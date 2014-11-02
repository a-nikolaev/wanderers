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

(* Exponential(lambda)
 *   returns the time to the next event.
 *   lambda is the rate at which the event occures.
 *)
let exponential lam =
  let u = uniform 1.0 in
  -. (log u /. lam)

(* Poisson(lambda) 
 *   returns the number of times an event occures in the unit time interval
 *   lambda is the rate at which it occures
 *)
let poisson lam =
  let lim = exp(-.lam) in
  let rec next k p =
    let p' = p *. uniform 1.0 in
    if p' > lim then next (k+1) p' else k
  in
  next 0 1.0 

let poisson_in_dt lam dt = 
  poisson (lam *. dt)


