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
open R

let constructors_dng = 
  List.map
  (fun s -> s |> Carve.load_constructor)
  [ 
    "data/dg/dng1.au";
    "data/dg/dng2.au";
    "data/dg/dng3.au";
    "data/dg/dng4.au";
    "data/dg/dng5.au";
    "data/dg/dng6.au";

    (*
    "data/dg/dng9.au";
    "data/dg/dng10.au";
    *)
  ] |> Array.of_list

let constructors_cave = 
  List.map
  (fun s -> s |> Carve.load_constructor)
  [ 
    "data/dg/cave1.au";
    "data/dg/cave2.au";
    "data/dg/cave3.au";
  ] |> Array.of_list

let constructors_house =
  List.map
  (fun s -> s |> Carve.load_constructor)
  [ 
    "data/dg/house2.au";
  ] |> Array.of_list


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
    let op_door = Tile.Door Tile.IsOpen in
    Area.set area (x,y+dy/2) op_door;
    Area.set area (x+dx,y+dy/2) op_door;
    Area.set area (x+dx/2,y) op_door;
    Area.set area (x+dx/2,y+dy) op_door;
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

let tile_open_closed () = if Random.int 2 = 0 then Tile.IsOpen else Tile.IsClosed

let charmap_std = function
  | '.' -> Tile.WoodenFloor
  | '+' -> Tile.Door (tile_open_closed())
  | '#' -> Tile.Wall
  | _ -> Tile.Grass

let charmap_inv_dng = function
  | '#' -> Tile.DungeonFloor
  | 'x' -> Tile.DungeonDoor (tile_open_closed())
  | '.' -> Tile.DungeonWall
  | _ -> Tile.DungeonFloor

let charmap_inv_cave = function
  | '#' -> Tile.CaveFloor
  | 'x' -> Tile.CaveDoor (tile_open_closed())
  | '.' -> Tile.CaveWall
  | _ -> Tile.CaveFloor

(* returns area and loc0 *)
let build_dungeon cons charmap none_tile w h wtogen htogen =
  match Carve.use_constructor cons wtogen htogen 5 with
  | Some res -> 
      let actualw = Carve.(res.rect.Rect.w) in
      let actualh = Carve.(res.rect.Rect.h) in
        
      let a = Area.make (actualw+2) (actualh+2) none_tile in
      
      let x0 = (w - actualw) / 2 in
      let y0 = (h - actualh) / 2 in
      let dii = Carve.(res.rect.Rect.x0) in
      let djj = Carve.(res.rect.Rect.y0) in
      for i = 0 to actualw-1 do
        for j = 0 to actualh-1 do
          let t = 
            match Carve.block_get res (i+dii,j+djj) with
              Some c -> charmap c
            | None -> none_tile
          in
          Area.set a (i+1,j+1) t
        done
      done;
      (a, (x0,y0))
  | None -> Area.make w h none_tile, (0,0)

let add_house a zones ground_tile (start_x, start_y) wtogen htogen =
  let (info,_) as cons = constructors_house.(0) in

  let rec attempt () =
    match Carve.use_constructor cons wtogen htogen 1 with
    | Some block ->
        
        let all_joints = Carve.find_all_joints info block in

        if Array.length all_joints = 0 then (prerr_endline "add_house try one more time"; attempt () )
        else
        ( let actualw = Carve.(block.rect.Rect.w) in
          let actualh = Carve.(block.rect.Rect.h) in

          let x0 = (wtogen - actualw) / 2 in
          let y0 = (htogen - actualh) / 2 in
          let dii = Carve.(block.rect.Rect.x0) - x0 in
          let djj = Carve.(block.rect.Rect.y0) - y0 in
        
          (* unblock all doors  *)
          let unblock (i,j) = 
            for ii = i-1 to i+1 do
              for jj = j-1 to j+1 do
                if Area.is_within a (ii,jj) then 
                ( if Area.get a (ii,jj) |> Tile.classify |> Tile.can_walk = false then
                    Area.set a (ii,jj) ground_tile
                )
              done
            done
          in
          Array.iter (fun (ii,jj) -> 
            let i = ii - dii + start_x in
            let j = jj - djj + start_y in
            unblock (i,j)
          ) all_joints;
          
          (* blit the house *) 
          for i = 0 to  wtogen-1 do
            for j = 0 to htogen-1 do
              match Carve.block_get block (i+dii,j+djj) with
                Some c -> 
                  let t = charmap_std c in
                  let ij = (start_x+i, start_y+j) in
                  if Tile.classify t <> Tile.CWall then R.Zone.mark zones ij (R.Zone.Cons RM.CHouse);
                  Area.set a ij t

              | None -> ()
            done
          done;
        )
    | None -> ()
  in
  attempt()

