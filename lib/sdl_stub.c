/*
 * sdlcaml - Objective Caml interface for the SDL library
 * Copyright (C) 1999, Jean-Christophe FILLIATRE, (C) 2006, 2007, 2008 Elliott Oti
 *
 * This library is free software; you can redistribute it and/or
 * modify it under the terms of the GNU Library General Public
 * License version 2, as published by the Free Software Foundation.
 *
 * This library is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
 *
 * See the GNU Library General Public License version 2 for more details
 * (enclosed in the file LGPL).
 */

/*
 * Modifications by Elliott Oti (2006, 2007, 2008)
 * Module Audio added
 * Module Window added	
 * Functions added to Module Video and Event
 * Non-SDL functions added to Module Draw: scale, scale_to, read_tga, load_tga, make_mipmaps,make_sfont and sfont_print
 */

#include <stdio.h>
#include <string.h>
#include <math.h>
#include <SDL/SDL.h>

/* Ugly: SDL_AudioSpec has a field called "callback" which caml/callback.h redefines to caml_callback.
So this function has to come before the caml #includes*/
void set_audiospec(SDL_AudioSpec *in, int freq, int format, int channels, int samples, void (*callback)(void *userdata, Uint8 *stream, int len))
{
	in->freq = freq;
	in->format = format;
	in->channels = channels;
	in->samples = samples;
	in->callback = callback;
	in->userdata = NULL;
}


/*  CAML - C interface */
#include <caml/mlvalues.h>
#include <caml/memory.h>
#include <caml/alloc.h>
#include <caml/fail.h>
#include <caml/callback.h>
#include <caml/bigarray.h>


/*  Caml list manipulations */
#define NIL_tag 0
#define CONS_tag 1

value nil(void)
{
	CAMLparam0();
	CAMLreturn (Val_int(0));
}

value cons(value x,value l)
{
	CAMLparam2(x,l);
	CAMLlocal1(m);
	m=alloc(2,CONS_tag);
	Store_field(m,0,x);
	Store_field(m,1,l);
	CAMLreturn (m);
}

int is_nil(value l)
{
	CAMLparam1(l);
	CAMLreturn (Is_long(l));
}

int is_not_nil(value l)
{
	CAMLparam1(l);
	CAMLreturn (Is_block(l));
}

value hd(value l)
{
	CAMLparam1(l);
	CAMLreturn (Field(l,0));
}

value tl(value l)
{
	CAMLparam1(l);
	CAMLreturn (Field(l,1));
}

/*  conversion between OCAMLSDL flags and C SDL flags */
#define TIMER_tag 0
#define AUDIO_tag 1
#define VIDEO_tag 2
#define CDROM_tag 3
#define JOYSTICK_tag 4
#define NOPARACHUTE_tag 5       
#define EVENTTHREAD_tag 6
#define EVERYTHING_tag 7

int init_flag_val(value flag_list)
{
	CAMLparam1(flag_list);
	int flag = 0;
	value l = flag_list;
	while (is_not_nil(l))
	{
		switch (Int_val(hd(l)))
		{
		case TIMER_tag       : flag |= SDL_INIT_TIMER       ; break;
		case AUDIO_tag       : flag |= SDL_INIT_AUDIO       ; break;
		case VIDEO_tag       : flag |= SDL_INIT_VIDEO       ; break;
		case CDROM_tag       : flag |= SDL_INIT_CDROM       ; break;
		case JOYSTICK_tag    : flag |= SDL_INIT_JOYSTICK    ; break;
		case NOPARACHUTE_tag : flag |= SDL_INIT_NOPARACHUTE ; break;
		case EVENTTHREAD_tag : flag |= SDL_INIT_EVENTTHREAD ; break;
		case EVERYTHING_tag  : flag |= SDL_INIT_EVERYTHING  ; break;
		}
		l = tl(l);
	}
	CAMLreturn (flag);
}

#define SWSURFACE_tag 0 
#define HWSURFACE_tag 1   
#define ANYFORMAT_tag 2  
#define HWPALETTE_tag 3   
#define DOUBLEBUF_tag 4   
#define FULLSCREEN_tag 5  
#define HWACCEL_tag 6     
#define SRCCOLORKEY_tag 7  
#define RLEACCEL_tag 8    
#define SRCALPHA_tag 9    
#define SRCCLIPPING_tag 10  
#define OPENGL_tag 11
#define RESIZABLE_tag 12
#define NOFRAME_tag 13

int video_flag_val(value flag_list)
{
	CAMLparam1(flag_list);
	int flag = 0;
	value l = flag_list;
	while (is_not_nil(l))
	{
		switch (Int_val(hd(l)))
		{
		case SWSURFACE_tag   : flag |= SDL_SWSURFACE   ; break;
		case HWSURFACE_tag   : flag |= SDL_HWSURFACE   ; break;
		case ANYFORMAT_tag   : flag |= SDL_ANYFORMAT   ; break;
		case HWPALETTE_tag   : flag |= SDL_HWPALETTE   ; break;
		case DOUBLEBUF_tag   : flag |= SDL_DOUBLEBUF   ; break;
		case FULLSCREEN_tag  : flag |= SDL_FULLSCREEN  ; break;
		case HWACCEL_tag     : flag |= SDL_HWACCEL     ; break;
		case SRCCOLORKEY_tag : flag |= SDL_SRCCOLORKEY ; break;
		case RLEACCEL_tag    : flag |= SDL_RLEACCEL    ; break;
		case SRCALPHA_tag    : flag |= SDL_SRCALPHA    ; break;
		case OPENGL_tag      : flag |= SDL_OPENGL      ; break; 
		case RESIZABLE_tag   : flag |= SDL_RESIZABLE   ; break; 
		case NOFRAME_tag     : flag |= SDL_NOFRAME   ; break; 
		}
		l = tl(l);
	}
	CAMLreturn (flag);
}

value val_video_flag(int flags)
{
	CAMLparam0();
	value l = nil();
	if (flags & SDL_SWSURFACE)   l = cons(Val_int(SWSURFACE_tag),l);
	if (flags & SDL_HWSURFACE)   l = cons(Val_int(HWSURFACE_tag),l);
	if (flags & SDL_ANYFORMAT)   l = cons(Val_int(ANYFORMAT_tag),l);
	if (flags & SDL_HWPALETTE)   l = cons(Val_int(HWPALETTE_tag),l);
	if (flags & SDL_DOUBLEBUF)   l = cons(Val_int(DOUBLEBUF_tag),l);
	if (flags & SDL_FULLSCREEN)  l = cons(Val_int(FULLSCREEN_tag),l);
	if (flags & SDL_HWACCEL)     l = cons(Val_int(HWACCEL_tag),l);
	if (flags & SDL_SRCCOLORKEY) l = cons(Val_int(SRCCOLORKEY_tag),l);
	if (flags & SDL_RLEACCEL)    l = cons(Val_int(RLEACCEL_tag),l);
	if (flags & SDL_SRCALPHA)    l = cons(Val_int(SRCALPHA_tag),l);
	if (flags & SDL_OPENGL)      l = cons(Val_int(OPENGL_tag),l);
	CAMLreturn (l);
}

