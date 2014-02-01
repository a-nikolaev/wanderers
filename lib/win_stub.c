#include <string.h>

#ifdef __unix__
#include <X11/X.h>
#include <X11/Xlib.h>
#include <X11/Xutil.h>
#include <X11/Xatom.h>
#include <GL/glx.h>
#endif

#ifdef _WIN32
#include <windows.h>
#include <wingdi.h>
#endif

#include <caml/mlvalues.h>
#include <caml/memory.h>
#include <caml/alloc.h>
#include <caml/fail.h>
#include <caml/callback.h>
#include <caml/bigarray.h>

#ifdef __unix__
Window gwin;
Display *gdisplay = NULL;
#endif

#ifdef _WIN32
HWND ghWnd = NULL;
HDC ghDC = NULL;
HGLRC  ghGlrc = NULL;
#endif

#ifdef __unix__
Window local_find_window (Display *display, Window root, char *name)
{
	Window parent;
	Window *children;
	unsigned int num_children = 0;
	int i, status = 0;
	XTextProperty tex_prop;
	char **list_return = NULL;
	int count_return = 0;
	status = XGetWMName(display, root, &tex_prop);
	if(status && tex_prop.value && tex_prop.nitems)
	{
		status = XmbTextPropertyToTextList (display, &tex_prop, &list_return, &count_return);
		if(status >= Success && count_return > 0 && *list_return)
		{
	        	if( !strcmp(name, (char*) strdup (*list_return)) ){
	        		XFreeStringList(list_return);
	        		return root;
	        	}
		}
	}
	status = XQueryTree (display, root, &root, &parent, &children, &num_children);
	if (status == 0 || num_children == 0)
	{
		XFree ((char*) children);
		return (Window)NULL;
	}
	for (i=0; i < num_children; i++)
	{
		Window result = local_find_window (display, children[i], name);
		if(result){
   			XFree ((char*) children);
		return result;
		}
	}
	XFree ((char*) children);
	return (Window)NULL;
}
#endif

value stub_init_gl(value name)
{
	CAMLparam1(name);
	CAMLlocal1(result);
	char *wname = String_val(name);
#ifdef __unix__
	XVisualInfo *vi = NULL;
	Display *display = XOpenDisplay (NULL);
	int screen = DefaultScreen (display);
	Window win = local_find_window (display, RootWindow(display, screen), wname );
	int attrListSgl[] = {	GLX_RGBA, GLX_RED_SIZE, 4,
				GLX_GREEN_SIZE, 4,
				GLX_BLUE_SIZE, 4,
				GLX_DEPTH_SIZE, 16,
				None};
	int attrListDbl[] = {	GLX_RGBA, GLX_DOUBLEBUFFER,
				GLX_RED_SIZE, 4,
				GLX_GREEN_SIZE, 4,
				GLX_BLUE_SIZE, 4,
				GLX_DEPTH_SIZE, 16,
				None};
	GLXContext ctx;
	vi = glXChooseVisual(display, screen, attrListDbl);
	if(NULL == vi)
	{
		vi = glXChooseVisual(display, screen, attrListSgl);
	}
	ctx = glXCreateContext(display, vi, 0, GL_TRUE);
	glXMakeCurrent(display, win, ctx);
	gwin = win;
	gdisplay = display;
#endif
#ifdef _WIN32
	PIXELFORMATDESCRIPTOR pfd = { 
		sizeof(PIXELFORMATDESCRIPTOR),   // size of this pfd 
		1,                     // version number 
		PFD_DRAW_TO_WINDOW |   // support window 
		PFD_SUPPORT_OPENGL |   // support OpenGL 
		PFD_DOUBLEBUFFER,      // double buffered 
		PFD_TYPE_RGBA,         // RGBA type 
		24,                    // 24-bit color depth 
		0, 0, 0, 0, 0, 0,      // color bits ignored 
		0,                     // no alpha buffer 
		0,                     // shift bit ignored 
		0,                     // no accumulation buffer 
		0, 0, 0, 0,            // accum bits ignored 
		32,                    // 32-bit z-buffer 
		0,                     // no stencil buffer 
		0,                     // no auxiliary buffer 
		PFD_MAIN_PLANE,        // main layer 
		0,                     // reserved 
		0, 0, 0                // layer masks ignored 
	}; 
	int  iPixelFormat; 
	ghWnd = FindWindow(NULL, wname);
	ghDC = GetDC(ghWnd);
	iPixelFormat = ChoosePixelFormat(ghDC, &pfd); 
	SetPixelFormat(ghDC, iPixelFormat, &pfd);     
	ghGlrc = wglCreateContext (ghDC); 
	wglMakeCurrent (ghDC, ghGlrc);  
#endif	
	result = Val_unit;
	CAMLreturn(result);
}

value stub_swap_buffers(value unit)
{
	CAMLparam1(unit);
	CAMLlocal1(result);
#ifdef __unix__	
	glXSwapBuffers(gdisplay, gwin);
#endif
#ifdef _WIN32
	wglSwapLayerBuffers(ghDC, WGL_SWAP_MAIN_PLANE);
#endif	
	result = Val_unit;
	CAMLreturn(result);
}

#ifdef _WIN32
#  include <windows.h>
#  define usleep(t) Sleep((t) / 1000)
#else
#  include <unistd.h>
#endif

value stub_usleep(value t)
{
	CAMLparam1(t);
	usleep(Int_val(t));
	CAMLreturn(Val_unit);
}