let add_market a zones ground_tile (start_x, start_y) wtogen htogen =
  let sq (x,y) (dx, dy) =
    for i = x to x + dx do
      for j = y to y + dy do
        if (i=x || i=x+dx) && (j = y || j =y+dy) then
          Area.set a (i,j) (Tile.MarketStand (Random.int 6))
        else
        ( R.Zone.mark zones (i,j) (R.Zone.Cons RM.CMarket);
          Area.set a (i,j) ground_tile
        )
      done
    done;
    (*
    let op_door = Tile.Door Tile.IsOpen in
    Area.set a (x,y+dy/2) op_door;
    Area.set a (x+dx,y+dy/2) op_door;
    Area.set a (x+dx/2,y) op_door;
    Area.set a (x+dx/2,y+dy) op_door;
    *)
  in
  sq (start_x, start_y) (wtogen-1, htogen-1)

let gen pol edges_func rid rm astr =

  let prng_state = Random.get_state() in

  (* set the seed *)
  Random.init rm.RM.seed;

  let ground_tile = match rm.RM.biome with
    | RM.Mnt | RM.ForestMnt -> Tile.RockyGround
    | RM.SnowMnt -> Tile.SnowyGround
    | RM.Swamp -> Tile.SwampyGround
    | RM.Dungeon -> Tile.DungeonFloor
    | RM.Cave -> Tile.CaveFloor
    | _ -> Tile.Grass
  in

  let high_altitude = float (rm.RM.altitude - 830) /. 170.0 in
  
  let low_altitude = float (200 - rm.RM.altitude) /. 200.0 in

  let prob_ls = match rm.RM.biome with
  | RM.Forest | RM.ForestMnt -> [Tile.Tree1,0.07; Tile.Tree2,0.09; Tile.Rock1, 0.004; Tile.Rock2, 0.004; Tile.Wall,0.002; ground_tile,1.00]
  | RM.DeepForest -> [Tile.Tree1,0.07; Tile.Tree2,0.12; Tile.Rock1, 0.003; Tile.Rock2, 0.003; Tile.Wall,0.0005; ground_tile,1.00]
  | RM.Plains -> [Tile.Tree1,0.02; Tile.Tree2,0.01; Tile.Rock1, 0.002; Tile.Rock2, 0.002; Tile.Wall,0.001; ground_tile,1.00]
  | RM.Swamp -> [Tile.Tree1,0.005; Tile.Tree2,0.04; Tile.Wall,0.002; 
      Tile.SwampyPool,0.05 +. 0.6 *. low_altitude; ground_tile,1.00]
  | RM.Mnt -> [Tile.Tree1,0.005; Tile.Tree2,0.03; Tile.Rock1, 0.02; Tile.Rock2, 0.02; Tile.Wall,0.002; ground_tile,1.00]
  | RM.SnowMnt -> [Tile.Tree1,0.0005; Tile.Tree2,0.02; Tile.Rock1, 0.03; Tile.Rock2, 0.03; Tile.Wall,0.001; 
      Tile.IcyGround, 0.05 +. 0.80 *. high_altitude; ground_tile,1.00]
  | RM.Dungeon -> [Tile.DungeonWall,0.2; ground_tile,1.00]
  | RM.Cave -> [Tile.CaveWall,0.2; ground_tile,1.00]
  | _ -> [Tile.Tree1,0.05; Tile.Tree2,0.05; Tile.Wall,0.05; ground_tile,1.00]
  in

  let area, loc0 = 
    let w = 24 in
    let h = 15 in
    let take_any arr = arr.(Random.int (Array.length arr)) in
    match rm.RM.biome with
    | RM.Dungeon -> 
        (* maze a Tile.DungeonWall Tile.DungeonFloor (1,1,w-2,h-2); *)
        let cons = take_any constructors_dng in
        build_dungeon cons charmap_inv_dng Tile.DungeonWall w h (w-2) (h-2)
    | RM.Cave -> 
        (* maze a Tile.DungeonWall Tile.DungeonFloor (1,1,w-2,h-2); *)
        let cons = take_any constructors_cave in
        build_dungeon cons charmap_inv_cave Tile.CaveWall w h (w-2) (h-2)
    | _ -> Area.init w h (fun _ _ -> any_from_prob_ls prob_ls ), (0,0) in


  (* add N, S, W, E exits *)
  List.iter 
    ( fun (dir, loc0, dloc) ->
        if edges_func dir then
        ( let not_a_floor loc = Area.is_within area loc && not ((Area.get area loc |> Tile.classify) = Tile.CFloor) in
          let rec repeat loc =
            if not_a_floor loc then
            ( Area.set area loc ground_tile;
              
              if (List.for_all (fun d -> (d++dloc = (0,0)) || not_a_floor (loc++d)) [(1,0); (-1,0); (0,1); (0,-1)]) then
                repeat (loc ++ dloc)
            )
            else 
              ()
          in
          repeat loc0
        )
    ) 
    ( let x = Area.w area - 1 in let y = Area.h area - 1 in 
      [ (North, (x/2, y), ( 0,-1));
        (South, (x/2, 0), ( 0, 1));
        (East,  (x, y/2), (-1, 0));
        (West,  (0, y/2), ( 1, 0));
      ] 
    );
  
  (* block the edges *)
  List.iter 
    ( fun (dir, x0, y0, x1, y1, dx, dy) ->
        if not (edges_func dir) then 
        ( (* if no exit, block the edge with a wall *)
          match rm.RM.biome with
          | RM.Dungeon | RM.Cave -> ()
          | _ -> 
              for x = x0 to x1 do
                for y = y0 to y1 do
                  for i = 0 to 0 + Random.int 2 + Random.int 2 + Random.int 2 do
                    let loc = (x + i*dx, y + i*dy) in
                    let t = Area.get area loc in
                    if t |> Tile.classify |> Tile.can_walk then
                    ( match Random.int (i+1) with
                      | 0 -> Area.set area (x + i*dx,y + i*dy) (Tile.BigRock (Random.int 4));
                      | 1 -> Area.set area (x + i*dx,y + i*dy) (if Random.int 2 = 0 then Tile.Rock1 else Tile.Rock2);
                      | _ -> Area.set area (x + i*dx,y + i*dy) (if Random.int 2 = 0 then Tile.Tree2 else Tile.Tree2);
                    )
                  done
                done
              done
        )
    )
    ( let x = Area.w area - 1 in let y = Area.h area - 1 in 
      [ North, 0, y, x, y, 0, -1;
        South, 0, 0, x, 0, 0, 1;
        East, x, 0, x, y, -1, 0;
        West, 0, 0, 0, y, 1, 0;
      ]
    );
  
  (* add constructions *)
  (* add_cons area rm; *)
  let zones =
    let zones = Area.make (Area.w area) (Area.h area) R.Zone.S.empty in

    let midgapx = 3 in 
    let midgapy = 2 in 
    let housew = (Area.w area - 2 - midgapx)/2 in
    let househ = (Area.h area - 2 - midgapy)/2 in
    let permutations =
      let a = [|(1,1); (1,1 + househ + midgapy); (1 + housew + midgapx,1); (1 + housew + midgapx, 1 + househ + midgapy)|] in
      array_permute a;
      a
    in
    List.iteri (fun i {RM.constype=ct; RM.consloc=loc} ->
      match ct with
      | RM.CMarket -> add_market area zones ground_tile permutations.(i) housew househ 
      | _ -> add_house area zones ground_tile permutations.(i) housew househ 
    ) rm.RM.cons;

    zones
  in

  (* add specials *)
  List.iter (function 
    | RM.BonusTower b ->
        Area.set area (Area.w area / 2, Area.h area / 2) (Tile.BonusTower b);
  ) rm.RM.specials;

  (* add stairs *)
  let obj = Obj.empty (Area.w area) (Area.h area) in
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

  (* add doors and other positional objects from the generated map *)
  let _ =
    for i = 0 to (Area.w area) - 1 do
      for j = 0 to (Area.h area) - 1 do
        let tile = Area.get area (i,j) in
        let cl = tile |> Tile.classify in
        match cl with
        | Tile.CDoor Tile.IsOpen ->
            Area.set obj.Obj.posobj (i,j) (Some (Obj.Door Obj.Open))
        | Tile.CDoor Tile.IsClosed ->
            Area.set obj.Obj.posobj (i,j) (Some (Obj.Door Obj.Closed))
        | Tile.CWall ->
            ( match tile with 
              | Tile.BonusTower b -> Area.set obj.Obj.posobj (i,j) (Some (Obj.BonusTower b))
              | _ -> ()
            )
        | _ -> ()
      done
    done 
  in

  let explored = Area.make (Area.w area) (Area.h area) None in
 
  (* restart random number initializer *)
  Random.set_state prng_state;
 
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

  (* add actors *)
  let ue_actors_added =
    Org.Astr.fold_at rid 
      ( fun e_acc a ->
          let loc = 
            match Org.Actor.get_wcl a with
            | Org.Actor.WC_Merchant when RM.has_market rm -> 
                find_walkable_location_zone_a_e_z (R.Zone.Cons RM.CMarket) area e_acc zones
            | _ -> find_walkable_location_a_e area e_acc 
          in
          if Tile.can_walk (Tile.classify (Area.get area loc)) then
          ( let u = Org.Actor.make_unit a loc in
            E.upd u e_acc 
          )
          else
            e_acc
      )
      E.empty
      astr
  in

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
        
        let u, _ = Unit.make_res mov_acc.Mov.res fac sp None loc in
        (E.upd u e_acc, Mov.subtract_unit mov_acc u)  
        (*
        if pol.Pol.prop.(fac).Pol.cl <> Pol.Wild then
        ( (* make a unit with items, use some resources *)
          let u, _ = Unit.make_res mov_acc.Mov.res fac sp None loc in
          (E.upd u e_acc, Mov.subtract_unit mov_acc u) ) 
        else
        ( (* make a unit without items *)
          let u = Unit.make fac sp None loc in
          (* change its inventory to animal inventory *)
          let u = Unit.({u with core = {u.core with Core.inv = Inv.animal}}) in
          (E.upd u e_acc, mov_acc) ) 
        *)
      )
      else
        (e_acc, mov_acc)
    ) (ue_actors_added, rm.RM.lat) 0 (units_to_gen - 1) in
  
  (* randomly drop items, spend more resources *)
  let make_optinv res =
    let a = Area.make (Area.w area) (Area.h area) None in
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

  ({rid=rid; a=area; e=ue; explored; optinv; zones; obj; loc0}, rm')

(* generation gunction ends *)
