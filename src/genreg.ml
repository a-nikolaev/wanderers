
open Base
open Common
open R
 

let add_cons area rm =
  let w = Area.w area in
  let h = Area.h area in
  let sq (x,y) (dx, dy) =
    for i = x to x + dx do
      for j = y to y + dy do
        if (i=x || i=x+dx || j = y || j =y+dy) then
          Area.set area (i,j) Tile.Wall
        else
          Area.set area (i,j) Tile.WoodenFloor
      done
    done;
    Area.set area (x,y+dy/2) Tile.OpenDoor;
    Area.set area (x+dx,y+dy/2) Tile.OpenDoor;
    Area.set area (x+dx/2,y) Tile.OpenDoor;
    Area.set area (x+dx/2,y+dy) Tile.OpenDoor;
  in
  List.iter (fun {RM.constype=ct; RM.consloc=loc} ->
    let xy () = Random.int ((w/2 - 4)/2), Random.int ((h/2 - 4)/2) in
    let mindims = (3,3) in
    let pos =
      match loc with
        (0,0) -> (0,0) 
      | (1,0) -> (w/2,0)
      | (0,1) -> (0,h/2) 
      | _     -> (w/2,h/2) in
    sq (pos ++ (1,1) ++ xy()) (mindims ++ xy())

  ) rm.RM.cons

let fill a tile (x,y,dx,dy)  =
  for i = x to x+dx-1 do
    for j = y to y+dy-1 do
      Area.set a (i,j) tile
    done
  done

let maze a wall floor (x,y,dx,dy) =
  let w = Area.w a in
  let h = Area.h a in
  let set = Area.set a in
  let get = Area.get a in
  let z = Array.make_matrix w h false in
  let nb8 (i,j) = 
    List.filter (fun (ii,jj) -> ii>=x && jj>=y && ii<x+dx && jj<y+dy) 
    [(i-1,j); (i+1,j); (i,j+1); (i,j-1);
     (i-1,j-1); (i+1,j-1); (i+1,j+1); (i-1,j+1)] in
  let nbd (i,j) = 
    List.filter (fun (ii,jj) -> ii>=x && jj>=y && ii<x+dx && jj<y+dy) 
    [(i-1,j-1); (i+1,j-1); (i+1,j+1); (i-1,j+1)] in
  let nb_z (i,j) = 
    List.filter (fun (ii,jj) -> not z.(ii).(jj) && ii>=x && jj>=y && ii<x+dx && jj<y+dy) 
    [(i-1,j); (i+1,j); (i,j+1); (i,j-1)] in
  let can_dig loc = 
    let nbls = nbd loc in
    nbls <> [] &&
    ( List.fold_left  (fun acc nloc -> 
        if get nloc = floor then acc+1 else acc) 
        0 nbls ) < 2 in
  let (i0, j0) = x + Random.int dx, y + Random.int dy in
  let rec repeat ls =
    match any_from_ls ls with
      Some (i,j) ->
        let ls1 = List.filter ((<>) (i,j)) ls in
        let ls2 = 
          if can_dig (i,j) then
          ( set (i,j) floor;
            z.(i).(j) <- true;
            (nb_z (i,j)) @ ls1  
          )
          else
          ( z.(i).(j) <- true;
            ls1 )
        in
        repeat ls2
    | None -> ()
  in
  repeat [(i0,j0)]

