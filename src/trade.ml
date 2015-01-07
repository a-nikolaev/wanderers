
open Item

let comp_price mult ls = 
  List.fold_left (fun acc b -> 
    let p = 
      if is `Money b.Cnt.item then 
        b.Cnt.item.price * b.Cnt.amount 
      else 
        let x = (mult *. float (b.Cnt.item.price * b.Cnt.amount)) in
        (if mult >= 1.0 then ceil x else floor x) |> int_of_float 
    in
    acc + p
  ) 0 ls 

module M = Map.Make (struct type t = barcode let compare = compare end)
let get bc m = try M.find bc m with Not_found -> 0 
let set bc v m = M.add bc v m 
let put bc v m = M.add bc (get bc m + v) m 
let put_bunch b m = put b.Cnt.item.barcode b.Cnt.amount m
let take bc v m = M.add bc (let vv = get bc m - v in if vv < 0 then failwith "Trade: take" else vv) m 
let put_bunch b m = put b.Cnt.item.barcode b.Cnt.amount m
let take_bunch b m = take b.Cnt.item.barcode b.Cnt.amount m

type trader = { skill : float; stuff : int M.t }

let price_buy tr ls = comp_price (1.0 /. tr.skill) ls 
let price_sell tr ls = comp_price tr.skill ls 

let barter tr sell buy =
  let p_buy = price_buy tr buy in
  let p_sell = price_sell tr sell in
  let sf = List.fold_left (fun m b -> take_bunch b m) tr.stuff sell in
  let sf = List.fold_left (fun m b -> put_bunch b m) sf buy in
  {tr with stuff = sf}
