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
  let b = Cnt.({item = coin; amount = money}) in
  {skill = 1.5; stuff = put_bunch b M.empty; kb = M.add Coll.coin_barcode coin M.empty}

let price_buy tr ls = comp_price (1.0 /. tr.skill) ls 
let price_sell tr ls = comp_price tr.skill ls 

let price_buy_ls tr ls = comp_price_ls (1.0 /. tr.skill) ls 
let price_sell_ls tr ls = comp_price_ls tr.skill ls 

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

    Printf.printf "prob_keep = %g\n%!" prob_keep;

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

let barter sell buy tr = 
  let p_buy = price_buy_ls tr buy in
  let p_sell = price_sell_ls tr sell in
  if p_buy >= p_sell then Some (tr |> exchange sell buy |> decompose_useless) else None

let make_offer_ls price_cap num prop tr = 
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
  
  let ls, sf, n = [], tr.stuff, num in
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

