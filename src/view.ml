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

let faction_color fac =
  let x = float (fac mod 5) /. 4.0 in
  let y = float (fac mod 3) /. 2.0 in
  let red = (0.5 +. 0.5*.(1.0-.y)) in
  let green = 0.6 in
  let blue = (0.3 +. 0.7*.x) in
  (red, green, blue)

let species_img = function
    Species.Hum, i -> (2.0 +. float i, 5.0)
  | Species.Cow, _ -> (9.0, 6.0)
  | Species.Horse, _ -> (10.0, 6.0)
  | Species.Wolf, _ -> (0.0, 7.0)
  | Species.Bear, _ -> (1.0, 7.0)
  | Species.Troll, _ -> (2.0, 7.0)
  | Species.Skeleton, _ -> (9.0, 5.0) 
  | Species.Zombie, _ -> (10.0, 5.0) 
  | Species.SkeletonWar, _ -> (11.0, 5.0) 
  | Species.ZombieHulk, _ -> (12.0, 5.0) 

let draw_gl_scene draw_func =
  glClear  (gl_color_buffer_bit (*lor gl_depth_buffer_bit*)) ;		 (* Clear The Screen And The Depth Buffer *)
  glLoadIdentity  () ;				 (* Reset The View*)
  glTranslatef 0.0 0.0 0.0 ;
  glColor4f 1.0 1.0 1.0 1.0; 
  glBindTexture gl_texture_2d texture.(0);
  glBegin gl_quads;		                
 
  draw_func();

  glColor4f 1.0 1.0 1.0 1.0; 
  glEnd();
  swap_buffers ()

let biome_img = function
  | RM.SnowMnt -> (9.0, 5.0)
  | RM.Mnt -> (10.0, 5.0)
  | RM.Plains -> (11.0, 5.0)
  | RM.Swamp -> (12.0, 5.0)
  | RM.Forest -> (13.0, 5.0)
  | RM.DeepForest -> (14.0, 5.0) 
  | RM.ForestMnt -> (15.0, 5.0)
  | RM.Dungeon -> (16.0, 5.0)
  | _ -> (8.0, 5.0)


let output_characteristics core ((i,j) as ij) =
  Draw.draw_ss_wh (6.0, 26.0) 4.0 3.0 ij;
  Draw.put_string (Printf.sprintf "%.0f" (Unit.Core.get_athletic core)) (i+5,j);
  Draw.put_string (Printf.sprintf "%.1f" (Unit.Core.get_reaction core)) (i+5,j-1);
  Draw.put_string (Printf.sprintf "%.0f" (Unit.Core.get_own_mass core)) (i+5,j-2)

let output_hp core ((i,j) as ij) =
  Draw.draw_ss_wh (6.0, 29.0) 4.0 1.0 ij;
  Draw.put_string (Printf.sprintf "%.0f" (Unit.Core.get_hp core)) (i+5,j)

let output_melee melee ((i,j) as ij) =
  Draw.draw_ss_wh (0.0, 26.0) 4.0 2.0 ij;
  let x = (melee.Item.Melee.attrate) (* *. (melee.Item.Melee.duration) *) in
  Draw.put_string (Printf.sprintf "%1.2g" x) (i+5,j);
  Draw.put_string (Printf.sprintf "%1.2g" (melee.Item.Melee.duration)) (i+5,j-1)

let output_ranged optranged ((i,j) as ij) =
  Draw.draw_ss_wh (0.0, 28.0) 4.0 2.0 ij;
  match optranged with
    Some ranged -> 
      Draw.put_string (Printf.sprintf "%1.2g" (ranged.Item.Ranged.dmgmult)) (i+5,j);
      Draw.put_string (Printf.sprintf "%1.2g" (ranged.Item.Ranged.force)) (i+5,j-1)
  | None ->
      Draw.put_string "none" (i+5,j)

let output_defense defense ((i,j) as ij) =
  Draw.draw_ss_wh (0.0, 30.0) 4.0 2.0 ij;
  Draw.put_string (Printf.sprintf "%1.2g" defense) (i+5,j)

