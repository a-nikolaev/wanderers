
open Base

type mat = Wood | Bronze | Iron | Steel | Damascus_Steel | Paper

type eff = [ `Heal ]

(* unified quality measure *)
type qm = float
let qm_min = 0.0 (* extremely bad, poor quality *)
let qm_max = 1.0 (* perfect, flawless *)

module Ranged = struct
  type t = {force: float; projmass: float; dmgmult: float}
end

module Melee = struct
  type t = {attrate: float; duration: float;}

  let join {attrate=ar1; duration=d1} {attrate=ar2; duration=d2} = 
    {attrate=ar1 +. ar2; duration = max d1 d2}
end

type prop = [ `Melee of Melee.t | `Defense of float | `Weight of float | `Material of mat 
  | `Consumable of eff | `Wearable | `Wieldable | `Quality of qm | `Ranged of Ranged.t]

module PS = Set.Make(struct type t = prop let compare = compare end)
type t = { name: string; prop: PS.t; imgindex:int; price: int; }

type item_type = t

(* item obj has property p*)
let is p obj = PS.mem p obj.prop

let get_melee obj =
  PS.fold (fun prop acc -> 
      match prop with
        `Melee x -> Some x 
      | _ -> acc
    ) obj.prop None

let get_defense obj =
  PS.fold (fun prop acc -> 
      match prop with
        `Defense x -> acc +. x 
      | _ -> acc
    ) obj.prop 0.0

let get_ranged obj =
  PS.fold (fun prop acc -> 
      match prop with
        `Ranged x -> Some x 
      | _ -> acc
    ) obj.prop None

let get_mass obj = 
  PS.fold (fun prop acc -> 
      match prop with
        `Weight x -> acc +. x 
      | _ -> acc
    ) obj.prop 0.0

let is_wearable obj = PS.mem `Wearable obj.prop
let is_wieldable obj = PS.mem `Wieldable obj.prop

(* integer map *)
module M = Map.Make(struct type t = int let compare = compare end)

let map_of_list ls = 
  List.fold_left (fun acc (key,obj) -> M.add key obj acc) M.empty ls

(* container *)
module Cnt = struct
  type slot_type = General | Hand | Body
  
  let does_fit slt obj = match slt with
    | General -> true
    | Hand -> is `Wieldable obj
    | Body -> is `Wearable obj
 
  type t = {item : item_type M.t; slot: slot_type M.t; caplim: int option;}

  let make slot caplim =
    {item = M.empty; slot; caplim}

  let empty_nat_human = 
    let ls = [(0,Hand); (1,Body); (2,Hand)] in
    let len = List.length ls in
    make (map_of_list ls) (Some len)
 
  let empty_unlimited = make M.empty None

  let find_empty_slot pred c = 
    let rec search i =
      let enough_space = 
        match c.caplim with
          | Some lim -> i < lim | None -> true in
      
      if enough_space then
      ( if not (M.mem i c.item) && 
          (not (M.mem i c.slot) || pred (M.find i c.slot)) then
          Some i
        else
          search (i+1)
      )
      else
        None 
      
    in
    search 0

  let put obj c = 
    match find_empty_slot (fun slt -> does_fit slt obj) c with
      Some i ->
        Some {c with item = M.add i obj c.item}
    | None -> 
        None

  let get i c = 
    if M.mem i c.item then 
      let obj = M.find i c.item in
      Some (obj, {c with item = M.remove i c.item})
    else
      None
  
  (* move everything (as much as possible) from csrc to cdst *)
  let put_all csrc cdst =
    let rec next leftovers cs cd =
      if M.is_empty cs.item then (leftovers, cd)
      else 
      ( let i, obj = M.choose cs.item in
        let cs1 = { cs with item = M.remove i cs.item } in 
        match put obj cd with
          Some cd1 -> next leftovers cs1 cd1
        | None -> 
            ( match put obj leftovers with
              | Some lo -> next lo cs1 cd
              | _ -> failwith "Cnt.put_all : cannot fit an object into the leftovers container" )
      )
    in 
    let leftovers = {item = M.empty; slot = csrc.slot; caplim = csrc.caplim} in
    next leftovers csrc cdst
  
  let examine i c = 
    if M.mem i c.item then 
      let obj = M.find i c.item in
      Some obj
    else
      None
  let fold f acc c =
    M.fold (fun si obj acc -> f acc si obj) c acc

  let remove_everything c = 
    {c with item = M.empty}

end

