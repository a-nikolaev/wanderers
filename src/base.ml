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

let rec fold_lim f a x xl = if x <= xl then fold_lim f (f a x) (x+1) xl else a
let rec filtermap pred map = function
  | hd::tl when pred hd -> map hd :: filtermap pred map tl
  | _::tl -> filtermap pred map tl
  | [] -> []

let ( |> ) x f = f x

type loc = int * int
type vec = float * float

let vec_of_loc (i,j) = (float i, float j)
let loc_of_vec (x,y) = (int_of_float (floor (x+.0.5)), int_of_float (floor (y+.0.5)))

let loc_of_vec_away_from_zero (x,y) =
  let ij = loc_of_vec (x,y) in
  match ij with
  | (1,0) | (-1,0) | (0,1) | (0,-1) -> ij
  | _ ->
      if abs_float x > abs_float y then 
        ( if x > 0.0 then (1, 0) else (-1, 0) )
      else
        ( if y > 0.0 then (0, 1) else (0, -1) )

let vec_len2 (x,y) = x*.x +. y*.y
let vec_len (x,y) = sqrt(x*.x +. y*.y)

let vec_dot_prod (x1,y1) (x2,y2) = x1*.x2 +. y1*.y2

let loc_manhattan (x,y) = abs x + abs y
let loc_infnorm (x,y) = max (abs x) (abs y)

let ( ++ ) (x1,y1) (x2,y2) = (x1+x2, y1+y2)
let ( -- ) (x1,y1) (x2,y2) = (x1-x2, y1-y2)
let ( %% ) c (x,y) = (c*x, c*y) (* multiply *)

let ( ++. ) (x1,y1) (x2,y2) = (x1+.x2, y1+.y2)
let ( --. ) (x1,y1) (x2,y2) = (x1-.x2, y1-.y2)
let ( %%. ) c (x,y) = (c*.x, c*.y) (* multiply *)
let ( //. ) (x,y) c = (x/.c, y/.c) (* divide *)

module Dir8 = struct
  type t = E | NE | N | NW | W | SW | S | SE
  let z = 0.9239 
  let mz = -0.9239 
  let of_vec v = 
    let x,y = (1.0 /. vec_len v) %%. v in
    if x > z then E else if x < mz then W
    else if y > z then N else if y < mz then S
    else if x > 0.0 then (if y > 0.0 then NE else SE)
    else (if y > 0.0 then NW else SW)

  let inv_sqrt_2 = 1.0 /. sqrt 2.0
  let pos = inv_sqrt_2
  let neg = -.inv_sqrt_2

  let to_unit_vec = function
    | E -> 1.0, 0.0
    | NE -> pos, pos
    | N -> 0.0, 1.0
    | NW -> neg, pos
    | W -> -1.0, 0.0
    | SW -> neg, neg
    | S -> 0.0, -1.0
    | SE -> pos, neg
    
end

let any_from_ls ls = 
  let len = List.length ls in
  if len > 0 then
    Some (List.nth ls (Random.int len))
  else
    None

let any_from_prob_ls ls = 
  let rec next x = function  
    | (v,p)::tl when x < p -> v 
    | (v,p)::[] -> v
    | (v,p)::tl -> next (x-.p) tl
    | [] -> failwith "list is empty"
  in
  next (Random.float 1.0) ls

let any_from_rate_ls ls = 
  let sum = List.fold_left (fun acc (_, r) -> acc +. r) 0.0 ls in
  let rec next x = function  
    | (v,r)::tl when x < r -> v 
    | (v,_)::[] -> v
    | (v,r)::tl -> next (x-.r) tl
    | [] -> failwith "list is empty"
  in
  next (Random.float sum) ls

let round_prob xf =
  let z = int_of_float (floor xf) in
  let dz = if Random.float 1.0 < xf -. float z then 1 else 0 in
  z + dz

let round xf =
  int_of_float (floor (0.5 +. xf))

let array_permute a =
  let len = Array.length a in
  for i = 0 to len-1 do
    let j1 = Random.int len in
    let j2 = Random.int len in
    let t = a.(j1) in
    a.(j1) <- a.(j2);
    a.(j2) <- t
  done

(* Bin Weighted Counter - for log-time random selection/update *)
module Bwc = struct
  type t = {sum: float array; cur: float array; total: float}

  (* 8 -> 9 -> 11 -> 15 -> 31 -> ... *)
  let rec next x = if x land 1 = 1 then ((next (x asr 1)) lsl 1 + 1) else x + 1 
  
  let make size = {sum = Array.make size 0.0; cur = Array.make size 0.0; total = 0.0 }

  let rec propagate bwc i wg =
    bwc.sum.(i) <- bwc.sum.(i) +. wg;
    let i' = next i in
    if i' < Array.length bwc.sum then
      propagate bwc i' wg 

  let add i wg bwc = 
    bwc.cur.(i) <- bwc.cur.(i) +. wg;
    propagate bwc i wg;
    {bwc with total = bwc.total +. wg}

  (* locate the bin containing x *)
  let binary_search bwc x =
    let top = Array.length bwc.sum in

    let rec search x di =
      if di < top then
      ( let (i, wg) = search x (di lsl 1 + 1) in
        let i' = (i + 1) lor di in
        if i' < top then
        ( let wg' = wg +. bwc.sum.(i') in
          if wg' -. bwc.cur.(i') < x then
            (i', wg')
          else
            (i, wg)
        ) 
        else
          (i, wg)
      )
      else
        (0, 0.0)
    in
    fst(search x 0)

  let random bwc = binary_search bwc (Random.float bwc.total)
end

module Resource = struct
  type t = {wealth:int}

  let make w = {wealth=w}

  let zero = {wealth = 0}

  let add {wealth=w1} {wealth=w2} = {wealth=w1+w2}
  let subtract {wealth=w1} {wealth=w2} = {wealth=w1-w2}

  let scale c {wealth} = {wealth = (c *. float wealth) |> round_prob}
  
  let times c {wealth} = {wealth = c * wealth}
  
  let intersection {wealth=w1} {wealth=w2} = {wealth = min w1 w2}

  let lesseq r1 r2 = 
    r1.wealth <= r2.wealth

  let numeric {wealth} = wealth
end


