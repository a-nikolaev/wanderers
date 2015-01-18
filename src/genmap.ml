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

let gen_rnd_alt_2 w h steps =  

  let get_w_h steps_remain =
    let zoom = power 2 steps_remain in 
    let ww = (w + zoom-1) / zoom in
    let hh = (h + zoom-1) / zoom in
    (ww,hh) in

  let (ww,hh) = get_w_h steps in

  let z = Array.make_matrix ww hh 0.0 in
  for i = 0 to ww-1 do
    for j = 0 to hh-1 do
      let boundary = 
        let dist2 = List.fold_left min (ww*ww + hh*hh) [i*i; j*j; (ww-1-i)*(ww-1-i); (hh-1-j)*(hh-1-j)] in 
        exp (-. 1.2 *. float dist2 )
      in
      z.(i).(j) <- ((Random.float 600.0) +. 200.0) *. boundary 
    done
  done;
  add_fun z (fun () -> (Random.float 430.0)**1.19 );
  
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


module Cube = struct

  (* set of coords *)
  type lbl = int
  type coord = int*int*int
  module Sc = Set.Make (struct type t = coord let compare = compare end)
  module Ml = Map.Make (struct type t = lbl let compare = compare end)

  let (+++) (a,b,c) (d,e,f) = (a+d, b+e, c+f)
  let (---) (a,b,c) (d,e,f) = (a-d, b-e, c-f)
  (* scalar product *)
  let (%%%) (a,b,c) (d,e,f) = (a*d + b*e + c*f)

  let get a (x,y,z) = a.(x).(y).(z)
  let set a (x,y,z) v = a.(x).(y).(z) <- v


  let initial w h depth altitude forestation =
    let map_alt_to_biome x frst = 
      if x > 730 then None
      else if x > 650 then Some RM.SnowMnt
      else if x > 450 then 
        ( if frst > 600 && x < 550 then Some RM.ForestMnt 
          else Some RM.Mnt )
      else if x > 120 then 
        ( if frst > 600 then Some RM.DeepForest 
          else if frst > 400 then Some RM.Forest
          else Some RM.Plains )
      else Some RM.Swamp in

    (* biomes *)
    let b = Array.init w (fun _ -> Array.init h (fun _ -> Array.make depth None)) in
    (* connected components *)
    let cc = Array.init w (fun _ -> Array.init h (fun _ -> Array.make depth 0)) in

    for x = 0 to w-1 do
      for y = 0 to h-1 do
        b.(x).(y).(0) <- map_alt_to_biome (int_of_float altitude.(x).(y)) (int_of_float forestation.(x).(y))
      done
    done;

    let is_inside (x,y,z) = x >= 0 && y >= 0 && z >= 0 && x < w && y < h && z < depth in

    let is_ok b cc xyz = is_inside xyz && get cc xyz = 0 && get b xyz <> None in

    let rec init_ccs b cc xyz lbl s = 
      if is_ok b cc xyz then
      ( set cc xyz lbl;
        let s2 = Sc.add xyz s in
        List.fold_left (fun acc_s dxyz ->
            init_ccs b cc (xyz +++ dxyz) lbl acc_s
          )
          s2 
          [(1,0,0); (-1,0,0); (0,1,0); (0,-1,0)]
      )
      else 
        s
    in
  
    let rec fill_cc b cc ((x,y,z) as xyz) lbl m =
      if x >= w then fill_cc b cc (0, y+1, z) lbl m
      else if y >= h then m
      else 
      ( if is_ok b cc xyz then
          let s = init_ccs b cc (x,y,z) lbl Sc.empty in
          let um = Ml.add lbl s m in
          fill_cc b cc (x+1,y,z) (lbl+1) um
        else
          fill_cc b cc (x+1,y,z) (lbl) m
      )
    in

    let lbl_map = fill_cc b cc (0,0,0) 1 Ml.empty in

    (b, cc, lbl_map)


  (* make an is_inside function for a given 3-dim array *)
  let is_inside arr =
    let w = Array.length arr in 
    let h = Array.length arr.(0) in 
    let depth = Array.length arr.(0).(0) in 
    (fun (x,y,z) -> x >= 0 && y >= 0 && z >= 0 && x < w && y < h && z < depth) 
 
  (* sample from a coord set *)
  let sc_sample s =
    let c = Sc.cardinal s in
    if c > 0 then
      let x = Random.int c in
      let _, res = Sc.fold (fun coord (i,acc) -> if i = x then (i+1, coord) else (i+1, acc)) s (0, (Sc.choose s)) in
      Some res
    else
      None

  (* sample from a label map *)
  let ml_sample m =
    let c = Ml.cardinal m in
    if c > 0 then
      let x = Random.int c in
      let _, res = Ml.fold (fun lbl s (i,acc) -> if i = x then (i+1, (lbl, s)) else (i+1, acc)) m (0, (0, Sc.empty)) in
      Some res
    else
      None

  (* sample two from a label map *)
  let ml_sample_two m = 
    let c = Ml.cardinal m in
    if c > 1 then
      let x1 = Random.int c in
      let x2 = let z = Random.int c in if z <> x1 then z else if z+1 < c then z+1 else z-1 in
      let _, res = Ml.fold (fun lbl s (i,(acc1,acc2)) -> 
          let accs = if i = x1 then ((lbl, s), acc2) else if i = x2 then (acc1, (lbl, s)) else (acc1, acc2) in
          (i+1, accs)
        )
        m ( 0, ((0, Sc.empty), (0, Sc.empty)) ) 
      in
      Some res
    else
      None

  (* substitute labels (joining two connected components)  *)
  let subst_lbl lbl_old lbl_new (b, cc, m) =
    let s_old = Ml.find lbl_old m in
    let s_new = Ml.find lbl_new m in
    for x = 0 to Array.length cc - 1 do
      for y = 0 to Array.length cc.(0) - 1 do
        for z = 0 to Array.length cc.(0).(0) - 1 do
          let xyz = (x,y,z) in
          if get cc xyz = lbl_old then set cc xyz lbl_new
        done
      done
    done;
    let um = m |> Ml.remove lbl_old |> Ml.add lbl_new (Sc.union s_old s_new) in
    (b, cc, um)

  (* look at the neighbors of a newly digged region and update the cube data, joining some connected components if needed *)
  let process_new_xyz (b, cc, m) ((x,y,z) as xyz) =
    let is_inside_cc = is_inside cc in
    let lbl = get cc xyz in
    List.fold_left (fun acc dxyz ->
        let nxyz = xyz +++ dxyz in
        if is_inside_cc nxyz then
        ( let nlbl = get cc nxyz in
          if nlbl <> lbl && nlbl <> 0 then
            subst_lbl nlbl lbl acc
          else
            acc
        )
        else
          acc
      )
      (b, cc, m)
      [ (1,0,0); (-1,0,0); (0,1,0); (0,-1,0); (0,0,1); (0,0,-1) ]
  
  let dig_at_xyz (b, cc, m) xyz lbl =

    let x,y,z = xyz in
    Printf.printf "dig at (%i,%i,%i)\n%!" x y z;
    
    if get b xyz = None then
    ( set b xyz (Some (if z < 8 then RM.Dungeon else RM.Cave));
      set cc xyz lbl;
      process_new_xyz (b, cc, m) xyz
    )
    else
      (b, cc, m)

  (* connect two points *)
  let connect_two_points (b,cc,m) (lbl1, xyz1) (lbl2, xyz2) condition_to_stop =
    let is_inside_cc ((_,_,z) as xyz) = is_inside cc xyz && z > 0 in
    
    let choose_where_to_go ((x,y,z) as src) (dst) =
      if z = 0 || z = 1 || z = 2 && Random.int 1 > 0 then (x,y,z+1)
      else
        let (diff_x, diff_y, diff_z) as diff = dst --- src in
        let len = (diff_x * diff_x + diff_y * diff_y + diff_z * diff_z) |> float_of_int |> sqrt |> floor |> int_of_float in
        let ls = 
          [ (1,0,0); (-1,0,0); (0,1,0); (0,-1,0); (0,0,1); (0,0,-1) ]
          |> List.filter (fun dxyz -> is_inside_cc (dxyz +++ src))
          |> List.map 
              (fun dxyz -> 
                let propensity = 
                  let v = ((diff +++ (0,0,len/3)) %%% dxyz + 7*len/5) in
                  let fv = v |> (fun x -> if x < 0 then 0 else x) |> float_of_int in
                  fv**1.3
                in
                (dxyz, propensity)
              )
        in
        let dxyz = any_from_rate_ls ls in
        src +++ dxyz
    in

    let dig_between xyz1 xyz2 b_cc_m =
      if Random.int 2 = 0 then
        let nxyz1 = choose_where_to_go xyz1 xyz2 in
        ((nxyz1, xyz2), dig_at_xyz b_cc_m nxyz1 lbl1)
      else 
        let nxyz2 = choose_where_to_go xyz2 xyz1 in
        ((xyz1, nxyz2), dig_at_xyz b_cc_m nxyz2 lbl2)
    in

    let rec repeat xyz1 xyz2 (b,cc,m)=
      let (xyz1, xyz2), (b,cc,m) = dig_between xyz1 xyz2 (b,cc,m) in
      if condition_to_stop (b,cc,m) xyz1 xyz2 then 
        (b,cc,m)
      else
        repeat xyz1 xyz2 (b,cc,m)
    in
    repeat xyz1 xyz2 (b, cc, m)

  (* connect two connected components by digging a tunnel *)
  let connect (b, cc, m) (lbl1, s1) (lbl2, s2) =
    match sc_sample s1, sc_sample s2 with
    | None, Some _ -> (b, cc, Ml.remove lbl1 m)
    | Some _, None -> (b, cc, Ml.remove lbl2 m)
    | None, None -> (b, cc, m |> Ml.remove lbl1 |> Ml.remove lbl2)
    | Some xyz1, Some xyz2 ->

        (* try to sampel two points close to each other *)
        let len (a,b,c) = abs a + abs b + abs c in
        
        let xyz1, xyz2 = 
          fold_lim (fun ((acc1, acc2) as acc) _ -> 
            match sc_sample s1, sc_sample s2 with
            | Some p1, Some p2 when len (p1 --- p2) < len (acc1 --- acc2) -> (p1, p2)
            | _ -> acc 
          ) 
          (xyz1, xyz2) 1 10 
        in
       
        let condition_to_stop (b,cc,m) nxyz1 nxyz2 = (not (Ml.mem lbl1 m)) || (not (Ml.mem lbl2 m)) in

        connect_two_points (b, cc, m) (lbl1, xyz1) (lbl2, xyz2) condition_to_stop
          
          

  (* connect all connected components *)
  let connect_everything b_cc_m =

    (* *)
    let _,_,m = b_cc_m in
    Printf.printf "connected components: %i\n" (Ml.cardinal m);

    let rec repeat (b, cc, m) =
      match ml_sample_two m with
      | Some ((lbl1, s1), (lbl2, s2)) ->
          
          (* we prefer to connect big components *)
          let prob_consider = 
            let area = Array.length cc * Array.length cc.(0) in
            float (Sc.cardinal s1 + Sc.cardinal s2) /. float area
          in

          if Random.float 1.0 < prob_consider then
          ( Printf.printf "(%i, %i)\n" lbl1 lbl2;
            (* if 2 connected components exist *)
            let b_cc_m = connect (b, cc, m) (lbl1, s1) (lbl2, s2) in
            repeat b_cc_m
          )
          else
            repeat (b,cc,m)
      | None -> 
          (* otherwise *)
          (b, cc, m)
    in
    repeat b_cc_m


  (* convert the cube data to a geo object *)
  let geo_of_cube facnum altitude forestation (b, cc, m) = 
    let w = Array.length cc in
    let h = Array.length cc.(0) in
    let depth = Array.length cc.(0).(0) in

    let is_inside_cc = is_inside cc in

    let rid_arr = Array.init w (fun _ -> Array.init h (fun _ -> Array.make depth None)) in

    (* collect list of rms *)
    let _, (xyz_ls, rm_ls) = 
      fold_lim (fun (rid,lss) z ->
        fold_lim (fun (rid,lss) x ->
          fold_lim (fun (rid,(xyz_ls, rm_ls)) y ->
            match get b (x,y,z) with 
            | Some biome -> 
              let alt = int_of_float altitude.(x).(y) in

              (* make rm *)  
              let difficulty =
                let r() = Random.float 1.0 in
                match biome with
                  RM.DeepForest -> 3.0 +. r()
                | RM.Forest -> 1.0 +. r()
                | RM.Swamp -> r()
                | RM.Mnt | RM.ForestMnt -> r()
                | RM.SnowMnt -> 1.0 +. r()
                | RM.Cave | RM.Dungeon -> float_of_int (z-1) +. r()
                | _ -> 0.0
              in
              let rm =
                { RM.lat = Mov.({res = Resource.make 0; fac = Array.init facnum (fun _ -> rndpop())}); 
                  RM.alloc = Mov.zero ();
                  RM.seed=Random.int 100000000; 
                  RM.altitude = alt;
                  RM.biome = biome;
                  RM.modifier = {RM.cursed = false; RM.urban = true};
                  RM.cons = [];
                  RM.difficulty = difficulty
                }
              in
              
              set rid_arr (x,y,z) (Some rid);

              (rid + 1, ((x,y,z)::xyz_ls, rm :: rm_ls))

            | None -> (rid, (xyz_ls, rm_ls))

          ) (rid,lss) 0 (h-1)
        ) (rid,lss) 0 (w-1)
      ) (0,([],[])) 0 (depth - 1)
    in
    
    (* convert to array *)
    let rm_arr = Array.of_list (List.rev rm_ls) in
    let xyz_arr = Array.of_list (List.rev xyz_ls) in

    (* region_loc array *)
    let rloc_arr = Array.map (fun (x,y,z) -> (-z, (x,y))) xyz_arr in

    (* neighbors array *)
    let nb_arr = Array.mapi (fun rid xyz ->
      List.fold_left (fun acc (edge, dxyz) -> 
          let nxyz = xyz +++ dxyz in
          if is_inside_cc nxyz then
            match get rid_arr nxyz with
            | Some nrid -> Me.add edge nrid acc
            | None -> acc
          else
            acc
        )
        Me.empty
        [(East, (1,0,0)); (West,(-1,0,0)); (North,(0,1,0)); (South,(0,-1,0)); (Up,(0,0,-1)); (Down,(0,0,1))] 
      )
      xyz_arr
    in
       
    (* combined *)
    let prio = Prio.make() in
    let currid = 0 in
    {currid; prio; rm = rm_arr; loc = rloc_arr; nb = nb_arr}


  let generate w h depth facnum =
    let altitude = gen_rnd_alt_2 w h 2 in
    let forestation = gen_rnd_alt w h 2 in
    let b_cc_m = initial w h depth altitude forestation in
    let b_cc_m = connect_everything b_cc_m in
    geo_of_cube facnum altitude forestation b_cc_m 


end
