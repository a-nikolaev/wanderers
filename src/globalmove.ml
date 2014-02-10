open Base
open Common
open Global

(* 
   
  Moving the current region.
 
  Region generation is called here

*)

let prio_bump pol astr edge_func addrid rmarr pl =
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
    ( let reg, rm' = Genreg.gen pol edge_func addrid rmarr.(addrid) astr in
      rmarr.(addrid) <- rm';
      Prio.Ml.add addrid reg ml' 
    )
    in
  Prio.({ml = ml''; rank = rank'})

open G

(* move your current region *)
let move pol astr dir g =
  let nb = g.nb.(g.currid) in
  if Me.mem dir nb then
  ( let nrid = Me.find dir nb in
    (* add immediate neighbors *)
    let bump pol rid prio = 
      let edge_func dir = Me.mem dir g.nb.(rid) in
      prio_bump pol astr edge_func rid g.rm prio 
    in 
    let nnb = g.nb.(nrid) in
    let prio1 = Me.fold (fun dir rid prio_acc -> bump pol rid prio_acc) nnb g.prio in
    let prio2 = bump pol nrid prio1 in
    {g with currid=nrid; prio=prio2}
  )
  else
    g

(* unit transfers from one region to another. *)
let unit_transfer u reg pol b_move_currid (g, astr) = 
  let g_upd, astr_upd = 
    match u.Unit.transfer with
    | Some edge ->
       
        let u1 = {u with Unit.transfer = None; Unit.ac = [Wait (u.Unit.loc, 0.0)]; Unit.tactmem = Unit.TactMem.empty;} in
        
        let nb = g.nb.(reg.R.rid) in
        if Me.mem edge nb then
        ( let nrid = Me.find edge nb in
          let g_upd = 
            match Prio.get nrid g.prio with
              Some nreg ->
                ( let new_loc = 
                    match find_entry_loc u.Unit.loc edge nreg.R.a nreg.R.obj with
                      Some loc -> loc 
                    | None -> find_walkable_location_reg nreg in
                  let u2 = {u1 with Unit.loc = new_loc; Unit.pos = vec_of_loc new_loc; ac=[Wait (new_loc, 0.0)]} in
                  (* transfer to the new reg *)
                  let g1 = 
                    g |> upd {reg with R.e = E.rm u reg.R.e}
                      |> upd {nreg with R.e = E.upd u2 nreg.R.e} in
                  (* move currid if asked to do so *)
                  if b_move_currid then move pol astr edge g1 else g1 
                )
            | None -> 
                (* simply remove the unit *)
                upd {reg with R.e = E.rm u reg.R.e} g 
          in
          (* actors' transfer works even if the unit is decomposed when leaving the detailed simulation region *)
          let astr_upd = match Unit.get_optaid u1 with 
            | None -> astr
            | Some aid -> 
                ( match Org.Astr.get aid astr with
                  | Some a -> Org.Astr.move_actor a nrid astr
                  | None -> astr
                )
          in
          (g_upd, astr_upd)
        )
        else
          (* no such exit edge *)
          (upd {reg with R.e = E.upd u1 reg.R.e} g, astr)
    | None -> (g, astr)
  in
  (g_upd, astr_upd)
