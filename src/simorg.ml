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

(* Sim Org *)
open Base
open Common
open Org
open Global


let compute_core_value core = 
  let v = core |> Unit.Core.decompose |> Resource.numeric |> float in 
  let fm = Unit.Core.get_fm core in
  v**4.0 *. fm

(* returns (bunch, (core, value)) option;  the 'bunch' contains what is left *)
let try_to_keep_the_bunch eval_better (core, value) bunch =
  let result = Inv.put_somewhere_bunch bunch (Unit.Core.get_inv core) in

  let opt_bunch, opt_inv_alt = 
    match result with
    | Item.Cnt.MoveBunchSuccess inv -> None, Some inv
    | Item.Cnt.MoveBunchPartial (b, inv) -> Some b, Some inv
    | _ -> Some bunch, None
  in

  match opt_inv_alt with
    Some inv_alt ->
      let core_alt = Unit.Core.upd_inv inv_alt core in
      if eval_better core core_alt then 
        None
      else
      ( let value_alt = compute_core_value core_alt in
        if value_alt > value then
          Some (opt_bunch, (core_alt, value_alt))
        else
          None
      )

  | None -> None

(* returns ((core,value),leftovers) *)
let keep_precious_items core_value bunchls =
  let upd (cv,ls) bunch = 
    match try_to_keep_the_bunch eval_slow cv bunch with
      Some (Some b, cv_alt) -> true, (cv_alt, b::ls)
    | Some (None, cv_alt) -> true, (cv_alt, ls)
    | None -> false, (cv, bunch::ls)
  in
  let rec next (cv0,ls0) (cvb,lsb) = function
    | bunch::tl ->
        let cvls_zero = cv0, bunch::ls0 in
        ( match upd (cv0,ls0) bunch, upd (cvb,lsb) bunch with
          | (true, (((_,v0u),_) as cvls0u)), (true, (((_,vbu),_) as cvlsbu)) ->
              let best = if v0u > vbu then cvls0u else cvlsbu in
              next cvls_zero best tl
          | (false,_), (true,cvlsbu) ->
              next cvls_zero cvlsbu tl
          | (true, (((_,v0u),_) as cvls0u)), (false,_) ->
              let _,vb = cvb in
              let best = if v0u > vb then cvls0u else (cvb, bunch::lsb) in
              next cvls_zero best tl
          | _ -> 
              next cvls_zero (cvb, bunch::lsb) tl
        )
    | [] -> (cvb,lsb)
  in
  let cvls = core_value,[] in
  next cvls cvls bunchls


let will_we_fight pol core1 core2 =
  let dec1 = Decision.C.get_intention pol core1 core2 in
  let dec2 = Decision.C.get_intention pol core2 core1 in
  match dec1, dec2 with
    Decision.Kill, Decision.Kill -> true
  | Decision.Kill, _ when Decision.C.initiative_roll_against core1 core2 -> true
  | _, Decision.Kill when Decision.C.initiative_roll_against core2 core1 -> true
  | _ -> false

(* helper function *)
let dissolve_lat_res g rid res =
  let lat_res = rget_lat g rid in 
  rset_lat g rid (Resource.add lat_res res) 

(* update the state of the system with an updated actor *)
let update_rid_actor_g_astr rid a (g, astr) =
  if Unit.Core.is_alive (Actor.get_core a) then
    (g, Astr.update a astr)
  else
    let res = Actor.decompose a in
    dissolve_lat_res g rid res;
    (g, Astr.remove a astr)

(* update the state of the system with an updated core of a simple unit *)
let update_rid_core_g_astr rid core (g, astr) =
  let res = Unit.Core.decompose core in
  dissolve_lat_res g rid res;

  if Unit.Core.is_alive core &&
    Random.float 1.0 < (Unit.Core.get_hp core /. Unit.Core.get_max_hp core) 
  then
    (g, astr)
  else
    let faction = Unit.Core.get_faction core in
    let pop_lat = fget_lat g rid faction in
    fset_lat g rid faction (max 0 (pop_lat-1)); 
    (g, astr)

