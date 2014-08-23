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

open Base

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


module TxInfo = struct
  type tx_coord_arr = float array array
  
  type t = {xc : tx_coord_arr; yc: tx_coord_arr; fw:float; fh:float; iw:int; ih:int}

  let make (fullw, fullh) (iw, ih) =
    let fw = float iw in
    let fh = float ih in
    let limx = 1.0 /. float fullw in
    let limy = 1.0 /. float fullh in

    let tw = fullw / iw in
    let th = fullh / ih in

    let xc = Array.make_matrix (tw+1) (th+1) 0.0 in
    let yc = Array.make_matrix (tw+1) (th+1) 0.0 in

    for i = 0 to tw do
      for j = 0 to th do
        let tx = fw *. float i *. limx in
        let ty = 1.0 -. fh *. (float j) *. limy in
        xc.(i).(j) <- tx;
        yc.(i).(j) <- ty;
      done
    done;

    {xc; yc; fw; fh; iw; ih}
end

module Predraw = struct
  open TxInfo

  let subimagei z tx (ti, tj) (vx, vy) =
    let vx1 = vx + tx.iw * z in
    let vy1 = vy + tx.ih * z in
    glTexCoord2f tx.xc.(ti).(tj+1)   tx.yc.(ti).(tj+1);    glVertex2i  vx   vy; (* Bottom Left Of The Texture and Quad *)
    glTexCoord2f tx.xc.(ti+1).(tj+1) tx.yc.(ti+1).(tj+1);  glVertex2i  vx1  vy; (* Bottom Right Of The Texture and Quad *)
    glTexCoord2f tx.xc.(ti+1).(tj)   tx.yc.(ti+1).(tj);    glVertex2i  vx1 vy1; (* Top Right Of The Texture and Quad *)
    glTexCoord2f tx.xc.(ti).(tj)     tx.yc.(ti).(tj);      glVertex2i  vx  vy1  (* Top Left Of The Texture and Quad *)
  
  let subimagei_stretch_wh (sx,sy) w h z tx (ti, tj) (vx, vy) =
    let vx1 = vx + tx.iw * w * z * sx in
    let vy1 = vy + tx.ih * h * z * sy in
    glTexCoord2f tx.xc.(ti).(tj+h)   tx.yc.(ti).(tj+h);    glVertex2i  vx   vy; (* Bottom Left Of The Texture and Quad *)
    glTexCoord2f tx.xc.(ti+w).(tj+h) tx.yc.(ti+w).(tj+h);  glVertex2i  vx1  vy; (* Bottom Right Of The Texture and Quad *)
    glTexCoord2f tx.xc.(ti+w).(tj)   tx.yc.(ti+w).(tj);    glVertex2i  vx1 vy1; (* Top Right Of The Texture and Quad *)
    glTexCoord2f tx.xc.(ti).(tj)     tx.yc.(ti).(tj);      glVertex2i  vx  vy1  (* Top Left Of The Texture and Quad *)
  
  let subimagei_wh = subimagei_stretch_wh (1,1)
  
  let round x = (x +. 0.5) |> floor |> int_of_float

  let subimagef z tx (ti, tj) (vx, vy) =
    let vx = round vx in
    let vy = round vy in
    let vx1 = vx + tx.iw * z in
    let vy1 = vy + tx.ih * z in
    glTexCoord2f tx.xc.(ti).(tj+1)   tx.yc.(ti).(tj+1);      glVertex2i  vx   vy; (* Bottom Left Of The Texture and Quad *)
    glTexCoord2f tx.xc.(ti+1).(tj+1) tx.yc.(ti+1).(tj+1);    glVertex2i  vx1  vy; (* Bottom Right Of The Texture and Quad *)
    glTexCoord2f tx.xc.(ti+1).(tj)   tx.yc.(ti+1).(tj);  glVertex2i  vx1 vy1; (* Top Right Of The Texture and Quad *)
    glTexCoord2f tx.xc.(ti).(tj)     tx.yc.(ti).(tj);    glVertex2i  vx  vy1  (* Top Left Of The Texture and Quad *)
  
  let subimagef_wh w h z tx (ti, tj) (vx, vy) =
    let vx = round vx in
    let vy = round vy in
    let vx1 = vx + tx.iw * w * z in
    let vy1 = vy + tx.ih * h * z in
    glTexCoord2f tx.xc.(ti).(tj+h)   tx.yc.(ti).(tj+h);    glVertex2i  vx   vy; (* Bottom Left Of The Texture and Quad *)
    glTexCoord2f tx.xc.(ti+w).(tj+h) tx.yc.(ti+w).(tj+h);  glVertex2i  vx1  vy; (* Bottom Right Of The Texture and Quad *)
    glTexCoord2f tx.xc.(ti+w).(tj)   tx.yc.(ti+w).(tj);    glVertex2i  vx1 vy1; (* Top Right Of The Texture and Quad *)
    glTexCoord2f tx.xc.(ti).(tj)     tx.yc.(ti).(tj);      glVertex2i  vx  vy1  (* Top Left Of The Texture and Quad *)
