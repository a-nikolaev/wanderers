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

open Printf

open Carvebase

module Rect = struct
  type t = {x0:int; y0:int; w:int; h:int}
  let make (x0, y0) w h = {x0; y0; w; h}
  let join r s = 
    let x0 = min r.x0 s.x0 in
    let y0 = min r.y0 s.y0 in
    let x1 = max (r.x0+r.w) (s.x0+s.w) in 
    let y1 = max (r.y0+r.h) (s.y0+s.h) in 
    {x0; y0; w = x1-x0; h = y1-y0}
  
  let displace r (dx,dy) = {r with x0=r.x0+dx; y0=r.y0+dy}

  let is_within r s =
    r.x0 <= s.x0 && r.y0 <= s.y0 && r.x0+r.w >= s.x0+s.w && r.y0+r.h >= s.y0+s.h
end

(* w,h = allocated memory dims;  maxw,maxh = max size of the block *)
type block = {w:int; h:int; maxw:int; maxh:int; rect:Rect.t; data: ((sym option) array) array; joints: loc array}

let block_make w h default = {w; h; maxw=w; maxh=h; rect = Rect.make (0,0) w h; data = Array.make_matrix w h default; joints = [||]}

let block_empty w h = block_make w h None

let block_get b (i,j) =
  if i < 0 || i >= b.w || j < 0 || j >= b.h then None else b.data.(i).(j)

let block_rotate_cw b =
  let v = block_empty b.h b.w in
  let z = b.w-1 in
  for i = 0 to b.w-1 do
    for j = 0 to b.h-1 do
      v.data.(j).(z-i) <- b.data.(i).(j)
    done
  done;
  {v with joints = Array.map (fun (i,j) -> (j,z-i)) b.joints}

let is_on_boundary_func get (i,j) =
  let f ij = match get ij with None -> true | _ -> false in
  f (i-1, j) || f (i+1, j) || f (i, j-1) || f (i, j+1)

let is_on_boundary b = is_on_boundary_func (block_get b) 

(* returns true if the location (i,j) is a joint *)
let is_a_joint info b (i,j) = 
  match block_get b (i,j) with
  | Some sym when info.joint sym -> is_on_boundary b (i,j)
  | _ -> false

let find_all_joints info b =
  let ls = 
    fold_lim (fun acc i ->
      fold_lim (fun acc j ->
        (* printf "[i=%i, j=%i]\n" i j; *)
        if is_a_joint info b (i,j) then (i,j)::acc else acc
      ) acc 0 (b.h-1)
    ) [] 0 (b.w-1)
  in
  Array.of_list ls

