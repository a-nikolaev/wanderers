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
open Item

(* SrcUnit (unit_id, ci) *)
type cnt_src = SrcGround of loc | SrcUnit of (int * int) | SrcOther of Cnt.t

type label = Text of string | TrSellPrice of int | TrBuyPrice of int

type ui_el = C of (int * string) | Info | Lbl of (label list)

type static = {
    tr: Trade.trader;
    n: int; (* = 10 by default *)
    width: int;
    src: (cnt_src option) array;
    permissions: (bool array) array; 
    tr_sell_ci: int;
    tr_buy_ci: int;
    tr_merchant_ci: int;

    u_uid: int; (* customer unit id *)
    m_uid: int; (* merchant unit id *)

    m_aid: int; (* merchant actor id *)

    ui_el: ui_el array; (* different indexation ! *)
  }

type t = {
    s: static; 

    cnt: Cnt.t array;
    dst_ok: bool array;

    ui_el_i: int;
    ci: int;
    si: int;
  }

let check_dst bar i = if i < 0 || i >= bar.s.n then false else match bar.s.src.(i) with Some _ -> true | _ -> false


let get_cnt_from_source reg s i =
  match s.src.(i) with
  | Some (SrcGround loc) ->
      let inv = 
        match Area.get reg.R.optinv loc with
        | Some inv -> inv 
        | None -> Inv.ground 
      in
      ( match Inv.container 0 inv with
        | Some cnt -> cnt
        | None -> failwith "Barter: init"
      )
  | Some (SrcUnit (uid,uci)) -> 
      ( match E.id uid reg.R.e with
        | Some u -> 
          ( match Inv.container uci (Unit.get_inv u) with
            | Some cnt -> cnt
            | None -> failwith "Barter: init: container not found"
          )
        | None -> failwith "Barter: init: unit not found"
      )
  | Some (SrcOther cnt) -> cnt
  | None -> Cnt.empty_limited 0


let make_offer_cnt u tr =
  let ls =
    match Trade.make_default_offer_ls (Unit.get_core u) tr with
    | Some money_bunch, ls -> money_bunch :: ls
    | None, ls -> ls
  in
  let c = Item.Cnt.empty_unlimited in
  List.fold_left (fun c b -> 
    match Item.Cnt.put_bunch b c with 
    | Item.Cnt.MoveBunchSuccess cc -> cc
    | _ -> c
  ) c ls


let init reg s =

  (*
  Trade.print_trader s.tr;
  *)

  let ui_el_i, ci = let rec search i = match s.ui_el.(i) with C (ci,_) -> (i, ci) | _ -> search (i+1) in search 0 in
  { s = s;
    ui_el_i; 
    ci; 
    si = 0;
    dst_ok = Array.init s.n (fun i -> match s.src.(i) with Some _ -> true | _ -> false);
    cnt = Array.init s.n (fun i -> get_cnt_from_source reg s i);
  }

let update_one_source bar i reg = 
  match bar.s.src.(i) with
  | Some (SrcGround loc) -> 
      let new_opt_inv =
        if Cnt.is_empty bar.cnt.(i) then 
          None 
        else 
          Some (Inv.upd_container 0 (bar.cnt.(i)) Inv.ground)
      in
      Area.set reg.R.optinv loc new_opt_inv;
      reg

  | Some (SrcUnit (uid,uci)) -> 
      ( match E.id uid reg.R.e with
        | Some u -> 
            let inv = Inv.upd_container uci bar.cnt.(i) (Unit.get_inv u) in
            let u = Unit.upd_inv inv u in
            let e = E.upd u reg.R.e in
            {reg with R.e = e}
        | None -> failwith "Barter: update_one_source: unit not found"
      )
  | _ -> reg

let update_all_sources bar reg = 
  fold_lim (fun reg i ->
    update_one_source bar i reg
  ) reg 0 (bar.s.n-1)

let rec walk_ui deli bar = 
  if deli = 0 then bar
  else
  ( let d = if deli < 0 then -1 else 1 in
    let len = Array.length bar.s.ui_el in
    let new_eli = (bar.ui_el_i + d + len) mod len in
    match bar.s.ui_el.(new_eli) with 
    | C (ci, _) -> walk_ui (deli - d)  {bar with ui_el_i = new_eli; ci = ci;}
    | _ -> walk_ui deli {bar with ui_el_i = new_eli}
  )