/* raising SDL_failure exception */

void raise_failure() {
	raise_with_string(*caml_named_value("SDL_failure"), SDL_GetError());
}

value sdlstub_init(value vf) {
	CAMLparam1(vf);
	int flags = init_flag_val(vf);
	
	if (SDL_Init(flags) < 0) raise_failure();
	CAMLreturn (Val_unit);
}

value sdlstub_quit(value u) {
	CAMLparam1(u);
	SDL_Quit();
	CAMLreturn (Val_unit);
}

value sdlstub_get_error(value u){
	CAMLparam1(u);
	CAMLlocal1(result);
	char *s = SDL_GetError();
	Store_field (result, 0, copy_string(s));
	CAMLreturn (result);
}

value sdlstub_must_lock(value s) {
	CAMLparam1(s);
	int b = SDL_MUSTLOCK(((SDL_Surface*) s));
	CAMLreturn (Val_bool(b));
}

value sdlstub_video_mode_ok(value vw, value vh, value vbpp, value vf) {
	CAMLparam4(vw,vh,vbpp,vf);
	int w = Int_val(vw);
	int h = Int_val(vh);
	int bpp = Int_val(vbpp);
	int flags = video_flag_val(vf);
	
	CAMLreturn (Val_bool(SDL_VideoModeOK(w,h,bpp,flags)));
}

value sdlstub_set_video_mode(value vw, value vh, value vbpp, value vf) {
	CAMLparam4(vw, vh, vbpp, vf);
	CAMLlocal1(r);		 
	int w = Int_val(vw);
	int h = Int_val(vh);
	int bpp = Int_val(vbpp);
	int flags = video_flag_val(vf);
	SDL_Surface* s;
	
	if ((s = SDL_SetVideoMode(w,h,bpp,flags)) == NULL) raise_failure();
	r = (value)s;
	CAMLreturn (r);
}

value sdlstub_load_bmp(value vfile) {
	CAMLparam1(vfile);
	char * file = String_val(vfile);
	SDL_Surface* s;
	
	if ((s = SDL_LoadBMP(file)) == NULL) raise_failure();
	CAMLreturn ((value) s);
}

value sdlstub_save_bmp(value s, value vfile) {
	CAMLparam2(s, vfile);
	char * file = String_val(vfile);
	
	if (SDL_SaveBMP((SDL_Surface*) s, file) < 0) raise_failure();
	CAMLreturn (Val_unit);
}

/* Code by Jeff Molofee's openGL tutorial */
SDL_Surface * GLLoadBMP(char *filename)
{
	Uint8 *rowhi, *rowlo;
	Uint8 *tmpbuf, tmpch;
	SDL_Surface *image;
	int i, j;

	image = SDL_LoadBMP(filename);
	if (image == NULL) {
		fprintf(stderr, "Unable to load %s: %s\n", filename, SDL_GetError());
		raise_failure();
	}

    /* GL surfaces are upsidedown and RGB, not BGR :-) */
	tmpbuf = (Uint8 *)malloc(image->pitch);
	if (tmpbuf == NULL) {
		fprintf(stderr, "Out of memory\n");
		raise_failure();
	}
	rowhi = (Uint8 *)image->pixels;
	rowlo = rowhi + (image->h * image->pitch) - image->pitch;
	for ( i=0; i<image->h/2; ++i ) {
		for ( j=0; j<image->w; ++j ) {
			tmpch = rowhi[j*3];
			rowhi[j*3] = rowhi[j*3+2];
			rowhi[j*3+2] = tmpch;
			tmpch = rowlo[j*3];
			rowlo[j*3] = rowlo[j*3+2];
			rowlo[j*3+2] = tmpch;
		}
		memcpy(tmpbuf, rowhi, image->pitch);
		memcpy(rowhi, rowlo, image->pitch);
		memcpy(rowlo, tmpbuf, image->pitch);
		rowhi += image->pitch;
		rowlo -= image->pitch;
	}
	free(tmpbuf);
	return(image);
}

value sdlstub_GL_load_bmp(value f) {
	CAMLparam1(f);
	CAMLreturn ((value)GLLoadBMP(String_val(f)));
}

value sdlstub_string_of_pixels(value s) {
	CAMLparam1(s);
	CAMLlocal1(v);
	SDL_Surface * surf = (SDL_Surface *) s;
	int n = surf->w * surf->h * surf->format->BytesPerPixel;
	v = alloc_string(n);
	memcpy(String_val(v), surf->pixels, n);
	CAMLreturn(v);
}

value sdlstub_set_color_key(value s, value vf, value vk) {
	CAMLparam3(s,vf,vk);
	int flag = video_flag_val(vf);
	unsigned int key = Int32_val(vk);
	
	if (SDL_SetColorKey((SDL_Surface*) s, flag, key) < 0) raise_failure();
	CAMLreturn( Val_unit);
}

value sdlstub_set_alpha(value s, value vf, value va) {
	CAMLparam3(s,vf,va);
	int flags = video_flag_val(vf);
	int alpha = Int_val(va);
	
	if (SDL_SetAlpha((SDL_Surface*) s, flags, alpha) < 0) raise_failure();
	CAMLreturn( Val_unit);
}


value sdlstub_set_clipping(value s, value vtop, value vleft, 
		 		 		    value vbottom, value vright) {
	CAMLparam5(s,vtop,vleft, vbottom, vright);
	SDL_Rect r;
	r.x = Int_val(vleft);
	r.y = Int_val(vtop);
	r.w = Int_val(abs(vright - vleft));
	r.h = Int_val(abs(vbottom - vtop));
	SDL_SetClipRect((SDL_Surface*) s, &r);
	CAMLreturn (Val_unit);
}

value sdlstub_display_format(value s) {
	CAMLparam1(s);
	SDL_Surface* n;
	if ((n = SDL_DisplayFormat((SDL_Surface*) s)) == NULL)raise_failure();
	CAMLreturn ((value) n);
}