let output_mobility core ((i,j) as ij) =
  Draw.draw_ss_wh (0.0, 32.0) 4.0 2.0 ij;
  Draw.put_string (Printf.sprintf "%1.2g" (Unit.Core.get_fm core)) (i+5,j);
  Draw.put_string (Printf.sprintf "%.0f" (Unit.Core.get_total_mass core)) (i+5,j-1)


let draw_geo g pol =
  let len = G.length g in
  
  let draw_one i loc =
    let scrloc = loc ++ (52,0) in
    (* biome *)
    let img = biome_img g.G.rm.(i).RM.biome in

    glColor4f 1.0 1.0 1.0 1.0; 
    Draw.draw_ss img scrloc;
   
    let (max_fac, max_fac_pop) = 
      fold_lim 
        ( fun (mf, mpop) f -> 
            let rm = g.G.rm.(i) in
            let pop = rm.RM.lat.Mov.fac.(f) + rm.RM.alloc.Mov.fac.(f) in
            if pop > mpop && pol.Pol.prop.(f).Pol.cl <> Pol.Wild then (f,pop) else (mf,mpop)
        ) (0, 0) 0 (Array.length g.G.rm.(i).RM.lat.Mov.fac - 1) in

    (* factions *)
    let cr, cg, cb = faction_color max_fac in

    (*
    (* altitude *)
    let alt = g.G.rm.(i).RM.altitude in
    let cr = alt in
    let cg = 1000 - alt in
    let cb = 0 in
    *)
   
    (* faction / altitude *)
    (*
    let img = if (fst loc + snd loc) mod 2 = 0 then (7.0,5.0) else (8.0,5.0) in
    *)

    if max_fac_pop > 5 then
    ( let img = (8.0, 5.0) in

      let x = float max_fac_pop *. 0.07 in
      glColor4f (x*. cr) (x*. cg) (x*. cb) 1.0; 
      Draw.draw_ss img scrloc;
    );

    (* g.prio *)
    ( match Prio.get i g.G.prio with
      | Some _ -> 
        ( glColor4f 1.0 1.0 1.0 1.0; 
          Draw.draw_ss (6.0,5.0) scrloc )
      | _ -> () );

    (* mark current region *)
    if i = g.G.currid then
    ( glColor4f 0.9 1.0 0.2 1.0; 
      Draw.draw_ss (6.0,5.0) scrloc )
  in
  
  for i = 0 to len-1 do

    let z, ((x,y) as loc) = g.G.loc.(i) in
    
    if x>=0 && x < 25 && y >=0 && y < 25 then
    ( let z_curr, _ = g.G.loc.(g.G.currid) in
    
      if z = z_curr then draw_one i loc )
  done