(* try to use the items of the defeated opponent *)
let digest_core_no_valuables my_core opp_core = 
  let bunch_ls = Unit.Core.bunch_ls opp_core in
  let my_core', leftovers =  
    List.fold_left (fun (acc_core, acc_leftovers) bunch ->
        let core, drop_bunch_ls = try_bunch_eval eval_slow acc_core bunch in
        (core, List.rev_append drop_bunch_ls acc_leftovers)
      ) 
    (my_core, []) bunch_ls in
  ( my_core', 
    {opp_core with Unit.Core.inv = Inv.remove_everything (Unit.Core.get_inv opp_core)},
    leftovers )

(* take both, better weapons and precious items  *)
let digest_core my_core opp_core = 

  let (my_core_upd, opp_core_upd, leftovers) = digest_core_no_valuables my_core opp_core in

  let my_value_upd = compute_core_value my_core_upd in
  let (my_core_upd2, my_value_upd2), leftovers_upd2 = keep_precious_items (my_core_upd, my_value_upd) leftovers in
  
  (my_core_upd2, opp_core_upd, leftovers_upd2)


(* transfer the actor *)
let transfer_actor a nrid (g, astr) =
  match Prio.get nrid g.G.prio with
    Some nreg ->
      (* Don't let it move into the simulated region *)
      (g, astr)
  | None ->
      (g, Astr.move_actor a nrid astr)


(* Scenario - meet a local inhabbitant *)
let scenario_meet_a_local pol a opp_core (g,astr) =
  let rid = Actor.get_rid a in
  let my_core = Actor.get_core a in
  if will_we_fight pol my_core opp_core then
  (  
    let (my_core_upd, opp_core_upd) = fake_fight my_core opp_core in
    
    (* take the resources from the rm *)
    let opp_res = Unit.Core.decompose opp_core in
    let lat_res = rget_lat g rid in 
    rset_lat g rid (Resource.subtract lat_res opp_res); 
 
    let my_core_upd2, opp_core_upd2, leftovers_to_dissolve =
      if Unit.Core.is_alive my_core_upd && not (Unit.Core.is_alive opp_core_upd) then 
        digest_core my_core_upd opp_core_upd
      else
        (my_core_upd, opp_core_upd, [])
    in
    
    let res_to_dissolve = List.fold_left 
      (fun res bunch -> Resource.add res (Item.decompose_bunch bunch)) 
      Resource.zero leftovers_to_dissolve in

    dissolve_lat_res g rid res_to_dissolve;

    (g, astr) 
    |> update_rid_actor_g_astr rid (Actor.update_core my_core_upd2 a)
    |> update_rid_core_g_astr rid opp_core_upd2
  )
  else
    (g, astr)


(* Scenario - meet another actor *)
let scenario_meet_an_actor pol a opp_actor (g,astr) =
  let rid = Actor.get_rid a in
  let my_core = Actor.get_core a in
  let opp_core = Actor.get_core opp_actor in
  if will_we_fight pol my_core opp_core then
    let (my_core_upd, opp_core_upd) = fake_fight my_core opp_core in
   
    let my_core_upd2, opp_core_upd2, leftovers_to_dissolve = 
      if Unit.Core.is_alive my_core_upd && not (Unit.Core.is_alive opp_core_upd) then 
        digest_core my_core_upd opp_core_upd
      else if not (Unit.Core.is_alive my_core_upd) && (Unit.Core.is_alive opp_core_upd) then 
        ( let x,y,z = digest_core opp_core_upd my_core_upd in (y,x,z) )
      else
        (my_core_upd, opp_core_upd, [])
    in
  
    let res_to_dissolve = List.fold_left 
      (fun res bunch -> Resource.add res (Item.decompose_bunch bunch)) 
      Resource.zero leftovers_to_dissolve in

    dissolve_lat_res g rid res_to_dissolve;

    (g, astr) 
    |> update_rid_actor_g_astr rid (Actor.update_core my_core_upd2 a)
    |> update_rid_actor_g_astr rid (Actor.update_core opp_core_upd2 opp_actor)
  else
    (* is he a trader? *)
    match Actor.get_cl opp_actor, Actor.get_cl a with
    | Actor.Merchant opp_tr, Actor.Merchant _ -> 
        (g, astr)
    | Actor.Merchant opp_tr, _ ->
        (* move money to Trader *)
        ( match Inv.get_bunch Inv.default_coins_container Item.Cnt.default_coins_slot (UC.get_inv opp_core) with
          | Some (money_bunch, opp_inv) when money_bunch.Item.Cnt.item.barcode = Item.Coll.coin_barcode  ->
             
              let opp_core = UC.upd_inv opp_inv opp_core in
              let opp_tr = Trade.exchange [] [money_bunch] opp_tr in

              let coin = money_bunch.item in
              
              (* trade *)
              let opp_tr, my_core = Simtrade.barter_with opp_tr my_core in
              
              (* put money back *)
              let opp_core, opp_tr = Trade.move_money_from_tr_to_core (opp_core, opp_tr) in

              (g, astr) 
              |> update_rid_actor_g_astr rid (a |> Actor.update_core my_core)
              |> update_rid_actor_g_astr rid (opp_actor |> Actor.update_core opp_core |> Actor.update_cl (Actor.Merchant opp_tr))


          | _ -> (g, astr)
        )
    | _ -> (g, astr)
 
type encounter = Enc_Local | Enc_Actor | Enc_Exit | Enc_Nothing

(* Sample an encounter for the actor a *)
let sample_encounter a (g,astr) (x_lat, x_act, x_exit, x_nothing) =
  let rid = Actor.get_rid a in
  let facnum = fnum g in
  (* 0 *)
  let num_lat_pop = fold_lim (fun acc fac -> acc + fget_lat g rid fac) 0 0 (facnum-1) in
  (* 1 *)
  let num_lat_actors = Astr.get_actors_num_at rid astr in
  let nb_rid_ls = G.get_only_nb_rid_ls rid g in
  (* 2 *)
  let num_exits = List.length nb_rid_ls in
  (* 3 *) 
  let num_nothing = 1 in

  let p_lat = float num_lat_pop *. x_lat in
  let p_act = float num_lat_actors *. x_act in
  let p_exit = float num_exits *. x_exit in
  let p_nothing = float num_nothing *. x_nothing in

  (* choose one event *)
  let sum = p_lat +. p_act +. p_exit +. p_nothing in
  if sum > 0.00001 then
  ( let prob_ls = 
    [ Enc_Local, p_lat /. sum; 
      Enc_Actor, p_act /. sum; 
      Enc_Exit, p_exit /. sum; 
      Enc_Nothing, p_nothing /. sum ] in
    Some (any_from_prob_ls prob_ls)
  )
  else
    None

(* Main adventurer simulation function *)
let sim_adventurer pol a (g, astr) =
  match sample_encounter a (g,astr) (1.0, 1.0, 1.0, 5.0) with
  | Some x ->
    let rid = Actor.get_rid a in
    let rm = g.G.rm.(rid) in
    ( match x with
      | Enc_Local ->
          (* encounter a local inhabitant *)
          ( match get_random_unit_core pol rm with
            | Some (opp_core, _) ->
                scenario_meet_a_local pol a opp_core (g,astr)
            | None -> (g, astr)
          )
      | Enc_Actor ->
          (* encounter an actor (active NPC) *)
          ( match Astr.get_random_from rid astr with
            | Some opp_actor when Actor.get_aid opp_actor <> Actor.get_aid a ->
                scenario_meet_an_actor pol a opp_actor (g,astr)
            | _ -> (g, astr) 
          )
      | Enc_Exit ->
          (* found an exit *)
          let nb_rid_ls = G.get_only_nb_rid_ls rid g in
          ( match any_from_ls nb_rid_ls with
            | Some nb_rid ->
                (g, astr) |> transfer_actor a nb_rid 
            | None ->
                (g, astr)
          )
      | Enc_Nothing ->
          (g, astr)
    )
  | None -> (g, astr)

(* Merchant simulation function *)
let sim_merchant pol a (g, astr) =
  match sample_encounter a (g,astr) (1.0, 1.0, 1.0, 5.0) with
  | Some x ->
    let rid = Actor.get_rid a in
    let rm = g.G.rm.(rid) in
    ( match x with
      | Enc_Local ->
          (* encounter a local inhabitant *)
          ( match get_random_unit_core pol rm with
            | Some (opp_core, _) ->
                scenario_meet_a_local pol a opp_core (g,astr)
            | None -> (g, astr)
          )
      | Enc_Actor ->
          (* encounter an actor (active NPC) *)
          ( match Astr.get_random_from rid astr with
            | Some opp_actor when Actor.get_aid opp_actor <> Actor.get_aid a ->
                scenario_meet_an_actor pol a opp_actor (g,astr)
            | _ -> (g, astr) 
          )
      | Enc_Exit ->
          (* found an exit *)
          let rid_has_market rid = RM.has_market g.G.rm.(rid) in

          let eval_friendliness rid =
            let fac_self = Unit.Core.get_fac (Org.Actor.get_core a) in
            let facnum = pol.Pol.facnum in
            fold_lim (fun sum fac -> sum +. float (fget g rid fac) *. (pol.Pol.rel_like.(fac_self).(fac)) ) 0.0 0 (facnum-1)
          in

          if rid_has_market rid then
            (* there is a market - stay *)
            (g, astr)
          else
            (* no market - leave *)
            let nb_rid_ls = G.get_only_nb_rid_ls rid g in
            let opt_rid =
              match List.filter rid_has_market nb_rid_ls with
              | [] -> any_from_ls nb_rid_ls
              | ls -> 
                  let ls = ls |> List.map (fun rid -> (rid, eval_friendliness rid)) |> List.filter (fun (_,v) -> v > 0.0) in
                  if ls <> [] then Some (any_from_rate_ls ls) else None
            in
            ( match opt_rid with
              | Some nb_rid ->
                  (g, astr) |> transfer_actor a nb_rid 
              | None ->
                  (g, astr)
            )
      | Enc_Nothing ->
          (g, astr)
    )
  | None -> (g, astr)

let heal a =
  Actor.update_core (Unit.Core.heal 20.0 (Actor.get_core a)) a

(* Dispatch *)  
let sim_one pol a ga =
  let a = heal a in
  match a.Actor.cl with
  | Actor.Merchant _ -> sim_merchant pol a ga
  | _ -> sim_adventurer pol a ga


let run accept_prob pol (geo, astr) = 
  let num = Astr.get_actors_num astr in
  (*
  Printf.printf "actors: %i\n%!" num;
  *)

  (* count factions *)
  let arr_a = Array.make pol.Pol.facnum 0 in
  let arr_m = Array.make pol.Pol.facnum 0 in
  Ma.iter (fun aid a -> 
    let fac = a |> Actor.get_core |> Unit.Core.get_faction in
    match Actor.get_wcl a with
    | Actor.WC_Adventurer -> arr_a.(fac) <- arr_a.(fac) + 1
    | _ -> arr_m.(fac) <- arr_m.(fac) + 1
  ) astr.ma;
  for fac = 0 to pol.Pol.facnum-1 do
    Printf.printf "%i.\ta=%i\tm=%i\n%!" fac arr_a.(fac) arr_m.(fac)
  done;
  Printf.printf "\n";

  let simnum = round_prob (float num *. accept_prob) in

  fold_lim (fun ((acc_geo, acc_astr) as acc) _ -> 
    match Astr.get_random acc_astr with 
      Some a -> sim_one pol a acc 
    | None -> acc
  ) (geo, astr) 1 simnum
