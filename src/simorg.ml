(* Sim Org *)
open Base
open Common
open Org
open Global

let sim_adventurer pol a (g, astr) =
  let rid = a.Actor.rid in
  let facnum = fnum g in
  (* 1 *)
  let num_lat_pop = fold_lim (fun acc fac -> acc + fget_lat g rid fac) 0 0 (facnum-1) in
  (* 2 *)
  let num_lat_actors = Astr.get_actors_num_at rid astr in
  let exits_ls = G.get_nb_ls rid g in
  (* 3 *)
  let num_exits = List.length exits_ls in
  
  let rm = g.G.rm.(rid) in

  (* choose one event *)
  let x = Random.int (num_lat_pop + num_lat_actors + num_exits) in
  if x < num_lat_pop then
    (g, astr)
  else if x < num_lat_pop + num_lat_actors then
    (g, astr)
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
    match Astr.get_random astr with 
      Some a -> sim_one pol a acc
    | None -> acc
  ) (geo, astr) 0 simnum
