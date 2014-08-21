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


(* inventory coordinates *)
let inv_coords = (8,20)
let inv_coords_sml = 2 %% inv_coords

let faction_color fac =
  let x = float (fac mod 5) /. 4.0 in
  let y = float (fac mod 3) /. 2.0 in
  let red = (0.5 +. 0.5*.(1.0-.y)) in
  let green = 0.6 in
  let blue = (0.3 +. 0.7*.x) in
  (red, green, blue)

let species_img = function
    Species.Hum, i -> (2 + i, 5)
  | Species.Cow, _ -> (9, 6)
  | Species.Horse, _ -> (10, 6)
  | Species.Wolf, _ -> (0, 7)
  | Species.Bear, _ -> (1, 7)
  | Species.Troll, _ -> (2, 7)
  | Species.Skeleton, _ -> (9, 5) 
  | Species.Zombie, _ -> (10, 5) 
  | Species.SkeletonWar, _ -> (11, 5) 
  | Species.ZombieHulk, _ -> (12, 5) 

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

let biome_img = function
  | RM.SnowMnt -> (9, 5)
  | RM.Mnt -> (10, 5)
  | RM.Plains -> (11, 5)
  | RM.Swamp -> (12, 5)
  | RM.Forest -> (13, 5)
  | RM.DeepForest -> (14, 5) 
  | RM.ForestMnt -> (15, 5)
  | RM.Dungeon -> (16, 5)
  | _ -> (8, 5)


let output_characteristics core ((i,j) as ij) =
  Draw.draw_sml_tile_wh 4 3 (6, 26) Draw.gr_sml_ui (ij -- (0,2));
  Draw.put_string (Printf.sprintf "%.0f" (Unit.Core.get_athletic core)) Draw.gr_sml_ui (i+5,j);
  Draw.put_string (Printf.sprintf "%.1f" (Unit.Core.get_reaction core)) Draw.gr_sml_ui (i+5,j-1);
  Draw.put_string (Printf.sprintf "%.0f" (Unit.Core.get_own_mass core)) Draw.gr_sml_ui (i+5,j-2)

let output_hp core ((i,j) as ij) =
  Draw.draw_sml_tile_wh 4 1 (6, 29) Draw.gr_sml_ui ij;
  Draw.put_string (Printf.sprintf "%.0f" (Unit.Core.get_hp core)) Draw.gr_sml_ui (i+5,j)

let output_melee melee ((i,j) as ij) =
  Draw.draw_sml_tile_wh 4 2 (0, 26) Draw.gr_sml_ui (ij -- (0,1));
  let x = (melee.Item.Melee.attrate) (* *. (melee.Item.Melee.duration) *) in
  Draw.put_string (Printf.sprintf "%1.2g" x) Draw.gr_sml_ui (i+5,j);
  Draw.put_string (Printf.sprintf "%1.2g" (melee.Item.Melee.duration)) Draw.gr_sml_ui (i+5,j-1)

let output_ranged optranged ((i,j) as ij) =
  Draw.draw_sml_tile_wh 4 2 (0, 28) Draw.gr_sml_ui (ij -- (0,1));
  match optranged with
    Some ranged -> 
      Draw.put_string (Printf.sprintf "%1.2g" (ranged.Item.Ranged.dmgmult)) Draw.gr_sml_ui (i+5,j);
      Draw.put_string (Printf.sprintf "%1.2g" (ranged.Item.Ranged.force)) Draw.gr_sml_ui (i+5,j-1)
  | None ->
      Draw.put_string "none" Draw.gr_sml_ui (i+5,j)

let output_defense defense ((i,j) as ij) =
  Draw.draw_sml_tile_wh 4 2 (0, 30) Draw.gr_sml_ui (ij -- (0,1));
  Draw.put_string (Printf.sprintf "%1.1g" defense) Draw.gr_sml_ui (i+5,j)