value sdlstub_create_rgb_surface(value vflags, value vw, value vh, value vdepth) {
	CAMLparam4(vflags, vw, vh, vdepth);
	CAMLlocal1(r);
	SDL_Surface* s;
	Uint32 flags = Int_val(vflags);
	int width = Int_val(vw);
	int height = Int_val(vh);
	int depth = Int_val(vdepth);
	Uint32 rmask=0, gmask=0, bmask=0, amask=0;
	if(depth == 32){
#if SDL_BYTEORDER == SDL_BIG_ENDIAN
	rmask = 0xff000000;
	gmask = 0x00ff0000;
	bmask = 0x0000ff00;
	amask = 0x000000ff;
#else
	rmask = 0x000000ff;
	gmask = 0x0000ff00;
	bmask = 0x00ff0000;
	amask = 0xff000000;
#endif
  }
	if(depth == 24){
#if SDL_BYTEORDER == SDL_BIG_ENDIAN
	rmask = 0xff0000;
	gmask = 0x00ff00;
	bmask = 0x0000ff;
	amask = 0;
#else
	rmask = 0x0000ff;
	gmask = 0x00ff00;
	bmask = 0xff0000;
	amask = 0;
#endif
  }
	if(depth == 16){
#if SDL_BYTEORDER == SDL_BIG_ENDIAN
	rmask = 0xF800;
	gmask = 0x7E0;
	bmask = 0x1F;
	amask = 1;
#else
	rmask = 0x1F;
	gmask = 0x7E0;
	bmask = 0xF800;
	amask = 0;
#endif
	}
	if(depth == 15){
#if SDL_BYTEORDER == SDL_BIG_ENDIAN
	rmask = 0xFC00;
	gmask = 0x3E0;
	bmask = 0x1F;
	amask = 1;
#else
	rmask = 0x1F;
	gmask = 0x3E0;
	bmask = 0xFC00;
	amask = 0x8000;
#endif
	}
	 
	s = SDL_CreateRGBSurface(flags, width, height, depth, 
		 		        rmask, gmask, bmask, amask); 
	if (s == NULL) raise_failure(); 
	r = (value)s;
	CAMLreturn(r);
}


value sdlstub_free_surface(value s) {
	CAMLparam1(s);		 
	SDL_FreeSurface((SDL_Surface*) s);
	CAMLreturn (Val_unit);
}

value sdlstub_lock_surface(value s) {
	CAMLparam1(s);		 
	if (SDL_LockSurface((SDL_Surface*) s) < 0) raise_failure();
	CAMLreturn (Val_unit);
}

value sdlstub_unlock_surface(value s) {
	CAMLparam1(s);		 
	SDL_UnlockSurface((SDL_Surface*) s);
	CAMLreturn (Val_unit);
}

value sdlstub_surface_pixels(value ps) {
	CAMLparam1(ps);
	SDL_Surface *s = ((SDL_Surface*) ps);
	CAMLreturn (alloc_bigarray_dims(BIGARRAY_UINT8 | BIGARRAY_C_LAYOUT, 1, s->pixels, s->w * s->h * (s->format->BitsPerPixel/8)));
}

value sdlstub_surface_width(value s) {
	CAMLparam1(s);		   
	CAMLreturn (Val_int(((SDL_Surface*) s)->w));
}

value sdlstub_surface_height(value s) {
	CAMLparam1(s);		 
	CAMLreturn (Val_int(((SDL_Surface*) s)->h));
}

value sdlstub_surface_flags(value s) {
	CAMLparam1(s);		 
	CAMLreturn (val_video_flag(((SDL_Surface*) s)->flags));
}

value sdlstub_surface_bpp(value s) {
	CAMLparam1(s);		 
	CAMLreturn (Val_int(((SDL_Surface*) s)->format->BitsPerPixel));
}

value sdlstub_surface_rmask(value s) {
	CAMLparam1(s);		 
	CAMLreturn (Val_int(((SDL_Surface*) s)->format->Rmask));
}

value sdlstub_surface_gmask(value s) {
	CAMLparam1(s);		 
	CAMLreturn (Val_int(((SDL_Surface*) s)->format->Gmask));
}

value sdlstub_surface_bmask(value s) {
	CAMLparam1(s);		 
	CAMLreturn (Val_int(((SDL_Surface*) s)->format->Bmask));
}

value sdlstub_surface_amask(value s) {
	CAMLparam1(s);		 
	CAMLreturn (Val_int(((SDL_Surface*) s)->format->Amask));
}

value sdlstub_map_rgb(value s, value vr, value vg, value vb) {
	CAMLparam4(s, vr, vg, vb);
	CAMLlocal1(rs);
	int r = Int_val(vr);
	int g = Int_val(vg);
	int b = Int_val(vb);
	int pixel = SDL_MapRGB(((SDL_Surface*) s)->format, r, g, b);
	rs = caml_copy_int32(pixel);
	CAMLreturn(rs);
}

value sdlstub_map_rgba(value s, value vr, value vg, value vb, value va) {
	CAMLparam5(s, vr, vg, vb, va);
	CAMLlocal1(rs);
	int r = Int_val(vr);
	int g = Int_val(vg);
	int b = Int_val(vb);
	int a = Int_val(va);
	int pixel = 0;
	pixel = SDL_MapRGBA(((SDL_Surface*) s)->format, r, g, b, a);
	rs = caml_copy_int32(pixel);
	CAMLreturn(rs);
}

value sdlstub_get_rgb(value s, value pixel){
	CAMLparam2(s,pixel);
	CAMLlocal1(result);
	Uint8 r =0, g=0, b=0;
	SDL_GetRGB(Int32_val(pixel), ((SDL_Surface *)s)->format, &r, &g, &b);
	result = caml_alloc(3,0);
	Store_field(result, 0, Val_int(r));
	Store_field(result, 1, Val_int(g));
	Store_field(result, 2, Val_int(b));
	CAMLreturn(result);
}

value sdlstub_get_rgba(value s, value pixel){
	CAMLparam2(s,pixel);
	CAMLlocal1(result);
	Uint8 r =0, g=0, b=0, a=0;
	SDL_GetRGBA(Int32_val(pixel), ((SDL_Surface *)s)->format, &r, &g, &b, &a);
	result = caml_alloc(4,0);
	Store_field(result, 0, Val_int(r));
	Store_field(result, 1, Val_int(g));
	Store_field(result, 2, Val_int(b));
	Store_field(result, 3, Val_int(a));
	CAMLreturn(result);
}

value sdlstub_get_ticks(value u) {
	CAMLparam1(u);
	CAMLreturn (Val_int(SDL_GetTicks()));
}