let draw_atlas atlas geo =
  let cur_z, cur_loc = atlas.Atlas.curloc in

  let maxr = 12 in
    
  let scrloc loc = loc -- cur_loc ++ (52,0) ++ (maxr, maxr) in

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
            (16.0, 5.0) ++. (10.0, 2.0) ++. (vec_of_loc dimg)

        | _ ->
            biome_img rmp.Atlas.biome 
      in
      glColor4f 1.0 1.0 1.0 alpha_bg; 
      Draw.draw_ss img (scrloc loc) ;
      List.iter 
        ( function
            Atlas.Occupied (fac, pop) ->
              let cr, cg, cb = faction_color fac in
              let x = float pop *. 0.07 in
              glColor4f (x*. cr) (x*. cg) (x*. cb) alpha_marks; 
              let img = (8.0, 5.0) in
              Draw.draw_ss img (scrloc loc) 
          | Atlas.StairsUp ->
              glColor4f 1.0 1.0 1.0 (0.5*.alpha_marks); 
              let img = (16.0, 6.0) in
              Draw.draw_ss img (scrloc loc) 
          | Atlas.StairsDown ->
              glColor4f 1.0 1.0 1.0 (0.5*.alpha_marks); 
              let img = (17.0, 6.0) in
              Draw.draw_ss img (scrloc loc) 
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
  glColor4f 0.9 1.0 0.2 1.0; 
  Draw.draw_ss (6.0,5.0) (scrloc cur_loc) 

  

let i_see_all = false

let draw_cursor t ij = 
  subimage (28.0,28.0) Draw.z (3.5, 3.5)
    (grid_pos Draw.dxdy_big Draw.z ij --. Draw.z %%. Draw.dxdy_sml)

let draw_target_cursor t ij = 
  subimage (28.0,28.0) Draw.z (2.5, 3.5)
    (grid_pos Draw.dxdy_big Draw.z ij --. Draw.z %%. Draw.dxdy_sml)

let draw_item t ij obj =
  let x = obj.Item.imgindex in
  let img = (float (9 + x mod 8), float(9 + x / 8)) in
  match Item.get_mat obj with
    Some Item.DmSteel ->
      glColor4f (0.78) (0.78) (0.86) 1.0;
      Draw.draw_bb img ij;
      glColor4f 1.0 1.0 1.0 1.0
  | Some Item.RustySteel ->
      glColor4f (0.80) (0.70) (0.60) 1.0;
      Draw.draw_bb img ij;
      glColor4f 1.0 1.0 1.0 1.0
  | _ ->
      Draw.draw_bb img ij

let draw_container t (i,j) (w,h) c = 
  for ii=0 to w-1 do
    for jj=0 to h-1 do
      Draw.draw_bb (9.0,8.0) (i+ii,j+jj)
    done
  done;
  Item.M.iter (fun k obj -> 
    draw_item t (i + k mod w, j - k / w) obj
  ) c.Item.Cnt.item

let draw_inventory t (i,j) (w,h) inv = 
  Item.M.iter (fun ci c -> 
    let w = match c.Item.Cnt.caplim with Some x -> x | _ -> w in
    draw_container i (i,j-h*ci) (w,h) c
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
          | Dir8.S -> (0.0,0.0), (0.25,0.5)
          | Dir8.N -> (1.0,1.0), (0.25,0.0)
          | Dir8.W -> (1.0,0.0), (0.5,0.25)
          | Dir8.E -> (0.0,1.0), (0.0,0.25)
          | Dir8.NE -> (2.0,1.0), (0.0,0.0)
          | Dir8.NW -> (3.0,1.0), (0.5,0.0)
          | Dir8.SE -> (2.0,0.0), (0.0,0.5)
          | Dir8.SW -> (3.0,0.0), (0.5,0.5)
        in
       
        let visible_well = is_visible_well vision (loc_of_vec pj.Proj.pos) in
        let visible_somewhat = is_visible_somewhat reg.R.a vision pj.Proj.pos in
        
        if visible_well || visible_somewhat then
        ( let red,green,blue = 1.0, 1.0, 1.0 in
          if visible_well then
            glColor4f red green blue 1.0
          else
            glColor4f (0.1+.0.2*.red) (0.1+.0.2*.green) (0.1+.0.2*.blue) 0.5;

          let img = (18.0, 32.0) in
          Draw.draw_ss_vec (img ++. dimg) (pj.Proj.pos ++. dpos); 

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
        glColor4f red green blue 1.0
      else
        glColor4f (0.3+.0.2*.red) (0.3+.0.2*.green) (0.3+.0.2*.blue) 0.5;

      let img = match stt with 
        | R.Obj.StairsUp -> (6.0,3.0)
        | R.Obj.StairsDown -> (7.0,3.0) in

      Draw.draw_bb img loc
    )
  ) ls

(* Area *)
let draw_area t reg rm vision =
  let def_ground_img = 
    match rm.RM.biome with
      | RM.Swamp -> (9.0, 1.0)
      | RM.Mnt | RM.ForestMnt -> (11.0, 0.0)
      | RM.SnowMnt -> (* (6.0, 4.0) *) (11.0, 1.0)
      | RM.Dungeon -> (13.0, 0.0)
      | _ -> (9.0, 0.0)
  in
  let def_ground_img_alt = def_ground_img ++. (1.0, 0.0) in

  glColor4f 1.0 1.0 1.0 1.0; 
  for i = 0 to Area.w reg.R.a - 1 do
    for j = 0 to Area.h reg.R.a - 1 do

      let visible, tile_opt =
        if Area.get vision (i,j) > 0 || i_see_all then true, Some (Area.get reg.R.a (i,j)) 
        else false, Area.get reg.R.explored (i,j) in

      match tile_opt with
      | Some tile -> 
          ( if visible then glColor4f 1.0 1.0 1.0 1.0 else glColor4f 0.7 0.7 0.7 0.7;

            let d_ground_img = match tile with Tile.IcyGround | Tile.SwampyPool -> (0.0, 1.0) | _ -> (0.0, 0.0) in
            Draw.draw_bb ((if (i+j) mod 2 = 1 then def_ground_img else def_ground_img_alt) ++. d_ground_img) (i,j);
            ( match tile with
                Tile.Wall -> Draw.draw_bb (0.0,3.0) (i,j)
              | Tile.Tree1 -> Draw.draw_bb (2.0,3.0) (i,j)
              | Tile.Tree2 -> Draw.draw_bb (if rm.RM.biome <> RM.SnowMnt then (3.0,3.0) else (3.0,4.0)) (i,j)
              | Tile.Rock1 -> Draw.draw_bb (if rm.RM.biome <> RM.SnowMnt then (4.0,3.0) else (4.0,4.0)) (i,j)
              | Tile.Rock2 -> Draw.draw_bb (if rm.RM.biome <> RM.SnowMnt then (5.0,3.0) else (5.0,4.0)) (i,j)
              | Tile.WoodenFloor -> Draw.draw_bb (1.0,3.0) (i,j)
              | Tile.OpenDoor -> Draw.draw_bb (1.0,4.0) (i,j)
              | Tile.DungeonWall -> Draw.draw_bb (14.0,1.0) (i,j)
              | Tile.DungeonOpenDoor -> Draw.draw_bb (15.0,2.0) (i,j)
              | _ -> () );

            (* draw items *)
            if visible then
            ( match Area.get reg.R.optinv (i,j) with
              | Some inv -> 
                  for k = 0 to 1 do
                    match Inv.examine 0 k inv with
                      Some obj -> draw_item t (i,j) obj
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
        glColor4f z1 (0.8 -. z1) (0.8 -. z1) ((1.0 -. t /. 4.0) +. z2); 
        Draw.put_string_vec Unit.(Printf.sprintf "%i" (round x)) (u.Unit.pos ++. (0.5*.(crit +. 0.1) *. sin(t), t*.0.4)) )
  ) u.Unit.ntfy

let draw_state t s = 
  glColor4f 1.0 1.0 1.0 1.0;
  let reg = G.curr s.State.geo in
  let cur_rm = s.State.geo.G.rm.(s.State.geo.G.currid) in
  draw_area t reg cur_rm s.State.vision;
  
  (* draw stairs *)
  glColor4f 1.0 1.0 1.0 1.0; 
  draw_stairs t reg s.State.vision;

  (* units *)
  glColor4f 0.5 0.6 0.3 1.0; 
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
            glColor4f red green blue 1.0
          else
            glColor4f (0.1+.0.2*.red) (0.1+.0.2*.green) (0.1+.0.2*.blue) 0.5;

          let species = Unit.get_sp u in 
          let img = species_img (species) ++. 
            ( match species, Unit.get_gender u with
              | (Species.Hum, _), Some Unit.Core.Female -> (0.,1.)
              | _ -> (0., 0.)
            ) in

          Draw.draw_bb_vec img (u.Unit.pos); 
        
          (* actors badge *)
          ( match u.Unit.optaid with 
              Some _ ->
                Draw.draw_bb_vec (0.0, 10.0) (u.Unit.pos); 
            | _ -> ()
          );

          (* danger area shading *)
          if visible_well then
          ( let u_strength = eval_unit_strength u in
            let ratio = u_strength /. u_controlled_strength in
            
            glColor4f 1.0 1.0 1.0 0.7;
            
            if ratio > 4.0 then 
              Draw.draw_bb_vec (2.0, 9.0) (u.Unit.pos)
            else if ratio > 1.0 then 
              Draw.draw_bb_vec (1.0, 9.0) (u.Unit.pos)
            else if ratio > 0.25 then 
              Draw.draw_bb_vec (0.0, 9.0) (u.Unit.pos)
          );
          
          (*
          match Unit.cur_dest_loc u with
            Some loc -> 
              glColor4f 1.0 0.0 0.0 0.4; 
              Draw.draw_bb (3.0, 6.0) loc
          | None -> ()
          *)
        )
        else
        ( (* human-controlled unit *) 
          glColor4f 1.0 1.0 1.0 1.0; 
          let img = (0.0, 5.0) ++. 
            ( match Unit.get_sp u, Unit.get_gender u with
              | (Species.Hum, _), Some Unit.Core.Female -> (0.,1.)
              | _ -> (0., 0.)
            ) in
          if s.State.debug then
            Draw.draw_bb (10.0, 17.0) (u.Unit.loc);
          Draw.draw_bb_vec img (u.Unit.pos);
         
          output_characteristics (Unit.get_core u) (0,37);
          output_hp (Unit.get_core u) (10,34);
          output_mobility (Unit.get_core u) (10,37);
          output_melee (Unit.get_melee u) (20,37);
          output_ranged (Unit.get_ranged u) (30,37);
          output_defense (Unit.get_defense u) (40,37);

          let fnctq = Fencing.get_tq u.Unit.fnctqn in
          Draw.put_string Unit.(Printf.sprintf "%s" (fnctq.Fencing.name)) (40,0);
  
          draw_inventory t (26,15) (12,1) u.Unit.core.Unit.Core.inv;
          ( match Area.get reg.R.optinv u.Unit.loc with
              Some inv ->  
                draw_inventory t (26,17) (12,1) inv
            | _ -> () )
          
          (*
          match Unit.cur_dest_loc u with
            Some loc -> 
              glColor4f 1.0 0.0 0.0 0.4; 
              Draw.draw_bb (3.0, 6.0) loc
          | None -> ()
          *)
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
            let j_x = floor (5.0 *. (0.5*. stage +. 0.5 *. tp/.te) ) in
          
            List.iter (fun tgt ->
              glColor4f 1.0 0.7 0.6 (0.1 +. 0.3 *. tgt.Fencing.magnitude); 
              let loc' = u.Unit.loc ++ tgt.Fencing.dloc in
              if Area.is_within s.State.vision loc' && Area.get s.State.vision (loc') > 0 then
              ( (* Draw.draw_bb (4.0 +. j, 6.0) (loc');*)
                Draw.draw_bb (4.0 +. j_x, 9.0) (loc') )
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
  glColor4f 1.0 1.0 1.0 1.0; 
  draw_projectiles t reg s.State.vision;
  
  glColor4f 1.0 1.0 1.0 1.0;
  if s.State.debug then
  (  (* draw auxiliary interface *)
    Draw.put_string Unit.(Printf.sprintf "top_rem_dt: %.0f" s.State.top_rem_dt) (10,-1);
  );
  Draw.put_string Unit.(Printf.sprintf "clock: %.0f" (State.Clock.get s.State.clock)) (25,0); 
  Draw.put_string Unit.(Printf.sprintf "speed[+-]:%+i" (s.State.opts.State.Options.game_speed)) (10,0); 
  Draw.put_string Unit.(Printf.sprintf "h: %i" (s.State.geo.G.loc.(R.get_rid reg) |> fst )) (50,0); 

  (* atlas *)
  if s.State.debug && false then
    draw_geo s.State.geo s.State.pol
  else
    draw_atlas s.State.atlas s.State.geo;

  if s.State.debug && false then
  ( (* factions images *)
    let output num pos =
      Draw.put_string Unit.(Printf.sprintf "%i" num) pos in
    let rm = s.State.geo.G.rm.(s.State.geo.G.currid) in
    Array.iteri (fun fac fac_prop -> 
        let sp = List.hd s.State.pol.Pol.prop.(fac).Pol.speciesls in
        let img = species_img sp in 
        let (r,g,b) = faction_color fac in
        glColor4f r g b 1.0; 
        Draw.draw_bb img (26+fac,13);
       
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
    glColor4f 1.0 1.0 1.0 1.0;
    if b then
    ( Draw.draw_bb (5.0, 11.0) (26+10, 0);
      Draw.draw_bb (6.0, 11.0) (27+10, 0) )
    else
    ( Draw.draw_bb (5.0, 12.0) (26+10, 0);
      Draw.draw_bb (6.0, 12.0) (27+10, 0) )
  );

  (* edges *)
  if G.Me.mem Down s.State.geo.G.nb.(s.State.geo.G.currid) then
  ( glColor4f 0.8 0.6 0.4 1.0; 
    Draw.put_string "Down" (0,33) );
  (* Draw.put_string (Printf.sprintf "id=%i" s.State.geo.G.currid) (50,37); *)


  (*
  (* resources *) 
  output (Resource.numeric rm.RM.lat.Mov.res) ((26+8)*2+1,12*2+2);
  output (Resource.numeric rm.RM.alloc.Mov.res) ((26+8)*2+1,12*2+1);
  *)

  match s.State.cm with
  | State.CtrlM.Target _ -> 
      (* cursor *)
      glColor4f 1.0 1.0 1.0 1.0; 
      
      (*
      subimage (28.0,28.0) Draw.z (3.5, 3.5)
        (grid_pos Draw.dxdy_big Draw.z s.State.cursor --. Draw.z %%. Draw.dxdy_sml)
      *)
      (*
      Draw.draw_bb (7.5, 7.5) (s.State.cursor);
      *)

      draw_target_cursor 0 (s.State.cursor ++ (1,1))
       

  | State.CtrlM.Inventory (invclass,ic,ii,u,_) ->
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
            let mass = Item.get_mass obj in
            let defense = Item.get_defense obj in
            
            glColor4f 1.0 1.0 1.0 1.0; 
            ( match Item.get_ranged obj with
              | (Some _) as x -> output_ranged x (59,34)
              | _ -> 
                  ( match Item.get_melee obj with
                    | Some melee -> output_melee melee (59, 34);
                      if defense > 0.0 then output_defense defense (68, 34)
                    | _ ->
                      if defense > 0.0 then output_defense defense (60, 34);
                  )
            );
            Draw.put_string Unit.(Printf.sprintf "Mass: %.2g" mass) (60, 32); 
            
            (*
            if melee_attrate > 0.0 then 
              Draw.put_string Unit.(Printf.sprintf "Atk:%.2g Dur:%.2g" melee_attrate melee_duration) (60, 33);
            if defense > 0.0 then 
              Draw.put_string Unit.(Printf.sprintf "Defense: %.2g" defense) (60, 32);
            if ranged_force > 0.0 then 
              Draw.put_string Unit.(Printf.sprintf "Ranged: %.2g" ranged_force) (60, 32) 
            *)
        | None -> ()
      );
      glColor4f 0.24 0.24 0.24 1.0; 
      Draw.put_string "0." (51, 35); 
      Draw.put_string "1." (51, 31); 
      Draw.put_string "2." (51, 29); 
      (* inventory cursor *)
      glColor4f 1.0 1.0 1.0 1.0; 
      let jj = match invclass with State.CtrlM.InvGround -> 18 | _ -> 16 in
      draw_cursor 0 (27 + ii, jj - ic)
  | _ -> ()
