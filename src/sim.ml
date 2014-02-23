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

open Base
open Common
open State
open Global

let comp_transfer area (i,j) = 
  if i < 0 then Some West else
  if i >= Area.w area then Some East else
  if j < 0 then Some South else
  if j >= Area.h area then Some North else None

(* check location *)
let is_loc_in_prio geo rid a loc =
  let test nrid =
    match Prio.get nrid geo.G.prio with
      Some _ -> true
    | None -> false
  in
  match comp_transfer a loc with
    Some dir ->
      ( match G.get_nb geo rid dir with 
          Some nrid -> test nrid
        | None -> false
      )
  | None -> false

(* make a path so that a unit exit a region only if the destination region is in region Priority List,
   so the unit does not disappear *)
let make_long_random_path geo rid a u =
  let rec path l dl n =
    let is_within = Area.is_within a l in
    if n > 0 && 
          ( not is_within && is_loc_in_prio geo rid a l
            || is_within && Tile.classify (Area.get a l) = Tile.CFloor ) then 
      l :: path (l++dl) dl (n-1) 
    else [] in
  match Random.int 2 with
  | 0 -> 
      let x0,_ = u.Unit.loc in
      let x1 = Random.int (Area.w a + 2) - 1 in
      let dx = x1-x0 in
      if dx > 0 then path (u.Unit.loc ++ (1,0)) (1,0) (abs dx)
      else if dx < 0 then path (u.Unit.loc ++ (-1,0)) (-1,0) (abs dx)
      else []
  | _ -> 
      let _,y0 = u.Unit.loc in
      let y1 = Random.int (Area.h a + 2) - 1 in
      let dy = y1-y0 in
      if dy > 0 then path (u.Unit.loc ++ (0,1)) (0,1) dy
      else if dy < 0 then path (u.Unit.loc ++ (0,-1)) (0,-1) (-dy)
      else []

let make_short_random_path geo rid a u =
  let (x0,y0) = u.Unit.loc in
  let dstloc = 
    match Random.int 2 with
    | 0 -> (Random.int (Area.w a + 2) - 1, y0)
    | _ -> (x0, Random.int (Area.h a + 2) - 1)
  in
  if ((Area.is_within a dstloc) || (is_loc_in_prio geo rid a dstloc)) && (dstloc <> u.Unit.loc) then
    Unit.make_path_to a u dstloc 
  else
    make_long_random_path geo rid a u

let make_some_random_path geo rid a u =
  if Random.int 2 = 0 then
    make_short_random_path geo rid a u
  else  
    make_long_random_path geo rid a u

(* fulfilled actions *)
let ff_path l = function hd::tl when l = hd -> tl | path -> path 
let ff_action_ls l = function 
  | (hd::tl) as acls ->
      ( match hd with
        | Walk (path,_) -> 
            (match ff_path l path with [] -> tl | npath -> Walk (npath,0.0) :: tl)
        | Run (path,_) -> 
            (match ff_path l path with [] -> tl | npath -> Run (npath,0.0) :: tl)
        | _ -> acls
      )
  | [] -> []

let reaction_roll u = 
  match u.Unit.ac with 
    (Wait (_,w))::tl -> w > Unit.get_reaction u 
  | _ -> false

let rec progress_ntfy dt = function
  | (ev, t)::tl when t < 4.0 -> (ev, t+.dt) :: progress_ntfy dt tl
  | _ -> []

