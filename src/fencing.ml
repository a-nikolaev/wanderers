
open Base

type template_slide = (string array)
type template = (template_slide*float) array

type target = {dloc: loc; magnitude: float; pushvec: vec}

type sequence = ((target list) * float) array

type technique = {dseq: sequence array; dur_mult: float; name: string }

(*  *)
let find_char c slide = 
  let rec next i =
    if i < Array.length slide then
      try Some (i, String.index slide.(i) c) with
        Not_found -> next (i+1)
    else
      None
  in
  next 0

let center_symbol = 'o'
let dir_symbol = '*'
  
(* i = row, j = column (index in the i'th string) *)
let verify_center (i,j) slide =
  let double_h = Array.length slide in
  if double_h > 0 then
  ( let w = String.length slide.(0) in
    (* check that all strings are the same length *)
    (fold_lim (fun acc k -> acc && (String.length slide.(k) = w) ) true 0 (double_h-1)) &&
    (* check some parameters *)
    ( double_h mod 2 = 0 && i mod 2 = 0 && i < double_h &&
      slide.(i).[j] = center_symbol && slide.(i+1).[j] = dir_symbol) &&
    (* check that all numbers are correctly aligned *)
    ( fold_lim (fun acc ii -> 
        fold_lim (fun sub_acc jj -> 
          sub_acc &&
          ( match slide.(2*ii).[jj], slide.(2*ii+1).[jj] with
            | '0'..'9', '1'..'9' -> true
            | '0'..'9', _ | _, '1'..'9' -> false
            | c1, c2 when c1 = center_symbol && c2 = dir_symbol -> true
            | _ -> true )
        ) acc 0 (w - 1)
    ) true 0 (double_h/2 - 1) )
  ) 
  else
    false

let verify_slide slide =
  match find_char center_symbol slide with
    Some (i,j) when verify_center (i,j) slide -> Some (i/2,j)
  | _ -> None

(* make list of targets from a single slide *)
let make_target_list (ci,cj) slide = 
  let h = Array.length slide / 2 in
  let w = String.length slide.(0) in
  let targetls, magsum =
    ( fold_lim (fun acc i -> 
        fold_lim (fun ((ls, sum) as subacc) j -> 
          ( match slide.(2*i).[j], slide.(2*i+1).[j] with
            | ('0'..'9' as cmag), ('1'..'9' as cdir) -> 
              let mag = float (Char.code cmag - Char.code '0') in
              let pushvec = match cdir with
                | '1' -> Dir8.to_unit_vec Dir8.SW
                | '2' -> Dir8.to_unit_vec Dir8.S
                | '3' -> Dir8.to_unit_vec Dir8.SE
                | '4' -> Dir8.to_unit_vec Dir8.W
                | '5' -> (0.0, 0.0)
                | '6' -> Dir8.to_unit_vec Dir8.E
                | '7' -> Dir8.to_unit_vec Dir8.NW
                | '8' -> Dir8.to_unit_vec Dir8.N
                | '9' -> Dir8.to_unit_vec Dir8.NE 
                | _ -> failwith "Fencing: Wrong direction character" in
              ({dloc = (j-cj, -(i-ci)); magnitude = mag; pushvec} :: ls, sum +. mag)
            | _ -> subacc )
        ) acc 0 (w-1)
    ) ([], 0.0) 0 (h-1) )
  in
  (* finally, normalize the magnitudes *)
  List.map (fun target -> {target with magnitude = target.magnitude /. magsum}) targetls

(* make sequence *)
let make_sequence (tmp:template) : sequence = 
  Array.map
    ( fun (slide, dt) ->
        match verify_slide slide with
          Some (i,j) -> (make_target_list (i,j) slide, dt)
        | _ -> 
            failwith "Fencing: error generating a sequence"
    )
    tmp

(* turn a single target structure counter-clockwise *)
let turn_ccw t =
  let (x,y) = t.dloc in
  let (vx, vy) = t.pushvec in
  {magnitude = t.magnitude; dloc = (-y, x); pushvec = (-.vy, vx)}

let make_technique arr name =
  let seq = make_sequence arr in
  let dseq = Array.init 4 
    ( fun n -> 
        Array.map (fun (tgtls, dt) -> 
          (List.map (fun tgt -> fold_lim (fun acc _ -> turn_ccw acc) tgt 1 n) tgtls, dt) 
        ) seq
    ) in 
  let dur_mult = 
    Array.fold_left (fun sum (_, dt) -> sum +. dt) 0.0 seq in
  {dseq; dur_mult; name}


let tm_basic = [|
  [| "o6"; "*6" |], 1.0;
|]

let tm_fw = [|
  [| "o6";  "*6" |], 0.5;

  [| "o36"; "*56" |], 0.7;
|]

let tm_l2r = [|
  [| "3 "; "6 ";
     "o6"; "*3" |], 0.4;

  [| "o3"; "*3";
     " 6"; " 2" |], 0.7;
|]

let tm_r2l = [|
  [| "o6"; "*9";
     "3 "; "6 " |], 0.4;

  [| " 6"; " 8";
     "o3"; "*9" |], 0.7;
|]

let tm_smash = [|
  [| "o 6"; "* 6" |], 0.6;

  [| "  1 "; "  8 ";
     "o121"; "*456";
     "  1 "; "  2 "; |], 0.6;
|]

let tq_basic = make_technique tm_basic "Basic"
let tq_fw = make_technique tm_fw "Forward"
let tq_l2r = make_technique tm_l2r "Right"
let tq_r2l = make_technique tm_r2l "Left"
let tq_smash = make_technique tm_smash "Smash"

let tqs = [| tq_basic; tq_fw; tq_l2r; tq_r2l; tq_smash |]

type tq_name = int

let default_tqn = 0

let max_tq_number = 5
let scroll_forward i = (i + 1) mod max_tq_number
let scroll_backward i = (i - 1 + max_tq_number) mod max_tq_number

let auto_switch = function
  | 2 -> 3
  | 3 -> 2
  | x -> x

let get_tq name = tqs.(name)

(* 
   dt = simulation time interval,
   t = current time (with this current time step added already)
   tf = final time

   returns (tgtls, stage_fraction)

   stage_fraction = number between 0.0 and 1.0 indicating the time position
    in the current slide.
 *)
let get_tgtls_and_stage dt t tf technique dir_index =
  let normal_midtime = (t -. 0.5*.dt) /. tf in
  let seq = technique.dseq.(dir_index) in
  let isize = Array.length seq in
  let rec search sum i =
    if i < isize then
    ( let _, interval = seq.(i) in
      let sum' = sum +. interval in
      if sum' > normal_midtime then (i, (normal_midtime -. sum)/. interval)
      else search sum' (i+1)
    )
    else
      ((i-1), 1.0)
  in
  let i, dtz = search 0.0 0 in
  let tgtls, _ = seq.(i) in
  (tgtls, dtz)

