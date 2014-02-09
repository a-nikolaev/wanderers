open Base
open Common
open Global

(* 
   
  Moving the current region.
 
  Region generation is called here

*)

let prio_bump pol edge_func addrid rmarr pl =
  (* keep nkeep-many elements excepti the bumped *)
  let rec split bumped nkeep acc = function 
    | hd::tl when nkeep > 0 ->
        let acc' = if hd <> bumped then hd::acc else acc in
        split bumped (nkeep-1) acc' tl
    | rem -> (List.rev acc, rem) in

  let keep, rem = split addrid (Prio.num-1) [] pl.Prio.rank in

  let rank' = addrid::keep in
  (* remove those that are discarded *)
  let ml' = List.fold_left 
    ( fun ml rid -> 
        if Prio.Ml.mem rid ml && rid <> addrid then 
        ( let rm = rmarr.(rid) in
          rmarr.(rid) <- {rm with 
            RM.lat = Mov.add (R.decompose (Prio.Ml.find rid ml)) rm.RM.lat; 
            RM.alloc = Mov.zero()};
          Prio.Ml.remove rid ml )
        else ml ) 
    pl.Prio.ml rem in
  (* add a new one *)
  let ml'' = 
    if Prio.Ml.mem addrid ml' then ml' else 
    ( let reg, rm' = Genreg.gen pol edge_func addrid rmarr.(addrid) in
      rmarr.(addrid) <- rm';
      Prio.Ml.add addrid reg ml' 
    )
    in
  Prio.({ml = ml''; rank = rank'})

open G

(* move your current region *)
let move pol dir g =
  let nb = g.nb.(g.currid) in
  if Me.mem dir nb then
  ( let nrid = Me.find dir nb in
    (* add immediate neighbors *)
    let bump pol rid prio = 
      let edge_func dir = Me.mem dir g.nb.(rid) in
      prio_bump pol edge_func rid g.rm prio 
    in 
    let nnb = g.nb.(nrid) in
    let prio1 = Me.fold (fun dir rid prio_acc -> bump pol rid prio_acc) nnb g.prio in
    let prio2 = bump pol nrid prio1 in
    {g with currid=nrid; prio=prio2}
  )
  else
    g

(* unit transfers from one region to another. *)
let unit_transfer u reg pol b_move_currid g = 
  match u.Unit.transfer with
  | Some edge ->
     
      let u1 = {u with Unit.transfer = None; Unit.ac = [Wait (u.Unit.loc, 0.0)]; Unit.tactmem = Unit.TactMem.empty;} in
      
      let nb = g.nb.(reg.R.rid) in
      if Me.mem edge nb then
      ( let nrid = Me.find edge nb in
        match Prio.get nrid g.prio with
          Some nreg ->
            ( (*
              match find_entry_loc u.Unit.loc edge nreg.R.a nreg.R.obj with
              | Some new_loc -> 
                  (* if could find an entry location *)
                  let u2 = {u1 with Unit.loc = new_loc; Unit.pos = vec_of_loc new_loc; ac=[Wait (new_loc, 0.0)]} in
                  (* transfer to the new reg *)
                  let g1 = 
                    g |> upd {reg with R.e = E.rm u reg.R.e}
                      |> upd {nreg with R.e = E.upd u2 nreg.R.e} in
                  (* move currid if asked to do so *)
                  if b_move_currid then move pol edge g1 else g1
              | None ->
                  (* if could not find an entry location *)
                  upd {reg with R.e = E.upd u1 reg.R.e} g
              *)
              let new_loc = 
                match find_entry_loc u.Unit.loc edge nreg.R.a nreg.R.obj with
                  Some loc -> loc 
                | None -> find_walkable_location_reg nreg in
              let u2 = {u1 with Unit.loc = new_loc; Unit.pos = vec_of_loc new_loc; ac=[Wait (new_loc, 0.0)]} in
              (* transfer to the new reg *)
              let g1 = 
                g |> upd {reg with R.e = E.rm u reg.R.e}
                  |> upd {nreg with R.e = E.upd u2 nreg.R.e} in
              (* move currid if asked to do so *)
              if b_move_currid then move pol edge g1 else g1 
            )
        | None -> 
            (* simply remove the unit *)
            upd {reg with R.e = E.rm u reg.R.e} g 
      )
      else
        (* no such exit edge *)
        upd {reg with R.e = E.upd u1 reg.R.e} g

  | None -> g 