value sdlstub_delay(value vms) {
	CAMLparam1(vms);		 
	int ms = Int_val(vms);
	SDL_Delay(ms);
	CAMLreturn (Val_unit);
}

value sdlstub_fill_surface(value s, value vc) {
	CAMLparam2(s,vc);
	int c = Int32_val(vc);
	if (SDL_FillRect((SDL_Surface*) s, NULL, c) < 0) raise_failure();
	CAMLreturn(Val_unit);
}

value sdlstub_fill_rect(value s, value vr, value vc) {
		 CAMLparam3(s, vr, vc);
	int c = Int32_val(vc);
	SDL_Rect r;
	r.x = Int_val(Field(vr,0));
	r.y = Int_val(Field(vr,1));
	r.w = Int_val(Field(vr,2));
	r.h = Int_val(Field(vr,3));
	if (SDL_FillRect((SDL_Surface*) s, &r, c) < 0) raise_failure();
	CAMLreturn(Val_unit);
}

value sdlstub_update_surface(value s) {
	CAMLparam1(s);
	SDL_UpdateRect((SDL_Surface*) s, 0, 0, 0, 0);
	CAMLreturn (Val_unit);
}

value sdlstub_update_rect(value s, value vx, value vy, value vw, value vh) {
	CAMLparam5(s,vx,vy,vw,vh);
	int x = Int_val(vx);
	int y = Int_val(vy);
	int w = Int_val(vw);
	int h = Int_val(vh);
	
	SDL_UpdateRect((SDL_Surface*) s, x, y, w, h);
	CAMLreturn (Val_unit);
}

value sdlstub_update_rects(value s, value vn, value arr){
	CAMLparam3(s, vn, arr);
	int n = Int_val(vn);
	value v;
	int i;
	SDL_Rect* rects;
	
	if (Wosize_val(arr) < n) invalid_argument("update_rects");
	rects = (SDL_Rect*) malloc(n * sizeof(SDL_Rect));
	for (i = 0; i < n; i++) {
		v = Field(arr,i);
		rects[i].x = Int_val(Field(v,0));
		rects[i].y = Int_val(Field(v,1));
		rects[i].w = Int_val(Field(v,2));
		rects[i].h = Int_val(Field(v,3));
	};
	SDL_UpdateRects((SDL_Surface*) s, n, rects);
	free(rects);
	CAMLreturn (Val_unit);
}

value sdlstub_flip(value s) {
	CAMLparam1(s);
	if (SDL_Flip((SDL_Surface*) s) < 0) raise_failure();
	CAMLreturn(Val_unit);
}

SDL_Rect* rect_from_option(value v,SDL_Rect* r) {
	CAMLparam1(v);
	value vr;
	if (v == Val_int(0)) { 
	/* None */
		return (NULL);
	} else {
	/* Some */
		vr = Field(v,0);
		r->x = Int_val(Field(vr,0));
		r->y = Int_val(Field(vr,1));
		r->w = Int_val(Field(vr,2));
		r->h = Int_val(Field(vr,3));
		return (r);
	}
}

/* assumption: v = Some rect  and  r is not NULL */
void update_rect_option(value v, SDL_Rect* r) {
	CAMLparam1(v);
	value vr = Field(v,0);
	modify(&Field(vr,0), Val_int(r->x));
	modify(&Field(vr,1), Val_int(r->y));
	modify(&Field(vr,2), Val_int(r->w));
	modify(&Field(vr,3), Val_int(r->h));
}

value sdlstub_blit_surface(value src, value srcr, value dst, value dstr) {
	CAMLparam4(src, srcr, dst, dstr);
	SDL_Rect sr,dr;
	SDL_Rect *srp, *drp;
	
	srp = rect_from_option(srcr,&sr);
	drp = rect_from_option(dstr,&dr);
	
	if (SDL_BlitSurface((SDL_Surface*) src, srp, (SDL_Surface*) dst, drp) < 0)
		raise_failure();
	if (! (srp == NULL)) update_rect_option(srcr,srp);
	if (! (drp == NULL)) update_rect_option(dstr,drp);
	CAMLreturn(Val_unit);
}


value sdlstub_set_colors(value s, value arr, value vfirst, value vn) {
	CAMLparam4(s, arr, vfirst, vn);
	int ncolors = Int_val(vn);
	int firstcolor = Int_val(vfirst);
	int result, i;
	value v;
	SDL_Color* colors;
	
	if (ncolors < 0 || ncolors > Wosize_val(arr)) invalid_argument("set_colors");
	colors = (SDL_Color*) malloc(ncolors * sizeof(SDL_Color));
	if (colors == NULL) raise_out_of_memory();
	for (i=0; i<ncolors; i++) {
		v = Field(arr,i);
		colors[i].r = Int_val(Field(v,0));
		colors[i].g = Int_val(Field(v,1));
		colors[i].b = Int_val(Field(v,2));
	};
	result = SDL_SetColors((SDL_Surface*) s, colors, firstcolor, ncolors);
	free(colors);
	CAMLreturn (Val_bool(result));
}

value sdlstub_show_cursor(value vtoggle) {
	CAMLparam1(vtoggle);
	int toggle = Bool_val(vtoggle);
	
	SDL_ShowCursor(toggle);
	CAMLreturn(Val_unit);
}

value sdlstub_warp_mouse(value x, value y)
{
	CAMLparam2(x,y);
	int lx = Int_val(x);
	int ly = Int_val(y);
	SDL_WarpMouse(x,y);
	CAMLreturn(Val_unit);	
}

/* --------------------- events -------------------------------- */
#define FLAG_TO_MOD_SIZE 12

int ML_flags_to_mask(value flags, int flag_to_cvalue[])
{
	int i,n;
	int mask=0;
	CAMLparam0();
	while(Is_block(flags))
	{
		mask |= flag_to_cvalue[Int_val(Field(flags, 0))];
		flags=Field(flags, 1);
	}
	CAMLreturn(mask);
}

value carray_to_ML_list(int carray[], int arr_size)
{
	int i;
	CAMLparam0();
	CAMLlocal2(toreturn, tail);
	
	if(arr_size==0)
	CAMLreturn(Val_int(0));
	toreturn=alloc(2,0);
	Store_field(toreturn, 0, Val_int(carray[0]));
	tail=toreturn;
	for(i=1;i<arr_size;i++)
	{
		Field(tail,1) = alloc(2,0);
		tail=Field(tail,1);
		Store_field(tail, 0, Val_int(carray[i]));
	}
	Store_field(tail, 1, Val_int(0));
	CAMLreturn(toreturn);
}    

