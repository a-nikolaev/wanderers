open Base
open Common
open Global

let round x = int_of_float (floor (x +. 0.5))

let round_prob xf =
  let z = int_of_float xf in
  let dz = if Random.float 1.0 < xf -. float z then 1 else 0 in
  z + dz

let in_range (l,h) x = min (max l x) h 
let def_max_pop = 100
let rng = in_range (0, def_max_pop)

let urbanization g rid = 
  List.length g.G.rm.(rid).RM.cons
  
let agriculture pol g rid = 
  let facnum = fnum g in
  fold_lim (fun sum i -> 
      if pol.Pol.prop.(i).Pol.fsp = Domestic then 
        sum + fget g rid i
      else 
        sum
  ) 0 0 (facnum-1)

let place_eval pol fac g rid =
  let base =
    match pol.Pol.prop.(fac).Pol.cl with
      | Pol.Civil -> float (urbanization g rid) -. 2.0   
      | Pol.Rogue -> (match urbanization g rid with 0 -> -1. | 1 -> 0. | _ -> -2.)
      | _ -> 0. in

  let htrm = pol.Pol.prop.(fac).Pol.htrm in
  let rm = g.G.rm.(rid) in
  let key = (rm.RM.biome, rm.RM.modifier) in
  let result =  
    if Hashtbl.mem htrm key then Hashtbl.find htrm key else 0.  in
  base +. result

let get_difficulty g rid = RM.get_difficulty g.G.rm.(rid)