let up bar = walk_ui (-1) bar 

let down bar = walk_ui 1 bar 

let right bar = {bar with si = (bar.si + 1 + bar.s.width) mod bar.s.width}

let left bar = {bar with si = (bar.si - 1 + bar.s.width) mod bar.s.width}

let move_item_to idst (bar, reg) =
  if check_dst bar idst && (idst <> bar.ci) && bar.s.permissions.(bar.ci).(idst) then
  ( let cnt_src = bar.cnt.(bar.ci) in
    let cnt_dst = bar.cnt.(idst) in
    
    let result = 
      match Cnt.get bar.si cnt_src with
      | Some (obj, u_cnt_src) -> 
          ( match Cnt.put obj cnt_dst with 
            | Some u_cnt_dst -> Some (u_cnt_src, u_cnt_dst)
            | None -> None
          )
      | None -> None
    in

    match result with
    | Some (u_cnt_src, u_cnt_dst) -> 
        bar.cnt.(bar.ci) <- u_cnt_src;
        bar.cnt.(idst) <- u_cnt_dst;
        let reg = reg |> update_one_source bar bar.ci |> update_one_source bar idst in
        (bar, reg)
    | None -> (bar, reg)
  )
  else
    (bar, reg)


let confirm (bar, reg, astr) =
  let to_list cnt = Cnt.fold (fun acc _ b -> b::acc) [] cnt in

  let tr_sell_ls = to_list bar.cnt.(bar.s.tr_sell_ci) in
  let tr_buy_ls = to_list bar.cnt.(bar.s.tr_buy_ci) in
  
  match Trade.barter_no_decomposition tr_sell_ls tr_buy_ls bar.s.tr with
  | Some tr ->
      (* success *)
      ( match E.id bar.s.u_uid reg.R.e, E.id bar.s.m_uid reg.R.e with
        | Some u, Some mu ->
            let u_inv = Unit.get_inv u in
            let mu_inv = Unit.get_inv mu in

            (* unit - customer *)
            let u_inv2 = 
              List.fold_left (fun inv b  -> 
                match Inv.put_somewhere_bunch b inv with
                | Item.Cnt.MoveBunchSuccess inv -> inv
                | _ -> inv
              ) u_inv tr_sell_ls
            in 
            let u2 = u |> Unit.upd_inv u_inv2 in

            let e2 = reg.R.e |> E.upd u2 in
            let reg = {reg with R.e = e2} in

            (* update static *)
            let s = {bar.s with tr = tr} in
            s.src.(s.tr_merchant_ci) <- Some (SrcOther (make_offer_cnt u2 tr));

            let bar = init reg s in
            
            (bar, reg, astr)

        | _ -> failwith "Barter: confirm"
      )
  | None ->
      (* failure *)
      (bar, reg, astr)


let cancel (bar, reg, astr) =
  match E.id bar.s.u_uid reg.R.e, E.id bar.s.m_uid reg.R.e with
  | Some u, Some mu ->

      (* unit - merchant - put money back *)
      let mu_core2, mu_tr2 = Trade.move_money_from_tr_to_core (Unit.get_core mu, bar.s.tr) in
      let mu2 = Unit.upd_core mu_core2 mu in
 
      (* update astr *)
      let astr = 
        match Org.Astr.get bar.s.m_aid astr with
        | Some ma -> 
            let ma2 = ma |> Org.Actor.update_core mu_core2 |> Org.Actor.update_cl (Org.Actor.Merchant mu_tr2) in
            Org.Astr.update ma2 astr
        | None -> astr
      in

      (* unit - customer *)
      let u_inv2 = 
        Cnt.fold (fun inv _ b -> 
          match Inv.put_somewhere_bunch b inv with
          | Item.Cnt.MoveBunchSuccess inv -> inv
          | _ -> inv
        ) (Unit.get_inv u) bar.cnt.(bar.s.tr_buy_ci)

        |> Inv.compact_simple (* and compact the inventory *)
      in 
      let u2 = u |> Unit.upd_inv u_inv2 in
      let u2 = {u2 with Unit.ac = [Wait (u2.Unit.loc, 0.0)]} in 

      let e2 = reg.R.e |> E.upd u2 |> E.upd mu2 in
      let reg = {reg with R.e = e2} in

      (reg, astr)

  | _ -> failwith "Barter: cancel"


