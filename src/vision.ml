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

let zero_area z =
  (* zero all z *)
  for x = 0 to Area.w z - 1 do
    for y = 0 to Area.h z - 1 do
      Area.set z (x,y) 0
    done
  done

let add_sight a opt_ex z locmap (x0,y0) sight_distance =
  let b loc = 
    let loc' = locmap loc in
    Area.is_within a loc' &&
    Tile.can_look (Tile.classify (Area.get a loc')) in

  let mark =
    match opt_ex with 
      Some ex -> 
      ( fun loc -> 
          let mapped_loc = locmap loc in
          Area.set z mapped_loc 1;
          Area.set ex mapped_loc (Some (Area.get a mapped_loc)) )
    | _ -> 
      ( fun loc -> 
          let mapped_loc = locmap loc in
          Area.set z mapped_loc 1 )
  in

  let rec scan range (xfl,yfl) (xfh,yfh) prev_x prev_yl prev_yh =
    let continue, range' = 
      match range with
      | None -> true, None
      | Some x when x > 0 -> true, Some (x-1)
      | Some x -> false, Some (x-1)
    in
    if continue then
      ( let x = prev_x + 1 in
        let f x = if x >= 1 then 1 else 0 in 
        let yl = prev_yl + f ( 2 * ((yfl - y0)*(x-x0) + (y0-prev_yl)*(xfl-x0)) / (xfl-x0) ) in
        let yh = prev_yh + f ( 2 * ((yfh - y0)*(x-x0) + (y0-prev_yh)*(xfh-x0)) / (xfh-x0) ) in
        let _ = 
          fold_lim 
            ( fun (((xfl',yfl') as xyfl'),((xfh',yfh') as xyfh'), opt_lower) y ->
                if b (x,y) then
                ( mark (x,y);
                  (* also see neighboring cells *)
                  let rec wider_range = function
                    | (dx,dy)::tl -> 
                        let lc = (x+dx,y+dy) in 
                        let mapped_lc = locmap lc in
                        if Area.is_within a mapped_lc && not (Tile.can_look(Tile.classify (Area.get a mapped_lc))) then
                        ( mark lc );
                        wider_range tl
                    | [] -> ()
                  in
                  if b (x,y) then wider_range [(1,0); (-1,0); (0,1); (0,-1)];
                         

                  match opt_lower with
                  | Some yl' -> 
                      if y = yh then scan range' xyfl' xyfh' x yl' (y);
                      (xyfl', xyfh', Some yl')
                  | None -> ((x,y), xyfh', Some y)
                )
                else
                ( (* mark walls in the field of sight *)
                  if Area.is_within a (locmap (x,y)) then mark (x,y); 
                  match opt_lower with
                  | Some yl' -> 
                      scan range' xyfl' (x,y-1) x yl' (y-1);
                      ((x,y+1), xyfh', None)
                  | None -> ((x,y+1), xyfh', None)
                )
            
            ) ((xfl,yfl), (xfh,yfh), (if b(x,yl) then Some yl else None)) yl yh in
        () )
  in
  scan (Some sight_distance) (x0+1,y0) (x0+1,y0+1) (x0) y0 (y0)



(* single mob sight *)
let update_mob_sight reg sight_distance u =
  let u' = 
    let w = Area.w reg.R.a in
    let h = Area.h reg.R.a in
    if Area.w u.Unit.sight <> w || Area.h u.Unit.sight <> h then
      {u with Unit.sight = Area.make w h 0} 
    else 
    ( zero_area u.Unit.sight; u )
  in
  let loc0 = u'.Unit.loc in
  if Area.is_within reg.R.a loc0 then
  ( Area.set u'.Unit.sight loc0 1;
  );
  List.iter
    ( fun locmap -> add_sight reg.R.a None u'.Unit.sight
        (fun loc -> loc0 ++ (locmap (loc -- loc0)) )
        u'.Unit.loc sight_distance)
    [ (fun (x,y) -> ( x, y));
      (fun (x,y) -> (-x, y));
      (fun (x,y) -> ( x,-y));
      (fun (x,y) -> (-x,-y));
      (fun (x,y) -> ( y, x));
      (fun (x,y) -> (-y, x));
      (fun (x,y) -> ( y,-x));
      (fun (x,y) -> (-y,-x));
    ];
  u'


(* sight for the controller *)
let update_sight controller reg z =
  let condition m = Unit.get_controller m = controller in 
  zero_area z;
  E.iter 
    ( fun mob -> 
        if condition mob then
        ( let loc0 = mob.Unit.loc in
          if Area.is_within reg.R.a loc0 then
          ( Area.set z loc0 1;
            Area.set reg.R.explored loc0 (Some (Area.get reg.R.a loc0));
          );
          List.iter
            ( fun locmap -> add_sight reg.R.a (Some reg.R.explored) z
                  (fun loc -> loc0 ++ (locmap (loc -- loc0)) )
                  mob.Unit.loc 8 )
            [ (fun (x,y) -> ( x, y));
              (fun (x,y) -> (-x, y));
              (fun (x,y) -> ( x,-y));
              (fun (x,y) -> (-x,-y));
              (fun (x,y) -> ( y, x));
              (fun (x,y) -> (-y, x));
              (fun (x,y) -> ( y,-x));
              (fun (x,y) -> (-y,-x));
            ]
        )
    ) reg.R.e
  
