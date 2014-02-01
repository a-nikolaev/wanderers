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

  let (rm,loc,nb) = add_dng (rm_ow, loc_ow, nb_ow) (w*h/12) in

  (* combined *)
  let prio = Prio.make() in
  let currid = 0 in
  {currid; prio; rm; loc; nb}