let move_dv area ue dt dv u =
  let dist = vec_len dv in
  
  let traction_factor = Tile.get_traction (Area.get area u.Unit.loc) in
  let friction_factor = Tile.get_friction (Area.get area u.Unit.loc) in
  
  let force_intention = 
    traction_factor *.
    ((Unit.get_athletic u) *. exp(-3.3*.(dist-.0.5)*.(dist-.0.5))) %%. dv in
  let force_collision = 
    List.fold_left (fun accf cu -> 
      let cdv = u.Unit.pos --. cu.Unit.pos in
      (* let cdist2 = vec_len2 cdv +. 0.01 in *)
      let mass = Unit.get_total_mass cu in
      
      let radius = (Unit.get_radius u +. Unit.get_radius cu) in
      let radius2 = radius*.radius in
      let cdist2 = vec_len2 cdv in
      let cdist = sqrt cdist2 in
      let cdist_x = cdist +. 0.01 in
      let dr = (min 0. (cdist -. radius)) in
      let ff = (0.20 *. (dr*.dr)  +. 0.05 *. exp(-1.0 /. radius2 *. cdist2)) *. mass %%. (cdv //. (cdist_x)) in
      (*
      let ff = (0.20 *. exp(-10.0 *. cdist2) +. 0.05 *. exp(-1.0 *. cdist2)) *. mass %%. (cdv //. (sqrt cdist2)) in
      *)
      accf ++. ff
    ) (0.0,0.0) (E.collisions_nb u ue) in
  let force = force_intention ++. force_collision in

  let vel_len2 = vec_len2 u.Unit.vel in
  let a = (10.0) %%. force //. Unit.get_total_mass u --. friction_factor *. (1.0 +. 1.0*.vel_len2) %%. u.Unit.vel in
  let nvel = u.Unit.vel ++. dt %%. (a ++. (Random.float 0.02 -. 0.01, Random.float 0.02 -. 0.01)) in
  let npos = u.Unit.pos ++. (dt *. 0.5) %%. (nvel ++. u.Unit.vel) in
  let nloc = loc_of_vec npos in

  let nntfy = progress_ntfy dt u.Unit.ntfy in

  (* pos and vel *)
  if is_walkable area nloc then
    {u with Unit.vel=nvel; Unit.pos=npos; Unit.ntfy = nntfy;}
  else
  ( (* reaction ? *)
    let transfer = comp_transfer area nloc in

    match transfer with 
      None -> 
        if reaction_roll u then (* cancel actions if reaction is good *)
          {u with Unit.vel=(0.0,0.0); Unit.pos=u.Unit.pos; ac = []; ntfy = nntfy;}
        else
          (*
          {u with Unit.vel=(0.0,0.0); Unit.pos=u.Unit.pos; Unit.ac=(Wait (u.Unit.loc,0.0)):: ff_action_ls nloc u.Unit.ac;}
          *)
          let (nvelx, nvely) = nvel in
          let loc = u.Unit.loc in
          let vel_repel = 1.0 %%.
            match loc -- nloc with
            | 0, _ -> (nvelx, -.nvely)
            | _, 0 -> (-.nvelx, nvely)
            | _ -> (-.nvelx, -.nvely)
          in
          {u with Unit.vel=vel_repel; Unit.pos=u.Unit.pos; ntfy = nntfy; Unit.ac=[Wait (u.Unit.loc,0.0)];}
    | _ ->
        {u with Unit.vel=nvel; Unit.pos=u.Unit.pos; ntfy = nntfy; ac = [Wait (u.Unit.loc,0.0)]; transfer}
  )

(* process actions, passing time dt *)
let move area ue dt u =
  
  (* heal slowly *)
  let u = Unit.heal (0.1*.dt) u in

  match u.Unit.ac with
  | ac_hd::ac_tl ->
      ( match ac_hd with
        | Walk (path, w) | Run (path, w) ->
            let target = vec_of_loc 
              (match path with hd::_ -> hd | _ -> u.Unit.loc) in
            let dv = target --. u.Unit.pos in
            let u' = move_dv area ue dt dv u in
            (* advanse walking time *)
            ( let ac =
                match u'.Unit.ac with
                | (Walk (path,w))::tl -> (Walk (path, w+.dt))::tl
                | (Run (path,w))::tl -> (Run (path, w+.dt))::tl
                | x -> x in
              {u' with Unit.ac = ac}
            )
        | Wait (loc,w) ->
            let dv = vec_of_loc loc --. u.Unit.pos in
            let u' = move_dv area ue dt dv u in
            {u' with Unit.ac = (Wait (loc,w+.dt))::ac_tl} 
        | Timed (hold_opt, t_passed, t_end, ta) -> 
            (* optional hold ground *)
            let dv = match hold_opt with
                Some loc -> vec_of_loc loc --. u.Unit.pos
              | _ -> (0.0, 0.0) in 
            move_dv area ue dt dv u
        | Lookaround _ 
        | FireProj _ ->
            move_dv area ue dt (0.0, 0.0) u
      )
  | [] ->
    move_dv area ue dt (0.0, 0.0) u



(* adjust loc, determine fulfilled actions, insert waiting, end waiting *)  
let adjust a u =
  let loc_now = loc_of_vec u.Unit.pos in
  let u1 = if loc_now <> u.Unit.loc then {u with Unit.loc = loc_now} else u in

  (* don't wait for too long *)
  let u1 = match u1.Unit.ac with
    | (Walk (_,w))::_ | (Run (_,w))::_ ->
        if  w > 3.0 +. 3.0 *. Unit.get_default_wait u1 then
          {u1 with Unit.ac = [Wait (loc_now,0.0)]}
        else
          u1
    | _ -> u1
  in

  match u1.Unit.ac with
    (Wait _)::ac_tl -> 
      if reaction_roll u1 then 
        {u1 with Unit.ac = ac_tl}
      else u1
  | (Timed _)::_ | (Lookaround _)::_ | (FireProj _)::_ -> u1
  | [] -> u1
  | (Walk _)::_ | (Run _)::_ ->
      let messedup = 
        match Unit.cur_dest_loc u with 
          Some x when x = u.Unit.loc -> true
        | None -> true 
        | _ -> false in

      if u1.Unit.loc <> u.Unit.loc || messedup then
      ( match Unit.cur_dest_loc u1 with
          Some dest when loc_manhattan (dest -- loc_now) < 1 ->
            {u1 with Unit.ac = (Wait(loc_now,0.0)) :: ff_action_ls loc_now u1.Unit.ac} 
        | _ -> {u1 with Unit.ac = [Wait (loc_now,0.0)]} )
      else
        u1

(* Firing projectiles *)
let actions_with_objects (reg, u) =
  match u.Unit.ac with
    (FireProj loc)::ac_tl -> 
      ( match Unit.get_ranged u with
        | Some {Item.Ranged.force=force; Item.Ranged.projmass = mass; Item.Ranged.dmgmult = dmgmult} ->
            (* create a projectile *)
            let dir = vec_of_loc loc --. u.Unit.pos in
            let uni = (1.0 /. vec_len dir) %%. dir in
            let pos = u.Unit.pos ++. uni in
            let dvel = (Unit.(0.5 *. (1.0 +. 0.1 *. Unit.get_athletic u)) *. force/.mass) %%. uni in
            let vel = dvel ++. u.Unit.vel in
            let projectile = Proj.({item={mass=mass; dmgmult}; pos; vel; }) in

            let u = {u with Unit.vel = u.Unit.vel --. (10.0 *. mass /. Unit.get_total_mass u %%. dvel)} in

            let reg1 = Simobj.add projectile reg in
            (reg1, {u with Unit.ac = (Wait (u.Unit.loc, 0.0))::ac_tl})

        | None ->
            (reg, {u with Unit.ac = (Wait (u.Unit.loc, 0.0))::ac_tl})
      )
  | _ -> (reg, u) 


(* Deal damage aux function *)
let deal_damage dt fnctgt u tu ue =
  (*
  let dv = tu.Unit.pos --. u.Unit.pos in
  let dist = vec_len dv in
  *)
  let strike = (* dp (change of the momentum with time dt) = F*dt = dvel*m *)
    dt *. Unit.get_athletic u *. fnctgt.Fencing.magnitude *.
    1.0 *. (1.0  +. 1.0 *. vec_dot_prod (u.Unit.vel --. tu.Unit.vel) fnctgt.Fencing.pushvec (*dv /. dist*)) in

  let melee = Unit.get_melee u in
  let tu' = Unit.damage (strike, fnctgt.Fencing.pushvec, melee.Item.Melee.attrate) tu in

  (E.upd tu' ue)

(* timed actions - does not change actions of u, they are changed by the function 'run' 
 * this function should do damage and affect units
 *)
let timed dt ( (ue, ((hold_opt, t_passed, t_end, ta) as ta_full), u) as args ) =
  match ta with
  | Attack (tq, dir_index) ->
    let fnctgt_ls, _ = Fencing.get_tgtls_and_stage dt t_passed t_end tq dir_index in
    let ue' =
      List.fold_left (fun ue fnctgt ->
        let dl = fnctgt.Fencing.dloc in
        let loc = u.Unit.loc ++ dl in
        let ls1 = if (loc_manhattan dl = 1) then E.at u.Unit.loc ue else [] in
        let ls2 = E.at loc ue in
        let fls1 = List.filter (fun tu -> vec_dot_prod Unit.(tu.pos --. u.pos) (vec_of_loc dl) > 0.0) ls1 in
        let ls = List.rev_append fls1 ls2 in
        ( match any_from_ls ls with
          | None -> ue
          | Some tu -> deal_damage dt fnctgt u tu ue
        )
      )
      ue fnctgt_ls 
    in
    (ue', ta_full, u)
  | Rest ->
      let u' = Unit.heal (0.8*.dt) u in
      (ue, ta_full, u')
  | _ -> args

(* come up with new actions *)
let intel geo reg pol ue u =
  (* if u does not like other_u: *)
  let g = List.filter (fun other_u -> 
    match Decision.U.get_intention pol u other_u with Decision.Kill | Decision.Avoid -> true | _ -> false) 
  in
  let h dl = E.at (u.Unit.loc ++ dl) ue in
  let f dl = g (h dl) in
  if u.Unit.ac = [] then
    let enemies =
      List.concat [ f(0,1); f(0,-1); f(1,0); f(-1,0) ] in
    match any_from_ls enemies with
      Some tu ->
        let dir_index = match Unit.(tu.loc--u.loc) with
          | (1,0) -> 0 
          | (0,1) -> 1
          | (-1,0) -> 2
          | _ -> 3
        in
        let melee = Unit.get_melee u in
        let weapon_duration = melee.Item.Melee.duration in
        let tq = Fencing.get_tq u.Unit.fnctqn in
        let timed_action = Attack (tq, dir_index) in
        let duration = weapon_duration *. tq.Fencing.dur_mult in
        {u with Unit.ac = [Timed (Some u.Unit.loc, 0.0, duration, timed_action)];
          Unit.fnctqn = Fencing.auto_switch u.Unit.fnctqn;
        }
    | None ->
        {u with Unit.ac = [Lookaround 8] (* [Walk (Unit.make_path reg.R.a u)]; *)} 
  else 
    ( match u.Unit.ac with
      | (Lookaround dist) :: tl ->
          let u' = Vision.update_mob_sight reg dist u in
          let ls = fold_lim (fun acc i ->
              fold_lim (fun acc j ->
                let loc = u.Unit.loc ++ (i,j) in
                if (i<>0||j<>0) && Area.is_within u'.Unit.sight loc && Area.get u'.Unit.sight loc = 1 then 
                  f(i,j) :: acc else acc
              ) acc (-dist) dist
            ) [] (-dist) dist in
          ( match any_from_ls (List.concat ls) with
            | Some tu ->
                (* remember the target *)
                let u' = Unit.({u' with tactmem = TactMem.(singleton (EnemySeen (u.loc, tu.id, tu.loc)))}) in
                ( match Unit.get_ranged u with
                  | Some _ -> (* Ranged attack *)
                      let delaytime = Unit.get_default_ranged_wait u in
                      {u' with Unit.ac = [ Timed(Some u'.Unit.loc, 0.0, delaytime, Prepare(FireProj (tu.Unit.loc)))] }
                  | _ -> (* Melee attack *)
                      {u' with Unit.ac = [Walk (Unit.make_path_to reg.R.a u' tu.Unit.loc, 0.0)]} 
                )
            | _ ->
              (* try to recall the enemy's position *)
              ( match Unit.TactMem.find_enemyseen u'.Unit.tactmem with
                | None -> 
                  ( let to_wait =
                      match Unit.get_sp u' with
                        Species.Cow, _ -> 0.9 | Species.Horse, _ -> 0.80 | _ -> -0.1 in
                    
                    if Random.float 1.0 < to_wait then
                      {u' with Unit.ac = [Wait (u'.Unit.loc, 0.0)]} 
                    else
                      {u' with Unit.ac = [Walk (make_some_random_path geo reg.R.rid reg.R.a u', 0.0)]} )
                | Some (ownloc, tid, tloc) ->
                  (* attack the enemy there *)
                  ( 
                    if u'.Unit.loc <> tloc then
                    ( let path = Unit.make_path_to reg.R.a u' tloc in
                      match path with
                        [] ->
                          { u' with Unit.ac = [Walk (make_some_random_path geo reg.R.rid reg.R.a u', 0.0)];
                            Unit.tactmem = Unit.TactMem.empty;
                          }
                      | _ -> {u' with Unit.ac = [Walk (path, 0.0)]} 
                    )
                    else
                    ( 
                      let z = tloc -- ownloc in
                      let d = loc_manhattan z + 1 in
                      let dloc_ls = [(d,0); (0,d); (-d,0); (0,-d)] in
                      let vz= vec_of_loc z in
                      
                      (* compute the probabilities to walk in the given directions *)
                      let pre_prob_ls = List.map 
                        (fun dloc -> vec_dot_prod (vec_of_loc dloc) vz +. 1.0 +. float (d*d)*.1.1)
                        dloc_ls in
                      let pre_prob_sum = List.fold_left (+.) 0.0 pre_prob_ls in
                      
                      (* actula probabilities list to choose the destination *)
                      let prob_ls = List.map2 (fun dloc pre_prob -> (tloc ++ dloc, pre_prob /. pre_prob_sum)) dloc_ls pre_prob_ls in

                      let dest_loc = any_from_prob_ls prob_ls in

                      {u' with 
                        Unit.ac = [Walk (Unit.make_path_to reg.R.a u' dest_loc, 0.0)];
                        Unit.tactmem = if (Random.int 3 = 0) then Unit.TactMem.empty else u'.Unit.tactmem }
                    )
                  )
              )
          )
      | _ -> u )

(* helper function *)
(* run simulation for a single unit, return reg and need_input *)
let run_for_one dt u s (reg, astr, need_input) =
  (* move and adjust *)
  let u' = u |> move reg.R.a reg.R.e dt |> adjust reg.R.a in

  (* fire projectiles *)
  let reg, u' = actions_with_objects (reg, u') in

  (* timed actions - affects other units, overshadows old ue and u' *)
  let (ue, u') = 
    match u'.Unit.ac with 
      (Timed (hold_opt, t_passed, t_end, ta)) :: tl -> 
        let (ue', ((_, tp', te', _) as ta_full), u') = 
          timed dt (reg.R.e, (hold_opt, t_passed +. dt, t_end, ta), u') in
        let u'' =
          if tp' <= te' then
            {u' with Unit.ac = (Timed ta_full) :: tl }
          else
            let tl_ext = match ta with 
              Prepare action -> action::tl
            | _ -> tl in
            {u' with Unit.ac = (Wait (u'.Unit.loc,0.0)) :: tl_ext } in
        (E.upd u'' ue', u'')
    | _ -> (reg.R.e, u')
  in

  let updateu u = {reg with R.e = E.upd u ue} in
  let removeu u = 
    let optinv = Area.get reg.R.optinv u.Unit.loc in
    let invleftovers, optinv1 = Inv.ground_drop_all u.Unit.core.Unit.Core.inv optinv in
    Area.set reg.R.optinv u.Unit.loc optinv1;
    (* Warning! this resources that left over, are lost and possibly disapear *)
    (* let res = Inv.decompose invleftovers in *)
    {reg with R.e = E.rm u ue} in

  let rid = R.get_rid reg in

  (* remove corpses *)
  if Unit.is_alive u' then
  ( (* intel or input *)
    match u'.Unit.ac with
    | (Lookaround _)::_ | [] ->
      ( (* add intelligence for units that are not directly controlled *)
        if Unit.get_controller u' = None then 
        ( let astr_upd = Org.Astr.update_from_unit u' rid astr in
          let u'' = (u' |> intel s.geo reg s.pol ue) in
          (updateu u'', Org.Astr.update_from_unit u'' rid astr_upd, need_input) )
        (* or wait for input *)
        else
          (updateu u', Org.Astr.update_from_unit u' rid astr , u'::need_input)
      )
    | _ -> 
      (updateu u', Org.Astr.update_from_unit u' rid astr, need_input)
  )
  else 
  (removeu u', Org.Astr.remove_from_unit u' astr, need_input)

let transfer_from reg pol controller_id (geo, astr) =
  E.fold (fun (geo_acc, astr_acc) u -> 
    (geo_acc, astr_acc) |> Globalmove.unit_transfer u reg pol (Unit.get_controller u = Some controller_id)        
  ) (geo, astr) reg.R.e


(* main simulation function *)
let run dt s =
  let def_dt = 0.025 in
  (* def_dt time step *)
  let rec iterate dt s =
    if s.rem_dt +. dt > def_dt then
    (
      (*
      let b_compute_neighbors = Random.int 4 = 0 in
      let gen_reg_list geo = 
        if b_compute_neighbors then G.curnb_ls geo else [G.curr geo] in
      *)
      let gen_reg_list geo = 
        G.curr geo :: (List.filter (fun _ -> Random.int 2 = 0) (G.only_nb_ls geo)) in

      let reg_list = gen_reg_list s.geo in

      (* simulate current + neighboring regions *)
      let geo1, astr1, need_input = 
        List.fold_left ( fun (acc_geo, acc_astr, acc_need_input) reg ->
          let rid = reg.R.rid in

          (* update projectiles *)
          let reg = Simobj.upd_projectiles def_dt reg in 

          (* update units *)
          let upd_reg, upd_astr, upd_acc_need_input = 
            E.fold 
              ( fun ((aa_reg,_,_) as acc) u ->
                  (* get u from the accumulator *)
                  ( match E.id (u.Unit.id) aa_reg.R.e with
                    | Some u -> run_for_one def_dt u s acc
                    | None -> acc
                  )
              ) (reg, acc_astr, acc_need_input) reg.R.e in
          
          (* update allocated movables *)
          acc_geo.G.rm.(rid) <- 
            { acc_geo.G.rm.(rid) with RM.alloc = R.decompose_nonplayer_only true upd_reg };
          
          (* return updated geo *)
          (G.upd upd_reg acc_geo, upd_astr, upd_acc_need_input)
        ) (s.geo, s.astr, []) reg_list in

      (* transfer units *)
      let reg_list_1 = gen_reg_list geo1 in
      let geo2,astr2 = 
        List.fold_left (fun geo_astr_acc reg ->
          transfer_from reg s.State.pol s.State.controller_id geo_astr_acc) (geo1,astr1) reg_list_1 in

      if need_input = [] then
        iterate (s.rem_dt +. dt -. def_dt) {s with geo = geo2; astr = astr2; rem_dt = 0.0;}
      else
        {s with rem_dt = s.rem_dt +. dt; geo = geo2; astr = astr2; cm=CtrlM.WaitInput need_input}
    )
    else
      {s with rem_dt = s.rem_dt +. dt}
  in

  match s.cm with
  | CtrlM.WaitInput _ | CtrlM.Target _ | CtrlM.Inventory _ ->
      (* how frequently the map is updated *)
      let step_dt = 10.0 in
      let number = ( s.State.top_rem_dt /. step_dt ) |> floor |> int_of_float  in
      let number = if number > 0 then 1 else 0 in
      let upd_geo, upd_astr = fold_lim (fun ga _ -> Top.run 1.0 s.pol ga) (s.geo, s.astr) 1 number in
      let upd_atlas = 
        if s.State.atlas.Atlas.currid <> s.State.geo.G.currid then
          Global.Atlas.update s.State.pol upd_geo s.State.atlas 
        else
          s.State.atlas
      in
      {s with 
        State.geo = upd_geo;
        State.astr = upd_astr;
        State.atlas = upd_atlas;
        State.top_rem_dt = 
          s.State.top_rem_dt -. float number *. step_dt; 
      }
  | CtrlM.Normal -> 
      let ns = iterate dt s in
      (* update vision *)
      Vision.update_sight (Some ns.State.controller_id) (G.curr ns.State.geo) ns.State.vision;
      let new_clock = State.Clock.add dt ns.State.clock in
      {ns with State.top_rem_dt = ns.State.top_rem_dt +. dt; State.clock = new_clock } 