end

module Grid = struct
  type t = {
    x0: int; y0: int; dx: int; dy: int;
    x0f: float; y0f: float; dxf: float; dyf: float
  }

  let make x0 y0 dx dy =
    { x0; y0; dx; dy; 
      x0f = float x0; y0f = float y0;
      dxf = float dx; dyf = float dy;
    }

  let posi z g (i,j) = (z*(g.x0 + i*g.dx (* + j*g.dx/2 *)), z*(g.y0 + j*g.dy))
  let posf z g (i,j) = (z*.(g.x0f +. i*.g.dxf (* +. 0.5*.j*.g.dxf *)), z*.(g.y0f +. j*.g.dyf))
end

module Draw = struct
  let zi = 2
  let zf = float zi

  let tx_text = TxInfo.make (256,256) (7,7)
  let tx_tile = TxInfo.make (256,256) (14,14)
  let tx_sml_tile = TxInfo.make (256,256) (7,7)

  let gr_map = Grid.make (7) (7) 14 14
  let gr_sml_ui = Grid.make 0 0 7 7
  let gr_ui = Grid.make 0 0 14 14
  let gr_atlas = Grid.make (7*50) (7*5) 7 7

  let draw_text tij gr ij = Predraw.subimagei zi tx_text tij (Grid.posi zi gr ij)
  let draw_tile tij gr ij = Predraw.subimagei zi tx_tile tij (Grid.posi zi gr ij)
  let draw_sml_tile tij gr ij = Predraw.subimagei zi tx_sml_tile tij (Grid.posi zi gr ij)
  let draw_sml_tile_wh w h tij gr ij = Predraw.subimagei_wh w h zi tx_sml_tile tij (Grid.posi zi gr ij)
 
  let draw_tile_stretch_wh sxsy w h tij gr ij = 
    Predraw.subimagei_stretch_wh sxsy w h zi tx_tile tij (Grid.posi zi gr ij)

  let draw_text_vec tij gr xy = Predraw.subimagef zi tx_text tij (Grid.posf zf gr xy)
  let draw_tile_vec tij gr xy = Predraw.subimagef zi tx_tile tij (Grid.posf zf gr xy)
  let draw_sml_tile_vec tij gr xy = Predraw.subimagef zi tx_sml_tile tij (Grid.posf zf gr xy)
  let draw_sml_tile_wh_vec w h tij gr xy = Predraw.subimagef_wh w h zi tx_sml_tile tij (Grid.posf zf gr xy)

  let put_char ch gr ij =
    let code = Char.code ch in
    if code>32 && code <128 then
      let k = code - 33 in
      draw_text ((k mod 18), (k/18)) gr ij
    else
    if code = 32 then 
      draw_text ((94 mod 18), (94/18)) gr ij
    else
      failwith (Printf.sprintf "put_char: char '%c' is out of range" ch)

  let put_string s gr (i, j) = 
    for e = 0 to String.length s - 1 do
      put_char s.[e] gr (i+e, j)
    done
  
  let put_char_vec ch gr xy =
    let code = Char.code ch in
    if code>32 && code <128 then
      let k = code - 33 in
      draw_text_vec ((k mod 18), (k/18)) gr xy
    else
    if code = 32 then 
      draw_text_vec ((94 mod 18), (94/18)) gr xy
    else
      failwith (Printf.sprintf "put_char: char '%c' is out of range" ch)

  let put_string_vec s gr (x, y) = 
    for e = 0 to String.length s - 1 do
      put_char_vec s.[e] gr (x +. 0.5*.float e, y)
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

