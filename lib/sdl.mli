(**  SDLCaml, an Objective Caml interface for the SDL library *)


(** The general exception thrown by SDL in case of failure *) 
exception SDL_failure of string

(** Unsigned char Bigarrays, with C-style layout *)
type byte_array = (int, Bigarray.int8_unsigned_elt, Bigarray.c_layout) Bigarray.Array1.t

(** Initialization flags*)
type init_flag =
  | TIMER			(** Initialize timer subsystem *)
  | AUDIO			(** Initialize audio subsystem *)
  | VIDEO			(** Initialize video subsystem *)
  | CDROM			(** Initialize CD ROM subsystem *)
  | JOYSTICK		(** Initialize joystick subsystem *)
  | NOPARACHUTE     (** Don't catch fatal signals *)
  | EVENTTHREAD		(** Run the event manager in a separate thread. Link with the Ocaml thread library if using this *)
  | EVERYTHING		(** Initialize all of the above subsystems, except for EVENTTHREAD *)

(** Initializes SDL. This should be called before all other SDL functions. 
	The init_flag parameter is a list specifies what part(s) of SDL to initialize. 
	Raises SDL_failure on failure *)  
val init : init_flag list -> unit

(** Shuts down all SDL subsystems and frees the resources allocated to them.  *)
val quit : unit -> unit

(**	Gets a string containing a description of the most recent SDL error *)
val get_error : unit -> string


(** Interface to SDL framebuffer
	 
	SDL presents a very simple interface to the display framebuffer. The framebuffer is represented as an 
	offscreen surface to which you can write directly. If you want the screen to show what you have written, 
	call the update function which will guarantee that the desired portion of the screen is updated.

	Before you call any of the SDL video functions, you must first call [init \[VIDEO\]], 
	which initializes the video and events in the SDL library. Check for the exception [SDL_failure], 
	to see if there were any errors in starting up.

	If you use both sound and video in your application, you need to call  [init \[AUDIO; VIDEO\]] 
	before opening the sound device, otherwise under Win32 DirectX, you won't be able to set full-screen display modes.

	After you have initialized the library, you can start up the video display in a number of ways. 
	The easiest way is to pick a common screen resolution and depth and just initialize the video, checking for errors. 
	You will probably get what you want, but SDL may be emulating your requested mode and converting the display 
	on update. The best way is to query, for the best video mode closest to the desired one, and then convert 
	your images to that pixel format.

	SDL currently supports any bit depth >= 8 bits per pixel. 8 bpp formats are considered 8-bit palettized modes, 
	while 12, 15, 16, 24, and 32 bits per pixel are considered "packed pixel" modes, meaning each pixel contains the 
	RGB color components packed in the bits of the pixel.

	After you have initialized your video mode, you can take the surface that was returned, and write to it 
	like any other framebuffer, calling the update routine as you go.

	When you have finished your video access and are ready to quit your application, you should call [quit ()] to 
	shutdown the video and events. *)
module Video : sig

	(** Flags that determine properties of video surfaces *)
	type video_flag =
	| SWSURFACE   (** Surface is in system memory *)
	| HWSURFACE   (** Surface is in video memory *)
	| ANYFORMAT   (** Allow any video pixel format *)
	| HWPALETTE   (** Surface has exclusive palette *)
	| DOUBLEBUF   (** Set up double-buffered video mode *)
	| FULLSCREEN  (** Surface is a full screen display *)
	| HWACCEL     (** Blit uses hardware acceleration *)
	| SRCCOLORKEY (** Blit uses a source color key *)
	| RLEACCEL    (** Colorkey blit is RLE accelerated *)
	| SRCALPHA    (** Blit uses source alpha blending *)
	| SRCCLIPPING (** Blit uses source clipping *)
	| OPENGL	  (** Surface supports OpenGL *)
	| RESIZABLE	  (** Surface is resizable *)	
	| NOFRAME	  (** Creates a window with no title frame and no border *)
	
	(** A surface is a software or hardware framebuffer *)  
	type surface
	
	(** Get a byte_array containing the raw pixel data. Non-copying *)
	val surface_pixels : surface -> byte_array
	
	(** Get the surface width in pixels *)
	val surface_width : surface -> int
	
	(** Get the surface height in pixels *)
	val surface_height : surface -> int
	
	(** Get a list of the surface flags *)
	val surface_flags : surface -> video_flag list
	
	(** Get the number bits per pixel for the surface *)
	val surface_bpp : surface -> int
	
	(** Get the mask for the red color component for each pixel for the surface *)
	val surface_rmask : surface -> int
	
	(** Get the mask for the green color component for each pixel for the surface *)
	val surface_gmask : surface -> int
	
	(** Get the mask for the blue color component for each pixel for the surface *)
	val surface_bmask : surface -> int
	
	(** Get the mask for the alpha component for each pixel for the surface *)
	val surface_amask : surface -> int
	
	(** Free a surface. Note: after freeing a surface it cannot be used again. *)
	val free_surface : surface -> unit
	
	(** [True] if the surface passed in should be locked, else [false] *)
	val must_lock : surface -> bool

	(** [lock_surface ()] sets up a surface for directly accessing the pixels. Between calls to [lock_surface ()] 
		and [unlock_surface ()], you can write to and read from [(surface_pixels _)], using the pixel format stored in 
		[(surface_format _)]. Once you are done accessing the surface, you should use [unlock_surface ()] to release it.
		Not all surfaces require locking. If [(must_lock surface)] is [false], then you can read and write 
		to the surface at any time, and the pixel format of the surface will not change. 
		No operating system or library calls should be made between [lock/unlock] pairs, as critical system locks 
		may be held during this time.
		It should be noted, that since SDL 1.1.8 surface locks are recursive. This means that you can lock a 
		surface multiple times, but each lock must have a match unlock. *)
	val lock_surface : surface -> unit
	
	(** Unlock surface*)
	val unlock_surface : surface -> unit

	(** [video_mode_ok width height bpp_flags -> true/false]
		[video_mode_ok] returns false if the requested mode is not supported under any bit depth, 
	    or returns true if a closest available mode with the given width, height and 
	    requested surface flags exists (see [set_video_mode]).
		You can usually request any bpp you want when setting the video mode and SDL will emulate that 
		color depth with a shadow video surface.
		The arguments to [video_mode_ok] are the same ones you would pass to [set_video_mode]*)
	val video_mode_ok : int -> int -> int -> video_flag list -> bool
		 
	(** [set_video_mode width height bpp flags -> surface] 
		Set up a video mode with the specified width, height and bitsperpixel.
		If bpp is 0, it is treated as the current display bits per pixel.
		The flags parameter is the same as the flags field of the SDL surface structure. 
		A list containing one or more of the following values are valid.
		- [SWSURFACE] Create the video surface in system memory 
		- [HWSURFACE] Create the video surface in video memory 
		- [ASYNCBLIT] Enables the use of asynchronous updates of the display surface. This will usually slow down blitting on single CPU machines, but may provide a speed increase on SMP systems. 
		- [ANYFORMAT] Normally, if a video surface of the requested bits-per-pixel (bpp) is not available, SDL will emulate one with a shadow surface. Passing [ANYFORMAT] prevents this and causes SDL to use the video surface, regardless of its pixel depth. 
		- [HWPALETTE] Give SDL exclusive palette access. Without this flag you may not always get the the colors you request with SDL_SetColors or SDL_SetPalette. 
		- [DOUBLEBUF] Enable hardware double buffering; only valid with [HWSURFACE]. Calling [flip] will flip the buffers and update the screen. All drawing will take place on the surface that is not displayed at the moment. If double buffering could not be enabled then [flip] will just perform a [update_rect] on the entire screen. 
		- [FULLSCREEN] SDL will attempt to use a fullscreen mode. If a hardware resolution change is not possible (for whatever reason), the next higher resolution will be used and the display window centered on a black background. 
		- [OPENGL] Create an OpenGL rendering context. You should have previously set OpenGL video attributes with [set_attribute]. 
		- [OPENGLBLIT] Create an OpenGL rendering context, like above, but allow normal blitting operations. The screen (2D) surface may have an alpha channel, and [update_rects] must be used for updating changes to the screen surface. 
		- [RESIZABLE] Create a resizable window. When the window is resized by the user a [VIDEORESIZE] event is generated and [set_video_mode] can be called again with the new size. 
		- [NOFRAME] If possible, [NOFRAME] causes SDL to create a window with no title bar or frame decoration. Fullscreen modes automatically have this flag set. 
		Note: Whatever flags [set_video_mode] could satisfy are set in the flags member of the returned surface.
		Note: The bpp parameter is the number of bits per pixel, so a bpp of 24 uses the packed representation of 3 bytes/pixel. For the more common 4 bytes/pixel mode, use a bpp of 32. Somewhat oddly, both 15 and 16 will request a 2 bytes/pixel mode, but different pixel formats.
		Note: Use [SWSURFACE] if you plan on doing per-pixel manipulations, or blit surfaces with alpha channels, and require a high framerate. 
		When you use hardware surfaces ([HWSURFACE]), SDL copies the surfaces from video memory to system memory when you lock them, and back when you unlock them. 
		This can cause a major performance hit. (Be aware that you may request a hardware surface, but receive a software surface. 
		Many platforms can only provide a hardware surface when using [FULLSCREEN].) [HWSURFACE] is best used when the surfaces you'll be blitting can also be stored in video memory.
		Note: If you want to control the position on the screen when creating a windowed surface, you may do so by setting the environment variables "SDL_VIDEO_CENTERED=center" or "SDL_VIDEO_WINDOW_POS=x,y". You can set them via [putenv].
		The framebuffer surface; if it fails it raises SDL_failure. The surface returned is freed by [quit]  and should not be freed by the caller. Note: This rule includes consecutive calls to [set_video_mode] (i.e. resize or rez change) - the pre-existing surface will be released automatically.  *)
	val set_video_mode : int -> int -> int -> video_flag list -> surface

	(** [create_rgb_surface video_flag_list width height bitsperpixel -> surface]
		Allocate an empty surface (must be called after [set_video_mode])
		If bitsPerPixel is 8 an empty palette is allocated for the surface, otherwise a 'packed-pixel' pixel format is created using internal RGBA masks based on standard 15,16,24 and 32 bitperpixel formats, and taking platform endianness into account. 
		The flags specifies the type of surface that should be created, it is alist containing one or more of the following possible values.
		- [SWSURFACE ]		 SDL will create the surface in system memory. This improves the performance of pixel level access, however you may not be able to take advantage of some types of hardware blitting.
		- [HWSURFACE] 		 SDL will attempt to create the surface in video memory. This will allow SDL to take advantage of Video->Video blits (which are often accelerated).
		- [SRCCOLORKEY] 		 This flag turns on color keying for blits from this surface. If [HWSURFACE] is also specified and color keyed blits are hardware-accelerated, then SDL will attempt to place the surface in video memory. If the screen is a hardware surface and color keyed blits are hardware-accelerated then the [HWSURFACE] flag will be set. Use [set_color_key] to set or clear this flag after surface creation.
		- [SRCALPHA] 		 This flag turns on alpha-blending for blits from this surface. If [HWSURFACE] is also specified and alpha-blending blits are hardware-accelerated, then the surface will be placed in video memory if possible. If the screen is a hardware surface and alpha-blending blits are hardware-accelerated then the [HWSURFACE] flag will be set. Use [set_alpha] to set or clear this flag after surface creation. *)
	val create_rgb_surface : 
		video_flag list -> int -> int -> int -> surface

	(** [load_bmp file -> surface]
		Loads a surface from a named Windows BMP file.
		Note: When loading a 24-bit Windows BMP file, pixel data points are loaded as blue, green, red, and NOT red, green, blue (as one might expect). *)  
	val load_bmp : string -> surface
  
	(** [save_bmp surface file ]
		Saves the SDL_Surface {i surface} as a Windows BMP file named {i file} *) 
  val save_bmp : surface -> string -> unit
 
	(** [set_color_key surf flag key] 
		Sets the color key (transparent pixel) in a blittable surface and enables or disables RLE blit acceleration.
		RLE acceleration can substantially speed up blitting of images with large horizontal runs of transparent pixels 
		(i.e., pixels that match the key value). The key must be of the same pixel format as the surface, [map_rgb] 
		is often useful for obtaining an acceptable value.
		If flag is [SRCCOLORKEY] then key is the transparent pixel value in the source image of a blit.
		If flag contains  [RLEACCEL] then the surface will be draw using RLE acceleration when drawn with blit_surface.
		The surface will actually be encoded for RLE acceleration the first time [blit_surface] or [display_format] 
		is called on the surface. *)
	val set_color_key : surface -> video_flag list -> int32 -> unit

	(** [set_alpha surf flag alpha] 
		Note: This function and the semantics of SDL alpha blending have changed since version 1.1.4. Up until version 1.1.5, 
		an alpha value of 0 was considered opaque and a value of 255 was considered transparent. 
		This has now been inverted: 0 ([ALPHA_TRANSPARENT]) is now considered transparent and 255 (S[ALPHA_OPAQUE]) is now 
		considered opaque.
		
		[set_alpha] is used for setting the per-surface alpha value and/or enabling and disabling alpha blending.
	
		The surface parameter specifies which surface whose alpha attributes you wish to adjust. flags is used to specify 
		whether alpha blending should be used (S[SRCALPHA]) and whether the surface should use RLE acceleration for blitting 
		([RLEACCEL]). flags can contain both of these two options, one of these options or none. 
		If [SRCALPHA] is not passed as a flag then all alpha information is ignored when blitting the surface. 
		The alpha parameter is the per-surface alpha value; a surface need not have an alpha channel to use per-surface 
		alpha and blitting can still be accelerated with [RLEACCEL.]
		
		Note: The per-surface alpha value of 128 is considered a special case and is optimised, so it's much faster than other 
		per-surface values.
		
		Alpha affects surface blitting in the following ways:
		- RGBA->RGB with [SRCALPHA] 		The source is alpha-blended with the destination, using the alpha channel. [SRCCOLORKEY] and the per-surface alpha are ignored.
		- RGBA->RGB without [SRCALPHA] 	 	The RGB data is copied from the source. The source alpha channel and the per-surface alpha value are ignored. If [SRCCOLORKEY] is set, only the pixels not matching the colorkey value are copied.
		- RGB->RGBA with [SRCALPHA] 		The source is alpha-blended with the destination using the per-surface alpha value. If [SRCCOLORKEY] is set, only the pixels not matching the colorkey value are copied. The alpha channel of the copied pixels is set to opaque.
		- RGB->RGBA without [SRCALPHA] 	 	The RGB data is copied from the source and the alpha value of the copied pixels is set to opaque. If [SRCCOLORKEY] is set, only the pixels not matching the colorkey value are copied.
		- RGBA->RGBA with [SRCALPHA] 		The source is alpha-blended with the destination using the source alpha channel. The alpha channel in the destination surface is left untouched. [SRCCOLORKEY] is ignored.
		- RGBA->RGBA without [SRCALPHA] 	The RGBA data is copied to the destination surface. If [SRCCOLORKEY] is set, only the pixels not matching the colorkey value are copied.
		- RGB->RGB with [SRCALPHA] 		 	The source is alpha-blended with the destination using the per-surface alpha value. If [SRCCOLORKEY] is set, only the pixels not matching the colorkey value are copied.
		- RGB->RGB without [SRCALPHA] 		The RGB data is copied from the source. If [SRCCOLORKEY] is set, only the pixels not matching the colorkey value are copied.
		Note: When blitting, the presence or absence of [SRCALPHA] is relevant only on the source surface, not the destination.
		Note: Note that RGBA->RGBA blits (with [SRCALPHA] set) keep the alpha of the destination surface. 
		This means that you cannot compose two arbitrary RGBA surfaces this way and get the result 
		you would expect from "overlaying" them; the destination alpha will work as a mask.
		Note: Also note that per-pixel and per-surface alpha cannot be combined; the per-pixel alpha is always used if available. *)
	val set_alpha : surface -> video_flag list -> int -> unit

	(** [set_clipping surf top left bottom right] 
		Sets the clipping rectangle for a surface. When this surface is the destination of a blit, only the area within the clip rectangle will be drawn into.
		The rectangle pointed to by the coordinates (top left  bottom right) will be clipped to the edges of the surface so that the clip rectangle for a surface can never fall outside the edges of the surface. *)
	val set_clipping : surface -> int -> int -> int -> int -> unit

	(** [disable_clipping surface]
		Disables clipping to the clipping rectangle set for a surface *)
	val disable_clipping : surface -> unit

	(** [display_format src_surface -> dest_surface]
		This function takes a surface and copies it to a new surface of the pixel format and colors of the video framebuffer, suitable for fast blitting onto the display surface. It calls [convert_surface].
		If you want to take advantage of hardware colorkey or alpha blit acceleration, you should set the colorkey and alpha value before calling this function.
		If you want an alpha channel, see [display_format_alpha]. *)
	val display_format : surface -> surface

	(** [get_rgb surface -> pixel -> red * green * blue]
		Get RGB component values from a pixel stored in the specified pixel format. This function uses the entire 8-bit \[0..255\] range when 
		converting color components from pixel formats with less than 8-bits per RGB component (e.g., a completely white pixel in 16-bit RGB565 format would return \[0xff, 0xff, 0xff\] not \[0xf8, 0xfc, 0xf8\]). *)
	val get_rgb : surface -> int32 -> int * int * int 

	(** [get_rgba  surface -> pixel -> red * green * blue * alpha]
		Get RGBA component values from a pixel stored in the specified pixel format.
		This function uses the entire 8-bit \[0..255\] range when converting color components from pixel formats with less than 8-bits per RGB component 
		(e.g., a completely white pixel in 16-bit RGB565 format would return \[0xff, 0xff, 0xff\] not \[0xf8, 0xfc, 0xf8\]).
		If the surface has no alpha component, the alpha will be returned as 0xff (100% opaque). 		 *)
	val get_rgba : surface -> int32 -> int * int * int * int 

	(** [map_rgb surface -> red -> green -> blue -> pixel]
		Maps the RGB color value to the specified pixel format and returns the pixel value as a 32-bit int.
		If the format has a palette (8-bit) the index of the closest matching color in the palette will be returned.
		If the specified pixel format has an alpha component it will be returned as all 1 bits (fully opaque). *)
	val map_rgb : surface -> int -> int -> int -> int32

	(** [map_rgba surface -> red -> green -> blue -> alpha -> pixel]
		Maps the RGBA color value to the specified pixel format and returns the pixel value as a 32-bit int.
		If the format has a palette (8-bit) the index of the closest matching color in the palette will be returned.
		If the specified pixel format has an alpha component it will be returned as all 1 bits (fully opaque). *)
	val map_rgba : surface -> int -> int -> int -> int -> int32

	(** Rectangle type, used for clipping and blitting operations *)
	type rect = {
		mutable rect_x : int; 	(** top left *)
		mutable rect_y : int;  	(** top *)
		mutable rect_w : int; 	(** width *)
		mutable rect_h : int  	(** height *)
	}

	(** [fill_surface surface  pixel]
		Fills the surface with pixels of the given color *)
	val fill_surface : surface -> int32 -> unit
  
	(** [fill_rect surface  dstrect pixel]
		This function performs a fast fill of the given rectangle with color. 
		The color should be a pixel of the format used by the surface, and can be generated by the [map_rgb] or [map_rgba] functions. 
		If the color value contains an alpha value then the destination is simply "filled" with that alpha information, no blending takes place.
		If there is a clip rectangle set on the destination (set via [set_clip_rect]), then this function will clip based on the intersection of the clip rectangle 
		and the dstrect rectangle, and the dstrect rectangle will be modified to represent the area actually filled.
		If you call this on the video surface (ie: the value of [get_video_surface ()]) you may have to update the video surface to see the result. 
		This can happen if you are using a shadowed surface that is not double buffered in Windows XP using build 1.2.9. *)  
	val fill_rect : surface -> rect -> int32 -> unit

	(** [update_surface surface]
		Makes sure the screen is updated *)
	val update_surface : surface -> unit
  
	(** [update_rect surface left top width height]
		Makes sure the given area is updated on the given screen. The rectangle must be confined within the screen boundaries 
		(no clipping is done).
		This function should not be called while 'screen' is locked (lock_surface). *)
	val update_rect : surface -> int -> int -> int -> int -> unit
  
	(** [update_rects surface  rect_array]
		Makes sure the given list of rectangles is updated on the given screen. The rectangles must all be confined within 
		the screen boundaries (no clipping is done). 
		WARNING : passing rectangles not confined within the screen boundaries to this function can cause very nasty 
		crashes, at least with SDL 1.2.8, at least in Windows and Linux.
		This function should not be called while screen is locked.
		Note: It is advised to call this function only once per frame, since each call has some processing overhead. 
		This is no restriction since you can pass any number of rectangles each time.
		The rectangles are not automatically merged or checked for overlap. In general, the programmer can use his or her 
		knowledge about his or her particular rectangles to merge them in an efficient way, to avoid overdraw. *)
	val update_rects : surface ->  rect array -> unit

	(** [flip surface]
		On hardware that supports double-buffering, this function sets up a flip and returns. The hardware will wait for vertical retrace, 
		and then swap video buffers before the next video surface blit or lock will return. On hardware that doesn't support double-buffering, 
		this is equivalent to calling [(update_surface screen)]
		The [DOUBLEBUF] flag must have been passed to [set_video_mode], when setting the video mode for this function to perform hardware flipping. *)
	val flip : surface -> unit

	(** [blit_surface source_surface srcrect dest_surface dstrect]
		This performs a fast blit from the source surface to the destination surface.
		The width and height in srcrect determine the size of the copied rectangle. Only the position is used in the dstrect (the width and height are ignored).
		If srcrect is [None], the entire surface is copied. If dstrect is [None], then the destination position (upper left corner) is (0, 0).
		The final blit rectangle is saved in dstrect after all clipping is performed (srcrect is not modified).
		The blit function should not be called on a locked surface. I.e. when you use your own drawing functions you may need to lock a surface, 
		but this is not the case with blit_surface. Like most surface manipulation functions in SDL, it should not be used together with OpenGL.
		The results of blitting operations vary greatly depending on whether [SRCAPLHA] is set or not. See [set_alpha] for an explanation of how this affects your results. 
		Colorkeying and alpha attributes also interact with surface blitting.. *)
	val blit_surface : surface -> rect option -> surface -> rect option -> unit

	(** Color type *)
	type color = { 
		red : int;     (** 0..255 *)
		green : int;   (** 0..255 *)
		blue : int     (** 0..255 *)
	}

	(**	[set_colors surf colors firstcolor ncolors] 
		Sets a portion of the colormap for the given 8-bit surface.
		
		When surface is the surface associated with the current display, the display colormap will be updated with the requested colors. 
		If [HWPALETTE] was set in set_video_mode flags, set_colors will always return true, and the palette is guaranteed to be set the way you desire, 
		even if the window colormap has to be warped or run under emulation.
		
		The color components of a [color] structure are 8-bits in size, giving you a total of 2563 = 16777216 colors.
		
		Palettized (8-bit) screen surfaces with the [HWPALETTE] flag have two palettes, a logical palette that is used for mapping blits to/from the surface and a 
		physical palette (that determines how the hardware will map the colors to the display). 
		[set_colors] modifies both palettes (if present), and is equivalent to calling [set_palette] with the flags set to [\[LOGPAL ; PHYSPAL\]]. *)
	val set_colors : surface -> color array -> int -> int -> bool
 
	(** [show_cursor true\false]
		Toggle whether or not the cursor is shown on the screen. *)
	val show_cursor : bool -> unit

	(**	[warp_mouse x y]
		Set the position of the mouse cursor (generates a mouse motion event). *)
	val warp_mouse : int -> int -> unit
  
	(**	[string_of_pixels surface -> string]
		Returns a copy of the raw pixel data in a surface as a string. *)
  val string_of_pixels : surface -> string

end


(*----------------------------- Window management --------------------------------- *)
(** Windowing-related functions
	SDL provides a small set of window management functions which allow applications to change 
	their title and toggle from windowed mode to fullscreen (if available) *)
module Window : sig

	(** [set_caption window_caption taskbar_caption]
		Sets the title-bar and icon name of the display window. *)
	 val set_caption : string -> string -> unit 

	(** [get_caption -> window_caption * taskbar_caption]
		Gets the title-bar and icon name of the display window. *)
	 val get_caption : unit -> string * string 

	(**	[set_icon surface]
	 	Sets the window icon to the surface. In Windows, icons must be 32x32 *)
	 val set_icon : Video.surface -> unit
	 
	(**	[iconify_window]
		If the application is running in a window managed environment SDL attempts to iconify/minimise it. 
		If [iconify_window] is successful, the application will receive an [APPACTIVE] loss event. *)
	 val iconify_window : unit -> unit
	 
	(**	[toggle_fullscreen surface]
		Toggles the application between windowed and fullscreen mode, if supported. (X11 is the only target currently supported, BeOS support is experimental). *)
	 val toggle_fullscreen : Video.surface -> unit
	 
	(**	[set_grab_input true/false]
		Grabbing means that the mouse is confined to the application window, and nearly all keyboard input is passed 
		directly to the application, and not interpreted by a window manager, if any. [True] toggles grabbing on, [false] toggles it off *)
	 val set_grab_input : bool -> unit
	 
	(**	[get_grab_input]
		Returns [true] if the input has been grabbed by the application, else [false] *)
	val get_grab_input : unit -> bool
end


(*----------------------------- Open GL support ------------------------------------ *)
(** SDL OpenGL support *)
module SDLGL : sig

	(** While you can set most OpenGL attributes normally, the attributes listed above must be known before SDL sets the video mode. 
		These attributes a set and read with [set_attribute] and [get_attribute]. *)
	type gl_attr = 
		RED_SIZE 		| (** Size of the framebuffer red component, in bits *)
		GREEN_SIZE 		| (** Size of the framebuffer green component, in bits *)
		BLUE_SIZE  		| (** Size of the framebuffer blue component, in bits *)
		ALPHA_SIZE  	| (** Size of the framebuffer alpha component, in bits *)
		DOUBLEBUFFER  	| (** 0 or 1, enable or disable double buffering *)
		BUFFER_SIZE 	| (** Size of the framebuffer, in bits *)
		DEPTH_SIZE 		| (** Size of the depth buffer, in bits *)
		STENCIL_SIZE  	| (** Size of the stencil buffer, in bits *)
		ACCUM_RED_SIZE 	| (** Size of the accumulation buffer red component, in bits *)
		ACCUM_GREEN_SIZE| (** Size of the accumulation buffer green component, in bits *)
		ACCUM_BLUE_SIZE | (** Size of the accumulation buffer blue component, in bits *)
		ACCUM_ALPHA_SIZE  (** Size of the accumulation buffer alpha component, in bits *)

	(**	[swap_buffers]
		Swap OpenGL framebuffers/Update Display *)
	val swap_buffers : unit -> unit

	(**	[load_bmp file -> surface]
		Loads a Windows Bitmap file and loads it into a surface suitable for use as an OpenGL texture *)
	val load_bmp : string -> Video.surface 

	(**	[set_attribute attr value]
		Sets the OpenGL attribute attr to value. The attributes you set don't take effect until after a call to [set_video_mode]. 
		You should use [get_attribute] to check the values after a [set_video_mode] call. *)
	val set_attribute : gl_attr -> int -> unit 
  
	(** [get_attribute attr -> value]	 
		Returns the value of the SDL/OpenGL attribute attr in value. 
		This is useful after a call to [set_video_mode] to check whether your attributes have been set as you expected. *)
	val get_attribute : gl_attr -> int 
 
end


(*---------------------------------------------------- Events ---------------------------------------------- *)

(** Event handling allows the application to receive input from the user. 
	Event handling is initalised (along with video) with a call to [init \[VIDEO\]]
	Internally, SDL stores all the events waiting to be handled in an event queue. Using functions like [poll_event], 
	[peep_events] and [wait_event] you can observe and handle waiting input events.
	The key to event handling in SDL is the [event] type. The event queue itself is composed of a series of [events], 
	one for each waiting event. [events] are read from the queue with the [poll_event] function and it is then up to 
	the application to process the information stored with them. 
*)
module Event : sig
	
	(** Query, Enable or Disable flags *)
	type que_dis_ena = QUERY | DISABLE | ENABLE
	
	(** On\Off flags *)
	type off_on = OFF | ON
	
	(** Pointer for user-defined event data*)
	type pointer

	(** Application state: application has mouse focus, input focus, active *)
	type app_state = APPMOUSEFOCUS | APPINPUTFOCUS | APPACTIVE 
	
	(** [get_app_state -> app_state list]
		This function returns the current state of the application. The value returned is list containing one or more of:
		[APPMOUSEFOCUS] 	The application has mouse focus.
		[APPINPUTFOCUS] 	The application has keyboard focus
		[APPACTIVE] 		The application is visible *)
	val get_app_state : unit -> (app_state list) 	    

	(**	SDLKey enum 
		An enumeration of keysym definitions.
		Note : A lot of the keysyms are unavailable on most keyboards. For example, the [K_1] keysym can't be accessed on a french keyboard. 
		You get the [K_AMPERSAND] instead. So, you should not hardcode any keysym unless it's one of the universal keys that are available on all keyboards. 
		Also, remember that the position of the letters can vary and so, although all of them are available on most keyboards, their position might not be practical for your application.
		And at last, never ever ever write your own custom ASCII conversion table. If you do that, you'll get angry non US users that will pester you to fix the keyboard handling for them, 
		one for each keyboard layout existing in the world. If you want to know the symbol entered by the user, the [keyboard_event] event is the good place to do it. *)
	type key = K_UNKNOWN | K_FIRST | K_BACKSPACE | K_TAB | K_CLEAR | K_RETURN | K_PAUSE | K_ESCAPE | K_SPACE | K_EXCLAIM | K_QUOTEDBL | K_HASH | K_DOLLAR | K_AMPERSAND | K_QUOTE | K_LEFTPAREN | K_RIGHTPAREN | K_ASTERISK | K_PLUS | K_COMMA | K_MINUS | K_PERIOD | K_SLASH
	| K_0 | K_1 | K_2 | K_3 | K_4 | K_5 | K_6 | K_7 | K_8 | K_9 | K_COLON | K_SEMICOLON | K_LESS | K_EQUALS | K_GREATER | K_QUESTION | K_AT
	| K_LEFTBRACKET | K_BACKSLASH | K_RIGHTBRACKET | K_CARET | K_UNDERSCORE | K_BACKQUOTE
	| K_A | K_B | K_C | K_D | K_E | K_F | K_G | K_H | K_I | K_J | K_K | K_L | K_M | K_N | K_O | K_P | K_Q | K_R | K_S | K_T | K_U | K_V | K_W | K_X | K_Y | K_Z | K_DELETE
	| K_WORLD_0 | K_WORLD_1 | K_WORLD_2 | K_WORLD_3 | K_WORLD_4 | K_WORLD_5 | K_WORLD_6 | K_WORLD_7 | K_WORLD_8 | K_WORLD_9 | K_WORLD_10 | K_WORLD_11 | K_WORLD_12 | K_WORLD_13 | K_WORLD_14 | K_WORLD_15 | K_WORLD_16 | K_WORLD_17 | K_WORLD_18 | K_WORLD_19 | K_WORLD_20 | K_WORLD_21 | K_WORLD_22 | K_WORLD_23 | K_WORLD_24 | K_WORLD_25 | K_WORLD_26 | K_WORLD_27 | K_WORLD_28 | K_WORLD_29 | K_WORLD_30 | K_WORLD_31 | K_WORLD_32 | K_WORLD_33 | K_WORLD_34 | K_WORLD_35 | K_WORLD_36 | K_WORLD_37 | K_WORLD_38 | K_WORLD_39 | K_WORLD_40 | K_WORLD_41 | K_WORLD_42 | K_WORLD_43 | K_WORLD_44 | K_WORLD_45 | K_WORLD_46 | K_WORLD_47 | K_WORLD_48 | K_WORLD_49 | K_WORLD_50 | K_WORLD_51 | K_WORLD_52 | K_WORLD_53 | K_WORLD_54 | K_WORLD_55 | K_WORLD_56 | K_WORLD_57 | K_WORLD_58 | K_WORLD_59 | K_WORLD_60 | K_WORLD_61 | K_WORLD_62 | K_WORLD_63 | K_WORLD_64 | K_WORLD_65 | K_WORLD_66 | K_WORLD_67 | K_WORLD_68 | K_WORLD_69 | K_WORLD_70 | K_WORLD_71 | K_WORLD_72 | K_WORLD_73 | K_WORLD_74 | K_WORLD_75 | K_WORLD_76 | K_WORLD_77 | K_WORLD_78 | K_WORLD_79 | K_WORLD_80 | K_WORLD_81 | K_WORLD_82 | K_WORLD_83 | K_WORLD_84 | K_WORLD_85 | K_WORLD_86 | K_WORLD_87 | K_WORLD_88 | K_WORLD_89 | K_WORLD_90 | K_WORLD_91 | K_WORLD_92 | K_WORLD_93 | K_WORLD_94 | K_WORLD_95
	| K_KP0 | K_KP1 | K_KP2 | K_KP3 | K_KP4 | K_KP5 | K_KP6 | K_KP7 | K_KP8 | K_KP9 | K_KP_PERIOD | K_KP_DIVIDE | K_KP_MULTIPLY | K_KP_MINUS | K_KP_PLUS | K_KP_ENTER | K_KP_EQUALS
	| K_UP | K_DOWN | K_RIGHT | K_LEFT | K_INSERT | K_HOME | K_END | K_PAGEUP | K_PAGEDOWN
	| K_F1 | K_F2 | K_F3 | K_F4 | K_F5 | K_F6 | K_F7 | K_F8 | K_F9 | K_F10 | K_F11 | K_F12 | K_F13 | K_F14 | K_F15
	| K_NUMLOCK | K_CAPSLOCK | K_SCROLLLOCK | K_RSHIFT | K_LSHIFT | K_RCTRL | K_LCTRL | K_RALT | K_LALT | K_RMETA | K_LMETA | K_LSUPER | K_RSUPER | K_MODE | K_COMPOSE
	| K_HELP | K_PRINT | K_SYSREQ | K_BREAK | K_MENU | K_POWER | K_EURO
	
	
	(**	SDLMod enum 
		An enumeration of key modifier definitions.*)
	type key_mod = KMOD_NONE | KMOD_LSHIFT | KMOD_RSHIFT | KMOD_LCTRL | KMOD_RCTRL 
	| KMOD_LALT | KMOD_RALT | KMOD_LMETA | KMOD_RMETA
	| KMOD_NUM | KMOD_CAPS | KMOD_MODE | KMOD_RESERVED
	
	(** [enable_unicode query/disable/enable -> on/off]
		Enables/Disables Unicode keyboard translation.
		To obtain the character codes corresponding to received keyboard events, Unicode translation must first be turned on using this function. 
		The translation incurs a slight overhead for each keyboard event and is therefore disabled by default. For each subsequently received key down event, 
		the unicode member of the [keyboard_event] structure will then contain the corresponding character code, or zero for key syms that do not correspond to any character code.
		[ENABLE] enables Unicode translation; [DISABLE] disables it, and [QUERY] leaves it unchanged (useful for querying the current translation mode).
		Note that only key press events will be translated, not release events. *)
	val enable_unicode : que_dis_ena -> off_on 
	
	(**	Default keyboard repeat delay *)
	val default_repeat_delay : int
	
	(**	Default keyboard repeat interval *)
	val default_repeat_interval : int
	
	(** [enable_key_repeat repeat_delay repeat_interval]
		Enables or disables the keyboard repeat rate. delay specifies how long the key must be pressed before it begins repeating, it then repeats at the speed
		specified by interval. Both delay and interval are expressed in milliseconds.
		Setting delay to 0 disables key repeating completely. Good default values are [default_repeat_delay] and [default_repeat_interval] *)
	val enable_key_repeat : int -> int -> unit 
	
	(** [get_mod_state -> key_mod list]
		Returns a list of the current state of the modifier keys (CTRL, ALT, etc.). *)
	val get_mod_state : unit -> (key_mod list) 
	
	(** [set_mod_state key_mod list]
		Sets the current state of the modifier keys (CTRL, ALT, etc.) in the input list. *)
	val set_mod_state : key_mod list -> unit 
	
	(** [get_key_name key keyname]
		Returns the SDL-defined name of the key in [key] *)
	val get_key_name : key -> string 
	
	(** Released/Pressed *)
	type press_release = RELEASED | PRESSED
	
	(** Focus lost/gained *)
	type lost_gained = LOST | GAINED

	(** Active event type, containing the application state and focus *)
	type active_event = {
		focus: lost_gained;
		state: app_state
	}

	(** Keyboard event type *)
	type keyboard_event =  {
		keystate: press_release;  	(** The key state ([PRESSED] or [RELEASED]) *)
		scancode: int;  			(** The key scan code *)
		sym: key;					(** The key sym *)
		modifiers: key_mod list;  	(** Key modifiers (CTRL, ALT etc)*)
		unicode : int				(** Unicode respresentation of key *)
	}
	
	(** Mouse button types: left, right, middle, and the scroll wheel (up or down) *)
	type mouse_button =  LEFT | MIDDLE | RIGHT | WHEELUP | WHEELDOWN
	
	(** Mouse motion event *)
	type mouse_motion_event = {
		mousestate : press_release; (** The mouse button state ([PRESSED] or [RELEASED]) *)
		mx : int;					(** x coordinate of cursor *)
		my : int;					(** y coordinate of cursor *)
		mxrel : int;				(** Amount in x coordinate moved since last mouse motion event *)
		myrel : int					(** Amount in y coordinate moved since last mouse motion event *)
	}
	
	
	(** Mouse button event *)
	type mouse_button_event = {
		mousebutton: mouse_button; 	(** left, right, middle, and the scroll wheel (up or down) *)
		buttonstate: press_release; (** Pressed\Released*)
		bx : int;					(** x coordinate of cursor *)	
		by : int					(** y coordinate of cursor *)
	}
	
	(** Joystick axis event *)
	type joy_axis_event = {
		which_axis : int;	(** Which joystick generated the event *)
		axis : int;			(** Which joystick axis, X (0) or Y (1) *)
		jvalue : int		(** The current position along that axis *)
	}
	
	(** Joystick ball event *)	
	type joy_ball_event = {
		which_ball : int;	(** Which joystick generated the event *)
		ball : int;			(** Which joystick ball *)
		jxrel : int;		(** Amount in x coordinate moved since last joystick ball event *)
		jyrel : int			(** Amount in y coordinate moved since last joystick ball event *)
	}
	
	
	(** Joystick hat event *)
	type joy_hat_event = {
		which_hat : int;		(** Which joystick generated the event *)
		hat : int;				(** Which joystick hat *)
		hvalue : int			(** The current hat position *)
	}
	
	(** Joystick button event *)
	type joy_button_event = {
		which_button : int;		(** Which joystick generated the event *)
		joybutton : int;		(** Which joystick button *)
		jstate : press_release	(** Pressed\Released *)
	}
	
	(** Window resize event *)
	type resize_event = {
		w : int;		(** New width *)
		h : int			(** New height *)
	}
	
	(** User defined SDL event type *)
	type user_event = {code : int; data1 : pointer; data2 : pointer}
	
	(** tsyswmevent not implemented in trial version *)
	type sys_wm_event
	
	(** event type *)
	type event = 
	    | NoEvent	(**   *)		
	    | Active of active_event 		(** Activation event *)
	    | Key of keyboard_event			(** Keyboard event *)
	    | Motion of mouse_motion_event 	(** Mouse motion event *)
	    | Button of mouse_button_event 	(** Mouse button event  *)
	    | Jaxis of joy_axis_event		(** Joystick axis motion event *)
	    | Jball of joy_ball_event		(** Joystick trackball motion event *)
	    | Jhat of joy_hat_event			(** Joystick hat motion event  *)
	    | Jbutton of joy_button_event	(** Joystick button event  *)
	    | Resize of resize_event		(** Application window resize event *)
	    | Expose 						(** Application window expose event *)
	    | Quit 							(** Application quit request event *)	
	    | User of user_event 			(** User defined event  *)		
	    | Syswm of sys_wm_event 		(** Undefined window manager event *)
	;;
	
	(**	[pump_events]
		Pumps the event loop, gathering events from the input devices.
		[pump_events] gathers all the pending input information from devices and places it on the event queue. 
		Without calls to [pump_events] no events would ever be placed on the queue. Often the need for calls to [pump_events] 
		is hidden from the user since [poll_event] and [wait_event] implicitly call [pump_events]. 
		However, if you are not polling or waiting for events (e.g. you are filtering them), then you must call [pump_events] to force an event queue update.
		Note: You can only call this function in the thread that set the video mode. *)
	val pump_events : unit -> unit
	
	(** [poll_event -> event]
		Polls for currently pending events.
		If there are any events, the next event is removed from the queue and stored in the [event] structure pointed to by event. *)
	val poll_event : unit -> event 
	
	(**	[wait_event -> event]
		Waits indefinitely for the next available event. If there are any events, the next event is 
		removed from the queue and stored in that area. *)
	val wait_event : unit -> event 
	
end


(* ------------------------------------------ Timer. -------------------------------------------------------- *)
(** Timer module *)
module Timer : sig

	(** [get_ticks -> milliseconds]
		Returns the number of milliseconds since SDL library initialization. Note that this value wraps around 
		if the program runs for more than ~49.7 days. *)
	val get_ticks : unit -> int
	
	(** [delay milliseconds]
		Wait a specified number of milliseconds before returning. 
		[delay] will wait at least the specified time, but possible longer due to OS scheduling.
		Note: Count on a delay granularity of at least 10 ms. Some platforms have shorter clock ticks but this is the most common. *)
	val delay : int -> unit

end



(* ------------------------------------------- Audio.------------------------------------------------- *)
(** Low-level audio *)
module Audio : sig
  
	(** Type of sample *)
	type sample_type =
		| U8 		(** 8 bits unsigned *)
		| S8		(** 8 bits signed *)
		| U16		(** 16 bits unsigned *)
		| S16		(** 16 bits signed *)
		| U16LSB	(** 16 bits unsigned least-significant-bit first*)
		| S16LSB	(** 16 bits signed least-significant-bit first*)
		| U16MSB	(** 16 bits unsigned most-significant-bit first *)
		| S16MSB	(** 16 bits signed most-significant-bit first *)
	
	(** Status of the audio device *)     
	type audio_status =
		| STOPPED	(** Device has been stopped *)
		| PAUSED	(** Device has been paused *)
		| PLAYING 	(** Device is currently playing *)
		| UNKNOWN	(** Device state is unknown *)
	   
	type channel_type =
		| MONO      (** Mono channel *)
		| STEREO 	(** Stereo channel *)
	    
	(**	The [audio_spec] structure is used to describe the format of some audio data. 
		This structure is used by [open_audio] and [load-wav]. 
		While all fields are used by [open_audio] only freq, format, samples and channels are used by [load_wav]. *)     
	type audio_spec = {
		frequency: int; 		(** The number of samples sent to the sound device every second. Common values are 11025, 22050 and 44100. The higher the better. *)
		format: sample_type; 	(** Specifies the size and type of each sample element *)
		channels: channel_type; (** The number of seperate sound channels *)
		silence: int;	
		samples: int; 			(** When used with [open_audio] this refers to the size of the audio buffer in samples. A sample a chunk of audio data of the size specified in format mulitplied by the number of channels. When the [audio_spec] is used with [load-wav] samples is set to 4096.  *)
		size: int;
	}

	(** The maximum sample mixer volume. Volume ranges from 0 (silence) to mix_maxvolume *)     
	val mix_maxvolume   : int

	(** [open_audio desired_audio_spec mixer_callback -> obtained audio_spec ] 
		This function opens the audio device with the [desired] parameters, and returns the [obtained] parameters, 
		placing the actual hardware parameters in the structure pointed to by [obtained]. *)
	val open_audio : audio_spec -> (byte_array -> unit) -> audio_spec 

	(** [close_audio] closes the audio device *)
	val close_audio : unit -> unit
  
	(** [load_wav filename -> obtained audio_spec * wav_buffer] 
		This function loads a WAVE file into memory.
		If this function succeeds, it returns the given [audio-spec], filled with the audio data format of 
		the wave data, and sets wav_buffer to a C-malloc'd buffer containing the audio data, 
		You need to free the audio buffer with [free-wav] when you are done with it.
		This function sets the SDL error message if the wave file cannot be opened, 
		uses an unknown data format, or is corrupt. Currently raw, MS-ADPCM and IMA-ADPCM WAVE files are supported. *)
	val load_wav : string -> audio_spec * byte_array
	
	(** [free_wav wav_buffer] 
		Frees a WAV buffer allocated by load-wav *)
	val free_wav : byte_array -> unit
  
	(** [pause_audio on\off] 
		Toggle audio playback on and off *)  
	val pause_audio : bool -> unit

	(**	The lock manipulated by these functions protects the callback function. 
		During a [lock_audio] period, you can be guaranteed that the callback function is not running. 
		Do not call these from the callback function or you will cause deadlock. *)
	val lock_audio : unit -> unit
	
	(**	Unlocks a previous [lock_audio] call.*)
	val unlock_audio : unit -> unit
  
	(**	[mix_audio buffer1 buffer2  volume] 
		This function takes two audio buffers of len bytes each of the playing audio format and mixes them, 
		performing addition, volume adjustment, and overflow clipping. 
		The volume ranges from 0 to [mix_maxvolume] and should be set to the maximum value for full audio volume. 
		Note this does not change hardware volume. This is provided for convenience -- you can mix your own audio data.
		Note: Do not use this function for mixing together more than two streams of sample data. 
		The output from repeated application of this function may be distorted by clipping, because there is no 
		accumulator with greater range than the input (not to mention this being an inefficient way of doing it). 
		Use mixing functions from SDL_mixer, OpenAL, or write your own mixer instead. *)
	val mix_audio :  byte_array -> byte_array  -> int -> unit
	
	(**	[get_audio_status -> audio_status]
		Returns either [STOPPED], [PAUSED] or [PLAYING] depending on the current audio status *)
	val get_audio_status : unit -> audio_status
  
	(**	[convert_audio from_format from_channels from_frequency to_format to_channels to_frequency input_buffer -> output_buffer] 
		Converts an audio sample in [input_buffer] of sample type [from_format], number of channels [from_channels], and sample frequency [from_frequency]
		to sample type [to_format], number of channels [to_channels], and sample frequency [to_frequency]
		The converted samples are returned in [output_buffer] *)  
	val convert_audio : sample_type -> channel_type -> int -> sample_type -> channel_type -> int -> byte_array -> byte_array
  
	(**	[fx_pan  pan volume input_buffer  -> output_buffer] 
		This is an auxiliary, non core SDL mixing function.  It takes an input sample in [input_buffer]
		and pans it (or more accurately, adjusts the balance) according to the value of [pan] which lies in the range \[-1.0 - 1.0 \].
		A value of -1.0 means that the sound will be coming exclusively from the left speaker, a value of 0.0 
		means that the sound will come equally from both speakers, and 1.0 means that the sound will come exclusively from
		the right speaker. The panned sample will be placed in the [output_buffer].
		[volume] sets the volume for the output buffer *)
	val fx_pan : float -> float -> byte_array -> byte_array 
	
	(**	[fx_shift : frequency_shift input_buffer -> output_buffer]
		This is an auxiliary, non core SDL mixing function.  It takes an input sample in [input_buffer] and shifts its frequency.
		[frequency_shift] determines the frequency shift. A value of 1.0 leaves the frequency unchanged, a value between 0.1 and 1.0
		lowers the frequency and a value between 1.0 and 10.0 raises the frequency. Shifts are capped in the range \[0.1 - 10.0\].
		The frequency shifted sound is placed in [output_buffer] *)
	val fx_shift : float -> byte_array -> byte_array
  
end


(* ---------------------------------------------------- Drawing.-------------------------------------------------- *)
(** 	Extra functions: font, bitmap, scaling and pixel operations *)
module Draw : sig

	(** failure loading TGA file *)	
	exception TGA_failure of string
	
	(** Failure using SFont functions *)
	exception Sfont_failure of string
	
	(** SFont texturemapped fonts based on the specifications at http://www.linux-games.com/sfont/
		A font consists of a 32bpp RGBA surface with ASCII characters from 33 to 127. The first line in
		the texturemap serves as a character delineator using the colour pink (255 0 255 255) to indicate
		the space between each character rectangle. *)
	type sfont = {
		font_list: (int * Video.rect) list; (** associative list of ASCII char values and corresponding SDL rects*)
		font_surf: Video.surface;		 	(** Texture map containing font characters *)
		font_space: int;		 		 	(** Size of the space character ' ' in pixels. Default is the same size as 'L' *)
		font_letters: int;		 		 	(** Space between letters in pixels. Default is the same size as '!' *)
		font_line: int		 		 		(** Space between lines in pixels. Default is zero i.e. font design handles it *)
	}
	
	(** Filters to be used in scaling bitmaps. Currently only box, triangle and lanczos3 filters have been implemented*)	     
	type filter = BOX of int | TRIANGLE of int | BELL of int | BSPLINE of int | HERMITE of int | MITCHELL of int | LANCZOS3 of int 
	val box : filter
	val triangle : filter
	val bell : filter
	val bspline : filter
	val hermite : filter
	val mitchell : filter
	val lanczos3 : filter

	(** [put_pixel surface x y pixel]
		puts an int32 rgb(a) pixel, such as output of [map_rgb(a)], on surface [surface] at location [(x,y)] *)
	val put_pixel : Video.surface -> int -> int -> int32 -> unit
      
	(**	[get_pixel surface x y -> pixel]
		gets an int32 rgb(a) pixel, from surface [surface] at location [(x,y)] *)
	val get_pixel : Video.surface -> int -> int -> int32
	
	(**	[scale surface factor filter -> surface]
		Scales a surface by the given scale [factor], using the given [filter], and returning a new scaled surface *)
	val scale : Video.surface -> float -> filter -> Video.surface
	
	(**	[scale_to surface new_width new_height filter -> surface]
		Scales a surface to the new width and height given, using the given [filter], and returning a new scaled surface *)
	val scale_to : Video.surface -> int -> int -> filter -> Video.surface
  
	(**	[read_tga file -> width * height * bitsperpixel * pixel-data]
		Targa TGA image file reader, based on the specs at http://astronomy.swin.edu.au/~pbourke/dataformats/tga/
		Takes as parameter the file name and returns a tuple containing the image width, height, bytes-per-pixel
		a string containing the image data in BGR(A) format, and the image orientation.
		Reads 15, 16, 24 and 32 bit-per-pixel raw and RLE-compressed images.
		Throws TGA_exception when anything goes wrong. *)
	type tga_orientation = From_upper_left | From_lower_left
	val read_tga : string -> int * int * int * string * tga_orientation 

	(**	[load_tga file -> surface]
		Loads a TGA file and returns a surface with the image data *)  
	val load_tga : string -> Video.surface
  
	(**	[make_sfont Surface_containing_loaded_RGBA_texture_map_with_font_characters ->  sfont]
		Takes a surface containing a texture-mapped font (see http://www.linux-games.com/sfont/)
		and returns an sfont structure *)
	val make_sfont : Video.surface -> sfont

	(** [sfont_print  string_to_print  x_position  y_position  sfont  surface_to_draw_text_on] *)
	val sfont_print : string -> int -> int -> sfont -> Video.surface -> unit
	
	(** [make_mipmaps surface_bitmap scale_filter_type  ->  array of mipmaps down to 1x1]
		Makes mipmaps suitable for use in OpenGL, by generating an array of mipmaps down to 1x1.
		The side of each mipmap is a power of two; if the sides of the original surface are powers of two then that
		surface will be used as the first mipmap in the array, otherwise it will be scaled to the nearest power of two
		and the result will be used as the first mipmap. *)
	val make_mipmaps : Video.surface ->  filter -> Video.surface array
  
end
  
(**
	{b Acknowledgements, license and copyright}
	
	SDLCaml
	
	Source code, additions and modifications 2006 - 2008  Elliott OTI 
	
	Copyright (C) 2006 - 2008 Elliott OTI
	
	This library is free software; you can redistribute it and/or
	modify it under the terms of the GNU Library General Public
	License version 2, as published by the Free Software Foundation.
	This library is distributed in the hope that it will be useful,
	but WITHOUT ANY WARRANTY; without even the implied warranty of
	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
	See the GNU Library General Public License version 2 for more details
	(enclosed in the file LGPL). 
	
	{b Credits}
	
	Parts of the documentation reproduced verbatim or in altered form 
	from the libsdl documentation (http://www.libsdl.org)
	
	Portions of modules Sdl, Video, SDLGL, Timer and Draw are based on code by Jean-Christophe Filliatre.
	
	Copyright (C) 1999 Jean-Christophe FILLIATRE:
	
	This library is free software; you can redistribute it and/or
	modify it under the terms of the GNU Library General Public
	License version 2, as published by the Free Software Foundation.
	This library is distributed in the hope that it will be useful,
	but WITHOUT ANY WARRANTY; without even the implied warranty of
	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
	See the GNU Library General Public License version 2 for more details
	(enclosed in the file LGPL). 
	
	The Event module contains code from the camlgl distribution (http://camlgl.sourceforge.net):
	
	(C) 2001-2002 Nickolay Kolchin-Semyonov
	
	This software is provided 'as-is', without any express or implied
	warranty.  In no event will the authors be held liable for any damages
	arising from the use of this software.
	Permission is granted to anyone to use this software for any purpose,
	including commercial applications, and to alter it and redistribute it
	freely, subject to the following restrictions:
	
	1. The origin of this software must not be misrepresented; you must not
	 claim that you wrote the original software. If you use this software
	 in a product, an acknowledgment in the product documentation would be
	 appreciated but is not required.
	
	2. Altered source versions must be plainly marked as such, and must not be
	 misrepresented as being the original software.
	
	3. This notice may not be removed or altered from any source distribution.
	
	Nickolay Kolchin-Semyonov
	
	snob\@snob.spb.ru 
*)