let gen pol edges_func rid rm =
  let w = 25 in
  let h = 16 in
  Random.init rm.RM.seed;
  let ground_tile = match rm.RM.biome with
    | RM.Mnt | RM.ForestMnt -> Tile.RockyGround
    | RM.SnowMnt -> Tile.SnowyGround
    | RM.Swamp -> Tile.SwampyGround
    | RM.Dungeon -> Tile.DungeonFloor
    | _ -> Tile.Grass
  in

  let high_altitude = float (rm.RM.altitude - 830) /. 170.0 in

  let prob_ls = match rm.RM.biome with
  | RM.Forest | RM.ForestMnt -> [Tile.Tree1,0.07; Tile.Tree2,0.09; Tile.Rock1, 0.004; Tile.Rock2, 0.004; Tile.Wall,0.002; ground_tile,1.00]
  | RM.DeepForest -> [Tile.Tree1,0.07; Tile.Tree2,0.12; Tile.Rock1, 0.003; Tile.Rock2, 0.003; Tile.Wall,0.0005; ground_tile,1.00]
  | RM.Plains -> [Tile.Tree1,0.02; Tile.Tree2,0.01; Tile.Rock1, 0.002; Tile.Rock2, 0.002; Tile.Wall,0.001; ground_tile,1.00]
  | RM.Swamp -> [Tile.Tree1,0.005; Tile.Tree2,0.04; Tile.Wall,0.002; ground_tile,1.00]
  | RM.Mnt -> [Tile.Tree1,0.005; Tile.Tree2,0.03; Tile.Rock1, 0.02; Tile.Rock2, 0.02; Tile.Wall,0.002; ground_tile,1.00]
  | RM.SnowMnt -> [Tile.Tree1,0.0005; Tile.Tree2,0.02; Tile.Rock1, 0.03; Tile.Rock2, 0.03; Tile.Wall,0.001; 
      Tile.IcyGround, 0.05 +. 0.80 *. high_altitude; ground_tile,1.00]
  | RM.Dungeon -> [Tile.DungeonWall,0.2; ground_tile,1.00]
  | _ -> [Tile.Tree1,0.05; Tile.Tree2,0.05; Tile.Wall,0.05; ground_tile,1.00]
  in

  let area = 
    match rm.RM.biome with
      RM.Dungeon -> 
        let a = Area.make w h Tile.DungeonWall in
        maze a Tile.DungeonWall Tile.DungeonFloor (1,1,w-2,h-2);
        a
    | _ -> Area.init w h (fun _ _ -> any_from_prob_ls prob_ls ) in


  (* add constructions *)
  add_cons area rm;

  (* add stairs *)
  let obj = Obj.empty in
  let obj = 
    if edges_func Down then
      let loc = find_placement_location area obj in
      {obj with Obj.stairsls = (Obj.StairsDown, loc) :: obj.Obj.stairsls}
    else
      obj in
  let obj = 
    if edges_func Up then
      let loc = find_placement_location area obj in
      {obj with Obj.stairsls = (Obj.StairsUp, loc) :: obj.Obj.stairsls}
    else
      obj in


  let explored = Area.make w h None in
 
  (* restart random number initializer *)
  Random.self_init ();
 
  let fac_arr, units_to_gen = 
    let total = Array.fold_left (fun sum v -> sum + v) 0 rm.RM.lat.Mov.fac in
    let arr = Array.make total 0 in

    let _ = Array.fold_left (fun (fac, i) v -> 
      for j = i to i+v-1 do
        arr.(j) <- fac
      done;
      (fac+1, i+v)
    ) (0,0) rm.RM.lat.Mov.fac in
   
    (* shuffle *)
    if total > 0 then
    ( for i = 0 to (total-1) do
        let j = Random.int total in
        let f = arr.(i) in
        arr.(i) <- arr.(j);
        arr.(j) <- f
      done
    );
    (arr, total)
  in

  let upgrade rm sp = 
    Species.upgrade (1.0 -. 0.95 ** RM.get_difficulty rm) sp in

  (* generate units, spend some resources *)
  let ue, lat_mov_left = 
    fold_lim (fun (e_acc, mov_acc) i -> 
      (* let loc = Random.int w, Random.int h in *)
      let loc = find_walkable_location_a_e area e_acc in
      if Tile.can_walk (Tile.classify (Area.get area loc)) && not (E.occupied loc e_acc) then
      ( let fac = fac_arr.(i) in
        let sp = match any_from_ls pol.Pol.prop.(fac).Pol.speciesls with 
          | Some sp -> upgrade rm sp 
          | _ -> failwith "genreg: empty species list" in
        if pol.Pol.prop.(fac).Pol.cl <> Pol.Wild then
        ( (* make a unit with items, use some resources *)
          let u, _ = Unit.make_res mov_acc.Mov.res fac sp None loc in
          (E.upd u e_acc, Mov.subtract_unit mov_acc u) ) 
        else
        ( (* make a unit without items *)
          let u = Unit.make fac sp None loc in
          (E.upd u e_acc, mov_acc) ) 
      )
      else
        (e_acc, mov_acc)
    ) (E.empty, rm.RM.lat) 0 (units_to_gen - 1) in
  
  (* randomly drop items, spend more resources *)
  let make_optinv res =
    let a = Area.make w h None in
    let is_a_dungeon = rm.RM.biome = RM.Dungeon in
    let rec distribute res =
      let obj = Item.Coll.random None in
      let price = Item.decompose obj in
      let price_num = Resource.numeric price in
      if Resource.lesseq price res &&
          ( is_a_dungeon ||
            ( Random.float 1.0 < exp(float (-price_num) /. float Item.Coll.cheap_price) ) ) then
      ( (* let loc = (Random.int w, Random.int h) in *)
        let loc = find_walkable_location_a_e area E.empty in
        if Tile.classify (Area.get area loc) = Tile.CFloor then
        ( let optinv = Area.get a loc in
          match (Inv.ground_drop obj optinv) with 
            Some upd_optinv -> 
              Area.set a loc upd_optinv;
              distribute (Resource.subtract res price)
          | None -> res
        )
        else
          distribute res
      )
      else
        res
    in
    let res_left = distribute res in
    (a, res_left)
  in
 
  (* almost done *)
  let optinv, resources_left = make_optinv lat_mov_left.Mov.res in

  (* latent movables left *)
  let lat_mov_left_2 = Mov.subtract lat_mov_left (Mov.res resources_left) in
  let just_allocated = Mov.subtract rm.RM.lat lat_mov_left_2 in

  let rm' = RM.({rm with alloc = Mov.add rm.alloc just_allocated; lat = lat_mov_left_2}) in

  ({rid=rid; a=area; e=ue; explored; optinv; obj}, rm')

(* generation gunction ends *)
