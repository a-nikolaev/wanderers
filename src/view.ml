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
open SDLGL
open Glcaml

open Base
open Common
open Global
open Grafx

(* Tileset positions *)
module Pos = struct
  let font = (0,0)  (* small *)
  let atlas = (0,8) (* small *)

  let u_hum = (0,12)
  let u_mon = (0,16)

  let bg = (10,0)

  let objs = (16,0)

  let items = (25,16)

  let ui_dyn = (0,26)
  let ui_stat = (0,31)
  let ui_stat_sml = 2 %% ui_stat
end


(* inventory coordinates *)
let inv_coords = (10,16)
let inv_coords_sml = 2 %% inv_coords

let faction_color fac =
  let x = float (fac mod 5) /. 4.0 in
  let y = float (fac mod 3) /. 2.0 in
  let red = (0.5 +. 0.5*.(1.0-.y)) in
  let green = 0.6 in
  let blue = (0.3 +. 0.7*.x) in
  (red, green, blue)

let species_img = function
    Species.Hum, i -> Pos.u_hum ++ (2 + i, 0)
  | Species.Cow, _ -> Pos.u_mon ++ (0, 0)
  | Species.Horse, _ -> Pos.u_mon ++ (1, 0)
  | Species.Wolf, _ -> Pos.u_mon ++ (0, 3)
  | Species.Bear, _ -> Pos.u_mon ++ (1, 3)
  | Species.Troll, _ -> Pos.u_mon ++ (2, 3)
  | Species.Skeleton, x -> Pos.u_mon ++ (0+x, 1) 
  | Species.SkeletonWar, _ -> Pos.u_mon ++ (2, 1) 
  | Species.Zombie, x -> Pos.u_mon ++ (0+x, 2) 
  | Species.ZombieHulk, _ -> Pos.u_mon ++ (2, 2) 
  | Species.Slime, x -> Pos.u_mon ++ (0+x, 5)

(* switch texture *)
let switch_to_text () = 
  glEnd();
  glBindTexture gl_texture_2d texture.(0);
  glBegin gl_quads

let switch_to_tile () = 
  glEnd();
  glBindTexture gl_texture_2d texture.(0);
  glBegin gl_quads

(* choose color *)
let set_color r g b a = glColor4f r g b a

let draw_gl_scene draw_func =
  glClear  (gl_color_buffer_bit (*lor gl_depth_buffer_bit*)) ;		 (* Clear The Screen And The Depth Buffer *)
  glLoadIdentity  () ;				 (* Reset The View*)
  glTranslatef 0.0 0.0 0.0 ;
  set_color 1.0 1.0 1.0 1.0; 
  glBindTexture gl_texture_2d texture.(0);
  glBegin gl_quads;		                
 
  draw_func();

  set_color 1.0 1.0 1.0 1.0; 
  glEnd();
  swap_buffers ()

let biome_img b = 
  Pos.atlas ++ 
  match b with
  | RM.SnowMnt -> (0, 1)
  | RM.Mnt -> (1, 1)
  | RM.Plains -> (2, 1)
  | RM.Swamp -> (3, 1)
  | RM.Forest -> (4, 1)
  | RM.DeepForest -> (5, 1) 
  | RM.ForestMnt -> (6, 1)
  | RM.Dungeon -> (7, 1)
  | RM.Cave -> (7, 1)
  | _ -> (0, 0)

let output_characteristics core ((i,j) as ij) =
  Draw.draw_sml_tile_wh 4 4 (Pos.ui_stat_sml ++ (6, 0)) Draw.gr_sml_ui (ij -- (0,3));
  Draw.put_string (Printf.sprintf "%.0f" (Unit.Core.get_athletic core)) Draw.gr_sml_ui (i+5,j);
  Draw.put_string (Printf.sprintf "%.1f" (Unit.Core.get_reaction core)) Draw.gr_sml_ui (i+5,j-1);
  Draw.put_string (Printf.sprintf "%.0f" (Unit.Core.get_own_mass core)) Draw.gr_sml_ui (i+5,j-2);
  Draw.put_string (Printf.sprintf "%.2f" (Unit.Core.get_magic_aff core)) Draw.gr_sml_ui (i+5,j-3)

let output_hp core ((i,j) as ij) =
  Draw.draw_sml_tile_wh 4 1 (Pos.ui_stat_sml ++ (6, 4)) Draw.gr_sml_ui ij;
  Draw.put_string (Printf.sprintf "%.0f" (Unit.Core.get_hp core)) Draw.gr_sml_ui (i+5,j)

let output_eng core ((i,j) as ij) =
  Draw.draw_sml_tile_wh 4 1 (Pos.ui_stat_sml ++ (6, 5)) Draw.gr_sml_ui ij;
  Draw.put_string (Printf.sprintf "%.0f/%.0f" (Unit.Core.get_eng core) (Unit.Core.get_max_eng core)) Draw.gr_sml_ui (i+5,j)

let output_melee melee ((i,j) as ij) =
  Draw.draw_sml_tile_wh 4 2 (Pos.ui_stat_sml ++ (0, 0)) Draw.gr_sml_ui (ij -- (0,1));
  let x = (melee.Item.Melee.attrate) (* *. (melee.Item.Melee.duration) *) in
  Draw.put_string (Printf.sprintf "%1.2g" x) Draw.gr_sml_ui (i+5,j);
  Draw.put_string (Printf.sprintf "%1.2g" (melee.Item.Melee.duration)) Draw.gr_sml_ui (i+5,j-1)

