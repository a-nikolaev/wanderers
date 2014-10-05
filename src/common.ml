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

module Area = struct
  type 'a t = {data: 'a array array}
  let make w h v = 
    let data = Array.make_matrix w h v in
    {data}
  let init w h f =
    let data = Array.init w (fun i -> Array.init h (fun j -> f i j)) in
    {data}
    
  let get a (i,j) = a.data.(i).(j) 
  let set a (i,j) v = a.data.(i).(j) <- v 
  
  let w a = Array.length a.data 
  let h a = Array.length (a.data.(0))
  let is_within a (i,j) =
    let width = w a in
    let height = h a in
    i >= 0 && i < width && j >= 0 && j < height
  let put_inside a (i,j) =
    let width = w a in let height = h a in
    ((i+width) mod width, (j+height) mod height)
end

module Tile = struct
  type door_state = IsOpen | IsClosed

  type t = Grass | Wall | Tree1 | Tree2 | Rock1 | Rock2
    | SwampyGround | SwampyPool | RockyGround | SnowyGround | IcyGround
    | WoodenFloor | Door of door_state 
    | DungeonFloor | DungeonWall | DungeonDoor of door_state
    | CaveFloor | CaveWall | CaveDoor of door_state

  let get_traction = function
    | IcyGround -> 0.38
    | SwampyPool -> 0.80
    | _ -> 1.0
  
  let get_friction = function
    | IcyGround -> 0.26
    | SwampyPool -> 2.1
    | _ -> 1.0

  type tile_class = CFloor | CWall | CDoor of door_state

  let classify = function
    | Grass | SwampyGround | SwampyPool | RockyGround | SnowyGround | IcyGround
    | WoodenFloor | DungeonFloor | CaveFloor -> CFloor
    | Wall | Tree1 | Tree2 | Rock1 | Rock2 | DungeonWall | CaveWall -> CWall
    | Door s | DungeonDoor s | CaveDoor s -> CDoor s

  let is_a_door = function
    CDoor _ -> true
  | _ -> false

  let can_walk = function
    CFloor | CDoor IsOpen -> true
  | CWall | CDoor IsClosed -> false

  let can_look = function
    CFloor | CDoor IsOpen -> true
  | CWall | CDoor IsClosed -> false
end

let is_walkable area loc =
  Area.is_within area loc && Tile.can_walk (Tile.classify (Area.get area loc))

type edge_type = East | North | West | South | Up | Down | Other

(* Projectile *)
module Proj = struct
  type prop = {mass:float; dmgmult:float}
  type t = {pos:vec; vel:vec; item:prop;}
  let move dt p = 
    let a = (-0.05 /. p.item.mass) %%. p.vel in
    let vel = p.vel ++. dt %%. a in
    let pos = p.pos ++. (dt *. 0.5) %%. (vel ++. p.vel) in
    {p with pos; vel} 
  
  let getdir pj = Dir8.of_vec pj.vel

end

type faction = int

type path = loc list

type timed_action = Attack of (Fencing.technique * int) | Rest | Prepare of action | Stunned

and op_obj_type = OpObjOpen | OpObjClose

and action = 
  | Walk of (path*float) 
  | Run of (path*float) 
  | Wait of (loc*float) 
  | Lookaround of int
  | Timed of ((loc option)*float*float*timed_action)
  | FireProj of loc
  | OperateObj of (loc * op_obj_type)

(* faction specialization *)
type fac_spec = Humanoid | Domestic | Wildlife | Undead

