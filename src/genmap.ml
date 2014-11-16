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
open Global
open G

let rec power x y = if y <= 0 then 1 else x * power x (y-1)

let add_fun z f =
  let w = Array.length z in
  let h = Array.length z.(0) in
  for i = 0 to w-1 do
    for j = 0 to h-1 do
      z.(i).(j) <- z.(i).(j) +. f()
    done
  done

let any_valprob ls = 
  let rec next x = function
    | (v,p)::tl when p < x -> next (x-.p) tl
    | [] -> failwith "empty list"
    | (v,p)::_ -> v in
  next (Random.float 1.0)

let rescale z nw nh =
  let w = Array.length z in
  let h = Array.length z.(0) in
  let factor = max ((nw+w-1) / w) ((nh+h-1) / h) in

  let di = (factor*w - nw) / 2 in
  let dj = (factor*h - nh) / 2 in
      
  let dist vloc zloc = (vloc -- (factor %% zloc ++ (di,dj))) |> vec_of_loc |> vec_len in

  let v = Array.make_matrix nw nh 0.0 in
  for i = 0 to nw-1 do
    for j = 0 to nh-1 do
      
      let vloc = (i,j) in
      let zloc = (i-di)/factor, (j-dj)/factor in
      let cand_ls = List.map (fun d -> zloc ++ d) 
        [ (-1,-1); (-1,0); (-1,1);
          ( 0,-1); ( 0,0); ( 0,1);
          ( 1,-1); ( 1,0); ( 1,1); ] in
      let z_ls = List.filter (fun (zi,zj) -> zi>=0 && zi<w && zj>=0 && zj<h ) cand_ls in 
      
      let dist_ls = List.map (dist vloc) z_ls in 
      let wg_ls = List.map (fun d -> exp (-.d*.d)) dist_ls in 
      let wg_sum = List.fold_left (fun acc d -> d +. acc) 0.0 wg_ls in

      let v_val = List.fold_left2 (fun acc (zi,zj) wg -> acc +. z.(zi).(zj) *. wg /. wg_sum) 0.0 z_ls wg_ls in

      v.(i).(j) <- v_val
    done
  done;
  v

let gen_rnd_alt w h steps =  

  let get_w_h steps_remain =
    let zoom = power 2 steps_remain in 
    let ww = (w + zoom-1) / zoom in
    let hh = (h + zoom-1) / zoom in
    (ww,hh) in

  let (ww,hh) = get_w_h steps in

  let z = Array.make_matrix ww hh 0.0 in
  add_fun z (fun () -> Random.float 1000.0);
  
  fold_lim 
    (fun zz step -> 
      let w,h = get_w_h (steps-step) in 
      let zzz = rescale zz w h in
      add_fun zzz (fun () -> Random.float 160.0 -. 80.0);
      zzz
    ) 
    z 1 steps

type intermediate = 
  (RM.t array) * (* rm *) 
  (region_loc array) * (* loc *)
  ((region_id Me.t) array) (* nb *)

let join (rm1, loc1, nb1) (rm2, loc2, nb2) bridgesls = 
  let len1 = Array.length rm1 in
  let len2 = Array.length rm2 in
  let len = len1 + len2 in
  let id_of_1 id = id in
  let id_of_2 id = len1 + id in
  let rm = Array.init len 
    ( fun id -> if id < len1 then rm1.(id) else rm2.(id - len1) ) in
  let loc = Array.init len 
    ( fun id -> if id < len1 then loc1.(id) else loc2.(id - len1) ) in
  let nb = Array.init len 
    ( fun id ->
        if id < len1 then
          nb1.(id)
        else
          Me.map (fun rid2 -> id_of_2 rid2) nb2.(id - len1) ) in
  List.iter (fun (id1,dir1,dir2,id2) -> 
    nb.(id_of_1 id1) <- Me.add dir1 (id_of_2 id2) nb.(id_of_1 id1);
    nb.(id_of_2 id2) <- Me.add dir2 (id_of_1 id1) nb.(id_of_2 id2);
    ) bridgesls;
  (rm, loc, nb)
  
let rndpop() = Random.int 4