(* Collection of objects *)
module Coll = struct

  let index kind size = kind * 8 + size
  let stdprice size = max 1 (int_of_float (2.0 *. (4.0 ** float size)))

  let cheap_price = 6

  let random opt_kind =
    let kind = match opt_kind with None -> Random.int 7 | Some x -> x in
    let melee x d =
      `Melee Melee.({attrate=x+.1.0; duration = (2.0 -. 1.0/.(x+.1.0) +. 0.1 *. x) *. d;}) in
    let sword_weight s = 0.5 +. 0.09375 *. (s*.s) in
    match kind with
      0 -> (* sword *)
        (* knife, dagger, short sword, broad sword, long sword (first two-handed), great sword, x, y*)
        let size = Random.int 8 in
        let price = stdprice size in
        let s = float size in
        (* 2kg for a long (two-handed sword) *)
        (* let weight = 0.5 +. 1.5 *. 0.25 *. 0.25 *. (s*.s) in *)
        let weight = sword_weight s in
        let prop = PS.empty 
          |> PS.add (melee s 1.0) 
          |> PS.add (`Weight (weight)) 
          |> PS.add `Wieldable in
        {name = "Sword-"^(string_of_int size); prop; imgindex = index kind size; price}
    | 1 -> (* rogue sword / sabre *)
        let size = Random.int 8 in
        let price = stdprice size in
        let s = float size in
        let weight = (sword_weight s) *. 1.15 in
        let prop = PS.empty 
          |> PS.add (melee (s *. 1.1) 1.0) 
          |> PS.add (`Weight (weight)) 
          |> PS.add `Wieldable in
        {name = "Swo:rd-"^(string_of_int size); prop; imgindex = index kind size; price}
    | 2 -> (* armor *)
        let size = 1 + Random.int 5 in
        let price = stdprice size in 
        let s = float size in
        let weight = (sword_weight s) *. 6.0 in
        let prop = PS.empty 
          |> PS.add (`Defense (0.05 +. 0.12 *. float size))
          |> PS.add (`Weight (weight)) 
          |> PS.add `Wearable in
        let name = match size with 0 -> "Leather Armor" | 1 -> "Chain mail" | 2 -> "Plated mail" | 3 -> "Laminar armor" | _ -> "Plate armor" in
        {name; prop; imgindex = index kind size; price}
    | 3 -> (* blunt weapons *)
        let size = Random.int 8 in
        let price = stdprice size in
        let s = float size in
        let weight = (sword_weight s) *. 1.2 in
        let prop = PS.empty 
          |> PS.add (melee (s*.1.25) 1.2)
          |> PS.add (`Weight (weight)) 
          |> PS.add `Wieldable in
        {name = "Mace-"^(string_of_int size); prop; imgindex = index kind size; price}
    | 4 -> (* axe *)
        let size = 1 + Random.int 7 in
        let price = stdprice size in
        let s = float size in
        let weight = (sword_weight s) *. 1.3 in
        let prop = PS.empty
          |> PS.add (melee (s*.1.35) 1.3)
          |> PS.add (`Weight (weight)) 
          |> PS.add `Wieldable in
        {name = "Axe-"^(string_of_int size); prop; imgindex = index kind size; price}
    | 5 -> (* shield *)
        let size = 0 + Random.int 8 in
        let price = stdprice size in
        let s = float size in
        let weight = (sword_weight s) *. 1.1 in
        let dd = if size > 1 then 0.05 else 0.0 in
        let prop = PS.empty
          |> PS.add (`Defense (0.08 +. 0.06 *. float size +. dd))
          |> PS.add (`Weight (weight)) 
          |> PS.add `Wieldable in
        let prop = match size with
          | 0 -> PS.add (melee (s*.0.5) 1.5) prop 
          | 1 -> PS.add (melee (s*.0.25) 1.5) prop 
          | _ -> prop in
        {name = "Shield-"^(string_of_int size); prop; imgindex = index kind size; price}
    
    | _ -> (* ranged *)
        let size = Random.int 5 in
        let x = float size in
        let price = stdprice size in
        let s = float size in
        let weight = (sword_weight s) in
        let prop = PS.empty
          |> PS.add (`Ranged Ranged.(
            {force = 0.85 *. (2.0 +. 0.9 *. x); projmass = 0.13 *. (5.0 +. 2.2 *. x); dmgmult = 1.5 *. ( 2.5 +. 0.2 *. x )}))
          |> PS.add (`Weight (weight)) 
          |> PS.add `Wieldable in
        {name = "Ranged-"^(string_of_int size); prop; imgindex = index kind size; price}
end

let decompose obj = Resource.make (obj.price)

