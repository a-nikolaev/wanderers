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


(* Global map object *)


(* Kinda priority list of R.t *)
module Prio = struct
  module Ml = Map.Make(struct type t = region_id let compare = compare end)
  type 'a t = {ml: 'a Ml.t; rank: region_id list}
  let num = 10
  
  let make () =
    {ml=Ml.empty; rank=[]}

  let upd r pl = 
    if Ml.mem r.R.rid pl.ml then {pl with ml = Ml.add r.R.rid r pl.ml} else pl

  let get rid pl = 
    if Ml.mem rid pl.ml then Some (Ml.find rid pl.ml) else None
end


(* Global map graph *)
module G = struct
  (* maps edge type to smthing *)
  module Me = Map.Make(struct type t = edge_type let compare = compare end)
  type geo = {currid : region_id; loc: region_loc array; rm: RM.t array; 
   nb: (region_id Me.t) array; prio: R.t Prio.t}
  
  let length g = Array.length g.rm

  (* see module Genmap for generating geo objects *)

  (* update region *)
  let upd r g = {g with prio = Prio.upd r g.prio}
  
  (* region option by rid *)
  let getro rid g = Prio.get rid g.prio 
  (* current region *)
  let curr g = match Prio.get g.currid g.prio with Some r -> r | _ -> failwith "current region is invalid"

  (* current + neighbour regions list *)
  let curnb_ls g = 
    Me.fold ( fun _ rid ls -> 
      match Prio.get rid g.prio with
        Some reg -> reg :: ls
      | _ -> ls )
      (g.nb.(g.currid))    
      [curr g] 
  
  (* only neighbour regions list *)
  let get_nb_ls givenrid g = 
    Me.fold ( fun _ rid ls -> 
      match Prio.get rid g.prio with
        Some reg -> reg :: ls
      | _ -> ls )
      (g.nb.(givenrid))    
      [] 
  
  (* only neighbour regions list *)
  let only_nb_ls g = get_nb_ls g.currid g 

  (* get rid of a neighbor *)
  let get_nb g rid dir =
    let nb = g.nb.(rid) in
    if Me.mem dir nb then
      Some (Me.find dir nb)
    else
      None

  let get_only_nb_rid_ls givenrid g =
    Me.fold (fun _ rid ls -> rid :: ls) (g.nb.(givenrid)) [] 


end

(* get faction *) 
let fget_lat g rig faction = g.G.rm.(rig).RM.lat.Mov.fac.(faction) 
let fget_alloc g rig faction = g.G.rm.(rig).RM.alloc.Mov.fac.(faction) 
let fget g rig faction = g.G.rm.(rig).RM.lat.Mov.fac.(faction) + g.G.rm.(rig).RM.alloc.Mov.fac.(faction)
let fset_lat g rig faction v = g.G.rm.(rig).RM.lat.Mov.fac.(faction) <- v 
let fnum g = Array.length g.G.rm.(0).RM.lat.Mov.fac 

(* get resources *)
let rget_lat g rig = g.G.rm.(rig).RM.lat.Mov.res 
let rget_alloc g rig = g.G.rm.(rig).RM.alloc.Mov.res 
let rget g rig = Resource.add g.G.rm.(rig).RM.alloc.Mov.res g.G.rm.(rig).RM.lat.Mov.res 
let rset_lat g rig res = g.G.rm.(rig) <- {g.G.rm.(rig) with RM.lat = {g.G.rm.(rig).RM.lat with Mov.res = res}}



