(* Sim Org *)
open Base
open Common
open Org
open Global

let alternative_cores core item =
  let inv = core.Unit.Core.inv in
  let def_ci = 0 in

  let mk c = {core with Unit.Core.inv = Inv.({inv with cnt = Item.M.add def_ci c inv.cnt})} in

  match Inv.container def_ci inv with
  | Some cnt ->
      let initial_ls = 
        match Item.Cnt.put item cnt with
          Some cnt -> [(mk cnt, [])]
        | _ -> [] in

      (* remove one item, put the given item instead *)
      let alt_cores_ls =
        Item.Cnt.fold (fun acc si _ ->
          match Item.Cnt.get si cnt with
            Some (removed_item, cnt') -> 
              ( match Item.Cnt.put item cnt' with
                  Some cnt'' -> (mk cnt'', [removed_item]) :: acc
                | _ -> acc
              )
          | None -> acc
        ) initial_ls cnt.Item.Cnt.item in
      alt_cores_ls
  | None ->
      []

let eval_quick c1 c2 = 
  let str1 = Unit.Core.approx_strength c1 in
  let str2 = Unit.Core.approx_strength c2 in
  str1 > str2

let eval_slow c1 c2 =
  let uc1, uc2 = fake_fight c1 c2 in
  Unit.Core.get_hp uc1 > Unit.Core.get_hp uc2 

(* try to put on the given item
 *
 * returns a tuple (best core, list of the items to drop)  *)
let try_item_eval eval_better core item =
  let alt_ls = alternative_cores core item in
  List.fold_left 
    (fun (bc, bls) (c,ls) -> 
      if eval_better c bc then (c,ls) else (bc,bls)
    ) 
    (core,[item]) alt_ls

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
let digest_core my_core opp_core = 
  let items_ls = Unit.Core.items_ls opp_core in
  let my_core', leftovers =  
    List.fold_left (fun (acc_core, acc_leftovers) item -> 
        let core, drop_items_ls = try_item_eval eval_slow acc_core item in
        (core, List.rev_append drop_items_ls acc_leftovers)
      ) 
    (my_core, []) items_ls in
  ( my_core', 
    {opp_core with Unit.Core.inv = Inv.remove_everything (Unit.Core.get_inv opp_core)},
    leftovers )

(* transfer the actor *)
let transfer_actor a nrid (g, astr) =
  match Prio.get nrid g.G.prio with
    Some nreg ->
      (* Don't let it move into the simulated region *)
      (g, astr)
  | None ->
      let a_upd = Actor.({a with rid = nrid}) in
      (g, astr |> Astr.update a_upd)


(* Main adventurer simulation function *)
let sim_adventurer pol a (g, astr) =
  let rid = Actor.get_rid a in
  let facnum = fnum g in
  (* 1 *)
  let num_lat_pop = fold_lim (fun acc fac -> acc + fget_lat g rid fac) 0 0 (facnum-1) in
  (* 2 *)
  let num_lat_actors = Astr.get_actors_num_at rid astr in
  let nb_rid_ls = G.get_only_nb_rid_ls rid g in
  (* 3 *)
  let num_exits = List.length nb_rid_ls in
  
  let rm = g.G.rm.(rid) in

  (* choose one event *)
  let sum = (num_lat_pop + num_lat_actors + num_exits) in
  if sum > 0 then
  ( let fsum = float sum in
    
    let prob_ls = 
      [ 0, float num_lat_pop /. fsum; 
        1, float num_lat_actors /. fsum; 
        2, float num_exits /. fsum; ] in

    let x = any_from_prob_ls prob_ls in
    match x with
    | 0 ->
        (* encounter a local inhabitant *)
        ( match get_random_unit_core pol rm with
          | Some (opp_core, _) ->
            ( let my_core = Actor.get_core a in
              if will_we_fight pol my_core opp_core then
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
                  (fun res item -> Resource.add res (Item.decompose item)) 
                  Resource.zero leftovers_to_dissolve in

                dissolve_lat_res g rid res_to_dissolve;

                (g, astr) 
                |> update_rid_actor_g_astr rid (Actor.update_core a my_core_upd2)
                |> update_rid_core_g_astr rid opp_core_upd2
              else
                (g, astr)
            )
          | None -> (g, astr)
        )
    | 1 ->
        (* encounter an actor (active NPC) *)
        ( match  Astr.get_random_from rid astr with
          | Some opp_actor when Actor.get_aid opp_actor <> Actor.get_aid a ->
              let my_core = Actor.get_core a in
              let opp_core = Actor.get_core opp_actor in
              ( if will_we_fight pol my_core opp_core then
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
                    (fun res item -> Resource.add res (Item.decompose item)) 
                    Resource.zero leftovers_to_dissolve in

                  dissolve_lat_res g rid res_to_dissolve;

                  (g, astr) 
                  |> update_rid_actor_g_astr rid (Actor.update_core a my_core_upd2)
                  |> update_rid_actor_g_astr rid (Actor.update_core opp_actor opp_core_upd2)
                else
                  (g, astr)
              )
          | _ -> (g, astr) 
        )
    | _ ->
        (* found an exit *)
        ( match any_from_ls nb_rid_ls with
          | Some nb_rid ->
              (g, astr) |> transfer_actor a nb_rid 
          | None ->
              (g, astr)
        )    
    | _ -> (g,astr)
  )
  else
    (g, astr)



(* Dispatch *)  
let sim_one pol a ga =
  match a.Actor.cl with
    _ -> sim_adventurer pol a ga


let run accept_prob pol (geo, astr) = 
  let num = Astr.get_actors_num astr in

  let simnum = round_prob (float num *. accept_prob) in

  fold_lim (fun ((acc_geo, acc_astr) as acc) _ -> 
    match Astr.get_random acc_astr with 
      Some a -> sim_one pol a acc 
    | None -> acc
  ) (geo, astr) 0 simnum