let output_ranged optranged ((i,j) as ij) =
  Draw.draw_sml_tile_wh 4 2 (Pos.ui_stat_sml ++ (0, 2)) Draw.gr_sml_ui (ij -- (0,1));
  match optranged with
    Some ranged -> 
      Draw.put_string (Printf.sprintf "%1.2g" (ranged.Item.Ranged.dmgmult)) Draw.gr_sml_ui (i+5,j);
      Draw.put_string (Printf.sprintf "%1.2g" (ranged.Item.Ranged.force)) Draw.gr_sml_ui (i+5,j-1)
  | None ->
      Draw.put_string "none" Draw.gr_sml_ui (i+5,j)

let output_defense defense ((i,j) as ij) =
  Draw.draw_sml_tile_wh 4 2 (Pos.ui_stat_sml ++ (0, 4)) Draw.gr_sml_ui (ij -- (0,1));
  Draw.put_string (Printf.sprintf "%1.2g" defense) Draw.gr_sml_ui (i+5,j)

let output_mobility core ((i,j) as ij) =
  Draw.draw_sml_tile_wh  4 2 (Pos.ui_stat_sml ++ (0, 6)) Draw.gr_sml_ui (ij -- (0,1));
  Draw.put_string (Printf.sprintf "%1.2g" (Unit.Core.get_fm core)) Draw.gr_sml_ui (i+5,j);
  Draw.put_string (Printf.sprintf "%.0f" (Unit.Core.get_total_mass core)) Draw.gr_sml_ui (i+5,j-1)

let output_object_desc obj ij = 
  (* output_object_description *)
  let mass = Item.get_mass obj in
  let defense = Item.get_defense obj in
  
  set_color 1.0 1.0 1.0 1.0; 
  ( match Item.get_ranged obj with
    | (Some _) as x -> output_ranged x (ij ++ (0,0))
    | _ -> 
        ( match Item.get_melee obj with
          | Some melee -> output_melee melee (ij ++ (0,0));
            if defense > 0.0 then output_defense defense (ij ++ (10, 0))
          | _ ->
            if defense > 0.0 then output_defense defense (ij ++ (0, 0));
        )
  );
  Draw.put_string Unit.(Printf.sprintf "Mass: %.2g" mass) Draw.gr_sml_ui (ij ++ (0, -3))

let draw_atlas atlas geo =
  let cur_z, cur_loc = atlas.Atlas.curloc in

  let maxr = 5 in
    
  let scrloc loc = loc -- cur_loc ++ (0,0) ++ (maxr, maxr) in

  let draw_rmp alpha_bg alpha_marks rmp =
    let z,loc = rmp.Atlas.rloc in
    if z = cur_z && loc_infnorm (loc -- cur_loc) < maxr then
    ( let img = 
        match rmp.Atlas.biome with
        | RM.Dungeon 
        | RM.Cave -> 
            let rid = rmp.Atlas.rid in
            let h dir = if G.get_nb geo rid dir = None then 0 else 1 in
            let dimg = 
              ( match h East, h North, h West, h South with
                | 1, 0, 0, 1 -> (0,0)  
                | 1, 0, 1, 1 -> (1,0)  
                | 0, 0, 1, 1 -> (2,0)

                | 1, 1, 0, 1 -> (0,1)  
                | 1, 1, 1, 1 -> (1,1)  
                | 0, 1, 1, 1 -> (2,1)  
                
                | 1, 1, 0, 0 -> (0,2)  
                | 1, 1, 1, 0 -> (1,2)  
                | 0, 1, 1, 0 -> (2,2)  
                
                | 1, 0, 0, 0 -> (3,0)  
                | 1, 0, 1, 0 -> (4,0)  
                | 0, 0, 1, 0 -> (5,0)  
                
                | 0, 0, 0, 1 -> (3,1)  
                | 0, 1, 0, 1 -> (4,1)  
                | 0, 1, 0, 0 -> (5,1)  
                
                | 0, 0, 0, 0 -> (3,2)  
                
                | _ -> (1,1)
              )
            in
            Pos.atlas ++ (0, 3) ++ dimg

        | _ ->
            biome_img rmp.Atlas.biome 
      in
      set_color 1.0 1.0 1.0 alpha_bg; 
      Draw.draw_sml_tile img Draw.gr_atlas (scrloc loc) ;
      List.iter 
        ( function
            Atlas.Occupied (fac, pop) ->
              let cr, cg, cb = faction_color fac in
              let x = float pop *. 0.07 in
              set_color (x*. cr) (x*. cg) (x*. cb) alpha_marks; 
              let img = Pos.atlas ++ (3, 0) in
              Draw.draw_sml_tile img Draw.gr_atlas (scrloc loc) 
          | Atlas.StairsUp ->
              set_color 1.0 1.0 1.0 (0.5*.alpha_marks); 
              let img = Pos.atlas ++ (4, 0) in
              Draw.draw_sml_tile img Draw.gr_atlas (scrloc loc) 
          | Atlas.StairsDown ->
              set_color 1.0 1.0 1.0 (0.5*.alpha_marks); 
              let img = Pos.atlas ++ (5, 0) in
              Draw.draw_sml_tile img Draw.gr_atlas (scrloc loc) 
        )
        rmp.Atlas.markls;
    )
  in

  Array.iter ( function 
    | Some rmp ->
        draw_rmp 0.5 0.8 rmp
    | _ -> ()
  ) atlas.Atlas.rmp;

  Atlas.iter_visible (fun rmp -> draw_rmp 1.0 1.0 rmp) atlas;

  (* mark current location *)
  set_color 0.9 1.0 0.2 1.0; 
  Draw.draw_sml_tile_wh 3 3 (Pos.atlas ++ (6,3)) Draw.gr_atlas (scrloc (cur_loc -- (1,1))) 

  

