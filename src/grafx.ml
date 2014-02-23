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

open Sdl
open Video
(*
open Window
open Timer
open Event
*)
open SDLGL
(*open Draw*)
open Glcaml

let load_image bmp =
  let s1 = (load_bmp bmp) in
  let s2 = display_format s1 in 
  lock_surface s2;
    let arr = surface_pixels s2 in
    let open Bigarray in

    for i = 0 to Array1.dim arr / 4 - 1 do
      let ii = 4*i in
      let r, g, b, a = arr.{ii}, arr.{ii+1}, arr.{ii+2}, arr.{ii+3} in 
      if r = 0 && g = 255 && b = 255 then
        arr.{ii+3} <- 0
      else
        arr.{ii+3} <- 255
    done;

  unlock_surface s2;
  free_surface s1;
  s2

let texture = Array.make 1 0

let load_gl_textures () =
	let s = load_image "data/z.bmp" in
	glGenTextures 1 texture;
	glBindTexture gl_texture_2d texture.(0);
  glTexParameteri gl_texture_2d gl_texture_mag_filter gl_nearest; (* scale linearly when image bigger than texture *)
	glTexParameteri gl_texture_2d gl_texture_min_filter gl_linear; (* scale linearly when image smalled than texture *)
  (* 2d texture, level of detail 0 (normal), 3 components (red, green, blue), x size from image, y size from image, 
     border 0 (normal), rgb color data, unsigned byte data, and finally the data itself. *)
  (*
  glTexImage2D gl_texture_2d 0 3 (surface_width s) (surface_height s) 0
    gl_rgb gl_unsigned_byte (surface_pixels s)
  *)  
  glTexImage2D gl_texture_2d 0 4 (surface_width s) (surface_height s) 0
    gl_rgba gl_unsigned_byte (surface_pixels s)


let limx = 1.0/.256.0 
let limy = 1.0/.256.0 
let subimage (dx, dy) z (tx, ty) (vx, vy) =
  let tx0 = dx *. tx *. limx in
  let tx1 = dx *. (tx +. 1.0) *. limx  in
  let ty1 = 1.0 -. dy *. ty *. limy  in
  let ty0 = 1.0 -. dy *. (ty +. 1.0) *. limy in
  let vx1 = vx +. dx*.z in
  let vy1 = vy +. dy*.z in
  glTexCoord2f tx0 ty0; glVertex2f  vx   vy; (* Bottom Left Of The Texture and Quad *)
  glTexCoord2f tx1 ty0; glVertex2f  vx1  vy; (* Bottom Right Of The Texture and Quad *)
  glTexCoord2f tx1 ty1; glVertex2f  vx1 vy1; (* Top Right Of The Texture and Quad *)
  glTexCoord2f tx0 ty1; glVertex2f  vx  vy1  (* Top Left Of The Texture and Quad *)

let subimage_wh w h (dx, dy) z (tx, ty) (vx, vy) =
  let tx0 = dx *. tx *. limx in
  let tx1 = dx *. (tx +. 1.0*.w) *. limx  in
  let ty1 = 1.0 -. dy *. ty *. limy  in
  let ty0 = 1.0 -. dy *. (ty +. 1.0*.h) *. limy in
  let vx1 = vx +. dx*.z*.w in
  let vy1 = vy +. dy*.z*.h in
  glTexCoord2f tx0 ty0; glVertex2f  vx   vy; (* Bottom Left Of The Texture and Quad *)
  glTexCoord2f tx1 ty0; glVertex2f  vx1  vy; (* Bottom Right Of The Texture and Quad *)
  glTexCoord2f tx1 ty1; glVertex2f  vx1 vy1; (* Top Right Of The Texture and Quad *)
  glTexCoord2f tx0 ty1; glVertex2f  vx  vy1  (* Top Left Of The Texture and Quad *)

let grid_pos (dx, dy) z (i, j) = z *. dx *. float i,  z *. dy *. float j

let grid_pos_vec (dx, dy) z (i, j) = floor(z *. dx *. i),  floor(z *. dy *. j)

module Draw = struct
  let z = 2.0

  let (dx_sml, dy_sml) as dxdy_sml = (7.0, 7.0)
  let dxdy_big = (14.0, 14.0)
  
  let draw_ss txty (i,j) = subimage dxdy_sml z txty (grid_pos dxdy_sml z (i+1,j+1))
  let draw_bb txty (i,j) = subimage dxdy_big z txty (grid_pos dxdy_big z (i+1,j+1))
  
  let draw_ss_wh txty w h (i,j) = subimage_wh w h dxdy_sml z txty (grid_pos dxdy_sml z (i+1,j+1 + 1 - int_of_float h))
  
  let draw_ss_vec txty (x,y) = subimage dxdy_sml z txty (grid_pos_vec dxdy_big z (x+.1.0,y+.1.0))
  let draw_bb_vec txty (x,y) = subimage dxdy_big z txty (grid_pos_vec dxdy_big z (x+.1.0,y+.1.0))

  let put_char ch ij =
    let code = Char.code ch in
    if code>32 && code <128 then
      let k = code - 33 in
      draw_ss (float (k mod 18), float (k/18)) ij
    else
    if code = 32 then 
      draw_ss (float (94 mod 18), float (94/18)) ij
    else
      failwith (Printf.sprintf "put_char: char '%c' is out of range" ch)

  let put_string s (i, j) = 
    for e = 0 to String.length s - 1 do
      put_char s.[e] (i+e, j)
    done
  
  let put_char_vec ch xy =
    let code = Char.code ch in
    if code>32 && code <128 then
      let k = code - 33 in
      draw_ss_vec (float (k mod 18), float (k/18)) xy
    else
    if code = 32 then 
      draw_ss_vec (float (94 mod 18), float (94/18)) xy
    else
      failwith (Printf.sprintf "put_char: char '%c' is out of range" ch)

  let put_string_vec s (x, y) = 
    for e = 0 to String.length s - 1 do
      put_char_vec s.[e] (x +. 0.5*.float e, y)
    done
end


(* A general OpenGL initialization function.  Sets all of the initial parameters. *)
let init_gl width height =
	(* load_gl_textures (); *)
	glViewport 0 0 width height;
	glClearColor 0.1 0.1 0.1 0.0;
	glClearDepth 1.0;
	(* glDepthFunc gl_less;
	glEnable gl_depth_test; *)
	glEnable gl_texture_2d;
  load_gl_textures();
  (*glTexEnvi gl_texture_env gl_texture_env_mode gl_modulate;*)
  
  (*glShadeModel gl_smooth;*)
	glMatrixMode gl_projection;
	glLoadIdentity ();
	(* let aspect = (float_of_int width) /. (float_of_int height) in
	perspective 45.0 aspect 1.0 100.0; *)
  glOrtho 0.0 (float width) 0.0 (float height) (-5.0) (5.0);

  glMatrixMode gl_modelview;
	(* Set up lights *)
	(* glEnable gl_lighting;
	glLightfv gl_light1 gl_ambient light_ambient;
	glLightfv gl_light1 gl_diffuse light_diffuse;
	glLightfv gl_light1 gl_position light_position;
	glEnable gl_light1;	 *)
	(* setup blending *)
	
  glBlendFunc gl_src_alpha gl_one_minus_src_alpha; (* Set The Blending Function For Translucency *)
  glEnable gl_blend;
  glDisable gl_color_material
  (* glColor4f 1.0 0.2 0.6 0.5;  *) 
  (*glLineWidth 2.0 *)