let simple_rm alt biome facnum difficulty = 
  { RM.lat = Mov.({res = Resource.make 0; fac = Array.init facnum (fun _ -> rndpop())}); 
    RM.alloc = Mov.zero ();
    RM.seed=Random.int 10000; 
    RM.altitude = alt;
    RM.biome = biome;
    RM.modifier = {RM.cursed = false; RM.urban = true};
    RM.cons = [];
    RM.difficulty = difficulty;
  } 

let simple_dungeon alt locxy facnum =
  let depth = 1 + Random.int 10 in
  let rm = Array.init depth 
    (fun i -> simple_rm alt RM.Dungeon facnum (float i)) 
  in
  let loc = Array.init depth
    (fun i -> (-1-i, locxy))
  in
  let nb = Array.init depth
    (fun i -> 
      let m = Me.empty in
      let m = 
        if i > 0 then Me.add Up (i-1) m
        else m in
      let m = 
        if i < depth-1 then Me.add Down (i+1) m
        else m in
      m
    )
  in
  (rm,loc,nb)


let make_geo w h facnum =

  let altitude = gen_rnd_alt w h 2 in
  let forestation = gen_rnd_alt w h 2 in
  let map_alt_to_biome x frst= 
    if x > 830 then RM.SnowMnt
    else if x > 650 then 
      ( if frst > 600 && x < 725 then RM.ForestMnt 
        else RM.Mnt )
    else if x > 200 then 
      ( if frst > 600 then RM.DeepForest 
        else if frst > 400 then RM.Forest
        else RM.Plains )
    else RM.Swamp in

  (* overworld *)
  let x_of_index k = k mod w in
  let y_of_index k = k / w in
  let index (i, j) = i + j*w in

  let len_ow = w*h in
  let rm_ow = Array.init len_ow (fun k ->
    let alt = int_of_float altitude.(x_of_index k).(y_of_index k) in
    let frst = int_of_float forestation.(x_of_index k).(y_of_index k) in
    let biome = map_alt_to_biome alt frst in
    let difficulty =
      let r() = Random.float 1.0 in
      match biome with
        RM.DeepForest -> 3.0 +. r()
      | RM.Forest -> 1.0 +. r()
      | RM.Swamp -> r()
      | RM.Mnt | RM.ForestMnt -> r()
      | RM.SnowMnt -> 1.0 +. r()
      | _ -> 0.0
    in
    { RM.lat = Mov.({res = Resource.make 0; fac = Array.init facnum (fun _ -> rndpop())}); 
      RM.alloc = Mov.zero ();
      RM.seed=Random.int 1000000; 
      RM.altitude = alt;
      RM.biome = biome;
      RM.modifier = {RM.cursed = false; RM.urban = true};
      RM.cons = [];
      RM.difficulty = difficulty
    }) in
  let loc_ow = Array.init len_ow (fun k -> (0,(x_of_index k, y_of_index k))) in
  let nb_ow = Array.init len_ow (fun k ->
      let i = x_of_index k in
      let j = y_of_index k in
      List.fold_left (fun acc (edge,(i,j)) -> 
          if i>=0 && i<w && j>=0 && j<h then
            Me.add edge (index(i,j)) acc
          else
            acc
        )
        Me.empty
        [(East,(i+1,j)); (West,(i-1,j)); (North,(i,j+1)); (South,(i,j-1))] 
    ) in
  
  (* dungeons *)
  let rec add_dng ((_,_,nb_acc) as acc_arrs) num =
    if num > 0 then
    ( let dng_loc = Random.int w, Random.int h in
      if not (G.Me.mem Down nb_acc.(index dng_loc)) then
      ( let dng_arrs = 
          (* let x,y = dng_loc in *)
          let alt = 0 (* int_of_float altitude.(x).(y) *) in
          simple_dungeon alt dng_loc facnum in

        let acc_arrs' = join acc_arrs dng_arrs [(index dng_loc, Down, Up, 0)] in
        add_dng acc_arrs' (num-1)
      )
      else
        add_dng acc_arrs num
    )
    else
      acc_arrs
  in

  (* more complex dungeons *)
  let add_entangled_dungeons given_arrs num =
    let xlim = w in
    let ylim = h in
    let zlim = 15 in
    let cube = Array.init xlim (fun i -> Array.init ylim (fun j -> Array.init zlim (fun k -> 
      if k = 0 then (Some RM.Plains) else None 
      )))
    in
    let rnd (i,j,k) =
      let cases = if k = 1 then 100 else 7 in
      match Random.int cases with
      | 0 -> (i+1,j,k)
      | 1 -> (i-1,j,k)
      | 2 -> (i,j+1,k)
      | 3 -> (i,j-1,k)
      | 4 -> (i,j,k-1) (* up *)
      | _ -> (i,j,k+1) (* down *)
    in
    
    let ijk_is_inside (i,j,k) =
      i >= 0 && j >= 0 && k >= 0 && i < xlim && j < ylim && k < zlim 
    in

    let rec worm step ((i,j,k) as loc) =
      if ijk_is_inside loc then
      ( match cube.(i).(j).(k) with
        | None ->
          ( cube.(i).(j).(k) <- 
              Some (if step > (* 10 *) 10 then RM.Cave else RM.Dungeon); 
            if Random.int 8 = 0 then worm (step+1) (rnd loc); 
            worm (step+1) (rnd loc) 
          )
        | _ -> ()
      )
    in
    for i = 0 to num do
      worm 0 (Random.int xlim, Random.int ylim, 1)
    done;

    (* transform the cube into the arrays *)
    let add (i,j,k) (rms, locs, ijks) =
      match cube.(i).(j).(k) with
      | Some biome ->
          let rm = simple_rm (int_of_float altitude.(i).(j)) biome facnum (float (k-1)) in
          (rm::rms, (-k,(i,j))::locs, (i,j,k)::ijks)
      | None -> 
          (rms, locs, ijks)
    in

    let rec fold_cube f acc (i,j,k) =
      if i >= xlim then
        fold_cube f acc (0, j+1, k)
      else if j >= ylim then
        fold_cube f acc (0, 0, k+1)
      else if k >= zlim then 
        acc
      else
        fold_cube f (f acc (i,j,k)) (i+1,j,k)
    in

    (* these cube does not include k=0, the top level *)
    let (rms, locs, ijks) = fold_cube (fun acc ijk -> add ijk acc ) ([], [], []) (0,0,1) in
    let rms_arr = Array.of_list rms in
    let locs_arr = Array.of_list locs in
    let ijks_arr = Array.of_list ijks in

    (* now, compute nbrs array *)

    let id_cube = Array.init xlim (fun i -> Array.init ylim (fun j -> Array.init zlim (fun k -> None ))) in
    Array.iteri (fun id (i,j,k) -> id_cube.(i).(j).(k) <- Some id) ijks_arr;
    let len = Array.length ijks_arr in

    let nbs_arr =
      Array.mapi (fun id (i,j,k) ->  
          let m = Me.empty in
          List.fold_left (fun m (edge, (ni,nj,nk)) ->
            if ijk_is_inside (ni,nj,nk) then
              match id_cube.(ni).(nj).(nk) with
                Some nid -> Me.add edge nid m
              | _ -> m
            else
              m
          ) 
          Me.empty
          [
            (West, (i-1,j,k));
            (East, (i+1,j,k));
            (North, (i,j+1,k));
            (South, (i,j-1,k));
            (Up,   (i,j,k-1));
            (Down, (i,j,k+1));
          ]

        ) ijks_arr
    in

    let bridges_ls = 
      fold_lim (fun acc i -> 
        fold_lim (fun acc j -> 

          match id_cube.(i).(j).(1) with
          | Some id -> (index (i,j), Down, Up, id) :: acc
          | _ -> acc

        ) acc 0 (ylim-1)
      ) [] 0 (xlim-1)
    in

    (* connect the given RMs with the new ones *)
    join 
      given_arrs 
      (rms_arr, locs_arr, nbs_arr) 
      bridges_ls 
  in

  (*
  let (rm,loc,nb) = add_dng (rm_ow, loc_ow, nb_ow) (w*h/12) in
  *)
  let (rm,loc,nb) = add_entangled_dungeons (rm_ow, loc_ow, nb_ow) (w*h/12) in

  (* combined *)
  let prio = Prio.make() in
  let currid = 0 in
  {currid; prio; rm; loc; nb}