let i_see_all = false

let draw_cursor t gr ij = 
  Draw.draw_tile_ext (Pos.ui_dyn ++ (12, 0)) gr ij

let draw_target_cursor t gr ij = 
  Draw.draw_tile_ext (Pos.ui_dyn ++ (10, 0)) gr ij

let draw_item t obj amount gr ij =
  let x = obj.Item.imgindex in
  let img = Pos.items ++ (x mod 8, x / 8) in
  (
    match Item.get_mat obj with
      Some Item.DmSteel ->
        let tt = 0.0001 *. float t in
        let xr = 0.05 *. sin (tt) in
        let xg = 0.05 *. sin (tt +. 1.0) in
        let xb = 0.05 *. sin (tt +. 2.0) in
        set_color (0.78 -. xr) (0.78 +. xg) (0.86 +. xb) 1.0;
        Draw.draw_tile img gr ij;
        set_color 1.0 1.0 1.0 1.0
    | Some Item.RustySteel ->
        set_color (0.80) (0.70) (0.60) 1.0;
        Draw.draw_tile img gr ij;
        set_color 1.0 1.0 1.0 1.0
    | Some Item.Gold ->
        let pic = (log10 (float amount)) |> floor |> int_of_float |> (min 4) in
        Draw.draw_tile (img ++ (pic,0)) gr ij
    | _ ->
        Draw.draw_tile img gr ij
  )

let draw_bunch_text t bunch gr ij =
  let gr_text = Grafx.Grid.({gr with x0 = gr.x0*2; y0 = gr.y0*2; dx=gr.dx/2; dy=gr.dy/2}) in
  if bunch.Item.Cnt.amount > 0 then
  (
    Draw.put_string (string_of_int bunch.Item.Cnt.amount) gr_text (2 %% ij)
  )

let draw_bunch_no_text t bunch gr ij =
  draw_item t bunch.Item.Cnt.item bunch.Item.Cnt.amount gr ij

let draw_bunch t bunch gr ij =
  draw_item t bunch.Item.Cnt.item bunch.Item.Cnt.amount gr ij;
  match bunch.Item.Cnt.item.Item.stackable with 
  | Some _ -> draw_bunch_text t bunch gr ij
  | _ -> () 

let draw_container t (w,h) c gr (i,j) = 
  for ii=0 to w-1 do
    for jj=0 to h-1 do
      Draw.draw_tile (Pos.ui_stat ++ (9,0)) gr (i+ii,j+jj)
    done
  done;
  Item.M.iter (fun k bunch -> 
    draw_bunch t bunch gr (i + k mod w, j - k / w)
  ) c.Item.Cnt.bunch

let draw_container_auto_width t (w,h) c gr (i,j) =
  let w = match c.Item.Cnt.caplim with Some x -> x | _ -> w in
  draw_container t (w,h) c gr (i,j)

let draw_inventory t (w,h) inv gr (i,j)= 
  Item.M.iter (fun ci c -> 
    draw_container_auto_width t (w,h) c gr (i,j-h*ci)
  ) inv.Inv.cnt


let is_visible_well vision ij = Area.get vision ij > 0 || i_see_all 
let is_visible_somewhat area vision (px,py) = 
  let g (x,y) = (int_of_float x, int_of_float y) in
  List.exists (fun loc -> Area.is_within area loc && Area.get vision loc > 0 && 
      Tile.can_look(Tile.classify (Area.get area loc))) 
    [g(floor px, floor py); g(floor px, ceil py); g(ceil px, floor py); g(ceil px, ceil py);]


