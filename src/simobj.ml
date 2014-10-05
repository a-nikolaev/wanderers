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
          
let find_target pj nb_ls = 
  (* minimize *)
  let minimize_this u = 
    let dvec = (u.Unit.pos --. pj.Proj.pos) in
    let touch u = vec_dot_prod dvec pj.Proj.vel in
    let t = touch u in 
    if t > 0.0 && (vec_len dvec < Unit.get_radius u) then 
      t +. vec_len dvec 
    else 
      infinity in
  let x, _ =
    List.fold_left 
      ( fun (ou_best, v_best) u ->
          let v = minimize_this u in
          if v >= v_best then (ou_best, v_best) else (Some u, v)
      ) (None, 100.0) nb_ls in
  x

let upd_projectiles dt reg = 
  let ls = reg.R.obj.R.Obj.projls in
  (* move *)
  let ls1 = List.map (fun pj -> Proj.move dt pj) ls in

  (* filter outside *)
  let ls2 = List.filter 
    (fun proj -> Area.is_within reg.R.a (loc_of_vec proj.Proj.pos)) ls1 in

  (* slowdown *)
  let ls3 = List.map (fun pj ->
      let tile = Area.get reg.R.a (loc_of_vec pj.Proj.pos) in
      if not (Tile.can_walk (Tile.classify tile)) then
        let mv = pj.Proj.item.Proj.mass %%. pj.Proj.vel in
        let mv_len = vec_len mv in
        let dmv = 10.0 *. mv_len *. dt in
        let mv' = (max (mv_len -. dmv) 0.0 /. mv_len) %%. mv in
        Proj.({pj with vel = (1.0/.pj.item.mass) %%. mv'})
      else
        pj
    ) ls2 in
  
  (* filter slow *)
  let ls3 = List.filter (fun proj -> vec_len2 proj.Proj.vel > 0.5) ls3 in

  (* damage *)
  let ls4, ue =
    let rec next_proj (lsacc, ueacc) = function 
      | pj::tl ->
          let nb = E.collisions_nb_vec pj.Proj.pos ueacc in
          ( match find_target pj nb with
              Some u ->
                let dmgmult = pj.Proj.item.Proj.dmgmult in
                
                let mv = pj.Proj.item.Proj.mass %%. pj.Proj.vel in
                let mv_len = vec_len mv in
                let strike = 10.0 *. mv_len *. dt in
                let mv' = (max (mv_len -. strike) 0.0 /. mv_len) %%. mv in
                let pj' = Proj.({pj with vel = (1.0/.pj.item.mass) %%. mv'}) in
                
                let u' = Unit.damage (strike, mv, dmgmult) u in

                next_proj (pj'::lsacc, E.upd u' ueacc) tl

            | _ -> next_proj (pj::lsacc, ueacc) tl
          )
      | _ -> (lsacc, ueacc)
    in
    next_proj ([], reg.R.e) ls3
  in

  (* E.at_loc  reg.R.e *)
  R.({reg with obj = {reg.obj with Obj.projls = ls4}; e = ue})

 
let add proj reg =
  let ls = reg.R.obj.R.Obj.projls in
  R.({reg with obj = {reg.obj with Obj.projls = proj::ls}})


let toggle_door u loc reg =
 
  if not (E.occupied loc reg.R.e) then
  (  
    let oa = R.(reg.obj.Obj.posobj) in
    let ta = reg.R.a in

    let obj_inv = function
      | R.Obj.Door s -> R.Obj.Door ( match s with R.Obj.Open -> R.Obj.Closed | R.Obj.Closed -> R.Obj.Open )
    in
    
    let tile_inv = 
      let inv = function Tile.IsOpen -> Tile.IsClosed | Tile.IsClosed -> Tile.IsOpen in
      function
      | Tile.DungeonDoor s -> Tile.DungeonDoor (inv s)
      | Tile.CaveDoor s -> Tile.CaveDoor (inv s)
      | Tile.Door s -> Tile.Door (inv s)
      | x -> x
    in
    
    ( match Area.get oa loc with
      | Some (R.Obj.Door s) -> 
          Area.set oa loc (Some (obj_inv (R.Obj.Door s)));
          Area.set ta loc (tile_inv (Area.get ta loc));
      | _ -> ()
    );
    reg
  )
  else
    reg