let output_mobility core ((i,j) as ij) =
  Draw.draw_sml_tile_wh  4 2 (0, 32) Draw.gr_sml_ui (ij -- (0,1));
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
        | RM.Dungeon -> 
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
            (16, 5) ++ (10, 2) ++ dimg

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
              let img = (8, 5) in
              Draw.draw_sml_tile img Draw.gr_atlas (scrloc loc) 
          | Atlas.StairsUp ->
              set_color 1.0 1.0 1.0 (0.5*.alpha_marks); 
              let img = (16, 6) in
              Draw.draw_sml_tile img Draw.gr_atlas (scrloc loc) 
          | Atlas.StairsDown ->
              set_color 1.0 1.0 1.0 (0.5*.alpha_marks); 
              let img = (17, 6) in
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
  Draw.draw_sml_tile (6,5) Draw.gr_atlas (scrloc cur_loc) 

  

let i_see_all = false

let draw_cursor t gr ij = 
  Draw.draw_sml_tile_wh_vec 4 4 (14, 14) gr ( vec_of_loc ij --. (0.5, 0.5) )

let draw_target_cursor t gr ij = 
  Draw.draw_sml_tile_wh_vec 4 4 (10, 14) gr ( vec_of_loc ij --. (0.5, 0.5) )

let draw_item t obj gr ij =
  let x = obj.Item.imgindex in
  let img = (9 + x mod 8, 9 + x / 8) in
  match Item.get_mat obj with
    Some Item.DmSteel ->
      set_color (0.78) (0.78) (0.86) 1.0;
      Draw.draw_tile img gr ij;
      set_color 1.0 1.0 1.0 1.0
  | Some Item.RustySteel ->
      set_color (0.80) (0.70) (0.60) 1.0;
      Draw.draw_tile img gr ij;
      set_color 1.0 1.0 1.0 1.0
  | _ ->
      Draw.draw_tile img gr ij

let draw_container t (w,h) c gr (i,j) = 
  for ii=0 to w-1 do
    for jj=0 to h-1 do
      Draw.draw_tile (9,8) gr (i+ii,j+jj)
    done
  done;
  Item.M.iter (fun k obj -> 
    draw_item t obj gr (i + k mod w, j - k / w)
  ) c.Item.Cnt.item

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
        ( let red,green,blue = 1.0, 1.0, 1.0 in
          if visible_well then
            set_color red green blue 1.0
          else
            set_color (0.1+.0.2*.red) (0.1+.0.2*.green) (0.1+.0.2*.blue) 0.5;

          let img = (18, 32) in
          Draw.draw_sml_tile_vec (img ++ dimg) Draw.gr_map (pj.Proj.pos ++. dpos); 

          (* Draw.draw_bb_vec (9.0, 17.0) pj.Proj.pos; *) 
        )
    ) ls

(* Stairs *)
let draw_stairs t reg vision =
  let ls = reg.R.obj.R.Obj.stairsls in
  List.iter ( fun (stt, loc) ->
    
    let visible_well = is_visible_well vision loc in
    let was_explored = match Area.get reg.R.explored loc with None -> false | _ -> true in

    if visible_well || was_explored then
    ( let red,green,blue = 1.0, 1.0, 1.0 in
      if visible_well then
        set_color red green blue 1.0
      else
        set_color (0.3+.0.2*.red) (0.3+.0.2*.green) (0.3+.0.2*.blue) 0.5;

      let img = match stt with 
        | R.Obj.StairsUp -> (6,3)
        | R.Obj.StairsDown -> (7,3) in

      Draw.draw_tile img Draw.gr_map loc
    )
  ) ls