(* Projectiles *)
let draw_projectiles t reg vision =
  let ls = reg.R.obj.R.Obj.projls in

  List.iter 
    ( fun pj ->
        let dimg, dpos =
          match Proj.getdir pj with
          | Dir8.S -> (0,0), (0.25,0.5)
          | Dir8.N -> (1,1), (0.25,0.0)
          | Dir8.W -> (1,0), (0.5,0.25)
          | Dir8.E -> (0,1), (0.0,0.25)
          | Dir8.NE -> (2,1), (0.0,0.0)
          | Dir8.NW -> (3,1), (0.5,0.0)
          | Dir8.SE -> (2,0), (0.0,0.5)
          | Dir8.SW -> (3,0), (0.5,0.5)
        in
       
        let visible_well = is_visible_well vision (loc_of_vec pj.Proj.pos) in
        let visible_somewhat = is_visible_somewhat reg.R.a vision pj.Proj.pos in
        
        if visible_well || visible_somewhat then
        ( 
          let proj_type, colors = match pj.Proj.item.Proj.tp with 
            | Proj.Arrow -> (0, 0), (1.0, 1.0, 1.0, 1.0)
            | Proj.EngBolt -> (2, 0), (0.8, 0.3, 1.0, 0.6 *. (min 1.0 pj.Proj.item.Proj.dmgmult)) 
            | Proj.EngCharge -> (4, 0), (0.8, 0.3, 1.0, 0.6 *. (min 1.0 pj.Proj.item.Proj.dmgmult)) 
          in

          let red,green,blue,alpha = colors in
          if visible_well then
            set_color red green blue alpha
          else
            set_color (0.1+.0.2*.red) (0.1+.0.2*.green) (0.1+.0.2*.blue) (0.5 *. alpha);
          
          ( match pj.Proj.item.Proj.tp with
          | Proj.EngCharge ->
              let dimg =
                match Proj.getdir pj with
                | Dir8.E -> (0,0)
                | Dir8.N | Dir8.NW | Dir8.NE-> (1,0)
                | Dir8.W -> (2,0)
                | Dir8.S | Dir8.SW | Dir8.SE -> (3,0)
              in
              let img = (Pos.items ++ (4, 14)) in
              Draw.draw_tile_vec (img ++ dimg) Draw.gr_map pj.Proj.pos
          | _ -> 
              let img = 2 %% (Pos.items ++ (0, 13) ++ proj_type) in
              Draw.draw_sml_tile_vec (img ++ dimg) Draw.gr_map (pj.Proj.pos ++. dpos); 
              (* Draw.draw_bb_vec (9.0, 17.0) pj.Proj.pos; *) 
          )
        )
    ) ls

(* Stairs *)
let draw_stairs t reg vision (stt, loc) =
  let visible_well = is_visible_well vision loc in
  let was_explored = match Area.get reg.R.explored loc with None -> false | _ -> true in

  if visible_well || was_explored then
  ( let red,green,blue = 1.0, 1.0, 1.0 in
    if visible_well then
      set_color red green blue 1.0
    else
      set_color (0.3+.0.2*.red) (0.3+.0.2*.green) (0.3+.0.2*.blue) 1.0;

    let img = 
      Pos.objs ++ 
      match stt with 
      | R.Obj.StairsUp -> (0,1)
      | R.Obj.StairsDown -> (1,1) in

    Draw.draw_tile_high img Draw.gr_map loc
  )

(* Movable objects (including Magic) *)  
let draw_movls t reg u vision =
  let ls = reg.R.obj.R.Obj.movls in

  let magic_aff = Unit.get_magic_aff u in

  let min_visible_pow = 5.0 *. (1.0 -. magic_aff) in

  List.iter 
    ( function 
      | R.Obj.Magical obj ->
          let loc, vec, pow, time = match obj with
            R.Obj.Spark (loc, vec, pow, time) -> (loc, vec, pow, time)
          in

          let visible_well = is_visible_well vision loc in
          let visible_somewhat = is_visible_somewhat reg.R.a vision vec in
          
          if (visible_well || visible_somewhat) && pow > min_visible_pow then
          ( let red,green,blue = 0.8, 0.3, 1.0 in

            let brightness = min ((pow -. min_visible_pow) *. magic_aff) 0.6 in
            
            let red, green, blue, alpha =
              if visible_well then
                (red, green, blue, 1.0 *. brightness)
              else
                (0.1+.0.7*.red, 0.1+.0.7*.green, 0.1+.0.7*.blue, 0.3 *. brightness)
            in
            
            (* animation frame *)
            let duration = 4.0 in
            let frames_num = 5.0 in
            let frame = 
              let frac = (time /. duration) in
              (frac *. frames_num) |> floor |> int_of_float
            in

            let opt_img =
              if pow > 0.0 then 
                Some (Pos.ui_dyn ++ (4 + frame, 2))
              else
                None
            in  
            ( match opt_img with
              | Some img -> 
                  
                  set_color red green blue (0.2*.alpha);
                  Draw.draw_tile_high_vec (img ++ (0,2)) Draw.gr_map vec;
                  
                  set_color red green blue alpha;
                  Draw.draw_tile_high_vec img Draw.gr_map vec

              | _ -> ()
            )
          )
    ) ls