value mask_to_ML_flags(int mask, int flag_to_cvalue[], int arr_size)
{
#ifdef _WIN32
	int flagar[1024];
#else
	int flagar[arr_size];
#endif
	int n=0,i;
	CAMLparam0 ();
	
	for(i=0; i<arr_size; i++)
		if(mask&flag_to_cvalue[i])
			flagar[n++]=i;
	
	CAMLreturn(carray_to_ML_list(flagar, n));    
}	    


int key_to_flag[] =
{  
	0, 0,0,0,0,0,0,0,
	2, 3, 0,0,
	4, 5, 0,0,0,0,0,
	6, 0,0,0,0,0,0,0,
	7, 0,0,0,0,
	8, 9, 10, 11, 12, 0,
	13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39,
	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
	40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, 62, 63, 64, 65, 66, 67, 68, 69, 70, 71,
	0,0,0,0,
	72,
	0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,
	73, 74, 75, 76, 77, 78, 79, 80, 81, 82, 83, 84, 85, 86, 87, 88, 89, 90, 91, 92, 93, 94, 95, 96, 97, 98, 99, 100, 101, 102, 103, 104, 105, 106, 107, 108, 109, 110, 111, 112, 113, 114, 115, 116, 117, 118, 119, 120, 121, 122, 123, 124, 125, 126, 127, 128, 129, 130, 131, 132, 133, 134, 135, 136, 137, 138, 139, 140, 141, 142, 143, 144, 145, 146, 147, 148, 149, 150, 151, 152, 153, 154, 155, 156, 157, 158, 159, 160, 161, 162, 163, 164, 165, 166, 167, 168,
	169, 170, 171, 172, 173, 174, 175, 176, 177, 178, 179, 180, 181, 182, 183, 184, 185, 186, 187, 188, 189, 190, 191, 192, 193, 194, 195, 196, 197, 198, 199, 200, 201, 202, 203, 204, 205, 206,207, 208, 209,
	0,0,0,
	210, 211, 212, 213, 214, 215, 216, 217, 218, 219, 220, 221, 222, 223, 224, 225, 226, 227, 228, 229, 230, 231,
	232
};

int flag_to_key[] =
{
	0,0,8,9,12,13,19,27,32,33,34,35,36,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60,61,62,63,64,
	91,92,93,94,95,96,97,98,99,100,101,102,103,104,105,106,107,108,109,110,111,112,113,114,115,116,117,118,119,120,121,122,127,
	160,161,162,163,164,165,166,167,168,169,170,171,172,173,174,175,176,177,178,179,180,181,182,183,184,185,186,187,188,189,190,191,192,193,194,195,196,197,198,199,200,201,202,203,204,205,206,207,208,209,210,211,212,213,214,215,216,217,218,219,220,221,222,223,224,225,226,227,228,229,230,231,232,233,234,235,236,237,238,239,240,241,242,243,244,245,246,247,248,249,250,251,252,253,254,255,
	256,257,258,259,260,261,262,263,264,265,266,267,268,269,270,271,272,273,274,275,276,277,278,279,280,281,282,283,284,285,286,287,288,289,290,291,292,293,294,295,296,
	300,301,302,303,304,305,306,307,308,309,310,311,312,313,314,315,316,317,318,319,320,321,322
};

int flag_to_mod[] = {
	0x0000,0x0001,0x0002,0x0040,0x0080,0x0100,0x0200,0x0400,0x0800,0x1000,0x2000,0x4000,0x8000
};

int flag_to_appstate[] = {
	0x01, 0x02, 0x04
};

#define FLAG_TO_APPSTATE_SIZE 	3

value sdlstub_get_app_state(value u)
{
	CAMLparam1(u);
	CAMLreturn(mask_to_ML_flags(SDL_GetAppState(), 
	flag_to_appstate, FLAG_TO_APPSTATE_SIZE));
}

