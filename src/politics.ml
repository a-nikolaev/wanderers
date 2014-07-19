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
open Pol
let rnd_traits () = 
  { militaristic = Random.bool(); industrial = Random.bool();
    agricult = Random.bool(); religious = Random.bool()} 

let zero_traits = 
  { militaristic = false; industrial = false; agricult = false; religious = false } 

let mk_htrm urban cursed ls =
  let ht = Hashtbl.create 32 in
  let rec next = function
    | (key, v)::tl -> 
        Hashtbl.add ht (key, RM.({cursed=false; urban=false})) v;
        Hashtbl.add ht (key, RM.({cursed=true; urban=false})) (v +. cursed);
        Hashtbl.add ht (key, RM.({cursed=false; urban=true})) (v +. urban);
        Hashtbl.add ht (key, RM.({cursed=true; urban=true})) (v +. cursed +. urban);
        next tl
    | _ -> () in
  next ls;
  ht

let make_fac_prop spec variant =
  match spec with
  | Humanoid -> 
      { fsp = spec;
        speciesls = [(Species.Hum, variant)];
        cl = 
          ( match Random.int 5 with
            | 0 | 1 | 2 | 3 -> Civil
            | 4 | _ -> Rogue );
        vio_ok = Random.int 10;
        lawful = Random.int 10;
        selfesteem = Random.int 10;
        traits = {militaristic = Random.bool(); industrial = Random.bool();
          agricult = Random.bool(); religious = Random.bool()};

        htrm = mk_htrm 3. (-10.) 
          RM.([(Plains, 3.); (Mnt, -3.); (SnowMnt, -6.); (ForestMnt,-2.); (Forest,-2.); (DeepForest,-5.); (Swamp,-4.) ]);
      }
  | Undead -> 
      { fsp = spec;
        speciesls = Species.([(Skeleton, 0); (Zombie, 0)]);
        cl = 
          ( match Random.int 5 with
            | 0 -> Civil
            | _ -> Rogue );
        vio_ok = 5 + Random.int 5;
        lawful = Random.int 5;
        selfesteem = Random.int 10;
        traits = {militaristic = Random.bool(); industrial = Random.bool();
          agricult = Random.bool(); religious = Random.bool()};
        
        htrm = mk_htrm 0. 10. 
          RM.([(Plains, 2.); (Mnt, 1.); (SnowMnt, -1.); (ForestMnt,0.); (Forest,0.); (DeepForest,0.); (Swamp,0.); (Dungeon, 6.) ]);
      }
  | Domestic ->
      { fsp = spec; cl = Wild;
        speciesls = Species.([(Cow, 0); (Horse, 0)]);
        vio_ok = 7; lawful = 5; selfesteem = 0;
        traits = zero_traits; 
        
        htrm = mk_htrm (-6.) (-10.) 
          RM.([(Plains, 8.); (Mnt, -8.); (SnowMnt, -8.); (ForestMnt,-7.); (Forest,-5.); (DeepForest,-9.); (Swamp,-4.); (Dungeon,-9.) ]);
      }
  | Wildlife ->
      { fsp = spec; cl = Wild;
        speciesls = Species.([(Wolf, 0);]);
        vio_ok = 3; lawful = 1; selfesteem = 5;
        traits = zero_traits; 
        
        htrm = mk_htrm (-10.) (-3.) 
          RM.([(Plains, 1.); (Mnt, 1.); (SnowMnt, -4.); (ForestMnt,4.); (Forest,11.); (DeepForest,10.); (Swamp,-1.); (Dungeon, -2.) ]);
      }

let make_variety n =
  (*
  let sp () = match Random.int 7 with
      0 | 1 | 2 -> Humanoid
    | 3 | 4 -> Undead
    | 5 -> Domestic
    | 6 | _ -> Wildlife in
  *)
  (*
  let prop = Array.init n (fun _ -> make_fac_prop (sp())) in
  *)
  let prop_ls = [(Humanoid, 0); (Domestic, 0); (Humanoid, 1); (Undead, 0); (Undead, 1); (Humanoid, 2); (Wildlife, 0); 
    (Humanoid, 3); (Undead, 2); (Undead, 3); (Humanoid, 4)] in
  assert(List.length prop_ls >= n); 
  let prop = Array.of_list (List.map (fun (sp,var) -> make_fac_prop sp var) prop_ls) in
  
  let rel_like = Array.init n (fun i -> Array.make n 0.) in
  let rel_act = Array.init n (fun i -> Array.make n 0.) in
  for i = 0 to n-1 do
    for j = 0 to n-1 do
      let rl1, rl2, ra1, ra2 = match prop.(i).fsp, prop.(j).fsp with
        Humanoid, Humanoid -> let x = -5. (* + Random.int 8 *) +. Random.float 7. in (x, x, x, x) 
      | Humanoid, Domestic | Domestic, Humanoid -> (5., 5., 6.5, 6.5)
      | Humanoid, Wildlife | Wildlife, Humanoid -> (-3., -3., -3., -3.) 
      | Domestic, Domestic -> (6., 6., 3., 3.)
      | Domestic, Wildlife -> (-9.,  2., -1., -5.)
      | Wildlife, Domestic -> ( 2., -9., -5., -1.)
      | Wildlife, Wildlife -> (-1., -1., -1., -1.)
      
      | Undead, Undead -> let x = -3. +. Random.float 5. in (x, x, x, x)
      | Humanoid, Undead -> (-6., -1., -6., -7.)
      | Undead, Humanoid -> (-1., -6., -7., -6.)
      | Domestic, Undead -> (-9., -9., -3., -4.)
      | Undead, Domestic -> (-9., -9., -4., -3.)
      
      | Undead, Wildlife | Wildlife, Undead -> (2., 2., 1., 1.)  
      in
      if i = j then 
      ( rel_like.(i).(j) <- 5.;
        rel_like.(j).(i) <- 5.;
        rel_act.(i).(j) <- 5.;
        rel_act.(j).(i) <- 5.; )
      else
      ( rel_like.(i).(j) <- rl1;
        rel_like.(j).(i) <- rl2;
        rel_act.(i).(j) <- ra1;
        rel_act.(j).(i) <- ra2 )
    done
  done;

  { facnum = n;
    prop = prop;
    rel_like = rel_like;
    rel_act = rel_act;
    policy = Array.init n (fun i -> Array.init n (fun j ->
        match (j - i + n) mod n with
        | 0 -> Neutral
        | 1 -> Neutral
        | x when x = n-1 -> Neutral
        | _ -> Neutral
      ))
  }    
  



