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
open Item

type t = {cnt: Cnt.t M.t; limit: int}

(* put an object obj into the container #ci *)
let put obj ci inv =
  if M.mem ci inv.cnt then
    let c = M.find ci inv.cnt in
    match Cnt.put obj c with
      Some c' -> Some {inv with cnt = M.add ci c' inv.cnt}
    | None -> None
  else
    None

(* try to put in any available container *)
let put_somewhere obj inv =
  let new_ci_c_opt =
    M.fold (fun ci c acc -> 
        match acc with 
          None -> 
            ( match Cnt.put obj c with 
                Some c' -> Some (ci, c') 
              | None -> None
            )
        | _ -> acc
      )
      inv.cnt None
  in
  match new_ci_c_opt with
    Some (ci,c) -> Some {inv with cnt = M.add ci c inv.cnt}
  | None -> None

(* try to put in any available container *)
let put_somewhere_bunch bunch inv =
  let remaining, new_ci_c_list =
    M.fold (fun ci c (opt_bunch, ls) -> 
        match opt_bunch with
        | Some bunch -> 
          ( match Cnt.put_bunch bunch c with 
            | Item.Cnt.MoveBunchSuccess c' -> (None, (ci, c') :: ls)
            | Item.Cnt.MoveBunchPartial (b', c') -> (Some b', (ci, c') :: ls)
            | Item.Cnt.MoveBunchFailure -> (Some bunch, ls)
          )
        | _ -> (opt_bunch, ls)
      )
      inv.cnt (Some bunch, [])
  in
  match new_ci_c_list with
  | [] -> Item.Cnt.MoveBunchFailure
  | ls -> 
      let inv_upd = List.fold_left (fun inv_acc (ci,c) -> {inv_acc with cnt = M.add ci c inv_acc.cnt}) inv ls in
      ( match remaining with 
        | Some b -> Item.Cnt.MoveBunchPartial (b, inv_upd)
        | None -> Item.Cnt.MoveBunchSuccess inv_upd
      )

(* get an object from the container #ci, slot si *)
let get ci si inv =
  if M.mem ci inv.cnt then
    let c = M.find ci inv.cnt in
    match Cnt.get si c with
      Some (obj, c') -> Some (obj, {inv with cnt = M.add ci c' inv.cnt})
    | None -> None
  else
    None

(* get a bunch from the container #ci, slot si *)
let get_bunch ci si inv =
  if M.mem ci inv.cnt then
    let c = M.find ci inv.cnt in
    match Cnt.get_bunch si c with
      Some (obj, c') -> Some (obj, {inv with cnt = M.add ci c' inv.cnt})
    | None -> None
  else
    None

(* examine an object from the container #ci, slot si *)
let examine ci si inv =
  if M.mem ci inv.cnt then
    let c = M.find ci inv.cnt in
    Cnt.examine si c
  else
    None

let container ci inv =
  if M.mem ci inv.cnt then
    Some (M.find ci inv.cnt)
  else
    None

let upd_container ci cnt inv = if ci < inv.limit then {inv with cnt = M.add ci cnt inv.cnt} else inv

let fold f acc inv =
  M.fold (fun ci c acc -> 
      M.fold (fun si bunch acc -> f acc ci si bunch) c.Cnt.bunch acc
  ) inv.cnt acc

let decompose inv =
  fold (fun acc _ _ bunch -> 
    Resource.add acc (Item.decompose_bunch bunch)
  ) Resource.zero inv

let remove_everything inv =
  let cnt' =
    M.map (fun c -> Item.Cnt.remove_everything c) inv.cnt in
  {inv with cnt = cnt'}


let default_coins_container = 0 
let default = 
  {cnt = map_of_list [(0, Cnt.empty_nat_human); (1, Cnt.empty_unlimited)]; limit = 4}

let animal = 
  {cnt = M.empty; limit = 0}

let slime = 
  {cnt = map_of_list [(1, Cnt.empty_only_money)]; limit = 2}

let ground =
  {cnt = map_of_list [(0, Cnt.empty_unlimited)]; limit = 1}

(* compact containers satisfying condition *)
let compact condition inv =
  let cnt_upd = 
    M.fold 
      ( fun ci c acc -> 
          let c_upd = if condition ci c then Item.Cnt.compact c else c in
          M.add ci c_upd acc
      )
      inv.cnt
      M.empty
  in
  {inv with cnt = cnt_upd}

let compact_simple inv = compact (fun x _ -> x <> 0) inv

(* function for optional ground inventories *)
let ground_drop obj optinv =
  let inv = 
    match optinv with
      Some inv -> inv
    | _ -> ground
  in
  match put_somewhere obj inv with
    Some inv' -> Some (Some inv')
  | None -> None

let raw_ground_drop_bunch bunch optinv =
  let inv = 
    match optinv with
      Some inv -> inv
    | _ -> ground
  in
  match put_somewhere_bunch bunch inv with
    Item.Cnt.MoveBunchSuccess inv' -> Some inv'
  | _ -> failwith "ground_drop_bunch failure"

let ground_pickup ci ii optinv =
  match optinv with
  | Some ginv -> 
      ( match get ci ii ginv with
          Some (obj,ginv') -> 
            let upd_optinv = if M.is_empty ginv'.cnt then None else Some ginv' in
            Some (obj, upd_optinv)
        | None -> None )
  | _ -> None

let ground_drop_all invsrc optinv =
  let invdst = match optinv with
    Some inv -> inv
  | None -> ground
  in  
  let invleftovers = 
    {cnt = M.map (fun cnt -> Cnt.({bunch=M.empty; slot=cnt.slot; caplim=cnt.caplim})) invsrc.cnt; limit = invsrc.limit} in
  let cd = M.find 0 invdst.cnt in
  let invleft_final, cd_final =
    M.fold (fun ics cs (invleftovers, cd) -> 
        let cs1, cd1 = Cnt.put_all cs cd in
        ({invleftovers with cnt = M.add ics cs1 invleftovers.cnt}, cd1)
      ) invsrc.cnt (invleftovers, cd) in
  (invleft_final, Some ({invdst with cnt = M.add 0 cd_final invdst.cnt}))

