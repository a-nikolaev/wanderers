
(* Generation of random variates *)

(* max value *)
let uniform = Random.float


(* Normal(mu=0, sigma=1). Marsaglia method *)
let rec normal_std () =
  let x = Random.float 2.0 -. 1.0 in
  let y = Random.float 2.0 -. 1.0 in
  let s = x*.x +. y*.y in
  if s < 1.0 then x *. sqrt (-2.0 *. log s /. s) else normal_std()

(* Normal(mu, sigma) *)
let normal mu sigma = normal_std() *. sigma +. mu

(* Normal(mu, sigma2) *)
let normal_s2 mu sigma2 = normal_std() *. (sqrt sigma2) +. mu

let lognormal mu sigma = exp(normal mu sigma)