value SDL_event_to_ML_tevent(SDL_Event event)
{
    CAMLparam0 ();
    CAMLlocal2(ML_event, to_return);
    int i;

    switch (event.type) 
    {
	case SDL_ACTIVEEVENT: 
	{
    	    ML_event=alloc(2, 0);
	    Store_field(ML_event, 0, Val_int(event.active.gain));
	    if (event.active.state & SDL_APPACTIVE) 
		Store_field(ML_event, 1, Val_int(2));
	    else if (event.active.state & SDL_APPINPUTFOCUS)
		Store_field(ML_event, 1, Val_int(1));
	    else
		Store_field(ML_event, 1, Val_int(0));
	
	    to_return=alloc(1,0);
	    Store_field(to_return, 0, ML_event);
	    CAMLreturn(to_return);
	}
	case SDL_KEYDOWN:
	case SDL_KEYUP:
	{
	    ML_event=alloc(5,0);
	    Store_field(ML_event, 0, Val_int(event.key.state));
	    Store_field(ML_event, 1, Val_int(event.key.keysym.scancode));
	    Store_field(ML_event, 2, Val_int(key_to_flag[event.key.keysym.sym]));
	    Store_field(ML_event, 3, 
		mask_to_ML_flags(event.key.keysym.mod, flag_to_mod, 12));
	    Store_field(ML_event, 4, Val_int(event.key.keysym.unicode));
	    to_return=alloc(1, 1);
	    Store_field(to_return, 0, ML_event);
	    CAMLreturn(to_return);
	}
	case SDL_MOUSEMOTION:
	{
	    ML_event=alloc(5,0);
	    switch(event.motion.state)
	    {
		case 0: Store_field(ML_event, 0, Val_int(0));break;
		case 1: Store_field(ML_event, 0, Val_int(1));break;
		default: Store_field(ML_event, 0, Val_int(2));break;
	    }
	    Store_field(ML_event, 1, Val_int(event.motion.x));
	    Store_field(ML_event, 2, Val_int(event.motion.y));
	    Store_field(ML_event, 3, Val_int(event.motion.xrel));
	    Store_field(ML_event, 4, Val_int(event.motion.yrel));
	    
	    to_return=alloc(1,2);
	    Store_field(to_return, 0, ML_event);
	    CAMLreturn(to_return);
	}
	case SDL_MOUSEBUTTONDOWN:
	case SDL_MOUSEBUTTONUP:
	{
	    ML_event=alloc(4,0);

	    Store_field(ML_event, 0, Val_int(event.button.button - 1));
	    Store_field(ML_event, 1, Val_int(event.button.state));
	    Store_field(ML_event, 2, Val_int(event.button.x));
	    Store_field(ML_event, 3, Val_int(event.button.y));
	    
	    to_return=alloc(1,3);
	    Store_field(to_return, 0, ML_event);
	    CAMLreturn(to_return);
	}
	case SDL_JOYAXISMOTION:
	{
	    ML_event=alloc(3,0);
	    Store_field(ML_event, 0, Val_int(event.jaxis.which));
	    Store_field(ML_event, 1, Val_int(event.jaxis.axis));
	    Store_field(ML_event, 2, Val_int(event.jaxis.value));
	    to_return=alloc(1,4);
	    Store_field(to_return, 0, ML_event);
	    CAMLreturn(to_return);
	}
	case SDL_JOYBALLMOTION:
	{
	    ML_event=alloc(4,0);
	    Store_field(ML_event, 0, Val_int(event.jball.which));
	    Store_field(ML_event, 1, Val_int(event.jball.ball));
	    Store_field(ML_event, 2, Val_int(event.jball.xrel));
	    Store_field(ML_event, 3, Val_int(event.jball.yrel));
	    to_return=alloc(1,5);
	    Store_field(to_return, 0, ML_event);
	    CAMLreturn(to_return);
	}
	case SDL_JOYHATMOTION:
	{
	    ML_event=alloc(3,0);
	    Store_field(ML_event, 0, Val_int(event.jhat.which));
	    Store_field(ML_event, 1, Val_int(event.jhat.hat));
	    Store_field(ML_event, 2, Val_int(event.jhat.value));
	    to_return=alloc(1,6);
	    Store_field(to_return, 0, ML_event);
	    CAMLreturn(to_return);
	}
	case SDL_JOYBUTTONUP:
	case SDL_JOYBUTTONDOWN:
	{
	    ML_event=alloc(3,0);
	    Store_field(ML_event, 0, Val_int(event.jbutton.which));
	    Store_field(ML_event, 1, Val_int(event.jbutton.button));
	    Store_field(ML_event, 2, Val_int(event.jbutton.state));
	    to_return=alloc(1,7);
	    Store_field(to_return, 0, ML_event);
	    CAMLreturn(to_return);
	}
	case SDL_VIDEORESIZE:
	{
	    ML_event=alloc(2,0);
	    Store_field(ML_event, 0, Val_int(event.resize.w));
	    Store_field(ML_event, 1, Val_int(event.resize.h));
	    
	    to_return=alloc(1,8);
	    Store_field(to_return, 0, ML_event);
	    CAMLreturn(to_return);
	}
	case SDL_VIDEOEXPOSE:
	{
	    CAMLreturn(Val_int(1));
	}
	case SDL_QUIT:
	{
	    CAMLreturn(Val_int(2));
	}
	case SDL_USEREVENT:
    /* ... */
	case SDL_NUMEVENTS-1:
	{
	    ML_event=alloc(3,0);
	    Store_field(ML_event, 0, Val_int(event.user.code));
	    Store_field(ML_event, 1, (value)(event.user.data1));
	    Store_field(ML_event, 2, (value)(event.user.data2));
	    
	    to_return=alloc(1,9);
	    Store_field(to_return, 0, ML_event);
	    CAMLreturn(to_return);
	}
	case SDL_SYSWMEVENT:
	{
	    to_return=alloc(1,10);
	    Store_field(to_return, 0, (value)(event.syswm.msg));
	    CAMLreturn(to_return);
	}
	default:
	{
	    fprintf(stderr,"Unknown event.\n");
	    exit(-1);
	}
    }
}

value sdlstub_poll_event(value u)
{
	SDL_Event event;
	CAMLparam1(u);
	int isevent;
	isevent=SDL_PollEvent(&event);
	if (isevent==1) 
	CAMLreturn (SDL_event_to_ML_tevent(event));
	else CAMLreturn (Val_int(0));
}

value sdlstub_wait_event(value u)
{
	CAMLparam1(u);
	SDL_Event event;
	int isevent;
	isevent=SDL_WaitEvent(&event);
	if (isevent==1) 
	CAMLreturn (SDL_event_to_ML_tevent(event));
	else CAMLreturn (Val_int(0));
}

void sdlstub_pump_events(value u)
{
	CAMLparam1(u);
	SDL_PumpEvents();
	CAMLreturn0;
}

value sdlstub_event_state(value type, value state)
{
	CAMLparam2(type, state);
	CAMLreturn(Val_int(1+SDL_EventState(Int_val(type), Int_val(state)-1)));
}

value sdlstub_get_mouse_state(value u)
{
	CAMLparam1(u);
	CAMLlocal1(toreturn);
	int x,y,but;
	toreturn=alloc(3,0);
	but=SDL_GetMouseState(&x,&y);
	switch(but)
	{
		case 0: Store_field(toreturn, 0, Val_int(0));break;
		case 1: Store_field(toreturn, 0, Val_int(1));break;
		default: Store_field(toreturn, 0, Val_int(2));break;
	}
	Store_field(toreturn, 1, Val_int(x));
	Store_field(toreturn, 2, Val_int(y));
	CAMLreturn(toreturn);
}

value sdlstub_enable_unicode(value enable)
{
	CAMLparam1(enable);
	CAMLreturn(Val_int(SDL_EnableUNICODE(Int_val(enable)-1)+1));
}

void sdlstub_enable_key_repeat(value delay, value interval)
{
	CAMLparam2(delay, interval);
	if (SDL_EnableKeyRepeat(Int_val(delay), Int_val(interval)) == -1)
		raise_failure();
	else CAMLreturn0;
}

value sdlstub_get_mod_state(value u)
{
	CAMLparam1(u);
	CAMLreturn(mask_to_ML_flags(SDL_GetModState(), 
	flag_to_mod, FLAG_TO_MOD_SIZE));
}

void sdlstub_set_mod_state(value flags)
{
	CAMLparam1(flags);
	SDL_SetModState(ML_flags_to_mask(flags, flag_to_mod));
	CAMLreturn0;
}    

value sdlstub_get_key_name(value ML_key)
{
	CAMLparam1(ML_key); /* perhaps GC likes CAMLlocal(toreturn); toreturn= */
	CAMLreturn(copy_string(SDL_GetKeyName(flag_to_key[Int_val(ML_key)])));
}




/* Window management */
value sdlstub_set_caption(value title, value icon)
{
	 CAMLparam2(title, icon);
	 SDL_WM_SetCaption( String_val(title), String_val(icon) );
	 CAMLreturn (Val_unit);
}

value sdlstub_get_caption(value u)
{
	 CAMLparam1(u);
	 CAMLlocal1 (result);
	 char *title, *icon;
	 SDL_WM_GetCaption( &title, &icon );
	 Store_field (result, 0, copy_string(title));
	 Store_field (result, 1, copy_string(icon));
	 CAMLreturn (result);  
}