(* Player's map memory *)
module Atlas = struct
  type mark = 
    | Occupied of (faction * int)
    | Market
    | StairsDown
    | StairsUp

  module RidKey = struct type t = region_id let compare = compare end
  module Mrid = Map.Make(RidKey)

  module Srloc = Set.Make(struct type t = region_loc let compare = compare end)

  type rmpoint = {rid: region_id; rloc: region_loc; biome:RM.biome; markls: mark list}
  type t = {
    rmp: (rmpoint option) array;
    visible : int Mrid.t;
    currid : region_id;
    curloc : region_loc;
    mountains : Srloc.t
  }
  
  let visible_rid_of_rloc atlas rloc =
    Array.fold_left (fun opt opt_rmp -> 
      ( match opt_rmp with Some rmp when rmp.rloc = rloc -> Some rmp.rid | _ -> opt )
    ) None atlas.rmp

  let iter_visible f atlas = 
    Mrid.iter (fun rid _ ->
        match atlas.rmp.(rid) with
          Some rmp -> f rmp
        | _ -> ()
      ) atlas.visible

  let biome_radius = function
    | RM.DeepForest -> 0
    | RM.ForestMnt | RM.Forest -> 1
    | _ -> 2
  
  let biome_radius_reduction = function
    | RM.DeepForest -> 2
    | RM.ForestMnt | RM.Forest -> 1
    | _ -> 1

  (* auxiliary function computing Mrid for the neighboring tiles *)
  let rec explore geo rid radius mrid =
    let do_update = (* true if the region is not ~ explored fully ~ *)
      not (Mrid.mem rid mrid) ||
      ( let prev_radius = Mrid.find rid mrid in
        radius > prev_radius )
    in
    if do_update then
    ( let mrid' = Mrid.add rid radius mrid in
      G.Me.fold
        ( fun edge nbrid mridacc ->
          match edge with  
          | East | West | North | South ->
            let incr_radius = 
              (geo.G.rm.(rid).RM.altitude - geo.G.rm.(nbrid).RM.altitude) / 150 
            in
            let radius_reduction = biome_radius_reduction geo.G.rm.(rid).RM.biome in
            let radius' = radius - radius_reduction + incr_radius in

            if radius > 0 then
              explore geo nbrid radius' mridacc 
            else
              mridacc

          | _ -> mridacc
         )
        geo.G.nb.(rid) mrid' 
    )
    else mrid

  (* compute map of all visible rids *)
  let comp_visible rid geo =
    let z,loc = geo.G.loc.(rid) in
    (* no vision in dungeons *)
    if z < 0 then 
      explore geo rid 0 Mrid.empty 
    else
      explore geo rid (biome_radius geo.G.rm.(rid).RM.biome) Mrid.empty 
  
  (* map of all rids *)
  let comp_all rid geo =
    fold_lim (fun acc rid ->
      Mrid.add rid 1 acc
    ) Mrid.empty 0 (Array.length geo.G.rm - 1)

      
  let comp_markls pol rm nb =
    let stairs_markls =
      (if G.Me.mem Up nb then [StairsUp] else []) @ 
      (if G.Me.mem Down nb then [StairsDown] else []) in

    let stairs_markls =
      let (max_fac, max_fac_pop) = 
        fold_lim 
          ( fun (mf, mpop) f -> 
              let pop = rm.RM.lat.Mov.fac.(f) + rm.RM.alloc.Mov.fac.(f) in
              if pop > mpop && pol.Pol.prop.(f).Pol.cl <> Pol.Wild then (f,pop) else (mf,mpop)
          ) (0, 0) 0 (Array.length rm.RM.lat.Mov.fac - 1) in
      if max_fac_pop > 5 then
        (Occupied (max_fac, max_fac_pop)) :: stairs_markls
      else
        stairs_markls
    in

    let stairs_markls =
      if RM.has_market rm then
        Market :: stairs_markls
      else
        stairs_markls
    in
    stairs_markls
  
  (* update the atlas from the map of rids *)
  let update_generic comp_func pol geo atlas = 
    let currid = geo.G.currid in
    let visible = comp_func currid geo in
    (* update teh rmpoint array *)
    Mrid.iter (fun rid _ ->
      atlas.rmp.(rid) <- 
        Some {rid=rid; rloc = geo.G.loc.(rid); biome = geo.G.rm.(rid).RM.biome; 
          markls = comp_markls pol geo.G.rm.(rid) geo.G.nb.(rid)}
    ) visible;
    (* update the mountains set *)
    let mountains =
      Mrid.fold (fun rid _ acc ->
        let (z, (x,y)) as rloc = geo.G.loc.(rid) in
        if z = 0 then
          List.fold_left (fun acc (edge,(dx,dy)) ->
            if G.Me.mem edge geo.G.nb.(rid) then
              acc
            else
              Srloc.add (z,(x+dx, y+dy)) acc
          )
          acc [East,(1,0); North,(0,1); West,(-1,0); South,(0,-1)]
        else
          acc
      ) visible atlas.mountains
    in
    {atlas with visible; currid; curloc = geo.G.loc.(currid); mountains}

  let update = update_generic comp_visible 
  
  let update_all = update_generic comp_all 

  let make pol geo =
    let rmnum = Array.length geo.G.rm in
    let rmp = Array.make rmnum None in
    update pol geo {rmp; visible = Mrid.empty; currid = 0; curloc = (0,(0,0)); mountains = Srloc.empty}

end
