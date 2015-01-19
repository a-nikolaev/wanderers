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
  let ls3 = 
    List.filter (fun proj -> 
      match proj.Proj.item.Proj.tp with
      | Proj.EngCharge -> vec_len2 proj.Proj.vel > 0.1 && proj.Proj.item.Proj.dmgmult > 0.1 
      | _ -> vec_len2 proj.Proj.vel > 0.5
    ) ls3 in

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
      | R.Obj.BonusTower x -> R.Obj.BonusTower x
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

let toggle_bonus_tower loc (u, reg, rm) =

  let oa = R.(reg.obj.Obj.posobj) in
  let ta = reg.R.a in

  let u = 
    ( match Area.get oa loc with
      | Some ((R.Obj.BonusTower true) as obj) -> 
          Area.set oa loc (Some (R.Obj.BonusTower false));
          Area.set ta loc (Tile.BonusTower false);

          let core = Unit.get_core u in
          let prop = core.Unit.Core.prop in
          let d_atl = 1.0 in
          let d_rct = -0.1 *. prop.Unit.Core.reaction in
          let d_cns = 5.0 in
          let d_mgc = 0.05 in
          
          let prop = {prop with 
              athletic = prop.Unit.Core.athletic +. d_atl;
              reaction = prop.Unit.Core.reaction +. d_rct;
              magic_aff = prop.Unit.Core.magic_aff +. d_mgc;
              max_eng = (prop.Unit.Core.magic_aff +. d_mgc) *. 16.0 |> round |> float;
              mass = prop.Unit.Core.mass +. d_cns;
            }
          in
          let core = {core with Unit.Core.prop = prop} |> Unit.Core.adjust_aux_info in

          let u = Unit.upd_core core u |> Unit.heal 1000.0 |> Unit.add_energy 100.0 in

          {u with Unit.ntfy = (NtfyOther "ATL+ RCT- CNS+ MGC+", 0.0) :: u.Unit.ntfy;}
      | _ -> u
    )
  in

  let rm = {rm with RM.specials = List.map (function RM.BonusTower true -> RM.BonusTower false | x -> x) rm.RM.specials} in

  let upd_reg u reg = {reg with R.e = E.upd u reg.R.e} in
  (u, upd_reg u reg, rm)

let upd_one_movobj dt reg movobj =
  match movobj with
    | R.Obj.Magical (R.Obj.Spark (loc, vec, pow, t)) ->
        let t' = t +. dt in
        let pow' = pow *. exp(-.0.1*.dt) in
        if t' < 4.0 && pow > 0.05 then 
          Some (R.Obj.Magical (R.Obj.Spark (loc, vec, pow', t')))
        else
          None

let upd_energyspots dt reg =
  let ls = reg.R.obj.R.Obj.energyspots in
  if List.length ls < 1 then
    let energyspots = fold_lim (fun acc _ -> 
        let loc = find_walkable_location_reg reg in
        let pow = (Prob.normal 1.0 1.0) |> min 0.1 |> max 4.0 in
        ((loc, pow), pow)::acc
      ) [] 0 (1 + Random.int 2 + Random.int 2 + Random.int 2) in
    {reg with R.obj = {reg.R.obj with R.Obj.energyspots = energyspots}}
  else
    reg

let upd_movls dt reg = 
  (* move the existing ones *)
  let movls = 
    List.fold_left 
      (fun acc mo -> 
        match upd_one_movobj dt reg mo with
          Some umo -> umo :: acc
        | _ -> acc
      ) [] reg.R.obj.R.Obj.movls 
  in
  
  (* give energy to units *)
  let reg =
    let ue =
      List.fold_left 
        (fun e_acc mo -> 
          match mo with
          | R.Obj.Magical (R.Obj.Spark (loc, vec, pow, t)) ->
              let nb = E.collisions_nb_vec vec e_acc in
              let num = List.length nb in
              if num > 0 then
                let mag = 0.1 *. pow *. dt /. float num in
                List.fold_left (fun e_acc u ->
                  let u' = Unit.add_energy (mag *. (Unit.get_magic_aff u)) u in
                  E.upd u' e_acc
                ) e_acc nb
              else
                e_acc
          | _ -> e_acc
        ) reg.R.e reg.R.obj.R.Obj.movls 
    in 
    {reg with R.e = ue}
  in

  (* add new ones *)
  let energyspots = reg.R.obj.R.Obj.energyspots in
  let spark_rate = List.fold_left (fun acc (_, rate) -> acc +. rate) 0.0 energyspots in

  let num = Prob.poisson_in_dt (0.2 *. spark_rate) dt in  
  let find_location_lambda () =
    let loc, pow = any_from_rate_ls energyspots in
    loc, ((2.0 -. pow) |> max 0.5)
  in

  let movls =
    fold_lim (fun acc _ -> 
        let loc, lambda = 
          if Random.int 5 > 0 then find_location_lambda() else (find_walkable_location_reg reg, 1.0) 
        in
        let vec = 
          let phi = Random.float (2.0 *. 3.141592) in
          let r = Prob.normal 0.4 0.15 in
          vec_of_loc loc ++. (r *. cos phi, r *. sin phi -. 0.2)
        in
        let pow = Prob.exponential lambda in
        R.Obj.Magical(R.Obj.Spark (loc, vec, pow, 0.0)) :: acc
      ) movls 1 num
  in
  {reg with R.obj = {reg.R.obj with R.Obj.movls = movls}}