value sdlstub_set_icon(value s)
{
	CAMLparam1(s);
	SDL_WM_SetIcon((SDL_Surface *)s, NULL);
	CAMLreturn(Val_unit);	
}

value sdlstub_iconify_window(value u)
{
	CAMLparam1(u);
	SDL_WM_IconifyWindow();
	CAMLreturn(Val_unit);	
}

value sdlstub_toggle_fullscreen(value s)
{
	CAMLparam1(s);
	SDL_WM_ToggleFullScreen((SDL_Surface *)s);
	CAMLreturn(Val_unit);	
}


value sdlstub_set_grab_input(value b)
{
	CAMLparam1(b);
	int vb = Int_val(b);
	SDL_GrabMode mode = vb? SDL_GRAB_ON : SDL_GRAB_OFF;
	SDL_WM_GrabInput(mode);
	CAMLreturn(Val_unit);	
}

value sdlstub_get_grab_input(value u)
{
	CAMLparam1(u);
	CAMLlocal1(result);
	int r;
	SDL_GrabMode mode = SDL_GRAB_QUERY;
	r = SDL_WM_GrabInput(mode);
	result = Bool_val(0);
	if(r == SDL_GRAB_ON)result = Bool_val(1);
	CAMLreturn(result);	
}


/* open GL */
value sdlstub_GL_swap_buffers(value u) {
	CAMLparam1(u);		 
	SDL_GL_SwapBuffers();
	CAMLreturn(Val_unit);
}

SDL_GLattr  SDL_GLAttrArray[] =
{
	SDL_GL_RED_SIZE ,
	SDL_GL_GREEN_SIZE ,
	SDL_GL_BLUE_SIZE ,
	SDL_GL_ALPHA_SIZE ,
	SDL_GL_DOUBLEBUFFER ,
	SDL_GL_BUFFER_SIZE ,
	SDL_GL_DEPTH_SIZE ,
	SDL_GL_STENCIL_SIZE ,
	SDL_GL_ACCUM_RED_SIZE ,
	SDL_GL_ACCUM_GREEN_SIZE ,
	SDL_GL_ACCUM_BLUE_SIZE ,
	SDL_GL_ACCUM_ALPHA_SIZE 
};

value sdlstub_set_attribute(value a, value v)
{
	CAMLparam2(a,v);
	int attr = Int_val(a);
	int val = Int_val(v);
	if(attr < sizeof(SDL_GLAttrArray)){
		SDL_GLattr  sdlattr = SDL_GLAttrArray[attr];
		SDL_GL_SetAttribute(sdlattr, val);
	}	
	CAMLreturn(Val_unit);
}

value sdlstub_get_attribute(value a)
{
	CAMLparam1(a);
	int attr = Int_val(a);
	int val = 0;
	if(attr < sizeof(SDL_GLAttrArray)){
		SDL_GLattr  sdlattr = SDL_GLAttrArray[attr];
		SDL_GL_GetAttribute(sdlattr, &val);
	}	
	CAMLreturn(Val_int(val));
}

/* audio */
static void __audio_callback(void *userdata, unsigned char *stream, int len)
{
	caml_callback(*caml_named_value("ml_setaudiocallback"), alloc_bigarray_dims(BIGARRAY_UINT8 | BIGARRAY_C_LAYOUT, 1, stream, len));
}



value sdlstub_open_audio(value freq, value format, value channels, value samples) {
	CAMLparam4 (freq, format, channels, samples);  
	CAMLlocal1 (result);
	SDL_AudioSpec input, output;
	result = caml_alloc (6, 0);
	set_audiospec(&input, Int_val(freq),Int_val(format),Int_val(channels),Int_val(samples), __audio_callback);
	set_audiospec(&output, 0,0,0,0, NULL);
	SDL_OpenAudio(&input, &output);
	Store_field (result, 0, Val_int((int)output.freq));
	Store_field (result, 1, Val_int((int)output.format));
	Store_field (result, 2, Val_int((int)output.channels));
	Store_field (result, 3, Val_int((int)output.silence));
	Store_field (result, 4, Val_int((int)output.samples));
	Store_field (result, 5, Val_int((int)output.size));
	CAMLreturn (result);  
}


value sdlstub_close_audio(value u) {
	CAMLparam1(u);
	SDL_CloseAudio();
	CAMLreturn (Val_unit);
}

value sdlstub_load_wav(value file) {
	CAMLparam1(file);
	CAMLlocal1 (result);
	SDL_AudioSpec wav_spec;
	Uint32 wav_length;
	Uint8 *wav_buffer;
	char *filename = String_val(file);
	result = caml_alloc (7, 0);
	if( SDL_LoadWAV(filename, &wav_spec, &wav_buffer, &wav_length) == NULL ){
		caml_failwith(SDL_GetError());
	}
	Store_field (result, 0, Val_int((int)wav_spec.freq));
	Store_field (result, 1, Val_int((int)wav_spec.format));
	Store_field (result, 2, Val_int((int)wav_spec.channels));
	Store_field (result, 3, Val_int((int)wav_spec.silence));
	Store_field (result, 4, Val_int((int)wav_spec.samples));
	Store_field (result, 5, Val_int((int)wav_spec.size));
	Store_field (result, 6, alloc_bigarray_dims(BIGARRAY_UINT8 | BIGARRAY_C_LAYOUT, 1, wav_buffer, wav_length));
	CAMLreturn (result); 
}


value sdlstub_free_wav(value wav) {
	CAMLparam1(wav);
	SDL_FreeWAV(Data_bigarray_val(wav));
	CAMLreturn (Val_unit);
}

value sdlstub_pause_audio(value on) {
	CAMLparam1(on);
	int p =  0;
	if (Bool_val(on)) p = 1;
	SDL_PauseAudio(p);
	CAMLreturn (Val_unit);
}

value sdlstub_lock_audio(value u) {
	CAMLparam1(u);
	SDL_LockAudio();
	CAMLreturn(Val_unit);
}

value sdlstub_unlock_audio(value u) {
	CAMLparam1(u);
	SDL_UnlockAudio();
	CAMLreturn(Val_unit);
}

value sdlstub_get_audio_status(value u) {
	CAMLparam1(u);
	CAMLreturn (Val_int(SDL_GetAudioStatus()));
}

value sdlstub_mix_audio(value b1, value b2, value volume){
	CAMLparam3(b1, b2, volume);
	SDL_MixAudio(Data_bigarray_val(b1), Data_bigarray_val(b2), Bigarray_val(b1)->dim[0], Int_val(volume));
	CAMLreturn (Val_unit);
}