module Species = struct
  type genus = Hum 
    | Cow | Horse
    | Skeleton | Zombie | SkeletonWar | ZombieHulk
    | Wolf | Bear | Troll

  type t = genus * int

  let add v dv x = v +. dv *. float x

  let xreaction = function
    | Skeleton, x -> add 0.9 0.05 x
    | SkeletonWar, _ -> 1.0
    | Zombie, x -> add 1.5 0.15 x
    | ZombieHulk, _ -> 1.8
    | Wolf, _ -> 0.7
    | Troll, _ -> 1.2
    | _ -> 1.0

  let xmass = function
    | Cow, _ -> 3.0
    | Horse, _ -> 2.5
    | Skeleton, x -> add 0.9 0.3 x
    | SkeletonWar, _ -> 1.5
    | Zombie, x -> add 1.0 0.5 x
    | ZombieHulk, _ -> 2.0
    | Wolf, _ -> 0.8
    | Bear, _ -> 4.0
    | Troll, _ -> 1.8
    | _ -> 1.0
  
  let xathletic = function
    | Cow, _ -> 2.0
    | Horse, _ -> 2.0
    | Zombie, x -> add 1.2 0.55 x
    | ZombieHulk, _ -> 2.3
    | Skeleton, x -> add 0.9 0.3 x
    | SkeletonWar, _ -> 1.5
    | Bear, _ -> 3.5
    | Troll, _ -> 2.2
    | _ -> 1.0
  
  let xbasedmg = function
    | Wolf, _ -> 1.5
    | Bear, _ -> 2.0
    | Troll, _ -> 4.0
    | Skeleton, x -> add 1.0 0.35 x
    | SkeletonWar, _ -> 1.7
    | _ -> 1.0

  let rec upgrade prob sp =
    let r() = Random.float 1.0 in
    let rec u = function
      | Skeleton, 0 when r() < prob -> u (Skeleton, 1)
      | Skeleton, _ when r() < prob -> u (SkeletonWar, 0)
      | Zombie, 0 when r() < prob -> u (Zombie, 1)
      | Zombie, _ when r() < prob -> u (ZombieHulk, 0)
      | Wolf, x when r() < 2.0 *. prob -> u (Bear, x)
      | Bear, x when r() < 2.0 *. prob -> u (Troll, x)
      | sp -> sp 
    in
    u sp
end