(* Area *)
let draw_area t reg rm vision =
  let def_ground_img = 
    match rm.RM.biome with
      | RM.Swamp -> (9, 1)
      | RM.Mnt | RM.ForestMnt -> (11, 0)
      | RM.SnowMnt -> (* (6.0, 4.0) *) (11, 1)
      | RM.Dungeon -> (13, 0)
      | _ -> (9, 0)
  in
  let def_ground_img_alt = def_ground_img ++ (1, 0) in

  set_color 1.0 1.0 1.0 1.0; 
  for i = 0 to Area.w reg.R.a - 1 do
    for j = 0 to Area.h reg.R.a - 1 do

      let visible, tile_opt =
        if Area.get vision (i,j) > 0 || i_see_all then true, Some (Area.get reg.R.a (i,j)) 
        else false, Area.get reg.R.explored (i,j) in

      match tile_opt with
      | Some tile -> 
          ( if visible then set_color 1.0 1.0 1.0 1.0 else set_color 0.7 0.7 0.7 0.7;

            let d_ground_img = match tile with Tile.IcyGround | Tile.SwampyPool -> (0, 1) | _ -> (0, 0) in
            Draw.draw_tile ((if (i+j) mod 2 = 1 then def_ground_img else def_ground_img_alt) ++ d_ground_img) Draw.gr_map (i,j);
            ( match tile with
                Tile.Wall -> Draw.draw_tile (0,3) Draw.gr_map (i,j)
              | Tile.Tree1 -> Draw.draw_tile (2,3) Draw.gr_map (i,j)
              | Tile.Tree2 -> Draw.draw_tile (if rm.RM.biome <> RM.SnowMnt then (3,3) else (3,4)) Draw.gr_map (i,j)
              | Tile.Rock1 -> Draw.draw_tile (if rm.RM.biome <> RM.SnowMnt then (4,3) else (4,4)) Draw.gr_map (i,j)
              | Tile.Rock2 -> Draw.draw_tile (if rm.RM.biome <> RM.SnowMnt then (5,3) else (5,4)) Draw.gr_map (i,j)
              | Tile.WoodenFloor -> Draw.draw_tile (1,3) Draw.gr_map (i,j)
              | Tile.OpenDoor -> Draw.draw_tile (1,4) Draw.gr_map (i,j)
              | Tile.DungeonWall -> Draw.draw_tile (14,1) Draw.gr_map (i,j)
              | Tile.DungeonOpenDoor -> Draw.draw_tile (15,2) Draw.gr_map (i,j)
              | _ -> () );

            (* draw items *)
            if visible then
            ( match Area.get reg.R.optinv (i,j) with
              | Some inv -> 
                  for k = 0 to 2 do
                    match Inv.examine 0 k inv with
                      Some obj -> draw_item t obj Draw.gr_map (i,j)
                    | None -> ()
                  done
              | None -> ()
            )
          )
      | None -> ()
    done
  done

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
        Draw.put_string_vec Unit.(Printf.sprintf "%i" (round x)) Draw.gr_map (u.Unit.pos ++. (0.5*.(crit +. 0.1) *. sin(t), t*.0.4)) )
  ) u.Unit.ntfy

