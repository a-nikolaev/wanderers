(*
 * Copyright (C) 2007, 2008 Elliott OTI
 *
 * Redistribution and use in source and binary forms, with or without modification, are permitted provided 
 * that the following conditions are met:
 *  - Redistributions of source code must retain the above copyright notice, this list of conditions 
 *    and the following disclaimer.
 *  - Redistributions in binary form must reproduce the above copyright notice, this list of conditions 
 *    and the following disclaimer in the documentation and/or other materials provided with the distribution.
 *  - The name Elliott Oti may not be used to endorse or promote products derived from this software 
 *    without specific prior written permission.
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
 * 'AS IS' AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
 * LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
 * A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR
 * CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
 * EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
 * PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
 * PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
 * LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
 * NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
 * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 *)

(*********************** Windowing ****************************************)
(* 
 * To prepare an Ocaml graphics window for use with OpenGL the following hack is used. 
 * The method is similar, but not identical, on both Windows and X11. 
 * After opening the window with Graphics.open_graph (), the function init_opengl ()
 * has to be called. This function gives the window a (hopefully) unique name. Then 
 * some C code is called which searches through all available windows for a window
 * with that particular name, gets pointers to its internal structure (both Win32 and
 * Xlib allow this) and sets it up for use as an OpenGL surface.
 *
 * Compiling:
 * You need the files win_stub.c, win.ml and win.mli
 * Link the resultant executable with libGL.a on X11, opengl32.lib and gdi32.lib on Windows
 *
 * Usage:
 * First set up your caml window with Graphics.open_graph ()
 * Next, call the function init_gl () defined here below.
 * After this you can (re)set the window title (if you set it previously it will be empty)
 * Feel free to call any OpenGL calls you wish. lablgl, glcaml and camlgl may all be used.
 * You may mix the Ocaml graphics functions with OpenGL.
 * Call swap_buffers () any time you need to flip the contents of your back buffer to the screen.
 *)

external init_gl' : string -> unit = "stub_init_gl" "stub_init_gl"
external swap_buffers : unit -> unit = "stub_swap_buffers" "stub_swap_buffers"

let init_opengl () =
	let _  = Random.self_init () in
	let title = Printf.sprintf "%d.%d" (Random.int 1000000) (Random.int 1000000) in
	Graphics.set_window_title title;
	init_gl' title;
	Graphics.set_window_title "";;

(* Sleep for n microseconds *)
external usleep: int -> unit = "stub_usleep"

	

