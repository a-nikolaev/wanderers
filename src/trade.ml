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
open Item

let comp_price mult b = 
  if b.Cnt.item.barcode = Coll.coin_barcode then 
    b.Cnt.item.price * b.Cnt.amount 
  else 
    let x = (mult *. float (b.Cnt.item.price * b.Cnt.amount)) in
    (if mult >= 1.0 then ceil x |> int_of_float else max 1 (round x))

let comp_price_ls mult ls = 
  List.fold_left (fun acc b -> acc + comp_price mult b) 0 ls 

let comp_price_cnt mult cnt =
  Cnt.fold (fun acc _ b -> acc + comp_price mult b) 0 cnt

(* Barcode Map *)
module M = Map.Make (struct type t = barcode let compare = compare end)
let opt_get bc m = try Some (M.find bc m) with Not_found -> None
let get bc m = try M.find bc m with Not_found -> 0 
let put bc v m = M.add bc (get bc m + v) m 
let put_bunch b m = put b.Cnt.item.barcode b.Cnt.amount m
let take bc v m = 
  let vv = get bc m - v in 
  if vv < 0 then failwith "Trade: take" 
  else if vv = 0 then M.remove bc m
  else M.add bc vv m 

let put_bunch b m = put b.Cnt.item.barcode b.Cnt.amount m
let take_bunch b m = take b.Cnt.item.barcode b.Cnt.amount m

(* Trader *)
type trader = { skill: float; stuff: int M.t; kb: Item.t M.t }

let trader_empty = {skill = 1.5; stuff = M.empty; kb = M.empty}

let trader_init money = 
  let coin = Item.Coll.coin in
    
  let rec additem attempts_left ls money =
    if attempts_left > 0 && money > 0 then
    ( let obj = Item.Coll.random None in
      let price = Item.decompose obj |> Resource.numeric in
      if price <= money then
        additem attempts_left (Cnt.({item = obj; amount = 1})::ls) (money - price)
      else
        additem (attempts_left - 1) ls money
    )
    else
      (ls, money)
  in

  let money_keep = money/2 in
  let money_stuff = money - money_keep in

  let ls, money_left = additem 5 [] money_stuff in
  let money = money_keep + money_left in
 
  (* put money *)
  let sf = 
    let b = Cnt.({item = coin; amount = money}) in
    if money > 0 then put_bunch b M.empty else M.empty 
  in
  let kb = M.add Coll.coin_barcode coin M.empty in

  (* put stuff *)
  let sf, kb = List.fold_left (fun (sf,kb) b -> (put_bunch b sf, M.add b.Cnt.item.barcode b.Cnt.item kb)) (sf, kb) ls in

  {skill = 1.5; stuff = sf; kb = kb}


let price_buy tr ls = comp_price (1.0 /. tr.skill) ls 
let price_sell tr ls = comp_price tr.skill ls 

let price_buy_ls tr ls = comp_price_ls (1.0 /. tr.skill) ls 
let price_sell_ls tr ls = comp_price_ls tr.skill ls 

let price_buy_cnt tr ls = comp_price_cnt (1.0 /. tr.skill) ls 
let price_sell_cnt tr ls = comp_price_cnt tr.skill ls 


let print_trader tr = 
  let print b = Printf.printf "\t%s; Amount = %i\n" (Item.string_of_item b.Item.Cnt.item) b.Item.Cnt.amount in
  M.iter (fun bc am -> 
    let b = Item.Cnt.({item = M.find bc tr.kb; amount = am}) in
    print b
  ) tr.stuff;
  Printf.printf "\n%!"


let extract bc tr = 
  match get bc tr.stuff, opt_get bc tr.kb with
  | n, _ when n <= 0 -> None
  | _, None -> failwith "Trade: extract: error"
  | n, Some item -> 
      let sf = take bc n tr.stuff in
      Some (Cnt.({item; amount = n}), {tr with stuff = sf})

let exchange sell buy tr=
  let sf = List.fold_left (fun sf b -> take_bunch b sf) tr.stuff sell in
  let sf = List.fold_left (fun sf b -> put_bunch b sf) sf buy in
  let kb = List.fold_left (fun kb b -> M.add b.Cnt.item.barcode b.Cnt.item kb) tr.kb buy in 
  {tr with stuff = sf; kb}
 