let draw_state t s = 
  set_color 1.0 1.0 1.0 1.0;
  let reg = G.curr s.State.geo in
  let cur_rm = s.State.geo.G.rm.(s.State.geo.G.currid) in
  draw_area t reg cur_rm s.State.vision;
  
  (* draw stairs *)
  set_color 1.0 1.0 1.0 1.0; 
  draw_stairs t reg s.State.vision;

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
  E.iter ( fun u ->
      (*
      glColor4f 1.0 1.0 1.0 0.2; 
      Draw.draw_bb (2.0, 6.0) u.Unit.loc;
      glColor4f 1.0 1.0 1.0 1.0; 
      Draw.draw_bb_vec (2.0, 6.0) u.Unit.pos;
      *)
      
      (* only visible units *)
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
                Draw.draw_tile_vec (0, 10) Draw.gr_map (u.Unit.pos); 
            | _ -> ()
          );

          (* danger bars *)
          if visible_well then
          ( let u_strength = eval_unit_strength u in
            let ratio = u_strength /. u_controlled_strength in
            
            set_color 1.0 1.0 1.0 0.7;
            
            if ratio > 4.0 then 
              Draw.draw_tile_vec (2, 9) Draw.gr_map (u.Unit.pos)
            else if ratio > 1.0 then 
              Draw.draw_tile_vec (1, 9) Draw.gr_map (u.Unit.pos)
            else if ratio > 0.25 then 
              Draw.draw_tile_vec (0, 9) Draw.gr_map (u.Unit.pos)
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
          let img = (0, 5) ++ 
            ( match Unit.get_sp u, Unit.get_gender u with
              | (Species.Hum, _), Some Unit.Core.Female -> (0, 1)
              | _ -> (0, 0)
            ) in
          if s.State.debug then
            Draw.draw_tile (10, 17) Draw.gr_map (u.Unit.loc);
          Draw.draw_tile_vec img Draw.gr_map (u.Unit.pos);
        
          let char_ij = (47, 41) in
          output_characteristics (Unit.get_core u) (char_ij ++ (0,0));
          output_hp (Unit.get_core u) (char_ij ++ (0,-4));
          output_mobility (Unit.get_core u) (char_ij ++ (0,-6));
          output_melee (Unit.get_melee u) (char_ij ++ (0,-9));
          output_ranged (Unit.get_ranged u) (char_ij ++ (0,-12));
          output_defense (Unit.get_defense u) (char_ij ++ (0, -15));

          let fnctq = Fencing.get_tq u.Unit.fnctqn in
          Draw.put_string Unit.(Printf.sprintf "%s" (fnctq.Fencing.name)) Draw.gr_sml_ui (40,0);
 
          (* Draw player's inventory *)
          
          (*
          draw_inventory t (12,1) u.Unit.core.Unit.Core.inv Draw.gr_ui inv_coords;
          (* Draw the ground inventory *)
          ( match Area.get reg.R.optinv u.Unit.loc with
              Some inv ->  
                draw_inventory t (12,1) inv Draw.gr_map (26,17)
            | _ -> () )
          *)

          (* simplified *)
          set_color 0.24 0.24 0.24 1.0;
          Draw.put_string "Equipped:" Draw.gr_sml_ui (inv_coords_sml ++ (-12,1));
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
                Draw.draw_tile (4 + j_x, 9) Draw.gr_map (loc') )
            ) tgtls

      | _ -> ()
      
  ) reg.R.e;
 
  (* notifications *)
  E.iter ( fun u ->
    let visible_well = is_visible_well s.State.vision u.Unit.loc in

    if visible_well then
    ( draw_ntfy t u )
  ) reg.R.e;

  (* draw projectiles *)
  set_color 1.0 1.0 1.0 1.0; 
  draw_projectiles t reg s.State.vision;
  
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
    let img = if b then (5,11) else (5,12) in
    let ij = (26,1) in
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
      
      draw_target_cursor 0 Draw.gr_map (s.State.cursor)
       

  | State.CtrlM.Inventory (invclass,ic,ii,u,_) ->
 
      let shift_unit_inv i = (0,-i) in
      let shift_unit_inv_sml i = (0,-2*i) in
      let shift_ground_inv = (0,-5) in
      let shift_ground_inv_sml = (0,-2*5) in

      (* background *)
      (
        let w = 14 in
        let h = let _,y = shift_ground_inv in -y + 3 in
        let img_bg = (7, 11) in
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
      let optobj = 
        let optinv = 
          match invclass with
          | State.CtrlM.InvGround -> Area.get reg.R.optinv u.Unit.loc 
          | _ -> Some u.Unit.core.Unit.Core.inv in
        match optinv with
          Some inv -> Inv.examine ic ii inv 
        | None -> None
      in
      ( match optobj with
          Some obj ->
            output_object_desc obj (inv_coords_sml ++ (0, -4))
            
        | None -> ()
      );

      (* Add labels *)
      set_color 0.24 0.24 0.24 1.0;
      Draw.put_string "0." Draw.gr_sml_ui (inv_coords_sml ++ shift_ground_inv_sml -- (2,0)); 
      
      Item.M.iter (fun i c -> 
        Draw.put_string (string_of_int (i+1) ^ ".") Draw.gr_sml_ui 
          (inv_coords_sml ++ shift_unit_inv_sml i -- (2,0))
      ) unit_inv.Inv.cnt;
      
      (* inventory cursor *)
      set_color 1.0 1.0 1.0 1.0; 
      let shift = match invclass with State.CtrlM.InvGround -> shift_ground_inv | _ -> shift_unit_inv ic in
      draw_cursor 0 Draw.gr_ui (inv_coords ++ shift ++ (ii,0))
  | _ -> ()