let block_randomize info b =
  let v = block_empty b.w b.h in
  for i = 0 to b.w-1 do
    for j = 0 to b.h-1 do
      v.data.(i).(j) <- 
        match b.data.(i).(j) with
        | Some c -> Some (info.gen c) 
        | x -> x
    done
  done;
  {v with 
    joints =
      Array.fold_left 
        (fun acc ij -> if is_a_joint info v ij then ij::acc else acc) [] b.joints
      |> Array.of_list 
  }


 (* 
    block_match_at
    Do the blocks match? Returns ((#matched, #new) option) 
 *)  
let block_match_at info b1 loc1 b2 loc2 = 
  let dd = loc1 -- loc2 in
  
  let rect_join = Rect.join b1.rect (Rect.displace b2.rect dd) in

  if rect_join.Rect.w <= b1.maxw && rect_join.Rect.h <= b1.maxh then
  ( 
    (* loc is the location in the second block *)
    let test loc = info.merge (block_get b1 (loc ++ dd)) (block_get b2 loc) in

    let get loc = loc |> test |> merged in

    match test loc2 with
    | Conflict -> None
    | _ ->
        let validate_if_door (i,j) =
          let t = function Some x when info.floor x -> true | None -> true | _ -> false in
          
          match get (i,j) with
            Some sym when info.door sym -> 
              t ( get (i-1,j) ) && t ( get (i+1,j) ) ||
              t ( get (i,j-1) ) && t ( get (i,j+1) ) 
          | _ -> true
        in

        let rec iter ((matched, added) as acc) (i,j) =
          if j > b2.h then
            Some acc
          else if i > b2.w then 
            iter acc (-1, j+1)
          else
          ( if validate_if_door (i,j) then
            (
              match test (i,j) with
              | Merge _ -> iter (matched + 1, added) (i+1, j)
              | Second _ -> iter (matched, added+1) (i+1, j)
              | First _ | Unc -> iter acc (i+1, j)
              | Conflict -> None
            )
            else
             None
          )
        in

        iter (0,0) (-1,-1)
  )
  else
    None


(* 
    block_merge 
    Merge two blocks. The first is modified in place.
 *)  
module LocSet = Set.Make(struct type t = loc let compare = compare end)

let join_joints_set info b1 loc1 b2 loc2 =
  let dd = loc2 -- loc1 in
  let test ij1 = info.merge (block_get b1 ij1) (block_get b2 (ij1++dd)) in
  let get ij1 = ij1 |> test |> merged in
  
  let it_is_a_joint loc = 
    match get loc with
    | Some sym when info.joint sym -> is_on_boundary_func get loc
    | _ -> false
  in

  let scan arr dd initial =   
    Array.fold_left 
      (fun acc ij -> 
        if true || it_is_a_joint (ij--dd) then LocSet.add (ij--dd) acc else acc)
      initial arr
  in

  LocSet.empty |> (scan b1.joints (0,0)) |> (scan b2.joints dd) 

let count_joints info b1 loc1 b2 loc2 =
  join_joints_set info b1 loc1 b2 loc2 |> LocSet.cardinal

let block_merge info b1 loc1 b2 loc2 =
  let (dx,dy) as dd = loc1 -- loc2 in
  
  let test loc = info.merge (block_get b1 (loc ++ dd)) (block_get b2 loc) in
  let get loc = loc |> test |> merged in
  
  (* let joints = join_joints_set info b1 loc1 b2 loc2 |> LocSet.elements |> Array.of_list in *)
  
  for i = 0 to b2.w-1 do
    for j = 0 to b2.h-1 do
      let ii = i+dx in
      let jj = j+dy in
      if ii>=0 && ii<b1.w && jj>=0 && jj<b1.h then
        b1.data.(ii).(jj) <- get (i,j)
    done
  done;

  (* update joints *)
 
  let it_is_a_joint = is_a_joint info b1 in

  let scan arr dd initial =   
    Array.fold_left 
      (fun acc ij -> if it_is_a_joint (ij++dd) then LocSet.add (ij++dd) acc else acc)
      initial arr
  in

  let joints =
    LocSet.empty 
      |> (scan b1.joints (0,0)) |> (scan b2.joints dd) |> LocSet.elements |> Array.of_list 
  in
  
  {b1 with joints; rect = Rect.join b1.rect (Rect.displace b2.rect dd)}



(* Reading from file *)


let instr_prefix = '@'

let block_from_strings info ls =
  (* find now many characters can be skipped, and the string length *)
  let skip, full_len =
    List.fold_left (fun (skip, full_len) s ->
      let rec measure s acc i di =
        match s.[i] with
        | ' ' | '\n' | '\r' | '\t' | '\012' -> measure s (acc+1) (i+di) di
        | _ -> acc
      in
      let sk = measure s 0 0 1 in
      let s_len = String.length s in
      let fln = let x = measure s 0 (s_len-1) (-1) in s_len-x in

      (min skip sk, max full_len fln)
    ) (max_int,0) ls
  in
  (* make the block *)
  let w = max 1 (full_len - skip) in
  let h = max 1 (List.length ls) in
  (*
  printf "full_len=%i, skip=%i\n" full_len skip ;
  printf "w=%i, h=%i\n" w h;
  List.iter (fun s -> print_endline s) ls;
  *)
  let b = block_empty w h in
  
  let _ = List.fold_left 
    (fun j s ->
      for i = 0 to w-1 do
        b.data.(i).(j) <- 
          if skip+i < String.length s then 
            ( match s.[skip+i] with
              | ' ' | '\r' | '\n' | '\t' | '\012' -> None
              | c -> Some c )
          else 
            None
      done;
      (j+1)
    ) 0 ls
  in
  { b with joints = find_all_joints info b}

type piece = ReadInstr of string | ReadBlock of (string list)

let blocks_from_chan ic =
  let get_pieces () = 
    let rec accum str_ls =
      let block_ls () = (if str_ls = [] then [] else [ReadBlock str_ls]) in
      match
      ( try Some (input_line ic) with End_of_file -> None )
      with
      | Some s -> 
          let strm = String.trim s in
          if strm <> "" then 
          ( if strm.[0] = instr_prefix then
              block_ls() @ [ReadInstr (String.sub strm 1 (String.length strm - 1))]
            else
              accum (s::str_ls)
          )
          else if str_ls = [] then accum [] 
          else block_ls()
      | None -> block_ls()
    in
    accum []
  in

  let rec digest ((x,bls) as acc) = function
    | [] -> acc
    | (ReadBlock strls)::tl ->
        let info = make_info x in
        let b = block_from_strings info strls in
        let b2 = block_rotate_cw b in
        let b3 = block_rotate_cw b2 in
        let b4 = block_rotate_cw b3 in
        digest (x, b4 :: b3 :: b2 :: b :: bls) tl
    | (ReadInstr s) :: tl ->
        let instr = Parse.read s in
        Instr.add_instr x instr;
        digest (x, bls) tl
  in

  let rec iter acc =
    match get_pieces() with
    | [] -> acc
    | ls -> iter (digest acc ls)
  in
  
  let x, bls = iter (Instr.make_empty(), []) in
  (make_info x, Array.of_list bls)

let block_print info b =
  let flr_color  = "\x1b[31m" in 
  let wall_color = "\x1b[30;1m" in 
  let def = "\x1b[0m" in 
  
  let i0 = b.rect.Rect.x0 in
  let j0 = b.rect.Rect.y0 in
  let i1 = i0 + b.rect.Rect.w - 1 in
  let j1 = j0 + b.rect.Rect.h - 1 in

  for j = j1 downto j0 do
    for i = i0 to i1 do
      let sym = 
        match block_get b (i,j) with
        | Some c -> c
        | _ -> ' '  
      in
      let prefix =
        let on_boundary = is_on_boundary b (i,j) in
        if info.floor sym && not on_boundary then 
           flr_color
        else if info.door sym && not on_boundary then
           def
        else
           wall_color
      in
      print_string (prefix^(String.make 1 sym)^def)
    done;
    print_newline();
  done;
  print_newline();
  (* printf "r.x0=%i r.y0=%i r.w=%i r.h=%i\n" b.rect.Rect.x0 b.rect.Rect.y0 b.rect.Rect.w b.rect.Rect.h *)
  ()


(* Generation *)

let block_postprocess info b =
  let i0 = b.rect.Rect.x0 in
  let j0 = b.rect.Rect.y0 in
  let i1 = i0 + b.rect.Rect.w - 1 in
  let j1 = j0 + b.rect.Rect.h - 1 in
  for j = j1 downto j0 do
    for i = i0 to i1 do
        match block_get b (i,j) with
        | Some c -> 
            let c' = if is_on_boundary b (i,j) then info.afterb c else c in            
            b.data.(i).(j) <- Some (info.after c')
        | None -> ()
    done;
  done

let pick_joints info b1 b2 = 
  let n1 = Array.length b1.joints in
  let n2 = Array.length b2.joints in

  let maximum1 = 30 in (* the max number of joints to try for the block b1 *)

  let lim1 = min maximum1 n1 in

  let i0 = if n1 = 0 then 0 else Random.int n1 in
  let idelta = if n1 < maximum1 then 1 else 3571 in
  let rec fold acc (i,icount,j,sumrate) =
    if icount >= lim1 || sumrate > 20.0 then 
      ( (*printf "(%f / %i) " sumrate icount;*)
        acc)
    else if j >= n2 then fold acc ((i+idelta) mod n1, icount+1, 0, sumrate)
    else
      match block_match_at info b1 b1.joints.(i) b2 b2.joints.(j) with
        Some (m,n) when n > 0 ->
          let joints_num = count_joints info b1 b1.joints.(i) b2 b2.joints.(j) in
          (* printf "(%i) " joints_num; *)
          if joints_num > 1 then
          ( let rate = float (m*m*m) *. (1.0 -. exp(float (-joints_num))) (* /. float (n*n) *) in
            fold 
              ( (rate, (b1.joints.(i), b2.joints.(j))) :: acc ) 
              (i, icount, j+1, sumrate+.rate)
          )
          else
            fold acc (i, icount, j+1, sumrate)
      | _ -> fold acc (i, icount, j+1, sumrate)
  in
  let ls = if n1 > 0 then fold [] (i0,0,0,0.0) else [] in
  any_from_rate_ls ls

let generate info blocks_arr w h num fnum fnrow =
  let b_rand() = blocks_arr.(Random.int (Array.length blocks_arr)) |> block_randomize info in
  let b_initial = 
    let b2 = b_rand () in
    
    let x0y0 = w, h in

    let b1 = 
      { w = 2*w;
        h = 2*h;
        maxw = w;
        maxh = h;
        rect = Rect.make x0y0 b2.w b2.h;
        data = Array.make_matrix (2*w) (2*h) None;
        joints = [||];
      }
    in
    
    block_merge info b1 x0y0 b2 (0,0) 
  in

  let rec add_more n fn fnr acc =
    (* 
    block_print info acc;
    *)

    (*
    printf "n=%i fn=%i\n" n fn;
    *)
    if fn < 0 || n < 1 || fnr < 0 then (acc, n)
    else
    ( let b = b_rand() in
      match pick_joints info acc b with
        Some (loc1,loc2) -> 
          add_more (n-1) fn fnrow (block_merge info acc loc1 b loc2)
      | _ -> add_more n (fn-1) (fnr-1) acc
    )
  in
  
  let b,ngend = add_more num fnum fnrow b_initial in
  block_postprocess info b;
  Some (b,ngend)


let generate_auto info blocks_arr w h =
  if Array.length blocks_arr > 0 then
  ( (* avg block dimensions *)
    let nblocks = float (Array.length blocks_arr) in
    let avg_w, avg_h, avg_area = 
      let sw, sh, sarea = 
        Array.fold_left (fun (sw, sh, sarea) b -> (sw + b.w, sh + b.h, sarea + b.w*b.h) ) (0,0,0) blocks_arr
      in
      (float sw /. nblocks, float sh /. nblocks, float sarea /. nblocks)
    in
    
    let x = avg_area +. 2.0*.(avg_w +. avg_h) in
    let num = (float (3*w*h) /. x) |> ceil |> int_of_float in
    let fnum = int_of_float (ceil (x *. 2.0 *. float num /. nblocks) )  in
    let fnrow = fnum / 4 in
    generate info blocks_arr w h num fnum fnrow
  )
  else
    None

let load_constructor filename =
  let ic = open_in filename in
  let info, blocks = blocks_from_chan ic in
  close_in ic;
  (info, blocks)

let use_constructor (info, blocks) w h min_blocks_number =
  let rec repeat () = 
    match generate_auto info blocks w h with
    | Some (result, n) when n >= min_blocks_number -> Some result
    | _ -> repeat () 
  in
  repeat ()

let constructors = 
  List.map
  (fun s -> s |> load_constructor)
  [ 
    "data/dg/dng1.au";
    "data/dg/dng2.au";
    "data/dg/dng3.au";
  ] |> Array.of_list

let cons_house =
  List.map
  (fun s -> s |> load_constructor)
  [ 
    "data/dg/house2.au";
  ] |> Array.of_list