let decompose_useless tr =
  let coin_bc = Coll.coin_barcode in

  let count prop = M.fold 
    (fun bc amount acc -> 
      match opt_get bc tr.kb with
      | Some item -> if prop bc item then acc + amount * item.price else acc
      | _ -> acc
    ) tr.stuff 0 
  in

  let tot_money = count (fun bc _ -> bc = coin_bc) in
  let tot_stuff = count (fun bc _ -> bc <> coin_bc) in

  let tot = tot_money + tot_stuff in

  if tot > 0 then
  ( let prob_decompose = (0.5 *. float (tot_stuff - tot_money) /. float tot) |> max 0.0 in
    
    let prob_keep = 1.0 -. prob_decompose in

    (*
    Printf.printf "prob_keep = %g\n%!" prob_keep;
    *)

    let sf = 
      M.fold ( fun bc amount acc_sf ->

        let new_am = (prob_keep *. float amount) |> round_prob in
        let drop_am = amount - new_am in

        let sf = if new_am > 0 then acc_sf |> put bc new_am else acc_sf in

        if drop_am > 0 then 
          let price = match opt_get bc tr.kb with Some item -> item.price | _ -> failwith "Trade: decompose_useless" in
          sf |> put coin_bc (price*drop_am)
        else
          sf

      ) tr.stuff M.empty
    in
    {tr with stuff = sf}
  )
  else
    tr

let barter_no_decomposition sell buy tr = 
  let p_buy = price_buy_ls tr buy in
  let p_sell = price_sell_ls tr sell in
  if p_buy >= p_sell then Some (tr |> exchange sell buy) else None

let barter sell buy tr = 
  let p_buy = price_buy_ls tr buy in
  let p_sell = price_sell_ls tr sell in
  if p_buy >= p_sell then Some (tr |> exchange sell buy |> decompose_useless) else None

let make_offer_ls price_cap num prop tr = 
 
  (*
  Printf.printf "price cap = %i\n%!" price_cap;
  *)

  let coins_num = get Coll.coin_barcode tr.stuff in
  let coins_bunch =
    match coins_num, opt_get Coll.coin_barcode tr.kb with
    | x, Some coin -> Some Cnt.({item = coin; amount = min x price_cap})
    | _ -> None
  in

  let pick probability ((init_ls, init_sf, init_n) as init_acc) =
    M.fold ( fun bc amount (ls, sf, n)  -> 
      if n > 0 then
        match opt_get bc tr.kb with
        | Some item -> 
            if prop item && Random.float 1.0 <= probability item then 
              let amount = match item.Item.stackable with
              | Some n -> min n amount
              | None -> 1
              in
              (Cnt.({item; amount}) :: ls, take bc 1 sf, n-1) 
            else 
              (ls, sf, n)
        | None -> failwith "Trade: make_offer_ls: unknown item"
      else
        (ls, sf, n)
    ) init_sf init_acc
  in

  let factor = 2.0 in
  let inv_factor = 1.0 /. factor in
 
  let sf_no_coins = take Coll.coin_barcode coins_num tr.stuff in
  let ls, sf, n = [], sf_no_coins, num in
  (* 1 *)
  let ls, sf, n = 
    pick 
    (fun item -> 
      let ratio = float item.price /. float price_cap in
      if ratio <= 1.0 then 0.0 +. factor *. ratio else 0.0 
    ) (ls, sf, n) 
  in
  (* 2 *)
  let ls, sf, n = 
    if n > 0 then
      pick 
      (fun item -> 
        let ratio = float item.price /. float price_cap in
        if ratio <= inv_factor then 0.25 +. factor *. 0.75 *. ratio else 0.0 
      ) (ls, sf, n) 
    else
      (ls, sf, n)
    in
  (* 3 *)
  let ls, sf, n = 
    if n > 0 then 
      pick (fun item -> 1.0) (ls, sf, n) 
    else 
      (ls, sf, n) 
  in

  (coins_bunch, ls)

module UC = Common.Unit.Core

let make_default_offer_ls core tr =
  let price_cap = UC.decompose core |> Resource.numeric in 
  make_offer_ls price_cap 10 (fun _ -> true) tr

let move_money_from_tr_to_core (core, tr) =
  let coin = Item.Coll.coin in
  match extract coin.Item.barcode tr with
  | Some (u_money_bunch, u_tr) -> 
    let u_core = 
      ( match Inv.put_somewhere_bunch u_money_bunch (UC.get_inv core) with
        | Item.Cnt.MoveBunchSuccess inv' -> UC.upd_inv inv' core
        | _ -> core )
    in
    (u_core, u_tr)
  | None -> (core, tr)