let growth speedup pol g facnum rid =
  let totpop = fold_lim (fun sum i -> sum + fget g rid i) 0 0 (facnum-1) in
  let totx = float totpop in

  (*
  let pop_cond pred = fold_lim (fun sum i -> if pred i then sum + fget g rid i else sum) 0 0 (facnum-1) in
  let pop_dont_like_me fac = pop_cond (fun other_fac -> pol.Politics.rel_act.(other_fac).(fac) < 0) in
  *)

  let actions_from_others fac =
    fold_lim 
      (fun sum i -> 
          sum +. ( pol.Pol.rel_act.(i).(fac) *. float (fget g rid i) )) 
      0.0 0 (facnum-1) in
 
  (*
  let like_others fac =
    fold_lim 
      (fun sum i -> 
          sum + ( pol.Politics.rel_like.(fac).(i) * fget g rid i )) 
      0 0 (facnum-1) in
  *)

  (* go through all factions *)
  let dres_lat = Array.make facnum 0 in

  let run_faction i =
    let pop = fget g rid i in
    let x_actions = actions_from_others i in
    let x_like = actions_from_others i in
    
    let x_place = place_eval pol i g rid in

    let urbn = urbanization g rid in
    let xtot_penalty_sq = 
      let z = 1 + int_of_float (float totpop /. sqrt( float (1 + urbn) )) in 
      float (z * z) in

    let x = float pop in
    let dx = 
      ( ( 8.0e-1 *.  +. 
          1.0e-2 *. x_place +. 
          1.0e-3 *. x_like ) *. ( 1.0 /. (totx +. 1.0) ) +.
        (-1.1e-3) *. xtot_penalty_sq +.
        1.0e-3 *. x_actions ) *. speedup *. x in

    (* economics *)
    let fcl = pol.Pol.prop.(i).Pol.cl in
    let frac = if totpop > 0 then float pop /. float totpop else 0.0 in
    let agro = agriculture pol g rid in

    let slowdown = 0.05 *. speedup in
    (* production efficiency per person *)
    let argx = (1.1 +. 0.1 *. float (urbn + round_prob (sqrt(float agro)) )) in
    (* production - adjust to the difficulty level of the region *)
    let argx = argx +. 0.05 *. get_difficulty g rid in
    (* consumption per person *)
    let argy = 1.0 in
    (* life cost per person *)
    (* let argz = 0.8 in *)

    let edpop, edres =
      if fcl = Pol.Civil || (fcl = Pol.Rogue) then
      (   let cap = round_prob ( 2.0 *. (1.0 +. x_place) *. frac) in
          let produced = min (round_prob (argx *. x)) cap in
          let eaten = min (Resource.numeric (rget g rid) / 2) (round_prob (argy *. x)) in
          let edres = produced - eaten in
          (* let edpop = eaten - round_prob (0.5 *. argz *. x) in *)
          let h x = round_prob (float x *. slowdown) in
          (0, h edres)
      )
      else 
        (0,0)
    in

    dres_lat.(i) <- edres;
    let pop' = ((x +. dx +. float edpop) |> round_prob |> rng) in
    fset_lat g rid i (max 0 (pop' - fget_alloc g rid i))
  in
  for i = 0 to facnum-1 do
    let pop = fget g rid i in
    if pop > 0 then
      run_faction i
  done;

  (* economic effect of resources *)
  let drl_val = (Array.fold_left (+) 0 dres_lat) in
  let drl = Resource.make drl_val in
  let rl = rget_lat g rid in 
  if drl_val > 0 then 
    rset_lat g rid (Resource.add rl drl)
  else if Resource.lesseq drl rl then
    rset_lat g rid (Resource.subtract rl drl)
  else
    rset_lat g rid (Resource.zero)


let migrate speedup pol g facnum rid =
  let total_pop = fold_lim (fun sum i -> sum + fget g rid i) 0 0 (facnum-1) in
  (* go through all factions *)
  for i = 0 to facnum-1 do
    let pop = fget g rid i in
    let pop_lat = fget_lat g rid i in
    let x = float pop in
    G.Me.iter 
      ( fun _ nrid ->

        if Random.int 4 = 0 && (pop > 0 || fget g nrid i > 0) then
        ( let x_place = place_eval pol i g rid in
          let x_nplace = place_eval pol i g nrid in
          let boost = 1.0 +. 4.0 *. 
            if x_nplace>x_place then (x_nplace -. x_place) /. (abs_float(x_nplace) +. abs_float(x_place)) else 0.0 in
          
          let d = round_prob (0.008 *. speedup *. x *. boost) in
          let d2 = min d (fget_lat g rid i) in
          let npop = fget g nrid i in
          
          let d3 = d2 |> min (pop - npop) |> max 0 in

          let npop_lat = fget_lat g nrid i in
          (* let npop_alloc = fget_alloc g nrid i in *)

          let d4 = in_range (0, def_max_pop - npop) d3 in

          (* move population *)
          fset_lat g rid i (pop_lat - d4) ;
          fset_lat g nrid i (npop_lat + d4) ;

          (* move resources *)
          let res_to_move = Resource.scale (float d4 /. float total_pop) (rget g rid) in
          let cur_res_lat = rget_lat g rid in
          let nb_res_lat = rget_lat g nrid in
          let res_to_move_2 = Resource.intersection res_to_move cur_res_lat in
          rset_lat g rid (Resource.subtract cur_res_lat res_to_move_2);
          rset_lat g nrid (Resource.add nb_res_lat res_to_move_2);
        )
      )
      g.G.nb.(rid)
      
  done


let economics speedup pol g facnum rid =
  let totpop = fold_lim (fun sum i -> sum + fget g rid i) 0 0 (facnum-1) in
  let res_lat = rget_lat g rid in
    
  let rm = g.G.rm.(rid) in

  if rm.RM.biome <> RM.Dungeon then
  (
    let cons = rm.RM.cons in
    let len = List.length cons in
   
    let house_base_price = 32 in

    let house_price = Resource.make (house_base_price*(1+len)) in
    
    for i = 0 to facnum-1 do
      let pop = fget g rid i in

      if pop > 0 then
      ( let frac = if totpop > 0 then float pop /. float totpop else 0.0 in

        let fcl = pol.Pol.prop.(i).Pol.cl in

        if fcl = Pol.Civil || (fcl = Pol.Rogue && len = 0) then 
        (
          let chance = speedup *. 0.10 in

            if totpop > 3 && frac > 0.33 && Random.float 1.0 < chance then
            ( if Resource.lesseq (Resource.scale 2.0 house_price) res_lat && len < 4 then
              ( let loc = match len with 0 -> (0,0) | 1 -> (1,0) | 2 -> (0,1) | _ -> (1,1) in
                g.G.rm.(rid) <- RM.({rm with cons = {constype=CHouse; consloc=loc} :: cons });
                rset_lat g rid (Resource.subtract res_lat house_price)
              ) 
            )
        )
      )
    done;

    (* destruction *)
    ( match g.G.rm.(rid).RM.cons with
      | hd::tl ->
          ( let noncivil = fold_lim (fun sum i -> 
                if pol.Pol.prop.(i).Pol.cl <> Pol.Civil then
                  sum + fget g rid i
                else 
                  sum
              ) 0 0 (facnum-1) in
            let civil = totpop - noncivil in
            let len = List.length g.G.rm.(rid).RM.cons in
            if float noncivil > 0.90 *. float totpop || civil < len || civil > 8 + 3 * len then
            ( let chance = speedup *. 0.10 in
              if Random.float 1.0 < chance then
              ( g.G.rm.(rid) <- RM.({rm with cons = tl});
                let res_lat = rget_lat g rid in
                rset_lat g rid (Resource.add res_lat (Resource.make (house_base_price/2))) )
            )
          )
      | _ -> () )
  ) (* not a dungeon *)

let sim_actors speedup pol (g, astr) =
  (* add new actors *)
  let n = round_prob speedup in
  let ga_upd = 
    fold_lim (fun ga i -> Org.Astr.add_new_actor pol ga) (g, astr) 1 n
  in
  (* simulate the existing ones *)
  let accept_prob = 0.1 *. speedup in
  Simorg.run accept_prob pol ga_upd 

let run speedup pol (g, astr) =
  let facnum = fnum g in
  let len = G.length g in
  let execute func = 
    for rid = 0 to len-1 do
      if Random.int 2 = 0 then
        func speedup pol g facnum rid;
    done
  in
  execute growth;
  execute economics;
  execute migrate;

  let g_astr' = sim_actors speedup pol (g, astr) in
  g_astr'
