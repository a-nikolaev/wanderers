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

let process_key_pressed k = function
    State.Play s ->
      let g m = State.Play (State.respond s m) in
      let ctrl = List.mem KMOD_LCTRL k.modifiers in
      let shift = List.mem KMOD_LSHIFT k.modifiers || List.mem KMOD_RSHIFT k.modifiers in
      State.
      ( match k.sym, k.keystate with
        | K_Q, PRESSED when ctrl -> State.Exit
        | K_LEFT, PRESSED -> if ctrl then g (Msg.Attack 2) else g Msg.Left
        | K_RIGHT, PRESSED -> if ctrl then g (Msg.Attack 0) else g Msg.Right
        | K_UP, PRESSED -> if ctrl then g (Msg.Attack 1) else g Msg.Up
        | K_DOWN, PRESSED -> if ctrl then g (Msg.Attack 3) else g Msg.Down
        | K_ESCAPE, PRESSED -> g Msg.Cancel
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
              | '<' -> g Msg.UpStairs
              | '>' -> g Msg.DownStairs
              | ',' -> g Msg.ScrollBackward
              | '.' -> g Msg.ScrollForward
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
          |  State.Play s -> draw_state ticks s
          | _ -> () );
        (* FPS *)
        let fps = 1000.0 /. float (ticks - prev_ticks) in
        glColor4f 1.0 1.0 1.0 1.0; 
        Grafx.Draw.put_string (sprintf "FPS: %.0f" fps) (0,0);
    );
  let mode_state' = match mode_state with
  | State.Play s ->
      State.Play (Sim.run ( 0.0105 *. float (ticks - prev_ticks)) s) 
  | ms -> ms
  in

  delay(5);

  if mode_state' <> State.Exit then
  ( match poll_event () with
    | Key k -> 
        main_loop (process_key_pressed k mode_state') ticks
    | Quit -> main_loop State.Exit ticks
    | _ -> main_loop mode_state' ticks
  )

let main () =
  Random.self_init();

	init [VIDEO];
	let w = 1100 and h = 550	and bpp = 32 in
  let _ = set_video_mode w h bpp [OPENGL; DOUBLEBUF] in
  (* enable_key_repeat default_repeat_delay default_repeat_interval; *)
  (* enable_key_repeat 10 10; *)
  enable_key_repeat 100 27;
  ignore (enable_unicode ENABLE);

	set_caption "Wanderers" "Wanderers";
	Grafx.init_gl w h;
 
  let b_debug = Array.length Sys.argv > 1 in

  let state0 = State.Play (State.initial 25 16 b_debug) in 

  main_loop state0 (Timer.get_ticks());

  quit ()	

let test_fake_fight () =
  Random.self_init();
  let facnum = 1 in
  let pol = Politics.make_variety facnum in
  let rm = Genmap.simple_rm 0 Common.RM.Plains facnum 0.0 in
  let res = Base.Resource.make 1000 in
  let rm = Common.({rm with RM.lat = {rm.RM.lat with Mov.res = res}}) in

  let oc1 = Org.random_unit_core pol rm in
  let oc2 = Org.random_unit_core pol rm in

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
  let len = 16 in
  let c = Org.Bwc.make len in
  let c = Org.Bwc.add 4 1.0 c in
  let c = Org.Bwc.add 5 1.0 c in
  let c = Org.Bwc.add 11 1.0 c in
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
  repeat 0.0 0.1 3.2

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