(* Area one tile *)
let draw_area_tile_floor t reg rm vision (i,j) = 
  let visible, tile_opt =
    if Area.get vision (i,j) > 0 || i_see_all then true, Some (Area.get reg.R.a (i,j)) 
    else false, Area.get reg.R.explored (i,j) in

  match tile_opt with
  | Some tile -> 
      ( if visible then set_color 1.0 1.0 1.0 1.0 else set_color 0.7 0.7 0.7 0.7;
  
        let def_ground_img =
          Pos.bg ++
          match rm.RM.biome with
            | RM.Swamp -> (0, 1)
            | RM.Mnt | RM.ForestMnt -> (2, 0)
            | RM.SnowMnt -> (2, 1)
            | RM.Dungeon -> (4, 0)
            | RM.Cave -> (4, 1)
            | _ -> (0, 0)
        in
        let def_ground_img_alt = def_ground_img ++ (1, 0) in

        let d_ground_img = match tile with Tile.IcyGround | Tile.SwampyPool -> (0, 1) | _ -> (0, 0) in
        Draw.draw_tile ((if (i+j) mod 2 = 1 then def_ground_img else def_ground_img_alt) ++ d_ground_img) Draw.gr_map (i,j);
        
        let draw_obj dimg = Draw.draw_tile_high (Pos.objs ++ dimg) Draw.gr_map (i,j) in
        ( match tile with
          | Tile.WoodenFloor -> draw_obj (6,9) 
          | Tile.Door _ -> draw_obj (6,9)
          | _ -> () );
        
        (* draw items *)
        if visible then
        ( match Area.get reg.R.optinv (i,j) with
          | Some inv -> 
              for k = 0 to 2 do
                match Inv.examine 0 k inv with
                  Some bunch -> draw_bunch_no_text t bunch Draw.gr_map (i,j)
                | None -> ()
              done
          | None -> ()
        )
      )
  | None -> ()


let door_is_east_west a (i,j) =
  let g loc = if not (Area.is_within a loc) || Area.get a loc |> Tile.classify |> Tile.can_walk then 1 else 0 in
  g (i-1,j) + g (i+1,j) >= g (i,j-1) + g (i, j+1) 

(* Area one tile *)
let draw_area_tile_obstacles t reg rm vision (i,j) = 
  let visible, tile_opt =
    if Area.get vision (i,j) > 0 || i_see_all then true, Some (Area.get reg.R.a (i,j)) 
    else false, Area.get reg.R.explored (i,j) in

  match tile_opt with
  | Some tile -> 
      ( if visible then set_color 1.0 1.0 1.0 1.0 else set_color 0.7 0.7 0.7 1.0;
  
        let draw_obj dimg = Draw.draw_tile_high (Pos.objs ++ dimg) Draw.gr_map (i,j) in
        
        let draw_door ds img =
          let east_west = door_is_east_west reg.R.a (i,j) in
          match ds with 
          | Tile.IsClosed -> 
              let d_east_west = if east_west then (2,0) else (0,0) in
              draw_obj (img ++ d_east_west ++ (-1,0)) 
          | Tile.IsOpen ->
            if east_west then
            ( draw_obj (img ++ (2,0));
              Draw.draw_tile_high (Pos.objs ++ img ++ (3,0)) Draw.gr_map (i+1,j) )
            else 
              draw_obj img 
        in
        ( match tile with
            Tile.Wall -> draw_obj (0,9)
          | Tile.Door ds -> draw_door ds (2,9)
          | Tile.DungeonDoor ds -> draw_door ds (2,7) 
          | Tile.CaveDoor ds -> draw_door ds (2,11) 
          | Tile.Tree1 -> draw_obj (0,3)
          | Tile.Tree2 -> draw_obj (if rm.RM.biome <> RM.SnowMnt then (1,3) else (1,5))
          | Tile.Rock1 -> draw_obj (if rm.RM.biome <> RM.SnowMnt then (2,3) else (2,5))
          | Tile.Rock2 -> draw_obj (if rm.RM.biome <> RM.SnowMnt then (3,3) else (3,5))
          | Tile.DungeonWall -> draw_obj (0,7) 
          | Tile.CaveWall -> draw_obj (0,11) 
          | _ -> () );
      )
  | None -> ()


(* Notification *)
let draw_ntfy time u = 
  List.iter (fun (ev,t) -> 
    match ev with
    | Unit.NtfyDamage x -> 
      ( let crit = 
          let hp = Unit.get_hp u in
          if hp > 0.0 then 
            max (min (x /. hp) 1.0) 0.0
          else
            1.0 in
        let z1 = 0.4 +. 0.4 *. crit in
        let z2 = 0.3 +. 0.7 *. crit in
        set_color z1 (0.8 -. z1) (0.8 -. z1) ((1.0 -. t /. 4.0) +. z2); 
        Draw.put_string_vec Unit.(Printf.sprintf "%i" (round x)) Draw.gr_map (u.Unit.pos ++. (0.5*.(crit +. 0.1) *. sin(t), t*.0.4)) 
      )
    | Unit.NtfyStunned -> 
        set_color 0.4 0.4 1.0 0.6; 
        Draw.put_string_vec "%" Draw.gr_map (u.Unit.pos ++. (0.5*.(0.0 +. 0.1) *. sin(t), t*.0.4)) 
  ) u.Unit.ntfy


