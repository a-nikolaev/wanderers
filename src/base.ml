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