value sdlstub_convert_audio(value from_format, value from_channels, value from_freq, 
                            value to_format, value to_channels, value to_freq, value buffer){
	CAMLparam5(from_format, from_channels, from_freq, to_format, to_channels);
	CAMLxparam2(to_freq, buffer);
	SDL_AudioCVT  wav_cvt;
	int wav_len = Bigarray_val(buffer)->dim[0];
	unsigned char *wav_buf = Data_bigarray_val(buffer); 
	if(!SDL_BuildAudioCVT(&wav_cvt, Int_val(from_format), Int_val(from_channels), Int_val(from_freq),
	                    Int_val(to_format), Int_val(to_channels), Int_val(to_freq)) ){
	    caml_failwith("Unable to carry out conversion");
	}
	wav_cvt.buf = malloc(wav_len * wav_cvt.len_mult);
	wav_cvt.len = wav_len;
	memcpy(wav_cvt.buf, wav_buf, wav_len);
	SDL_ConvertAudio(&wav_cvt);
	CAMLreturn (alloc_bigarray_dims(BIGARRAY_UINT8 | BIGARRAY_C_LAYOUT, 1, wav_cvt.buf, wav_len * wav_cvt.len_mult));
}

value sdlstub_convert_audio_byte(value * argv, int n){
	return sdlstub_convert_audio (argv[0], argv[1], argv[2], argv[3], argv[4], argv[5], argv[6]);
}

/* Audio effects */

// Author: A. Umbach sdl@lokigames.com
int fxShift(double pitch, Uint8 *source, Uint8 *target, int len) {
	int i, j, k;
	double l;
	double pa = 0;
	double shift = pitch > 0 ? pitch : 0;
	len /= 4; 
	for(i = 0; i < len; i++) { // LR pairs 
		for(j = 0; j < 2; j++) { // channels
			pa = i * shift;
			k = (int) pa;
			l = pa - k;
			*(Sint16*) (target + 2 * j + 4 * i) +=
			( *(Sint16*) (source + 2 * j + 4 * (k + 0) ) * ( 1 - l ) +
			*(Sint16*) (source + 2 * j + 4 * (k + 2) ) * ( l ) );
		}
	}
	return ( (int)(len * shift + 0.49999) ) * 4;
}

value fxstub_shift(value shift, value source, value target)
{
	CAMLparam3(shift, source, target);
	int consumed = 0;
	consumed = fxShift(Double_val(shift), Data_bigarray_val(source), Data_bigarray_val(target), Bigarray_val(target)->dim[0] );
	CAMLreturn (Val_int(consumed));
}

// Author: A. Umbach sdl@lokigames.com
void fxPan(double pan, double vol, Uint8 *buf, Uint8 *out, int len) {
	int i;
	double left_vol =  - vol * ( -1.0 + pan ) / 2.0;
	double right_vol = vol * ( 1.0 + pan ) / 2.0;
	
	// Guards
	if(left_vol < 0)left_vol = 0;
	if(left_vol > 1)left_vol = 1;
	if(right_vol < 0)right_vol = 0;
	if(right_vol > 1)right_vol = 1;
	
	for(i = 0; i < len; i += 4) {
		*(Sint16*) (out + i) = *(Sint16*) (buf + i) * left_vol;
		*(Sint16*) (out + i + 2) = *(Sint16*) (buf + i + 2) * right_vol;
	}
}

value fxstub_pan(value pan, value vol, value buf, value out)
{
	CAMLparam4(pan, vol, buf, out);
	fxPan(Double_val(pan), Double_val(vol), Data_bigarray_val(buf), Data_bigarray_val(out), Bigarray_val(buf)->dim[0]);
	CAMLreturn (Val_unit);
}


/* the following code is borrowed from stars.c by Nathan Strong */

value sdldraw_put_pixel(value s, value vx, value vy, value vc) {
	CAMLparam4(s,vx,vy,vc);
	Uint16 x = Int_val(vx);
	Uint16 y = Int_val(vy);
	Uint32 pixel = Int32_val(vc);
	SDL_Surface* dst = (SDL_Surface*) s;
	Uint8 *pix;
	int shift;
	
	if (SDL_LockSurface(dst) == 0) {
		switch (dst->format->BytesPerPixel) {
			case 1:
				*((Uint8 *)dst->pixels + y * dst->pitch + x) = pixel;
				break;
			case 2:
				*((Uint16 *)dst->pixels + y * dst->pitch/2 + x) = pixel;
				break;
			case 3:
				/* Slow, but endian correct */
				pix = (Uint8 *)dst->pixels + y * dst->pitch + x*3;
				shift = dst->format->Rshift;
				*(pix+shift/8) = pixel>>shift;
				shift = dst->format->Gshift;
				*(pix+shift/8) = pixel>>shift;
				shift = dst->format->Bshift;
				*(pix+shift/8) = pixel>>shift;
				break;
			case 4:
				*((Uint32 *)dst->pixels + y * dst->pitch/4 + x) = pixel;
				break;
			default:
				break;
		};
		SDL_UnlockSurface(dst);
	};
	CAMLreturn(Val_unit);
}

value sdldraw_get_pixel(value s, value vx, value vy) {
	CAMLparam3(s,vx,vy);
	CAMLlocal1(rs);
	Uint16 x = Int_val(vx);
	Uint16 y = Int_val(vy);
	Uint32 pixel = 0;
	SDL_Surface* dst = (SDL_Surface*) s;
	Uint8 *pix;
	int shift;
	
	if (SDL_LockSurface(dst) == 0) {
		switch (dst->format->BytesPerPixel) {
			case 1:
				pixel = *((Uint8 *)dst->pixels + y * dst->pitch + x);
				break;
			case 2:
				pixel = *((Uint16 *)dst->pixels + y * dst->pitch/2 + x);
				break;
			case 3:
				/* Slow, but endian correct */
				pix = (Uint8 *)dst->pixels + y * dst->pitch + x*3;
				pixel = 0;
				shift = dst->format->Rshift;
				pixel |= (*(pix+shift/8)) << shift;
				shift = dst->format->Gshift;
				pixel |= (*(pix+shift/8)) << shift;
				shift = dst->format->Bshift;
				pixel |= (*(pix+shift/8)) << shift;
				break;
			case 4:
				pixel = *((Uint32 *)dst->pixels + y * dst->pitch/4 + x);
				break;
			default:
				break;
		};
		SDL_UnlockSurface(dst);
	};
	
	rs = caml_copy_int32(pixel);
	CAMLreturn(rs);
}


#ifdef __APPLE__
int main(int argc, char **argv)
{
   caml_main(argv);
   return 0;
}
#endif 