let draw_unit t s reg eval_unit_strength u_controlled_strength u =
  let visible_well = is_visible_well s.State.vision u.Unit.loc in
  let visible_somewhat = is_visible_somewhat reg.R.a s.State.vision u.Unit.pos in
  if visible_well || visible_somewhat then
  (

    if (Unit.get_controller u <> Some s.State.controller_id) then
    ( 
      let red, green, blue = faction_color (Unit.get_faction u) in
      if visible_well then
        set_color red green blue 1.0
      else
        set_color (0.1+.0.2*.red) (0.1+.0.2*.green) (0.1+.0.2*.blue) 0.5;

      let species = Unit.get_sp u in 
      let img = species_img (species) ++ 
        ( match species, Unit.get_gender u with
          | (Species.Hum, _), Some Unit.Core.Female -> (0, 1)
          | _ -> (0, 0)
        ) in

      Draw.draw_tile_vec img Draw.gr_map (u.Unit.pos); 
    
      (* actors badge *)
      ( match u.Unit.optaid with 
          Some _ ->
            Draw.draw_tile_vec (Pos.ui_dyn ++ (0, 1)) Draw.gr_map (u.Unit.pos); 
        | _ -> ()
      );

      (* danger bars *)
      if visible_well then
      ( let u_strength = eval_unit_strength u in
        let ratio = u_strength /. u_controlled_strength in
        
        set_color 1.0 1.0 1.0 0.7;
       
        let opt_img =
          if ratio > 8.0 then 
            Some (Pos.ui_dyn ++ (2, 0))
          else if ratio > 1.0 then 
            Some (Pos.ui_dyn ++ (1, 0))
          else if ratio > 0.125 then 
            Some (Pos.ui_dyn ++ (0, 0))
          else
            None
        in  
        ( match opt_img with
          | Some img -> Draw.draw_tile_vec img Draw.gr_map (u.Unit.pos)
          | _ -> ()
        )
      );
      
      (*
      match Unit.cur_dest_loc u with
        Some loc -> 
          set_color 1.0 0.0 0.0 0.4; 
          Draw.draw_tile (3, 6) Draw.gr_map loc
      | None -> ()
      *)
    )
    else
    ( (* human-controlled unit *) 
      set_color 1.0 1.0 1.0 1.0; 
      let img = Pos.u_hum ++ 
        ( match Unit.get_sp u, Unit.get_gender u with
          | (Species.Hum, _), Some Unit.Core.Female -> (0, 1)
          | _ -> (0, 0)
        ) in
      if s.State.debug then
        Draw.draw_tile (10, 17) Draw.gr_map (u.Unit.loc);
      Draw.draw_tile_vec img Draw.gr_map (u.Unit.pos);
   
      (* Player's Stats *)
      let char_ij = (50, 32) in
      output_characteristics (Unit.get_core u) (char_ij ++ (0,0));
      output_hp (Unit.get_core u) (char_ij ++ (0,-5));
      output_eng (Unit.get_core u) (char_ij ++ (0,-6));
      output_mobility (Unit.get_core u) (char_ij ++ (0,-7));
      output_melee (Unit.get_melee u) (char_ij ++ (0,-10));
      output_ranged (Unit.get_ranged u) (char_ij ++ (0,-13));
      output_defense (Unit.get_defense u) (char_ij ++ (0, -16));

      let fnctq = Fencing.get_tq u.Unit.fnctqn in
      Draw.put_string Unit.(Printf.sprintf "%s" (fnctq.Fencing.name)) Draw.gr_sml_ui (40,0);

      (* simplified *)
      set_color 0.34 0.34 0.34 1.0;
      Draw.put_string "Equipment:" Draw.gr_sml_ui (inv_coords_sml ++ (-13,0));
      set_color 1.0 1.0 1.0 1.0;
      let inv = Unit.get_inv u in
      let w,h = 12,1 in
      Item.M.iter (fun ci c -> 
        if ci = 0 then
          draw_container_auto_width t (w,h) c Draw.gr_ui (inv_coords ++ (0,-h*ci))
      ) inv.Inv.cnt
      
    );
  );

  (* attack animation *)
  match u.Unit.ac with
    (Timed (_,tp,te, Attack (tq, dir_index)))::_ -> 
        let tgtls, stage = Fencing.get_tgtls_and_stage 0.0 tp te tq dir_index in

        (*
        let j = floor (5.0 *. (tp /. te) ) in
        let j_alt = floor (5.0 *. stage ) in
        *)
        let j_x = int_of_float (floor (5.0 *. (0.5*. stage +. 0.5 *. tp/.te) )) in
      
        List.iter (fun tgt ->
          set_color 1.0 0.7 0.6 (0.1 +. 0.3 *. tgt.Fencing.magnitude); 
          let loc' = u.Unit.loc ++ tgt.Fencing.dloc in
          if Area.is_within s.State.vision loc' && Area.get s.State.vision (loc') > 0 then
          ( (* Draw.draw_bb (4.0 +. j, 6.0) (loc');*)
            Draw.draw_tile (Pos.ui_dyn ++ (4,0) ++ (j_x,0)) Draw.gr_map (loc') )
        ) tgtls
  | _ -> ()


let draw_state t s = 
  set_color 1.0 1.0 1.0 1.0;
  let reg = G.curr s.State.geo in
  let cur_rm = s.State.geo.G.rm.(s.State.geo.G.currid) in

  let area_w = Area.w reg.R.a in
  let area_h = Area.h reg.R.a in

  (* units array *)
  let unit_ls_arr = Array.make_matrix area_w area_h [] in 
  E.iter ( fun u ->
    let (i,j) = u.Unit.loc in
    unit_ls_arr.(i).(j) <- u :: unit_ls_arr.(i).(j) 
  ) reg.R.e;

  (* stairs array *)
  let stairs_arr = Array.make_matrix area_w area_h None in
  List.iter ( fun (stt, (i,j)) -> 
    stairs_arr.(i).(j) <- Some stt
  ) reg.R.obj.R.Obj.stairsls;

  (*
  draw_area t reg cur_rm s.State.vision;

  (* draw stairs *)
  set_color 1.0 1.0 1.0 1.0; 
  draw_stairs t reg s.State.vision;
  *)

  (* units *)
  set_color 0.5 0.6 0.3 1.0; 
  let u_controlled = 
    E.fold (fun acc u -> 
      if (Unit.get_controller u = Some s.State.controller_id) then Some u else acc 
      ) None reg.R.e
  in
  let eval_unit_strength u = Unit.Core.approx_strength (Unit.get_core u) in
  let u_controlled_strength = match u_controlled with 
    | Some u -> eval_unit_strength u
    | None -> infinity 
  in

  for j = area_h-1 downto 0 do
    
    (* floor, items, and stairs *)
    for i = 0 to area_w-1 do
      let ij = (i,j) in

      (* tile *)
      draw_area_tile_floor t reg cur_rm s.State.vision ij;
    
      (* stairs floor *)
      ( match stairs_arr.(i).(j) with
        | Some stt -> draw_stairs t reg s.State.vision (stt, ij) 
        | None -> ()
      );
    done;

    (* units *)
    let draw_units_at i jj =
      List.iter ( fun u ->
          draw_unit t s reg eval_unit_strength u_controlled_strength u 
        ) unit_ls_arr.(i).(jj)
    in
    for i = 0 to area_w-1 do
      if j < area_h-1 then ( draw_units_at i (j+1) );
      if j = 0 then draw_units_at i j;
    done;

    for i = 0 to area_w-1 do
      (* tile obstacles *)
      draw_area_tile_obstacles t reg cur_rm s.State.vision (i,j);
    done;
  done;
  
  (* mist *)
  (
    let mist_img = (15,9) in
    let known loc = Area.is_within reg.R.a loc && match Area.get reg.R.explored loc with Some _ -> true | _ -> false in
    
    let rnd (i,j) = cur_rm.RM.seed + + (i * 40591) lxor (j * 3571) in
    let timed_rnd (i,j) = ((t+rnd(i,j))/700) + rnd (i,j) in
   
    (* base color *)
    let r, g, b = 
      match cur_rm.RM.biome with
      | RM.Dungeon | RM.Cave -> 0.74, 0.80, 0.80 
      | _ -> 0.86, 0.84, 0.80
    in
       
    let mist_fill_all = false in

    let on_the_edge (i,j) =
      not (known (i,j)) && ( mist_fill_all || 
        List.exists known 
          [(i+1,j); (i,j+1); (i-1,j); (i,j-1); 
           (* (i+1,j+1); (i+1,j-1); (i-1,j+1); (i-1,j-1) *)]
      )
    in

    for j = area_h-1 downto 0 do
      for i = 0 to area_w-1 do
        let nb = [(i+1,j); (i,j+1); (i-1,j); (i,j-1)] in
        
        if on_the_edge (i,j) then
        ( let img = Pos.objs ++ mist_img in 

          let phi_temporal =
            0.002 *. sin (float (t * (2000 + rnd (i,j) mod 1000) ) *. 0.000001) 
            +. 0.1 *. sin (float t *. 0.0002)
          in

          let alpha = 0.65 in

          set_color r g b (alpha +. phi_temporal);
          Draw.draw_tile img Draw.gr_map (i,j);
          
          set_color r g b (0.90 *. (alpha +. phi_temporal));
          let x = (timed_rnd(i,j) mod 1117) in
          if x < 6 then
          ( let dimg = (0, x+1) in
            Draw.draw_tile (img ++ dimg) Draw.gr_map (i,j);
          );
          List.iteri (fun v loc -> 
            if not (on_the_edge loc) then
              Draw.draw_tile (img++(v+1, (timed_rnd (i,j)) mod 6 )) Draw.gr_map loc
          ) nb
        )
        
      done
    done
  );

  (* notifications *)
  E.iter ( fun u ->
    let visible_well = is_visible_well s.State.vision u.Unit.loc in

    if visible_well then
    ( draw_ntfy t u )
  ) reg.R.e;

  (* draw projectiles *)
  set_color 1.0 1.0 1.0 1.0; 
  draw_projectiles t reg s.State.vision;
 
  (* movable objects *)
  (
    match u_controlled with
      Some u -> 
        draw_movls t reg u s.State.vision
    | None -> ()
  );
  
  set_color 1.0 1.0 1.0 1.0;
  if s.State.debug then
  (  (* draw auxiliary interface *)
    Draw.put_string Unit.(Printf.sprintf "top_rem_dt: %.0f" s.State.top_rem_dt) Draw.gr_sml_ui (10,-1);
  );
  Draw.put_string Unit.(Printf.sprintf "clock: %.0f" (State.Clock.get s.State.clock)) Draw.gr_sml_ui(25,0); 
  Draw.put_string Unit.(Printf.sprintf "speed[+-]:%+i" (s.State.opts.State.Options.game_speed)) Draw.gr_sml_ui (10,0); 
  Draw.put_string Unit.(Printf.sprintf "h: %i" (s.State.geo.G.loc.(R.get_rid reg) |> fst )) Draw.gr_sml_ui (50,0); 

  (* atlas *)
  draw_atlas s.State.atlas s.State.geo;

  if s.State.debug && false then
  ( (* factions images *)
    let output num pos =
      Draw.put_string Unit.(Printf.sprintf "%i" num) Draw.gr_sml_ui pos in
    let rm = s.State.geo.G.rm.(s.State.geo.G.currid) in
    Array.iteri (fun fac fac_prop -> 
        let sp = List.hd s.State.pol.Pol.prop.(fac).Pol.speciesls in
        let img = species_img sp in 
        let (r,g,b) = faction_color fac in
        set_color r g b 1.0; 
        Draw.draw_tile img Draw.gr_ui (26+fac,13);
       
        (* their population here *)
        output rm.RM.lat.Mov.fac.(fac) ((26+fac)*2+1,12*2+2);
        output rm.RM.alloc.Mov.fac.(fac) ((26+fac)*2+1,12*2+1)
      ) s.State.pol.Pol.prop;
  )
  else
  ( (* canary *)
    let rm = s.State.geo.G.rm.(s.State.geo.G.currid) in
    let b = fold_lim (fun acc i -> 
        acc ||
        ( s.State.pol.Pol.prop.(i).Pol.fsp = Undead && rm.RM.alloc.Mov.fac.(i) > 0 )
      ) false 0 (s.State.pol.Pol.facnum - 1) in
    set_color 1.0 1.0 1.0 1.0;
    let img = Pos.ui_stat ++ (6,0) ++ if b then (0,0) else (0,1) in
    let ij = (28,1) in
    Draw.draw_tile img Draw.gr_ui ij;
    Draw.draw_tile (img ++ (1,0)) Draw.gr_ui (ij ++ (1,0))
  );

  (* edges *)
  (*
  if G.Me.mem Down s.State.geo.G.nb.(s.State.geo.G.currid) then
  ( set_color 0.8 0.6 0.4 1.0; 
    Draw.put_string "Down" Draw.gr_sml_ui (0,33) );
  *)

  match s.State.cm with
  | State.CtrlM.Target _ -> 
      (* cursor *)
      set_color 1.0 1.0 1.0 1.0; 
      draw_target_cursor t Draw.gr_map (s.State.target_cursor)
  
  | State.CtrlM.Look _ -> 
      (* cursor *)
      set_color 1.0 1.0 1.0 1.0; 
      draw_cursor t Draw.gr_map (s.State.look_cursor)
       

  | State.CtrlM.Inventory (invclass,ic,ii,u,_) ->
 
      let shift_unit_inv i = (0,-i) in
      let shift_unit_inv_sml i = (0,-2*i) in
      let shift_ground_inv = (0,-5) in
      let shift_ground_inv_sml = (0,-2*5) in

      (* background *)
      (
        let w = 14 in
        let h = let _,y = shift_ground_inv in -y + 3 in
        let img_bg = Pos.ui_stat ++ (8, 0) in
        Draw.draw_tile_stretch_wh (w, h) 1 1 img_bg Draw.gr_ui (inv_coords -- (1,h-2))
      );

      let unit_inv = Unit.get_inv u in
      draw_inventory t (12,1) unit_inv Draw.gr_ui (inv_coords);
      (* Draw the ground inventory *)
      ( match Area.get reg.R.optinv u.Unit.loc with
          Some inv ->  
            draw_inventory t (12,1) inv Draw.gr_ui (inv_coords ++ shift_ground_inv)
        | _ -> () );
      
      (* find the object we are pointing at *)
      let optbunch = 
        let optinv = 
          match invclass with
          | State.CtrlM.InvGround -> Area.get reg.R.optinv u.Unit.loc 
          | _ -> Some u.Unit.core.Unit.Core.inv in
        match optinv with
          Some inv -> Inv.examine ic ii inv 
        | None -> None
      in
      ( match optbunch with
          Some bunch ->
            output_object_desc bunch.Item.Cnt.item (inv_coords_sml ++ (0, -4))
            
        | None -> ()
      );

      (* Add labels *)
      set_color 0.34 0.34 0.34 1.0;
      Draw.put_string "0." Draw.gr_sml_ui (inv_coords_sml ++ shift_ground_inv_sml -- (2,0)); 
      
      Item.M.iter (fun i c -> 
        Draw.put_string (string_of_int (i+1) ^ ".") Draw.gr_sml_ui 
          (inv_coords_sml ++ shift_unit_inv_sml i -- (2,0))
      ) unit_inv.Inv.cnt;
      
      (* inventory cursor *)
      set_color 1.0 1.0 1.0 1.0; 
      let shift = match invclass with State.CtrlM.InvGround -> shift_ground_inv | _ -> shift_unit_inv ic in
      draw_cursor 0 Draw.gr_ui (inv_coords ++ shift ++ (ii,0))
  | State.CtrlM.Normal | State.CtrlM.WaitInput _ -> ()
  | State.CtrlM.Died t ->
      set_color 0.35 0.35 0.35 (min 1.0 (0.02 *. t));
      Draw.put_string "press [Enter] to restart" Draw.gr_sml_ui (15, 32)

