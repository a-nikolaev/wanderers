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
open Trade

module UC = Unit.Core

let barter_with tr core =
  let (opt_coins, offer_ls) = make_default_offer_ls core tr in

  (* trader buys *)
  let money_paid, bought_ls, u_core, opt_coin_buy =
    let ci = 1 in
    match opt_coins, Inv.container ci (UC.get_inv core) with
    | Some coins_bunch, Some cnt -> 
        let coin = coins_bunch.Cnt.item in
        let money = coins_bunch.Cnt.amount in

        let cnt_rem, bought_ls, money_rem = 
          Cnt.fold (fun (cnt, bought_ls, money) si b -> 
            let price = price_buy tr b in
            if price <= money then
              let cnt' = match Cnt.get_bunch si cnt with Some (_, c) -> c | _ -> cnt in
              (cnt', b::bought_ls, money - price)
            else
              (cnt, bought_ls, money)
          ) (cnt, [], money) cnt
        in

        let money_paid = money - money_rem in

        let cnt_rem = Cnt.compact cnt_rem in

        let bought_ls, u_inv = 
          let inv = UC.get_inv core in 
          match inv |> Inv.upd_container ci cnt_rem |> Inv.put_somewhere_bunch Cnt.({item=coin; amount=money_paid}) with
          | Item.Cnt.MoveBunchSuccess inv' -> bought_ls, inv'
          | _ -> [], inv
        in

        let u_core = UC.upd_inv u_inv core in
        
        (money_paid, bought_ls, u_core, Some coin)
    | _ -> (0, [], core, None)
  in


  (* trader sells *)
  let money_earned, sold_ls, uu_core, opt_coin_sell =
    match Inv.get_bunch Inv.default_coins_container Item.Cnt.default_coins_slot (UC.get_inv u_core) with
    | Some (b, inv) when b.Cnt.item.barcode = Coll.coin_barcode  ->
        
        let money_buyer_has, coin, u_core = (b.Cnt.amount, b.Cnt.item, UC.upd_inv inv u_core) in

        (* sell one item *)
        let money_remains, sold_ls, uu_core =
          List.fold_left (fun ((money_remains, sold_ls, uu_core) as acc) b ->
              
            let price = price_sell tr b in
            
            if price <= money_remains then
              match Org.try_bunch_eval_option Org.eval_slow uu_core u_core b with
              | Some (core, not_needed_ls) -> 

                  let inv = UC.get_inv core in 
                  let inv =
                    List.fold_left (fun inv bb  ->
                      match inv |> Inv.put_somewhere_bunch bb with
                      | Item.Cnt.MoveBunchSuccess inv' -> inv'
                      | _ -> inv
                    ) inv not_needed_ls
                  in

                  (money_remains - price, [b], UC.upd_inv inv core)

              | None -> acc
            else
              acc

          ) (money_buyer_has, [], u_core) offer_ls
        in

        let uu_core_2 = 
          let inv = UC.get_inv uu_core in 
          match Inv.put_somewhere_bunch Cnt.({item=coin; amount=money_remains}) inv with
          | Item.Cnt.MoveBunchSuccess inv' -> UC.upd_inv inv' uu_core
          | _ -> uu_core
        in
  
        let money_earned = money_buyer_has - money_remains in
        (money_earned, sold_ls, uu_core_2, Some coin)

    | _ -> (0, [], u_core, None) 
  in

  let money_balance = money_earned - money_paid in

  let buy, sell =
    match opt_coin_sell, opt_coin_buy with
    | Some coin, _
    | _, Some coin ->
        if money_balance > 0 then 
          Cnt.({item=coin; amount=money_balance})::bought_ls, sold_ls
        else if money_balance < 0 then
          bought_ls, Cnt.({item=coin; amount= - money_balance})::sold_ls
        else
          bought_ls, sold_ls
    | _ -> bought_ls, sold_ls
  in

  (*
  let print b = Printf.printf "%s; Amount = %i\n" (Item.string_of_item b.Cnt.item) b.Cnt.amount in
  Printf.printf "\nBuy (%i):\n" (price_buy_ls tr buy);
  List.iter print buy;
  Printf.printf "\nSell (%i):\n" (price_sell_ls tr sell);
  List.iter print sell;
  *)
  match barter sell buy tr with
  | Some u_tr -> 
      (* Printf.printf "OK\n%!"; *)
      (u_tr, uu_core)
  | None -> 
      failwith "Trade: barter_with failure"

