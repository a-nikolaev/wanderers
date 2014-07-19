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

let any_from_ls ls = 
  let len = List.length ls in
  if len > 0 then
    Some (List.nth ls (Random.int len))
  else
    None

let any ls = 
  match any_from_ls ls with
    Some x -> x
  | _ -> raise Not_found

let any_from_rate_ls ls =
  let sum = List.fold_left (fun acc (r,_) -> acc+.r) 0.0 ls in
  let rec next x = function  
    | (r,v)::tl when x < r -> Some v 
    | (r,v)::[] -> Some v
    | (r,v)::tl -> next (x-.r) tl
    | [] -> None
  in
  next (Random.float sum) ls

let round_prob xf =
  let z = int_of_float (floor xf) in
  let dz = if Random.float 1.0 < xf -. float z then 1 else 0 in
  z + dz

let round xf =
  int_of_float (floor (0.5 +. xf))

type loc = int * int

let loc_manhattan (x,y) = abs x + abs y
let loc_infnorm (x,y) = max (abs x) (abs y)

let ( ++ ) (x1,y1) (x2,y2) = (x1+x2, y1+y2)
let ( -- ) (x1,y1) (x2,y2) = (x1-x2, y1-y2)
let ( %% ) c (x,y) = (c*x, c*y) (* multiply *)

let array_any arr = arr.(Random.int (Array.length arr))

type sym = char

type 'a merging = Merge of 'a | First of 'a | Second of 'a | Unc | Conflict

let merged = function 
  | Merge a | First a | Second a -> Some a
  | _ -> None


type info = {
  joint: sym->bool; 
  door: sym->bool; 
  floor: sym->bool; 
  gen: sym->sym;
  merge: sym option -> sym option -> sym merging;
  after: sym -> sym;
  afterb: sym -> sym;
}

module Instr = struct
  type group = sym array
  type t =
    | Include of string
    | Joint of group
    | Door of group
    | Floor of group
    | Gen of group * group
    | Merge of sym * sym * group
    | After of group * group
    | AfterB of group * group
    | Comment

  type data = {  
    joint: bool array;
    door: bool array;
    floor: bool array;
    gen: (sym, group) Hashtbl.t;
    after: (sym, group) Hashtbl.t;
    afterb: (sym, group) Hashtbl.t;
    merge: (sym*sym, group) Hashtbl.t;
  }

  let make_empty () = {
    joint = Array.make 256 false;
    door = Array.make 256 false;
    floor = Array.make 256 false;
    gen = Hashtbl.create 8;
    after = Hashtbl.create 8;
    afterb = Hashtbl.create 8;
    merge = Hashtbl.create 8;
  }

  let add_instr x = function
    | Joint g -> Array.iter (fun c -> x.joint.(Char.code c) <- true ) g
    | Floor g -> Array.iter (fun c -> x.floor.(Char.code c) <- true ) g
    | Door g -> Array.iter (fun c -> x.door.(Char.code c) <- true ) g
    | Gen (g1, g2) -> Array.iter (fun c -> Hashtbl.replace x.gen c g2 ) g1
    | After (g1, g2) -> Array.iter (fun c -> Hashtbl.replace x.after c g2 ) g1
    | AfterB (g1, g2) -> Array.iter (fun c -> Hashtbl.replace x.afterb c g2 ) g1
    | Merge (a, b, g) -> Hashtbl.replace x.merge (a,b) g
    | _ -> ()

end

let make_info x = 
  { 
    joint = ( fun c -> x.Instr.joint.(Char.code c) );
    door = ( fun c -> x.Instr.door.(Char.code c) );
    floor = ( fun c -> x.Instr.floor.(Char.code c) );
    gen = ( fun c -> try Hashtbl.find x.Instr.gen c |> array_any with Not_found -> c );
    after = ( fun c -> try Hashtbl.find x.Instr.after c |> array_any with Not_found -> c );
    afterb = ( fun c -> try Hashtbl.find x.Instr.afterb c |> array_any with Not_found -> c );
    merge = 
      ( fun o1 o2 ->
          match o1, o2 with
          | Some a, Some b -> 
              ( try 
                  let arr = Hashtbl.find x.Instr.merge (a,b) in
                  if Array.length arr > 0 then Merge (array_any arr)
                  else Conflict
                with 
                  Not_found -> 
                    if a = b then Merge a else Conflict
              )
          | Some a, None -> First a
          | None, Some a -> Second a
          | None, None -> Unc
      ) 
  }

module Parse = struct
  let group_of_string s = 
    Array.init (String.length s) (fun i -> s.[i])

  let read s =
    let rx = Str.regexp "[ \t\r\n\012]+" in
    
    if String.length s <= 0 || s.[0] = '@' then Instr.Comment
    else
    ( let ls = Str.split rx s in
      let f = group_of_string in
      match ls with
      | "include" :: path :: _ -> Instr.Include path
      | "joint" :: g :: _ -> Instr.Joint (f g)
      | "door" :: g :: _ -> Instr.Door (f g)
      | "floor" :: g :: _ -> Instr.Floor (f g)
      | "gen" :: g1 :: "=" :: g2 :: _ -> Instr.Gen (f g1, f g2)
      | "a" :: g1 :: "=" :: g2 :: _ -> Instr.After (f g1, f g2)
      | "b" :: g1 :: "=" :: g2 :: _ -> Instr.AfterB (f g1, f g2)
      
      | "+" :: g1 :: g2 :: "=" :: g3 :: _ when String.length g1 = 1 && String.length g2 = 1 -> Instr.Merge (g1.[0], g2.[0], f g3)
      | "+" :: g1 :: g2 :: "=" :: [] when String.length g1 = 1 && String.length g2 = 1 -> Instr.Merge (g1.[0], g2.[0], f "")

      | _ -> failwith ("Parsing error: " ^ s )
    )
end