module Unit = struct
  module Core = struct
    type properties = {reaction:float; mass:float; radius:float; athletic:float; basedmg:float; courage:float;}
    type aux = {mass_carry: float; mass_wear: float; mass_headgear: float; mass_wield: float; 
      unenc_melee: Item.Melee.t; unenc_ranged: Item.Ranged.t option; unenc_defense: float;
      fm: float;
      melee: Item.Melee.t; ranged: Item.Ranged.t option; defense: float;
    }
    type gender = Male | Female
    let comp_radius m = 0.45 *. (m /. 100.0)**(0.25)

    let comp_size g = 
      let s = match g with
      | Some Male -> (Prob.lognormal 4.29 0.163 -. 50.0) /. 50.0 
      | Some Female -> (Prob.lognormal 4.10 0.168 -. 50.0) /. 50.0 
      | None -> (Prob.lognormal 4.20 0.166 -. 50.0) /. 50.0 in
      max ((* -0.2 *) 0.0 ) (min s 2.0)

    let rnd_prop gender =
      (*
      { reaction = 0.5 +. Random.float 0.8; 
        mass = 50.0 +. Random.float 50.0;
        athletic = 8.0 +. Random.float 8.0 }
      *)
      (*let size = Random.float 1.0 in *)
      (*let size = (Prob.lognormal 4.25 0.163 -. 50.0) /. 50.0 in *)
      
      let size = comp_size gender in
      let smarts = (1.0 -. size) in

      (*
      let athletic = 8.5 +. 7.5 *. sqrt size in
      *)
      let athletic = 5.5*.log(size+.0.4) +. 14.5 in

      let reaction = 0.5 +. 0.8 *. (1.0 -. smarts) in
      let mass = 50.0 +. 50.0 *. size in

      let noize () = 0.025 *. (Random.float 1.0 -. 0.5) in
      let athletic = athletic *. (1.0 +. noize()) in 
      let reaction = reaction *. (1.0 +. noize())in
      let mass = mass *. (1.0 +. noize()) in
      
      (* Printf.printf "[%g, m=%g] \n%!" size mass; *)

      { athletic;
        reaction;
        mass;
        radius = comp_radius mass;
        basedmg = 1.0; 
        courage = 1.5;
      }
    type t = {
      fac:faction; sp:Species.t; gender: gender option;
      hp: float;
      controller: int option;
      prop: properties;
      inv: Inv.t;
      aux: aux;
      res: Resource.t;
    }

    (* Freedom of movement *)
    (* 1 = free movement, 0 = encumbered *)
    let comp_fm uc =
      let force = uc.prop.athletic in
      let wg_mass = uc.aux.mass_wield +. 0.25 *. uc.aux.mass_wear +. 0.35 *. uc.aux.mass_headgear +. 0.1 *. uc.aux.mass_carry in
      let sigmoid_decay mean x = 1.0 /. (1.0 +. exp (x -. mean)) in
      sigmoid_decay (0.5 *. force) wg_mass 
 
    (* Unencumbered *)
    let comp_melee_unencumbered uc =
      let default = Item.Melee.({attrate = uc.prop.basedmg; duration = 2.0;}) in
      let addition = Item.Melee.({attrate = uc.prop.basedmg; duration = 0.0;}) in
      match Inv.container 0 uc.inv with
      | Some cnt -> 
          let accum = 
            Item.Cnt.fold 
            ( fun acc _ bunch ->
                ( match acc, Item.get_melee bunch.Item.Cnt.item with 
                    (Some (acc_sum, acc_max)), Some m -> 
                      Item.Melee.(Some (join_simple acc_sum m, join_max acc_max m))
                  | None, Some m -> (Some (m, m))
                  | x, _ -> x
                )
            )
            None cnt.Item.Cnt.bunch 
          in
          ( match accum with 
            | Some (msum, mmax) ->
                (* num = the number of weapons wielded *)
                (* penalize second weapon *)
                let aux_factor = 0.65 in 
                let mu = Item.Melee.({msum with attrate = mmax.attrate +. (msum.attrate -. mmax.attrate) *. aux_factor}) in
                Item.Melee.join_simple mu addition
            | None -> default
          )
      | None -> default
 
    let comp_ranged_unencumbered uc =
      let base = None in
      match Inv.container 0 uc.inv with
      | Some cnt -> 
          Item.Cnt.fold 
          ( fun acc _ bunch ->
              match Item.get_ranged bunch.Item.Cnt.item with
                None -> acc
              | x -> x
          )
          base cnt.Item.Cnt.bunch
      | None -> base
    
    let comp_defense_unencumbered cu =
      let base = 0.0 in
      match Inv.container 0 cu.inv with
      | Some cnt -> 
          Item.Cnt.fold 
          ( fun acc _ bunch ->
              let d = Item.get_defense bunch.Item.Cnt.item in
              acc +. d -. (d *. acc)
          )
          base cnt.Item.Cnt.bunch
      | None -> base
  
    (* helper function *)
    let comp_mass_cnt_pred uc cnt_num pred =
      let g cnt accum =  
        match cnt with
        | Some cnt -> 
            Item.Cnt.fold 
            ( fun acc _ bunch ->
                if pred bunch.Item.Cnt.item then
                  acc +. float bunch.Item.Cnt.amount *. Item.get_mass bunch.Item.Cnt.item
                else
                  acc
            )
            accum cnt.Item.Cnt.bunch
        | None -> accum in
      g (Inv.container cnt_num uc.inv) 0.0

    let comp_mass_wear uc = comp_mass_cnt_pred uc 0 Item.is_wearable 
    let comp_mass_headgear uc = comp_mass_cnt_pred uc 0 Item.is_a_headgear 
    let comp_mass_wield uc = comp_mass_cnt_pred uc 0 Item.is_wieldable 
    let comp_mass_carry uc = comp_mass_cnt_pred uc 1 (fun _ -> true)

    (* encumber *)
    let encumber_melee fm m =
      Item.Melee.({attrate = fm *. m.attrate; duration = m.duration *. (1.3 /. (fm +. 0.3))})

    let encumber_ranged fm rng = 
      match rng with
      | Some r ->
          Some Item.Ranged.({r with force = fm*.r.force})
      | _ -> None

    let encumber_defense fm d = d
  
    (* adjust aux field *)
    let adjust_aux_info uc =
      let uc1 = { uc with aux = { uc.aux with
        mass_carry = comp_mass_carry uc;
        mass_wear = comp_mass_wear uc;
        mass_headgear = comp_mass_headgear uc;
        mass_wield = comp_mass_wield uc; } }
      in
      let unenc_melee = comp_melee_unencumbered uc in
      let unenc_ranged = comp_ranged_unencumbered uc in
      let unenc_defense = comp_defense_unencumbered uc in
      let fm = comp_fm uc1 in
      let aux = { uc1.aux with
          fm; unenc_melee; unenc_ranged; unenc_defense;
          melee = encumber_melee fm unenc_melee;
          ranged = encumber_ranged fm unenc_ranged;
          defense = encumber_defense fm unenc_defense;
        } in
      {uc1 with aux}
  
    let get_melee uc = uc.aux.melee
    let get_ranged uc = uc.aux.ranged
    let get_defense uc = uc.aux.defense
    let get_total_mass uc = 
      (uc.prop.mass +. uc.aux.mass_carry +. uc.aux.mass_wear +. uc.aux.mass_headgear +. uc.aux.mass_wield)
    let get_fm uc = uc.aux.fm
    let get_sp uc = uc.sp
    let get_fac uc = uc.fac
 
    let get_hp uc = uc.hp
    
    let get_max_hp uc = uc.prop.mass

    let get_reaction uc = uc.prop.reaction
    let get_athletic uc = uc.prop.athletic
    let get_own_mass uc = uc.prop.mass
    let get_courage uc = uc.prop.courage
    
    let get_fm uc = uc.aux.fm
  
    let get_default_wait uc = (uc.prop.reaction) /. (max 0.1 uc.aux.fm)
    
    let get_default_ranged_wait uc = (1.0 +. uc.prop.reaction) /. (max 0.1 uc.aux.fm)
    
    let get_faction uc = uc.fac
    
    let get_gender uc = uc.gender
    
    let get_inv uc = uc.inv
    
    let get_res uc = uc.res
  
    let is_alive uc = uc.hp > 0.0

    let damage strike dmgmult uc =
      if strike <= 0.0 then 
        uc
      else
      ( let dmg = strike *. dmgmult in
        let t_defense = get_defense uc in
        let dmg_defended = if Random.float 1.0 < t_defense then 0.0 else dmg in
        {uc with hp = uc.hp -. dmg_defended} )
  
    let heal dhp uc = {uc with hp = min (uc.hp +. dhp) uc.prop.mass}

    let upd_inv inv uc = adjust_aux_info {uc with inv}
    
    let upd_res res uc = adjust_aux_info {uc with res}

    let make fac sp controller =
      let gender = 
        match sp with 
          Species.Hum, _ -> (match Random.int 2 with 0 -> Some Male | _ -> Some Female)
        | _ -> None
      in
      let {reaction; mass; radius; athletic; basedmg; courage} = rnd_prop gender in
      let prop = 
        {
        reaction = reaction *. Species.xreaction sp; 
        mass = mass*.Species.xmass sp;
        radius = comp_radius (mass *. Species.xmass sp);
        athletic = athletic*.Species.xathletic sp;
        basedmg = basedmg *. Species.xbasedmg sp;
        courage = courage;
        } in
      let aux = {mass_carry = 0.0; mass_wear = 0.0; mass_headgear = 0.0; mass_wield = 0.0; 
        unenc_melee = Item.Melee.({attrate=1.0; duration=1.0});
        unenc_ranged = None;
        unenc_defense = 0.0;
        fm = 1.0;
        melee = Item.Melee.({attrate=1.0; duration=1.0});
        ranged = None;
        defense = 0.0;
        } in
      let uc =
        { fac; sp; prop; hp = prop.mass; controller = controller;
          inv = Inv.default;
          aux;
          gender;
          res = Resource.zero;
        } in
      adjust_aux_info uc
    
    let make_res fac sp controller res =
      let rec additem ucore res_left =
        let obj = Item.Coll.random None in
        let price = Item.decompose obj in
        if Resource.lesseq price res_left then
          match Inv.put_somewhere obj ucore.inv with
            Some inv1 -> additem {ucore with inv=inv1} (Resource.subtract res_left price)
          | None -> (ucore, res_left)
        else
          (ucore, res_left)
      in
      let uc = make fac sp controller in
      let uc, res = additem uc res in
      (adjust_aux_info uc, res)

    let bunch_ls uc =
      Inv.fold (fun ls _ _ bunch -> bunch::ls) [] (get_inv uc)

    let decompose uc = Resource.add (Inv.decompose uc.inv) uc.res 

    let approx_strength uc = 
      let items = Resource.numeric (decompose uc) in
      get_athletic uc *. get_hp uc /. (get_reaction uc) *. get_fm uc *. float items 

    let print c = 
      Printf.printf "m=%.0f, re=%.1f, ath=%.1f;   "
             (get_total_mass c)
             (get_reaction c)
             (get_athletic c);
      Printf.printf "HP=%.0f;   " (get_hp c);
      let melee = get_melee c in
      let ranged_force = match get_ranged c with Some r -> r.Item.Ranged.force | _ -> 0.0 in
      let defense = get_defense c in
      Printf.printf "atk rate=%.1f (dur=%.1f), rng=%.1f, def=%.2f\n" 
        melee.Item.Melee.attrate melee.Item.Melee.duration ranged_force defense

  end
 

  (* unit *)
  type notification_type = NtfyDamage of float | NtfyStunned
  type notification = notification_type * float
  type id = int
  
  module TactMem = struct
    (* tactical memory *)

    type esrec = loc*id*loc (* own loc * enemy's id * enemy's loc *)

    type fact = EnemySeen of esrec 

    module Sf = Set.Make(struct type t = fact let compare = compare end)
    type t = Sf.t

    let empty = Sf.empty

    let singleton fact = Sf.singleton fact

    let find_enemyseen mem = 
      let enemymem = Sf.filter (function EnemySeen _ -> true) mem in
      if Sf.is_empty enemymem then 
        None
      else 
      ( match Sf.choose enemymem with
        | EnemySeen x -> Some x
       )
  end


  type t = {
    id: id;
    core:Core.t; 
    loc:loc; pos:vec; vel:vec; ac: action list;
    transfer: edge_type option; 
    sight: int Area.t;
    fnctqn: Fencing.tq_name;
    ntfy: notification list;
    tactmem: TactMem.t;

    optaid: int option; (* actor's id, if any *)
    }


  let get_core u = u.core
  (* wrappers *)
  let get_radius u = u.core.Core.prop.Core.radius
  let get_melee u = u.core.Core.aux.Core.melee
  let get_ranged u = u.core.Core.aux.Core.ranged
  let get_defense u = u.core.Core.aux.Core.defense
  let get_total_mass u = Core.get_total_mass u.core 
  let get_faction u = u.core.Core.fac
  let get_sp u = u.core.Core.sp
  let get_gender u = Core.get_gender u.core
  let get_controller u = u.core.Core.controller
  
  let get_hp u = u.core.Core.hp

  let get_reaction u = u.core.Core.prop.Core.reaction
  let get_athletic u = u.core.Core.prop.Core.athletic
  let get_courage u = Core.get_courage u.core

  let get_default_wait u = Core.get_default_wait u.core
  
  let get_default_ranged_wait u = Core.get_default_ranged_wait u.core

  let is_alive u = Core.is_alive u.core

  let get_fnctqn u = u.fnctqn

  let get_optaid u = u.optaid

  (* adjust aux field *)
  let adjust_aux_info u = {u with core = Core.adjust_aux_info u.core}
  
  let get_inv u = Core.get_inv u.core

  let upd_inv inv u = {u with core = Core.upd_inv inv u.core}

  let create_maker () =
    let id0 = ref 0 in
    ( fun fac sp controller loc ->
        let id = !id0 in
        id0 := !id0 + 1;
        let core = Core.make fac sp controller in
        { id; loc; pos=vec_of_loc loc; vel=(0.0,0.0); ac=[];
          core; transfer = None;
          sight = Area.make 1 1 0;
          fnctqn = Fencing.default_tqn;
          ntfy = [];
          tactmem = TactMem.empty;
          optaid = None;
        }
    )
  let make = create_maker ()

  (* make with resources *)
  let make_res res fac sp controller loc = 
    let u = make fac sp controller loc in
    let updcore, rem_res = Core.make_res fac sp controller res in
    (adjust_aux_info {u with core = updcore}, rem_res)

  let make_core core controller loc =
    let u = make (Core.get_fac core) (Core.get_sp core) controller loc in
    adjust_aux_info {u with core}

  let damage (strike, dirvec, dmgmult) u =
    (* strike ~ d momentum *)
    let push = strike *. 18.0 /. get_total_mass u in

    let core1 = Core.damage strike dmgmult u.core in
    let dmg = u.core.Core.hp -. core1.Core.hp in

    let unitdir = (* (1.0 /. vec_len dirvec) %%. *) dirvec in

    let nntfy = 
      match u.ntfy with
      | (NtfyDamage d, t) :: tl when t < 1.0 ->
          (NtfyDamage (d+.dmg), t) :: tl
      | _ -> (NtfyDamage dmg, 0.0) :: u.ntfy in

    {u with core = core1; vel = u.vel ++. push %%. unitdir; ntfy = nntfy; }
   
  let stun u =
    let nntfy = 
      match u.ntfy with
      | _ :: (NtfyStunned, t) :: tl | (NtfyStunned, t) :: tl when t < 1.0 -> u.ntfy
      | _ -> (NtfyStunned, 0.0) :: u.ntfy 
    in
    let dt = 0.2 *. get_default_wait u in
    {u with 
      ac = [Timed (None, 0.0, dt, Stunned)];
      ntfy = nntfy}

  let heal dhp u = {u with core = Core.heal dhp u.core}

  (* unit to resources *)
  let decompose u = Core.decompose u.core

  let make_long_path a u =
    let rec path l dl n = 
      if n > 0 && (not (Area.is_within a l) || is_walkable a l) then 
        l :: path (l++dl) dl (n-1) 
      else [] in
    match Random.int 2 with
    | 0 -> 
        let x0,_ = u.loc in
        let x1 = Random.int (Area.w a + 2) - 1 in
        let dx = x1-x0 in
        if dx > 0 then path (u.loc ++ (1,0)) (1,0) (abs dx)
        else if dx < 0 then path (u.loc ++ (-1,0)) (-1,0) (abs dx)
        else []
    | _ -> 
        let _,y0 = u.loc in
        let y1 = Random.int (Area.h a + 2) - 1 in
        let dy = y1-y0 in
        if dy > 0 then path (u.loc ++ (0,1)) (0,1) dy
        else if dy < 0 then path (u.loc ++ (0,-1)) (0,-1) (-dy)
        else []
  
  let make_path_to a u tloc =
    let ok l = (not (Area.is_within a l)) || is_walkable a l in
    (* (si,sj) are the signs, and (adi,adj) are the magnitudes of the displacement *)
    let rec next steps (i,j) ((si,sj), (mi,mj)) =
      if steps > 0 then
      ( let x = Random.int (mi+mj) in
        let loc = (i+si,j) in
        if x < mi && ok loc then loc :: next (steps-1) loc ((si,sj), (mi-1,mj))
        else
        ( let loc = (i,j+sj) in
          if ok loc then loc :: next (steps-1) loc ((si,sj), (mi, mj-1))
          else [] ) 
      )
      else
        []
    in
    let steps = int_of_float (0.3 *. float (loc_manhattan (u.loc -- tloc))) |> (max 1) in
    let signs_mags (di,dj) = 
      let s x = if x < 0 then (-1) else if x > 0 then 1 else 0 in
      ((s di, s dj), (abs di, abs dj))
    in
    next steps u.loc (signs_mags (tloc -- u.loc))
  
  let make_short_path a u =
    let (x0,y0) = u.loc in
    let dstloc = 
      match Random.int 2 with
      | 0 -> (Random.int (Area.w a + 2) - 1, y0)
      | _ -> (x0, Random.int (Area.h a + 2) - 1)
    in
    make_path_to a u dstloc 

  
  let cur_dest_loc u = 
    match u.ac with
    | (Walk ((loc::_), _))::_ | (Run ((loc::_),_))::_ | (Wait (loc,_))::_ -> Some loc
    | (Timed (x,_,_,_))::_ -> x
    | (OperateObj (loc,_))::_ -> Some loc 
    | (Walk ([],_))::_ | (Run ([],_))::_ | (Lookaround _)::_ | (FireProj _)::_ | [] -> None
end




(* units registry, by id and by loc *)
module E = struct
  type id = int
  module Mi = Map.Make (struct type t = id let compare = compare end)
  module Ml = Map.Make (struct type t = loc let compare = compare end)
  type t = {id: Unit.t Mi.t; at: (id list) Ml.t}

  let empty = {id = Mi.empty; at = Ml.empty}
 
  let id i d = if (Mi.mem i d.id) then Some (Mi.find i d.id) else None
  let ids_at loc d = if (Ml.mem loc d.at) then (Ml.find loc d.at) else []
  let at loc d = List.fold_left (fun acc i -> match id i d with Some u -> u::acc | _ -> acc) [] (ids_at loc d)
  let occupied loc d = Ml.mem loc d.at

  (* list of units uu collides with (they occupy the same loc) *)
  let collisions uu d = 
    List.fold_left 
      (fun acc i -> match id i d with Some u when u.Unit.id <> uu.Unit.id -> u::acc | _ -> acc) 
      [] (ids_at uu.Unit.loc d)
  (* including neighbors *)
  let collisions_nb uu d =
    let loc = uu.Unit.loc in
    List.fold_left (fun acc1 loc ->
      List.fold_left 
        (fun acc2 i -> match id i d with Some u when u.Unit.id <> uu.Unit.id -> u::acc2 | _ -> acc2) 
        acc1 (ids_at loc d)
    ) [] [loc; loc ++ (1,0); loc ++ (-1,0); loc ++ (0,1); loc ++ (0,-1)]
  
  let collisions_nb_vec vec d =
    let loc = loc_of_vec vec in
    List.fold_left (fun acc1 loc ->
      List.fold_left 
        (fun acc2 i -> match id i d with Some u -> u::acc2 | _ -> acc2) 
        acc1 (ids_at loc d)
    ) [] [loc; loc ++ (1,0); loc ++ (-1,0); loc ++ (0,1); loc ++ (0,-1)]
  
    

  let rm ru d =
    let i = ru.Unit.id in
    match id i d with
    | Some u ->
        let loc = u.Unit.loc in
        let d_id = Mi.remove i d.id in
        let d_at = 
        ( match List.filter ((<>)i) (ids_at loc d) with
          | [] -> Ml.remove loc d.at
          | ls -> Ml.add loc ls d.at ) in
        {id=d_id; at=d_at}
    | None -> d
  
  let upd u d = 
    let d1 = rm u d in
    let i = u.Unit.id in
    let loc = u.Unit.loc in
    let d2_at = Ml.add loc (i :: ids_at loc d1) d1.at in
    let d2_id = Mi.add i u d1.id in
    {at = d2_at; id = d2_id}

  let iter f d = Mi.iter (fun k u -> f u) d.id

  let fold f acc d = Mi.fold (fun k u acc -> f acc u) d.id acc
end


let default_factions_number = 11

(* Movables, bulk counted movable goods and population *)
module Mov = struct
  type t = {res: Resource.t; fac: int array}

  let zero() = {res = Resource.zero; fac = Array.make default_factions_number 0}
  
  let res x = {res = x; fac = Array.make default_factions_number 0}

  let add {res=res1; fac=fac1} {res=res2; fac=fac2} =
    {res = Resource.add res1 res2; fac = Array.init default_factions_number (fun i -> fac1.(i) + fac2.(i))}
  
  let subtract {res=res1; fac=fac1} {res=res2; fac=fac2} =
    {res = Resource.subtract res1 res2; fac = Array.init default_factions_number (fun i -> fac1.(i) - fac2.(i))}

  let subtract_unit {res; fac} u =
    {res = Resource.subtract res (Unit.decompose u); fac = Array.mapi (fun i pop -> if i<>Unit.get_faction u then pop else pop-1) fac}

  let scale c {res;fac} =
    {res = Resource.scale c res; fac = Array.map (fun x -> (c *. (float) x) |> floor |> int_of_float) fac}
end

type region_id = int
type region_loc = (int*loc)

(* Region meta info *)
module RM = struct
  type biome = Sea | SandyShore | Plains | Mnt | SnowMnt | ForestMnt | Forest | DeepForest | Swamp | Dungeon | Cave | Tomb
  type modifier = {urban:bool; cursed:bool}
  type constype = CHouse | CFarm | CMarket of Item.Cnt.t | CFactory | CCityHall
  type construction = {constype: constype; consloc:loc}

  type t = {seed:int; biome:biome; modifier:modifier; altitude:int; lat:Mov.t; alloc:Mov.t; cons: construction list;
    difficulty: float
  }

  let get_difficulty rm = rm.difficulty 
end

(* Politics stab module *)
module Pol = struct

  type fac_class = Civil | Rogue | Wild 
  type fac_traits = {militaristic:bool; industrial:bool; agricult:bool; religious:bool}
  type fac_prop = {fsp:fac_spec; cl:fac_class; 
    speciesls : Species.t list;
    vio_ok:int; lawful:int; selfesteem:int; traits:fac_traits; 
    htrm: ((RM.biome*RM.modifier), float) Hashtbl.t}

  type policy = Ally | Neutral | AtWar

  type rel_like = float (* +10 = like, -10 = afraid, 0 = neutral *)
  type rel_act = float (* +10 = helpful actions; 0 = no action, -10 = aggresive actions *)

  type t = {facnum:int; prop: fac_prop array; 
    rel_like: (rel_like array) array; 
    rel_act: (rel_act array) array; 
    policy: (policy array) array}
end


(* Region module *)
module R = struct
  (* active objects *)
  module Obj = struct
    type stairs_type = StairsUp | StairsDown
    type stairs = (stairs_type * loc)

    (* positional object type *)
    type door_state = Open | Closed
    type pos_obj_type = Door of door_state
    
    type t = {projls:Proj.t list; stairsls: stairs list; posobj: (pos_obj_type option) Area.t}
    let empty w h = {projls=[]; stairsls = []; posobj = Area.make w h None }
  end

  type t = {
    rid: region_id; 
    a: Tile.t Area.t;
    loc0: loc;
    e: E.t; 
    explored: (Tile.t option) Area.t; 
    optinv: (Inv.t option) Area.t;
    obj: Obj.t;}

  (* decompose region (only non-player units if b=true) *)
  let decompose_nonplayer_only b reg = 
    let res_units =
      E.fold (fun res u -> 
        if Unit.get_controller u = None || (not b) then
          Resource.add res (Unit.decompose u) 
        else res) 
        Resource.zero reg.e in
    let res_ground =
      fold_lim (fun acc i -> 
          fold_lim (fun acc j ->
            match Area.get reg.optinv (i,j) with
            | Some inv -> Resource.add acc (Inv.decompose inv)
            | None -> acc
          )
          acc 0 (Area.h reg.optinv - 1)
        ) 
        Resource.zero 0 (Area.w reg.optinv - 1) in
      
    let mv = Mov.zero () in
    E.iter (fun u ->
        if Unit.get_controller u = None || (not b) then
        ( let fac = Unit.get_faction u in
          mv.Mov.fac.(fac) <- mv.Mov.fac.(fac) + 1 )
      ) reg.e;
    {mv with Mov.res=(Resource.add res_units res_ground)}

  let decompose = decompose_nonplayer_only false

  let get_rid reg = reg.rid
end

(* Utilities *)
let find_location a pred = 
  let w = Area.w a in
  let h = Area.h a in
  let rec attempt n =
    let loc = Random.int w, Random.int h in
    if pred n loc then
      loc
    else
      attempt (n-1)
  in
  attempt 0

let find_walkable_location_a_e a e =
  find_location a 
    ( fun n loc -> 
        let c1 = Tile.can_walk (Tile.classify (Area.get a loc)) in
        let c2 = not (E.occupied loc e) in
        c1 && (n > 50 || c2) )

let find_walkable_location_reg reg =
  find_walkable_location_a_e reg.R.a reg.R.e

let find_placement_location area obj =
  find_location 
    area 
    ( fun n loc -> 
        let c1 = Tile.can_walk (Tile.classify (Area.get area loc)) in
        let c2 = not (List.exists (fun (_,locx) -> loc = locx) obj.R.Obj.stairsls) in
        c2 && (n > 50 || c1) )

let find_entry_loc (i,j) edge reg1 reg2 obj2 = 
  let (i,j) = (i,j) ++ reg1.R.loc0 -- reg2.R.loc0 in
  let area = reg2.R.a in
  let rec search loc d1 d2 i =
    let loc1 = loc ++ i %% d1 in
    let loc2 = loc ++ i %% d2 in
    if is_walkable area loc1 then Some loc1 else
    if is_walkable area loc2 then Some loc2 else
    ( if Area.is_within area (loc1++d1) || Area.is_within area (loc2++d2) then
        search loc d1 d2 (i+1)
      else 
        None
    )
  in
  let rec search_stairs stt = function
    | (t, loc)::tl when t = stt -> Some loc
    | _::tl -> search_stairs stt tl
    | [] -> None
  in
  match edge with
  | East -> search (0,j) (0,1) (0,-1) 0
  | West -> search (Area.w area - 1, j) (0,-1) (0,1) 0
  | North -> search (i,0) (-1,0) (1,0) 0
  | South -> search (i, Area.h area - 1) (1,0) (-1,0) 0
  | Up -> search_stairs R.Obj.StairsDown obj2.R.Obj.stairsls
  | Down -> search_stairs R.Obj.StairsUp obj2.R.Obj.stairsls
  | _ -> None


module Decision = struct

  type intention = Kill | Beat | Ignore | Avoid | Trade_with
  module C = struct

    let initiative_roll_against c1 c2 =
      let str1 = Unit.Core.approx_strength c1 in
      let str2 = Unit.Core.approx_strength c2 in
      Random.float (str1 +. str2) < str1

    let get_intention pol c1 c2 = 
      let courage = Unit.Core.get_courage c1 in
      let str1 = Unit.Core.approx_strength c1 in
      let str2 = Unit.Core.approx_strength c2 in
      if pol.Pol.rel_act.(c1.Unit.Core.fac).(c2.Unit.Core.fac) < 0. then 
        ( if str1 *. courage > str2 then
            Kill
          else
            Avoid
        )
      else 
        Ignore
  end
  
  module U = struct
    let get_intention pol u1 u2 = 
      C.get_intention pol u1.Unit.core u2.Unit.core
  end

end
