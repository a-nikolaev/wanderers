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
