(*           Wanderers - open world adventure game.
            Copyright (C) 2013-2014  Alexey Nikolaev.

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see <http://www.gnu.org/licenses/>. *)

open Sdl
open Video
open Window
open Timer
open Event
(*
open SDLGL
open Draw *)
open Glcaml

open View

open Printf

let finalize s =
  State.save_to_file s "game.save"

let process_key_pressed k = function
    State.Play s ->
      let g m = State.Play (State.respond s m) in
      let ctrl = List.mem KMOD_LCTRL k.modifiers in
      (* let shift = List.mem KMOD_LSHIFT k.modifiers || List.mem KMOD_RSHIFT k.modifiers in *)
      State.
      ( match k.sym, k.keystate with
        | K_Q, PRESSED when ctrl -> finalize s; State.Exit
        | K_LEFT, PRESSED -> if ctrl then g (Msg.Attack 2) else g Msg.Left
        | K_RIGHT, PRESSED -> if ctrl then g (Msg.Attack 0) else g Msg.Right
        | K_UP, PRESSED -> if ctrl then g (Msg.Attack 1) else g Msg.Up
        | K_DOWN, PRESSED -> if ctrl then g (Msg.Attack 3) else g Msg.Down
        | K_ESCAPE, PRESSED -> g Msg.Cancel
        | K_RETURN, PRESSED -> g Msg.Confirm
        | _, PRESSED -> 
          ( if (k.unicode land 0xFF80) = 0 then
            ( let x = k.unicode land 0x7F in
              let v = if ctrl then x + 0x60 else x in
              let ch = Char.chr v in
              
              match ch with 
              | 'h' -> if ctrl then g (Msg.Attack 2) else g Msg.Left
              | 'l' -> if ctrl then g (Msg.Attack 0) else g Msg.Right
              | 'k' -> if ctrl then g (Msg.Attack 1) else g Msg.Up
              | 'j' -> if ctrl then g (Msg.Attack 3) else g Msg.Down
              | 'a' -> g (Msg.Attack 2)
              | 'd' -> g (Msg.Attack 0)
              | 'w' -> g (Msg.Attack 1) 
              | 's' -> g (Msg.Attack 3)
              | ' ' -> g Msg.Wait
              | 't' -> g Msg.Rest
              | 'i' -> g Msg.OpenInventory
              | 'q' when ctrl-> State.Exit
              | 'q' -> g Msg.Cancel
              | '0' -> g (Msg.Num 0)
              | '1' -> g (Msg.Num 1)
              | '2' -> g (Msg.Num 2)
              | 'f' -> g Msg.Fire
              | 'v' -> g Msg.Look
              | '<' -> g Msg.UpStairs
              | '>' -> g Msg.DownStairs
              (*
              | ',' -> g Msg.ScrollBackward
              | '.' -> g Msg.ScrollForward
              *)
              | '+' -> g Msg.OptsSpeedup
              | '-' -> g Msg.OptsSlowdown
              | _ -> State.Play s
            )
            else
              State.Play s
          )
        | _ -> State.Play s
      )
  | x -> x

let rec main_loop mode_state prev_ticks =
  let ticks = Timer.get_ticks () in
  draw_gl_scene 
    ( fun () -> 
        ( match mode_state with
          |  State.Play s -> 
              draw_state ticks s;
              (* FPS *)
              if s.State.debug then
              ( let fps = 1000.0 /. float (ticks - prev_ticks) in
                glColor4f 1.0 1.0 1.0 1.0; 
                Grafx.Draw.put_string (sprintf "FPS: %.0f" fps) Grafx.Draw.gr_ui (0,0); )
          | _ -> () );
    );
  let mode_state' = match mode_state with
  | State.Play s ->
      let speed = s.State.opts.State.Options.game_speed in
      let speedup = 1.07 ** float speed in
      State.Play (Sim.run ( 0.011 *. float (ticks - prev_ticks) *. speedup) s) 
  | ms -> ms
  in

  delay(5);

  if mode_state' <> State.Exit then
  ( match poll_event () with
    | Key k -> 
        main_loop (process_key_pressed k mode_state') ticks
    | Quit -> 
        (* on exit *)
        ( match mode_state' with
          | State.Play s -> finalize s
          | _ -> ()
        );
        main_loop State.Exit ticks
    | _ -> main_loop mode_state' ticks
  )

let main () =
  Random.self_init();

	init [VIDEO];
	let w = 854 / 2 * Grafx.Draw.zi and h = 480 / 2 * Grafx.Draw.zi and bpp = 32 in
  let _ = set_video_mode w h bpp [OPENGL; DOUBLEBUF] in
  (* enable_key_repeat default_repeat_delay default_repeat_interval; *)
  (* enable_key_repeat 10 10; *)
  enable_key_repeat 100 27;
  ignore (enable_unicode ENABLE);

	set_caption "Wanderers" "Wanderers";
	Grafx.init_gl w h;
 
  (* let b_debug = Array.length Sys.argv > 1 in *)  
  let b_debug = false in

  let state0 = 
    (* generate a new map? *)
    let opt_seed =
      
      let max_seed = 2147483647 in

      let rnd_seed_string () =
        let len = 1 + Random.int 6 in
        let s = String.make len 'a' in
        for i = 0 to len-1 do 
          let c = Char.chr (Char.code 'a' + Random.int 26) in 
          (* Going to use String.set until version 4.02 is everywhere and we can move on to String.init *)
          s.[i] <- c
        done;
        Printf.printf "Random seed: %s\n%!" s;
        s
      in

      let hash_string s =
        Base.fold_lim (fun a i -> (a*256 + Char.code s.[i]) mod (max_seed/512)) 0 0 (String.length s - 1) 
      in

      if Array.length Sys.argv > 1 then
        let s_prelim = Sys.argv.(1) in
        let s = if s_prelim = "?" then rnd_seed_string () else s_prelim in
        let seed = hash_string s in
        Some seed
      else
      ( if Sys.file_exists "game.save" then 
          None
        else
          Some ( () |> rnd_seed_string |> hash_string )
      )        
    in
    let s = 
      match opt_seed with
        Some seed ->
          Random.init seed;
          State.initial 25 16 b_debug
      | _ ->
          State.load_from_file "game.save"
    in
    State.Play s
  in

  (*
  let state0 = State.Play (State.initial 25 16 b_debug) in 
  *)

  main_loop state0 (Timer.get_ticks());

  quit ()	

let test_fake_fight () =
  Random.self_init();
  let facnum = 1 in
  let pol = Politics.make_variety facnum in
  let rm = Genmap.simple_rm 0 Common.RM.Plains facnum 0.0 in
  let res = Base.Resource.make 1000 in
  let rm = Common.({rm with RM.lat = {rm.RM.lat with Mov.res = res}}) in

  let oc1 = Org.get_random_unit_core pol rm in
  let oc2 = Org.get_random_unit_core pol rm in

  let print = Common.Unit.Core.print in 

  match oc1, oc2 with 
  | Some (c1, _), Some (c2, _) -> 
      print c1;
      print c2;
      
      let c1', c2' = Org.fake_fight c1 c2 in
      
      print c1';
      print c2';
      ()
  | _ -> () 

let test_bwc () =
  let len = 15 in
  let c = Org.Bwc.make len in
  let c = Org.Bwc.add 0 1.0 c in
  let c = Org.Bwc.add 4 1.0 c in
  let c = Org.Bwc.add 5 1.0 c in
  let c = Org.Bwc.add 10 1.0 c in
  for i = 0 to len-1 do
    printf "%i\t %g\t %g \n" i c.Org.Bwc.cur.(i) c.Org.Bwc.sum.(i)
  done;
  let rec repeat x dx xmax =
    if x < xmax then
    ( let i = Org.Bwc.binary_search c x in
      printf "%g -> %i\n" x i;
      repeat (x+.dx) dx xmax
    )
  in
  repeat 0.0 0.1 4.2

let _ = 
  try
    (*
	  test_fake_fight ()
    *)
   
    (*
    test_bwc ()
    *)
    
    main ()
    
	with
		SDL_failure m -> failwith m    


