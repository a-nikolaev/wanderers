/*
 * GLCaml - Objective Caml interface for OpenGL 1.1, 1.2, 1.3, 1.4, 1.5, 2.0 and 2.1
 * plus extensions: 
 *
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
 */

#include <stdio.h>
#include <string.h> 
 
#include <caml/mlvalues.h>
#include <caml/memory.h>
#include <caml/alloc.h>
#include <caml/fail.h>
#include <caml/callback.h>
#include <caml/bigarray.h>

typedef unsigned int GLenum;
typedef unsigned char GLboolean;
typedef unsigned int GLbitfield;
typedef void GLvoid;
typedef char GLbyte;
typedef short GLshort;
typedef int GLint;
typedef unsigned char GLubyte;
typedef unsigned short GLushort;
typedef unsigned int GLuint;
typedef int GLsizei;
typedef float GLfloat;
typedef float GLclampf;
typedef double GLdouble;
typedef double GLclampd;
typedef char GLchar;
typedef ptrdiff_t GLsizeiptr;
typedef ptrdiff_t GLintptr;
typedef char* GLstring;

#ifdef _WIN32
#include <windows.h>

static HMODULE lib=NULL;

static void init_lib()
{
	if(lib)return;
	lib = LoadLibrary("opengl32.dll");
	if(lib == NULL) failwith("error loading opengl32.dll");
}

static void *get_proc_address(char *fname)
{
	return GetProcAddress(lib, fname);
}

#endif

#ifdef __unix__
#ifndef APIENTRY
#define APIENTRY
#endif
#include <dlfcn.h>
#include <stdio.h>

static void* lib=NULL;

static void init_lib()
{
	if(lib)return;
	lib = dlopen("libGL.so.1",RTLD_LAZY);
	if(lib == NULL) failwith("error loading libGL.so.1");
}

static void *get_proc_address(char *fname)
{
	return dlsym(lib, fname);
}

#endif

#if defined(__APPLE__) && defined(__GNUC__)
#ifndef APIENTRY
#define APIENTRY
#endif
#include <dlfcn.h>
#include <stdio.h>

static void* lib=NULL;

static void init_lib()
{
	if(lib)return;
	lib = dlopen("libGL.dylib",RTLD_LAZY);
	if(lib == NULL) failwith("error loading libGL.dylib");
}

static void *get_proc_address(char *fname)
{
	return dlsym(lib, fname);
}
#endif

value unsafe_coercion(value v)
{
        CAMLparam1(v);
        CAMLreturn(v);
}


#define DECLARE_FUNCTION(func, args, ret)						\
typedef ret APIENTRY (*pstub_##func)args;						\
static pstub_##func stub_##func = NULL;							\
static int loaded_##func = 0;



#define LOAD_FUNCTION(func) 									\
	if(!loaded_##func)											\
	{															\
		init_lib ();											\
		stub_##func = (pstub_##func)get_proc_address(#func);	\
		if(stub_##func)											\
		{														\
			loaded_##func = 1;									\
		}														\
		else													\
		{														\
			char fn[256], buf[300];								\
			strncpy(fn, #func, 255);							\
			sprintf(buf, "Unable to load %s", fn);			\
			caml_failwith(buf);									\
		}														\
	}



DECLARE_FUNCTION(glAccum,(GLenum, GLfloat),void);
value glstub_glAccum(value v0, value v1)
{
	CAMLparam2(v0, v1);
	GLenum lv0 = Int_val(v0);
	GLfloat lv1 = Double_val(v1);
	LOAD_FUNCTION(glAccum);
	(*stub_glAccum)(lv0, lv1);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glActiveStencilFaceEXT,(GLenum),void);
value glstub_glActiveStencilFaceEXT(value v0)
{
	CAMLparam1(v0);
	GLenum lv0 = Int_val(v0);
	LOAD_FUNCTION(glActiveStencilFaceEXT);
	(*stub_glActiveStencilFaceEXT)(lv0);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glActiveTexture,(GLenum),void);
value glstub_glActiveTexture(value v0)
{
	CAMLparam1(v0);
	GLenum lv0 = Int_val(v0);
	LOAD_FUNCTION(glActiveTexture);
	(*stub_glActiveTexture)(lv0);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glActiveTextureARB,(GLenum),void);
value glstub_glActiveTextureARB(value v0)
{
	CAMLparam1(v0);
	GLenum lv0 = Int_val(v0);
	LOAD_FUNCTION(glActiveTextureARB);
	(*stub_glActiveTextureARB)(lv0);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glActiveVaryingNV,(GLuint, GLchar*),void);
value glstub_glActiveVaryingNV(value v0, value v1)
{
	CAMLparam2(v0, v1);
	GLuint lv0 = Int_val(v0);
	GLchar* lv1 = String_val(v1);
	LOAD_FUNCTION(glActiveVaryingNV);
	(*stub_glActiveVaryingNV)(lv0, lv1);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glAddSwapHintRectWIN,(GLint, GLint, GLsizei, GLsizei),void);
value glstub_glAddSwapHintRectWIN(value v0, value v1, value v2, value v3)
{
	CAMLparam4(v0, v1, v2, v3);
	GLint lv0 = Int_val(v0);
	GLint lv1 = Int_val(v1);
	GLsizei lv2 = Int_val(v2);
	GLsizei lv3 = Int_val(v3);
	LOAD_FUNCTION(glAddSwapHintRectWIN);
	(*stub_glAddSwapHintRectWIN)(lv0, lv1, lv2, lv3);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glAlphaFragmentOp1ATI,(GLenum, GLuint, GLuint, GLuint, GLuint, GLuint),void);
value glstub_glAlphaFragmentOp1ATI(value v0, value v1, value v2, value v3, value v4, value v5)
{
	CAMLparam5(v0, v1, v2, v3, v4);
	CAMLxparam1(v5);
	GLenum lv0 = Int_val(v0);
	GLuint lv1 = Int_val(v1);
	GLuint lv2 = Int_val(v2);
	GLuint lv3 = Int_val(v3);
	GLuint lv4 = Int_val(v4);
	GLuint lv5 = Int_val(v5);
	LOAD_FUNCTION(glAlphaFragmentOp1ATI);
	(*stub_glAlphaFragmentOp1ATI)(lv0, lv1, lv2, lv3, lv4, lv5);
	CAMLreturn(Val_unit);
}

value glstub_glAlphaFragmentOp1ATI_byte(value * argv, int n)
{
	return glstub_glAlphaFragmentOp1ATI(argv[0], argv[1], argv[2], argv[3], argv[4], argv[5]);
}

DECLARE_FUNCTION(glAlphaFragmentOp2ATI,(GLenum, GLuint, GLuint, GLuint, GLuint, GLuint, GLuint, GLuint, GLuint),void);
value glstub_glAlphaFragmentOp2ATI(value v0, value v1, value v2, value v3, value v4, value v5, value v6, value v7, value v8)
{
	CAMLparam5(v0, v1, v2, v3, v4);
	CAMLxparam4(v5, v6, v7, v8);
	GLenum lv0 = Int_val(v0);
	GLuint lv1 = Int_val(v1);
	GLuint lv2 = Int_val(v2);
	GLuint lv3 = Int_val(v3);
	GLuint lv4 = Int_val(v4);
	GLuint lv5 = Int_val(v5);
	GLuint lv6 = Int_val(v6);
	GLuint lv7 = Int_val(v7);
	GLuint lv8 = Int_val(v8);
	LOAD_FUNCTION(glAlphaFragmentOp2ATI);
	(*stub_glAlphaFragmentOp2ATI)(lv0, lv1, lv2, lv3, lv4, lv5, lv6, lv7, lv8);
	CAMLreturn(Val_unit);
}

value glstub_glAlphaFragmentOp2ATI_byte(value * argv, int n)
{
	return glstub_glAlphaFragmentOp2ATI(argv[0], argv[1], argv[2], argv[3], argv[4], argv[5], argv[6], argv[7], argv[8]);
}

DECLARE_FUNCTION(glAlphaFragmentOp3ATI,(GLenum, GLuint, GLuint, GLuint, GLuint, GLuint, GLuint, GLuint, GLuint, GLuint, GLuint, GLuint),void);
value glstub_glAlphaFragmentOp3ATI(value v0, value v1, value v2, value v3, value v4, value v5, value v6, value v7, value v8, value v9, value v10, value v11)
{
	CAMLparam5(v0, v1, v2, v3, v4);
	CAMLxparam5(v5, v6, v7, v8, v9);
	CAMLxparam2(v10, v11);
	GLenum lv0 = Int_val(v0);
	GLuint lv1 = Int_val(v1);
	GLuint lv2 = Int_val(v2);
	GLuint lv3 = Int_val(v3);
	GLuint lv4 = Int_val(v4);
	GLuint lv5 = Int_val(v5);
	GLuint lv6 = Int_val(v6);
	GLuint lv7 = Int_val(v7);
	GLuint lv8 = Int_val(v8);
	GLuint lv9 = Int_val(v9);
	GLuint lv10 = Int_val(v10);
	GLuint lv11 = Int_val(v11);
	LOAD_FUNCTION(glAlphaFragmentOp3ATI);
	(*stub_glAlphaFragmentOp3ATI)(lv0, lv1, lv2, lv3, lv4, lv5, lv6, lv7, lv8, lv9, lv10, lv11);
	CAMLreturn(Val_unit);
}

value glstub_glAlphaFragmentOp3ATI_byte(value * argv, int n)
{
	return glstub_glAlphaFragmentOp3ATI(argv[0], argv[1], argv[2], argv[3], argv[4], argv[5], argv[6], argv[7], argv[8], argv[9], argv[10], argv[11]);
}

DECLARE_FUNCTION(glAlphaFunc,(GLenum, GLclampf),void);
value glstub_glAlphaFunc(value v0, value v1)
{
	CAMLparam2(v0, v1);
	GLenum lv0 = Int_val(v0);
	GLclampf lv1 = Double_val(v1);
	LOAD_FUNCTION(glAlphaFunc);
	(*stub_glAlphaFunc)(lv0, lv1);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glApplyTextureEXT,(GLenum),void);
value glstub_glApplyTextureEXT(value v0)
{
	CAMLparam1(v0);
	GLenum lv0 = Int_val(v0);
	LOAD_FUNCTION(glApplyTextureEXT);
	(*stub_glApplyTextureEXT)(lv0);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glAreProgramsResidentNV,(GLsizei, GLuint*, GLboolean*),GLboolean);
value glstub_glAreProgramsResidentNV(value v0, value v1, value v2)
{
	CAMLparam3(v0, v1, v2);
	CAMLlocal1(result);
	GLsizei lv0 = Int_val(v0);
	GLuint* lv1 = Data_bigarray_val(v1);
	GLboolean* lv2 = Data_bigarray_val(v2);
	GLboolean ret;
	LOAD_FUNCTION(glAreProgramsResidentNV);
	ret = (*stub_glAreProgramsResidentNV)(lv0, lv1, lv2);
	result = Val_bool(ret);
	CAMLreturn(result);
}

DECLARE_FUNCTION(glAreTexturesResident,(GLsizei, GLuint*, GLboolean*),GLboolean);
value glstub_glAreTexturesResident(value v0, value v1, value v2)
{
	CAMLparam3(v0, v1, v2);
	CAMLlocal1(result);
	GLsizei lv0 = Int_val(v0);
	GLuint* lv1 = Data_bigarray_val(v1);
	GLboolean* lv2 = Data_bigarray_val(v2);
	GLboolean ret;
	LOAD_FUNCTION(glAreTexturesResident);
	ret = (*stub_glAreTexturesResident)(lv0, lv1, lv2);
	result = Val_bool(ret);
	CAMLreturn(result);
}

DECLARE_FUNCTION(glAreTexturesResidentEXT,(GLsizei, GLuint*, GLboolean*),GLboolean);
value glstub_glAreTexturesResidentEXT(value v0, value v1, value v2)
{
	CAMLparam3(v0, v1, v2);
	CAMLlocal1(result);
	GLsizei lv0 = Int_val(v0);
	GLuint* lv1 = Data_bigarray_val(v1);
	GLboolean* lv2 = Data_bigarray_val(v2);
	GLboolean ret;
	LOAD_FUNCTION(glAreTexturesResidentEXT);
	ret = (*stub_glAreTexturesResidentEXT)(lv0, lv1, lv2);
	result = Val_bool(ret);
	CAMLreturn(result);
}

DECLARE_FUNCTION(glArrayElement,(GLint),void);
value glstub_glArrayElement(value v0)
{
	CAMLparam1(v0);
	GLint lv0 = Int_val(v0);
	LOAD_FUNCTION(glArrayElement);
	(*stub_glArrayElement)(lv0);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glArrayElementEXT,(GLint),void);
value glstub_glArrayElementEXT(value v0)
{
	CAMLparam1(v0);
	GLint lv0 = Int_val(v0);
	LOAD_FUNCTION(glArrayElementEXT);
	(*stub_glArrayElementEXT)(lv0);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glArrayObjectATI,(GLenum, GLint, GLenum, GLsizei, GLuint, GLuint),void);
value glstub_glArrayObjectATI(value v0, value v1, value v2, value v3, value v4, value v5)
{
	CAMLparam5(v0, v1, v2, v3, v4);
	CAMLxparam1(v5);
	GLenum lv0 = Int_val(v0);
	GLint lv1 = Int_val(v1);
	GLenum lv2 = Int_val(v2);
	GLsizei lv3 = Int_val(v3);
	GLuint lv4 = Int_val(v4);
	GLuint lv5 = Int_val(v5);
	LOAD_FUNCTION(glArrayObjectATI);
	(*stub_glArrayObjectATI)(lv0, lv1, lv2, lv3, lv4, lv5);
	CAMLreturn(Val_unit);
}

value glstub_glArrayObjectATI_byte(value * argv, int n)
{
	return glstub_glArrayObjectATI(argv[0], argv[1], argv[2], argv[3], argv[4], argv[5]);
}

DECLARE_FUNCTION(glAsyncMarkerSGIX,(GLuint),void);
value glstub_glAsyncMarkerSGIX(value v0)
{
	CAMLparam1(v0);
	GLuint lv0 = Int_val(v0);
	LOAD_FUNCTION(glAsyncMarkerSGIX);
	(*stub_glAsyncMarkerSGIX)(lv0);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glAttachObjectARB,(GLuint, GLuint),void);
value glstub_glAttachObjectARB(value v0, value v1)
{
	CAMLparam2(v0, v1);
	GLuint lv0 = Int_val(v0);
	GLuint lv1 = Int_val(v1);
	LOAD_FUNCTION(glAttachObjectARB);
	(*stub_glAttachObjectARB)(lv0, lv1);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glAttachShader,(GLuint, GLuint),void);
value glstub_glAttachShader(value v0, value v1)
{
	CAMLparam2(v0, v1);
	GLuint lv0 = Int_val(v0);
	GLuint lv1 = Int_val(v1);
	LOAD_FUNCTION(glAttachShader);
	(*stub_glAttachShader)(lv0, lv1);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glBegin,(GLenum),void);
value glstub_glBegin(value v0)
{
	CAMLparam1(v0);
	GLenum lv0 = Int_val(v0);
	LOAD_FUNCTION(glBegin);
	(*stub_glBegin)(lv0);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glBeginFragmentShaderATI,(void),void);
value glstub_glBeginFragmentShaderATI(value v0)
{
	CAMLparam1(v0);
	LOAD_FUNCTION(glBeginFragmentShaderATI);
	(*stub_glBeginFragmentShaderATI)();
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glBeginOcclusionQueryNV,(GLuint),void);
value glstub_glBeginOcclusionQueryNV(value v0)
{
	CAMLparam1(v0);
	GLuint lv0 = Int_val(v0);
	LOAD_FUNCTION(glBeginOcclusionQueryNV);
	(*stub_glBeginOcclusionQueryNV)(lv0);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glBeginQuery,(GLenum, GLuint),void);
value glstub_glBeginQuery(value v0, value v1)
{
	CAMLparam2(v0, v1);
	GLenum lv0 = Int_val(v0);
	GLuint lv1 = Int_val(v1);
	LOAD_FUNCTION(glBeginQuery);
	(*stub_glBeginQuery)(lv0, lv1);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glBeginQueryARB,(GLenum, GLuint),void);
value glstub_glBeginQueryARB(value v0, value v1)
{
	CAMLparam2(v0, v1);
	GLenum lv0 = Int_val(v0);
	GLuint lv1 = Int_val(v1);
	LOAD_FUNCTION(glBeginQueryARB);
	(*stub_glBeginQueryARB)(lv0, lv1);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glBeginSceneEXT,(void),void);
value glstub_glBeginSceneEXT(value v0)
{
	CAMLparam1(v0);
	LOAD_FUNCTION(glBeginSceneEXT);
	(*stub_glBeginSceneEXT)();
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glBeginTransformFeedbackNV,(GLenum),void);
value glstub_glBeginTransformFeedbackNV(value v0)
{
	CAMLparam1(v0);
	GLenum lv0 = Int_val(v0);
	LOAD_FUNCTION(glBeginTransformFeedbackNV);
	(*stub_glBeginTransformFeedbackNV)(lv0);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glBeginVertexShaderEXT,(void),void);
value glstub_glBeginVertexShaderEXT(value v0)
{
	CAMLparam1(v0);
	LOAD_FUNCTION(glBeginVertexShaderEXT);
	(*stub_glBeginVertexShaderEXT)();
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glBindAttribLocation,(GLuint, GLuint, GLchar*),void);
value glstub_glBindAttribLocation(value v0, value v1, value v2)
{
	CAMLparam3(v0, v1, v2);
	GLuint lv0 = Int_val(v0);
	GLuint lv1 = Int_val(v1);
	GLchar* lv2 = String_val(v2);
	LOAD_FUNCTION(glBindAttribLocation);
	(*stub_glBindAttribLocation)(lv0, lv1, lv2);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glBindAttribLocationARB,(GLuint, GLuint, GLchar*),void);
value glstub_glBindAttribLocationARB(value v0, value v1, value v2)
{
	CAMLparam3(v0, v1, v2);
	GLuint lv0 = Int_val(v0);
	GLuint lv1 = Int_val(v1);
	GLchar* lv2 = String_val(v2);
	LOAD_FUNCTION(glBindAttribLocationARB);
	(*stub_glBindAttribLocationARB)(lv0, lv1, lv2);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glBindBuffer,(GLenum, GLuint),void);
value glstub_glBindBuffer(value v0, value v1)
{
	CAMLparam2(v0, v1);
	GLenum lv0 = Int_val(v0);
	GLuint lv1 = Int_val(v1);
	LOAD_FUNCTION(glBindBuffer);
	(*stub_glBindBuffer)(lv0, lv1);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glBindBufferARB,(GLenum, GLuint),void);
value glstub_glBindBufferARB(value v0, value v1)
{
	CAMLparam2(v0, v1);
	GLenum lv0 = Int_val(v0);
	GLuint lv1 = Int_val(v1);
	LOAD_FUNCTION(glBindBufferARB);
	(*stub_glBindBufferARB)(lv0, lv1);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glBindBufferBaseNV,(GLenum, GLuint, GLuint),void);
value glstub_glBindBufferBaseNV(value v0, value v1, value v2)
{
	CAMLparam3(v0, v1, v2);
	GLenum lv0 = Int_val(v0);
	GLuint lv1 = Int_val(v1);
	GLuint lv2 = Int_val(v2);
	LOAD_FUNCTION(glBindBufferBaseNV);
	(*stub_glBindBufferBaseNV)(lv0, lv1, lv2);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glBindBufferOffsetNV,(GLenum, GLuint, GLuint, GLintptr),void);
value glstub_glBindBufferOffsetNV(value v0, value v1, value v2, value v3)
{
	CAMLparam4(v0, v1, v2, v3);
	GLenum lv0 = Int_val(v0);
	GLuint lv1 = Int_val(v1);
	GLuint lv2 = Int_val(v2);
	GLintptr lv3 = Int_val(v3);
	LOAD_FUNCTION(glBindBufferOffsetNV);
	(*stub_glBindBufferOffsetNV)(lv0, lv1, lv2, lv3);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glBindBufferRangeNV,(GLenum, GLuint, GLuint, GLintptr, GLsizeiptr),void);
value glstub_glBindBufferRangeNV(value v0, value v1, value v2, value v3, value v4)
{
	CAMLparam5(v0, v1, v2, v3, v4);
	GLenum lv0 = Int_val(v0);
	GLuint lv1 = Int_val(v1);
	GLuint lv2 = Int_val(v2);
	GLintptr lv3 = Int_val(v3);
	GLsizeiptr lv4 = Int_val(v4);
	LOAD_FUNCTION(glBindBufferRangeNV);
	(*stub_glBindBufferRangeNV)(lv0, lv1, lv2, lv3, lv4);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glBindFragDataLocationEXT,(GLuint, GLuint, GLchar*),void);
value glstub_glBindFragDataLocationEXT(value v0, value v1, value v2)
{
	CAMLparam3(v0, v1, v2);
	GLuint lv0 = Int_val(v0);
	GLuint lv1 = Int_val(v1);
	GLchar* lv2 = String_val(v2);
	LOAD_FUNCTION(glBindFragDataLocationEXT);
	(*stub_glBindFragDataLocationEXT)(lv0, lv1, lv2);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glBindFragmentShaderATI,(GLuint),void);
value glstub_glBindFragmentShaderATI(value v0)
{
	CAMLparam1(v0);
	GLuint lv0 = Int_val(v0);
	LOAD_FUNCTION(glBindFragmentShaderATI);
	(*stub_glBindFragmentShaderATI)(lv0);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glBindFramebufferEXT,(GLenum, GLuint),void);
value glstub_glBindFramebufferEXT(value v0, value v1)
{
	CAMLparam2(v0, v1);
	GLenum lv0 = Int_val(v0);
	GLuint lv1 = Int_val(v1);
	LOAD_FUNCTION(glBindFramebufferEXT);
	(*stub_glBindFramebufferEXT)(lv0, lv1);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glBindLightParameterEXT,(GLenum, GLenum),GLuint);
value glstub_glBindLightParameterEXT(value v0, value v1)
{
	CAMLparam2(v0, v1);
	CAMLlocal1(result);
	GLenum lv0 = Int_val(v0);
	GLenum lv1 = Int_val(v1);
	GLuint ret;
	LOAD_FUNCTION(glBindLightParameterEXT);
	ret = (*stub_glBindLightParameterEXT)(lv0, lv1);
	result = Val_int(ret);
	CAMLreturn(result);
}

DECLARE_FUNCTION(glBindMaterialParameterEXT,(GLenum, GLenum),GLuint);
value glstub_glBindMaterialParameterEXT(value v0, value v1)
{
	CAMLparam2(v0, v1);
	CAMLlocal1(result);
	GLenum lv0 = Int_val(v0);
	GLenum lv1 = Int_val(v1);
	GLuint ret;
	LOAD_FUNCTION(glBindMaterialParameterEXT);
	ret = (*stub_glBindMaterialParameterEXT)(lv0, lv1);
	result = Val_int(ret);
	CAMLreturn(result);
}

DECLARE_FUNCTION(glBindParameterEXT,(GLenum),GLuint);
value glstub_glBindParameterEXT(value v0)
{
	CAMLparam1(v0);
	CAMLlocal1(result);
	GLenum lv0 = Int_val(v0);
	GLuint ret;
	LOAD_FUNCTION(glBindParameterEXT);
	ret = (*stub_glBindParameterEXT)(lv0);
	result = Val_int(ret);
	CAMLreturn(result);
}

DECLARE_FUNCTION(glBindProgramARB,(GLenum, GLuint),void);
value glstub_glBindProgramARB(value v0, value v1)
{
	CAMLparam2(v0, v1);
	GLenum lv0 = Int_val(v0);
	GLuint lv1 = Int_val(v1);
	LOAD_FUNCTION(glBindProgramARB);
	(*stub_glBindProgramARB)(lv0, lv1);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glBindProgramNV,(GLenum, GLuint),void);
value glstub_glBindProgramNV(value v0, value v1)
{
	CAMLparam2(v0, v1);
	GLenum lv0 = Int_val(v0);
	GLuint lv1 = Int_val(v1);
	LOAD_FUNCTION(glBindProgramNV);
	(*stub_glBindProgramNV)(lv0, lv1);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glBindRenderbufferEXT,(GLenum, GLuint),void);
value glstub_glBindRenderbufferEXT(value v0, value v1)
{
	CAMLparam2(v0, v1);
	GLenum lv0 = Int_val(v0);
	GLuint lv1 = Int_val(v1);
	LOAD_FUNCTION(glBindRenderbufferEXT);
	(*stub_glBindRenderbufferEXT)(lv0, lv1);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glBindTexGenParameterEXT,(GLenum, GLenum, GLenum),GLuint);
value glstub_glBindTexGenParameterEXT(value v0, value v1, value v2)
{
	CAMLparam3(v0, v1, v2);
	CAMLlocal1(result);
	GLenum lv0 = Int_val(v0);
	GLenum lv1 = Int_val(v1);
	GLenum lv2 = Int_val(v2);
	GLuint ret;
	LOAD_FUNCTION(glBindTexGenParameterEXT);
	ret = (*stub_glBindTexGenParameterEXT)(lv0, lv1, lv2);
	result = Val_int(ret);
	CAMLreturn(result);
}

DECLARE_FUNCTION(glBindTexture,(GLenum, GLuint),void);
value glstub_glBindTexture(value v0, value v1)
{
	CAMLparam2(v0, v1);
	GLenum lv0 = Int_val(v0);
	GLuint lv1 = Int_val(v1);
	LOAD_FUNCTION(glBindTexture);
	(*stub_glBindTexture)(lv0, lv1);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glBindTextureEXT,(GLenum, GLuint),void);
value glstub_glBindTextureEXT(value v0, value v1)
{
	CAMLparam2(v0, v1);
	GLenum lv0 = Int_val(v0);
	GLuint lv1 = Int_val(v1);
	LOAD_FUNCTION(glBindTextureEXT);
	(*stub_glBindTextureEXT)(lv0, lv1);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glBindTextureUnitParameterEXT,(GLenum, GLenum),GLuint);
value glstub_glBindTextureUnitParameterEXT(value v0, value v1)
{
	CAMLparam2(v0, v1);
	CAMLlocal1(result);
	GLenum lv0 = Int_val(v0);
	GLenum lv1 = Int_val(v1);
	GLuint ret;
	LOAD_FUNCTION(glBindTextureUnitParameterEXT);
	ret = (*stub_glBindTextureUnitParameterEXT)(lv0, lv1);
	result = Val_int(ret);
	CAMLreturn(result);
}

DECLARE_FUNCTION(glBindVertexArrayAPPLE,(GLuint),void);
value glstub_glBindVertexArrayAPPLE(value v0)
{
	CAMLparam1(v0);
	GLuint lv0 = Int_val(v0);
	LOAD_FUNCTION(glBindVertexArrayAPPLE);
	(*stub_glBindVertexArrayAPPLE)(lv0);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glBindVertexShaderEXT,(GLuint),void);
value glstub_glBindVertexShaderEXT(value v0)
{
	CAMLparam1(v0);
	GLuint lv0 = Int_val(v0);
	LOAD_FUNCTION(glBindVertexShaderEXT);
	(*stub_glBindVertexShaderEXT)(lv0);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glBinormalPointerEXT,(GLenum, GLsizei, GLvoid*),void);
value glstub_glBinormalPointerEXT(value v0, value v1, value v2)
{
	CAMLparam3(v0, v1, v2);
	GLenum lv0 = Int_val(v0);
	GLsizei lv1 = Int_val(v1);
	GLvoid* lv2 = (GLvoid *)((Tag_val(v2) == String_tag)? (String_val(v2)) : (Data_bigarray_val(v2)));
	LOAD_FUNCTION(glBinormalPointerEXT);
	(*stub_glBinormalPointerEXT)(lv0, lv1, lv2);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glBitmap,(GLsizei, GLsizei, GLfloat, GLfloat, GLfloat, GLfloat, GLubyte*),void);
value glstub_glBitmap(value v0, value v1, value v2, value v3, value v4, value v5, value v6)
{
	CAMLparam5(v0, v1, v2, v3, v4);
	CAMLxparam2(v5, v6);
	GLsizei lv0 = Int_val(v0);
	GLsizei lv1 = Int_val(v1);
	GLfloat lv2 = Double_val(v2);
	GLfloat lv3 = Double_val(v3);
	GLfloat lv4 = Double_val(v4);
	GLfloat lv5 = Double_val(v5);
	GLubyte* lv6 = Data_bigarray_val(v6);
	LOAD_FUNCTION(glBitmap);
	(*stub_glBitmap)(lv0, lv1, lv2, lv3, lv4, lv5, lv6);
	CAMLreturn(Val_unit);
}

value glstub_glBitmap_byte(value * argv, int n)
{
	return glstub_glBitmap(argv[0], argv[1], argv[2], argv[3], argv[4], argv[5], argv[6]);
}

DECLARE_FUNCTION(glBlendColor,(GLclampf, GLclampf, GLclampf, GLclampf),void);
value glstub_glBlendColor(value v0, value v1, value v2, value v3)
{
	CAMLparam4(v0, v1, v2, v3);
	GLclampf lv0 = Double_val(v0);
	GLclampf lv1 = Double_val(v1);
	GLclampf lv2 = Double_val(v2);
	GLclampf lv3 = Double_val(v3);
	LOAD_FUNCTION(glBlendColor);
	(*stub_glBlendColor)(lv0, lv1, lv2, lv3);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glBlendColorEXT,(GLclampf, GLclampf, GLclampf, GLclampf),void);
value glstub_glBlendColorEXT(value v0, value v1, value v2, value v3)
{
	CAMLparam4(v0, v1, v2, v3);
	GLclampf lv0 = Double_val(v0);
	GLclampf lv1 = Double_val(v1);
	GLclampf lv2 = Double_val(v2);
	GLclampf lv3 = Double_val(v3);
	LOAD_FUNCTION(glBlendColorEXT);
	(*stub_glBlendColorEXT)(lv0, lv1, lv2, lv3);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glBlendEquation,(GLenum),void);
value glstub_glBlendEquation(value v0)
{
	CAMLparam1(v0);
	GLenum lv0 = Int_val(v0);
	LOAD_FUNCTION(glBlendEquation);
	(*stub_glBlendEquation)(lv0);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glBlendEquationEXT,(GLenum),void);
value glstub_glBlendEquationEXT(value v0)
{
	CAMLparam1(v0);
	GLenum lv0 = Int_val(v0);
	LOAD_FUNCTION(glBlendEquationEXT);
	(*stub_glBlendEquationEXT)(lv0);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glBlendEquationSeparate,(GLenum, GLenum),void);
value glstub_glBlendEquationSeparate(value v0, value v1)
{
	CAMLparam2(v0, v1);
	GLenum lv0 = Int_val(v0);
	GLenum lv1 = Int_val(v1);
	LOAD_FUNCTION(glBlendEquationSeparate);
	(*stub_glBlendEquationSeparate)(lv0, lv1);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glBlendEquationSeparateEXT,(GLenum, GLenum),void);
value glstub_glBlendEquationSeparateEXT(value v0, value v1)
{
	CAMLparam2(v0, v1);
	GLenum lv0 = Int_val(v0);
	GLenum lv1 = Int_val(v1);
	LOAD_FUNCTION(glBlendEquationSeparateEXT);
	(*stub_glBlendEquationSeparateEXT)(lv0, lv1);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glBlendFunc,(GLenum, GLenum),void);
value glstub_glBlendFunc(value v0, value v1)
{
	CAMLparam2(v0, v1);
	GLenum lv0 = Int_val(v0);
	GLenum lv1 = Int_val(v1);
	LOAD_FUNCTION(glBlendFunc);
	(*stub_glBlendFunc)(lv0, lv1);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glBlendFuncSeparate,(GLenum, GLenum, GLenum, GLenum),void);
value glstub_glBlendFuncSeparate(value v0, value v1, value v2, value v3)
{
	CAMLparam4(v0, v1, v2, v3);
	GLenum lv0 = Int_val(v0);
	GLenum lv1 = Int_val(v1);
	GLenum lv2 = Int_val(v2);
	GLenum lv3 = Int_val(v3);
	LOAD_FUNCTION(glBlendFuncSeparate);
	(*stub_glBlendFuncSeparate)(lv0, lv1, lv2, lv3);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glBlendFuncSeparateEXT,(GLenum, GLenum, GLenum, GLenum),void);
value glstub_glBlendFuncSeparateEXT(value v0, value v1, value v2, value v3)
{
	CAMLparam4(v0, v1, v2, v3);
	GLenum lv0 = Int_val(v0);
	GLenum lv1 = Int_val(v1);
	GLenum lv2 = Int_val(v2);
	GLenum lv3 = Int_val(v3);
	LOAD_FUNCTION(glBlendFuncSeparateEXT);
	(*stub_glBlendFuncSeparateEXT)(lv0, lv1, lv2, lv3);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glBlitFramebufferEXT,(GLint, GLint, GLint, GLint, GLint, GLint, GLint, GLint, GLbitfield, GLenum),void);
value glstub_glBlitFramebufferEXT(value v0, value v1, value v2, value v3, value v4, value v5, value v6, value v7, value v8, value v9)
{
	CAMLparam5(v0, v1, v2, v3, v4);
	CAMLxparam5(v5, v6, v7, v8, v9);
	GLint lv0 = Int_val(v0);
	GLint lv1 = Int_val(v1);
	GLint lv2 = Int_val(v2);
	GLint lv3 = Int_val(v3);
	GLint lv4 = Int_val(v4);
	GLint lv5 = Int_val(v5);
	GLint lv6 = Int_val(v6);
	GLint lv7 = Int_val(v7);
	GLbitfield lv8 = Int_val(v8);
	GLenum lv9 = Int_val(v9);
	LOAD_FUNCTION(glBlitFramebufferEXT);
	(*stub_glBlitFramebufferEXT)(lv0, lv1, lv2, lv3, lv4, lv5, lv6, lv7, lv8, lv9);
	CAMLreturn(Val_unit);
}

value glstub_glBlitFramebufferEXT_byte(value * argv, int n)
{
	return glstub_glBlitFramebufferEXT(argv[0], argv[1], argv[2], argv[3], argv[4], argv[5], argv[6], argv[7], argv[8], argv[9]);
}

DECLARE_FUNCTION(glBufferData,(GLenum, GLsizeiptr, GLvoid*, GLenum),void);
value glstub_glBufferData(value v0, value v1, value v2, value v3)
{
	CAMLparam4(v0, v1, v2, v3);
	GLenum lv0 = Int_val(v0);
	GLsizeiptr lv1 = Int_val(v1);
	GLvoid* lv2 = (GLvoid *)((Tag_val(v2) == String_tag)? (String_val(v2)) : (Data_bigarray_val(v2)));
	GLenum lv3 = Int_val(v3);
	LOAD_FUNCTION(glBufferData);
	(*stub_glBufferData)(lv0, lv1, lv2, lv3);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glBufferDataARB,(GLenum, GLsizeiptr, GLvoid*, GLenum),void);
value glstub_glBufferDataARB(value v0, value v1, value v2, value v3)
{
	CAMLparam4(v0, v1, v2, v3);
	GLenum lv0 = Int_val(v0);
	GLsizeiptr lv1 = Int_val(v1);
	GLvoid* lv2 = (GLvoid *)((Tag_val(v2) == String_tag)? (String_val(v2)) : (Data_bigarray_val(v2)));
	GLenum lv3 = Int_val(v3);
	LOAD_FUNCTION(glBufferDataARB);
	(*stub_glBufferDataARB)(lv0, lv1, lv2, lv3);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glBufferRegionEnabledEXT,(void),GLuint);
value glstub_glBufferRegionEnabledEXT(value v0)
{
	CAMLparam1(v0);
	CAMLlocal1(result);
	GLuint ret;
	LOAD_FUNCTION(glBufferRegionEnabledEXT);
	ret = (*stub_glBufferRegionEnabledEXT)();
	result = Val_int(ret);
	CAMLreturn(result);
}

DECLARE_FUNCTION(glBufferSubData,(GLenum, GLintptr, GLsizeiptr, GLvoid*),void);
value glstub_glBufferSubData(value v0, value v1, value v2, value v3)
{
	CAMLparam4(v0, v1, v2, v3);
	GLenum lv0 = Int_val(v0);
	GLintptr lv1 = Int_val(v1);
	GLsizeiptr lv2 = Int_val(v2);
	GLvoid* lv3 = (GLvoid *)((Tag_val(v3) == String_tag)? (String_val(v3)) : (Data_bigarray_val(v3)));
	LOAD_FUNCTION(glBufferSubData);
	(*stub_glBufferSubData)(lv0, lv1, lv2, lv3);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glBufferSubDataARB,(GLenum, GLintptr, GLsizeiptr, GLvoid*),void);
value glstub_glBufferSubDataARB(value v0, value v1, value v2, value v3)
{
	CAMLparam4(v0, v1, v2, v3);
	GLenum lv0 = Int_val(v0);
	GLintptr lv1 = Int_val(v1);
	GLsizeiptr lv2 = Int_val(v2);
	GLvoid* lv3 = (GLvoid *)((Tag_val(v3) == String_tag)? (String_val(v3)) : (Data_bigarray_val(v3)));
	LOAD_FUNCTION(glBufferSubDataARB);
	(*stub_glBufferSubDataARB)(lv0, lv1, lv2, lv3);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glCallList,(GLuint),void);
value glstub_glCallList(value v0)
{
	CAMLparam1(v0);
	GLuint lv0 = Int_val(v0);
	LOAD_FUNCTION(glCallList);
	(*stub_glCallList)(lv0);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glCallLists,(GLsizei, GLenum, GLvoid*),void);
value glstub_glCallLists(value v0, value v1, value v2)
{
	CAMLparam3(v0, v1, v2);
	GLsizei lv0 = Int_val(v0);
	GLenum lv1 = Int_val(v1);
	GLvoid* lv2 = (GLvoid *)((Tag_val(v2) == String_tag)? (String_val(v2)) : (Data_bigarray_val(v2)));
	LOAD_FUNCTION(glCallLists);
	(*stub_glCallLists)(lv0, lv1, lv2);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glCheckFramebufferStatusEXT,(GLenum),GLenum);
value glstub_glCheckFramebufferStatusEXT(value v0)
{
	CAMLparam1(v0);
	CAMLlocal1(result);
	GLenum lv0 = Int_val(v0);
	GLenum ret;
	LOAD_FUNCTION(glCheckFramebufferStatusEXT);
	ret = (*stub_glCheckFramebufferStatusEXT)(lv0);
	result = Val_int(ret);
	CAMLreturn(result);
}

DECLARE_FUNCTION(glClampColorARB,(GLenum, GLenum),void);
value glstub_glClampColorARB(value v0, value v1)
{
	CAMLparam2(v0, v1);
	GLenum lv0 = Int_val(v0);
	GLenum lv1 = Int_val(v1);
	LOAD_FUNCTION(glClampColorARB);
	(*stub_glClampColorARB)(lv0, lv1);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glClear,(GLbitfield),void);
value glstub_glClear(value v0)
{
	CAMLparam1(v0);
	GLbitfield lv0 = Int_val(v0);
	LOAD_FUNCTION(glClear);
	(*stub_glClear)(lv0);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glClearAccum,(GLfloat, GLfloat, GLfloat, GLfloat),void);
value glstub_glClearAccum(value v0, value v1, value v2, value v3)
{
	CAMLparam4(v0, v1, v2, v3);
	GLfloat lv0 = Double_val(v0);
	GLfloat lv1 = Double_val(v1);
	GLfloat lv2 = Double_val(v2);
	GLfloat lv3 = Double_val(v3);
	LOAD_FUNCTION(glClearAccum);
	(*stub_glClearAccum)(lv0, lv1, lv2, lv3);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glClearColor,(GLclampf, GLclampf, GLclampf, GLclampf),void);
value glstub_glClearColor(value v0, value v1, value v2, value v3)
{
	CAMLparam4(v0, v1, v2, v3);
	GLclampf lv0 = Double_val(v0);
	GLclampf lv1 = Double_val(v1);
	GLclampf lv2 = Double_val(v2);
	GLclampf lv3 = Double_val(v3);
	LOAD_FUNCTION(glClearColor);
	(*stub_glClearColor)(lv0, lv1, lv2, lv3);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glClearColorIiEXT,(GLint, GLint, GLint, GLint),void);
value glstub_glClearColorIiEXT(value v0, value v1, value v2, value v3)
{
	CAMLparam4(v0, v1, v2, v3);
	GLint lv0 = Int_val(v0);
	GLint lv1 = Int_val(v1);
	GLint lv2 = Int_val(v2);
	GLint lv3 = Int_val(v3);
	LOAD_FUNCTION(glClearColorIiEXT);
	(*stub_glClearColorIiEXT)(lv0, lv1, lv2, lv3);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glClearColorIuiEXT,(GLuint, GLuint, GLuint, GLuint),void);
value glstub_glClearColorIuiEXT(value v0, value v1, value v2, value v3)
{
	CAMLparam4(v0, v1, v2, v3);
	GLuint lv0 = Int_val(v0);
	GLuint lv1 = Int_val(v1);
	GLuint lv2 = Int_val(v2);
	GLuint lv3 = Int_val(v3);
	LOAD_FUNCTION(glClearColorIuiEXT);
	(*stub_glClearColorIuiEXT)(lv0, lv1, lv2, lv3);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glClearDepth,(GLclampd),void);
value glstub_glClearDepth(value v0)
{
	CAMLparam1(v0);
	GLclampd lv0 = Double_val(v0);
	LOAD_FUNCTION(glClearDepth);
	(*stub_glClearDepth)(lv0);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glClearDepthdNV,(GLdouble),void);
value glstub_glClearDepthdNV(value v0)
{
	CAMLparam1(v0);
	GLdouble lv0 = Double_val(v0);
	LOAD_FUNCTION(glClearDepthdNV);
	(*stub_glClearDepthdNV)(lv0);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glClearDepthfOES,(GLclampd),void);
value glstub_glClearDepthfOES(value v0)
{
	CAMLparam1(v0);
	GLclampd lv0 = Double_val(v0);
	LOAD_FUNCTION(glClearDepthfOES);
	(*stub_glClearDepthfOES)(lv0);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glClearIndex,(GLfloat),void);
value glstub_glClearIndex(value v0)
{
	CAMLparam1(v0);
	GLfloat lv0 = Double_val(v0);
	LOAD_FUNCTION(glClearIndex);
	(*stub_glClearIndex)(lv0);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glClearStencil,(GLint),void);
value glstub_glClearStencil(value v0)
{
	CAMLparam1(v0);
	GLint lv0 = Int_val(v0);
	LOAD_FUNCTION(glClearStencil);
	(*stub_glClearStencil)(lv0);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glClientActiveTexture,(GLenum),void);
value glstub_glClientActiveTexture(value v0)
{
	CAMLparam1(v0);
	GLenum lv0 = Int_val(v0);
	LOAD_FUNCTION(glClientActiveTexture);
	(*stub_glClientActiveTexture)(lv0);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glClientActiveTextureARB,(GLenum),void);
value glstub_glClientActiveTextureARB(value v0)
{
	CAMLparam1(v0);
	GLenum lv0 = Int_val(v0);
	LOAD_FUNCTION(glClientActiveTextureARB);
	(*stub_glClientActiveTextureARB)(lv0);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glClientActiveVertexStreamATI,(GLenum),void);
value glstub_glClientActiveVertexStreamATI(value v0)
{
	CAMLparam1(v0);
	GLenum lv0 = Int_val(v0);
	LOAD_FUNCTION(glClientActiveVertexStreamATI);
	(*stub_glClientActiveVertexStreamATI)(lv0);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glClipPlane,(GLenum, GLdouble*),void);
value glstub_glClipPlane(value v0, value v1)
{
	CAMLparam2(v0, v1);
	GLenum lv0 = Int_val(v0);
	GLdouble* lv1 = (Tag_val(v1) == Double_array_tag)? (double *)v1: Data_bigarray_val(v1);
	LOAD_FUNCTION(glClipPlane);
	(*stub_glClipPlane)(lv0, lv1);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glClipPlanefOES,(GLenum, GLfloat*),void);
value glstub_glClipPlanefOES(value v0, value v1)
{
	CAMLparam2(v0, v1);
	GLenum lv0 = Int_val(v0);
	GLfloat* lv1 = Data_bigarray_val(v1);
	LOAD_FUNCTION(glClipPlanefOES);
	(*stub_glClipPlanefOES)(lv0, lv1);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glColor3b,(GLbyte, GLbyte, GLbyte),void);
value glstub_glColor3b(value v0, value v1, value v2)
{
	CAMLparam3(v0, v1, v2);
	GLbyte lv0 = Int_val(v0);
	GLbyte lv1 = Int_val(v1);
	GLbyte lv2 = Int_val(v2);
	LOAD_FUNCTION(glColor3b);
	(*stub_glColor3b)(lv0, lv1, lv2);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glColor3bv,(GLbyte*),void);
value glstub_glColor3bv(value v0)
{
	CAMLparam1(v0);
	GLbyte* lv0 = Data_bigarray_val(v0);
	LOAD_FUNCTION(glColor3bv);
	(*stub_glColor3bv)(lv0);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glColor3d,(GLdouble, GLdouble, GLdouble),void);
value glstub_glColor3d(value v0, value v1, value v2)
{
	CAMLparam3(v0, v1, v2);
	GLdouble lv0 = Double_val(v0);
	GLdouble lv1 = Double_val(v1);
	GLdouble lv2 = Double_val(v2);
	LOAD_FUNCTION(glColor3d);
	(*stub_glColor3d)(lv0, lv1, lv2);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glColor3dv,(GLdouble*),void);
value glstub_glColor3dv(value v0)
{
	CAMLparam1(v0);
	GLdouble* lv0 = (Tag_val(v0) == Double_array_tag)? (double *)v0: Data_bigarray_val(v0);
	LOAD_FUNCTION(glColor3dv);
	(*stub_glColor3dv)(lv0);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glColor3f,(GLfloat, GLfloat, GLfloat),void);
value glstub_glColor3f(value v0, value v1, value v2)
{
	CAMLparam3(v0, v1, v2);
	GLfloat lv0 = Double_val(v0);
	GLfloat lv1 = Double_val(v1);
	GLfloat lv2 = Double_val(v2);
	LOAD_FUNCTION(glColor3f);
	(*stub_glColor3f)(lv0, lv1, lv2);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glColor3fVertex3fSUN,(GLfloat, GLfloat, GLfloat, GLfloat, GLfloat, GLfloat),void);
value glstub_glColor3fVertex3fSUN(value v0, value v1, value v2, value v3, value v4, value v5)
{
	CAMLparam5(v0, v1, v2, v3, v4);
	CAMLxparam1(v5);
	GLfloat lv0 = Double_val(v0);
	GLfloat lv1 = Double_val(v1);
	GLfloat lv2 = Double_val(v2);
	GLfloat lv3 = Double_val(v3);
	GLfloat lv4 = Double_val(v4);
	GLfloat lv5 = Double_val(v5);
	LOAD_FUNCTION(glColor3fVertex3fSUN);
	(*stub_glColor3fVertex3fSUN)(lv0, lv1, lv2, lv3, lv4, lv5);
	CAMLreturn(Val_unit);
}

value glstub_glColor3fVertex3fSUN_byte(value * argv, int n)
{
	return glstub_glColor3fVertex3fSUN(argv[0], argv[1], argv[2], argv[3], argv[4], argv[5]);
}

DECLARE_FUNCTION(glColor3fVertex3fvSUN,(GLfloat*, GLfloat*),void);
value glstub_glColor3fVertex3fvSUN(value v0, value v1)
{
	CAMLparam2(v0, v1);
	GLfloat* lv0 = Data_bigarray_val(v0);
	GLfloat* lv1 = Data_bigarray_val(v1);
	LOAD_FUNCTION(glColor3fVertex3fvSUN);
	(*stub_glColor3fVertex3fvSUN)(lv0, lv1);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glColor3fv,(GLfloat*),void);
value glstub_glColor3fv(value v0)
{
	CAMLparam1(v0);
	GLfloat* lv0 = Data_bigarray_val(v0);
	LOAD_FUNCTION(glColor3fv);
	(*stub_glColor3fv)(lv0);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glColor3hNV,(GLushort, GLushort, GLushort),void);
value glstub_glColor3hNV(value v0, value v1, value v2)
{
	CAMLparam3(v0, v1, v2);
	GLushort lv0 = Int_val(v0);
	GLushort lv1 = Int_val(v1);
	GLushort lv2 = Int_val(v2);
	LOAD_FUNCTION(glColor3hNV);
	(*stub_glColor3hNV)(lv0, lv1, lv2);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glColor3hvNV,(GLushort*),void);
value glstub_glColor3hvNV(value v0)
{
	CAMLparam1(v0);
	GLushort* lv0 = Data_bigarray_val(v0);
	LOAD_FUNCTION(glColor3hvNV);
	(*stub_glColor3hvNV)(lv0);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glColor3i,(GLint, GLint, GLint),void);
value glstub_glColor3i(value v0, value v1, value v2)
{
	CAMLparam3(v0, v1, v2);
	GLint lv0 = Int_val(v0);
	GLint lv1 = Int_val(v1);
	GLint lv2 = Int_val(v2);
	LOAD_FUNCTION(glColor3i);
	(*stub_glColor3i)(lv0, lv1, lv2);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glColor3iv,(GLint*),void);
value glstub_glColor3iv(value v0)
{
	CAMLparam1(v0);
	GLint* lv0 = Data_bigarray_val(v0);
	LOAD_FUNCTION(glColor3iv);
	(*stub_glColor3iv)(lv0);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glColor3s,(GLshort, GLshort, GLshort),void);
value glstub_glColor3s(value v0, value v1, value v2)
{
	CAMLparam3(v0, v1, v2);
	GLshort lv0 = Int_val(v0);
	GLshort lv1 = Int_val(v1);
	GLshort lv2 = Int_val(v2);
	LOAD_FUNCTION(glColor3s);
	(*stub_glColor3s)(lv0, lv1, lv2);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glColor3sv,(GLshort*),void);
value glstub_glColor3sv(value v0)
{
	CAMLparam1(v0);
	GLshort* lv0 = Data_bigarray_val(v0);
	LOAD_FUNCTION(glColor3sv);
	(*stub_glColor3sv)(lv0);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glColor3ub,(GLubyte, GLubyte, GLubyte),void);
value glstub_glColor3ub(value v0, value v1, value v2)
{
	CAMLparam3(v0, v1, v2);
	GLubyte lv0 = Int_val(v0);
	GLubyte lv1 = Int_val(v1);
	GLubyte lv2 = Int_val(v2);
	LOAD_FUNCTION(glColor3ub);
	(*stub_glColor3ub)(lv0, lv1, lv2);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glColor3ubv,(GLubyte*),void);
value glstub_glColor3ubv(value v0)
{
	CAMLparam1(v0);
	GLubyte* lv0 = Data_bigarray_val(v0);
	LOAD_FUNCTION(glColor3ubv);
	(*stub_glColor3ubv)(lv0);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glColor3ui,(GLuint, GLuint, GLuint),void);
value glstub_glColor3ui(value v0, value v1, value v2)
{
	CAMLparam3(v0, v1, v2);
	GLuint lv0 = Int_val(v0);
	GLuint lv1 = Int_val(v1);
	GLuint lv2 = Int_val(v2);
	LOAD_FUNCTION(glColor3ui);
	(*stub_glColor3ui)(lv0, lv1, lv2);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glColor3uiv,(GLuint*),void);
value glstub_glColor3uiv(value v0)
{
	CAMLparam1(v0);
	GLuint* lv0 = Data_bigarray_val(v0);
	LOAD_FUNCTION(glColor3uiv);
	(*stub_glColor3uiv)(lv0);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glColor3us,(GLushort, GLushort, GLushort),void);
value glstub_glColor3us(value v0, value v1, value v2)
{
	CAMLparam3(v0, v1, v2);
	GLushort lv0 = Int_val(v0);
	GLushort lv1 = Int_val(v1);
	GLushort lv2 = Int_val(v2);
	LOAD_FUNCTION(glColor3us);
	(*stub_glColor3us)(lv0, lv1, lv2);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glColor3usv,(GLushort*),void);
value glstub_glColor3usv(value v0)
{
	CAMLparam1(v0);
	GLushort* lv0 = Data_bigarray_val(v0);
	LOAD_FUNCTION(glColor3usv);
	(*stub_glColor3usv)(lv0);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glColor4b,(GLbyte, GLbyte, GLbyte, GLbyte),void);
value glstub_glColor4b(value v0, value v1, value v2, value v3)
{
	CAMLparam4(v0, v1, v2, v3);
	GLbyte lv0 = Int_val(v0);
	GLbyte lv1 = Int_val(v1);
	GLbyte lv2 = Int_val(v2);
	GLbyte lv3 = Int_val(v3);
	LOAD_FUNCTION(glColor4b);
	(*stub_glColor4b)(lv0, lv1, lv2, lv3);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glColor4bv,(GLbyte*),void);
value glstub_glColor4bv(value v0)
{
	CAMLparam1(v0);
	GLbyte* lv0 = Data_bigarray_val(v0);
	LOAD_FUNCTION(glColor4bv);
	(*stub_glColor4bv)(lv0);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glColor4d,(GLdouble, GLdouble, GLdouble, GLdouble),void);
value glstub_glColor4d(value v0, value v1, value v2, value v3)
{
	CAMLparam4(v0, v1, v2, v3);
	GLdouble lv0 = Double_val(v0);
	GLdouble lv1 = Double_val(v1);
	GLdouble lv2 = Double_val(v2);
	GLdouble lv3 = Double_val(v3);
	LOAD_FUNCTION(glColor4d);
	(*stub_glColor4d)(lv0, lv1, lv2, lv3);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glColor4dv,(GLdouble*),void);
value glstub_glColor4dv(value v0)
{
	CAMLparam1(v0);
	GLdouble* lv0 = (Tag_val(v0) == Double_array_tag)? (double *)v0: Data_bigarray_val(v0);
	LOAD_FUNCTION(glColor4dv);
	(*stub_glColor4dv)(lv0);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glColor4f,(GLfloat, GLfloat, GLfloat, GLfloat),void);
value glstub_glColor4f(value v0, value v1, value v2, value v3)
{
	CAMLparam4(v0, v1, v2, v3);
	GLfloat lv0 = Double_val(v0);
	GLfloat lv1 = Double_val(v1);
	GLfloat lv2 = Double_val(v2);
	GLfloat lv3 = Double_val(v3);
	LOAD_FUNCTION(glColor4f);
	(*stub_glColor4f)(lv0, lv1, lv2, lv3);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glColor4fNormal3fVertex3fSUN,(GLfloat, GLfloat, GLfloat, GLfloat, GLfloat, GLfloat, GLfloat, GLfloat, GLfloat, GLfloat),void);
value glstub_glColor4fNormal3fVertex3fSUN(value v0, value v1, value v2, value v3, value v4, value v5, value v6, value v7, value v8, value v9)
{
	CAMLparam5(v0, v1, v2, v3, v4);
	CAMLxparam5(v5, v6, v7, v8, v9);
	GLfloat lv0 = Double_val(v0);
	GLfloat lv1 = Double_val(v1);
	GLfloat lv2 = Double_val(v2);
	GLfloat lv3 = Double_val(v3);
	GLfloat lv4 = Double_val(v4);
	GLfloat lv5 = Double_val(v5);
	GLfloat lv6 = Double_val(v6);
	GLfloat lv7 = Double_val(v7);
	GLfloat lv8 = Double_val(v8);
	GLfloat lv9 = Double_val(v9);
	LOAD_FUNCTION(glColor4fNormal3fVertex3fSUN);
	(*stub_glColor4fNormal3fVertex3fSUN)(lv0, lv1, lv2, lv3, lv4, lv5, lv6, lv7, lv8, lv9);
	CAMLreturn(Val_unit);
}

value glstub_glColor4fNormal3fVertex3fSUN_byte(value * argv, int n)
{
	return glstub_glColor4fNormal3fVertex3fSUN(argv[0], argv[1], argv[2], argv[3], argv[4], argv[5], argv[6], argv[7], argv[8], argv[9]);
}

DECLARE_FUNCTION(glColor4fNormal3fVertex3fvSUN,(GLfloat*, GLfloat*, GLfloat*),void);
value glstub_glColor4fNormal3fVertex3fvSUN(value v0, value v1, value v2)
{
	CAMLparam3(v0, v1, v2);
	GLfloat* lv0 = Data_bigarray_val(v0);
	GLfloat* lv1 = Data_bigarray_val(v1);
	GLfloat* lv2 = Data_bigarray_val(v2);
	LOAD_FUNCTION(glColor4fNormal3fVertex3fvSUN);
	(*stub_glColor4fNormal3fVertex3fvSUN)(lv0, lv1, lv2);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glColor4fv,(GLfloat*),void);
value glstub_glColor4fv(value v0)
{
	CAMLparam1(v0);
	GLfloat* lv0 = Data_bigarray_val(v0);
	LOAD_FUNCTION(glColor4fv);
	(*stub_glColor4fv)(lv0);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glColor4hNV,(GLushort, GLushort, GLushort, GLushort),void);
value glstub_glColor4hNV(value v0, value v1, value v2, value v3)
{
	CAMLparam4(v0, v1, v2, v3);
	GLushort lv0 = Int_val(v0);
	GLushort lv1 = Int_val(v1);
	GLushort lv2 = Int_val(v2);
	GLushort lv3 = Int_val(v3);
	LOAD_FUNCTION(glColor4hNV);
	(*stub_glColor4hNV)(lv0, lv1, lv2, lv3);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glColor4hvNV,(GLushort*),void);
value glstub_glColor4hvNV(value v0)
{
	CAMLparam1(v0);
	GLushort* lv0 = Data_bigarray_val(v0);
	LOAD_FUNCTION(glColor4hvNV);
	(*stub_glColor4hvNV)(lv0);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glColor4i,(GLint, GLint, GLint, GLint),void);
value glstub_glColor4i(value v0, value v1, value v2, value v3)
{
	CAMLparam4(v0, v1, v2, v3);
	GLint lv0 = Int_val(v0);
	GLint lv1 = Int_val(v1);
	GLint lv2 = Int_val(v2);
	GLint lv3 = Int_val(v3);
	LOAD_FUNCTION(glColor4i);
	(*stub_glColor4i)(lv0, lv1, lv2, lv3);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glColor4iv,(GLint*),void);
value glstub_glColor4iv(value v0)
{
	CAMLparam1(v0);
	GLint* lv0 = Data_bigarray_val(v0);
	LOAD_FUNCTION(glColor4iv);
	(*stub_glColor4iv)(lv0);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glColor4s,(GLshort, GLshort, GLshort, GLshort),void);
value glstub_glColor4s(value v0, value v1, value v2, value v3)
{
	CAMLparam4(v0, v1, v2, v3);
	GLshort lv0 = Int_val(v0);
	GLshort lv1 = Int_val(v1);
	GLshort lv2 = Int_val(v2);
	GLshort lv3 = Int_val(v3);
	LOAD_FUNCTION(glColor4s);
	(*stub_glColor4s)(lv0, lv1, lv2, lv3);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glColor4sv,(GLshort*),void);
value glstub_glColor4sv(value v0)
{
	CAMLparam1(v0);
	GLshort* lv0 = Data_bigarray_val(v0);
	LOAD_FUNCTION(glColor4sv);
	(*stub_glColor4sv)(lv0);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glColor4ub,(GLubyte, GLubyte, GLubyte, GLubyte),void);
value glstub_glColor4ub(value v0, value v1, value v2, value v3)
{
	CAMLparam4(v0, v1, v2, v3);
	GLubyte lv0 = Int_val(v0);
	GLubyte lv1 = Int_val(v1);
	GLubyte lv2 = Int_val(v2);
	GLubyte lv3 = Int_val(v3);
	LOAD_FUNCTION(glColor4ub);
	(*stub_glColor4ub)(lv0, lv1, lv2, lv3);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glColor4ubVertex2fSUN,(GLubyte, GLubyte, GLubyte, GLubyte, GLfloat, GLfloat),void);
value glstub_glColor4ubVertex2fSUN(value v0, value v1, value v2, value v3, value v4, value v5)
{
	CAMLparam5(v0, v1, v2, v3, v4);
	CAMLxparam1(v5);
	GLubyte lv0 = Int_val(v0);
	GLubyte lv1 = Int_val(v1);
	GLubyte lv2 = Int_val(v2);
	GLubyte lv3 = Int_val(v3);
	GLfloat lv4 = Double_val(v4);
	GLfloat lv5 = Double_val(v5);
	LOAD_FUNCTION(glColor4ubVertex2fSUN);
	(*stub_glColor4ubVertex2fSUN)(lv0, lv1, lv2, lv3, lv4, lv5);
	CAMLreturn(Val_unit);
}

value glstub_glColor4ubVertex2fSUN_byte(value * argv, int n)
{
	return glstub_glColor4ubVertex2fSUN(argv[0], argv[1], argv[2], argv[3], argv[4], argv[5]);
}

DECLARE_FUNCTION(glColor4ubVertex2fvSUN,(GLubyte*, GLfloat*),void);
value glstub_glColor4ubVertex2fvSUN(value v0, value v1)
{
	CAMLparam2(v0, v1);
	GLubyte* lv0 = Data_bigarray_val(v0);
	GLfloat* lv1 = Data_bigarray_val(v1);
	LOAD_FUNCTION(glColor4ubVertex2fvSUN);
	(*stub_glColor4ubVertex2fvSUN)(lv0, lv1);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glColor4ubVertex3fSUN,(GLubyte, GLubyte, GLubyte, GLubyte, GLfloat, GLfloat, GLfloat),void);
value glstub_glColor4ubVertex3fSUN(value v0, value v1, value v2, value v3, value v4, value v5, value v6)
{
	CAMLparam5(v0, v1, v2, v3, v4);
	CAMLxparam2(v5, v6);
	GLubyte lv0 = Int_val(v0);
	GLubyte lv1 = Int_val(v1);
	GLubyte lv2 = Int_val(v2);
	GLubyte lv3 = Int_val(v3);
	GLfloat lv4 = Double_val(v4);
	GLfloat lv5 = Double_val(v5);
	GLfloat lv6 = Double_val(v6);
	LOAD_FUNCTION(glColor4ubVertex3fSUN);
	(*stub_glColor4ubVertex3fSUN)(lv0, lv1, lv2, lv3, lv4, lv5, lv6);
	CAMLreturn(Val_unit);
}

value glstub_glColor4ubVertex3fSUN_byte(value * argv, int n)
{
	return glstub_glColor4ubVertex3fSUN(argv[0], argv[1], argv[2], argv[3], argv[4], argv[5], argv[6]);
}

DECLARE_FUNCTION(glColor4ubVertex3fvSUN,(GLubyte*, GLfloat*),void);
value glstub_glColor4ubVertex3fvSUN(value v0, value v1)
{
	CAMLparam2(v0, v1);
	GLubyte* lv0 = Data_bigarray_val(v0);
	GLfloat* lv1 = Data_bigarray_val(v1);
	LOAD_FUNCTION(glColor4ubVertex3fvSUN);
	(*stub_glColor4ubVertex3fvSUN)(lv0, lv1);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glColor4ubv,(GLubyte*),void);
value glstub_glColor4ubv(value v0)
{
	CAMLparam1(v0);
	GLubyte* lv0 = Data_bigarray_val(v0);
	LOAD_FUNCTION(glColor4ubv);
	(*stub_glColor4ubv)(lv0);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glColor4ui,(GLuint, GLuint, GLuint, GLuint),void);
value glstub_glColor4ui(value v0, value v1, value v2, value v3)
{
	CAMLparam4(v0, v1, v2, v3);
	GLuint lv0 = Int_val(v0);
	GLuint lv1 = Int_val(v1);
	GLuint lv2 = Int_val(v2);
	GLuint lv3 = Int_val(v3);
	LOAD_FUNCTION(glColor4ui);
	(*stub_glColor4ui)(lv0, lv1, lv2, lv3);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glColor4uiv,(GLuint*),void);
value glstub_glColor4uiv(value v0)
{
	CAMLparam1(v0);
	GLuint* lv0 = Data_bigarray_val(v0);
	LOAD_FUNCTION(glColor4uiv);
	(*stub_glColor4uiv)(lv0);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glColor4us,(GLushort, GLushort, GLushort, GLushort),void);
value glstub_glColor4us(value v0, value v1, value v2, value v3)
{
	CAMLparam4(v0, v1, v2, v3);
	GLushort lv0 = Int_val(v0);
	GLushort lv1 = Int_val(v1);
	GLushort lv2 = Int_val(v2);
	GLushort lv3 = Int_val(v3);
	LOAD_FUNCTION(glColor4us);
	(*stub_glColor4us)(lv0, lv1, lv2, lv3);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glColor4usv,(GLushort*),void);
value glstub_glColor4usv(value v0)
{
	CAMLparam1(v0);
	GLushort* lv0 = Data_bigarray_val(v0);
	LOAD_FUNCTION(glColor4usv);
	(*stub_glColor4usv)(lv0);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glColorFragmentOp1ATI,(GLenum, GLuint, GLuint, GLuint, GLuint, GLuint, GLuint),void);
value glstub_glColorFragmentOp1ATI(value v0, value v1, value v2, value v3, value v4, value v5, value v6)
{
	CAMLparam5(v0, v1, v2, v3, v4);
	CAMLxparam2(v5, v6);
	GLenum lv0 = Int_val(v0);
	GLuint lv1 = Int_val(v1);
	GLuint lv2 = Int_val(v2);
	GLuint lv3 = Int_val(v3);
	GLuint lv4 = Int_val(v4);
	GLuint lv5 = Int_val(v5);
	GLuint lv6 = Int_val(v6);
	LOAD_FUNCTION(glColorFragmentOp1ATI);
	(*stub_glColorFragmentOp1ATI)(lv0, lv1, lv2, lv3, lv4, lv5, lv6);
	CAMLreturn(Val_unit);
}

value glstub_glColorFragmentOp1ATI_byte(value * argv, int n)
{
	return glstub_glColorFragmentOp1ATI(argv[0], argv[1], argv[2], argv[3], argv[4], argv[5], argv[6]);
}

DECLARE_FUNCTION(glColorFragmentOp2ATI,(GLenum, GLuint, GLuint, GLuint, GLuint, GLuint, GLuint, GLuint, GLuint, GLuint),void);
value glstub_glColorFragmentOp2ATI(value v0, value v1, value v2, value v3, value v4, value v5, value v6, value v7, value v8, value v9)
{
	CAMLparam5(v0, v1, v2, v3, v4);
	CAMLxparam5(v5, v6, v7, v8, v9);
	GLenum lv0 = Int_val(v0);
	GLuint lv1 = Int_val(v1);
	GLuint lv2 = Int_val(v2);
	GLuint lv3 = Int_val(v3);
	GLuint lv4 = Int_val(v4);
	GLuint lv5 = Int_val(v5);
	GLuint lv6 = Int_val(v6);
	GLuint lv7 = Int_val(v7);
	GLuint lv8 = Int_val(v8);
	GLuint lv9 = Int_val(v9);
	LOAD_FUNCTION(glColorFragmentOp2ATI);
	(*stub_glColorFragmentOp2ATI)(lv0, lv1, lv2, lv3, lv4, lv5, lv6, lv7, lv8, lv9);
	CAMLreturn(Val_unit);
}

value glstub_glColorFragmentOp2ATI_byte(value * argv, int n)
{
	return glstub_glColorFragmentOp2ATI(argv[0], argv[1], argv[2], argv[3], argv[4], argv[5], argv[6], argv[7], argv[8], argv[9]);
}

DECLARE_FUNCTION(glColorFragmentOp3ATI,(GLenum, GLuint, GLuint, GLuint, GLuint, GLuint, GLuint, GLuint, GLuint, GLuint, GLuint, GLuint, GLuint),void);
value glstub_glColorFragmentOp3ATI(value v0, value v1, value v2, value v3, value v4, value v5, value v6, value v7, value v8, value v9, value v10, value v11, value v12)
{
	CAMLparam5(v0, v1, v2, v3, v4);
	CAMLxparam5(v5, v6, v7, v8, v9);
	CAMLxparam3(v10, v11, v12);
	GLenum lv0 = Int_val(v0);
	GLuint lv1 = Int_val(v1);
	GLuint lv2 = Int_val(v2);
	GLuint lv3 = Int_val(v3);
	GLuint lv4 = Int_val(v4);
	GLuint lv5 = Int_val(v5);
	GLuint lv6 = Int_val(v6);
	GLuint lv7 = Int_val(v7);
	GLuint lv8 = Int_val(v8);
	GLuint lv9 = Int_val(v9);
	GLuint lv10 = Int_val(v10);
	GLuint lv11 = Int_val(v11);
	GLuint lv12 = Int_val(v12);
	LOAD_FUNCTION(glColorFragmentOp3ATI);
	(*stub_glColorFragmentOp3ATI)(lv0, lv1, lv2, lv3, lv4, lv5, lv6, lv7, lv8, lv9, lv10, lv11, lv12);
	CAMLreturn(Val_unit);
}

value glstub_glColorFragmentOp3ATI_byte(value * argv, int n)
{
	return glstub_glColorFragmentOp3ATI(argv[0], argv[1], argv[2], argv[3], argv[4], argv[5], argv[6], argv[7], argv[8], argv[9], argv[10], argv[11], argv[12]);
}

DECLARE_FUNCTION(glColorMask,(GLboolean, GLboolean, GLboolean, GLboolean),void);
value glstub_glColorMask(value v0, value v1, value v2, value v3)
{
	CAMLparam4(v0, v1, v2, v3);
	GLboolean lv0 = Bool_val(v0);
	GLboolean lv1 = Bool_val(v1);
	GLboolean lv2 = Bool_val(v2);
	GLboolean lv3 = Bool_val(v3);
	LOAD_FUNCTION(glColorMask);
	(*stub_glColorMask)(lv0, lv1, lv2, lv3);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glColorMaskIndexedEXT,(GLuint, GLboolean, GLboolean, GLboolean, GLboolean),void);
value glstub_glColorMaskIndexedEXT(value v0, value v1, value v2, value v3, value v4)
{
	CAMLparam5(v0, v1, v2, v3, v4);
	GLuint lv0 = Int_val(v0);
	GLboolean lv1 = Bool_val(v1);
	GLboolean lv2 = Bool_val(v2);
	GLboolean lv3 = Bool_val(v3);
	GLboolean lv4 = Bool_val(v4);
	LOAD_FUNCTION(glColorMaskIndexedEXT);
	(*stub_glColorMaskIndexedEXT)(lv0, lv1, lv2, lv3, lv4);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glColorMaterial,(GLenum, GLenum),void);
value glstub_glColorMaterial(value v0, value v1)
{
	CAMLparam2(v0, v1);
	GLenum lv0 = Int_val(v0);
	GLenum lv1 = Int_val(v1);
	LOAD_FUNCTION(glColorMaterial);
	(*stub_glColorMaterial)(lv0, lv1);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glColorPointer,(GLint, GLenum, GLsizei, GLvoid*),void);
value glstub_glColorPointer(value v0, value v1, value v2, value v3)
{
	CAMLparam4(v0, v1, v2, v3);
	GLint lv0 = Int_val(v0);
	GLenum lv1 = Int_val(v1);
	GLsizei lv2 = Int_val(v2);
	GLvoid* lv3 = (GLvoid *)((Tag_val(v3) == String_tag)? (String_val(v3)) : (Data_bigarray_val(v3)));
	LOAD_FUNCTION(glColorPointer);
	(*stub_glColorPointer)(lv0, lv1, lv2, lv3);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glColorPointerEXT,(GLint, GLenum, GLsizei, GLsizei, GLvoid*),void);
value glstub_glColorPointerEXT(value v0, value v1, value v2, value v3, value v4)
{
	CAMLparam5(v0, v1, v2, v3, v4);
	GLint lv0 = Int_val(v0);
	GLenum lv1 = Int_val(v1);
	GLsizei lv2 = Int_val(v2);
	GLsizei lv3 = Int_val(v3);
	GLvoid* lv4 = (GLvoid *)((Tag_val(v4) == String_tag)? (String_val(v4)) : (Data_bigarray_val(v4)));
	LOAD_FUNCTION(glColorPointerEXT);
	(*stub_glColorPointerEXT)(lv0, lv1, lv2, lv3, lv4);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glColorPointerListIBM,(GLint, GLenum, GLint, GLvoid**, GLint),void);
value glstub_glColorPointerListIBM(value v0, value v1, value v2, value v3, value v4)
{
	CAMLparam5(v0, v1, v2, v3, v4);
	GLint lv0 = Int_val(v0);
	GLenum lv1 = Int_val(v1);
	GLint lv2 = Int_val(v2);
	GLvoid** lv3 = Data_bigarray_val(v3);
	GLint lv4 = Int_val(v4);
	LOAD_FUNCTION(glColorPointerListIBM);
	(*stub_glColorPointerListIBM)(lv0, lv1, lv2, lv3, lv4);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glColorPointervINTEL,(GLint, GLenum, GLvoid**),void);
value glstub_glColorPointervINTEL(value v0, value v1, value v2)
{
	CAMLparam3(v0, v1, v2);
	GLint lv0 = Int_val(v0);
	GLenum lv1 = Int_val(v1);
	GLvoid** lv2 = Data_bigarray_val(v2);
	LOAD_FUNCTION(glColorPointervINTEL);
	(*stub_glColorPointervINTEL)(lv0, lv1, lv2);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glColorSubTable,(GLenum, GLsizei, GLsizei, GLenum, GLenum, GLvoid*),void);
value glstub_glColorSubTable(value v0, value v1, value v2, value v3, value v4, value v5)
{
	CAMLparam5(v0, v1, v2, v3, v4);
	CAMLxparam1(v5);
	GLenum lv0 = Int_val(v0);
	GLsizei lv1 = Int_val(v1);
	GLsizei lv2 = Int_val(v2);
	GLenum lv3 = Int_val(v3);
	GLenum lv4 = Int_val(v4);
	GLvoid* lv5 = (GLvoid *)((Tag_val(v5) == String_tag)? (String_val(v5)) : (Data_bigarray_val(v5)));
	LOAD_FUNCTION(glColorSubTable);
	(*stub_glColorSubTable)(lv0, lv1, lv2, lv3, lv4, lv5);
	CAMLreturn(Val_unit);
}

value glstub_glColorSubTable_byte(value * argv, int n)
{
	return glstub_glColorSubTable(argv[0], argv[1], argv[2], argv[3], argv[4], argv[5]);
}

DECLARE_FUNCTION(glColorSubTableEXT,(GLenum, GLsizei, GLsizei, GLenum, GLenum, GLvoid*),void);
value glstub_glColorSubTableEXT(value v0, value v1, value v2, value v3, value v4, value v5)
{
	CAMLparam5(v0, v1, v2, v3, v4);
	CAMLxparam1(v5);
	GLenum lv0 = Int_val(v0);
	GLsizei lv1 = Int_val(v1);
	GLsizei lv2 = Int_val(v2);
	GLenum lv3 = Int_val(v3);
	GLenum lv4 = Int_val(v4);
	GLvoid* lv5 = (GLvoid *)((Tag_val(v5) == String_tag)? (String_val(v5)) : (Data_bigarray_val(v5)));
	LOAD_FUNCTION(glColorSubTableEXT);
	(*stub_glColorSubTableEXT)(lv0, lv1, lv2, lv3, lv4, lv5);
	CAMLreturn(Val_unit);
}

value glstub_glColorSubTableEXT_byte(value * argv, int n)
{
	return glstub_glColorSubTableEXT(argv[0], argv[1], argv[2], argv[3], argv[4], argv[5]);
}

DECLARE_FUNCTION(glColorTable,(GLenum, GLenum, GLsizei, GLenum, GLenum, GLvoid*),void);
value glstub_glColorTable(value v0, value v1, value v2, value v3, value v4, value v5)
{
	CAMLparam5(v0, v1, v2, v3, v4);
	CAMLxparam1(v5);
	GLenum lv0 = Int_val(v0);
	GLenum lv1 = Int_val(v1);
	GLsizei lv2 = Int_val(v2);
	GLenum lv3 = Int_val(v3);
	GLenum lv4 = Int_val(v4);
	GLvoid* lv5 = (GLvoid *)((Tag_val(v5) == String_tag)? (String_val(v5)) : (Data_bigarray_val(v5)));
	LOAD_FUNCTION(glColorTable);
	(*stub_glColorTable)(lv0, lv1, lv2, lv3, lv4, lv5);
	CAMLreturn(Val_unit);
}

value glstub_glColorTable_byte(value * argv, int n)
{
	return glstub_glColorTable(argv[0], argv[1], argv[2], argv[3], argv[4], argv[5]);
}

DECLARE_FUNCTION(glColorTableEXT,(GLenum, GLenum, GLsizei, GLenum, GLenum, GLvoid*),void);
value glstub_glColorTableEXT(value v0, value v1, value v2, value v3, value v4, value v5)
{
	CAMLparam5(v0, v1, v2, v3, v4);
	CAMLxparam1(v5);
	GLenum lv0 = Int_val(v0);
	GLenum lv1 = Int_val(v1);
	GLsizei lv2 = Int_val(v2);
	GLenum lv3 = Int_val(v3);
	GLenum lv4 = Int_val(v4);
	GLvoid* lv5 = (GLvoid *)((Tag_val(v5) == String_tag)? (String_val(v5)) : (Data_bigarray_val(v5)));
	LOAD_FUNCTION(glColorTableEXT);
	(*stub_glColorTableEXT)(lv0, lv1, lv2, lv3, lv4, lv5);
	CAMLreturn(Val_unit);
}

value glstub_glColorTableEXT_byte(value * argv, int n)
{
	return glstub_glColorTableEXT(argv[0], argv[1], argv[2], argv[3], argv[4], argv[5]);
}

DECLARE_FUNCTION(glColorTableParameterfv,(GLenum, GLenum, GLfloat*),void);
value glstub_glColorTableParameterfv(value v0, value v1, value v2)
{
	CAMLparam3(v0, v1, v2);
	GLenum lv0 = Int_val(v0);
	GLenum lv1 = Int_val(v1);
	GLfloat* lv2 = Data_bigarray_val(v2);
	LOAD_FUNCTION(glColorTableParameterfv);
	(*stub_glColorTableParameterfv)(lv0, lv1, lv2);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glColorTableParameterfvSGI,(GLenum, GLenum, GLfloat*),void);
value glstub_glColorTableParameterfvSGI(value v0, value v1, value v2)
{
	CAMLparam3(v0, v1, v2);
	GLenum lv0 = Int_val(v0);
	GLenum lv1 = Int_val(v1);
	GLfloat* lv2 = Data_bigarray_val(v2);
	LOAD_FUNCTION(glColorTableParameterfvSGI);
	(*stub_glColorTableParameterfvSGI)(lv0, lv1, lv2);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glColorTableParameteriv,(GLenum, GLenum, GLint*),void);
value glstub_glColorTableParameteriv(value v0, value v1, value v2)
{
	CAMLparam3(v0, v1, v2);
	GLenum lv0 = Int_val(v0);
	GLenum lv1 = Int_val(v1);
	GLint* lv2 = Data_bigarray_val(v2);
	LOAD_FUNCTION(glColorTableParameteriv);
	(*stub_glColorTableParameteriv)(lv0, lv1, lv2);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glColorTableParameterivSGI,(GLenum, GLenum, GLint*),void);
value glstub_glColorTableParameterivSGI(value v0, value v1, value v2)
{
	CAMLparam3(v0, v1, v2);
	GLenum lv0 = Int_val(v0);
	GLenum lv1 = Int_val(v1);
	GLint* lv2 = Data_bigarray_val(v2);
	LOAD_FUNCTION(glColorTableParameterivSGI);
	(*stub_glColorTableParameterivSGI)(lv0, lv1, lv2);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glColorTableSGI,(GLenum, GLenum, GLsizei, GLenum, GLenum, GLvoid*),void);
value glstub_glColorTableSGI(value v0, value v1, value v2, value v3, value v4, value v5)
{
	CAMLparam5(v0, v1, v2, v3, v4);
	CAMLxparam1(v5);
	GLenum lv0 = Int_val(v0);
	GLenum lv1 = Int_val(v1);
	GLsizei lv2 = Int_val(v2);
	GLenum lv3 = Int_val(v3);
	GLenum lv4 = Int_val(v4);
	GLvoid* lv5 = (GLvoid *)((Tag_val(v5) == String_tag)? (String_val(v5)) : (Data_bigarray_val(v5)));
	LOAD_FUNCTION(glColorTableSGI);
	(*stub_glColorTableSGI)(lv0, lv1, lv2, lv3, lv4, lv5);
	CAMLreturn(Val_unit);
}

value glstub_glColorTableSGI_byte(value * argv, int n)
{
	return glstub_glColorTableSGI(argv[0], argv[1], argv[2], argv[3], argv[4], argv[5]);
}

DECLARE_FUNCTION(glCombinerInputNV,(GLenum, GLenum, GLenum, GLenum, GLenum, GLenum),void);
value glstub_glCombinerInputNV(value v0, value v1, value v2, value v3, value v4, value v5)
{
	CAMLparam5(v0, v1, v2, v3, v4);
	CAMLxparam1(v5);
	GLenum lv0 = Int_val(v0);
	GLenum lv1 = Int_val(v1);
	GLenum lv2 = Int_val(v2);
	GLenum lv3 = Int_val(v3);
	GLenum lv4 = Int_val(v4);
	GLenum lv5 = Int_val(v5);
	LOAD_FUNCTION(glCombinerInputNV);
	(*stub_glCombinerInputNV)(lv0, lv1, lv2, lv3, lv4, lv5);
	CAMLreturn(Val_unit);
}

value glstub_glCombinerInputNV_byte(value * argv, int n)
{
	return glstub_glCombinerInputNV(argv[0], argv[1], argv[2], argv[3], argv[4], argv[5]);
}

DECLARE_FUNCTION(glCombinerOutputNV,(GLenum, GLenum, GLenum, GLenum, GLenum, GLenum, GLenum, GLboolean, GLboolean, GLboolean),void);
value glstub_glCombinerOutputNV(value v0, value v1, value v2, value v3, value v4, value v5, value v6, value v7, value v8, value v9)
{
	CAMLparam5(v0, v1, v2, v3, v4);
	CAMLxparam5(v5, v6, v7, v8, v9);
	GLenum lv0 = Int_val(v0);
	GLenum lv1 = Int_val(v1);
	GLenum lv2 = Int_val(v2);
	GLenum lv3 = Int_val(v3);
	GLenum lv4 = Int_val(v4);
	GLenum lv5 = Int_val(v5);
	GLenum lv6 = Int_val(v6);
	GLboolean lv7 = Bool_val(v7);
	GLboolean lv8 = Bool_val(v8);
	GLboolean lv9 = Bool_val(v9);
	LOAD_FUNCTION(glCombinerOutputNV);
	(*stub_glCombinerOutputNV)(lv0, lv1, lv2, lv3, lv4, lv5, lv6, lv7, lv8, lv9);
	CAMLreturn(Val_unit);
}

value glstub_glCombinerOutputNV_byte(value * argv, int n)
{
	return glstub_glCombinerOutputNV(argv[0], argv[1], argv[2], argv[3], argv[4], argv[5], argv[6], argv[7], argv[8], argv[9]);
}

DECLARE_FUNCTION(glCombinerParameterfNV,(GLenum, GLfloat),void);
value glstub_glCombinerParameterfNV(value v0, value v1)
{
	CAMLparam2(v0, v1);
	GLenum lv0 = Int_val(v0);
	GLfloat lv1 = Double_val(v1);
	LOAD_FUNCTION(glCombinerParameterfNV);
	(*stub_glCombinerParameterfNV)(lv0, lv1);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glCombinerParameterfvNV,(GLenum, GLfloat*),void);
value glstub_glCombinerParameterfvNV(value v0, value v1)
{
	CAMLparam2(v0, v1);
	GLenum lv0 = Int_val(v0);
	GLfloat* lv1 = Data_bigarray_val(v1);
	LOAD_FUNCTION(glCombinerParameterfvNV);
	(*stub_glCombinerParameterfvNV)(lv0, lv1);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glCombinerParameteriNV,(GLenum, GLint),void);
value glstub_glCombinerParameteriNV(value v0, value v1)
{
	CAMLparam2(v0, v1);
	GLenum lv0 = Int_val(v0);
	GLint lv1 = Int_val(v1);
	LOAD_FUNCTION(glCombinerParameteriNV);
	(*stub_glCombinerParameteriNV)(lv0, lv1);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glCombinerParameterivNV,(GLenum, GLint*),void);
value glstub_glCombinerParameterivNV(value v0, value v1)
{
	CAMLparam2(v0, v1);
	GLenum lv0 = Int_val(v0);
	GLint* lv1 = Data_bigarray_val(v1);
	LOAD_FUNCTION(glCombinerParameterivNV);
	(*stub_glCombinerParameterivNV)(lv0, lv1);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glCombinerStageParameterfvNV,(GLenum, GLenum, GLfloat*),void);
value glstub_glCombinerStageParameterfvNV(value v0, value v1, value v2)
{
	CAMLparam3(v0, v1, v2);
	GLenum lv0 = Int_val(v0);
	GLenum lv1 = Int_val(v1);
	GLfloat* lv2 = Data_bigarray_val(v2);
	LOAD_FUNCTION(glCombinerStageParameterfvNV);
	(*stub_glCombinerStageParameterfvNV)(lv0, lv1, lv2);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glCompileShader,(GLuint),void);
value glstub_glCompileShader(value v0)
{
	CAMLparam1(v0);
	GLuint lv0 = Int_val(v0);
	LOAD_FUNCTION(glCompileShader);
	(*stub_glCompileShader)(lv0);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glCompileShaderARB,(GLuint),void);
value glstub_glCompileShaderARB(value v0)
{
	CAMLparam1(v0);
	GLuint lv0 = Int_val(v0);
	LOAD_FUNCTION(glCompileShaderARB);
	(*stub_glCompileShaderARB)(lv0);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glCompressedTexImage1D,(GLenum, GLint, GLenum, GLsizei, GLint, GLsizei, GLvoid*),void);
value glstub_glCompressedTexImage1D(value v0, value v1, value v2, value v3, value v4, value v5, value v6)
{
	CAMLparam5(v0, v1, v2, v3, v4);
	CAMLxparam2(v5, v6);
	GLenum lv0 = Int_val(v0);
	GLint lv1 = Int_val(v1);
	GLenum lv2 = Int_val(v2);
	GLsizei lv3 = Int_val(v3);
	GLint lv4 = Int_val(v4);
	GLsizei lv5 = Int_val(v5);
	GLvoid* lv6 = (GLvoid *)((Tag_val(v6) == String_tag)? (String_val(v6)) : (Data_bigarray_val(v6)));
	LOAD_FUNCTION(glCompressedTexImage1D);
	(*stub_glCompressedTexImage1D)(lv0, lv1, lv2, lv3, lv4, lv5, lv6);
	CAMLreturn(Val_unit);
}

value glstub_glCompressedTexImage1D_byte(value * argv, int n)
{
	return glstub_glCompressedTexImage1D(argv[0], argv[1], argv[2], argv[3], argv[4], argv[5], argv[6]);
}

DECLARE_FUNCTION(glCompressedTexImage1DARB,(GLenum, GLint, GLenum, GLsizei, GLint, GLsizei, GLvoid*),void);
value glstub_glCompressedTexImage1DARB(value v0, value v1, value v2, value v3, value v4, value v5, value v6)
{
	CAMLparam5(v0, v1, v2, v3, v4);
	CAMLxparam2(v5, v6);
	GLenum lv0 = Int_val(v0);
	GLint lv1 = Int_val(v1);
	GLenum lv2 = Int_val(v2);
	GLsizei lv3 = Int_val(v3);
	GLint lv4 = Int_val(v4);
	GLsizei lv5 = Int_val(v5);
	GLvoid* lv6 = (GLvoid *)((Tag_val(v6) == String_tag)? (String_val(v6)) : (Data_bigarray_val(v6)));
	LOAD_FUNCTION(glCompressedTexImage1DARB);
	(*stub_glCompressedTexImage1DARB)(lv0, lv1, lv2, lv3, lv4, lv5, lv6);
	CAMLreturn(Val_unit);
}

value glstub_glCompressedTexImage1DARB_byte(value * argv, int n)
{
	return glstub_glCompressedTexImage1DARB(argv[0], argv[1], argv[2], argv[3], argv[4], argv[5], argv[6]);
}

DECLARE_FUNCTION(glCompressedTexImage2D,(GLenum, GLint, GLenum, GLsizei, GLsizei, GLint, GLsizei, GLvoid*),void);
value glstub_glCompressedTexImage2D(value v0, value v1, value v2, value v3, value v4, value v5, value v6, value v7)
{
	CAMLparam5(v0, v1, v2, v3, v4);
	CAMLxparam3(v5, v6, v7);
	GLenum lv0 = Int_val(v0);
	GLint lv1 = Int_val(v1);
	GLenum lv2 = Int_val(v2);
	GLsizei lv3 = Int_val(v3);
	GLsizei lv4 = Int_val(v4);
	GLint lv5 = Int_val(v5);
	GLsizei lv6 = Int_val(v6);
	GLvoid* lv7 = (GLvoid *)((Tag_val(v7) == String_tag)? (String_val(v7)) : (Data_bigarray_val(v7)));
	LOAD_FUNCTION(glCompressedTexImage2D);
	(*stub_glCompressedTexImage2D)(lv0, lv1, lv2, lv3, lv4, lv5, lv6, lv7);
	CAMLreturn(Val_unit);
}

value glstub_glCompressedTexImage2D_byte(value * argv, int n)
{
	return glstub_glCompressedTexImage2D(argv[0], argv[1], argv[2], argv[3], argv[4], argv[5], argv[6], argv[7]);
}

DECLARE_FUNCTION(glCompressedTexImage2DARB,(GLenum, GLint, GLenum, GLsizei, GLsizei, GLint, GLsizei, GLvoid*),void);
value glstub_glCompressedTexImage2DARB(value v0, value v1, value v2, value v3, value v4, value v5, value v6, value v7)
{
	CAMLparam5(v0, v1, v2, v3, v4);
	CAMLxparam3(v5, v6, v7);
	GLenum lv0 = Int_val(v0);
	GLint lv1 = Int_val(v1);
	GLenum lv2 = Int_val(v2);
	GLsizei lv3 = Int_val(v3);
	GLsizei lv4 = Int_val(v4);
	GLint lv5 = Int_val(v5);
	GLsizei lv6 = Int_val(v6);
	GLvoid* lv7 = (GLvoid *)((Tag_val(v7) == String_tag)? (String_val(v7)) : (Data_bigarray_val(v7)));
	LOAD_FUNCTION(glCompressedTexImage2DARB);
	(*stub_glCompressedTexImage2DARB)(lv0, lv1, lv2, lv3, lv4, lv5, lv6, lv7);
	CAMLreturn(Val_unit);
}

value glstub_glCompressedTexImage2DARB_byte(value * argv, int n)
{
	return glstub_glCompressedTexImage2DARB(argv[0], argv[1], argv[2], argv[3], argv[4], argv[5], argv[6], argv[7]);
}

DECLARE_FUNCTION(glCompressedTexImage3D,(GLenum, GLint, GLenum, GLsizei, GLsizei, GLsizei, GLint, GLsizei, GLvoid*),void);
value glstub_glCompressedTexImage3D(value v0, value v1, value v2, value v3, value v4, value v5, value v6, value v7, value v8)
{
	CAMLparam5(v0, v1, v2, v3, v4);
	CAMLxparam4(v5, v6, v7, v8);
	GLenum lv0 = Int_val(v0);
	GLint lv1 = Int_val(v1);
	GLenum lv2 = Int_val(v2);
	GLsizei lv3 = Int_val(v3);
	GLsizei lv4 = Int_val(v4);
	GLsizei lv5 = Int_val(v5);
	GLint lv6 = Int_val(v6);
	GLsizei lv7 = Int_val(v7);
	GLvoid* lv8 = (GLvoid *)((Tag_val(v8) == String_tag)? (String_val(v8)) : (Data_bigarray_val(v8)));
	LOAD_FUNCTION(glCompressedTexImage3D);
	(*stub_glCompressedTexImage3D)(lv0, lv1, lv2, lv3, lv4, lv5, lv6, lv7, lv8);
	CAMLreturn(Val_unit);
}

value glstub_glCompressedTexImage3D_byte(value * argv, int n)
{
	return glstub_glCompressedTexImage3D(argv[0], argv[1], argv[2], argv[3], argv[4], argv[5], argv[6], argv[7], argv[8]);
}

DECLARE_FUNCTION(glCompressedTexImage3DARB,(GLenum, GLint, GLenum, GLsizei, GLsizei, GLsizei, GLint, GLsizei, GLvoid*),void);
value glstub_glCompressedTexImage3DARB(value v0, value v1, value v2, value v3, value v4, value v5, value v6, value v7, value v8)
{
	CAMLparam5(v0, v1, v2, v3, v4);
	CAMLxparam4(v5, v6, v7, v8);
	GLenum lv0 = Int_val(v0);
	GLint lv1 = Int_val(v1);
	GLenum lv2 = Int_val(v2);
	GLsizei lv3 = Int_val(v3);
	GLsizei lv4 = Int_val(v4);
	GLsizei lv5 = Int_val(v5);
	GLint lv6 = Int_val(v6);
	GLsizei lv7 = Int_val(v7);
	GLvoid* lv8 = (GLvoid *)((Tag_val(v8) == String_tag)? (String_val(v8)) : (Data_bigarray_val(v8)));
	LOAD_FUNCTION(glCompressedTexImage3DARB);
	(*stub_glCompressedTexImage3DARB)(lv0, lv1, lv2, lv3, lv4, lv5, lv6, lv7, lv8);
	CAMLreturn(Val_unit);
}

value glstub_glCompressedTexImage3DARB_byte(value * argv, int n)
{
	return glstub_glCompressedTexImage3DARB(argv[0], argv[1], argv[2], argv[3], argv[4], argv[5], argv[6], argv[7], argv[8]);
}

DECLARE_FUNCTION(glCompressedTexSubImage1D,(GLenum, GLint, GLint, GLsizei, GLenum, GLsizei, GLvoid*),void);
value glstub_glCompressedTexSubImage1D(value v0, value v1, value v2, value v3, value v4, value v5, value v6)
{
	CAMLparam5(v0, v1, v2, v3, v4);
	CAMLxparam2(v5, v6);
	GLenum lv0 = Int_val(v0);
	GLint lv1 = Int_val(v1);
	GLint lv2 = Int_val(v2);
	GLsizei lv3 = Int_val(v3);
	GLenum lv4 = Int_val(v4);
	GLsizei lv5 = Int_val(v5);
	GLvoid* lv6 = (GLvoid *)((Tag_val(v6) == String_tag)? (String_val(v6)) : (Data_bigarray_val(v6)));
	LOAD_FUNCTION(glCompressedTexSubImage1D);
	(*stub_glCompressedTexSubImage1D)(lv0, lv1, lv2, lv3, lv4, lv5, lv6);
	CAMLreturn(Val_unit);
}

value glstub_glCompressedTexSubImage1D_byte(value * argv, int n)
{
	return glstub_glCompressedTexSubImage1D(argv[0], argv[1], argv[2], argv[3], argv[4], argv[5], argv[6]);
}

DECLARE_FUNCTION(glCompressedTexSubImage1DARB,(GLenum, GLint, GLint, GLsizei, GLenum, GLsizei, GLvoid*),void);
value glstub_glCompressedTexSubImage1DARB(value v0, value v1, value v2, value v3, value v4, value v5, value v6)
{
	CAMLparam5(v0, v1, v2, v3, v4);
	CAMLxparam2(v5, v6);
	GLenum lv0 = Int_val(v0);
	GLint lv1 = Int_val(v1);
	GLint lv2 = Int_val(v2);
	GLsizei lv3 = Int_val(v3);
	GLenum lv4 = Int_val(v4);
	GLsizei lv5 = Int_val(v5);
	GLvoid* lv6 = (GLvoid *)((Tag_val(v6) == String_tag)? (String_val(v6)) : (Data_bigarray_val(v6)));
	LOAD_FUNCTION(glCompressedTexSubImage1DARB);
	(*stub_glCompressedTexSubImage1DARB)(lv0, lv1, lv2, lv3, lv4, lv5, lv6);
	CAMLreturn(Val_unit);
}

value glstub_glCompressedTexSubImage1DARB_byte(value * argv, int n)
{
	return glstub_glCompressedTexSubImage1DARB(argv[0], argv[1], argv[2], argv[3], argv[4], argv[5], argv[6]);
}

DECLARE_FUNCTION(glCompressedTexSubImage2D,(GLenum, GLint, GLint, GLint, GLsizei, GLsizei, GLenum, GLsizei, GLvoid*),void);
value glstub_glCompressedTexSubImage2D(value v0, value v1, value v2, value v3, value v4, value v5, value v6, value v7, value v8)
{
	CAMLparam5(v0, v1, v2, v3, v4);
	CAMLxparam4(v5, v6, v7, v8);
	GLenum lv0 = Int_val(v0);
	GLint lv1 = Int_val(v1);
	GLint lv2 = Int_val(v2);
	GLint lv3 = Int_val(v3);
	GLsizei lv4 = Int_val(v4);
	GLsizei lv5 = Int_val(v5);
	GLenum lv6 = Int_val(v6);
	GLsizei lv7 = Int_val(v7);
	GLvoid* lv8 = (GLvoid *)((Tag_val(v8) == String_tag)? (String_val(v8)) : (Data_bigarray_val(v8)));
	LOAD_FUNCTION(glCompressedTexSubImage2D);
	(*stub_glCompressedTexSubImage2D)(lv0, lv1, lv2, lv3, lv4, lv5, lv6, lv7, lv8);
	CAMLreturn(Val_unit);
}

value glstub_glCompressedTexSubImage2D_byte(value * argv, int n)
{
	return glstub_glCompressedTexSubImage2D(argv[0], argv[1], argv[2], argv[3], argv[4], argv[5], argv[6], argv[7], argv[8]);
}

DECLARE_FUNCTION(glCompressedTexSubImage2DARB,(GLenum, GLint, GLint, GLint, GLsizei, GLsizei, GLenum, GLsizei, GLvoid*),void);
value glstub_glCompressedTexSubImage2DARB(value v0, value v1, value v2, value v3, value v4, value v5, value v6, value v7, value v8)
{
	CAMLparam5(v0, v1, v2, v3, v4);
	CAMLxparam4(v5, v6, v7, v8);
	GLenum lv0 = Int_val(v0);
	GLint lv1 = Int_val(v1);
	GLint lv2 = Int_val(v2);
	GLint lv3 = Int_val(v3);
	GLsizei lv4 = Int_val(v4);
	GLsizei lv5 = Int_val(v5);
	GLenum lv6 = Int_val(v6);
	GLsizei lv7 = Int_val(v7);
	GLvoid* lv8 = (GLvoid *)((Tag_val(v8) == String_tag)? (String_val(v8)) : (Data_bigarray_val(v8)));
	LOAD_FUNCTION(glCompressedTexSubImage2DARB);
	(*stub_glCompressedTexSubImage2DARB)(lv0, lv1, lv2, lv3, lv4, lv5, lv6, lv7, lv8);
	CAMLreturn(Val_unit);
}

value glstub_glCompressedTexSubImage2DARB_byte(value * argv, int n)
{
	return glstub_glCompressedTexSubImage2DARB(argv[0], argv[1], argv[2], argv[3], argv[4], argv[5], argv[6], argv[7], argv[8]);
}

DECLARE_FUNCTION(glCompressedTexSubImage3D,(GLenum, GLint, GLint, GLint, GLint, GLsizei, GLsizei, GLsizei, GLenum, GLsizei, GLvoid*),void);
value glstub_glCompressedTexSubImage3D(value v0, value v1, value v2, value v3, value v4, value v5, value v6, value v7, value v8, value v9, value v10)
{
	CAMLparam5(v0, v1, v2, v3, v4);
	CAMLxparam5(v5, v6, v7, v8, v9);
	CAMLxparam1(v10);
	GLenum lv0 = Int_val(v0);
	GLint lv1 = Int_val(v1);
	GLint lv2 = Int_val(v2);
	GLint lv3 = Int_val(v3);
	GLint lv4 = Int_val(v4);
	GLsizei lv5 = Int_val(v5);
	GLsizei lv6 = Int_val(v6);
	GLsizei lv7 = Int_val(v7);
	GLenum lv8 = Int_val(v8);
	GLsizei lv9 = Int_val(v9);
	GLvoid* lv10 = (GLvoid *)((Tag_val(v10) == String_tag)? (String_val(v10)) : (Data_bigarray_val(v10)));
	LOAD_FUNCTION(glCompressedTexSubImage3D);
	(*stub_glCompressedTexSubImage3D)(lv0, lv1, lv2, lv3, lv4, lv5, lv6, lv7, lv8, lv9, lv10);
	CAMLreturn(Val_unit);
}

value glstub_glCompressedTexSubImage3D_byte(value * argv, int n)
{
	return glstub_glCompressedTexSubImage3D(argv[0], argv[1], argv[2], argv[3], argv[4], argv[5], argv[6], argv[7], argv[8], argv[9], argv[10]);
}

DECLARE_FUNCTION(glCompressedTexSubImage3DARB,(GLenum, GLint, GLint, GLint, GLint, GLsizei, GLsizei, GLsizei, GLenum, GLsizei, GLvoid*),void);
value glstub_glCompressedTexSubImage3DARB(value v0, value v1, value v2, value v3, value v4, value v5, value v6, value v7, value v8, value v9, value v10)
{
	CAMLparam5(v0, v1, v2, v3, v4);
	CAMLxparam5(v5, v6, v7, v8, v9);
	CAMLxparam1(v10);
	GLenum lv0 = Int_val(v0);
	GLint lv1 = Int_val(v1);
	GLint lv2 = Int_val(v2);
	GLint lv3 = Int_val(v3);
	GLint lv4 = Int_val(v4);
	GLsizei lv5 = Int_val(v5);
	GLsizei lv6 = Int_val(v6);
	GLsizei lv7 = Int_val(v7);
	GLenum lv8 = Int_val(v8);
	GLsizei lv9 = Int_val(v9);
	GLvoid* lv10 = (GLvoid *)((Tag_val(v10) == String_tag)? (String_val(v10)) : (Data_bigarray_val(v10)));
	LOAD_FUNCTION(glCompressedTexSubImage3DARB);
	(*stub_glCompressedTexSubImage3DARB)(lv0, lv1, lv2, lv3, lv4, lv5, lv6, lv7, lv8, lv9, lv10);
	CAMLreturn(Val_unit);
}

value glstub_glCompressedTexSubImage3DARB_byte(value * argv, int n)
{
	return glstub_glCompressedTexSubImage3DARB(argv[0], argv[1], argv[2], argv[3], argv[4], argv[5], argv[6], argv[7], argv[8], argv[9], argv[10]);
}

DECLARE_FUNCTION(glConvolutionFilter1D,(GLenum, GLenum, GLsizei, GLenum, GLenum, GLvoid*),void);
value glstub_glConvolutionFilter1D(value v0, value v1, value v2, value v3, value v4, value v5)
{
	CAMLparam5(v0, v1, v2, v3, v4);
	CAMLxparam1(v5);
	GLenum lv0 = Int_val(v0);
	GLenum lv1 = Int_val(v1);
	GLsizei lv2 = Int_val(v2);
	GLenum lv3 = Int_val(v3);
	GLenum lv4 = Int_val(v4);
	GLvoid* lv5 = (GLvoid *)((Tag_val(v5) == String_tag)? (String_val(v5)) : (Data_bigarray_val(v5)));
	LOAD_FUNCTION(glConvolutionFilter1D);
	(*stub_glConvolutionFilter1D)(lv0, lv1, lv2, lv3, lv4, lv5);
	CAMLreturn(Val_unit);
}

value glstub_glConvolutionFilter1D_byte(value * argv, int n)
{
	return glstub_glConvolutionFilter1D(argv[0], argv[1], argv[2], argv[3], argv[4], argv[5]);
}

DECLARE_FUNCTION(glConvolutionFilter1DEXT,(GLenum, GLenum, GLsizei, GLenum, GLenum, GLvoid*),void);
value glstub_glConvolutionFilter1DEXT(value v0, value v1, value v2, value v3, value v4, value v5)
{
	CAMLparam5(v0, v1, v2, v3, v4);
	CAMLxparam1(v5);
	GLenum lv0 = Int_val(v0);
	GLenum lv1 = Int_val(v1);
	GLsizei lv2 = Int_val(v2);
	GLenum lv3 = Int_val(v3);
	GLenum lv4 = Int_val(v4);
	GLvoid* lv5 = (GLvoid *)((Tag_val(v5) == String_tag)? (String_val(v5)) : (Data_bigarray_val(v5)));
	LOAD_FUNCTION(glConvolutionFilter1DEXT);
	(*stub_glConvolutionFilter1DEXT)(lv0, lv1, lv2, lv3, lv4, lv5);
	CAMLreturn(Val_unit);
}

value glstub_glConvolutionFilter1DEXT_byte(value * argv, int n)
{
	return glstub_glConvolutionFilter1DEXT(argv[0], argv[1], argv[2], argv[3], argv[4], argv[5]);
}

DECLARE_FUNCTION(glConvolutionFilter2D,(GLenum, GLenum, GLsizei, GLsizei, GLenum, GLenum, GLvoid*),void);
value glstub_glConvolutionFilter2D(value v0, value v1, value v2, value v3, value v4, value v5, value v6)
{
	CAMLparam5(v0, v1, v2, v3, v4);
	CAMLxparam2(v5, v6);
	GLenum lv0 = Int_val(v0);
	GLenum lv1 = Int_val(v1);
	GLsizei lv2 = Int_val(v2);
	GLsizei lv3 = Int_val(v3);
	GLenum lv4 = Int_val(v4);
	GLenum lv5 = Int_val(v5);
	GLvoid* lv6 = (GLvoid *)((Tag_val(v6) == String_tag)? (String_val(v6)) : (Data_bigarray_val(v6)));
	LOAD_FUNCTION(glConvolutionFilter2D);
	(*stub_glConvolutionFilter2D)(lv0, lv1, lv2, lv3, lv4, lv5, lv6);
	CAMLreturn(Val_unit);
}

value glstub_glConvolutionFilter2D_byte(value * argv, int n)
{
	return glstub_glConvolutionFilter2D(argv[0], argv[1], argv[2], argv[3], argv[4], argv[5], argv[6]);
}

DECLARE_FUNCTION(glConvolutionFilter2DEXT,(GLenum, GLenum, GLsizei, GLsizei, GLenum, GLenum, GLvoid*),void);
value glstub_glConvolutionFilter2DEXT(value v0, value v1, value v2, value v3, value v4, value v5, value v6)
{
	CAMLparam5(v0, v1, v2, v3, v4);
	CAMLxparam2(v5, v6);
	GLenum lv0 = Int_val(v0);
	GLenum lv1 = Int_val(v1);
	GLsizei lv2 = Int_val(v2);
	GLsizei lv3 = Int_val(v3);
	GLenum lv4 = Int_val(v4);
	GLenum lv5 = Int_val(v5);
	GLvoid* lv6 = (GLvoid *)((Tag_val(v6) == String_tag)? (String_val(v6)) : (Data_bigarray_val(v6)));
	LOAD_FUNCTION(glConvolutionFilter2DEXT);
	(*stub_glConvolutionFilter2DEXT)(lv0, lv1, lv2, lv3, lv4, lv5, lv6);
	CAMLreturn(Val_unit);
}

value glstub_glConvolutionFilter2DEXT_byte(value * argv, int n)
{
	return glstub_glConvolutionFilter2DEXT(argv[0], argv[1], argv[2], argv[3], argv[4], argv[5], argv[6]);
}

DECLARE_FUNCTION(glConvolutionParameterf,(GLenum, GLenum, GLfloat),void);
value glstub_glConvolutionParameterf(value v0, value v1, value v2)
{
	CAMLparam3(v0, v1, v2);
	GLenum lv0 = Int_val(v0);
	GLenum lv1 = Int_val(v1);
	GLfloat lv2 = Double_val(v2);
	LOAD_FUNCTION(glConvolutionParameterf);
	(*stub_glConvolutionParameterf)(lv0, lv1, lv2);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glConvolutionParameterfEXT,(GLenum, GLenum, GLfloat),void);
value glstub_glConvolutionParameterfEXT(value v0, value v1, value v2)
{
	CAMLparam3(v0, v1, v2);
	GLenum lv0 = Int_val(v0);
	GLenum lv1 = Int_val(v1);
	GLfloat lv2 = Double_val(v2);
	LOAD_FUNCTION(glConvolutionParameterfEXT);
	(*stub_glConvolutionParameterfEXT)(lv0, lv1, lv2);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glConvolutionParameterfv,(GLenum, GLenum, GLfloat*),void);
value glstub_glConvolutionParameterfv(value v0, value v1, value v2)
{
	CAMLparam3(v0, v1, v2);
	GLenum lv0 = Int_val(v0);
	GLenum lv1 = Int_val(v1);
	GLfloat* lv2 = Data_bigarray_val(v2);
	LOAD_FUNCTION(glConvolutionParameterfv);
	(*stub_glConvolutionParameterfv)(lv0, lv1, lv2);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glConvolutionParameterfvEXT,(GLenum, GLenum, GLfloat*),void);
value glstub_glConvolutionParameterfvEXT(value v0, value v1, value v2)
{
	CAMLparam3(v0, v1, v2);
	GLenum lv0 = Int_val(v0);
	GLenum lv1 = Int_val(v1);
	GLfloat* lv2 = Data_bigarray_val(v2);
	LOAD_FUNCTION(glConvolutionParameterfvEXT);
	(*stub_glConvolutionParameterfvEXT)(lv0, lv1, lv2);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glConvolutionParameteri,(GLenum, GLenum, GLint),void);
value glstub_glConvolutionParameteri(value v0, value v1, value v2)
{
	CAMLparam3(v0, v1, v2);
	GLenum lv0 = Int_val(v0);
	GLenum lv1 = Int_val(v1);
	GLint lv2 = Int_val(v2);
	LOAD_FUNCTION(glConvolutionParameteri);
	(*stub_glConvolutionParameteri)(lv0, lv1, lv2);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glConvolutionParameteriEXT,(GLenum, GLenum, GLint),void);
value glstub_glConvolutionParameteriEXT(value v0, value v1, value v2)
{
	CAMLparam3(v0, v1, v2);
	GLenum lv0 = Int_val(v0);
	GLenum lv1 = Int_val(v1);
	GLint lv2 = Int_val(v2);
	LOAD_FUNCTION(glConvolutionParameteriEXT);
	(*stub_glConvolutionParameteriEXT)(lv0, lv1, lv2);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glConvolutionParameteriv,(GLenum, GLenum, GLint*),void);
value glstub_glConvolutionParameteriv(value v0, value v1, value v2)
{
	CAMLparam3(v0, v1, v2);
	GLenum lv0 = Int_val(v0);
	GLenum lv1 = Int_val(v1);
	GLint* lv2 = Data_bigarray_val(v2);
	LOAD_FUNCTION(glConvolutionParameteriv);
	(*stub_glConvolutionParameteriv)(lv0, lv1, lv2);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glConvolutionParameterivEXT,(GLenum, GLenum, GLint*),void);
value glstub_glConvolutionParameterivEXT(value v0, value v1, value v2)
{
	CAMLparam3(v0, v1, v2);
	GLenum lv0 = Int_val(v0);
	GLenum lv1 = Int_val(v1);
	GLint* lv2 = Data_bigarray_val(v2);
	LOAD_FUNCTION(glConvolutionParameterivEXT);
	(*stub_glConvolutionParameterivEXT)(lv0, lv1, lv2);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glCopyColorSubTable,(GLenum, GLsizei, GLint, GLint, GLsizei),void);
value glstub_glCopyColorSubTable(value v0, value v1, value v2, value v3, value v4)
{
	CAMLparam5(v0, v1, v2, v3, v4);
	GLenum lv0 = Int_val(v0);
	GLsizei lv1 = Int_val(v1);
	GLint lv2 = Int_val(v2);
	GLint lv3 = Int_val(v3);
	GLsizei lv4 = Int_val(v4);
	LOAD_FUNCTION(glCopyColorSubTable);
	(*stub_glCopyColorSubTable)(lv0, lv1, lv2, lv3, lv4);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glCopyColorSubTableEXT,(GLenum, GLsizei, GLint, GLint, GLsizei),void);
value glstub_glCopyColorSubTableEXT(value v0, value v1, value v2, value v3, value v4)
{
	CAMLparam5(v0, v1, v2, v3, v4);
	GLenum lv0 = Int_val(v0);
	GLsizei lv1 = Int_val(v1);
	GLint lv2 = Int_val(v2);
	GLint lv3 = Int_val(v3);
	GLsizei lv4 = Int_val(v4);
	LOAD_FUNCTION(glCopyColorSubTableEXT);
	(*stub_glCopyColorSubTableEXT)(lv0, lv1, lv2, lv3, lv4);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glCopyColorTable,(GLenum, GLenum, GLint, GLint, GLsizei),void);
value glstub_glCopyColorTable(value v0, value v1, value v2, value v3, value v4)
{
	CAMLparam5(v0, v1, v2, v3, v4);
	GLenum lv0 = Int_val(v0);
	GLenum lv1 = Int_val(v1);
	GLint lv2 = Int_val(v2);
	GLint lv3 = Int_val(v3);
	GLsizei lv4 = Int_val(v4);
	LOAD_FUNCTION(glCopyColorTable);
	(*stub_glCopyColorTable)(lv0, lv1, lv2, lv3, lv4);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glCopyColorTableSGI,(GLenum, GLenum, GLint, GLint, GLsizei),void);
value glstub_glCopyColorTableSGI(value v0, value v1, value v2, value v3, value v4)
{
	CAMLparam5(v0, v1, v2, v3, v4);
	GLenum lv0 = Int_val(v0);
	GLenum lv1 = Int_val(v1);
	GLint lv2 = Int_val(v2);
	GLint lv3 = Int_val(v3);
	GLsizei lv4 = Int_val(v4);
	LOAD_FUNCTION(glCopyColorTableSGI);
	(*stub_glCopyColorTableSGI)(lv0, lv1, lv2, lv3, lv4);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glCopyConvolutionFilter1D,(GLenum, GLenum, GLint, GLint, GLsizei),void);
value glstub_glCopyConvolutionFilter1D(value v0, value v1, value v2, value v3, value v4)
{
	CAMLparam5(v0, v1, v2, v3, v4);
	GLenum lv0 = Int_val(v0);
	GLenum lv1 = Int_val(v1);
	GLint lv2 = Int_val(v2);
	GLint lv3 = Int_val(v3);
	GLsizei lv4 = Int_val(v4);
	LOAD_FUNCTION(glCopyConvolutionFilter1D);
	(*stub_glCopyConvolutionFilter1D)(lv0, lv1, lv2, lv3, lv4);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glCopyConvolutionFilter1DEXT,(GLenum, GLenum, GLint, GLint, GLsizei),void);
value glstub_glCopyConvolutionFilter1DEXT(value v0, value v1, value v2, value v3, value v4)
{
	CAMLparam5(v0, v1, v2, v3, v4);
	GLenum lv0 = Int_val(v0);
	GLenum lv1 = Int_val(v1);
	GLint lv2 = Int_val(v2);
	GLint lv3 = Int_val(v3);
	GLsizei lv4 = Int_val(v4);
	LOAD_FUNCTION(glCopyConvolutionFilter1DEXT);
	(*stub_glCopyConvolutionFilter1DEXT)(lv0, lv1, lv2, lv3, lv4);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glCopyConvolutionFilter2D,(GLenum, GLenum, GLint, GLint, GLsizei, GLsizei),void);
value glstub_glCopyConvolutionFilter2D(value v0, value v1, value v2, value v3, value v4, value v5)
{
	CAMLparam5(v0, v1, v2, v3, v4);
	CAMLxparam1(v5);
	GLenum lv0 = Int_val(v0);
	GLenum lv1 = Int_val(v1);
	GLint lv2 = Int_val(v2);
	GLint lv3 = Int_val(v3);
	GLsizei lv4 = Int_val(v4);
	GLsizei lv5 = Int_val(v5);
	LOAD_FUNCTION(glCopyConvolutionFilter2D);
	(*stub_glCopyConvolutionFilter2D)(lv0, lv1, lv2, lv3, lv4, lv5);
	CAMLreturn(Val_unit);
}

value glstub_glCopyConvolutionFilter2D_byte(value * argv, int n)
{
	return glstub_glCopyConvolutionFilter2D(argv[0], argv[1], argv[2], argv[3], argv[4], argv[5]);
}

DECLARE_FUNCTION(glCopyConvolutionFilter2DEXT,(GLenum, GLenum, GLint, GLint, GLsizei, GLsizei),void);
value glstub_glCopyConvolutionFilter2DEXT(value v0, value v1, value v2, value v3, value v4, value v5)
{
	CAMLparam5(v0, v1, v2, v3, v4);
	CAMLxparam1(v5);
	GLenum lv0 = Int_val(v0);
	GLenum lv1 = Int_val(v1);
	GLint lv2 = Int_val(v2);
	GLint lv3 = Int_val(v3);
	GLsizei lv4 = Int_val(v4);
	GLsizei lv5 = Int_val(v5);
	LOAD_FUNCTION(glCopyConvolutionFilter2DEXT);
	(*stub_glCopyConvolutionFilter2DEXT)(lv0, lv1, lv2, lv3, lv4, lv5);
	CAMLreturn(Val_unit);
}

value glstub_glCopyConvolutionFilter2DEXT_byte(value * argv, int n)
{
	return glstub_glCopyConvolutionFilter2DEXT(argv[0], argv[1], argv[2], argv[3], argv[4], argv[5]);
}

DECLARE_FUNCTION(glCopyPixels,(GLint, GLint, GLsizei, GLsizei, GLenum),void);
value glstub_glCopyPixels(value v0, value v1, value v2, value v3, value v4)
{
	CAMLparam5(v0, v1, v2, v3, v4);
	GLint lv0 = Int_val(v0);
	GLint lv1 = Int_val(v1);
	GLsizei lv2 = Int_val(v2);
	GLsizei lv3 = Int_val(v3);
	GLenum lv4 = Int_val(v4);
	LOAD_FUNCTION(glCopyPixels);
	(*stub_glCopyPixels)(lv0, lv1, lv2, lv3, lv4);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glCopyTexImage1D,(GLenum, GLint, GLenum, GLint, GLint, GLsizei, GLint),void);
value glstub_glCopyTexImage1D(value v0, value v1, value v2, value v3, value v4, value v5, value v6)
{
	CAMLparam5(v0, v1, v2, v3, v4);
	CAMLxparam2(v5, v6);
	GLenum lv0 = Int_val(v0);
	GLint lv1 = Int_val(v1);
	GLenum lv2 = Int_val(v2);
	GLint lv3 = Int_val(v3);
	GLint lv4 = Int_val(v4);
	GLsizei lv5 = Int_val(v5);
	GLint lv6 = Int_val(v6);
	LOAD_FUNCTION(glCopyTexImage1D);
	(*stub_glCopyTexImage1D)(lv0, lv1, lv2, lv3, lv4, lv5, lv6);
	CAMLreturn(Val_unit);
}

value glstub_glCopyTexImage1D_byte(value * argv, int n)
{
	return glstub_glCopyTexImage1D(argv[0], argv[1], argv[2], argv[3], argv[4], argv[5], argv[6]);
}

DECLARE_FUNCTION(glCopyTexImage1DEXT,(GLenum, GLint, GLenum, GLint, GLint, GLsizei, GLint),void);
value glstub_glCopyTexImage1DEXT(value v0, value v1, value v2, value v3, value v4, value v5, value v6)
{
	CAMLparam5(v0, v1, v2, v3, v4);
	CAMLxparam2(v5, v6);
	GLenum lv0 = Int_val(v0);
	GLint lv1 = Int_val(v1);
	GLenum lv2 = Int_val(v2);
	GLint lv3 = Int_val(v3);
	GLint lv4 = Int_val(v4);
	GLsizei lv5 = Int_val(v5);
	GLint lv6 = Int_val(v6);
	LOAD_FUNCTION(glCopyTexImage1DEXT);
	(*stub_glCopyTexImage1DEXT)(lv0, lv1, lv2, lv3, lv4, lv5, lv6);
	CAMLreturn(Val_unit);
}

value glstub_glCopyTexImage1DEXT_byte(value * argv, int n)
{
	return glstub_glCopyTexImage1DEXT(argv[0], argv[1], argv[2], argv[3], argv[4], argv[5], argv[6]);
}

DECLARE_FUNCTION(glCopyTexImage2D,(GLenum, GLint, GLenum, GLint, GLint, GLsizei, GLsizei, GLint),void);
value glstub_glCopyTexImage2D(value v0, value v1, value v2, value v3, value v4, value v5, value v6, value v7)
{
	CAMLparam5(v0, v1, v2, v3, v4);
	CAMLxparam3(v5, v6, v7);
	GLenum lv0 = Int_val(v0);
	GLint lv1 = Int_val(v1);
	GLenum lv2 = Int_val(v2);
	GLint lv3 = Int_val(v3);
	GLint lv4 = Int_val(v4);
	GLsizei lv5 = Int_val(v5);
	GLsizei lv6 = Int_val(v6);
	GLint lv7 = Int_val(v7);
	LOAD_FUNCTION(glCopyTexImage2D);
	(*stub_glCopyTexImage2D)(lv0, lv1, lv2, lv3, lv4, lv5, lv6, lv7);
	CAMLreturn(Val_unit);
}

value glstub_glCopyTexImage2D_byte(value * argv, int n)
{
	return glstub_glCopyTexImage2D(argv[0], argv[1], argv[2], argv[3], argv[4], argv[5], argv[6], argv[7]);
}

DECLARE_FUNCTION(glCopyTexImage2DEXT,(GLenum, GLint, GLenum, GLint, GLint, GLsizei, GLsizei, GLint),void);
value glstub_glCopyTexImage2DEXT(value v0, value v1, value v2, value v3, value v4, value v5, value v6, value v7)
{
	CAMLparam5(v0, v1, v2, v3, v4);
	CAMLxparam3(v5, v6, v7);
	GLenum lv0 = Int_val(v0);
	GLint lv1 = Int_val(v1);
	GLenum lv2 = Int_val(v2);
	GLint lv3 = Int_val(v3);
	GLint lv4 = Int_val(v4);
	GLsizei lv5 = Int_val(v5);
	GLsizei lv6 = Int_val(v6);
	GLint lv7 = Int_val(v7);
	LOAD_FUNCTION(glCopyTexImage2DEXT);
	(*stub_glCopyTexImage2DEXT)(lv0, lv1, lv2, lv3, lv4, lv5, lv6, lv7);
	CAMLreturn(Val_unit);
}

value glstub_glCopyTexImage2DEXT_byte(value * argv, int n)
{
	return glstub_glCopyTexImage2DEXT(argv[0], argv[1], argv[2], argv[3], argv[4], argv[5], argv[6], argv[7]);
}

DECLARE_FUNCTION(glCopyTexSubImage1D,(GLenum, GLint, GLint, GLint, GLint, GLsizei),void);
value glstub_glCopyTexSubImage1D(value v0, value v1, value v2, value v3, value v4, value v5)
{
	CAMLparam5(v0, v1, v2, v3, v4);
	CAMLxparam1(v5);
	GLenum lv0 = Int_val(v0);
	GLint lv1 = Int_val(v1);
	GLint lv2 = Int_val(v2);
	GLint lv3 = Int_val(v3);
	GLint lv4 = Int_val(v4);
	GLsizei lv5 = Int_val(v5);
	LOAD_FUNCTION(glCopyTexSubImage1D);
	(*stub_glCopyTexSubImage1D)(lv0, lv1, lv2, lv3, lv4, lv5);
	CAMLreturn(Val_unit);
}

value glstub_glCopyTexSubImage1D_byte(value * argv, int n)
{
	return glstub_glCopyTexSubImage1D(argv[0], argv[1], argv[2], argv[3], argv[4], argv[5]);
}

DECLARE_FUNCTION(glCopyTexSubImage1DEXT,(GLenum, GLint, GLint, GLint, GLint, GLsizei),void);
value glstub_glCopyTexSubImage1DEXT(value v0, value v1, value v2, value v3, value v4, value v5)
{
	CAMLparam5(v0, v1, v2, v3, v4);
	CAMLxparam1(v5);
	GLenum lv0 = Int_val(v0);
	GLint lv1 = Int_val(v1);
	GLint lv2 = Int_val(v2);
	GLint lv3 = Int_val(v3);
	GLint lv4 = Int_val(v4);
	GLsizei lv5 = Int_val(v5);
	LOAD_FUNCTION(glCopyTexSubImage1DEXT);
	(*stub_glCopyTexSubImage1DEXT)(lv0, lv1, lv2, lv3, lv4, lv5);
	CAMLreturn(Val_unit);
}

value glstub_glCopyTexSubImage1DEXT_byte(value * argv, int n)
{
	return glstub_glCopyTexSubImage1DEXT(argv[0], argv[1], argv[2], argv[3], argv[4], argv[5]);
}

DECLARE_FUNCTION(glCopyTexSubImage2D,(GLenum, GLint, GLint, GLint, GLint, GLint, GLsizei, GLsizei),void);
value glstub_glCopyTexSubImage2D(value v0, value v1, value v2, value v3, value v4, value v5, value v6, value v7)
{
	CAMLparam5(v0, v1, v2, v3, v4);
	CAMLxparam3(v5, v6, v7);
	GLenum lv0 = Int_val(v0);
	GLint lv1 = Int_val(v1);
	GLint lv2 = Int_val(v2);
	GLint lv3 = Int_val(v3);
	GLint lv4 = Int_val(v4);
	GLint lv5 = Int_val(v5);
	GLsizei lv6 = Int_val(v6);
	GLsizei lv7 = Int_val(v7);
	LOAD_FUNCTION(glCopyTexSubImage2D);
	(*stub_glCopyTexSubImage2D)(lv0, lv1, lv2, lv3, lv4, lv5, lv6, lv7);
	CAMLreturn(Val_unit);
}

value glstub_glCopyTexSubImage2D_byte(value * argv, int n)
{
	return glstub_glCopyTexSubImage2D(argv[0], argv[1], argv[2], argv[3], argv[4], argv[5], argv[6], argv[7]);
}

DECLARE_FUNCTION(glCopyTexSubImage2DEXT,(GLenum, GLint, GLint, GLint, GLint, GLint, GLsizei, GLsizei),void);
value glstub_glCopyTexSubImage2DEXT(value v0, value v1, value v2, value v3, value v4, value v5, value v6, value v7)
{
	CAMLparam5(v0, v1, v2, v3, v4);
	CAMLxparam3(v5, v6, v7);
	GLenum lv0 = Int_val(v0);
	GLint lv1 = Int_val(v1);
	GLint lv2 = Int_val(v2);
	GLint lv3 = Int_val(v3);
	GLint lv4 = Int_val(v4);
	GLint lv5 = Int_val(v5);
	GLsizei lv6 = Int_val(v6);
	GLsizei lv7 = Int_val(v7);
	LOAD_FUNCTION(glCopyTexSubImage2DEXT);
	(*stub_glCopyTexSubImage2DEXT)(lv0, lv1, lv2, lv3, lv4, lv5, lv6, lv7);
	CAMLreturn(Val_unit);
}

value glstub_glCopyTexSubImage2DEXT_byte(value * argv, int n)
{
	return glstub_glCopyTexSubImage2DEXT(argv[0], argv[1], argv[2], argv[3], argv[4], argv[5], argv[6], argv[7]);
}

DECLARE_FUNCTION(glCopyTexSubImage3D,(GLenum, GLint, GLint, GLint, GLint, GLint, GLint, GLsizei, GLsizei),void);
value glstub_glCopyTexSubImage3D(value v0, value v1, value v2, value v3, value v4, value v5, value v6, value v7, value v8)
{
	CAMLparam5(v0, v1, v2, v3, v4);
	CAMLxparam4(v5, v6, v7, v8);
	GLenum lv0 = Int_val(v0);
	GLint lv1 = Int_val(v1);
	GLint lv2 = Int_val(v2);
	GLint lv3 = Int_val(v3);
	GLint lv4 = Int_val(v4);
	GLint lv5 = Int_val(v5);
	GLint lv6 = Int_val(v6);
	GLsizei lv7 = Int_val(v7);
	GLsizei lv8 = Int_val(v8);
	LOAD_FUNCTION(glCopyTexSubImage3D);
	(*stub_glCopyTexSubImage3D)(lv0, lv1, lv2, lv3, lv4, lv5, lv6, lv7, lv8);
	CAMLreturn(Val_unit);
}

value glstub_glCopyTexSubImage3D_byte(value * argv, int n)
{
	return glstub_glCopyTexSubImage3D(argv[0], argv[1], argv[2], argv[3], argv[4], argv[5], argv[6], argv[7], argv[8]);
}

DECLARE_FUNCTION(glCopyTexSubImage3DEXT,(GLenum, GLint, GLint, GLint, GLint, GLint, GLint, GLsizei, GLsizei),void);
value glstub_glCopyTexSubImage3DEXT(value v0, value v1, value v2, value v3, value v4, value v5, value v6, value v7, value v8)
{
	CAMLparam5(v0, v1, v2, v3, v4);
	CAMLxparam4(v5, v6, v7, v8);
	GLenum lv0 = Int_val(v0);
	GLint lv1 = Int_val(v1);
	GLint lv2 = Int_val(v2);
	GLint lv3 = Int_val(v3);
	GLint lv4 = Int_val(v4);
	GLint lv5 = Int_val(v5);
	GLint lv6 = Int_val(v6);
	GLsizei lv7 = Int_val(v7);
	GLsizei lv8 = Int_val(v8);
	LOAD_FUNCTION(glCopyTexSubImage3DEXT);
	(*stub_glCopyTexSubImage3DEXT)(lv0, lv1, lv2, lv3, lv4, lv5, lv6, lv7, lv8);
	CAMLreturn(Val_unit);
}

value glstub_glCopyTexSubImage3DEXT_byte(value * argv, int n)
{
	return glstub_glCopyTexSubImage3DEXT(argv[0], argv[1], argv[2], argv[3], argv[4], argv[5], argv[6], argv[7], argv[8]);
}

DECLARE_FUNCTION(glCreateProgram,(void),GLuint);
value glstub_glCreateProgram(value v0)
{
	CAMLparam1(v0);
	CAMLlocal1(result);
	GLuint ret;
	LOAD_FUNCTION(glCreateProgram);
	ret = (*stub_glCreateProgram)();
	result = Val_int(ret);
	CAMLreturn(result);
}

DECLARE_FUNCTION(glCreateProgramObjectARB,(void),GLuint);
value glstub_glCreateProgramObjectARB(value v0)
{
	CAMLparam1(v0);
	CAMLlocal1(result);
	GLuint ret;
	LOAD_FUNCTION(glCreateProgramObjectARB);
	ret = (*stub_glCreateProgramObjectARB)();
	result = Val_int(ret);
	CAMLreturn(result);
}

DECLARE_FUNCTION(glCreateShader,(GLenum),GLuint);
value glstub_glCreateShader(value v0)
{
	CAMLparam1(v0);
	CAMLlocal1(result);
	GLenum lv0 = Int_val(v0);
	GLuint ret;
	LOAD_FUNCTION(glCreateShader);
	ret = (*stub_glCreateShader)(lv0);
	result = Val_int(ret);
	CAMLreturn(result);
}

DECLARE_FUNCTION(glCreateShaderObjectARB,(GLenum),GLuint);
value glstub_glCreateShaderObjectARB(value v0)
{
	CAMLparam1(v0);
	CAMLlocal1(result);
	GLenum lv0 = Int_val(v0);
	GLuint ret;
	LOAD_FUNCTION(glCreateShaderObjectARB);
	ret = (*stub_glCreateShaderObjectARB)(lv0);
	result = Val_int(ret);
	CAMLreturn(result);
}

DECLARE_FUNCTION(glCullFace,(GLenum),void);
value glstub_glCullFace(value v0)
{
	CAMLparam1(v0);
	GLenum lv0 = Int_val(v0);
	LOAD_FUNCTION(glCullFace);
	(*stub_glCullFace)(lv0);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glCullParameterdvEXT,(GLenum, GLdouble*),void);
value glstub_glCullParameterdvEXT(value v0, value v1)
{
	CAMLparam2(v0, v1);
	GLenum lv0 = Int_val(v0);
	GLdouble* lv1 = (Tag_val(v1) == Double_array_tag)? (double *)v1: Data_bigarray_val(v1);
	LOAD_FUNCTION(glCullParameterdvEXT);
	(*stub_glCullParameterdvEXT)(lv0, lv1);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glCullParameterfvEXT,(GLenum, GLfloat*),void);
value glstub_glCullParameterfvEXT(value v0, value v1)
{
	CAMLparam2(v0, v1);
	GLenum lv0 = Int_val(v0);
	GLfloat* lv1 = Data_bigarray_val(v1);
	LOAD_FUNCTION(glCullParameterfvEXT);
	(*stub_glCullParameterfvEXT)(lv0, lv1);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glCurrentPaletteMatrixARB,(GLint),void);
value glstub_glCurrentPaletteMatrixARB(value v0)
{
	CAMLparam1(v0);
	GLint lv0 = Int_val(v0);
	LOAD_FUNCTION(glCurrentPaletteMatrixARB);
	(*stub_glCurrentPaletteMatrixARB)(lv0);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glDeleteAsyncMarkersSGIX,(GLuint, GLsizei),void);
value glstub_glDeleteAsyncMarkersSGIX(value v0, value v1)
{
	CAMLparam2(v0, v1);
	GLuint lv0 = Int_val(v0);
	GLsizei lv1 = Int_val(v1);
	LOAD_FUNCTION(glDeleteAsyncMarkersSGIX);
	(*stub_glDeleteAsyncMarkersSGIX)(lv0, lv1);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glDeleteBufferRegionEXT,(GLenum),void);
value glstub_glDeleteBufferRegionEXT(value v0)
{
	CAMLparam1(v0);
	GLenum lv0 = Int_val(v0);
	LOAD_FUNCTION(glDeleteBufferRegionEXT);
	(*stub_glDeleteBufferRegionEXT)(lv0);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glDeleteBuffers,(GLsizei, GLuint*),void);
value glstub_glDeleteBuffers(value v0, value v1)
{
	CAMLparam2(v0, v1);
	GLsizei lv0 = Int_val(v0);
	GLuint* lv1 = Data_bigarray_val(v1);
	LOAD_FUNCTION(glDeleteBuffers);
	(*stub_glDeleteBuffers)(lv0, lv1);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glDeleteBuffersARB,(GLsizei, GLuint*),void);
value glstub_glDeleteBuffersARB(value v0, value v1)
{
	CAMLparam2(v0, v1);
	GLsizei lv0 = Int_val(v0);
	GLuint* lv1 = Data_bigarray_val(v1);
	LOAD_FUNCTION(glDeleteBuffersARB);
	(*stub_glDeleteBuffersARB)(lv0, lv1);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glDeleteFencesAPPLE,(GLsizei, GLuint*),void);
value glstub_glDeleteFencesAPPLE(value v0, value v1)
{
	CAMLparam2(v0, v1);
	GLsizei lv0 = Int_val(v0);
	GLuint* lv1 = Data_bigarray_val(v1);
	LOAD_FUNCTION(glDeleteFencesAPPLE);
	(*stub_glDeleteFencesAPPLE)(lv0, lv1);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glDeleteFencesNV,(GLsizei, GLuint*),void);
value glstub_glDeleteFencesNV(value v0, value v1)
{
	CAMLparam2(v0, v1);
	GLsizei lv0 = Int_val(v0);
	GLuint* lv1 = Data_bigarray_val(v1);
	LOAD_FUNCTION(glDeleteFencesNV);
	(*stub_glDeleteFencesNV)(lv0, lv1);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glDeleteFragmentShaderATI,(GLuint),void);
value glstub_glDeleteFragmentShaderATI(value v0)
{
	CAMLparam1(v0);
	GLuint lv0 = Int_val(v0);
	LOAD_FUNCTION(glDeleteFragmentShaderATI);
	(*stub_glDeleteFragmentShaderATI)(lv0);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glDeleteFramebuffersEXT,(GLsizei, GLuint*),void);
value glstub_glDeleteFramebuffersEXT(value v0, value v1)
{
	CAMLparam2(v0, v1);
	GLsizei lv0 = Int_val(v0);
	GLuint* lv1 = Data_bigarray_val(v1);
	LOAD_FUNCTION(glDeleteFramebuffersEXT);
	(*stub_glDeleteFramebuffersEXT)(lv0, lv1);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glDeleteLists,(GLuint, GLsizei),void);
value glstub_glDeleteLists(value v0, value v1)
{
	CAMLparam2(v0, v1);
	GLuint lv0 = Int_val(v0);
	GLsizei lv1 = Int_val(v1);
	LOAD_FUNCTION(glDeleteLists);
	(*stub_glDeleteLists)(lv0, lv1);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glDeleteObjectARB,(GLuint),void);
value glstub_glDeleteObjectARB(value v0)
{
	CAMLparam1(v0);
	GLuint lv0 = Int_val(v0);
	LOAD_FUNCTION(glDeleteObjectARB);
	(*stub_glDeleteObjectARB)(lv0);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glDeleteOcclusionQueriesNV,(GLsizei, GLuint*),void);
value glstub_glDeleteOcclusionQueriesNV(value v0, value v1)
{
	CAMLparam2(v0, v1);
	GLsizei lv0 = Int_val(v0);
	GLuint* lv1 = Data_bigarray_val(v1);
	LOAD_FUNCTION(glDeleteOcclusionQueriesNV);
	(*stub_glDeleteOcclusionQueriesNV)(lv0, lv1);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glDeleteProgram,(GLuint),void);
value glstub_glDeleteProgram(value v0)
{
	CAMLparam1(v0);
	GLuint lv0 = Int_val(v0);
	LOAD_FUNCTION(glDeleteProgram);
	(*stub_glDeleteProgram)(lv0);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glDeleteProgramsARB,(GLsizei, GLuint*),void);
value glstub_glDeleteProgramsARB(value v0, value v1)
{
	CAMLparam2(v0, v1);
	GLsizei lv0 = Int_val(v0);
	GLuint* lv1 = Data_bigarray_val(v1);
	LOAD_FUNCTION(glDeleteProgramsARB);
	(*stub_glDeleteProgramsARB)(lv0, lv1);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glDeleteProgramsNV,(GLsizei, GLuint*),void);
value glstub_glDeleteProgramsNV(value v0, value v1)
{
	CAMLparam2(v0, v1);
	GLsizei lv0 = Int_val(v0);
	GLuint* lv1 = Data_bigarray_val(v1);
	LOAD_FUNCTION(glDeleteProgramsNV);
	(*stub_glDeleteProgramsNV)(lv0, lv1);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glDeleteQueries,(GLsizei, GLuint*),void);
value glstub_glDeleteQueries(value v0, value v1)
{
	CAMLparam2(v0, v1);
	GLsizei lv0 = Int_val(v0);
	GLuint* lv1 = Data_bigarray_val(v1);
	LOAD_FUNCTION(glDeleteQueries);
	(*stub_glDeleteQueries)(lv0, lv1);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glDeleteQueriesARB,(GLsizei, GLuint*),void);
value glstub_glDeleteQueriesARB(value v0, value v1)
{
	CAMLparam2(v0, v1);
	GLsizei lv0 = Int_val(v0);
	GLuint* lv1 = Data_bigarray_val(v1);
	LOAD_FUNCTION(glDeleteQueriesARB);
	(*stub_glDeleteQueriesARB)(lv0, lv1);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glDeleteRenderbuffersEXT,(GLsizei, GLuint*),void);
value glstub_glDeleteRenderbuffersEXT(value v0, value v1)
{
	CAMLparam2(v0, v1);
	GLsizei lv0 = Int_val(v0);
	GLuint* lv1 = Data_bigarray_val(v1);
	LOAD_FUNCTION(glDeleteRenderbuffersEXT);
	(*stub_glDeleteRenderbuffersEXT)(lv0, lv1);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glDeleteShader,(GLuint),void);
value glstub_glDeleteShader(value v0)
{
	CAMLparam1(v0);
	GLuint lv0 = Int_val(v0);
	LOAD_FUNCTION(glDeleteShader);
	(*stub_glDeleteShader)(lv0);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glDeleteTextures,(GLsizei, GLuint*),void);
value glstub_glDeleteTextures(value v0, value v1)
{
	CAMLparam2(v0, v1);
	GLsizei lv0 = Int_val(v0);
	GLuint* lv1 = Data_bigarray_val(v1);
	LOAD_FUNCTION(glDeleteTextures);
	(*stub_glDeleteTextures)(lv0, lv1);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glDeleteTexturesEXT,(GLsizei, GLuint*),void);
value glstub_glDeleteTexturesEXT(value v0, value v1)
{
	CAMLparam2(v0, v1);
	GLsizei lv0 = Int_val(v0);
	GLuint* lv1 = Data_bigarray_val(v1);
	LOAD_FUNCTION(glDeleteTexturesEXT);
	(*stub_glDeleteTexturesEXT)(lv0, lv1);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glDeleteVertexArraysAPPLE,(GLsizei, GLuint*),void);
value glstub_glDeleteVertexArraysAPPLE(value v0, value v1)
{
	CAMLparam2(v0, v1);
	GLsizei lv0 = Int_val(v0);
	GLuint* lv1 = Data_bigarray_val(v1);
	LOAD_FUNCTION(glDeleteVertexArraysAPPLE);
	(*stub_glDeleteVertexArraysAPPLE)(lv0, lv1);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glDeleteVertexShaderEXT,(GLuint),void);
value glstub_glDeleteVertexShaderEXT(value v0)
{
	CAMLparam1(v0);
	GLuint lv0 = Int_val(v0);
	LOAD_FUNCTION(glDeleteVertexShaderEXT);
	(*stub_glDeleteVertexShaderEXT)(lv0);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glDepthBoundsEXT,(GLclampd, GLclampd),void);
value glstub_glDepthBoundsEXT(value v0, value v1)
{
	CAMLparam2(v0, v1);
	GLclampd lv0 = Double_val(v0);
	GLclampd lv1 = Double_val(v1);
	LOAD_FUNCTION(glDepthBoundsEXT);
	(*stub_glDepthBoundsEXT)(lv0, lv1);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glDepthBoundsdNV,(GLdouble, GLdouble),void);
value glstub_glDepthBoundsdNV(value v0, value v1)
{
	CAMLparam2(v0, v1);
	GLdouble lv0 = Double_val(v0);
	GLdouble lv1 = Double_val(v1);
	LOAD_FUNCTION(glDepthBoundsdNV);
	(*stub_glDepthBoundsdNV)(lv0, lv1);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glDepthFunc,(GLenum),void);
value glstub_glDepthFunc(value v0)
{
	CAMLparam1(v0);
	GLenum lv0 = Int_val(v0);
	LOAD_FUNCTION(glDepthFunc);
	(*stub_glDepthFunc)(lv0);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glDepthMask,(GLboolean),void);
value glstub_glDepthMask(value v0)
{
	CAMLparam1(v0);
	GLboolean lv0 = Bool_val(v0);
	LOAD_FUNCTION(glDepthMask);
	(*stub_glDepthMask)(lv0);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glDepthRange,(GLclampd, GLclampd),void);
value glstub_glDepthRange(value v0, value v1)
{
	CAMLparam2(v0, v1);
	GLclampd lv0 = Double_val(v0);
	GLclampd lv1 = Double_val(v1);
	LOAD_FUNCTION(glDepthRange);
	(*stub_glDepthRange)(lv0, lv1);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glDepthRangedNV,(GLdouble, GLdouble),void);
value glstub_glDepthRangedNV(value v0, value v1)
{
	CAMLparam2(v0, v1);
	GLdouble lv0 = Double_val(v0);
	GLdouble lv1 = Double_val(v1);
	LOAD_FUNCTION(glDepthRangedNV);
	(*stub_glDepthRangedNV)(lv0, lv1);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glDepthRangefOES,(GLclampf, GLclampf),void);
value glstub_glDepthRangefOES(value v0, value v1)
{
	CAMLparam2(v0, v1);
	GLclampf lv0 = Double_val(v0);
	GLclampf lv1 = Double_val(v1);
	LOAD_FUNCTION(glDepthRangefOES);
	(*stub_glDepthRangefOES)(lv0, lv1);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glDetachObjectARB,(GLuint, GLuint),void);
value glstub_glDetachObjectARB(value v0, value v1)
{
	CAMLparam2(v0, v1);
	GLuint lv0 = Int_val(v0);
	GLuint lv1 = Int_val(v1);
	LOAD_FUNCTION(glDetachObjectARB);
	(*stub_glDetachObjectARB)(lv0, lv1);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glDetachShader,(GLuint, GLuint),void);
value glstub_glDetachShader(value v0, value v1)
{
	CAMLparam2(v0, v1);
	GLuint lv0 = Int_val(v0);
	GLuint lv1 = Int_val(v1);
	LOAD_FUNCTION(glDetachShader);
	(*stub_glDetachShader)(lv0, lv1);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glDetailTexFuncSGIS,(GLenum, GLsizei, GLfloat*),void);
value glstub_glDetailTexFuncSGIS(value v0, value v1, value v2)
{
	CAMLparam3(v0, v1, v2);
	GLenum lv0 = Int_val(v0);
	GLsizei lv1 = Int_val(v1);
	GLfloat* lv2 = Data_bigarray_val(v2);
	LOAD_FUNCTION(glDetailTexFuncSGIS);
	(*stub_glDetailTexFuncSGIS)(lv0, lv1, lv2);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glDisable,(GLenum),void);
value glstub_glDisable(value v0)
{
	CAMLparam1(v0);
	GLenum lv0 = Int_val(v0);
	LOAD_FUNCTION(glDisable);
	(*stub_glDisable)(lv0);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glDisableClientState,(GLenum),void);
value glstub_glDisableClientState(value v0)
{
	CAMLparam1(v0);
	GLenum lv0 = Int_val(v0);
	LOAD_FUNCTION(glDisableClientState);
	(*stub_glDisableClientState)(lv0);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glDisableIndexedEXT,(GLenum, GLuint),void);
value glstub_glDisableIndexedEXT(value v0, value v1)
{
	CAMLparam2(v0, v1);
	GLenum lv0 = Int_val(v0);
	GLuint lv1 = Int_val(v1);
	LOAD_FUNCTION(glDisableIndexedEXT);
	(*stub_glDisableIndexedEXT)(lv0, lv1);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glDisableVariantClientStateEXT,(GLuint),void);
value glstub_glDisableVariantClientStateEXT(value v0)
{
	CAMLparam1(v0);
	GLuint lv0 = Int_val(v0);
	LOAD_FUNCTION(glDisableVariantClientStateEXT);
	(*stub_glDisableVariantClientStateEXT)(lv0);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glDisableVertexAttribArray,(GLuint),void);
value glstub_glDisableVertexAttribArray(value v0)
{
	CAMLparam1(v0);
	GLuint lv0 = Int_val(v0);
	LOAD_FUNCTION(glDisableVertexAttribArray);
	(*stub_glDisableVertexAttribArray)(lv0);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glDisableVertexAttribArrayARB,(GLuint),void);
value glstub_glDisableVertexAttribArrayARB(value v0)
{
	CAMLparam1(v0);
	GLuint lv0 = Int_val(v0);
	LOAD_FUNCTION(glDisableVertexAttribArrayARB);
	(*stub_glDisableVertexAttribArrayARB)(lv0);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glDrawArrays,(GLenum, GLint, GLsizei),void);
value glstub_glDrawArrays(value v0, value v1, value v2)
{
	CAMLparam3(v0, v1, v2);
	GLenum lv0 = Int_val(v0);
	GLint lv1 = Int_val(v1);
	GLsizei lv2 = Int_val(v2);
	LOAD_FUNCTION(glDrawArrays);
	(*stub_glDrawArrays)(lv0, lv1, lv2);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glDrawArraysEXT,(GLenum, GLint, GLsizei),void);
value glstub_glDrawArraysEXT(value v0, value v1, value v2)
{
	CAMLparam3(v0, v1, v2);
	GLenum lv0 = Int_val(v0);
	GLint lv1 = Int_val(v1);
	GLsizei lv2 = Int_val(v2);
	LOAD_FUNCTION(glDrawArraysEXT);
	(*stub_glDrawArraysEXT)(lv0, lv1, lv2);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glDrawArraysInstancedEXT,(GLenum, GLint, GLsizei, GLsizei),void);
value glstub_glDrawArraysInstancedEXT(value v0, value v1, value v2, value v3)
{
	CAMLparam4(v0, v1, v2, v3);
	GLenum lv0 = Int_val(v0);
	GLint lv1 = Int_val(v1);
	GLsizei lv2 = Int_val(v2);
	GLsizei lv3 = Int_val(v3);
	LOAD_FUNCTION(glDrawArraysInstancedEXT);
	(*stub_glDrawArraysInstancedEXT)(lv0, lv1, lv2, lv3);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glDrawBuffer,(GLenum),void);
value glstub_glDrawBuffer(value v0)
{
	CAMLparam1(v0);
	GLenum lv0 = Int_val(v0);
	LOAD_FUNCTION(glDrawBuffer);
	(*stub_glDrawBuffer)(lv0);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glDrawBufferRegionEXT,(GLuint, GLint, GLint, GLsizei, GLsizei, GLint, GLint),void);
value glstub_glDrawBufferRegionEXT(value v0, value v1, value v2, value v3, value v4, value v5, value v6)
{
	CAMLparam5(v0, v1, v2, v3, v4);
	CAMLxparam2(v5, v6);
	GLuint lv0 = Int_val(v0);
	GLint lv1 = Int_val(v1);
	GLint lv2 = Int_val(v2);
	GLsizei lv3 = Int_val(v3);
	GLsizei lv4 = Int_val(v4);
	GLint lv5 = Int_val(v5);
	GLint lv6 = Int_val(v6);
	LOAD_FUNCTION(glDrawBufferRegionEXT);
	(*stub_glDrawBufferRegionEXT)(lv0, lv1, lv2, lv3, lv4, lv5, lv6);
	CAMLreturn(Val_unit);
}

value glstub_glDrawBufferRegionEXT_byte(value * argv, int n)
{
	return glstub_glDrawBufferRegionEXT(argv[0], argv[1], argv[2], argv[3], argv[4], argv[5], argv[6]);
}

DECLARE_FUNCTION(glDrawBuffers,(GLsizei, GLenum*),void);
value glstub_glDrawBuffers(value v0, value v1)
{
	CAMLparam2(v0, v1);
	GLsizei lv0 = Int_val(v0);
	GLenum* lv1 = Data_bigarray_val(v1);
	LOAD_FUNCTION(glDrawBuffers);
	(*stub_glDrawBuffers)(lv0, lv1);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glDrawBuffersARB,(GLsizei, GLenum*),void);
value glstub_glDrawBuffersARB(value v0, value v1)
{
	CAMLparam2(v0, v1);
	GLsizei lv0 = Int_val(v0);
	GLenum* lv1 = Data_bigarray_val(v1);
	LOAD_FUNCTION(glDrawBuffersARB);
	(*stub_glDrawBuffersARB)(lv0, lv1);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glDrawBuffersATI,(GLsizei, GLenum*),void);
value glstub_glDrawBuffersATI(value v0, value v1)
{
	CAMLparam2(v0, v1);
	GLsizei lv0 = Int_val(v0);
	GLenum* lv1 = Data_bigarray_val(v1);
	LOAD_FUNCTION(glDrawBuffersATI);
	(*stub_glDrawBuffersATI)(lv0, lv1);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glDrawElementArrayAPPLE,(GLenum, GLint, GLsizei),void);
value glstub_glDrawElementArrayAPPLE(value v0, value v1, value v2)
{
	CAMLparam3(v0, v1, v2);
	GLenum lv0 = Int_val(v0);
	GLint lv1 = Int_val(v1);
	GLsizei lv2 = Int_val(v2);
	LOAD_FUNCTION(glDrawElementArrayAPPLE);
	(*stub_glDrawElementArrayAPPLE)(lv0, lv1, lv2);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glDrawElementArrayATI,(GLenum, GLsizei),void);
value glstub_glDrawElementArrayATI(value v0, value v1)
{
	CAMLparam2(v0, v1);
	GLenum lv0 = Int_val(v0);
	GLsizei lv1 = Int_val(v1);
	LOAD_FUNCTION(glDrawElementArrayATI);
	(*stub_glDrawElementArrayATI)(lv0, lv1);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glDrawElements,(GLenum, GLsizei, GLenum, GLvoid*),void);
value glstub_glDrawElements(value v0, value v1, value v2, value v3)
{
	CAMLparam4(v0, v1, v2, v3);
	GLenum lv0 = Int_val(v0);
	GLsizei lv1 = Int_val(v1);
	GLenum lv2 = Int_val(v2);
	GLvoid* lv3 = (GLvoid *)((Tag_val(v3) == String_tag)? (String_val(v3)) : (Data_bigarray_val(v3)));
	LOAD_FUNCTION(glDrawElements);
	(*stub_glDrawElements)(lv0, lv1, lv2, lv3);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glDrawElementsInstancedEXT,(GLenum, GLsizei, GLenum, GLvoid*, GLsizei),void);
value glstub_glDrawElementsInstancedEXT(value v0, value v1, value v2, value v3, value v4)
{
	CAMLparam5(v0, v1, v2, v3, v4);
	GLenum lv0 = Int_val(v0);
	GLsizei lv1 = Int_val(v1);
	GLenum lv2 = Int_val(v2);
	GLvoid* lv3 = (GLvoid *)((Tag_val(v3) == String_tag)? (String_val(v3)) : (Data_bigarray_val(v3)));
	GLsizei lv4 = Int_val(v4);
	LOAD_FUNCTION(glDrawElementsInstancedEXT);
	(*stub_glDrawElementsInstancedEXT)(lv0, lv1, lv2, lv3, lv4);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glDrawPixels,(GLsizei, GLsizei, GLenum, GLenum, GLvoid*),void);
value glstub_glDrawPixels(value v0, value v1, value v2, value v3, value v4)
{
	CAMLparam5(v0, v1, v2, v3, v4);
	GLsizei lv0 = Int_val(v0);
	GLsizei lv1 = Int_val(v1);
	GLenum lv2 = Int_val(v2);
	GLenum lv3 = Int_val(v3);
	GLvoid* lv4 = (GLvoid *)((Tag_val(v4) == String_tag)? (String_val(v4)) : (Data_bigarray_val(v4)));
	LOAD_FUNCTION(glDrawPixels);
	(*stub_glDrawPixels)(lv0, lv1, lv2, lv3, lv4);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glDrawRangeElementArrayAPPLE,(GLenum, GLuint, GLuint, GLint, GLsizei),void);
value glstub_glDrawRangeElementArrayAPPLE(value v0, value v1, value v2, value v3, value v4)
{
	CAMLparam5(v0, v1, v2, v3, v4);
	GLenum lv0 = Int_val(v0);
	GLuint lv1 = Int_val(v1);
	GLuint lv2 = Int_val(v2);
	GLint lv3 = Int_val(v3);
	GLsizei lv4 = Int_val(v4);
	LOAD_FUNCTION(glDrawRangeElementArrayAPPLE);
	(*stub_glDrawRangeElementArrayAPPLE)(lv0, lv1, lv2, lv3, lv4);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glDrawRangeElementArrayATI,(GLenum, GLuint, GLuint, GLsizei),void);
value glstub_glDrawRangeElementArrayATI(value v0, value v1, value v2, value v3)
{
	CAMLparam4(v0, v1, v2, v3);
	GLenum lv0 = Int_val(v0);
	GLuint lv1 = Int_val(v1);
	GLuint lv2 = Int_val(v2);
	GLsizei lv3 = Int_val(v3);
	LOAD_FUNCTION(glDrawRangeElementArrayATI);
	(*stub_glDrawRangeElementArrayATI)(lv0, lv1, lv2, lv3);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glDrawRangeElements,(GLenum, GLuint, GLuint, GLsizei, GLenum, GLvoid*),void);
value glstub_glDrawRangeElements(value v0, value v1, value v2, value v3, value v4, value v5)
{
	CAMLparam5(v0, v1, v2, v3, v4);
	CAMLxparam1(v5);
	GLenum lv0 = Int_val(v0);
	GLuint lv1 = Int_val(v1);
	GLuint lv2 = Int_val(v2);
	GLsizei lv3 = Int_val(v3);
	GLenum lv4 = Int_val(v4);
	GLvoid* lv5 = (GLvoid *)((Tag_val(v5) == String_tag)? (String_val(v5)) : (Data_bigarray_val(v5)));
	LOAD_FUNCTION(glDrawRangeElements);
	(*stub_glDrawRangeElements)(lv0, lv1, lv2, lv3, lv4, lv5);
	CAMLreturn(Val_unit);
}

value glstub_glDrawRangeElements_byte(value * argv, int n)
{
	return glstub_glDrawRangeElements(argv[0], argv[1], argv[2], argv[3], argv[4], argv[5]);
}

DECLARE_FUNCTION(glDrawRangeElementsEXT,(GLenum, GLuint, GLuint, GLsizei, GLenum, GLvoid*),void);
value glstub_glDrawRangeElementsEXT(value v0, value v1, value v2, value v3, value v4, value v5)
{
	CAMLparam5(v0, v1, v2, v3, v4);
	CAMLxparam1(v5);
	GLenum lv0 = Int_val(v0);
	GLuint lv1 = Int_val(v1);
	GLuint lv2 = Int_val(v2);
	GLsizei lv3 = Int_val(v3);
	GLenum lv4 = Int_val(v4);
	GLvoid* lv5 = (GLvoid *)((Tag_val(v5) == String_tag)? (String_val(v5)) : (Data_bigarray_val(v5)));
	LOAD_FUNCTION(glDrawRangeElementsEXT);
	(*stub_glDrawRangeElementsEXT)(lv0, lv1, lv2, lv3, lv4, lv5);
	CAMLreturn(Val_unit);
}

value glstub_glDrawRangeElementsEXT_byte(value * argv, int n)
{
	return glstub_glDrawRangeElementsEXT(argv[0], argv[1], argv[2], argv[3], argv[4], argv[5]);
}

DECLARE_FUNCTION(glEdgeFlag,(GLboolean),void);
value glstub_glEdgeFlag(value v0)
{
	CAMLparam1(v0);
	GLboolean lv0 = Bool_val(v0);
	LOAD_FUNCTION(glEdgeFlag);
	(*stub_glEdgeFlag)(lv0);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glEdgeFlagPointer,(GLsizei, GLvoid*),void);
value glstub_glEdgeFlagPointer(value v0, value v1)
{
	CAMLparam2(v0, v1);
	GLsizei lv0 = Int_val(v0);
	GLvoid* lv1 = (GLvoid *)((Tag_val(v1) == String_tag)? (String_val(v1)) : (Data_bigarray_val(v1)));
	LOAD_FUNCTION(glEdgeFlagPointer);
	(*stub_glEdgeFlagPointer)(lv0, lv1);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glEdgeFlagPointerEXT,(GLsizei, GLsizei, GLboolean*),void);
value glstub_glEdgeFlagPointerEXT(value v0, value v1, value v2)
{
	CAMLparam3(v0, v1, v2);
	GLsizei lv0 = Int_val(v0);
	GLsizei lv1 = Int_val(v1);
	GLboolean* lv2 = Data_bigarray_val(v2);
	LOAD_FUNCTION(glEdgeFlagPointerEXT);
	(*stub_glEdgeFlagPointerEXT)(lv0, lv1, lv2);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glEdgeFlagPointerListIBM,(GLint, GLboolean**, GLint),void);
value glstub_glEdgeFlagPointerListIBM(value v0, value v1, value v2)
{
	CAMLparam3(v0, v1, v2);
	GLint lv0 = Int_val(v0);
	GLboolean** lv1 = Data_bigarray_val(v1);
	GLint lv2 = Int_val(v2);
	LOAD_FUNCTION(glEdgeFlagPointerListIBM);
	(*stub_glEdgeFlagPointerListIBM)(lv0, lv1, lv2);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glEdgeFlagv,(GLboolean*),void);
value glstub_glEdgeFlagv(value v0)
{
	CAMLparam1(v0);
	GLboolean* lv0 = Data_bigarray_val(v0);
	LOAD_FUNCTION(glEdgeFlagv);
	(*stub_glEdgeFlagv)(lv0);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glElementPointerAPPLE,(GLenum, GLvoid*),void);
value glstub_glElementPointerAPPLE(value v0, value v1)
{
	CAMLparam2(v0, v1);
	GLenum lv0 = Int_val(v0);
	GLvoid* lv1 = (GLvoid *)((Tag_val(v1) == String_tag)? (String_val(v1)) : (Data_bigarray_val(v1)));
	LOAD_FUNCTION(glElementPointerAPPLE);
	(*stub_glElementPointerAPPLE)(lv0, lv1);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glElementPointerATI,(GLenum, GLvoid*),void);
value glstub_glElementPointerATI(value v0, value v1)
{
	CAMLparam2(v0, v1);
	GLenum lv0 = Int_val(v0);
	GLvoid* lv1 = (GLvoid *)((Tag_val(v1) == String_tag)? (String_val(v1)) : (Data_bigarray_val(v1)));
	LOAD_FUNCTION(glElementPointerATI);
	(*stub_glElementPointerATI)(lv0, lv1);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glEnable,(GLenum),void);
value glstub_glEnable(value v0)
{
	CAMLparam1(v0);
	GLenum lv0 = Int_val(v0);
	LOAD_FUNCTION(glEnable);
	(*stub_glEnable)(lv0);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glEnableClientState,(GLenum),void);
value glstub_glEnableClientState(value v0)
{
	CAMLparam1(v0);
	GLenum lv0 = Int_val(v0);
	LOAD_FUNCTION(glEnableClientState);
	(*stub_glEnableClientState)(lv0);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glEnableIndexedEXT,(GLenum, GLuint),void);
value glstub_glEnableIndexedEXT(value v0, value v1)
{
	CAMLparam2(v0, v1);
	GLenum lv0 = Int_val(v0);
	GLuint lv1 = Int_val(v1);
	LOAD_FUNCTION(glEnableIndexedEXT);
	(*stub_glEnableIndexedEXT)(lv0, lv1);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glEnableVariantClientStateEXT,(GLuint),void);
value glstub_glEnableVariantClientStateEXT(value v0)
{
	CAMLparam1(v0);
	GLuint lv0 = Int_val(v0);
	LOAD_FUNCTION(glEnableVariantClientStateEXT);
	(*stub_glEnableVariantClientStateEXT)(lv0);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glEnableVertexAttribArray,(GLuint),void);
value glstub_glEnableVertexAttribArray(value v0)
{
	CAMLparam1(v0);
	GLuint lv0 = Int_val(v0);
	LOAD_FUNCTION(glEnableVertexAttribArray);
	(*stub_glEnableVertexAttribArray)(lv0);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glEnableVertexAttribArrayARB,(GLuint),void);
value glstub_glEnableVertexAttribArrayARB(value v0)
{
	CAMLparam1(v0);
	GLuint lv0 = Int_val(v0);
	LOAD_FUNCTION(glEnableVertexAttribArrayARB);
	(*stub_glEnableVertexAttribArrayARB)(lv0);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glEnd,(void),void);
value glstub_glEnd(value v0)
{
	CAMLparam1(v0);
	LOAD_FUNCTION(glEnd);
	(*stub_glEnd)();
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glEndFragmentShaderATI,(void),void);
value glstub_glEndFragmentShaderATI(value v0)
{
	CAMLparam1(v0);
	LOAD_FUNCTION(glEndFragmentShaderATI);
	(*stub_glEndFragmentShaderATI)();
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glEndList,(void),void);
value glstub_glEndList(value v0)
{
	CAMLparam1(v0);
	LOAD_FUNCTION(glEndList);
	(*stub_glEndList)();
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glEndOcclusionQueryNV,(void),void);
value glstub_glEndOcclusionQueryNV(value v0)
{
	CAMLparam1(v0);
	LOAD_FUNCTION(glEndOcclusionQueryNV);
	(*stub_glEndOcclusionQueryNV)();
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glEndQuery,(GLenum),void);
value glstub_glEndQuery(value v0)
{
	CAMLparam1(v0);
	GLenum lv0 = Int_val(v0);
	LOAD_FUNCTION(glEndQuery);
	(*stub_glEndQuery)(lv0);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glEndQueryARB,(GLenum),void);
value glstub_glEndQueryARB(value v0)
{
	CAMLparam1(v0);
	GLenum lv0 = Int_val(v0);
	LOAD_FUNCTION(glEndQueryARB);
	(*stub_glEndQueryARB)(lv0);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glEndSceneEXT,(void),void);
value glstub_glEndSceneEXT(value v0)
{
	CAMLparam1(v0);
	LOAD_FUNCTION(glEndSceneEXT);
	(*stub_glEndSceneEXT)();
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glEndTransformFeedbackNV,(void),void);
value glstub_glEndTransformFeedbackNV(value v0)
{
	CAMLparam1(v0);
	LOAD_FUNCTION(glEndTransformFeedbackNV);
	(*stub_glEndTransformFeedbackNV)();
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glEndVertexShaderEXT,(void),void);
value glstub_glEndVertexShaderEXT(value v0)
{
	CAMLparam1(v0);
	LOAD_FUNCTION(glEndVertexShaderEXT);
	(*stub_glEndVertexShaderEXT)();
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glEvalCoord1d,(GLdouble),void);
value glstub_glEvalCoord1d(value v0)
{
	CAMLparam1(v0);
	GLdouble lv0 = Double_val(v0);
	LOAD_FUNCTION(glEvalCoord1d);
	(*stub_glEvalCoord1d)(lv0);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glEvalCoord1dv,(GLdouble*),void);
value glstub_glEvalCoord1dv(value v0)
{
	CAMLparam1(v0);
	GLdouble* lv0 = (Tag_val(v0) == Double_array_tag)? (double *)v0: Data_bigarray_val(v0);
	LOAD_FUNCTION(glEvalCoord1dv);
	(*stub_glEvalCoord1dv)(lv0);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glEvalCoord1f,(GLfloat),void);
value glstub_glEvalCoord1f(value v0)
{
	CAMLparam1(v0);
	GLfloat lv0 = Double_val(v0);
	LOAD_FUNCTION(glEvalCoord1f);
	(*stub_glEvalCoord1f)(lv0);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glEvalCoord1fv,(GLfloat*),void);
value glstub_glEvalCoord1fv(value v0)
{
	CAMLparam1(v0);
	GLfloat* lv0 = Data_bigarray_val(v0);
	LOAD_FUNCTION(glEvalCoord1fv);
	(*stub_glEvalCoord1fv)(lv0);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glEvalCoord2d,(GLdouble, GLdouble),void);
value glstub_glEvalCoord2d(value v0, value v1)
{
	CAMLparam2(v0, v1);
	GLdouble lv0 = Double_val(v0);
	GLdouble lv1 = Double_val(v1);
	LOAD_FUNCTION(glEvalCoord2d);
	(*stub_glEvalCoord2d)(lv0, lv1);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glEvalCoord2dv,(GLdouble*),void);
value glstub_glEvalCoord2dv(value v0)
{
	CAMLparam1(v0);
	GLdouble* lv0 = (Tag_val(v0) == Double_array_tag)? (double *)v0: Data_bigarray_val(v0);
	LOAD_FUNCTION(glEvalCoord2dv);
	(*stub_glEvalCoord2dv)(lv0);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glEvalCoord2f,(GLfloat, GLfloat),void);
value glstub_glEvalCoord2f(value v0, value v1)
{
	CAMLparam2(v0, v1);
	GLfloat lv0 = Double_val(v0);
	GLfloat lv1 = Double_val(v1);
	LOAD_FUNCTION(glEvalCoord2f);
	(*stub_glEvalCoord2f)(lv0, lv1);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glEvalCoord2fv,(GLfloat*),void);
value glstub_glEvalCoord2fv(value v0)
{
	CAMLparam1(v0);
	GLfloat* lv0 = Data_bigarray_val(v0);
	LOAD_FUNCTION(glEvalCoord2fv);
	(*stub_glEvalCoord2fv)(lv0);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glEvalMapsNV,(GLenum, GLenum),void);
value glstub_glEvalMapsNV(value v0, value v1)
{
	CAMLparam2(v0, v1);
	GLenum lv0 = Int_val(v0);
	GLenum lv1 = Int_val(v1);
	LOAD_FUNCTION(glEvalMapsNV);
	(*stub_glEvalMapsNV)(lv0, lv1);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glEvalMesh1,(GLenum, GLint, GLint),void);
value glstub_glEvalMesh1(value v0, value v1, value v2)
{
	CAMLparam3(v0, v1, v2);
	GLenum lv0 = Int_val(v0);
	GLint lv1 = Int_val(v1);
	GLint lv2 = Int_val(v2);
	LOAD_FUNCTION(glEvalMesh1);
	(*stub_glEvalMesh1)(lv0, lv1, lv2);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glEvalMesh2,(GLenum, GLint, GLint, GLint, GLint),void);
value glstub_glEvalMesh2(value v0, value v1, value v2, value v3, value v4)
{
	CAMLparam5(v0, v1, v2, v3, v4);
	GLenum lv0 = Int_val(v0);
	GLint lv1 = Int_val(v1);
	GLint lv2 = Int_val(v2);
	GLint lv3 = Int_val(v3);
	GLint lv4 = Int_val(v4);
	LOAD_FUNCTION(glEvalMesh2);
	(*stub_glEvalMesh2)(lv0, lv1, lv2, lv3, lv4);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glEvalPoint1,(GLint),void);
value glstub_glEvalPoint1(value v0)
{
	CAMLparam1(v0);
	GLint lv0 = Int_val(v0);
	LOAD_FUNCTION(glEvalPoint1);
	(*stub_glEvalPoint1)(lv0);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glEvalPoint2,(GLint, GLint),void);
value glstub_glEvalPoint2(value v0, value v1)
{
	CAMLparam2(v0, v1);
	GLint lv0 = Int_val(v0);
	GLint lv1 = Int_val(v1);
	LOAD_FUNCTION(glEvalPoint2);
	(*stub_glEvalPoint2)(lv0, lv1);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glExecuteProgramNV,(GLenum, GLuint, GLfloat*),void);
value glstub_glExecuteProgramNV(value v0, value v1, value v2)
{
	CAMLparam3(v0, v1, v2);
	GLenum lv0 = Int_val(v0);
	GLuint lv1 = Int_val(v1);
	GLfloat* lv2 = Data_bigarray_val(v2);
	LOAD_FUNCTION(glExecuteProgramNV);
	(*stub_glExecuteProgramNV)(lv0, lv1, lv2);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glExtractComponentEXT,(GLuint, GLuint, GLuint),void);
value glstub_glExtractComponentEXT(value v0, value v1, value v2)
{
	CAMLparam3(v0, v1, v2);
	GLuint lv0 = Int_val(v0);
	GLuint lv1 = Int_val(v1);
	GLuint lv2 = Int_val(v2);
	LOAD_FUNCTION(glExtractComponentEXT);
	(*stub_glExtractComponentEXT)(lv0, lv1, lv2);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glFeedbackBuffer,(GLsizei, GLenum, GLfloat*),void);
value glstub_glFeedbackBuffer(value v0, value v1, value v2)
{
	CAMLparam3(v0, v1, v2);
	GLsizei lv0 = Int_val(v0);
	GLenum lv1 = Int_val(v1);
	GLfloat* lv2 = Data_bigarray_val(v2);
	LOAD_FUNCTION(glFeedbackBuffer);
	(*stub_glFeedbackBuffer)(lv0, lv1, lv2);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glFinalCombinerInputNV,(GLenum, GLenum, GLenum, GLenum),void);
value glstub_glFinalCombinerInputNV(value v0, value v1, value v2, value v3)
{
	CAMLparam4(v0, v1, v2, v3);
	GLenum lv0 = Int_val(v0);
	GLenum lv1 = Int_val(v1);
	GLenum lv2 = Int_val(v2);
	GLenum lv3 = Int_val(v3);
	LOAD_FUNCTION(glFinalCombinerInputNV);
	(*stub_glFinalCombinerInputNV)(lv0, lv1, lv2, lv3);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glFinish,(void),void);
value glstub_glFinish(value v0)
{
	CAMLparam1(v0);
	LOAD_FUNCTION(glFinish);
	(*stub_glFinish)();
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glFinishAsyncSGIX,(GLuint*),GLint);
value glstub_glFinishAsyncSGIX(value v0)
{
	CAMLparam1(v0);
	CAMLlocal1(result);
	GLuint* lv0 = Data_bigarray_val(v0);
	GLint ret;
	LOAD_FUNCTION(glFinishAsyncSGIX);
	ret = (*stub_glFinishAsyncSGIX)(lv0);
	result = Val_int(ret);
	CAMLreturn(result);
}

DECLARE_FUNCTION(glFinishFenceAPPLE,(GLuint),void);
value glstub_glFinishFenceAPPLE(value v0)
{
	CAMLparam1(v0);
	GLuint lv0 = Int_val(v0);
	LOAD_FUNCTION(glFinishFenceAPPLE);
	(*stub_glFinishFenceAPPLE)(lv0);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glFinishFenceNV,(GLuint),void);
value glstub_glFinishFenceNV(value v0)
{
	CAMLparam1(v0);
	GLuint lv0 = Int_val(v0);
	LOAD_FUNCTION(glFinishFenceNV);
	(*stub_glFinishFenceNV)(lv0);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glFinishObjectAPPLE,(GLenum, GLint),void);
value glstub_glFinishObjectAPPLE(value v0, value v1)
{
	CAMLparam2(v0, v1);
	GLenum lv0 = Int_val(v0);
	GLint lv1 = Int_val(v1);
	LOAD_FUNCTION(glFinishObjectAPPLE);
	(*stub_glFinishObjectAPPLE)(lv0, lv1);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glFinishTextureSUNX,(void),void);
value glstub_glFinishTextureSUNX(value v0)
{
	CAMLparam1(v0);
	LOAD_FUNCTION(glFinishTextureSUNX);
	(*stub_glFinishTextureSUNX)();
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glFlush,(void),void);
value glstub_glFlush(value v0)
{
	CAMLparam1(v0);
	LOAD_FUNCTION(glFlush);
	(*stub_glFlush)();
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glFlushPixelDataRangeNV,(GLenum),void);
value glstub_glFlushPixelDataRangeNV(value v0)
{
	CAMLparam1(v0);
	GLenum lv0 = Int_val(v0);
	LOAD_FUNCTION(glFlushPixelDataRangeNV);
	(*stub_glFlushPixelDataRangeNV)(lv0);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glFlushRasterSGIX,(void),void);
value glstub_glFlushRasterSGIX(value v0)
{
	CAMLparam1(v0);
	LOAD_FUNCTION(glFlushRasterSGIX);
	(*stub_glFlushRasterSGIX)();
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glFlushVertexArrayRangeAPPLE,(GLsizei, GLvoid*),void);
value glstub_glFlushVertexArrayRangeAPPLE(value v0, value v1)
{
	CAMLparam2(v0, v1);
	GLsizei lv0 = Int_val(v0);
	GLvoid* lv1 = (GLvoid *)((Tag_val(v1) == String_tag)? (String_val(v1)) : (Data_bigarray_val(v1)));
	LOAD_FUNCTION(glFlushVertexArrayRangeAPPLE);
	(*stub_glFlushVertexArrayRangeAPPLE)(lv0, lv1);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glFlushVertexArrayRangeNV,(void),void);
value glstub_glFlushVertexArrayRangeNV(value v0)
{
	CAMLparam1(v0);
	LOAD_FUNCTION(glFlushVertexArrayRangeNV);
	(*stub_glFlushVertexArrayRangeNV)();
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glFogCoordPointer,(GLenum, GLsizei, GLvoid*),void);
value glstub_glFogCoordPointer(value v0, value v1, value v2)
{
	CAMLparam3(v0, v1, v2);
	GLenum lv0 = Int_val(v0);
	GLsizei lv1 = Int_val(v1);
	GLvoid* lv2 = (GLvoid *)((Tag_val(v2) == String_tag)? (String_val(v2)) : (Data_bigarray_val(v2)));
	LOAD_FUNCTION(glFogCoordPointer);
	(*stub_glFogCoordPointer)(lv0, lv1, lv2);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glFogCoordPointerEXT,(GLenum, GLsizei, GLvoid*),void);
value glstub_glFogCoordPointerEXT(value v0, value v1, value v2)
{
	CAMLparam3(v0, v1, v2);
	GLenum lv0 = Int_val(v0);
	GLsizei lv1 = Int_val(v1);
	GLvoid* lv2 = (GLvoid *)((Tag_val(v2) == String_tag)? (String_val(v2)) : (Data_bigarray_val(v2)));
	LOAD_FUNCTION(glFogCoordPointerEXT);
	(*stub_glFogCoordPointerEXT)(lv0, lv1, lv2);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glFogCoordPointerListIBM,(GLenum, GLint, GLvoid**, GLint),void);
value glstub_glFogCoordPointerListIBM(value v0, value v1, value v2, value v3)
{
	CAMLparam4(v0, v1, v2, v3);
	GLenum lv0 = Int_val(v0);
	GLint lv1 = Int_val(v1);
	GLvoid** lv2 = Data_bigarray_val(v2);
	GLint lv3 = Int_val(v3);
	LOAD_FUNCTION(glFogCoordPointerListIBM);
	(*stub_glFogCoordPointerListIBM)(lv0, lv1, lv2, lv3);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glFogCoordd,(GLdouble),void);
value glstub_glFogCoordd(value v0)
{
	CAMLparam1(v0);
	GLdouble lv0 = Double_val(v0);
	LOAD_FUNCTION(glFogCoordd);
	(*stub_glFogCoordd)(lv0);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glFogCoorddEXT,(GLdouble),void);
value glstub_glFogCoorddEXT(value v0)
{
	CAMLparam1(v0);
	GLdouble lv0 = Double_val(v0);
	LOAD_FUNCTION(glFogCoorddEXT);
	(*stub_glFogCoorddEXT)(lv0);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glFogCoorddv,(GLdouble*),void);
value glstub_glFogCoorddv(value v0)
{
	CAMLparam1(v0);
	GLdouble* lv0 = (Tag_val(v0) == Double_array_tag)? (double *)v0: Data_bigarray_val(v0);
	LOAD_FUNCTION(glFogCoorddv);
	(*stub_glFogCoorddv)(lv0);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glFogCoorddvEXT,(GLdouble*),void);
value glstub_glFogCoorddvEXT(value v0)
{
	CAMLparam1(v0);
	GLdouble* lv0 = (Tag_val(v0) == Double_array_tag)? (double *)v0: Data_bigarray_val(v0);
	LOAD_FUNCTION(glFogCoorddvEXT);
	(*stub_glFogCoorddvEXT)(lv0);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glFogCoordf,(GLfloat),void);
value glstub_glFogCoordf(value v0)
{
	CAMLparam1(v0);
	GLfloat lv0 = Double_val(v0);
	LOAD_FUNCTION(glFogCoordf);
	(*stub_glFogCoordf)(lv0);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glFogCoordfEXT,(GLfloat),void);
value glstub_glFogCoordfEXT(value v0)
{
	CAMLparam1(v0);
	GLfloat lv0 = Double_val(v0);
	LOAD_FUNCTION(glFogCoordfEXT);
	(*stub_glFogCoordfEXT)(lv0);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glFogCoordfv,(GLfloat*),void);
value glstub_glFogCoordfv(value v0)
{
	CAMLparam1(v0);
	GLfloat* lv0 = Data_bigarray_val(v0);
	LOAD_FUNCTION(glFogCoordfv);
	(*stub_glFogCoordfv)(lv0);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glFogCoordfvEXT,(GLfloat*),void);
value glstub_glFogCoordfvEXT(value v0)
{
	CAMLparam1(v0);
	GLfloat* lv0 = Data_bigarray_val(v0);
	LOAD_FUNCTION(glFogCoordfvEXT);
	(*stub_glFogCoordfvEXT)(lv0);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glFogCoordhNV,(GLushort),void);
value glstub_glFogCoordhNV(value v0)
{
	CAMLparam1(v0);
	GLushort lv0 = Int_val(v0);
	LOAD_FUNCTION(glFogCoordhNV);
	(*stub_glFogCoordhNV)(lv0);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glFogCoordhvNV,(GLushort*),void);
value glstub_glFogCoordhvNV(value v0)
{
	CAMLparam1(v0);
	GLushort* lv0 = Data_bigarray_val(v0);
	LOAD_FUNCTION(glFogCoordhvNV);
	(*stub_glFogCoordhvNV)(lv0);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glFogFuncSGIS,(GLsizei, GLfloat*),void);
value glstub_glFogFuncSGIS(value v0, value v1)
{
	CAMLparam2(v0, v1);
	GLsizei lv0 = Int_val(v0);
	GLfloat* lv1 = Data_bigarray_val(v1);
	LOAD_FUNCTION(glFogFuncSGIS);
	(*stub_glFogFuncSGIS)(lv0, lv1);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glFogf,(GLenum, GLfloat),void);
value glstub_glFogf(value v0, value v1)
{
	CAMLparam2(v0, v1);
	GLenum lv0 = Int_val(v0);
	GLfloat lv1 = Double_val(v1);
	LOAD_FUNCTION(glFogf);
	(*stub_glFogf)(lv0, lv1);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glFogfv,(GLenum, GLfloat*),void);
value glstub_glFogfv(value v0, value v1)
{
	CAMLparam2(v0, v1);
	GLenum lv0 = Int_val(v0);
	GLfloat* lv1 = Data_bigarray_val(v1);
	LOAD_FUNCTION(glFogfv);
	(*stub_glFogfv)(lv0, lv1);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glFogi,(GLenum, GLint),void);
value glstub_glFogi(value v0, value v1)
{
	CAMLparam2(v0, v1);
	GLenum lv0 = Int_val(v0);
	GLint lv1 = Int_val(v1);
	LOAD_FUNCTION(glFogi);
	(*stub_glFogi)(lv0, lv1);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glFogiv,(GLenum, GLint*),void);
value glstub_glFogiv(value v0, value v1)
{
	CAMLparam2(v0, v1);
	GLenum lv0 = Int_val(v0);
	GLint* lv1 = Data_bigarray_val(v1);
	LOAD_FUNCTION(glFogiv);
	(*stub_glFogiv)(lv0, lv1);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glFragmentColorMaterialEXT,(GLenum, GLenum),void);
value glstub_glFragmentColorMaterialEXT(value v0, value v1)
{
	CAMLparam2(v0, v1);
	GLenum lv0 = Int_val(v0);
	GLenum lv1 = Int_val(v1);
	LOAD_FUNCTION(glFragmentColorMaterialEXT);
	(*stub_glFragmentColorMaterialEXT)(lv0, lv1);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glFragmentColorMaterialSGIX,(GLenum, GLenum),void);
value glstub_glFragmentColorMaterialSGIX(value v0, value v1)
{
	CAMLparam2(v0, v1);
	GLenum lv0 = Int_val(v0);
	GLenum lv1 = Int_val(v1);
	LOAD_FUNCTION(glFragmentColorMaterialSGIX);
	(*stub_glFragmentColorMaterialSGIX)(lv0, lv1);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glFragmentLightModelfEXT,(GLenum, GLfloat),void);
value glstub_glFragmentLightModelfEXT(value v0, value v1)
{
	CAMLparam2(v0, v1);
	GLenum lv0 = Int_val(v0);
	GLfloat lv1 = Double_val(v1);
	LOAD_FUNCTION(glFragmentLightModelfEXT);
	(*stub_glFragmentLightModelfEXT)(lv0, lv1);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glFragmentLightModelfSGIX,(GLenum, GLfloat),void);
value glstub_glFragmentLightModelfSGIX(value v0, value v1)
{
	CAMLparam2(v0, v1);
	GLenum lv0 = Int_val(v0);
	GLfloat lv1 = Double_val(v1);
	LOAD_FUNCTION(glFragmentLightModelfSGIX);
	(*stub_glFragmentLightModelfSGIX)(lv0, lv1);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glFragmentLightModelfvEXT,(GLenum, GLfloat*),void);
value glstub_glFragmentLightModelfvEXT(value v0, value v1)
{
	CAMLparam2(v0, v1);
	GLenum lv0 = Int_val(v0);
	GLfloat* lv1 = Data_bigarray_val(v1);
	LOAD_FUNCTION(glFragmentLightModelfvEXT);
	(*stub_glFragmentLightModelfvEXT)(lv0, lv1);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glFragmentLightModelfvSGIX,(GLenum, GLfloat*),void);
value glstub_glFragmentLightModelfvSGIX(value v0, value v1)
{
	CAMLparam2(v0, v1);
	GLenum lv0 = Int_val(v0);
	GLfloat* lv1 = Data_bigarray_val(v1);
	LOAD_FUNCTION(glFragmentLightModelfvSGIX);
	(*stub_glFragmentLightModelfvSGIX)(lv0, lv1);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glFragmentLightModeliEXT,(GLenum, GLint),void);
value glstub_glFragmentLightModeliEXT(value v0, value v1)
{
	CAMLparam2(v0, v1);
	GLenum lv0 = Int_val(v0);
	GLint lv1 = Int_val(v1);
	LOAD_FUNCTION(glFragmentLightModeliEXT);
	(*stub_glFragmentLightModeliEXT)(lv0, lv1);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glFragmentLightModeliSGIX,(GLenum, GLint),void);
value glstub_glFragmentLightModeliSGIX(value v0, value v1)
{
	CAMLparam2(v0, v1);
	GLenum lv0 = Int_val(v0);
	GLint lv1 = Int_val(v1);
	LOAD_FUNCTION(glFragmentLightModeliSGIX);
	(*stub_glFragmentLightModeliSGIX)(lv0, lv1);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glFragmentLightModelivEXT,(GLenum, GLint*),void);
value glstub_glFragmentLightModelivEXT(value v0, value v1)
{
	CAMLparam2(v0, v1);
	GLenum lv0 = Int_val(v0);
	GLint* lv1 = Data_bigarray_val(v1);
	LOAD_FUNCTION(glFragmentLightModelivEXT);
	(*stub_glFragmentLightModelivEXT)(lv0, lv1);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glFragmentLightModelivSGIX,(GLenum, GLint*),void);
value glstub_glFragmentLightModelivSGIX(value v0, value v1)
{
	CAMLparam2(v0, v1);
	GLenum lv0 = Int_val(v0);
	GLint* lv1 = Data_bigarray_val(v1);
	LOAD_FUNCTION(glFragmentLightModelivSGIX);
	(*stub_glFragmentLightModelivSGIX)(lv0, lv1);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glFragmentLightfEXT,(GLenum, GLenum, GLfloat),void);
value glstub_glFragmentLightfEXT(value v0, value v1, value v2)
{
	CAMLparam3(v0, v1, v2);
	GLenum lv0 = Int_val(v0);
	GLenum lv1 = Int_val(v1);
	GLfloat lv2 = Double_val(v2);
	LOAD_FUNCTION(glFragmentLightfEXT);
	(*stub_glFragmentLightfEXT)(lv0, lv1, lv2);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glFragmentLightfSGIX,(GLenum, GLenum, GLfloat),void);
value glstub_glFragmentLightfSGIX(value v0, value v1, value v2)
{
	CAMLparam3(v0, v1, v2);
	GLenum lv0 = Int_val(v0);
	GLenum lv1 = Int_val(v1);
	GLfloat lv2 = Double_val(v2);
	LOAD_FUNCTION(glFragmentLightfSGIX);
	(*stub_glFragmentLightfSGIX)(lv0, lv1, lv2);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glFragmentLightfvEXT,(GLenum, GLenum, GLfloat*),void);
value glstub_glFragmentLightfvEXT(value v0, value v1, value v2)
{
	CAMLparam3(v0, v1, v2);
	GLenum lv0 = Int_val(v0);
	GLenum lv1 = Int_val(v1);
	GLfloat* lv2 = Data_bigarray_val(v2);
	LOAD_FUNCTION(glFragmentLightfvEXT);
	(*stub_glFragmentLightfvEXT)(lv0, lv1, lv2);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glFragmentLightfvSGIX,(GLenum, GLenum, GLfloat*),void);
value glstub_glFragmentLightfvSGIX(value v0, value v1, value v2)
{
	CAMLparam3(v0, v1, v2);
	GLenum lv0 = Int_val(v0);
	GLenum lv1 = Int_val(v1);
	GLfloat* lv2 = Data_bigarray_val(v2);
	LOAD_FUNCTION(glFragmentLightfvSGIX);
	(*stub_glFragmentLightfvSGIX)(lv0, lv1, lv2);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glFragmentLightiEXT,(GLenum, GLenum, GLint),void);
value glstub_glFragmentLightiEXT(value v0, value v1, value v2)
{
	CAMLparam3(v0, v1, v2);
	GLenum lv0 = Int_val(v0);
	GLenum lv1 = Int_val(v1);
	GLint lv2 = Int_val(v2);
	LOAD_FUNCTION(glFragmentLightiEXT);
	(*stub_glFragmentLightiEXT)(lv0, lv1, lv2);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glFragmentLightiSGIX,(GLenum, GLenum, GLint),void);
value glstub_glFragmentLightiSGIX(value v0, value v1, value v2)
{
	CAMLparam3(v0, v1, v2);
	GLenum lv0 = Int_val(v0);
	GLenum lv1 = Int_val(v1);
	GLint lv2 = Int_val(v2);
	LOAD_FUNCTION(glFragmentLightiSGIX);
	(*stub_glFragmentLightiSGIX)(lv0, lv1, lv2);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glFragmentLightivEXT,(GLenum, GLenum, GLint*),void);
value glstub_glFragmentLightivEXT(value v0, value v1, value v2)
{
	CAMLparam3(v0, v1, v2);
	GLenum lv0 = Int_val(v0);
	GLenum lv1 = Int_val(v1);
	GLint* lv2 = Data_bigarray_val(v2);
	LOAD_FUNCTION(glFragmentLightivEXT);
	(*stub_glFragmentLightivEXT)(lv0, lv1, lv2);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glFragmentLightivSGIX,(GLenum, GLenum, GLint*),void);
value glstub_glFragmentLightivSGIX(value v0, value v1, value v2)
{
	CAMLparam3(v0, v1, v2);
	GLenum lv0 = Int_val(v0);
	GLenum lv1 = Int_val(v1);
	GLint* lv2 = Data_bigarray_val(v2);
	LOAD_FUNCTION(glFragmentLightivSGIX);
	(*stub_glFragmentLightivSGIX)(lv0, lv1, lv2);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glFragmentMaterialfEXT,(GLenum, GLenum, GLfloat),void);
value glstub_glFragmentMaterialfEXT(value v0, value v1, value v2)
{
	CAMLparam3(v0, v1, v2);
	GLenum lv0 = Int_val(v0);
	GLenum lv1 = Int_val(v1);
	GLfloat lv2 = Double_val(v2);
	LOAD_FUNCTION(glFragmentMaterialfEXT);
	(*stub_glFragmentMaterialfEXT)(lv0, lv1, lv2);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glFragmentMaterialfSGIX,(GLenum, GLenum, GLfloat),void);
value glstub_glFragmentMaterialfSGIX(value v0, value v1, value v2)
{
	CAMLparam3(v0, v1, v2);
	GLenum lv0 = Int_val(v0);
	GLenum lv1 = Int_val(v1);
	GLfloat lv2 = Double_val(v2);
	LOAD_FUNCTION(glFragmentMaterialfSGIX);
	(*stub_glFragmentMaterialfSGIX)(lv0, lv1, lv2);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glFragmentMaterialfvEXT,(GLenum, GLenum, GLfloat*),void);
value glstub_glFragmentMaterialfvEXT(value v0, value v1, value v2)
{
	CAMLparam3(v0, v1, v2);
	GLenum lv0 = Int_val(v0);
	GLenum lv1 = Int_val(v1);
	GLfloat* lv2 = Data_bigarray_val(v2);
	LOAD_FUNCTION(glFragmentMaterialfvEXT);
	(*stub_glFragmentMaterialfvEXT)(lv0, lv1, lv2);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glFragmentMaterialfvSGIX,(GLenum, GLenum, GLfloat*),void);
value glstub_glFragmentMaterialfvSGIX(value v0, value v1, value v2)
{
	CAMLparam3(v0, v1, v2);
	GLenum lv0 = Int_val(v0);
	GLenum lv1 = Int_val(v1);
	GLfloat* lv2 = Data_bigarray_val(v2);
	LOAD_FUNCTION(glFragmentMaterialfvSGIX);
	(*stub_glFragmentMaterialfvSGIX)(lv0, lv1, lv2);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glFragmentMaterialiEXT,(GLenum, GLenum, GLint),void);
value glstub_glFragmentMaterialiEXT(value v0, value v1, value v2)
{
	CAMLparam3(v0, v1, v2);
	GLenum lv0 = Int_val(v0);
	GLenum lv1 = Int_val(v1);
	GLint lv2 = Int_val(v2);
	LOAD_FUNCTION(glFragmentMaterialiEXT);
	(*stub_glFragmentMaterialiEXT)(lv0, lv1, lv2);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glFragmentMaterialiSGIX,(GLenum, GLenum, GLint),void);
value glstub_glFragmentMaterialiSGIX(value v0, value v1, value v2)
{
	CAMLparam3(v0, v1, v2);
	GLenum lv0 = Int_val(v0);
	GLenum lv1 = Int_val(v1);
	GLint lv2 = Int_val(v2);
	LOAD_FUNCTION(glFragmentMaterialiSGIX);
	(*stub_glFragmentMaterialiSGIX)(lv0, lv1, lv2);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glFragmentMaterialivEXT,(GLenum, GLenum, GLint*),void);
value glstub_glFragmentMaterialivEXT(value v0, value v1, value v2)
{
	CAMLparam3(v0, v1, v2);
	GLenum lv0 = Int_val(v0);
	GLenum lv1 = Int_val(v1);
	GLint* lv2 = Data_bigarray_val(v2);
	LOAD_FUNCTION(glFragmentMaterialivEXT);
	(*stub_glFragmentMaterialivEXT)(lv0, lv1, lv2);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glFragmentMaterialivSGIX,(GLenum, GLenum, GLint*),void);
value glstub_glFragmentMaterialivSGIX(value v0, value v1, value v2)
{
	CAMLparam3(v0, v1, v2);
	GLenum lv0 = Int_val(v0);
	GLenum lv1 = Int_val(v1);
	GLint* lv2 = Data_bigarray_val(v2);
	LOAD_FUNCTION(glFragmentMaterialivSGIX);
	(*stub_glFragmentMaterialivSGIX)(lv0, lv1, lv2);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glFrameZoomSGIX,(GLint),void);
value glstub_glFrameZoomSGIX(value v0)
{
	CAMLparam1(v0);
	GLint lv0 = Int_val(v0);
	LOAD_FUNCTION(glFrameZoomSGIX);
	(*stub_glFrameZoomSGIX)(lv0);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glFramebufferRenderbufferEXT,(GLenum, GLenum, GLenum, GLuint),void);
value glstub_glFramebufferRenderbufferEXT(value v0, value v1, value v2, value v3)
{
	CAMLparam4(v0, v1, v2, v3);
	GLenum lv0 = Int_val(v0);
	GLenum lv1 = Int_val(v1);
	GLenum lv2 = Int_val(v2);
	GLuint lv3 = Int_val(v3);
	LOAD_FUNCTION(glFramebufferRenderbufferEXT);
	(*stub_glFramebufferRenderbufferEXT)(lv0, lv1, lv2, lv3);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glFramebufferTexture1DEXT,(GLenum, GLenum, GLenum, GLuint, GLint),void);
value glstub_glFramebufferTexture1DEXT(value v0, value v1, value v2, value v3, value v4)
{
	CAMLparam5(v0, v1, v2, v3, v4);
	GLenum lv0 = Int_val(v0);
	GLenum lv1 = Int_val(v1);
	GLenum lv2 = Int_val(v2);
	GLuint lv3 = Int_val(v3);
	GLint lv4 = Int_val(v4);
	LOAD_FUNCTION(glFramebufferTexture1DEXT);
	(*stub_glFramebufferTexture1DEXT)(lv0, lv1, lv2, lv3, lv4);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glFramebufferTexture2DEXT,(GLenum, GLenum, GLenum, GLuint, GLint),void);
value glstub_glFramebufferTexture2DEXT(value v0, value v1, value v2, value v3, value v4)
{
	CAMLparam5(v0, v1, v2, v3, v4);
	GLenum lv0 = Int_val(v0);
	GLenum lv1 = Int_val(v1);
	GLenum lv2 = Int_val(v2);
	GLuint lv3 = Int_val(v3);
	GLint lv4 = Int_val(v4);
	LOAD_FUNCTION(glFramebufferTexture2DEXT);
	(*stub_glFramebufferTexture2DEXT)(lv0, lv1, lv2, lv3, lv4);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glFramebufferTexture3DEXT,(GLenum, GLenum, GLenum, GLuint, GLint, GLint),void);
value glstub_glFramebufferTexture3DEXT(value v0, value v1, value v2, value v3, value v4, value v5)
{
	CAMLparam5(v0, v1, v2, v3, v4);
	CAMLxparam1(v5);
	GLenum lv0 = Int_val(v0);
	GLenum lv1 = Int_val(v1);
	GLenum lv2 = Int_val(v2);
	GLuint lv3 = Int_val(v3);
	GLint lv4 = Int_val(v4);
	GLint lv5 = Int_val(v5);
	LOAD_FUNCTION(glFramebufferTexture3DEXT);
	(*stub_glFramebufferTexture3DEXT)(lv0, lv1, lv2, lv3, lv4, lv5);
	CAMLreturn(Val_unit);
}

value glstub_glFramebufferTexture3DEXT_byte(value * argv, int n)
{
	return glstub_glFramebufferTexture3DEXT(argv[0], argv[1], argv[2], argv[3], argv[4], argv[5]);
}

DECLARE_FUNCTION(glFramebufferTextureEXT,(GLenum, GLenum, GLuint, GLint),void);
value glstub_glFramebufferTextureEXT(value v0, value v1, value v2, value v3)
{
	CAMLparam4(v0, v1, v2, v3);
	GLenum lv0 = Int_val(v0);
	GLenum lv1 = Int_val(v1);
	GLuint lv2 = Int_val(v2);
	GLint lv3 = Int_val(v3);
	LOAD_FUNCTION(glFramebufferTextureEXT);
	(*stub_glFramebufferTextureEXT)(lv0, lv1, lv2, lv3);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glFramebufferTextureFaceEXT,(GLenum, GLenum, GLuint, GLint, GLenum),void);
value glstub_glFramebufferTextureFaceEXT(value v0, value v1, value v2, value v3, value v4)
{
	CAMLparam5(v0, v1, v2, v3, v4);
	GLenum lv0 = Int_val(v0);
	GLenum lv1 = Int_val(v1);
	GLuint lv2 = Int_val(v2);
	GLint lv3 = Int_val(v3);
	GLenum lv4 = Int_val(v4);
	LOAD_FUNCTION(glFramebufferTextureFaceEXT);
	(*stub_glFramebufferTextureFaceEXT)(lv0, lv1, lv2, lv3, lv4);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glFramebufferTextureLayerEXT,(GLenum, GLenum, GLuint, GLint, GLint),void);
value glstub_glFramebufferTextureLayerEXT(value v0, value v1, value v2, value v3, value v4)
{
	CAMLparam5(v0, v1, v2, v3, v4);
	GLenum lv0 = Int_val(v0);
	GLenum lv1 = Int_val(v1);
	GLuint lv2 = Int_val(v2);
	GLint lv3 = Int_val(v3);
	GLint lv4 = Int_val(v4);
	LOAD_FUNCTION(glFramebufferTextureLayerEXT);
	(*stub_glFramebufferTextureLayerEXT)(lv0, lv1, lv2, lv3, lv4);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glFreeObjectBufferATI,(GLuint),void);
value glstub_glFreeObjectBufferATI(value v0)
{
	CAMLparam1(v0);
	GLuint lv0 = Int_val(v0);
	LOAD_FUNCTION(glFreeObjectBufferATI);
	(*stub_glFreeObjectBufferATI)(lv0);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glFrontFace,(GLenum),void);
value glstub_glFrontFace(value v0)
{
	CAMLparam1(v0);
	GLenum lv0 = Int_val(v0);
	LOAD_FUNCTION(glFrontFace);
	(*stub_glFrontFace)(lv0);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glFrustum,(GLdouble, GLdouble, GLdouble, GLdouble, GLdouble, GLdouble),void);
value glstub_glFrustum(value v0, value v1, value v2, value v3, value v4, value v5)
{
	CAMLparam5(v0, v1, v2, v3, v4);
	CAMLxparam1(v5);
	GLdouble lv0 = Double_val(v0);
	GLdouble lv1 = Double_val(v1);
	GLdouble lv2 = Double_val(v2);
	GLdouble lv3 = Double_val(v3);
	GLdouble lv4 = Double_val(v4);
	GLdouble lv5 = Double_val(v5);
	LOAD_FUNCTION(glFrustum);
	(*stub_glFrustum)(lv0, lv1, lv2, lv3, lv4, lv5);
	CAMLreturn(Val_unit);
}

value glstub_glFrustum_byte(value * argv, int n)
{
	return glstub_glFrustum(argv[0], argv[1], argv[2], argv[3], argv[4], argv[5]);
}

DECLARE_FUNCTION(glFrustumfOES,(GLfloat, GLfloat, GLfloat, GLfloat, GLfloat, GLfloat),void);
value glstub_glFrustumfOES(value v0, value v1, value v2, value v3, value v4, value v5)
{
	CAMLparam5(v0, v1, v2, v3, v4);
	CAMLxparam1(v5);
	GLfloat lv0 = Double_val(v0);
	GLfloat lv1 = Double_val(v1);
	GLfloat lv2 = Double_val(v2);
	GLfloat lv3 = Double_val(v3);
	GLfloat lv4 = Double_val(v4);
	GLfloat lv5 = Double_val(v5);
	LOAD_FUNCTION(glFrustumfOES);
	(*stub_glFrustumfOES)(lv0, lv1, lv2, lv3, lv4, lv5);
	CAMLreturn(Val_unit);
}

value glstub_glFrustumfOES_byte(value * argv, int n)
{
	return glstub_glFrustumfOES(argv[0], argv[1], argv[2], argv[3], argv[4], argv[5]);
}

DECLARE_FUNCTION(glGenAsyncMarkersSGIX,(GLsizei),GLuint);
value glstub_glGenAsyncMarkersSGIX(value v0)
{
	CAMLparam1(v0);
	CAMLlocal1(result);
	GLsizei lv0 = Int_val(v0);
	GLuint ret;
	LOAD_FUNCTION(glGenAsyncMarkersSGIX);
	ret = (*stub_glGenAsyncMarkersSGIX)(lv0);
	result = Val_int(ret);
	CAMLreturn(result);
}

DECLARE_FUNCTION(glGenBuffers,(GLsizei, GLuint*),void);
value glstub_glGenBuffers(value v0, value v1)
{
	CAMLparam2(v0, v1);
	GLsizei lv0 = Int_val(v0);
	GLuint* lv1 = Data_bigarray_val(v1);
	LOAD_FUNCTION(glGenBuffers);
	(*stub_glGenBuffers)(lv0, lv1);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glGenBuffersARB,(GLsizei, GLuint*),void);
value glstub_glGenBuffersARB(value v0, value v1)
{
	CAMLparam2(v0, v1);
	GLsizei lv0 = Int_val(v0);
	GLuint* lv1 = Data_bigarray_val(v1);
	LOAD_FUNCTION(glGenBuffersARB);
	(*stub_glGenBuffersARB)(lv0, lv1);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glGenFencesAPPLE,(GLsizei, GLuint*),void);
value glstub_glGenFencesAPPLE(value v0, value v1)
{
	CAMLparam2(v0, v1);
	GLsizei lv0 = Int_val(v0);
	GLuint* lv1 = Data_bigarray_val(v1);
	LOAD_FUNCTION(glGenFencesAPPLE);
	(*stub_glGenFencesAPPLE)(lv0, lv1);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glGenFencesNV,(GLsizei, GLuint*),void);
value glstub_glGenFencesNV(value v0, value v1)
{
	CAMLparam2(v0, v1);
	GLsizei lv0 = Int_val(v0);
	GLuint* lv1 = Data_bigarray_val(v1);
	LOAD_FUNCTION(glGenFencesNV);
	(*stub_glGenFencesNV)(lv0, lv1);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glGenFragmentShadersATI,(GLuint),GLuint);
value glstub_glGenFragmentShadersATI(value v0)
{
	CAMLparam1(v0);
	CAMLlocal1(result);
	GLuint lv0 = Int_val(v0);
	GLuint ret;
	LOAD_FUNCTION(glGenFragmentShadersATI);
	ret = (*stub_glGenFragmentShadersATI)(lv0);
	result = Val_int(ret);
	CAMLreturn(result);
}

DECLARE_FUNCTION(glGenFramebuffersEXT,(GLsizei, GLuint*),void);
value glstub_glGenFramebuffersEXT(value v0, value v1)
{
	CAMLparam2(v0, v1);
	GLsizei lv0 = Int_val(v0);
	GLuint* lv1 = Data_bigarray_val(v1);
	LOAD_FUNCTION(glGenFramebuffersEXT);
	(*stub_glGenFramebuffersEXT)(lv0, lv1);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glGenLists,(GLsizei),GLuint);
value glstub_glGenLists(value v0)
{
	CAMLparam1(v0);
	CAMLlocal1(result);
	GLsizei lv0 = Int_val(v0);
	GLuint ret;
	LOAD_FUNCTION(glGenLists);
	ret = (*stub_glGenLists)(lv0);
	result = Val_int(ret);
	CAMLreturn(result);
}

DECLARE_FUNCTION(glGenOcclusionQueriesNV,(GLsizei, GLuint*),void);
value glstub_glGenOcclusionQueriesNV(value v0, value v1)
{
	CAMLparam2(v0, v1);
	GLsizei lv0 = Int_val(v0);
	GLuint* lv1 = Data_bigarray_val(v1);
	LOAD_FUNCTION(glGenOcclusionQueriesNV);
	(*stub_glGenOcclusionQueriesNV)(lv0, lv1);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glGenProgramsARB,(GLsizei, GLuint*),void);
value glstub_glGenProgramsARB(value v0, value v1)
{
	CAMLparam2(v0, v1);
	GLsizei lv0 = Int_val(v0);
	GLuint* lv1 = Data_bigarray_val(v1);
	LOAD_FUNCTION(glGenProgramsARB);
	(*stub_glGenProgramsARB)(lv0, lv1);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glGenProgramsNV,(GLsizei, GLuint*),void);
value glstub_glGenProgramsNV(value v0, value v1)
{
	CAMLparam2(v0, v1);
	GLsizei lv0 = Int_val(v0);
	GLuint* lv1 = Data_bigarray_val(v1);
	LOAD_FUNCTION(glGenProgramsNV);
	(*stub_glGenProgramsNV)(lv0, lv1);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glGenQueries,(GLsizei, GLuint*),void);
value glstub_glGenQueries(value v0, value v1)
{
	CAMLparam2(v0, v1);
	GLsizei lv0 = Int_val(v0);
	GLuint* lv1 = Data_bigarray_val(v1);
	LOAD_FUNCTION(glGenQueries);
	(*stub_glGenQueries)(lv0, lv1);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glGenQueriesARB,(GLsizei, GLuint*),void);
value glstub_glGenQueriesARB(value v0, value v1)
{
	CAMLparam2(v0, v1);
	GLsizei lv0 = Int_val(v0);
	GLuint* lv1 = Data_bigarray_val(v1);
	LOAD_FUNCTION(glGenQueriesARB);
	(*stub_glGenQueriesARB)(lv0, lv1);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glGenRenderbuffersEXT,(GLsizei, GLuint*),void);
value glstub_glGenRenderbuffersEXT(value v0, value v1)
{
	CAMLparam2(v0, v1);
	GLsizei lv0 = Int_val(v0);
	GLuint* lv1 = Data_bigarray_val(v1);
	LOAD_FUNCTION(glGenRenderbuffersEXT);
	(*stub_glGenRenderbuffersEXT)(lv0, lv1);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glGenSymbolsEXT,(GLenum, GLenum, GLenum, GLuint),GLuint);
value glstub_glGenSymbolsEXT(value v0, value v1, value v2, value v3)
{
	CAMLparam4(v0, v1, v2, v3);
	CAMLlocal1(result);
	GLenum lv0 = Int_val(v0);
	GLenum lv1 = Int_val(v1);
	GLenum lv2 = Int_val(v2);
	GLuint lv3 = Int_val(v3);
	GLuint ret;
	LOAD_FUNCTION(glGenSymbolsEXT);
	ret = (*stub_glGenSymbolsEXT)(lv0, lv1, lv2, lv3);
	result = Val_int(ret);
	CAMLreturn(result);
}

DECLARE_FUNCTION(glGenTextures,(GLsizei, GLuint*),void);
value glstub_glGenTextures(value v0, value v1)
{
	CAMLparam2(v0, v1);
	GLsizei lv0 = Int_val(v0);
	GLuint* lv1 = Data_bigarray_val(v1);
	LOAD_FUNCTION(glGenTextures);
	(*stub_glGenTextures)(lv0, lv1);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glGenTexturesEXT,(GLsizei, GLuint*),void);
value glstub_glGenTexturesEXT(value v0, value v1)
{
	CAMLparam2(v0, v1);
	GLsizei lv0 = Int_val(v0);
	GLuint* lv1 = Data_bigarray_val(v1);
	LOAD_FUNCTION(glGenTexturesEXT);
	(*stub_glGenTexturesEXT)(lv0, lv1);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glGenVertexArraysAPPLE,(GLsizei, GLuint*),void);
value glstub_glGenVertexArraysAPPLE(value v0, value v1)
{
	CAMLparam2(v0, v1);
	GLsizei lv0 = Int_val(v0);
	GLuint* lv1 = Data_bigarray_val(v1);
	LOAD_FUNCTION(glGenVertexArraysAPPLE);
	(*stub_glGenVertexArraysAPPLE)(lv0, lv1);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glGenVertexShadersEXT,(GLuint),GLuint);
value glstub_glGenVertexShadersEXT(value v0)
{
	CAMLparam1(v0);
	CAMLlocal1(result);
	GLuint lv0 = Int_val(v0);
	GLuint ret;
	LOAD_FUNCTION(glGenVertexShadersEXT);
	ret = (*stub_glGenVertexShadersEXT)(lv0);
	result = Val_int(ret);
	CAMLreturn(result);
}

DECLARE_FUNCTION(glGenerateMipmapEXT,(GLenum),void);
value glstub_glGenerateMipmapEXT(value v0)
{
	CAMLparam1(v0);
	GLenum lv0 = Int_val(v0);
	LOAD_FUNCTION(glGenerateMipmapEXT);
	(*stub_glGenerateMipmapEXT)(lv0);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glGetActiveAttrib,(GLuint, GLuint, GLsizei, GLsizei*, GLint*, GLenum*, GLchar*),void);
value glstub_glGetActiveAttrib(value v0, value v1, value v2, value v3, value v4, value v5, value v6)
{
	CAMLparam5(v0, v1, v2, v3, v4);
	CAMLxparam2(v5, v6);
	GLuint lv0 = Int_val(v0);
	GLuint lv1 = Int_val(v1);
	GLsizei lv2 = Int_val(v2);
	GLsizei* lv3 = Data_bigarray_val(v3);
	GLint* lv4 = Data_bigarray_val(v4);
	GLenum* lv5 = Data_bigarray_val(v5);
	GLchar* lv6 = String_val(v6);
	LOAD_FUNCTION(glGetActiveAttrib);
	(*stub_glGetActiveAttrib)(lv0, lv1, lv2, lv3, lv4, lv5, lv6);
	CAMLreturn(Val_unit);
}

value glstub_glGetActiveAttrib_byte(value * argv, int n)
{
	return glstub_glGetActiveAttrib(argv[0], argv[1], argv[2], argv[3], argv[4], argv[5], argv[6]);
}

DECLARE_FUNCTION(glGetActiveAttribARB,(GLuint, GLuint, GLsizei, GLsizei*, GLint*, GLenum*, GLchar*),void);
value glstub_glGetActiveAttribARB(value v0, value v1, value v2, value v3, value v4, value v5, value v6)
{
	CAMLparam5(v0, v1, v2, v3, v4);
	CAMLxparam2(v5, v6);
	GLuint lv0 = Int_val(v0);
	GLuint lv1 = Int_val(v1);
	GLsizei lv2 = Int_val(v2);
	GLsizei* lv3 = Data_bigarray_val(v3);
	GLint* lv4 = Data_bigarray_val(v4);
	GLenum* lv5 = Data_bigarray_val(v5);
	GLchar* lv6 = String_val(v6);
	LOAD_FUNCTION(glGetActiveAttribARB);
	(*stub_glGetActiveAttribARB)(lv0, lv1, lv2, lv3, lv4, lv5, lv6);
	CAMLreturn(Val_unit);
}

value glstub_glGetActiveAttribARB_byte(value * argv, int n)
{
	return glstub_glGetActiveAttribARB(argv[0], argv[1], argv[2], argv[3], argv[4], argv[5], argv[6]);
}

DECLARE_FUNCTION(glGetActiveUniform,(GLuint, GLuint, GLsizei, GLsizei*, GLint*, GLenum*, GLchar*),void);
value glstub_glGetActiveUniform(value v0, value v1, value v2, value v3, value v4, value v5, value v6)
{
	CAMLparam5(v0, v1, v2, v3, v4);
	CAMLxparam2(v5, v6);
	GLuint lv0 = Int_val(v0);
	GLuint lv1 = Int_val(v1);
	GLsizei lv2 = Int_val(v2);
	GLsizei* lv3 = Data_bigarray_val(v3);
	GLint* lv4 = Data_bigarray_val(v4);
	GLenum* lv5 = Data_bigarray_val(v5);
	GLchar* lv6 = String_val(v6);
	LOAD_FUNCTION(glGetActiveUniform);
	(*stub_glGetActiveUniform)(lv0, lv1, lv2, lv3, lv4, lv5, lv6);
	CAMLreturn(Val_unit);
}

value glstub_glGetActiveUniform_byte(value * argv, int n)
{
	return glstub_glGetActiveUniform(argv[0], argv[1], argv[2], argv[3], argv[4], argv[5], argv[6]);
}

DECLARE_FUNCTION(glGetActiveUniformARB,(GLuint, GLuint, GLsizei, GLsizei*, GLint*, GLenum*, GLchar*),void);
value glstub_glGetActiveUniformARB(value v0, value v1, value v2, value v3, value v4, value v5, value v6)
{
	CAMLparam5(v0, v1, v2, v3, v4);
	CAMLxparam2(v5, v6);
	GLuint lv0 = Int_val(v0);
	GLuint lv1 = Int_val(v1);
	GLsizei lv2 = Int_val(v2);
	GLsizei* lv3 = Data_bigarray_val(v3);
	GLint* lv4 = Data_bigarray_val(v4);
	GLenum* lv5 = Data_bigarray_val(v5);
	GLchar* lv6 = String_val(v6);
	LOAD_FUNCTION(glGetActiveUniformARB);
	(*stub_glGetActiveUniformARB)(lv0, lv1, lv2, lv3, lv4, lv5, lv6);
	CAMLreturn(Val_unit);
}

value glstub_glGetActiveUniformARB_byte(value * argv, int n)
{
	return glstub_glGetActiveUniformARB(argv[0], argv[1], argv[2], argv[3], argv[4], argv[5], argv[6]);
}

DECLARE_FUNCTION(glGetActiveVaryingNV,(GLuint, GLuint, GLsizei, GLsizei*, GLsizei*, GLenum*, GLchar*),void);
value glstub_glGetActiveVaryingNV(value v0, value v1, value v2, value v3, value v4, value v5, value v6)
{
	CAMLparam5(v0, v1, v2, v3, v4);
	CAMLxparam2(v5, v6);
	GLuint lv0 = Int_val(v0);
	GLuint lv1 = Int_val(v1);
	GLsizei lv2 = Int_val(v2);
	GLsizei* lv3 = Data_bigarray_val(v3);
	GLsizei* lv4 = Data_bigarray_val(v4);
	GLenum* lv5 = Data_bigarray_val(v5);
	GLchar* lv6 = String_val(v6);
	LOAD_FUNCTION(glGetActiveVaryingNV);
	(*stub_glGetActiveVaryingNV)(lv0, lv1, lv2, lv3, lv4, lv5, lv6);
	CAMLreturn(Val_unit);
}

value glstub_glGetActiveVaryingNV_byte(value * argv, int n)
{
	return glstub_glGetActiveVaryingNV(argv[0], argv[1], argv[2], argv[3], argv[4], argv[5], argv[6]);
}

DECLARE_FUNCTION(glGetArrayObjectfvATI,(GLenum, GLenum, GLfloat*),void);
value glstub_glGetArrayObjectfvATI(value v0, value v1, value v2)
{
	CAMLparam3(v0, v1, v2);
	GLenum lv0 = Int_val(v0);
	GLenum lv1 = Int_val(v1);
	GLfloat* lv2 = Data_bigarray_val(v2);
	LOAD_FUNCTION(glGetArrayObjectfvATI);
	(*stub_glGetArrayObjectfvATI)(lv0, lv1, lv2);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glGetArrayObjectivATI,(GLenum, GLenum, GLint*),void);
value glstub_glGetArrayObjectivATI(value v0, value v1, value v2)
{
	CAMLparam3(v0, v1, v2);
	GLenum lv0 = Int_val(v0);
	GLenum lv1 = Int_val(v1);
	GLint* lv2 = Data_bigarray_val(v2);
	LOAD_FUNCTION(glGetArrayObjectivATI);
	(*stub_glGetArrayObjectivATI)(lv0, lv1, lv2);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glGetAttachedObjectsARB,(GLuint, GLsizei, GLsizei*, GLuint*),void);
value glstub_glGetAttachedObjectsARB(value v0, value v1, value v2, value v3)
{
	CAMLparam4(v0, v1, v2, v3);
	GLuint lv0 = Int_val(v0);
	GLsizei lv1 = Int_val(v1);
	GLsizei* lv2 = Data_bigarray_val(v2);
	GLuint* lv3 = Data_bigarray_val(v3);
	LOAD_FUNCTION(glGetAttachedObjectsARB);
	(*stub_glGetAttachedObjectsARB)(lv0, lv1, lv2, lv3);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glGetAttachedShaders,(GLuint, GLsizei, GLsizei*, GLuint*),void);
value glstub_glGetAttachedShaders(value v0, value v1, value v2, value v3)
{
	CAMLparam4(v0, v1, v2, v3);
	GLuint lv0 = Int_val(v0);
	GLsizei lv1 = Int_val(v1);
	GLsizei* lv2 = Data_bigarray_val(v2);
	GLuint* lv3 = Data_bigarray_val(v3);
	LOAD_FUNCTION(glGetAttachedShaders);
	(*stub_glGetAttachedShaders)(lv0, lv1, lv2, lv3);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glGetAttribLocation,(GLuint, GLchar*),GLint);
value glstub_glGetAttribLocation(value v0, value v1)
{
	CAMLparam2(v0, v1);
	CAMLlocal1(result);
	GLuint lv0 = Int_val(v0);
	GLchar* lv1 = String_val(v1);
	GLint ret;
	LOAD_FUNCTION(glGetAttribLocation);
	ret = (*stub_glGetAttribLocation)(lv0, lv1);
	result = Val_int(ret);
	CAMLreturn(result);
}

DECLARE_FUNCTION(glGetAttribLocationARB,(GLuint, GLchar*),GLint);
value glstub_glGetAttribLocationARB(value v0, value v1)
{
	CAMLparam2(v0, v1);
	CAMLlocal1(result);
	GLuint lv0 = Int_val(v0);
	GLchar* lv1 = String_val(v1);
	GLint ret;
	LOAD_FUNCTION(glGetAttribLocationARB);
	ret = (*stub_glGetAttribLocationARB)(lv0, lv1);
	result = Val_int(ret);
	CAMLreturn(result);
}

DECLARE_FUNCTION(glGetBooleanIndexedvEXT,(GLenum, GLuint, GLboolean*),void);
value glstub_glGetBooleanIndexedvEXT(value v0, value v1, value v2)
{
	CAMLparam3(v0, v1, v2);
	GLenum lv0 = Int_val(v0);
	GLuint lv1 = Int_val(v1);
	GLboolean* lv2 = Data_bigarray_val(v2);
	LOAD_FUNCTION(glGetBooleanIndexedvEXT);
	(*stub_glGetBooleanIndexedvEXT)(lv0, lv1, lv2);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glGetBooleanv,(GLenum, GLboolean*),void);
value glstub_glGetBooleanv(value v0, value v1)
{
	CAMLparam2(v0, v1);
	GLenum lv0 = Int_val(v0);
	GLboolean* lv1 = Data_bigarray_val(v1);
	LOAD_FUNCTION(glGetBooleanv);
	(*stub_glGetBooleanv)(lv0, lv1);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glGetBufferParameteriv,(GLenum, GLenum, GLint*),void);
value glstub_glGetBufferParameteriv(value v0, value v1, value v2)
{
	CAMLparam3(v0, v1, v2);
	GLenum lv0 = Int_val(v0);
	GLenum lv1 = Int_val(v1);
	GLint* lv2 = Data_bigarray_val(v2);
	LOAD_FUNCTION(glGetBufferParameteriv);
	(*stub_glGetBufferParameteriv)(lv0, lv1, lv2);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glGetBufferParameterivARB,(GLenum, GLenum, GLint*),void);
value glstub_glGetBufferParameterivARB(value v0, value v1, value v2)
{
	CAMLparam3(v0, v1, v2);
	GLenum lv0 = Int_val(v0);
	GLenum lv1 = Int_val(v1);
	GLint* lv2 = Data_bigarray_val(v2);
	LOAD_FUNCTION(glGetBufferParameterivARB);
	(*stub_glGetBufferParameterivARB)(lv0, lv1, lv2);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glGetBufferPointerv,(GLenum, GLenum, GLvoid**),void);
value glstub_glGetBufferPointerv(value v0, value v1, value v2)
{
	CAMLparam3(v0, v1, v2);
	GLenum lv0 = Int_val(v0);
	GLenum lv1 = Int_val(v1);
	GLvoid** lv2 = Data_bigarray_val(v2);
	LOAD_FUNCTION(glGetBufferPointerv);
	(*stub_glGetBufferPointerv)(lv0, lv1, lv2);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glGetBufferPointervARB,(GLenum, GLenum, GLvoid**),void);
value glstub_glGetBufferPointervARB(value v0, value v1, value v2)
{
	CAMLparam3(v0, v1, v2);
	GLenum lv0 = Int_val(v0);
	GLenum lv1 = Int_val(v1);
	GLvoid** lv2 = Data_bigarray_val(v2);
	LOAD_FUNCTION(glGetBufferPointervARB);
	(*stub_glGetBufferPointervARB)(lv0, lv1, lv2);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glGetBufferSubData,(GLenum, GLintptr, GLsizeiptr, GLvoid*),void);
value glstub_glGetBufferSubData(value v0, value v1, value v2, value v3)
{
	CAMLparam4(v0, v1, v2, v3);
	GLenum lv0 = Int_val(v0);
	GLintptr lv1 = Int_val(v1);
	GLsizeiptr lv2 = Int_val(v2);
	GLvoid* lv3 = (GLvoid *)((Tag_val(v3) == String_tag)? (String_val(v3)) : (Data_bigarray_val(v3)));
	LOAD_FUNCTION(glGetBufferSubData);
	(*stub_glGetBufferSubData)(lv0, lv1, lv2, lv3);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glGetBufferSubDataARB,(GLenum, GLintptr, GLsizeiptr, GLvoid*),void);
value glstub_glGetBufferSubDataARB(value v0, value v1, value v2, value v3)
{
	CAMLparam4(v0, v1, v2, v3);
	GLenum lv0 = Int_val(v0);
	GLintptr lv1 = Int_val(v1);
	GLsizeiptr lv2 = Int_val(v2);
	GLvoid* lv3 = (GLvoid *)((Tag_val(v3) == String_tag)? (String_val(v3)) : (Data_bigarray_val(v3)));
	LOAD_FUNCTION(glGetBufferSubDataARB);
	(*stub_glGetBufferSubDataARB)(lv0, lv1, lv2, lv3);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glGetClipPlane,(GLenum, GLdouble*),void);
value glstub_glGetClipPlane(value v0, value v1)
{
	CAMLparam2(v0, v1);
	GLenum lv0 = Int_val(v0);
	GLdouble* lv1 = (Tag_val(v1) == Double_array_tag)? (double *)v1: Data_bigarray_val(v1);
	LOAD_FUNCTION(glGetClipPlane);
	(*stub_glGetClipPlane)(lv0, lv1);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glGetClipPlanefOES,(GLenum, GLfloat*),void);
value glstub_glGetClipPlanefOES(value v0, value v1)
{
	CAMLparam2(v0, v1);
	GLenum lv0 = Int_val(v0);
	GLfloat* lv1 = Data_bigarray_val(v1);
	LOAD_FUNCTION(glGetClipPlanefOES);
	(*stub_glGetClipPlanefOES)(lv0, lv1);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glGetColorTable,(GLenum, GLenum, GLenum, GLvoid*),void);
value glstub_glGetColorTable(value v0, value v1, value v2, value v3)
{
	CAMLparam4(v0, v1, v2, v3);
	GLenum lv0 = Int_val(v0);
	GLenum lv1 = Int_val(v1);
	GLenum lv2 = Int_val(v2);
	GLvoid* lv3 = (GLvoid *)((Tag_val(v3) == String_tag)? (String_val(v3)) : (Data_bigarray_val(v3)));
	LOAD_FUNCTION(glGetColorTable);
	(*stub_glGetColorTable)(lv0, lv1, lv2, lv3);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glGetColorTableEXT,(GLenum, GLenum, GLenum, GLvoid*),void);
value glstub_glGetColorTableEXT(value v0, value v1, value v2, value v3)
{
	CAMLparam4(v0, v1, v2, v3);
	GLenum lv0 = Int_val(v0);
	GLenum lv1 = Int_val(v1);
	GLenum lv2 = Int_val(v2);
	GLvoid* lv3 = (GLvoid *)((Tag_val(v3) == String_tag)? (String_val(v3)) : (Data_bigarray_val(v3)));
	LOAD_FUNCTION(glGetColorTableEXT);
	(*stub_glGetColorTableEXT)(lv0, lv1, lv2, lv3);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glGetColorTableParameterfv,(GLenum, GLenum, GLfloat*),void);
value glstub_glGetColorTableParameterfv(value v0, value v1, value v2)
{
	CAMLparam3(v0, v1, v2);
	GLenum lv0 = Int_val(v0);
	GLenum lv1 = Int_val(v1);
	GLfloat* lv2 = Data_bigarray_val(v2);
	LOAD_FUNCTION(glGetColorTableParameterfv);
	(*stub_glGetColorTableParameterfv)(lv0, lv1, lv2);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glGetColorTableParameterfvEXT,(GLenum, GLenum, GLfloat*),void);
value glstub_glGetColorTableParameterfvEXT(value v0, value v1, value v2)
{
	CAMLparam3(v0, v1, v2);
	GLenum lv0 = Int_val(v0);
	GLenum lv1 = Int_val(v1);
	GLfloat* lv2 = Data_bigarray_val(v2);
	LOAD_FUNCTION(glGetColorTableParameterfvEXT);
	(*stub_glGetColorTableParameterfvEXT)(lv0, lv1, lv2);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glGetColorTableParameterfvSGI,(GLenum, GLenum, GLfloat*),void);
value glstub_glGetColorTableParameterfvSGI(value v0, value v1, value v2)
{
	CAMLparam3(v0, v1, v2);
	GLenum lv0 = Int_val(v0);
	GLenum lv1 = Int_val(v1);
	GLfloat* lv2 = Data_bigarray_val(v2);
	LOAD_FUNCTION(glGetColorTableParameterfvSGI);
	(*stub_glGetColorTableParameterfvSGI)(lv0, lv1, lv2);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glGetColorTableParameteriv,(GLenum, GLenum, GLint*),void);
value glstub_glGetColorTableParameteriv(value v0, value v1, value v2)
{
	CAMLparam3(v0, v1, v2);
	GLenum lv0 = Int_val(v0);
	GLenum lv1 = Int_val(v1);
	GLint* lv2 = Data_bigarray_val(v2);
	LOAD_FUNCTION(glGetColorTableParameteriv);
	(*stub_glGetColorTableParameteriv)(lv0, lv1, lv2);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glGetColorTableParameterivEXT,(GLenum, GLenum, GLint*),void);
value glstub_glGetColorTableParameterivEXT(value v0, value v1, value v2)
{
	CAMLparam3(v0, v1, v2);
	GLenum lv0 = Int_val(v0);
	GLenum lv1 = Int_val(v1);
	GLint* lv2 = Data_bigarray_val(v2);
	LOAD_FUNCTION(glGetColorTableParameterivEXT);
	(*stub_glGetColorTableParameterivEXT)(lv0, lv1, lv2);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glGetColorTableParameterivSGI,(GLenum, GLenum, GLint*),void);
value glstub_glGetColorTableParameterivSGI(value v0, value v1, value v2)
{
	CAMLparam3(v0, v1, v2);
	GLenum lv0 = Int_val(v0);
	GLenum lv1 = Int_val(v1);
	GLint* lv2 = Data_bigarray_val(v2);
	LOAD_FUNCTION(glGetColorTableParameterivSGI);
	(*stub_glGetColorTableParameterivSGI)(lv0, lv1, lv2);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glGetColorTableSGI,(GLenum, GLenum, GLenum, GLvoid*),void);
value glstub_glGetColorTableSGI(value v0, value v1, value v2, value v3)
{
	CAMLparam4(v0, v1, v2, v3);
	GLenum lv0 = Int_val(v0);
	GLenum lv1 = Int_val(v1);
	GLenum lv2 = Int_val(v2);
	GLvoid* lv3 = (GLvoid *)((Tag_val(v3) == String_tag)? (String_val(v3)) : (Data_bigarray_val(v3)));
	LOAD_FUNCTION(glGetColorTableSGI);
	(*stub_glGetColorTableSGI)(lv0, lv1, lv2, lv3);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glGetCombinerInputParameterfvNV,(GLenum, GLenum, GLenum, GLenum, GLfloat*),void);
value glstub_glGetCombinerInputParameterfvNV(value v0, value v1, value v2, value v3, value v4)
{
	CAMLparam5(v0, v1, v2, v3, v4);
	GLenum lv0 = Int_val(v0);
	GLenum lv1 = Int_val(v1);
	GLenum lv2 = Int_val(v2);
	GLenum lv3 = Int_val(v3);
	GLfloat* lv4 = Data_bigarray_val(v4);
	LOAD_FUNCTION(glGetCombinerInputParameterfvNV);
	(*stub_glGetCombinerInputParameterfvNV)(lv0, lv1, lv2, lv3, lv4);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glGetCombinerInputParameterivNV,(GLenum, GLenum, GLenum, GLenum, GLint*),void);
value glstub_glGetCombinerInputParameterivNV(value v0, value v1, value v2, value v3, value v4)
{
	CAMLparam5(v0, v1, v2, v3, v4);
	GLenum lv0 = Int_val(v0);
	GLenum lv1 = Int_val(v1);
	GLenum lv2 = Int_val(v2);
	GLenum lv3 = Int_val(v3);
	GLint* lv4 = Data_bigarray_val(v4);
	LOAD_FUNCTION(glGetCombinerInputParameterivNV);
	(*stub_glGetCombinerInputParameterivNV)(lv0, lv1, lv2, lv3, lv4);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glGetCombinerOutputParameterfvNV,(GLenum, GLenum, GLenum, GLfloat*),void);
value glstub_glGetCombinerOutputParameterfvNV(value v0, value v1, value v2, value v3)
{
	CAMLparam4(v0, v1, v2, v3);
	GLenum lv0 = Int_val(v0);
	GLenum lv1 = Int_val(v1);
	GLenum lv2 = Int_val(v2);
	GLfloat* lv3 = Data_bigarray_val(v3);
	LOAD_FUNCTION(glGetCombinerOutputParameterfvNV);
	(*stub_glGetCombinerOutputParameterfvNV)(lv0, lv1, lv2, lv3);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glGetCombinerOutputParameterivNV,(GLenum, GLenum, GLenum, GLint*),void);
value glstub_glGetCombinerOutputParameterivNV(value v0, value v1, value v2, value v3)
{
	CAMLparam4(v0, v1, v2, v3);
	GLenum lv0 = Int_val(v0);
	GLenum lv1 = Int_val(v1);
	GLenum lv2 = Int_val(v2);
	GLint* lv3 = Data_bigarray_val(v3);
	LOAD_FUNCTION(glGetCombinerOutputParameterivNV);
	(*stub_glGetCombinerOutputParameterivNV)(lv0, lv1, lv2, lv3);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glGetCombinerStageParameterfvNV,(GLenum, GLenum, GLfloat*),void);
value glstub_glGetCombinerStageParameterfvNV(value v0, value v1, value v2)
{
	CAMLparam3(v0, v1, v2);
	GLenum lv0 = Int_val(v0);
	GLenum lv1 = Int_val(v1);
	GLfloat* lv2 = Data_bigarray_val(v2);
	LOAD_FUNCTION(glGetCombinerStageParameterfvNV);
	(*stub_glGetCombinerStageParameterfvNV)(lv0, lv1, lv2);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glGetCompressedTexImage,(GLenum, GLint, GLvoid*),void);
value glstub_glGetCompressedTexImage(value v0, value v1, value v2)
{
	CAMLparam3(v0, v1, v2);
	GLenum lv0 = Int_val(v0);
	GLint lv1 = Int_val(v1);
	GLvoid* lv2 = (GLvoid *)((Tag_val(v2) == String_tag)? (String_val(v2)) : (Data_bigarray_val(v2)));
	LOAD_FUNCTION(glGetCompressedTexImage);
	(*stub_glGetCompressedTexImage)(lv0, lv1, lv2);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glGetCompressedTexImageARB,(GLenum, GLint, GLvoid*),void);
value glstub_glGetCompressedTexImageARB(value v0, value v1, value v2)
{
	CAMLparam3(v0, v1, v2);
	GLenum lv0 = Int_val(v0);
	GLint lv1 = Int_val(v1);
	GLvoid* lv2 = (GLvoid *)((Tag_val(v2) == String_tag)? (String_val(v2)) : (Data_bigarray_val(v2)));
	LOAD_FUNCTION(glGetCompressedTexImageARB);
	(*stub_glGetCompressedTexImageARB)(lv0, lv1, lv2);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glGetConvolutionFilter,(GLenum, GLenum, GLenum, GLvoid*),void);
value glstub_glGetConvolutionFilter(value v0, value v1, value v2, value v3)
{
	CAMLparam4(v0, v1, v2, v3);
	GLenum lv0 = Int_val(v0);
	GLenum lv1 = Int_val(v1);
	GLenum lv2 = Int_val(v2);
	GLvoid* lv3 = (GLvoid *)((Tag_val(v3) == String_tag)? (String_val(v3)) : (Data_bigarray_val(v3)));
	LOAD_FUNCTION(glGetConvolutionFilter);
	(*stub_glGetConvolutionFilter)(lv0, lv1, lv2, lv3);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glGetConvolutionFilterEXT,(GLenum, GLenum, GLenum, GLvoid*),void);
value glstub_glGetConvolutionFilterEXT(value v0, value v1, value v2, value v3)
{
	CAMLparam4(v0, v1, v2, v3);
	GLenum lv0 = Int_val(v0);
	GLenum lv1 = Int_val(v1);
	GLenum lv2 = Int_val(v2);
	GLvoid* lv3 = (GLvoid *)((Tag_val(v3) == String_tag)? (String_val(v3)) : (Data_bigarray_val(v3)));
	LOAD_FUNCTION(glGetConvolutionFilterEXT);
	(*stub_glGetConvolutionFilterEXT)(lv0, lv1, lv2, lv3);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glGetConvolutionParameterfv,(GLenum, GLenum, GLfloat*),void);
value glstub_glGetConvolutionParameterfv(value v0, value v1, value v2)
{
	CAMLparam3(v0, v1, v2);
	GLenum lv0 = Int_val(v0);
	GLenum lv1 = Int_val(v1);
	GLfloat* lv2 = Data_bigarray_val(v2);
	LOAD_FUNCTION(glGetConvolutionParameterfv);
	(*stub_glGetConvolutionParameterfv)(lv0, lv1, lv2);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glGetConvolutionParameterfvEXT,(GLenum, GLenum, GLfloat*),void);
value glstub_glGetConvolutionParameterfvEXT(value v0, value v1, value v2)
{
	CAMLparam3(v0, v1, v2);
	GLenum lv0 = Int_val(v0);
	GLenum lv1 = Int_val(v1);
	GLfloat* lv2 = Data_bigarray_val(v2);
	LOAD_FUNCTION(glGetConvolutionParameterfvEXT);
	(*stub_glGetConvolutionParameterfvEXT)(lv0, lv1, lv2);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glGetConvolutionParameteriv,(GLenum, GLenum, GLint*),void);
value glstub_glGetConvolutionParameteriv(value v0, value v1, value v2)
{
	CAMLparam3(v0, v1, v2);
	GLenum lv0 = Int_val(v0);
	GLenum lv1 = Int_val(v1);
	GLint* lv2 = Data_bigarray_val(v2);
	LOAD_FUNCTION(glGetConvolutionParameteriv);
	(*stub_glGetConvolutionParameteriv)(lv0, lv1, lv2);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glGetConvolutionParameterivEXT,(GLenum, GLenum, GLint*),void);
value glstub_glGetConvolutionParameterivEXT(value v0, value v1, value v2)
{
	CAMLparam3(v0, v1, v2);
	GLenum lv0 = Int_val(v0);
	GLenum lv1 = Int_val(v1);
	GLint* lv2 = Data_bigarray_val(v2);
	LOAD_FUNCTION(glGetConvolutionParameterivEXT);
	(*stub_glGetConvolutionParameterivEXT)(lv0, lv1, lv2);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glGetDetailTexFuncSGIS,(GLenum, GLfloat*),void);
value glstub_glGetDetailTexFuncSGIS(value v0, value v1)
{
	CAMLparam2(v0, v1);
	GLenum lv0 = Int_val(v0);
	GLfloat* lv1 = Data_bigarray_val(v1);
	LOAD_FUNCTION(glGetDetailTexFuncSGIS);
	(*stub_glGetDetailTexFuncSGIS)(lv0, lv1);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glGetDoublev,(GLenum, GLdouble*),void);
value glstub_glGetDoublev(value v0, value v1)
{
	CAMLparam2(v0, v1);
	GLenum lv0 = Int_val(v0);
	GLdouble* lv1 = (Tag_val(v1) == Double_array_tag)? (double *)v1: Data_bigarray_val(v1);
	LOAD_FUNCTION(glGetDoublev);
	(*stub_glGetDoublev)(lv0, lv1);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glGetError,(void),GLenum);
value glstub_glGetError(value v0)
{
	CAMLparam1(v0);
	CAMLlocal1(result);
	GLenum ret;
	LOAD_FUNCTION(glGetError);
	ret = (*stub_glGetError)();
	result = Val_int(ret);
	CAMLreturn(result);
}

DECLARE_FUNCTION(glGetFenceivNV,(GLuint, GLenum, GLint*),void);
value glstub_glGetFenceivNV(value v0, value v1, value v2)
{
	CAMLparam3(v0, v1, v2);
	GLuint lv0 = Int_val(v0);
	GLenum lv1 = Int_val(v1);
	GLint* lv2 = Data_bigarray_val(v2);
	LOAD_FUNCTION(glGetFenceivNV);
	(*stub_glGetFenceivNV)(lv0, lv1, lv2);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glGetFinalCombinerInputParameterfvNV,(GLenum, GLenum, GLfloat*),void);
value glstub_glGetFinalCombinerInputParameterfvNV(value v0, value v1, value v2)
{
	CAMLparam3(v0, v1, v2);
	GLenum lv0 = Int_val(v0);
	GLenum lv1 = Int_val(v1);
	GLfloat* lv2 = Data_bigarray_val(v2);
	LOAD_FUNCTION(glGetFinalCombinerInputParameterfvNV);
	(*stub_glGetFinalCombinerInputParameterfvNV)(lv0, lv1, lv2);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glGetFinalCombinerInputParameterivNV,(GLenum, GLenum, GLint*),void);
value glstub_glGetFinalCombinerInputParameterivNV(value v0, value v1, value v2)
{
	CAMLparam3(v0, v1, v2);
	GLenum lv0 = Int_val(v0);
	GLenum lv1 = Int_val(v1);
	GLint* lv2 = Data_bigarray_val(v2);
	LOAD_FUNCTION(glGetFinalCombinerInputParameterivNV);
	(*stub_glGetFinalCombinerInputParameterivNV)(lv0, lv1, lv2);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glGetFloatv,(GLenum, GLfloat*),void);
value glstub_glGetFloatv(value v0, value v1)
{
	CAMLparam2(v0, v1);
	GLenum lv0 = Int_val(v0);
	GLfloat* lv1 = Data_bigarray_val(v1);
	LOAD_FUNCTION(glGetFloatv);
	(*stub_glGetFloatv)(lv0, lv1);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glGetFogFuncSGIS,(GLfloat*),void);
value glstub_glGetFogFuncSGIS(value v0)
{
	CAMLparam1(v0);
	GLfloat* lv0 = Data_bigarray_val(v0);
	LOAD_FUNCTION(glGetFogFuncSGIS);
	(*stub_glGetFogFuncSGIS)(lv0);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glGetFragDataLocationEXT,(GLuint, GLchar*),GLint);
value glstub_glGetFragDataLocationEXT(value v0, value v1)
{
	CAMLparam2(v0, v1);
	CAMLlocal1(result);
	GLuint lv0 = Int_val(v0);
	GLchar* lv1 = String_val(v1);
	GLint ret;
	LOAD_FUNCTION(glGetFragDataLocationEXT);
	ret = (*stub_glGetFragDataLocationEXT)(lv0, lv1);
	result = Val_int(ret);
	CAMLreturn(result);
}

DECLARE_FUNCTION(glGetFragmentLightfvEXT,(GLenum, GLenum, GLfloat*),void);
value glstub_glGetFragmentLightfvEXT(value v0, value v1, value v2)
{
	CAMLparam3(v0, v1, v2);
	GLenum lv0 = Int_val(v0);
	GLenum lv1 = Int_val(v1);
	GLfloat* lv2 = Data_bigarray_val(v2);
	LOAD_FUNCTION(glGetFragmentLightfvEXT);
	(*stub_glGetFragmentLightfvEXT)(lv0, lv1, lv2);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glGetFragmentLightfvSGIX,(GLenum, GLenum, GLfloat*),void);
value glstub_glGetFragmentLightfvSGIX(value v0, value v1, value v2)
{
	CAMLparam3(v0, v1, v2);
	GLenum lv0 = Int_val(v0);
	GLenum lv1 = Int_val(v1);
	GLfloat* lv2 = Data_bigarray_val(v2);
	LOAD_FUNCTION(glGetFragmentLightfvSGIX);
	(*stub_glGetFragmentLightfvSGIX)(lv0, lv1, lv2);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glGetFragmentLightivEXT,(GLenum, GLenum, GLint*),void);
value glstub_glGetFragmentLightivEXT(value v0, value v1, value v2)
{
	CAMLparam3(v0, v1, v2);
	GLenum lv0 = Int_val(v0);
	GLenum lv1 = Int_val(v1);
	GLint* lv2 = Data_bigarray_val(v2);
	LOAD_FUNCTION(glGetFragmentLightivEXT);
	(*stub_glGetFragmentLightivEXT)(lv0, lv1, lv2);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glGetFragmentLightivSGIX,(GLenum, GLenum, GLint*),void);
value glstub_glGetFragmentLightivSGIX(value v0, value v1, value v2)
{
	CAMLparam3(v0, v1, v2);
	GLenum lv0 = Int_val(v0);
	GLenum lv1 = Int_val(v1);
	GLint* lv2 = Data_bigarray_val(v2);
	LOAD_FUNCTION(glGetFragmentLightivSGIX);
	(*stub_glGetFragmentLightivSGIX)(lv0, lv1, lv2);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glGetFragmentMaterialfvEXT,(GLenum, GLenum, GLfloat*),void);
value glstub_glGetFragmentMaterialfvEXT(value v0, value v1, value v2)
{
	CAMLparam3(v0, v1, v2);
	GLenum lv0 = Int_val(v0);
	GLenum lv1 = Int_val(v1);
	GLfloat* lv2 = Data_bigarray_val(v2);
	LOAD_FUNCTION(glGetFragmentMaterialfvEXT);
	(*stub_glGetFragmentMaterialfvEXT)(lv0, lv1, lv2);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glGetFragmentMaterialfvSGIX,(GLenum, GLenum, GLfloat*),void);
value glstub_glGetFragmentMaterialfvSGIX(value v0, value v1, value v2)
{
	CAMLparam3(v0, v1, v2);
	GLenum lv0 = Int_val(v0);
	GLenum lv1 = Int_val(v1);
	GLfloat* lv2 = Data_bigarray_val(v2);
	LOAD_FUNCTION(glGetFragmentMaterialfvSGIX);
	(*stub_glGetFragmentMaterialfvSGIX)(lv0, lv1, lv2);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glGetFragmentMaterialivEXT,(GLenum, GLenum, GLint*),void);
value glstub_glGetFragmentMaterialivEXT(value v0, value v1, value v2)
{
	CAMLparam3(v0, v1, v2);
	GLenum lv0 = Int_val(v0);
	GLenum lv1 = Int_val(v1);
	GLint* lv2 = Data_bigarray_val(v2);
	LOAD_FUNCTION(glGetFragmentMaterialivEXT);
	(*stub_glGetFragmentMaterialivEXT)(lv0, lv1, lv2);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glGetFragmentMaterialivSGIX,(GLenum, GLenum, GLint*),void);
value glstub_glGetFragmentMaterialivSGIX(value v0, value v1, value v2)
{
	CAMLparam3(v0, v1, v2);
	GLenum lv0 = Int_val(v0);
	GLenum lv1 = Int_val(v1);
	GLint* lv2 = Data_bigarray_val(v2);
	LOAD_FUNCTION(glGetFragmentMaterialivSGIX);
	(*stub_glGetFragmentMaterialivSGIX)(lv0, lv1, lv2);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glGetFramebufferAttachmentParameterivEXT,(GLenum, GLenum, GLenum, GLint*),void);
value glstub_glGetFramebufferAttachmentParameterivEXT(value v0, value v1, value v2, value v3)
{
	CAMLparam4(v0, v1, v2, v3);
	GLenum lv0 = Int_val(v0);
	GLenum lv1 = Int_val(v1);
	GLenum lv2 = Int_val(v2);
	GLint* lv3 = Data_bigarray_val(v3);
	LOAD_FUNCTION(glGetFramebufferAttachmentParameterivEXT);
	(*stub_glGetFramebufferAttachmentParameterivEXT)(lv0, lv1, lv2, lv3);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glGetHandleARB,(GLenum),GLuint);
value glstub_glGetHandleARB(value v0)
{
	CAMLparam1(v0);
	CAMLlocal1(result);
	GLenum lv0 = Int_val(v0);
	GLuint ret;
	LOAD_FUNCTION(glGetHandleARB);
	ret = (*stub_glGetHandleARB)(lv0);
	result = Val_int(ret);
	CAMLreturn(result);
}

DECLARE_FUNCTION(glGetHistogram,(GLenum, GLboolean, GLenum, GLenum, GLvoid*),void);
value glstub_glGetHistogram(value v0, value v1, value v2, value v3, value v4)
{
	CAMLparam5(v0, v1, v2, v3, v4);
	GLenum lv0 = Int_val(v0);
	GLboolean lv1 = Bool_val(v1);
	GLenum lv2 = Int_val(v2);
	GLenum lv3 = Int_val(v3);
	GLvoid* lv4 = (GLvoid *)((Tag_val(v4) == String_tag)? (String_val(v4)) : (Data_bigarray_val(v4)));
	LOAD_FUNCTION(glGetHistogram);
	(*stub_glGetHistogram)(lv0, lv1, lv2, lv3, lv4);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glGetHistogramEXT,(GLenum, GLboolean, GLenum, GLenum, GLvoid*),void);
value glstub_glGetHistogramEXT(value v0, value v1, value v2, value v3, value v4)
{
	CAMLparam5(v0, v1, v2, v3, v4);
	GLenum lv0 = Int_val(v0);
	GLboolean lv1 = Bool_val(v1);
	GLenum lv2 = Int_val(v2);
	GLenum lv3 = Int_val(v3);
	GLvoid* lv4 = (GLvoid *)((Tag_val(v4) == String_tag)? (String_val(v4)) : (Data_bigarray_val(v4)));
	LOAD_FUNCTION(glGetHistogramEXT);
	(*stub_glGetHistogramEXT)(lv0, lv1, lv2, lv3, lv4);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glGetHistogramParameterfv,(GLenum, GLenum, GLfloat*),void);
value glstub_glGetHistogramParameterfv(value v0, value v1, value v2)
{
	CAMLparam3(v0, v1, v2);
	GLenum lv0 = Int_val(v0);
	GLenum lv1 = Int_val(v1);
	GLfloat* lv2 = Data_bigarray_val(v2);
	LOAD_FUNCTION(glGetHistogramParameterfv);
	(*stub_glGetHistogramParameterfv)(lv0, lv1, lv2);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glGetHistogramParameterfvEXT,(GLenum, GLenum, GLfloat*),void);
value glstub_glGetHistogramParameterfvEXT(value v0, value v1, value v2)
{
	CAMLparam3(v0, v1, v2);
	GLenum lv0 = Int_val(v0);
	GLenum lv1 = Int_val(v1);
	GLfloat* lv2 = Data_bigarray_val(v2);
	LOAD_FUNCTION(glGetHistogramParameterfvEXT);
	(*stub_glGetHistogramParameterfvEXT)(lv0, lv1, lv2);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glGetHistogramParameteriv,(GLenum, GLenum, GLint*),void);
value glstub_glGetHistogramParameteriv(value v0, value v1, value v2)
{
	CAMLparam3(v0, v1, v2);
	GLenum lv0 = Int_val(v0);
	GLenum lv1 = Int_val(v1);
	GLint* lv2 = Data_bigarray_val(v2);
	LOAD_FUNCTION(glGetHistogramParameteriv);
	(*stub_glGetHistogramParameteriv)(lv0, lv1, lv2);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glGetHistogramParameterivEXT,(GLenum, GLenum, GLint*),void);
value glstub_glGetHistogramParameterivEXT(value v0, value v1, value v2)
{
	CAMLparam3(v0, v1, v2);
	GLenum lv0 = Int_val(v0);
	GLenum lv1 = Int_val(v1);
	GLint* lv2 = Data_bigarray_val(v2);
	LOAD_FUNCTION(glGetHistogramParameterivEXT);
	(*stub_glGetHistogramParameterivEXT)(lv0, lv1, lv2);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glGetImageTransformParameterfvHP,(GLenum, GLenum, GLfloat*),void);
value glstub_glGetImageTransformParameterfvHP(value v0, value v1, value v2)
{
	CAMLparam3(v0, v1, v2);
	GLenum lv0 = Int_val(v0);
	GLenum lv1 = Int_val(v1);
	GLfloat* lv2 = Data_bigarray_val(v2);
	LOAD_FUNCTION(glGetImageTransformParameterfvHP);
	(*stub_glGetImageTransformParameterfvHP)(lv0, lv1, lv2);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glGetImageTransformParameterivHP,(GLenum, GLenum, GLint*),void);
value glstub_glGetImageTransformParameterivHP(value v0, value v1, value v2)
{
	CAMLparam3(v0, v1, v2);
	GLenum lv0 = Int_val(v0);
	GLenum lv1 = Int_val(v1);
	GLint* lv2 = Data_bigarray_val(v2);
	LOAD_FUNCTION(glGetImageTransformParameterivHP);
	(*stub_glGetImageTransformParameterivHP)(lv0, lv1, lv2);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glGetInfoLogARB,(GLuint, GLsizei, GLsizei*, GLchar*),void);
value glstub_glGetInfoLogARB(value v0, value v1, value v2, value v3)
{
	CAMLparam4(v0, v1, v2, v3);
	GLuint lv0 = Int_val(v0);
	GLsizei lv1 = Int_val(v1);
	GLsizei* lv2 = Data_bigarray_val(v2);
	GLchar* lv3 = String_val(v3);
	LOAD_FUNCTION(glGetInfoLogARB);
	(*stub_glGetInfoLogARB)(lv0, lv1, lv2, lv3);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glGetIntegerIndexedvEXT,(GLenum, GLuint, GLint*),void);
value glstub_glGetIntegerIndexedvEXT(value v0, value v1, value v2)
{
	CAMLparam3(v0, v1, v2);
	GLenum lv0 = Int_val(v0);
	GLuint lv1 = Int_val(v1);
	GLint* lv2 = Data_bigarray_val(v2);
	LOAD_FUNCTION(glGetIntegerIndexedvEXT);
	(*stub_glGetIntegerIndexedvEXT)(lv0, lv1, lv2);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glGetIntegerv,(GLenum, GLint*),void);
value glstub_glGetIntegerv(value v0, value v1)
{
	CAMLparam2(v0, v1);
	GLenum lv0 = Int_val(v0);
	GLint* lv1 = Data_bigarray_val(v1);
	LOAD_FUNCTION(glGetIntegerv);
	(*stub_glGetIntegerv)(lv0, lv1);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glGetInvariantBooleanvEXT,(GLuint, GLenum, GLboolean*),void);
value glstub_glGetInvariantBooleanvEXT(value v0, value v1, value v2)
{
	CAMLparam3(v0, v1, v2);
	GLuint lv0 = Int_val(v0);
	GLenum lv1 = Int_val(v1);
	GLboolean* lv2 = Data_bigarray_val(v2);
	LOAD_FUNCTION(glGetInvariantBooleanvEXT);
	(*stub_glGetInvariantBooleanvEXT)(lv0, lv1, lv2);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glGetInvariantFloatvEXT,(GLuint, GLenum, GLfloat*),void);
value glstub_glGetInvariantFloatvEXT(value v0, value v1, value v2)
{
	CAMLparam3(v0, v1, v2);
	GLuint lv0 = Int_val(v0);
	GLenum lv1 = Int_val(v1);
	GLfloat* lv2 = Data_bigarray_val(v2);
	LOAD_FUNCTION(glGetInvariantFloatvEXT);
	(*stub_glGetInvariantFloatvEXT)(lv0, lv1, lv2);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glGetInvariantIntegervEXT,(GLuint, GLenum, GLint*),void);
value glstub_glGetInvariantIntegervEXT(value v0, value v1, value v2)
{
	CAMLparam3(v0, v1, v2);
	GLuint lv0 = Int_val(v0);
	GLenum lv1 = Int_val(v1);
	GLint* lv2 = Data_bigarray_val(v2);
	LOAD_FUNCTION(glGetInvariantIntegervEXT);
	(*stub_glGetInvariantIntegervEXT)(lv0, lv1, lv2);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glGetLightfv,(GLenum, GLenum, GLfloat*),void);
value glstub_glGetLightfv(value v0, value v1, value v2)
{
	CAMLparam3(v0, v1, v2);
	GLenum lv0 = Int_val(v0);
	GLenum lv1 = Int_val(v1);
	GLfloat* lv2 = Data_bigarray_val(v2);
	LOAD_FUNCTION(glGetLightfv);
	(*stub_glGetLightfv)(lv0, lv1, lv2);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glGetLightiv,(GLenum, GLenum, GLint*),void);
value glstub_glGetLightiv(value v0, value v1, value v2)
{
	CAMLparam3(v0, v1, v2);
	GLenum lv0 = Int_val(v0);
	GLenum lv1 = Int_val(v1);
	GLint* lv2 = Data_bigarray_val(v2);
	LOAD_FUNCTION(glGetLightiv);
	(*stub_glGetLightiv)(lv0, lv1, lv2);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glGetLocalConstantBooleanvEXT,(GLuint, GLenum, GLboolean*),void);
value glstub_glGetLocalConstantBooleanvEXT(value v0, value v1, value v2)
{
	CAMLparam3(v0, v1, v2);
	GLuint lv0 = Int_val(v0);
	GLenum lv1 = Int_val(v1);
	GLboolean* lv2 = Data_bigarray_val(v2);
	LOAD_FUNCTION(glGetLocalConstantBooleanvEXT);
	(*stub_glGetLocalConstantBooleanvEXT)(lv0, lv1, lv2);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glGetLocalConstantFloatvEXT,(GLuint, GLenum, GLfloat*),void);
value glstub_glGetLocalConstantFloatvEXT(value v0, value v1, value v2)
{
	CAMLparam3(v0, v1, v2);
	GLuint lv0 = Int_val(v0);
	GLenum lv1 = Int_val(v1);
	GLfloat* lv2 = Data_bigarray_val(v2);
	LOAD_FUNCTION(glGetLocalConstantFloatvEXT);
	(*stub_glGetLocalConstantFloatvEXT)(lv0, lv1, lv2);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glGetLocalConstantIntegervEXT,(GLuint, GLenum, GLint*),void);
value glstub_glGetLocalConstantIntegervEXT(value v0, value v1, value v2)
{
	CAMLparam3(v0, v1, v2);
	GLuint lv0 = Int_val(v0);
	GLenum lv1 = Int_val(v1);
	GLint* lv2 = Data_bigarray_val(v2);
	LOAD_FUNCTION(glGetLocalConstantIntegervEXT);
	(*stub_glGetLocalConstantIntegervEXT)(lv0, lv1, lv2);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glGetMapAttribParameterfvNV,(GLenum, GLuint, GLenum, GLfloat*),void);
value glstub_glGetMapAttribParameterfvNV(value v0, value v1, value v2, value v3)
{
	CAMLparam4(v0, v1, v2, v3);
	GLenum lv0 = Int_val(v0);
	GLuint lv1 = Int_val(v1);
	GLenum lv2 = Int_val(v2);
	GLfloat* lv3 = Data_bigarray_val(v3);
	LOAD_FUNCTION(glGetMapAttribParameterfvNV);
	(*stub_glGetMapAttribParameterfvNV)(lv0, lv1, lv2, lv3);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glGetMapAttribParameterivNV,(GLenum, GLuint, GLenum, GLint*),void);
value glstub_glGetMapAttribParameterivNV(value v0, value v1, value v2, value v3)
{
	CAMLparam4(v0, v1, v2, v3);
	GLenum lv0 = Int_val(v0);
	GLuint lv1 = Int_val(v1);
	GLenum lv2 = Int_val(v2);
	GLint* lv3 = Data_bigarray_val(v3);
	LOAD_FUNCTION(glGetMapAttribParameterivNV);
	(*stub_glGetMapAttribParameterivNV)(lv0, lv1, lv2, lv3);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glGetMapControlPointsNV,(GLenum, GLuint, GLenum, GLsizei, GLsizei, GLboolean, GLvoid*),void);
value glstub_glGetMapControlPointsNV(value v0, value v1, value v2, value v3, value v4, value v5, value v6)
{
	CAMLparam5(v0, v1, v2, v3, v4);
	CAMLxparam2(v5, v6);
	GLenum lv0 = Int_val(v0);
	GLuint lv1 = Int_val(v1);
	GLenum lv2 = Int_val(v2);
	GLsizei lv3 = Int_val(v3);
	GLsizei lv4 = Int_val(v4);
	GLboolean lv5 = Bool_val(v5);
	GLvoid* lv6 = (GLvoid *)((Tag_val(v6) == String_tag)? (String_val(v6)) : (Data_bigarray_val(v6)));
	LOAD_FUNCTION(glGetMapControlPointsNV);
	(*stub_glGetMapControlPointsNV)(lv0, lv1, lv2, lv3, lv4, lv5, lv6);
	CAMLreturn(Val_unit);
}

value glstub_glGetMapControlPointsNV_byte(value * argv, int n)
{
	return glstub_glGetMapControlPointsNV(argv[0], argv[1], argv[2], argv[3], argv[4], argv[5], argv[6]);
}

DECLARE_FUNCTION(glGetMapParameterfvNV,(GLenum, GLenum, GLfloat*),void);
value glstub_glGetMapParameterfvNV(value v0, value v1, value v2)
{
	CAMLparam3(v0, v1, v2);
	GLenum lv0 = Int_val(v0);
	GLenum lv1 = Int_val(v1);
	GLfloat* lv2 = Data_bigarray_val(v2);
	LOAD_FUNCTION(glGetMapParameterfvNV);
	(*stub_glGetMapParameterfvNV)(lv0, lv1, lv2);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glGetMapParameterivNV,(GLenum, GLenum, GLint*),void);
value glstub_glGetMapParameterivNV(value v0, value v1, value v2)
{
	CAMLparam3(v0, v1, v2);
	GLenum lv0 = Int_val(v0);
	GLenum lv1 = Int_val(v1);
	GLint* lv2 = Data_bigarray_val(v2);
	LOAD_FUNCTION(glGetMapParameterivNV);
	(*stub_glGetMapParameterivNV)(lv0, lv1, lv2);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glGetMapdv,(GLenum, GLenum, GLdouble*),void);
value glstub_glGetMapdv(value v0, value v1, value v2)
{
	CAMLparam3(v0, v1, v2);
	GLenum lv0 = Int_val(v0);
	GLenum lv1 = Int_val(v1);
	GLdouble* lv2 = (Tag_val(v2) == Double_array_tag)? (double *)v2: Data_bigarray_val(v2);
	LOAD_FUNCTION(glGetMapdv);
	(*stub_glGetMapdv)(lv0, lv1, lv2);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glGetMapfv,(GLenum, GLenum, GLfloat*),void);
value glstub_glGetMapfv(value v0, value v1, value v2)
{
	CAMLparam3(v0, v1, v2);
	GLenum lv0 = Int_val(v0);
	GLenum lv1 = Int_val(v1);
	GLfloat* lv2 = Data_bigarray_val(v2);
	LOAD_FUNCTION(glGetMapfv);
	(*stub_glGetMapfv)(lv0, lv1, lv2);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glGetMapiv,(GLenum, GLenum, GLint*),void);
value glstub_glGetMapiv(value v0, value v1, value v2)
{
	CAMLparam3(v0, v1, v2);
	GLenum lv0 = Int_val(v0);
	GLenum lv1 = Int_val(v1);
	GLint* lv2 = Data_bigarray_val(v2);
	LOAD_FUNCTION(glGetMapiv);
	(*stub_glGetMapiv)(lv0, lv1, lv2);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glGetMaterialfv,(GLenum, GLenum, GLfloat*),void);
value glstub_glGetMaterialfv(value v0, value v1, value v2)
{
	CAMLparam3(v0, v1, v2);
	GLenum lv0 = Int_val(v0);
	GLenum lv1 = Int_val(v1);
	GLfloat* lv2 = Data_bigarray_val(v2);
	LOAD_FUNCTION(glGetMaterialfv);
	(*stub_glGetMaterialfv)(lv0, lv1, lv2);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glGetMaterialiv,(GLenum, GLenum, GLint*),void);
value glstub_glGetMaterialiv(value v0, value v1, value v2)
{
	CAMLparam3(v0, v1, v2);
	GLenum lv0 = Int_val(v0);
	GLenum lv1 = Int_val(v1);
	GLint* lv2 = Data_bigarray_val(v2);
	LOAD_FUNCTION(glGetMaterialiv);
	(*stub_glGetMaterialiv)(lv0, lv1, lv2);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glGetMinmax,(GLenum, GLboolean, GLenum, GLenum, GLvoid*),void);
value glstub_glGetMinmax(value v0, value v1, value v2, value v3, value v4)
{
	CAMLparam5(v0, v1, v2, v3, v4);
	GLenum lv0 = Int_val(v0);
	GLboolean lv1 = Bool_val(v1);
	GLenum lv2 = Int_val(v2);
	GLenum lv3 = Int_val(v3);
	GLvoid* lv4 = (GLvoid *)((Tag_val(v4) == String_tag)? (String_val(v4)) : (Data_bigarray_val(v4)));
	LOAD_FUNCTION(glGetMinmax);
	(*stub_glGetMinmax)(lv0, lv1, lv2, lv3, lv4);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glGetMinmaxEXT,(GLenum, GLboolean, GLenum, GLenum, GLvoid*),void);
value glstub_glGetMinmaxEXT(value v0, value v1, value v2, value v3, value v4)
{
	CAMLparam5(v0, v1, v2, v3, v4);
	GLenum lv0 = Int_val(v0);
	GLboolean lv1 = Bool_val(v1);
	GLenum lv2 = Int_val(v2);
	GLenum lv3 = Int_val(v3);
	GLvoid* lv4 = (GLvoid *)((Tag_val(v4) == String_tag)? (String_val(v4)) : (Data_bigarray_val(v4)));
	LOAD_FUNCTION(glGetMinmaxEXT);
	(*stub_glGetMinmaxEXT)(lv0, lv1, lv2, lv3, lv4);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glGetMinmaxParameterfv,(GLenum, GLenum, GLfloat*),void);
value glstub_glGetMinmaxParameterfv(value v0, value v1, value v2)
{
	CAMLparam3(v0, v1, v2);
	GLenum lv0 = Int_val(v0);
	GLenum lv1 = Int_val(v1);
	GLfloat* lv2 = Data_bigarray_val(v2);
	LOAD_FUNCTION(glGetMinmaxParameterfv);
	(*stub_glGetMinmaxParameterfv)(lv0, lv1, lv2);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glGetMinmaxParameterfvEXT,(GLenum, GLenum, GLfloat*),void);
value glstub_glGetMinmaxParameterfvEXT(value v0, value v1, value v2)
{
	CAMLparam3(v0, v1, v2);
	GLenum lv0 = Int_val(v0);
	GLenum lv1 = Int_val(v1);
	GLfloat* lv2 = Data_bigarray_val(v2);
	LOAD_FUNCTION(glGetMinmaxParameterfvEXT);
	(*stub_glGetMinmaxParameterfvEXT)(lv0, lv1, lv2);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glGetMinmaxParameteriv,(GLenum, GLenum, GLint*),void);
value glstub_glGetMinmaxParameteriv(value v0, value v1, value v2)
{
	CAMLparam3(v0, v1, v2);
	GLenum lv0 = Int_val(v0);
	GLenum lv1 = Int_val(v1);
	GLint* lv2 = Data_bigarray_val(v2);
	LOAD_FUNCTION(glGetMinmaxParameteriv);
	(*stub_glGetMinmaxParameteriv)(lv0, lv1, lv2);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glGetMinmaxParameterivEXT,(GLenum, GLenum, GLint*),void);
value glstub_glGetMinmaxParameterivEXT(value v0, value v1, value v2)
{
	CAMLparam3(v0, v1, v2);
	GLenum lv0 = Int_val(v0);
	GLenum lv1 = Int_val(v1);
	GLint* lv2 = Data_bigarray_val(v2);
	LOAD_FUNCTION(glGetMinmaxParameterivEXT);
	(*stub_glGetMinmaxParameterivEXT)(lv0, lv1, lv2);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glGetObjectBufferfvATI,(GLuint, GLenum, GLfloat*),void);
value glstub_glGetObjectBufferfvATI(value v0, value v1, value v2)
{
	CAMLparam3(v0, v1, v2);
	GLuint lv0 = Int_val(v0);
	GLenum lv1 = Int_val(v1);
	GLfloat* lv2 = Data_bigarray_val(v2);
	LOAD_FUNCTION(glGetObjectBufferfvATI);
	(*stub_glGetObjectBufferfvATI)(lv0, lv1, lv2);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glGetObjectBufferivATI,(GLuint, GLenum, GLint*),void);
value glstub_glGetObjectBufferivATI(value v0, value v1, value v2)
{
	CAMLparam3(v0, v1, v2);
	GLuint lv0 = Int_val(v0);
	GLenum lv1 = Int_val(v1);
	GLint* lv2 = Data_bigarray_val(v2);
	LOAD_FUNCTION(glGetObjectBufferivATI);
	(*stub_glGetObjectBufferivATI)(lv0, lv1, lv2);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glGetObjectParameterfvARB,(GLuint, GLenum, GLfloat*),void);
value glstub_glGetObjectParameterfvARB(value v0, value v1, value v2)
{
	CAMLparam3(v0, v1, v2);
	GLuint lv0 = Int_val(v0);
	GLenum lv1 = Int_val(v1);
	GLfloat* lv2 = Data_bigarray_val(v2);
	LOAD_FUNCTION(glGetObjectParameterfvARB);
	(*stub_glGetObjectParameterfvARB)(lv0, lv1, lv2);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glGetObjectParameterivARB,(GLuint, GLenum, GLint*),void);
value glstub_glGetObjectParameterivARB(value v0, value v1, value v2)
{
	CAMLparam3(v0, v1, v2);
	GLuint lv0 = Int_val(v0);
	GLenum lv1 = Int_val(v1);
	GLint* lv2 = Data_bigarray_val(v2);
	LOAD_FUNCTION(glGetObjectParameterivARB);
	(*stub_glGetObjectParameterivARB)(lv0, lv1, lv2);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glGetOcclusionQueryivNV,(GLuint, GLenum, GLint*),void);
value glstub_glGetOcclusionQueryivNV(value v0, value v1, value v2)
{
	CAMLparam3(v0, v1, v2);
	GLuint lv0 = Int_val(v0);
	GLenum lv1 = Int_val(v1);
	GLint* lv2 = Data_bigarray_val(v2);
	LOAD_FUNCTION(glGetOcclusionQueryivNV);
	(*stub_glGetOcclusionQueryivNV)(lv0, lv1, lv2);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glGetOcclusionQueryuivNV,(GLuint, GLenum, GLuint*),void);
value glstub_glGetOcclusionQueryuivNV(value v0, value v1, value v2)
{
	CAMLparam3(v0, v1, v2);
	GLuint lv0 = Int_val(v0);
	GLenum lv1 = Int_val(v1);
	GLuint* lv2 = Data_bigarray_val(v2);
	LOAD_FUNCTION(glGetOcclusionQueryuivNV);
	(*stub_glGetOcclusionQueryuivNV)(lv0, lv1, lv2);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glGetPixelMapfv,(GLenum, GLfloat*),void);
value glstub_glGetPixelMapfv(value v0, value v1)
{
	CAMLparam2(v0, v1);
	GLenum lv0 = Int_val(v0);
	GLfloat* lv1 = Data_bigarray_val(v1);
	LOAD_FUNCTION(glGetPixelMapfv);
	(*stub_glGetPixelMapfv)(lv0, lv1);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glGetPixelMapuiv,(GLenum, GLuint*),void);
value glstub_glGetPixelMapuiv(value v0, value v1)
{
	CAMLparam2(v0, v1);
	GLenum lv0 = Int_val(v0);
	GLuint* lv1 = Data_bigarray_val(v1);
	LOAD_FUNCTION(glGetPixelMapuiv);
	(*stub_glGetPixelMapuiv)(lv0, lv1);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glGetPixelMapusv,(GLenum, GLushort*),void);
value glstub_glGetPixelMapusv(value v0, value v1)
{
	CAMLparam2(v0, v1);
	GLenum lv0 = Int_val(v0);
	GLushort* lv1 = Data_bigarray_val(v1);
	LOAD_FUNCTION(glGetPixelMapusv);
	(*stub_glGetPixelMapusv)(lv0, lv1);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glGetPixelTransformParameterfvEXT,(GLenum, GLenum, GLfloat*),void);
value glstub_glGetPixelTransformParameterfvEXT(value v0, value v1, value v2)
{
	CAMLparam3(v0, v1, v2);
	GLenum lv0 = Int_val(v0);
	GLenum lv1 = Int_val(v1);
	GLfloat* lv2 = Data_bigarray_val(v2);
	LOAD_FUNCTION(glGetPixelTransformParameterfvEXT);
	(*stub_glGetPixelTransformParameterfvEXT)(lv0, lv1, lv2);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glGetPixelTransformParameterivEXT,(GLenum, GLenum, GLint*),void);
value glstub_glGetPixelTransformParameterivEXT(value v0, value v1, value v2)
{
	CAMLparam3(v0, v1, v2);
	GLenum lv0 = Int_val(v0);
	GLenum lv1 = Int_val(v1);
	GLint* lv2 = Data_bigarray_val(v2);
	LOAD_FUNCTION(glGetPixelTransformParameterivEXT);
	(*stub_glGetPixelTransformParameterivEXT)(lv0, lv1, lv2);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glGetPointerv,(GLenum, GLvoid**),void);
value glstub_glGetPointerv(value v0, value v1)
{
	CAMLparam2(v0, v1);
	GLenum lv0 = Int_val(v0);
	GLvoid** lv1 = Data_bigarray_val(v1);
	LOAD_FUNCTION(glGetPointerv);
	(*stub_glGetPointerv)(lv0, lv1);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glGetPointervEXT,(GLenum, GLvoid**),void);
value glstub_glGetPointervEXT(value v0, value v1)
{
	CAMLparam2(v0, v1);
	GLenum lv0 = Int_val(v0);
	GLvoid** lv1 = Data_bigarray_val(v1);
	LOAD_FUNCTION(glGetPointervEXT);
	(*stub_glGetPointervEXT)(lv0, lv1);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glGetPolygonStipple,(GLubyte*),void);
value glstub_glGetPolygonStipple(value v0)
{
	CAMLparam1(v0);
	GLubyte* lv0 = Data_bigarray_val(v0);
	LOAD_FUNCTION(glGetPolygonStipple);
	(*stub_glGetPolygonStipple)(lv0);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glGetProgramEnvParameterdvARB,(GLenum, GLuint, GLdouble*),void);
value glstub_glGetProgramEnvParameterdvARB(value v0, value v1, value v2)
{
	CAMLparam3(v0, v1, v2);
	GLenum lv0 = Int_val(v0);
	GLuint lv1 = Int_val(v1);
	GLdouble* lv2 = (Tag_val(v2) == Double_array_tag)? (double *)v2: Data_bigarray_val(v2);
	LOAD_FUNCTION(glGetProgramEnvParameterdvARB);
	(*stub_glGetProgramEnvParameterdvARB)(lv0, lv1, lv2);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glGetProgramEnvParameterfvARB,(GLenum, GLuint, GLfloat*),void);
value glstub_glGetProgramEnvParameterfvARB(value v0, value v1, value v2)
{
	CAMLparam3(v0, v1, v2);
	GLenum lv0 = Int_val(v0);
	GLuint lv1 = Int_val(v1);
	GLfloat* lv2 = Data_bigarray_val(v2);
	LOAD_FUNCTION(glGetProgramEnvParameterfvARB);
	(*stub_glGetProgramEnvParameterfvARB)(lv0, lv1, lv2);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glGetProgramInfoLog,(GLuint, GLsizei, GLsizei*, GLchar*),void);
value glstub_glGetProgramInfoLog(value v0, value v1, value v2, value v3)
{
	CAMLparam4(v0, v1, v2, v3);
	GLuint lv0 = Int_val(v0);
	GLsizei lv1 = Int_val(v1);
	GLsizei* lv2 = Data_bigarray_val(v2);
	GLchar* lv3 = String_val(v3);
	LOAD_FUNCTION(glGetProgramInfoLog);
	(*stub_glGetProgramInfoLog)(lv0, lv1, lv2, lv3);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glGetProgramLocalParameterdvARB,(GLenum, GLuint, GLdouble*),void);
value glstub_glGetProgramLocalParameterdvARB(value v0, value v1, value v2)
{
	CAMLparam3(v0, v1, v2);
	GLenum lv0 = Int_val(v0);
	GLuint lv1 = Int_val(v1);
	GLdouble* lv2 = (Tag_val(v2) == Double_array_tag)? (double *)v2: Data_bigarray_val(v2);
	LOAD_FUNCTION(glGetProgramLocalParameterdvARB);
	(*stub_glGetProgramLocalParameterdvARB)(lv0, lv1, lv2);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glGetProgramLocalParameterfvARB,(GLenum, GLuint, GLfloat*),void);
value glstub_glGetProgramLocalParameterfvARB(value v0, value v1, value v2)
{
	CAMLparam3(v0, v1, v2);
	GLenum lv0 = Int_val(v0);
	GLuint lv1 = Int_val(v1);
	GLfloat* lv2 = Data_bigarray_val(v2);
	LOAD_FUNCTION(glGetProgramLocalParameterfvARB);
	(*stub_glGetProgramLocalParameterfvARB)(lv0, lv1, lv2);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glGetProgramNamedParameterdvNV,(GLuint, GLsizei, GLubyte*, GLdouble*),void);
value glstub_glGetProgramNamedParameterdvNV(value v0, value v1, value v2, value v3)
{
	CAMLparam4(v0, v1, v2, v3);
	GLuint lv0 = Int_val(v0);
	GLsizei lv1 = Int_val(v1);
	GLubyte* lv2 = Data_bigarray_val(v2);
	GLdouble* lv3 = (Tag_val(v3) == Double_array_tag)? (double *)v3: Data_bigarray_val(v3);
	LOAD_FUNCTION(glGetProgramNamedParameterdvNV);
	(*stub_glGetProgramNamedParameterdvNV)(lv0, lv1, lv2, lv3);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glGetProgramNamedParameterfvNV,(GLuint, GLsizei, GLubyte*, GLfloat*),void);
value glstub_glGetProgramNamedParameterfvNV(value v0, value v1, value v2, value v3)
{
	CAMLparam4(v0, v1, v2, v3);
	GLuint lv0 = Int_val(v0);
	GLsizei lv1 = Int_val(v1);
	GLubyte* lv2 = Data_bigarray_val(v2);
	GLfloat* lv3 = Data_bigarray_val(v3);
	LOAD_FUNCTION(glGetProgramNamedParameterfvNV);
	(*stub_glGetProgramNamedParameterfvNV)(lv0, lv1, lv2, lv3);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glGetProgramParameterdvNV,(GLenum, GLuint, GLenum, GLdouble*),void);
value glstub_glGetProgramParameterdvNV(value v0, value v1, value v2, value v3)
{
	CAMLparam4(v0, v1, v2, v3);
	GLenum lv0 = Int_val(v0);
	GLuint lv1 = Int_val(v1);
	GLenum lv2 = Int_val(v2);
	GLdouble* lv3 = (Tag_val(v3) == Double_array_tag)? (double *)v3: Data_bigarray_val(v3);
	LOAD_FUNCTION(glGetProgramParameterdvNV);
	(*stub_glGetProgramParameterdvNV)(lv0, lv1, lv2, lv3);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glGetProgramParameterfvNV,(GLenum, GLuint, GLenum, GLfloat*),void);
value glstub_glGetProgramParameterfvNV(value v0, value v1, value v2, value v3)
{
	CAMLparam4(v0, v1, v2, v3);
	GLenum lv0 = Int_val(v0);
	GLuint lv1 = Int_val(v1);
	GLenum lv2 = Int_val(v2);
	GLfloat* lv3 = Data_bigarray_val(v3);
	LOAD_FUNCTION(glGetProgramParameterfvNV);
	(*stub_glGetProgramParameterfvNV)(lv0, lv1, lv2, lv3);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glGetProgramStringARB,(GLenum, GLenum, GLvoid*),void);
value glstub_glGetProgramStringARB(value v0, value v1, value v2)
{
	CAMLparam3(v0, v1, v2);
	GLenum lv0 = Int_val(v0);
	GLenum lv1 = Int_val(v1);
	GLvoid* lv2 = (GLvoid *)((Tag_val(v2) == String_tag)? (String_val(v2)) : (Data_bigarray_val(v2)));
	LOAD_FUNCTION(glGetProgramStringARB);
	(*stub_glGetProgramStringARB)(lv0, lv1, lv2);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glGetProgramStringNV,(GLuint, GLenum, GLubyte*),void);
value glstub_glGetProgramStringNV(value v0, value v1, value v2)
{
	CAMLparam3(v0, v1, v2);
	GLuint lv0 = Int_val(v0);
	GLenum lv1 = Int_val(v1);
	GLubyte* lv2 = Data_bigarray_val(v2);
	LOAD_FUNCTION(glGetProgramStringNV);
	(*stub_glGetProgramStringNV)(lv0, lv1, lv2);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glGetProgramiv,(GLuint, GLenum, GLint*),void);
value glstub_glGetProgramiv(value v0, value v1, value v2)
{
	CAMLparam3(v0, v1, v2);
	GLuint lv0 = Int_val(v0);
	GLenum lv1 = Int_val(v1);
	GLint* lv2 = Data_bigarray_val(v2);
	LOAD_FUNCTION(glGetProgramiv);
	(*stub_glGetProgramiv)(lv0, lv1, lv2);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glGetProgramivARB,(GLenum, GLenum, GLint*),void);
value glstub_glGetProgramivARB(value v0, value v1, value v2)
{
	CAMLparam3(v0, v1, v2);
	GLenum lv0 = Int_val(v0);
	GLenum lv1 = Int_val(v1);
	GLint* lv2 = Data_bigarray_val(v2);
	LOAD_FUNCTION(glGetProgramivARB);
	(*stub_glGetProgramivARB)(lv0, lv1, lv2);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glGetProgramivNV,(GLuint, GLenum, GLint*),void);
value glstub_glGetProgramivNV(value v0, value v1, value v2)
{
	CAMLparam3(v0, v1, v2);
	GLuint lv0 = Int_val(v0);
	GLenum lv1 = Int_val(v1);
	GLint* lv2 = Data_bigarray_val(v2);
	LOAD_FUNCTION(glGetProgramivNV);
	(*stub_glGetProgramivNV)(lv0, lv1, lv2);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glGetQueryObjectiv,(GLuint, GLenum, GLint*),void);
value glstub_glGetQueryObjectiv(value v0, value v1, value v2)
{
	CAMLparam3(v0, v1, v2);
	GLuint lv0 = Int_val(v0);
	GLenum lv1 = Int_val(v1);
	GLint* lv2 = Data_bigarray_val(v2);
	LOAD_FUNCTION(glGetQueryObjectiv);
	(*stub_glGetQueryObjectiv)(lv0, lv1, lv2);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glGetQueryObjectivARB,(GLuint, GLenum, GLint*),void);
value glstub_glGetQueryObjectivARB(value v0, value v1, value v2)
{
	CAMLparam3(v0, v1, v2);
	GLuint lv0 = Int_val(v0);
	GLenum lv1 = Int_val(v1);
	GLint* lv2 = Data_bigarray_val(v2);
	LOAD_FUNCTION(glGetQueryObjectivARB);
	(*stub_glGetQueryObjectivARB)(lv0, lv1, lv2);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glGetQueryObjectuiv,(GLuint, GLenum, GLuint*),void);
value glstub_glGetQueryObjectuiv(value v0, value v1, value v2)
{
	CAMLparam3(v0, v1, v2);
	GLuint lv0 = Int_val(v0);
	GLenum lv1 = Int_val(v1);
	GLuint* lv2 = Data_bigarray_val(v2);
	LOAD_FUNCTION(glGetQueryObjectuiv);
	(*stub_glGetQueryObjectuiv)(lv0, lv1, lv2);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glGetQueryObjectuivARB,(GLuint, GLenum, GLuint*),void);
value glstub_glGetQueryObjectuivARB(value v0, value v1, value v2)
{
	CAMLparam3(v0, v1, v2);
	GLuint lv0 = Int_val(v0);
	GLenum lv1 = Int_val(v1);
	GLuint* lv2 = Data_bigarray_val(v2);
	LOAD_FUNCTION(glGetQueryObjectuivARB);
	(*stub_glGetQueryObjectuivARB)(lv0, lv1, lv2);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glGetQueryiv,(GLenum, GLenum, GLint*),void);
value glstub_glGetQueryiv(value v0, value v1, value v2)
{
	CAMLparam3(v0, v1, v2);
	GLenum lv0 = Int_val(v0);
	GLenum lv1 = Int_val(v1);
	GLint* lv2 = Data_bigarray_val(v2);
	LOAD_FUNCTION(glGetQueryiv);
	(*stub_glGetQueryiv)(lv0, lv1, lv2);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glGetQueryivARB,(GLenum, GLenum, GLint*),void);
value glstub_glGetQueryivARB(value v0, value v1, value v2)
{
	CAMLparam3(v0, v1, v2);
	GLenum lv0 = Int_val(v0);
	GLenum lv1 = Int_val(v1);
	GLint* lv2 = Data_bigarray_val(v2);
	LOAD_FUNCTION(glGetQueryivARB);
	(*stub_glGetQueryivARB)(lv0, lv1, lv2);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glGetRenderbufferParameterivEXT,(GLenum, GLenum, GLint*),void);
value glstub_glGetRenderbufferParameterivEXT(value v0, value v1, value v2)
{
	CAMLparam3(v0, v1, v2);
	GLenum lv0 = Int_val(v0);
	GLenum lv1 = Int_val(v1);
	GLint* lv2 = Data_bigarray_val(v2);
	LOAD_FUNCTION(glGetRenderbufferParameterivEXT);
	(*stub_glGetRenderbufferParameterivEXT)(lv0, lv1, lv2);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glGetSeparableFilter,(GLenum, GLenum, GLenum, GLvoid*, GLvoid*, GLvoid*),void);
value glstub_glGetSeparableFilter(value v0, value v1, value v2, value v3, value v4, value v5)
{
	CAMLparam5(v0, v1, v2, v3, v4);
	CAMLxparam1(v5);
	GLenum lv0 = Int_val(v0);
	GLenum lv1 = Int_val(v1);
	GLenum lv2 = Int_val(v2);
	GLvoid* lv3 = (GLvoid *)((Tag_val(v3) == String_tag)? (String_val(v3)) : (Data_bigarray_val(v3)));
	GLvoid* lv4 = (GLvoid *)((Tag_val(v4) == String_tag)? (String_val(v4)) : (Data_bigarray_val(v4)));
	GLvoid* lv5 = (GLvoid *)((Tag_val(v5) == String_tag)? (String_val(v5)) : (Data_bigarray_val(v5)));
	LOAD_FUNCTION(glGetSeparableFilter);
	(*stub_glGetSeparableFilter)(lv0, lv1, lv2, lv3, lv4, lv5);
	CAMLreturn(Val_unit);
}

value glstub_glGetSeparableFilter_byte(value * argv, int n)
{
	return glstub_glGetSeparableFilter(argv[0], argv[1], argv[2], argv[3], argv[4], argv[5]);
}

DECLARE_FUNCTION(glGetSeparableFilterEXT,(GLenum, GLenum, GLenum, GLvoid*, GLvoid*, GLvoid*),void);
value glstub_glGetSeparableFilterEXT(value v0, value v1, value v2, value v3, value v4, value v5)
{
	CAMLparam5(v0, v1, v2, v3, v4);
	CAMLxparam1(v5);
	GLenum lv0 = Int_val(v0);
	GLenum lv1 = Int_val(v1);
	GLenum lv2 = Int_val(v2);
	GLvoid* lv3 = (GLvoid *)((Tag_val(v3) == String_tag)? (String_val(v3)) : (Data_bigarray_val(v3)));
	GLvoid* lv4 = (GLvoid *)((Tag_val(v4) == String_tag)? (String_val(v4)) : (Data_bigarray_val(v4)));
	GLvoid* lv5 = (GLvoid *)((Tag_val(v5) == String_tag)? (String_val(v5)) : (Data_bigarray_val(v5)));
	LOAD_FUNCTION(glGetSeparableFilterEXT);
	(*stub_glGetSeparableFilterEXT)(lv0, lv1, lv2, lv3, lv4, lv5);
	CAMLreturn(Val_unit);
}

value glstub_glGetSeparableFilterEXT_byte(value * argv, int n)
{
	return glstub_glGetSeparableFilterEXT(argv[0], argv[1], argv[2], argv[3], argv[4], argv[5]);
}

DECLARE_FUNCTION(glGetShaderInfoLog,(GLuint, GLsizei, GLsizei*, GLchar*),void);
value glstub_glGetShaderInfoLog(value v0, value v1, value v2, value v3)
{
	CAMLparam4(v0, v1, v2, v3);
	GLuint lv0 = Int_val(v0);
	GLsizei lv1 = Int_val(v1);
	GLsizei* lv2 = Data_bigarray_val(v2);
	GLchar* lv3 = String_val(v3);
	LOAD_FUNCTION(glGetShaderInfoLog);
	(*stub_glGetShaderInfoLog)(lv0, lv1, lv2, lv3);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glGetShaderSource,(GLint, GLsizei, GLsizei*, GLchar*),void);
value glstub_glGetShaderSource(value v0, value v1, value v2, value v3)
{
	CAMLparam4(v0, v1, v2, v3);
	GLint lv0 = Int_val(v0);
	GLsizei lv1 = Int_val(v1);
	GLsizei* lv2 = Data_bigarray_val(v2);
	GLchar* lv3 = String_val(v3);
	LOAD_FUNCTION(glGetShaderSource);
	(*stub_glGetShaderSource)(lv0, lv1, lv2, lv3);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glGetShaderSourceARB,(GLuint, GLsizei, GLsizei*, GLchar*),void);
value glstub_glGetShaderSourceARB(value v0, value v1, value v2, value v3)
{
	CAMLparam4(v0, v1, v2, v3);
	GLuint lv0 = Int_val(v0);
	GLsizei lv1 = Int_val(v1);
	GLsizei* lv2 = Data_bigarray_val(v2);
	GLchar* lv3 = String_val(v3);
	LOAD_FUNCTION(glGetShaderSourceARB);
	(*stub_glGetShaderSourceARB)(lv0, lv1, lv2, lv3);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glGetShaderiv,(GLuint, GLenum, GLint*),void);
value glstub_glGetShaderiv(value v0, value v1, value v2)
{
	CAMLparam3(v0, v1, v2);
	GLuint lv0 = Int_val(v0);
	GLenum lv1 = Int_val(v1);
	GLint* lv2 = Data_bigarray_val(v2);
	LOAD_FUNCTION(glGetShaderiv);
	(*stub_glGetShaderiv)(lv0, lv1, lv2);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glGetSharpenTexFuncSGIS,(GLenum, GLfloat*),void);
value glstub_glGetSharpenTexFuncSGIS(value v0, value v1)
{
	CAMLparam2(v0, v1);
	GLenum lv0 = Int_val(v0);
	GLfloat* lv1 = Data_bigarray_val(v1);
	LOAD_FUNCTION(glGetSharpenTexFuncSGIS);
	(*stub_glGetSharpenTexFuncSGIS)(lv0, lv1);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glGetString,(GLenum),GLstring);
value glstub_glGetString(value v0)
{
	CAMLparam1(v0);
	CAMLlocal1(result);
	GLenum lv0 = Int_val(v0);
	GLstring ret;
	LOAD_FUNCTION(glGetString);
	ret = (*stub_glGetString)(lv0);
	result = caml_copy_string(ret);
	CAMLreturn(result);
}

DECLARE_FUNCTION(glGetTexBumpParameterfvATI,(GLenum, GLfloat*),void);
value glstub_glGetTexBumpParameterfvATI(value v0, value v1)
{
	CAMLparam2(v0, v1);
	GLenum lv0 = Int_val(v0);
	GLfloat* lv1 = Data_bigarray_val(v1);
	LOAD_FUNCTION(glGetTexBumpParameterfvATI);
	(*stub_glGetTexBumpParameterfvATI)(lv0, lv1);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glGetTexBumpParameterivATI,(GLenum, GLint*),void);
value glstub_glGetTexBumpParameterivATI(value v0, value v1)
{
	CAMLparam2(v0, v1);
	GLenum lv0 = Int_val(v0);
	GLint* lv1 = Data_bigarray_val(v1);
	LOAD_FUNCTION(glGetTexBumpParameterivATI);
	(*stub_glGetTexBumpParameterivATI)(lv0, lv1);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glGetTexEnvfv,(GLenum, GLenum, GLfloat*),void);
value glstub_glGetTexEnvfv(value v0, value v1, value v2)
{
	CAMLparam3(v0, v1, v2);
	GLenum lv0 = Int_val(v0);
	GLenum lv1 = Int_val(v1);
	GLfloat* lv2 = Data_bigarray_val(v2);
	LOAD_FUNCTION(glGetTexEnvfv);
	(*stub_glGetTexEnvfv)(lv0, lv1, lv2);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glGetTexEnviv,(GLenum, GLenum, GLint*),void);
value glstub_glGetTexEnviv(value v0, value v1, value v2)
{
	CAMLparam3(v0, v1, v2);
	GLenum lv0 = Int_val(v0);
	GLenum lv1 = Int_val(v1);
	GLint* lv2 = Data_bigarray_val(v2);
	LOAD_FUNCTION(glGetTexEnviv);
	(*stub_glGetTexEnviv)(lv0, lv1, lv2);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glGetTexFilterFuncSGIS,(GLenum, GLenum, GLfloat*),void);
value glstub_glGetTexFilterFuncSGIS(value v0, value v1, value v2)
{
	CAMLparam3(v0, v1, v2);
	GLenum lv0 = Int_val(v0);
	GLenum lv1 = Int_val(v1);
	GLfloat* lv2 = Data_bigarray_val(v2);
	LOAD_FUNCTION(glGetTexFilterFuncSGIS);
	(*stub_glGetTexFilterFuncSGIS)(lv0, lv1, lv2);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glGetTexGendv,(GLenum, GLenum, GLdouble*),void);
value glstub_glGetTexGendv(value v0, value v1, value v2)
{
	CAMLparam3(v0, v1, v2);
	GLenum lv0 = Int_val(v0);
	GLenum lv1 = Int_val(v1);
	GLdouble* lv2 = (Tag_val(v2) == Double_array_tag)? (double *)v2: Data_bigarray_val(v2);
	LOAD_FUNCTION(glGetTexGendv);
	(*stub_glGetTexGendv)(lv0, lv1, lv2);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glGetTexGenfv,(GLenum, GLenum, GLfloat*),void);
value glstub_glGetTexGenfv(value v0, value v1, value v2)
{
	CAMLparam3(v0, v1, v2);
	GLenum lv0 = Int_val(v0);
	GLenum lv1 = Int_val(v1);
	GLfloat* lv2 = Data_bigarray_val(v2);
	LOAD_FUNCTION(glGetTexGenfv);
	(*stub_glGetTexGenfv)(lv0, lv1, lv2);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glGetTexGeniv,(GLenum, GLenum, GLint*),void);
value glstub_glGetTexGeniv(value v0, value v1, value v2)
{
	CAMLparam3(v0, v1, v2);
	GLenum lv0 = Int_val(v0);
	GLenum lv1 = Int_val(v1);
	GLint* lv2 = Data_bigarray_val(v2);
	LOAD_FUNCTION(glGetTexGeniv);
	(*stub_glGetTexGeniv)(lv0, lv1, lv2);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glGetTexImage,(GLenum, GLint, GLenum, GLenum, GLvoid*),void);
value glstub_glGetTexImage(value v0, value v1, value v2, value v3, value v4)
{
	CAMLparam5(v0, v1, v2, v3, v4);
	GLenum lv0 = Int_val(v0);
	GLint lv1 = Int_val(v1);
	GLenum lv2 = Int_val(v2);
	GLenum lv3 = Int_val(v3);
	GLvoid* lv4 = (GLvoid *)((Tag_val(v4) == String_tag)? (String_val(v4)) : (Data_bigarray_val(v4)));
	LOAD_FUNCTION(glGetTexImage);
	(*stub_glGetTexImage)(lv0, lv1, lv2, lv3, lv4);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glGetTexLevelParameterfv,(GLenum, GLint, GLenum, GLfloat*),void);
value glstub_glGetTexLevelParameterfv(value v0, value v1, value v2, value v3)
{
	CAMLparam4(v0, v1, v2, v3);
	GLenum lv0 = Int_val(v0);
	GLint lv1 = Int_val(v1);
	GLenum lv2 = Int_val(v2);
	GLfloat* lv3 = Data_bigarray_val(v3);
	LOAD_FUNCTION(glGetTexLevelParameterfv);
	(*stub_glGetTexLevelParameterfv)(lv0, lv1, lv2, lv3);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glGetTexLevelParameteriv,(GLenum, GLint, GLenum, GLint*),void);
value glstub_glGetTexLevelParameteriv(value v0, value v1, value v2, value v3)
{
	CAMLparam4(v0, v1, v2, v3);
	GLenum lv0 = Int_val(v0);
	GLint lv1 = Int_val(v1);
	GLenum lv2 = Int_val(v2);
	GLint* lv3 = Data_bigarray_val(v3);
	LOAD_FUNCTION(glGetTexLevelParameteriv);
	(*stub_glGetTexLevelParameteriv)(lv0, lv1, lv2, lv3);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glGetTexParameterIivEXT,(GLenum, GLenum, GLint*),void);
value glstub_glGetTexParameterIivEXT(value v0, value v1, value v2)
{
	CAMLparam3(v0, v1, v2);
	GLenum lv0 = Int_val(v0);
	GLenum lv1 = Int_val(v1);
	GLint* lv2 = Data_bigarray_val(v2);
	LOAD_FUNCTION(glGetTexParameterIivEXT);
	(*stub_glGetTexParameterIivEXT)(lv0, lv1, lv2);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glGetTexParameterIuivEXT,(GLenum, GLenum, GLuint*),void);
value glstub_glGetTexParameterIuivEXT(value v0, value v1, value v2)
{
	CAMLparam3(v0, v1, v2);
	GLenum lv0 = Int_val(v0);
	GLenum lv1 = Int_val(v1);
	GLuint* lv2 = Data_bigarray_val(v2);
	LOAD_FUNCTION(glGetTexParameterIuivEXT);
	(*stub_glGetTexParameterIuivEXT)(lv0, lv1, lv2);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glGetTexParameterPointervAPPLE,(GLenum, GLenum, GLvoid**),void);
value glstub_glGetTexParameterPointervAPPLE(value v0, value v1, value v2)
{
	CAMLparam3(v0, v1, v2);
	GLenum lv0 = Int_val(v0);
	GLenum lv1 = Int_val(v1);
	GLvoid** lv2 = Data_bigarray_val(v2);
	LOAD_FUNCTION(glGetTexParameterPointervAPPLE);
	(*stub_glGetTexParameterPointervAPPLE)(lv0, lv1, lv2);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glGetTexParameterfv,(GLenum, GLenum, GLfloat*),void);
value glstub_glGetTexParameterfv(value v0, value v1, value v2)
{
	CAMLparam3(v0, v1, v2);
	GLenum lv0 = Int_val(v0);
	GLenum lv1 = Int_val(v1);
	GLfloat* lv2 = Data_bigarray_val(v2);
	LOAD_FUNCTION(glGetTexParameterfv);
	(*stub_glGetTexParameterfv)(lv0, lv1, lv2);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glGetTexParameteriv,(GLenum, GLenum, GLint*),void);
value glstub_glGetTexParameteriv(value v0, value v1, value v2)
{
	CAMLparam3(v0, v1, v2);
	GLenum lv0 = Int_val(v0);
	GLenum lv1 = Int_val(v1);
	GLint* lv2 = Data_bigarray_val(v2);
	LOAD_FUNCTION(glGetTexParameteriv);
	(*stub_glGetTexParameteriv)(lv0, lv1, lv2);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glGetTrackMatrixivNV,(GLenum, GLuint, GLenum, GLint*),void);
value glstub_glGetTrackMatrixivNV(value v0, value v1, value v2, value v3)
{
	CAMLparam4(v0, v1, v2, v3);
	GLenum lv0 = Int_val(v0);
	GLuint lv1 = Int_val(v1);
	GLenum lv2 = Int_val(v2);
	GLint* lv3 = Data_bigarray_val(v3);
	LOAD_FUNCTION(glGetTrackMatrixivNV);
	(*stub_glGetTrackMatrixivNV)(lv0, lv1, lv2, lv3);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glGetTransformFeedbackVaryingNV,(GLuint, GLuint, GLint*),void);
value glstub_glGetTransformFeedbackVaryingNV(value v0, value v1, value v2)
{
	CAMLparam3(v0, v1, v2);
	GLuint lv0 = Int_val(v0);
	GLuint lv1 = Int_val(v1);
	GLint* lv2 = Data_bigarray_val(v2);
	LOAD_FUNCTION(glGetTransformFeedbackVaryingNV);
	(*stub_glGetTransformFeedbackVaryingNV)(lv0, lv1, lv2);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glGetUniformBufferSizeEXT,(GLuint, GLint),GLint);
value glstub_glGetUniformBufferSizeEXT(value v0, value v1)
{
	CAMLparam2(v0, v1);
	CAMLlocal1(result);
	GLuint lv0 = Int_val(v0);
	GLint lv1 = Int_val(v1);
	GLint ret;
	LOAD_FUNCTION(glGetUniformBufferSizeEXT);
	ret = (*stub_glGetUniformBufferSizeEXT)(lv0, lv1);
	result = Val_int(ret);
	CAMLreturn(result);
}

DECLARE_FUNCTION(glGetUniformLocation,(GLint, GLchar*),GLint);
value glstub_glGetUniformLocation(value v0, value v1)
{
	CAMLparam2(v0, v1);
	CAMLlocal1(result);
	GLint lv0 = Int_val(v0);
	GLchar* lv1 = String_val(v1);
	GLint ret;
	LOAD_FUNCTION(glGetUniformLocation);
	ret = (*stub_glGetUniformLocation)(lv0, lv1);
	result = Val_int(ret);
	CAMLreturn(result);
}

DECLARE_FUNCTION(glGetUniformLocationARB,(GLuint, GLchar*),GLint);
value glstub_glGetUniformLocationARB(value v0, value v1)
{
	CAMLparam2(v0, v1);
	CAMLlocal1(result);
	GLuint lv0 = Int_val(v0);
	GLchar* lv1 = String_val(v1);
	GLint ret;
	LOAD_FUNCTION(glGetUniformLocationARB);
	ret = (*stub_glGetUniformLocationARB)(lv0, lv1);
	result = Val_int(ret);
	CAMLreturn(result);
}

DECLARE_FUNCTION(glGetUniformOffsetEXT,(GLuint, GLint),GLintptr);
value glstub_glGetUniformOffsetEXT(value v0, value v1)
{
	CAMLparam2(v0, v1);
	CAMLlocal1(result);
	GLuint lv0 = Int_val(v0);
	GLint lv1 = Int_val(v1);
	GLintptr ret;
	LOAD_FUNCTION(glGetUniformOffsetEXT);
	ret = (*stub_glGetUniformOffsetEXT)(lv0, lv1);
	result = Val_int(ret);
	CAMLreturn(result);
}

DECLARE_FUNCTION(glGetUniformfv,(GLuint, GLint, GLfloat*),void);
value glstub_glGetUniformfv(value v0, value v1, value v2)
{
	CAMLparam3(v0, v1, v2);
	GLuint lv0 = Int_val(v0);
	GLint lv1 = Int_val(v1);
	GLfloat* lv2 = Data_bigarray_val(v2);
	LOAD_FUNCTION(glGetUniformfv);
	(*stub_glGetUniformfv)(lv0, lv1, lv2);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glGetUniformfvARB,(GLuint, GLint, GLfloat*),void);
value glstub_glGetUniformfvARB(value v0, value v1, value v2)
{
	CAMLparam3(v0, v1, v2);
	GLuint lv0 = Int_val(v0);
	GLint lv1 = Int_val(v1);
	GLfloat* lv2 = Data_bigarray_val(v2);
	LOAD_FUNCTION(glGetUniformfvARB);
	(*stub_glGetUniformfvARB)(lv0, lv1, lv2);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glGetUniformiv,(GLuint, GLint, GLint*),void);
value glstub_glGetUniformiv(value v0, value v1, value v2)
{
	CAMLparam3(v0, v1, v2);
	GLuint lv0 = Int_val(v0);
	GLint lv1 = Int_val(v1);
	GLint* lv2 = Data_bigarray_val(v2);
	LOAD_FUNCTION(glGetUniformiv);
	(*stub_glGetUniformiv)(lv0, lv1, lv2);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glGetUniformivARB,(GLuint, GLint, GLint*),void);
value glstub_glGetUniformivARB(value v0, value v1, value v2)
{
	CAMLparam3(v0, v1, v2);
	GLuint lv0 = Int_val(v0);
	GLint lv1 = Int_val(v1);
	GLint* lv2 = Data_bigarray_val(v2);
	LOAD_FUNCTION(glGetUniformivARB);
	(*stub_glGetUniformivARB)(lv0, lv1, lv2);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glGetUniformuivEXT,(GLuint, GLint, GLuint*),void);
value glstub_glGetUniformuivEXT(value v0, value v1, value v2)
{
	CAMLparam3(v0, v1, v2);
	GLuint lv0 = Int_val(v0);
	GLint lv1 = Int_val(v1);
	GLuint* lv2 = Data_bigarray_val(v2);
	LOAD_FUNCTION(glGetUniformuivEXT);
	(*stub_glGetUniformuivEXT)(lv0, lv1, lv2);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glGetVariantArrayObjectfvATI,(GLuint, GLenum, GLfloat*),void);
value glstub_glGetVariantArrayObjectfvATI(value v0, value v1, value v2)
{
	CAMLparam3(v0, v1, v2);
	GLuint lv0 = Int_val(v0);
	GLenum lv1 = Int_val(v1);
	GLfloat* lv2 = Data_bigarray_val(v2);
	LOAD_FUNCTION(glGetVariantArrayObjectfvATI);
	(*stub_glGetVariantArrayObjectfvATI)(lv0, lv1, lv2);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glGetVariantArrayObjectivATI,(GLuint, GLenum, GLint*),void);
value glstub_glGetVariantArrayObjectivATI(value v0, value v1, value v2)
{
	CAMLparam3(v0, v1, v2);
	GLuint lv0 = Int_val(v0);
	GLenum lv1 = Int_val(v1);
	GLint* lv2 = Data_bigarray_val(v2);
	LOAD_FUNCTION(glGetVariantArrayObjectivATI);
	(*stub_glGetVariantArrayObjectivATI)(lv0, lv1, lv2);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glGetVariantBooleanvEXT,(GLuint, GLenum, GLboolean*),void);
value glstub_glGetVariantBooleanvEXT(value v0, value v1, value v2)
{
	CAMLparam3(v0, v1, v2);
	GLuint lv0 = Int_val(v0);
	GLenum lv1 = Int_val(v1);
	GLboolean* lv2 = Data_bigarray_val(v2);
	LOAD_FUNCTION(glGetVariantBooleanvEXT);
	(*stub_glGetVariantBooleanvEXT)(lv0, lv1, lv2);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glGetVariantFloatvEXT,(GLuint, GLenum, GLfloat*),void);
value glstub_glGetVariantFloatvEXT(value v0, value v1, value v2)
{
	CAMLparam3(v0, v1, v2);
	GLuint lv0 = Int_val(v0);
	GLenum lv1 = Int_val(v1);
	GLfloat* lv2 = Data_bigarray_val(v2);
	LOAD_FUNCTION(glGetVariantFloatvEXT);
	(*stub_glGetVariantFloatvEXT)(lv0, lv1, lv2);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glGetVariantIntegervEXT,(GLuint, GLenum, GLint*),void);
value glstub_glGetVariantIntegervEXT(value v0, value v1, value v2)
{
	CAMLparam3(v0, v1, v2);
	GLuint lv0 = Int_val(v0);
	GLenum lv1 = Int_val(v1);
	GLint* lv2 = Data_bigarray_val(v2);
	LOAD_FUNCTION(glGetVariantIntegervEXT);
	(*stub_glGetVariantIntegervEXT)(lv0, lv1, lv2);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glGetVariantPointervEXT,(GLuint, GLenum, GLvoid**),void);
value glstub_glGetVariantPointervEXT(value v0, value v1, value v2)
{
	CAMLparam3(v0, v1, v2);
	GLuint lv0 = Int_val(v0);
	GLenum lv1 = Int_val(v1);
	GLvoid** lv2 = Data_bigarray_val(v2);
	LOAD_FUNCTION(glGetVariantPointervEXT);
	(*stub_glGetVariantPointervEXT)(lv0, lv1, lv2);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glGetVaryingLocationNV,(GLuint, GLchar*),GLint);
value glstub_glGetVaryingLocationNV(value v0, value v1)
{
	CAMLparam2(v0, v1);
	CAMLlocal1(result);
	GLuint lv0 = Int_val(v0);
	GLchar* lv1 = String_val(v1);
	GLint ret;
	LOAD_FUNCTION(glGetVaryingLocationNV);
	ret = (*stub_glGetVaryingLocationNV)(lv0, lv1);
	result = Val_int(ret);
	CAMLreturn(result);
}

DECLARE_FUNCTION(glGetVertexAttribArrayObjectfvATI,(GLuint, GLenum, GLfloat*),void);
value glstub_glGetVertexAttribArrayObjectfvATI(value v0, value v1, value v2)
{
	CAMLparam3(v0, v1, v2);
	GLuint lv0 = Int_val(v0);
	GLenum lv1 = Int_val(v1);
	GLfloat* lv2 = Data_bigarray_val(v2);
	LOAD_FUNCTION(glGetVertexAttribArrayObjectfvATI);
	(*stub_glGetVertexAttribArrayObjectfvATI)(lv0, lv1, lv2);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glGetVertexAttribArrayObjectivATI,(GLuint, GLenum, GLint*),void);
value glstub_glGetVertexAttribArrayObjectivATI(value v0, value v1, value v2)
{
	CAMLparam3(v0, v1, v2);
	GLuint lv0 = Int_val(v0);
	GLenum lv1 = Int_val(v1);
	GLint* lv2 = Data_bigarray_val(v2);
	LOAD_FUNCTION(glGetVertexAttribArrayObjectivATI);
	(*stub_glGetVertexAttribArrayObjectivATI)(lv0, lv1, lv2);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glGetVertexAttribIivEXT,(GLuint, GLenum, GLint*),void);
value glstub_glGetVertexAttribIivEXT(value v0, value v1, value v2)
{
	CAMLparam3(v0, v1, v2);
	GLuint lv0 = Int_val(v0);
	GLenum lv1 = Int_val(v1);
	GLint* lv2 = Data_bigarray_val(v2);
	LOAD_FUNCTION(glGetVertexAttribIivEXT);
	(*stub_glGetVertexAttribIivEXT)(lv0, lv1, lv2);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glGetVertexAttribIuivEXT,(GLuint, GLenum, GLuint*),void);
value glstub_glGetVertexAttribIuivEXT(value v0, value v1, value v2)
{
	CAMLparam3(v0, v1, v2);
	GLuint lv0 = Int_val(v0);
	GLenum lv1 = Int_val(v1);
	GLuint* lv2 = Data_bigarray_val(v2);
	LOAD_FUNCTION(glGetVertexAttribIuivEXT);
	(*stub_glGetVertexAttribIuivEXT)(lv0, lv1, lv2);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glGetVertexAttribPointerv,(GLuint, GLenum, GLvoid*),void);
value glstub_glGetVertexAttribPointerv(value v0, value v1, value v2)
{
	CAMLparam3(v0, v1, v2);
	GLuint lv0 = Int_val(v0);
	GLenum lv1 = Int_val(v1);
	GLvoid* lv2 = (GLvoid *)((Tag_val(v2) == String_tag)? (String_val(v2)) : (Data_bigarray_val(v2)));
	LOAD_FUNCTION(glGetVertexAttribPointerv);
	(*stub_glGetVertexAttribPointerv)(lv0, lv1, lv2);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glGetVertexAttribPointervARB,(GLuint, GLenum, GLvoid**),void);
value glstub_glGetVertexAttribPointervARB(value v0, value v1, value v2)
{
	CAMLparam3(v0, v1, v2);
	GLuint lv0 = Int_val(v0);
	GLenum lv1 = Int_val(v1);
	GLvoid** lv2 = Data_bigarray_val(v2);
	LOAD_FUNCTION(glGetVertexAttribPointervARB);
	(*stub_glGetVertexAttribPointervARB)(lv0, lv1, lv2);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glGetVertexAttribPointervNV,(GLuint, GLenum, GLvoid**),void);
value glstub_glGetVertexAttribPointervNV(value v0, value v1, value v2)
{
	CAMLparam3(v0, v1, v2);
	GLuint lv0 = Int_val(v0);
	GLenum lv1 = Int_val(v1);
	GLvoid** lv2 = Data_bigarray_val(v2);
	LOAD_FUNCTION(glGetVertexAttribPointervNV);
	(*stub_glGetVertexAttribPointervNV)(lv0, lv1, lv2);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glGetVertexAttribdv,(GLuint, GLenum, GLdouble*),void);
value glstub_glGetVertexAttribdv(value v0, value v1, value v2)
{
	CAMLparam3(v0, v1, v2);
	GLuint lv0 = Int_val(v0);
	GLenum lv1 = Int_val(v1);
	GLdouble* lv2 = (Tag_val(v2) == Double_array_tag)? (double *)v2: Data_bigarray_val(v2);
	LOAD_FUNCTION(glGetVertexAttribdv);
	(*stub_glGetVertexAttribdv)(lv0, lv1, lv2);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glGetVertexAttribdvARB,(GLuint, GLenum, GLdouble*),void);
value glstub_glGetVertexAttribdvARB(value v0, value v1, value v2)
{
	CAMLparam3(v0, v1, v2);
	GLuint lv0 = Int_val(v0);
	GLenum lv1 = Int_val(v1);
	GLdouble* lv2 = (Tag_val(v2) == Double_array_tag)? (double *)v2: Data_bigarray_val(v2);
	LOAD_FUNCTION(glGetVertexAttribdvARB);
	(*stub_glGetVertexAttribdvARB)(lv0, lv1, lv2);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glGetVertexAttribdvNV,(GLuint, GLenum, GLdouble*),void);
value glstub_glGetVertexAttribdvNV(value v0, value v1, value v2)
{
	CAMLparam3(v0, v1, v2);
	GLuint lv0 = Int_val(v0);
	GLenum lv1 = Int_val(v1);
	GLdouble* lv2 = (Tag_val(v2) == Double_array_tag)? (double *)v2: Data_bigarray_val(v2);
	LOAD_FUNCTION(glGetVertexAttribdvNV);
	(*stub_glGetVertexAttribdvNV)(lv0, lv1, lv2);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glGetVertexAttribfv,(GLuint, GLenum, GLfloat*),void);
value glstub_glGetVertexAttribfv(value v0, value v1, value v2)
{
	CAMLparam3(v0, v1, v2);
	GLuint lv0 = Int_val(v0);
	GLenum lv1 = Int_val(v1);
	GLfloat* lv2 = Data_bigarray_val(v2);
	LOAD_FUNCTION(glGetVertexAttribfv);
	(*stub_glGetVertexAttribfv)(lv0, lv1, lv2);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glGetVertexAttribfvARB,(GLuint, GLenum, GLfloat*),void);
value glstub_glGetVertexAttribfvARB(value v0, value v1, value v2)
{
	CAMLparam3(v0, v1, v2);
	GLuint lv0 = Int_val(v0);
	GLenum lv1 = Int_val(v1);
	GLfloat* lv2 = Data_bigarray_val(v2);
	LOAD_FUNCTION(glGetVertexAttribfvARB);
	(*stub_glGetVertexAttribfvARB)(lv0, lv1, lv2);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glGetVertexAttribfvNV,(GLuint, GLenum, GLfloat*),void);
value glstub_glGetVertexAttribfvNV(value v0, value v1, value v2)
{
	CAMLparam3(v0, v1, v2);
	GLuint lv0 = Int_val(v0);
	GLenum lv1 = Int_val(v1);
	GLfloat* lv2 = Data_bigarray_val(v2);
	LOAD_FUNCTION(glGetVertexAttribfvNV);
	(*stub_glGetVertexAttribfvNV)(lv0, lv1, lv2);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glGetVertexAttribiv,(GLuint, GLenum, GLint*),void);
value glstub_glGetVertexAttribiv(value v0, value v1, value v2)
{
	CAMLparam3(v0, v1, v2);
	GLuint lv0 = Int_val(v0);
	GLenum lv1 = Int_val(v1);
	GLint* lv2 = Data_bigarray_val(v2);
	LOAD_FUNCTION(glGetVertexAttribiv);
	(*stub_glGetVertexAttribiv)(lv0, lv1, lv2);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glGetVertexAttribivARB,(GLuint, GLenum, GLint*),void);
value glstub_glGetVertexAttribivARB(value v0, value v1, value v2)
{
	CAMLparam3(v0, v1, v2);
	GLuint lv0 = Int_val(v0);
	GLenum lv1 = Int_val(v1);
	GLint* lv2 = Data_bigarray_val(v2);
	LOAD_FUNCTION(glGetVertexAttribivARB);
	(*stub_glGetVertexAttribivARB)(lv0, lv1, lv2);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glGetVertexAttribivNV,(GLuint, GLenum, GLint*),void);
value glstub_glGetVertexAttribivNV(value v0, value v1, value v2)
{
	CAMLparam3(v0, v1, v2);
	GLuint lv0 = Int_val(v0);
	GLenum lv1 = Int_val(v1);
	GLint* lv2 = Data_bigarray_val(v2);
	LOAD_FUNCTION(glGetVertexAttribivNV);
	(*stub_glGetVertexAttribivNV)(lv0, lv1, lv2);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glGlobalAlphaFactorbSUN,(GLbyte),void);
value glstub_glGlobalAlphaFactorbSUN(value v0)
{
	CAMLparam1(v0);
	GLbyte lv0 = Int_val(v0);
	LOAD_FUNCTION(glGlobalAlphaFactorbSUN);
	(*stub_glGlobalAlphaFactorbSUN)(lv0);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glGlobalAlphaFactordSUN,(GLdouble),void);
value glstub_glGlobalAlphaFactordSUN(value v0)
{
	CAMLparam1(v0);
	GLdouble lv0 = Double_val(v0);
	LOAD_FUNCTION(glGlobalAlphaFactordSUN);
	(*stub_glGlobalAlphaFactordSUN)(lv0);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glGlobalAlphaFactorfSUN,(GLfloat),void);
value glstub_glGlobalAlphaFactorfSUN(value v0)
{
	CAMLparam1(v0);
	GLfloat lv0 = Double_val(v0);
	LOAD_FUNCTION(glGlobalAlphaFactorfSUN);
	(*stub_glGlobalAlphaFactorfSUN)(lv0);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glGlobalAlphaFactoriSUN,(GLint),void);
value glstub_glGlobalAlphaFactoriSUN(value v0)
{
	CAMLparam1(v0);
	GLint lv0 = Int_val(v0);
	LOAD_FUNCTION(glGlobalAlphaFactoriSUN);
	(*stub_glGlobalAlphaFactoriSUN)(lv0);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glGlobalAlphaFactorsSUN,(GLshort),void);
value glstub_glGlobalAlphaFactorsSUN(value v0)
{
	CAMLparam1(v0);
	GLshort lv0 = Int_val(v0);
	LOAD_FUNCTION(glGlobalAlphaFactorsSUN);
	(*stub_glGlobalAlphaFactorsSUN)(lv0);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glGlobalAlphaFactorubSUN,(GLubyte),void);
value glstub_glGlobalAlphaFactorubSUN(value v0)
{
	CAMLparam1(v0);
	GLubyte lv0 = Int_val(v0);
	LOAD_FUNCTION(glGlobalAlphaFactorubSUN);
	(*stub_glGlobalAlphaFactorubSUN)(lv0);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glGlobalAlphaFactoruiSUN,(GLuint),void);
value glstub_glGlobalAlphaFactoruiSUN(value v0)
{
	CAMLparam1(v0);
	GLuint lv0 = Int_val(v0);
	LOAD_FUNCTION(glGlobalAlphaFactoruiSUN);
	(*stub_glGlobalAlphaFactoruiSUN)(lv0);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glGlobalAlphaFactorusSUN,(GLushort),void);
value glstub_glGlobalAlphaFactorusSUN(value v0)
{
	CAMLparam1(v0);
	GLushort lv0 = Int_val(v0);
	LOAD_FUNCTION(glGlobalAlphaFactorusSUN);
	(*stub_glGlobalAlphaFactorusSUN)(lv0);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glHint,(GLenum, GLenum),void);
value glstub_glHint(value v0, value v1)
{
	CAMLparam2(v0, v1);
	GLenum lv0 = Int_val(v0);
	GLenum lv1 = Int_val(v1);
	LOAD_FUNCTION(glHint);
	(*stub_glHint)(lv0, lv1);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glHistogram,(GLenum, GLsizei, GLenum, GLboolean),void);
value glstub_glHistogram(value v0, value v1, value v2, value v3)
{
	CAMLparam4(v0, v1, v2, v3);
	GLenum lv0 = Int_val(v0);
	GLsizei lv1 = Int_val(v1);
	GLenum lv2 = Int_val(v2);
	GLboolean lv3 = Bool_val(v3);
	LOAD_FUNCTION(glHistogram);
	(*stub_glHistogram)(lv0, lv1, lv2, lv3);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glHistogramEXT,(GLenum, GLsizei, GLenum, GLboolean),void);
value glstub_glHistogramEXT(value v0, value v1, value v2, value v3)
{
	CAMLparam4(v0, v1, v2, v3);
	GLenum lv0 = Int_val(v0);
	GLsizei lv1 = Int_val(v1);
	GLenum lv2 = Int_val(v2);
	GLboolean lv3 = Bool_val(v3);
	LOAD_FUNCTION(glHistogramEXT);
	(*stub_glHistogramEXT)(lv0, lv1, lv2, lv3);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glImageTransformParameterfHP,(GLenum, GLenum, GLfloat),void);
value glstub_glImageTransformParameterfHP(value v0, value v1, value v2)
{
	CAMLparam3(v0, v1, v2);
	GLenum lv0 = Int_val(v0);
	GLenum lv1 = Int_val(v1);
	GLfloat lv2 = Double_val(v2);
	LOAD_FUNCTION(glImageTransformParameterfHP);
	(*stub_glImageTransformParameterfHP)(lv0, lv1, lv2);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glImageTransformParameterfvHP,(GLenum, GLenum, GLfloat*),void);
value glstub_glImageTransformParameterfvHP(value v0, value v1, value v2)
{
	CAMLparam3(v0, v1, v2);
	GLenum lv0 = Int_val(v0);
	GLenum lv1 = Int_val(v1);
	GLfloat* lv2 = Data_bigarray_val(v2);
	LOAD_FUNCTION(glImageTransformParameterfvHP);
	(*stub_glImageTransformParameterfvHP)(lv0, lv1, lv2);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glImageTransformParameteriHP,(GLenum, GLenum, GLint),void);
value glstub_glImageTransformParameteriHP(value v0, value v1, value v2)
{
	CAMLparam3(v0, v1, v2);
	GLenum lv0 = Int_val(v0);
	GLenum lv1 = Int_val(v1);
	GLint lv2 = Int_val(v2);
	LOAD_FUNCTION(glImageTransformParameteriHP);
	(*stub_glImageTransformParameteriHP)(lv0, lv1, lv2);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glImageTransformParameterivHP,(GLenum, GLenum, GLint*),void);
value glstub_glImageTransformParameterivHP(value v0, value v1, value v2)
{
	CAMLparam3(v0, v1, v2);
	GLenum lv0 = Int_val(v0);
	GLenum lv1 = Int_val(v1);
	GLint* lv2 = Data_bigarray_val(v2);
	LOAD_FUNCTION(glImageTransformParameterivHP);
	(*stub_glImageTransformParameterivHP)(lv0, lv1, lv2);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glIndexFuncEXT,(GLenum, GLfloat),void);
value glstub_glIndexFuncEXT(value v0, value v1)
{
	CAMLparam2(v0, v1);
	GLenum lv0 = Int_val(v0);
	GLfloat lv1 = Double_val(v1);
	LOAD_FUNCTION(glIndexFuncEXT);
	(*stub_glIndexFuncEXT)(lv0, lv1);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glIndexMask,(GLuint),void);
value glstub_glIndexMask(value v0)
{
	CAMLparam1(v0);
	GLuint lv0 = Int_val(v0);
	LOAD_FUNCTION(glIndexMask);
	(*stub_glIndexMask)(lv0);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glIndexMaterialEXT,(GLenum, GLenum),void);
value glstub_glIndexMaterialEXT(value v0, value v1)
{
	CAMLparam2(v0, v1);
	GLenum lv0 = Int_val(v0);
	GLenum lv1 = Int_val(v1);
	LOAD_FUNCTION(glIndexMaterialEXT);
	(*stub_glIndexMaterialEXT)(lv0, lv1);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glIndexPointer,(GLenum, GLsizei, GLvoid*),void);
value glstub_glIndexPointer(value v0, value v1, value v2)
{
	CAMLparam3(v0, v1, v2);
	GLenum lv0 = Int_val(v0);
	GLsizei lv1 = Int_val(v1);
	GLvoid* lv2 = (GLvoid *)((Tag_val(v2) == String_tag)? (String_val(v2)) : (Data_bigarray_val(v2)));
	LOAD_FUNCTION(glIndexPointer);
	(*stub_glIndexPointer)(lv0, lv1, lv2);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glIndexPointerEXT,(GLenum, GLsizei, GLsizei, GLvoid*),void);
value glstub_glIndexPointerEXT(value v0, value v1, value v2, value v3)
{
	CAMLparam4(v0, v1, v2, v3);
	GLenum lv0 = Int_val(v0);
	GLsizei lv1 = Int_val(v1);
	GLsizei lv2 = Int_val(v2);
	GLvoid* lv3 = (GLvoid *)((Tag_val(v3) == String_tag)? (String_val(v3)) : (Data_bigarray_val(v3)));
	LOAD_FUNCTION(glIndexPointerEXT);
	(*stub_glIndexPointerEXT)(lv0, lv1, lv2, lv3);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glIndexPointerListIBM,(GLenum, GLint, GLvoid**, GLint),void);
value glstub_glIndexPointerListIBM(value v0, value v1, value v2, value v3)
{
	CAMLparam4(v0, v1, v2, v3);
	GLenum lv0 = Int_val(v0);
	GLint lv1 = Int_val(v1);
	GLvoid** lv2 = Data_bigarray_val(v2);
	GLint lv3 = Int_val(v3);
	LOAD_FUNCTION(glIndexPointerListIBM);
	(*stub_glIndexPointerListIBM)(lv0, lv1, lv2, lv3);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glIndexd,(GLdouble),void);
value glstub_glIndexd(value v0)
{
	CAMLparam1(v0);
	GLdouble lv0 = Double_val(v0);
	LOAD_FUNCTION(glIndexd);
	(*stub_glIndexd)(lv0);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glIndexdv,(GLdouble*),void);
value glstub_glIndexdv(value v0)
{
	CAMLparam1(v0);
	GLdouble* lv0 = (Tag_val(v0) == Double_array_tag)? (double *)v0: Data_bigarray_val(v0);
	LOAD_FUNCTION(glIndexdv);
	(*stub_glIndexdv)(lv0);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glIndexf,(GLfloat),void);
value glstub_glIndexf(value v0)
{
	CAMLparam1(v0);
	GLfloat lv0 = Double_val(v0);
	LOAD_FUNCTION(glIndexf);
	(*stub_glIndexf)(lv0);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glIndexfv,(GLfloat*),void);
value glstub_glIndexfv(value v0)
{
	CAMLparam1(v0);
	GLfloat* lv0 = Data_bigarray_val(v0);
	LOAD_FUNCTION(glIndexfv);
	(*stub_glIndexfv)(lv0);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glIndexi,(GLint),void);
value glstub_glIndexi(value v0)
{
	CAMLparam1(v0);
	GLint lv0 = Int_val(v0);
	LOAD_FUNCTION(glIndexi);
	(*stub_glIndexi)(lv0);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glIndexiv,(GLint*),void);
value glstub_glIndexiv(value v0)
{
	CAMLparam1(v0);
	GLint* lv0 = Data_bigarray_val(v0);
	LOAD_FUNCTION(glIndexiv);
	(*stub_glIndexiv)(lv0);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glIndexs,(GLshort),void);
value glstub_glIndexs(value v0)
{
	CAMLparam1(v0);
	GLshort lv0 = Int_val(v0);
	LOAD_FUNCTION(glIndexs);
	(*stub_glIndexs)(lv0);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glIndexsv,(GLshort*),void);
value glstub_glIndexsv(value v0)
{
	CAMLparam1(v0);
	GLshort* lv0 = Data_bigarray_val(v0);
	LOAD_FUNCTION(glIndexsv);
	(*stub_glIndexsv)(lv0);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glIndexub,(GLubyte),void);
value glstub_glIndexub(value v0)
{
	CAMLparam1(v0);
	GLubyte lv0 = Int_val(v0);
	LOAD_FUNCTION(glIndexub);
	(*stub_glIndexub)(lv0);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glIndexubv,(GLubyte*),void);
value glstub_glIndexubv(value v0)
{
	CAMLparam1(v0);
	GLubyte* lv0 = Data_bigarray_val(v0);
	LOAD_FUNCTION(glIndexubv);
	(*stub_glIndexubv)(lv0);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glInitNames,(void),void);
value glstub_glInitNames(value v0)
{
	CAMLparam1(v0);
	LOAD_FUNCTION(glInitNames);
	(*stub_glInitNames)();
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glInsertComponentEXT,(GLuint, GLuint, GLuint),void);
value glstub_glInsertComponentEXT(value v0, value v1, value v2)
{
	CAMLparam3(v0, v1, v2);
	GLuint lv0 = Int_val(v0);
	GLuint lv1 = Int_val(v1);
	GLuint lv2 = Int_val(v2);
	LOAD_FUNCTION(glInsertComponentEXT);
	(*stub_glInsertComponentEXT)(lv0, lv1, lv2);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glInterleavedArrays,(GLenum, GLsizei, GLvoid*),void);
value glstub_glInterleavedArrays(value v0, value v1, value v2)
{
	CAMLparam3(v0, v1, v2);
	GLenum lv0 = Int_val(v0);
	GLsizei lv1 = Int_val(v1);
	GLvoid* lv2 = (GLvoid *)((Tag_val(v2) == String_tag)? (String_val(v2)) : (Data_bigarray_val(v2)));
	LOAD_FUNCTION(glInterleavedArrays);
	(*stub_glInterleavedArrays)(lv0, lv1, lv2);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glIsAsyncMarkerSGIX,(GLuint),GLboolean);
value glstub_glIsAsyncMarkerSGIX(value v0)
{
	CAMLparam1(v0);
	CAMLlocal1(result);
	GLuint lv0 = Int_val(v0);
	GLboolean ret;
	LOAD_FUNCTION(glIsAsyncMarkerSGIX);
	ret = (*stub_glIsAsyncMarkerSGIX)(lv0);
	result = Val_bool(ret);
	CAMLreturn(result);
}

DECLARE_FUNCTION(glIsBuffer,(GLuint),GLboolean);
value glstub_glIsBuffer(value v0)
{
	CAMLparam1(v0);
	CAMLlocal1(result);
	GLuint lv0 = Int_val(v0);
	GLboolean ret;
	LOAD_FUNCTION(glIsBuffer);
	ret = (*stub_glIsBuffer)(lv0);
	result = Val_bool(ret);
	CAMLreturn(result);
}

DECLARE_FUNCTION(glIsBufferARB,(GLuint),GLboolean);
value glstub_glIsBufferARB(value v0)
{
	CAMLparam1(v0);
	CAMLlocal1(result);
	GLuint lv0 = Int_val(v0);
	GLboolean ret;
	LOAD_FUNCTION(glIsBufferARB);
	ret = (*stub_glIsBufferARB)(lv0);
	result = Val_bool(ret);
	CAMLreturn(result);
}

DECLARE_FUNCTION(glIsEnabled,(GLenum),GLboolean);
value glstub_glIsEnabled(value v0)
{
	CAMLparam1(v0);
	CAMLlocal1(result);
	GLenum lv0 = Int_val(v0);
	GLboolean ret;
	LOAD_FUNCTION(glIsEnabled);
	ret = (*stub_glIsEnabled)(lv0);
	result = Val_bool(ret);
	CAMLreturn(result);
}

DECLARE_FUNCTION(glIsEnabledIndexedEXT,(GLenum, GLuint),GLboolean);
value glstub_glIsEnabledIndexedEXT(value v0, value v1)
{
	CAMLparam2(v0, v1);
	CAMLlocal1(result);
	GLenum lv0 = Int_val(v0);
	GLuint lv1 = Int_val(v1);
	GLboolean ret;
	LOAD_FUNCTION(glIsEnabledIndexedEXT);
	ret = (*stub_glIsEnabledIndexedEXT)(lv0, lv1);
	result = Val_bool(ret);
	CAMLreturn(result);
}

DECLARE_FUNCTION(glIsFenceAPPLE,(GLuint),GLboolean);
value glstub_glIsFenceAPPLE(value v0)
{
	CAMLparam1(v0);
	CAMLlocal1(result);
	GLuint lv0 = Int_val(v0);
	GLboolean ret;
	LOAD_FUNCTION(glIsFenceAPPLE);
	ret = (*stub_glIsFenceAPPLE)(lv0);
	result = Val_bool(ret);
	CAMLreturn(result);
}

DECLARE_FUNCTION(glIsFenceNV,(GLuint),GLboolean);
value glstub_glIsFenceNV(value v0)
{
	CAMLparam1(v0);
	CAMLlocal1(result);
	GLuint lv0 = Int_val(v0);
	GLboolean ret;
	LOAD_FUNCTION(glIsFenceNV);
	ret = (*stub_glIsFenceNV)(lv0);
	result = Val_bool(ret);
	CAMLreturn(result);
}

DECLARE_FUNCTION(glIsFramebufferEXT,(GLuint),GLboolean);
value glstub_glIsFramebufferEXT(value v0)
{
	CAMLparam1(v0);
	CAMLlocal1(result);
	GLuint lv0 = Int_val(v0);
	GLboolean ret;
	LOAD_FUNCTION(glIsFramebufferEXT);
	ret = (*stub_glIsFramebufferEXT)(lv0);
	result = Val_bool(ret);
	CAMLreturn(result);
}

DECLARE_FUNCTION(glIsList,(GLuint),GLboolean);
value glstub_glIsList(value v0)
{
	CAMLparam1(v0);
	CAMLlocal1(result);
	GLuint lv0 = Int_val(v0);
	GLboolean ret;
	LOAD_FUNCTION(glIsList);
	ret = (*stub_glIsList)(lv0);
	result = Val_bool(ret);
	CAMLreturn(result);
}

DECLARE_FUNCTION(glIsObjectBufferATI,(GLuint),GLboolean);
value glstub_glIsObjectBufferATI(value v0)
{
	CAMLparam1(v0);
	CAMLlocal1(result);
	GLuint lv0 = Int_val(v0);
	GLboolean ret;
	LOAD_FUNCTION(glIsObjectBufferATI);
	ret = (*stub_glIsObjectBufferATI)(lv0);
	result = Val_bool(ret);
	CAMLreturn(result);
}

DECLARE_FUNCTION(glIsOcclusionQueryNV,(GLuint),GLboolean);
value glstub_glIsOcclusionQueryNV(value v0)
{
	CAMLparam1(v0);
	CAMLlocal1(result);
	GLuint lv0 = Int_val(v0);
	GLboolean ret;
	LOAD_FUNCTION(glIsOcclusionQueryNV);
	ret = (*stub_glIsOcclusionQueryNV)(lv0);
	result = Val_bool(ret);
	CAMLreturn(result);
}

DECLARE_FUNCTION(glIsProgram,(GLuint),GLboolean);
value glstub_glIsProgram(value v0)
{
	CAMLparam1(v0);
	CAMLlocal1(result);
	GLuint lv0 = Int_val(v0);
	GLboolean ret;
	LOAD_FUNCTION(glIsProgram);
	ret = (*stub_glIsProgram)(lv0);
	result = Val_bool(ret);
	CAMLreturn(result);
}

DECLARE_FUNCTION(glIsProgramARB,(GLuint),GLboolean);
value glstub_glIsProgramARB(value v0)
{
	CAMLparam1(v0);
	CAMLlocal1(result);
	GLuint lv0 = Int_val(v0);
	GLboolean ret;
	LOAD_FUNCTION(glIsProgramARB);
	ret = (*stub_glIsProgramARB)(lv0);
	result = Val_bool(ret);
	CAMLreturn(result);
}

DECLARE_FUNCTION(glIsProgramNV,(GLuint),GLboolean);
value glstub_glIsProgramNV(value v0)
{
	CAMLparam1(v0);
	CAMLlocal1(result);
	GLuint lv0 = Int_val(v0);
	GLboolean ret;
	LOAD_FUNCTION(glIsProgramNV);
	ret = (*stub_glIsProgramNV)(lv0);
	result = Val_bool(ret);
	CAMLreturn(result);
}

DECLARE_FUNCTION(glIsQuery,(GLuint),GLboolean);
value glstub_glIsQuery(value v0)
{
	CAMLparam1(v0);
	CAMLlocal1(result);
	GLuint lv0 = Int_val(v0);
	GLboolean ret;
	LOAD_FUNCTION(glIsQuery);
	ret = (*stub_glIsQuery)(lv0);
	result = Val_bool(ret);
	CAMLreturn(result);
}

DECLARE_FUNCTION(glIsQueryARB,(GLuint),GLboolean);
value glstub_glIsQueryARB(value v0)
{
	CAMLparam1(v0);
	CAMLlocal1(result);
	GLuint lv0 = Int_val(v0);
	GLboolean ret;
	LOAD_FUNCTION(glIsQueryARB);
	ret = (*stub_glIsQueryARB)(lv0);
	result = Val_bool(ret);
	CAMLreturn(result);
}

DECLARE_FUNCTION(glIsRenderbufferEXT,(GLuint),GLboolean);
value glstub_glIsRenderbufferEXT(value v0)
{
	CAMLparam1(v0);
	CAMLlocal1(result);
	GLuint lv0 = Int_val(v0);
	GLboolean ret;
	LOAD_FUNCTION(glIsRenderbufferEXT);
	ret = (*stub_glIsRenderbufferEXT)(lv0);
	result = Val_bool(ret);
	CAMLreturn(result);
}

DECLARE_FUNCTION(glIsShader,(GLuint),GLboolean);
value glstub_glIsShader(value v0)
{
	CAMLparam1(v0);
	CAMLlocal1(result);
	GLuint lv0 = Int_val(v0);
	GLboolean ret;
	LOAD_FUNCTION(glIsShader);
	ret = (*stub_glIsShader)(lv0);
	result = Val_bool(ret);
	CAMLreturn(result);
}

DECLARE_FUNCTION(glIsTexture,(GLuint),GLboolean);
value glstub_glIsTexture(value v0)
{
	CAMLparam1(v0);
	CAMLlocal1(result);
	GLuint lv0 = Int_val(v0);
	GLboolean ret;
	LOAD_FUNCTION(glIsTexture);
	ret = (*stub_glIsTexture)(lv0);
	result = Val_bool(ret);
	CAMLreturn(result);
}

DECLARE_FUNCTION(glIsTextureEXT,(GLuint),GLboolean);
value glstub_glIsTextureEXT(value v0)
{
	CAMLparam1(v0);
	CAMLlocal1(result);
	GLuint lv0 = Int_val(v0);
	GLboolean ret;
	LOAD_FUNCTION(glIsTextureEXT);
	ret = (*stub_glIsTextureEXT)(lv0);
	result = Val_bool(ret);
	CAMLreturn(result);
}

DECLARE_FUNCTION(glIsVariantEnabledEXT,(GLuint, GLenum),GLboolean);
value glstub_glIsVariantEnabledEXT(value v0, value v1)
{
	CAMLparam2(v0, v1);
	CAMLlocal1(result);
	GLuint lv0 = Int_val(v0);
	GLenum lv1 = Int_val(v1);
	GLboolean ret;
	LOAD_FUNCTION(glIsVariantEnabledEXT);
	ret = (*stub_glIsVariantEnabledEXT)(lv0, lv1);
	result = Val_bool(ret);
	CAMLreturn(result);
}

DECLARE_FUNCTION(glIsVertexArrayAPPLE,(GLuint),GLboolean);
value glstub_glIsVertexArrayAPPLE(value v0)
{
	CAMLparam1(v0);
	CAMLlocal1(result);
	GLuint lv0 = Int_val(v0);
	GLboolean ret;
	LOAD_FUNCTION(glIsVertexArrayAPPLE);
	ret = (*stub_glIsVertexArrayAPPLE)(lv0);
	result = Val_bool(ret);
	CAMLreturn(result);
}

DECLARE_FUNCTION(glLightEnviEXT,(GLenum, GLint),void);
value glstub_glLightEnviEXT(value v0, value v1)
{
	CAMLparam2(v0, v1);
	GLenum lv0 = Int_val(v0);
	GLint lv1 = Int_val(v1);
	LOAD_FUNCTION(glLightEnviEXT);
	(*stub_glLightEnviEXT)(lv0, lv1);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glLightModelf,(GLenum, GLfloat),void);
value glstub_glLightModelf(value v0, value v1)
{
	CAMLparam2(v0, v1);
	GLenum lv0 = Int_val(v0);
	GLfloat lv1 = Double_val(v1);
	LOAD_FUNCTION(glLightModelf);
	(*stub_glLightModelf)(lv0, lv1);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glLightModelfv,(GLenum, GLfloat*),void);
value glstub_glLightModelfv(value v0, value v1)
{
	CAMLparam2(v0, v1);
	GLenum lv0 = Int_val(v0);
	GLfloat* lv1 = Data_bigarray_val(v1);
	LOAD_FUNCTION(glLightModelfv);
	(*stub_glLightModelfv)(lv0, lv1);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glLightModeli,(GLenum, GLint),void);
value glstub_glLightModeli(value v0, value v1)
{
	CAMLparam2(v0, v1);
	GLenum lv0 = Int_val(v0);
	GLint lv1 = Int_val(v1);
	LOAD_FUNCTION(glLightModeli);
	(*stub_glLightModeli)(lv0, lv1);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glLightModeliv,(GLenum, GLint*),void);
value glstub_glLightModeliv(value v0, value v1)
{
	CAMLparam2(v0, v1);
	GLenum lv0 = Int_val(v0);
	GLint* lv1 = Data_bigarray_val(v1);
	LOAD_FUNCTION(glLightModeliv);
	(*stub_glLightModeliv)(lv0, lv1);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glLightf,(GLenum, GLenum, GLfloat),void);
value glstub_glLightf(value v0, value v1, value v2)
{
	CAMLparam3(v0, v1, v2);
	GLenum lv0 = Int_val(v0);
	GLenum lv1 = Int_val(v1);
	GLfloat lv2 = Double_val(v2);
	LOAD_FUNCTION(glLightf);
	(*stub_glLightf)(lv0, lv1, lv2);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glLightfv,(GLenum, GLenum, GLfloat*),void);
value glstub_glLightfv(value v0, value v1, value v2)
{
	CAMLparam3(v0, v1, v2);
	GLenum lv0 = Int_val(v0);
	GLenum lv1 = Int_val(v1);
	GLfloat* lv2 = Data_bigarray_val(v2);
	LOAD_FUNCTION(glLightfv);
	(*stub_glLightfv)(lv0, lv1, lv2);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glLighti,(GLenum, GLenum, GLint),void);
value glstub_glLighti(value v0, value v1, value v2)
{
	CAMLparam3(v0, v1, v2);
	GLenum lv0 = Int_val(v0);
	GLenum lv1 = Int_val(v1);
	GLint lv2 = Int_val(v2);
	LOAD_FUNCTION(glLighti);
	(*stub_glLighti)(lv0, lv1, lv2);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glLightiv,(GLenum, GLenum, GLint*),void);
value glstub_glLightiv(value v0, value v1, value v2)
{
	CAMLparam3(v0, v1, v2);
	GLenum lv0 = Int_val(v0);
	GLenum lv1 = Int_val(v1);
	GLint* lv2 = Data_bigarray_val(v2);
	LOAD_FUNCTION(glLightiv);
	(*stub_glLightiv)(lv0, lv1, lv2);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glLineStipple,(GLint, GLushort),void);
value glstub_glLineStipple(value v0, value v1)
{
	CAMLparam2(v0, v1);
	GLint lv0 = Int_val(v0);
	GLushort lv1 = Int_val(v1);
	LOAD_FUNCTION(glLineStipple);
	(*stub_glLineStipple)(lv0, lv1);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glLineWidth,(GLfloat),void);
value glstub_glLineWidth(value v0)
{
	CAMLparam1(v0);
	GLfloat lv0 = Double_val(v0);
	LOAD_FUNCTION(glLineWidth);
	(*stub_glLineWidth)(lv0);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glLinkProgram,(GLuint),void);
value glstub_glLinkProgram(value v0)
{
	CAMLparam1(v0);
	GLuint lv0 = Int_val(v0);
	LOAD_FUNCTION(glLinkProgram);
	(*stub_glLinkProgram)(lv0);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glLinkProgramARB,(GLuint),void);
value glstub_glLinkProgramARB(value v0)
{
	CAMLparam1(v0);
	GLuint lv0 = Int_val(v0);
	LOAD_FUNCTION(glLinkProgramARB);
	(*stub_glLinkProgramARB)(lv0);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glListBase,(GLuint),void);
value glstub_glListBase(value v0)
{
	CAMLparam1(v0);
	GLuint lv0 = Int_val(v0);
	LOAD_FUNCTION(glListBase);
	(*stub_glListBase)(lv0);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glLoadIdentity,(void),void);
value glstub_glLoadIdentity(value v0)
{
	CAMLparam1(v0);
	LOAD_FUNCTION(glLoadIdentity);
	(*stub_glLoadIdentity)();
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glLoadMatrixd,(GLdouble*),void);
value glstub_glLoadMatrixd(value v0)
{
	CAMLparam1(v0);
	GLdouble* lv0 = (Tag_val(v0) == Double_array_tag)? (double *)v0: Data_bigarray_val(v0);
	LOAD_FUNCTION(glLoadMatrixd);
	(*stub_glLoadMatrixd)(lv0);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glLoadMatrixf,(GLfloat*),void);
value glstub_glLoadMatrixf(value v0)
{
	CAMLparam1(v0);
	GLfloat* lv0 = Data_bigarray_val(v0);
	LOAD_FUNCTION(glLoadMatrixf);
	(*stub_glLoadMatrixf)(lv0);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glLoadName,(GLuint),void);
value glstub_glLoadName(value v0)
{
	CAMLparam1(v0);
	GLuint lv0 = Int_val(v0);
	LOAD_FUNCTION(glLoadName);
	(*stub_glLoadName)(lv0);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glLoadProgramNV,(GLenum, GLuint, GLsizei, GLubyte*),void);
value glstub_glLoadProgramNV(value v0, value v1, value v2, value v3)
{
	CAMLparam4(v0, v1, v2, v3);
	GLenum lv0 = Int_val(v0);
	GLuint lv1 = Int_val(v1);
	GLsizei lv2 = Int_val(v2);
	GLubyte* lv3 = Data_bigarray_val(v3);
	LOAD_FUNCTION(glLoadProgramNV);
	(*stub_glLoadProgramNV)(lv0, lv1, lv2, lv3);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glLoadTransposeMatrixd,(GLdouble*),void);
value glstub_glLoadTransposeMatrixd(value v0)
{
	CAMLparam1(v0);
	GLdouble* lv0 = (Tag_val(v0) == Double_array_tag)? (double *)v0: Data_bigarray_val(v0);
	LOAD_FUNCTION(glLoadTransposeMatrixd);
	(*stub_glLoadTransposeMatrixd)(lv0);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glLoadTransposeMatrixdARB,(GLdouble*),void);
value glstub_glLoadTransposeMatrixdARB(value v0)
{
	CAMLparam1(v0);
	GLdouble* lv0 = (Tag_val(v0) == Double_array_tag)? (double *)v0: Data_bigarray_val(v0);
	LOAD_FUNCTION(glLoadTransposeMatrixdARB);
	(*stub_glLoadTransposeMatrixdARB)(lv0);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glLoadTransposeMatrixf,(GLfloat*),void);
value glstub_glLoadTransposeMatrixf(value v0)
{
	CAMLparam1(v0);
	GLfloat* lv0 = Data_bigarray_val(v0);
	LOAD_FUNCTION(glLoadTransposeMatrixf);
	(*stub_glLoadTransposeMatrixf)(lv0);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glLoadTransposeMatrixfARB,(GLfloat*),void);
value glstub_glLoadTransposeMatrixfARB(value v0)
{
	CAMLparam1(v0);
	GLfloat* lv0 = Data_bigarray_val(v0);
	LOAD_FUNCTION(glLoadTransposeMatrixfARB);
	(*stub_glLoadTransposeMatrixfARB)(lv0);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glLockArraysEXT,(GLint, GLsizei),void);
value glstub_glLockArraysEXT(value v0, value v1)
{
	CAMLparam2(v0, v1);
	GLint lv0 = Int_val(v0);
	GLsizei lv1 = Int_val(v1);
	LOAD_FUNCTION(glLockArraysEXT);
	(*stub_glLockArraysEXT)(lv0, lv1);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glLogicOp,(GLenum),void);
value glstub_glLogicOp(value v0)
{
	CAMLparam1(v0);
	GLenum lv0 = Int_val(v0);
	LOAD_FUNCTION(glLogicOp);
	(*stub_glLogicOp)(lv0);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glMap1d,(GLenum, GLdouble, GLdouble, GLint, GLint, GLdouble*),void);
value glstub_glMap1d(value v0, value v1, value v2, value v3, value v4, value v5)
{
	CAMLparam5(v0, v1, v2, v3, v4);
	CAMLxparam1(v5);
	GLenum lv0 = Int_val(v0);
	GLdouble lv1 = Double_val(v1);
	GLdouble lv2 = Double_val(v2);
	GLint lv3 = Int_val(v3);
	GLint lv4 = Int_val(v4);
	GLdouble* lv5 = (Tag_val(v5) == Double_array_tag)? (double *)v5: Data_bigarray_val(v5);
	LOAD_FUNCTION(glMap1d);
	(*stub_glMap1d)(lv0, lv1, lv2, lv3, lv4, lv5);
	CAMLreturn(Val_unit);
}

value glstub_glMap1d_byte(value * argv, int n)
{
	return glstub_glMap1d(argv[0], argv[1], argv[2], argv[3], argv[4], argv[5]);
}

DECLARE_FUNCTION(glMap1f,(GLenum, GLfloat, GLfloat, GLint, GLint, GLfloat*),void);
value glstub_glMap1f(value v0, value v1, value v2, value v3, value v4, value v5)
{
	CAMLparam5(v0, v1, v2, v3, v4);
	CAMLxparam1(v5);
	GLenum lv0 = Int_val(v0);
	GLfloat lv1 = Double_val(v1);
	GLfloat lv2 = Double_val(v2);
	GLint lv3 = Int_val(v3);
	GLint lv4 = Int_val(v4);
	GLfloat* lv5 = Data_bigarray_val(v5);
	LOAD_FUNCTION(glMap1f);
	(*stub_glMap1f)(lv0, lv1, lv2, lv3, lv4, lv5);
	CAMLreturn(Val_unit);
}

value glstub_glMap1f_byte(value * argv, int n)
{
	return glstub_glMap1f(argv[0], argv[1], argv[2], argv[3], argv[4], argv[5]);
}

DECLARE_FUNCTION(glMap2d,(GLenum, GLdouble, GLdouble, GLint, GLint, GLdouble, GLdouble, GLint, GLint, GLdouble*),void);
value glstub_glMap2d(value v0, value v1, value v2, value v3, value v4, value v5, value v6, value v7, value v8, value v9)
{
	CAMLparam5(v0, v1, v2, v3, v4);
	CAMLxparam5(v5, v6, v7, v8, v9);
	GLenum lv0 = Int_val(v0);
	GLdouble lv1 = Double_val(v1);
	GLdouble lv2 = Double_val(v2);
	GLint lv3 = Int_val(v3);
	GLint lv4 = Int_val(v4);
	GLdouble lv5 = Double_val(v5);
	GLdouble lv6 = Double_val(v6);
	GLint lv7 = Int_val(v7);
	GLint lv8 = Int_val(v8);
	GLdouble* lv9 = (Tag_val(v9) == Double_array_tag)? (double *)v9: Data_bigarray_val(v9);
	LOAD_FUNCTION(glMap2d);
	(*stub_glMap2d)(lv0, lv1, lv2, lv3, lv4, lv5, lv6, lv7, lv8, lv9);
	CAMLreturn(Val_unit);
}

value glstub_glMap2d_byte(value * argv, int n)
{
	return glstub_glMap2d(argv[0], argv[1], argv[2], argv[3], argv[4], argv[5], argv[6], argv[7], argv[8], argv[9]);
}

DECLARE_FUNCTION(glMap2f,(GLenum, GLfloat, GLfloat, GLint, GLint, GLfloat, GLfloat, GLint, GLint, GLfloat*),void);
value glstub_glMap2f(value v0, value v1, value v2, value v3, value v4, value v5, value v6, value v7, value v8, value v9)
{
	CAMLparam5(v0, v1, v2, v3, v4);
	CAMLxparam5(v5, v6, v7, v8, v9);
	GLenum lv0 = Int_val(v0);
	GLfloat lv1 = Double_val(v1);
	GLfloat lv2 = Double_val(v2);
	GLint lv3 = Int_val(v3);
	GLint lv4 = Int_val(v4);
	GLfloat lv5 = Double_val(v5);
	GLfloat lv6 = Double_val(v6);
	GLint lv7 = Int_val(v7);
	GLint lv8 = Int_val(v8);
	GLfloat* lv9 = Data_bigarray_val(v9);
	LOAD_FUNCTION(glMap2f);
	(*stub_glMap2f)(lv0, lv1, lv2, lv3, lv4, lv5, lv6, lv7, lv8, lv9);
	CAMLreturn(Val_unit);
}

value glstub_glMap2f_byte(value * argv, int n)
{
	return glstub_glMap2f(argv[0], argv[1], argv[2], argv[3], argv[4], argv[5], argv[6], argv[7], argv[8], argv[9]);
}

DECLARE_FUNCTION(glMapBuffer,(GLenum, GLenum),GLvoid*);
value glstub_glMapBuffer(value v0, value v1)
{
	CAMLparam2(v0, v1);
	CAMLlocal1(result);
	GLenum lv0 = Int_val(v0);
	GLenum lv1 = Int_val(v1);
	GLvoid* ret;
	LOAD_FUNCTION(glMapBuffer);
	ret = (*stub_glMapBuffer)(lv0, lv1);
	result = (value)(ret);
	CAMLreturn(result);
}

DECLARE_FUNCTION(glMapBufferARB,(GLenum, GLenum),GLvoid*);
value glstub_glMapBufferARB(value v0, value v1)
{
	CAMLparam2(v0, v1);
	CAMLlocal1(result);
	GLenum lv0 = Int_val(v0);
	GLenum lv1 = Int_val(v1);
	GLvoid* ret;
	LOAD_FUNCTION(glMapBufferARB);
	ret = (*stub_glMapBufferARB)(lv0, lv1);
	result = (value)(ret);
	CAMLreturn(result);
}

DECLARE_FUNCTION(glMapControlPointsNV,(GLenum, GLuint, GLenum, GLsizei, GLsizei, GLint, GLint, GLboolean, GLvoid*),void);
value glstub_glMapControlPointsNV(value v0, value v1, value v2, value v3, value v4, value v5, value v6, value v7, value v8)
{
	CAMLparam5(v0, v1, v2, v3, v4);
	CAMLxparam4(v5, v6, v7, v8);
	GLenum lv0 = Int_val(v0);
	GLuint lv1 = Int_val(v1);
	GLenum lv2 = Int_val(v2);
	GLsizei lv3 = Int_val(v3);
	GLsizei lv4 = Int_val(v4);
	GLint lv5 = Int_val(v5);
	GLint lv6 = Int_val(v6);
	GLboolean lv7 = Bool_val(v7);
	GLvoid* lv8 = (GLvoid *)((Tag_val(v8) == String_tag)? (String_val(v8)) : (Data_bigarray_val(v8)));
	LOAD_FUNCTION(glMapControlPointsNV);
	(*stub_glMapControlPointsNV)(lv0, lv1, lv2, lv3, lv4, lv5, lv6, lv7, lv8);
	CAMLreturn(Val_unit);
}

value glstub_glMapControlPointsNV_byte(value * argv, int n)
{
	return glstub_glMapControlPointsNV(argv[0], argv[1], argv[2], argv[3], argv[4], argv[5], argv[6], argv[7], argv[8]);
}

DECLARE_FUNCTION(glMapGrid1d,(GLint, GLdouble, GLdouble),void);
value glstub_glMapGrid1d(value v0, value v1, value v2)
{
	CAMLparam3(v0, v1, v2);
	GLint lv0 = Int_val(v0);
	GLdouble lv1 = Double_val(v1);
	GLdouble lv2 = Double_val(v2);
	LOAD_FUNCTION(glMapGrid1d);
	(*stub_glMapGrid1d)(lv0, lv1, lv2);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glMapGrid1f,(GLint, GLfloat, GLfloat),void);
value glstub_glMapGrid1f(value v0, value v1, value v2)
{
	CAMLparam3(v0, v1, v2);
	GLint lv0 = Int_val(v0);
	GLfloat lv1 = Double_val(v1);
	GLfloat lv2 = Double_val(v2);
	LOAD_FUNCTION(glMapGrid1f);
	(*stub_glMapGrid1f)(lv0, lv1, lv2);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glMapGrid2d,(GLint, GLdouble, GLdouble, GLint, GLdouble, GLdouble),void);
value glstub_glMapGrid2d(value v0, value v1, value v2, value v3, value v4, value v5)
{
	CAMLparam5(v0, v1, v2, v3, v4);
	CAMLxparam1(v5);
	GLint lv0 = Int_val(v0);
	GLdouble lv1 = Double_val(v1);
	GLdouble lv2 = Double_val(v2);
	GLint lv3 = Int_val(v3);
	GLdouble lv4 = Double_val(v4);
	GLdouble lv5 = Double_val(v5);
	LOAD_FUNCTION(glMapGrid2d);
	(*stub_glMapGrid2d)(lv0, lv1, lv2, lv3, lv4, lv5);
	CAMLreturn(Val_unit);
}

value glstub_glMapGrid2d_byte(value * argv, int n)
{
	return glstub_glMapGrid2d(argv[0], argv[1], argv[2], argv[3], argv[4], argv[5]);
}

DECLARE_FUNCTION(glMapGrid2f,(GLint, GLfloat, GLfloat, GLint, GLfloat, GLfloat),void);
value glstub_glMapGrid2f(value v0, value v1, value v2, value v3, value v4, value v5)
{
	CAMLparam5(v0, v1, v2, v3, v4);
	CAMLxparam1(v5);
	GLint lv0 = Int_val(v0);
	GLfloat lv1 = Double_val(v1);
	GLfloat lv2 = Double_val(v2);
	GLint lv3 = Int_val(v3);
	GLfloat lv4 = Double_val(v4);
	GLfloat lv5 = Double_val(v5);
	LOAD_FUNCTION(glMapGrid2f);
	(*stub_glMapGrid2f)(lv0, lv1, lv2, lv3, lv4, lv5);
	CAMLreturn(Val_unit);
}

value glstub_glMapGrid2f_byte(value * argv, int n)
{
	return glstub_glMapGrid2f(argv[0], argv[1], argv[2], argv[3], argv[4], argv[5]);
}

DECLARE_FUNCTION(glMapObjectBufferATI,(GLuint),void*);
value glstub_glMapObjectBufferATI(value v0)
{
	CAMLparam1(v0);
	CAMLlocal1(result);
	GLuint lv0 = Int_val(v0);
	void* ret;
	LOAD_FUNCTION(glMapObjectBufferATI);
	ret = (*stub_glMapObjectBufferATI)(lv0);
	result = (value)(ret);
	CAMLreturn(result);
}

DECLARE_FUNCTION(glMapParameterfvNV,(GLenum, GLenum, GLfloat*),void);
value glstub_glMapParameterfvNV(value v0, value v1, value v2)
{
	CAMLparam3(v0, v1, v2);
	GLenum lv0 = Int_val(v0);
	GLenum lv1 = Int_val(v1);
	GLfloat* lv2 = Data_bigarray_val(v2);
	LOAD_FUNCTION(glMapParameterfvNV);
	(*stub_glMapParameterfvNV)(lv0, lv1, lv2);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glMapParameterivNV,(GLenum, GLenum, GLint*),void);
value glstub_glMapParameterivNV(value v0, value v1, value v2)
{
	CAMLparam3(v0, v1, v2);
	GLenum lv0 = Int_val(v0);
	GLenum lv1 = Int_val(v1);
	GLint* lv2 = Data_bigarray_val(v2);
	LOAD_FUNCTION(glMapParameterivNV);
	(*stub_glMapParameterivNV)(lv0, lv1, lv2);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glMaterialf,(GLenum, GLenum, GLfloat),void);
value glstub_glMaterialf(value v0, value v1, value v2)
{
	CAMLparam3(v0, v1, v2);
	GLenum lv0 = Int_val(v0);
	GLenum lv1 = Int_val(v1);
	GLfloat lv2 = Double_val(v2);
	LOAD_FUNCTION(glMaterialf);
	(*stub_glMaterialf)(lv0, lv1, lv2);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glMaterialfv,(GLenum, GLenum, GLfloat*),void);
value glstub_glMaterialfv(value v0, value v1, value v2)
{
	CAMLparam3(v0, v1, v2);
	GLenum lv0 = Int_val(v0);
	GLenum lv1 = Int_val(v1);
	GLfloat* lv2 = Data_bigarray_val(v2);
	LOAD_FUNCTION(glMaterialfv);
	(*stub_glMaterialfv)(lv0, lv1, lv2);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glMateriali,(GLenum, GLenum, GLint),void);
value glstub_glMateriali(value v0, value v1, value v2)
{
	CAMLparam3(v0, v1, v2);
	GLenum lv0 = Int_val(v0);
	GLenum lv1 = Int_val(v1);
	GLint lv2 = Int_val(v2);
	LOAD_FUNCTION(glMateriali);
	(*stub_glMateriali)(lv0, lv1, lv2);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glMaterialiv,(GLenum, GLenum, GLint*),void);
value glstub_glMaterialiv(value v0, value v1, value v2)
{
	CAMLparam3(v0, v1, v2);
	GLenum lv0 = Int_val(v0);
	GLenum lv1 = Int_val(v1);
	GLint* lv2 = Data_bigarray_val(v2);
	LOAD_FUNCTION(glMaterialiv);
	(*stub_glMaterialiv)(lv0, lv1, lv2);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glMatrixIndexPointerARB,(GLint, GLenum, GLsizei, GLvoid*),void);
value glstub_glMatrixIndexPointerARB(value v0, value v1, value v2, value v3)
{
	CAMLparam4(v0, v1, v2, v3);
	GLint lv0 = Int_val(v0);
	GLenum lv1 = Int_val(v1);
	GLsizei lv2 = Int_val(v2);
	GLvoid* lv3 = (GLvoid *)((Tag_val(v3) == String_tag)? (String_val(v3)) : (Data_bigarray_val(v3)));
	LOAD_FUNCTION(glMatrixIndexPointerARB);
	(*stub_glMatrixIndexPointerARB)(lv0, lv1, lv2, lv3);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glMatrixIndexubvARB,(GLint, GLubyte*),void);
value glstub_glMatrixIndexubvARB(value v0, value v1)
{
	CAMLparam2(v0, v1);
	GLint lv0 = Int_val(v0);
	GLubyte* lv1 = Data_bigarray_val(v1);
	LOAD_FUNCTION(glMatrixIndexubvARB);
	(*stub_glMatrixIndexubvARB)(lv0, lv1);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glMatrixIndexuivARB,(GLint, GLuint*),void);
value glstub_glMatrixIndexuivARB(value v0, value v1)
{
	CAMLparam2(v0, v1);
	GLint lv0 = Int_val(v0);
	GLuint* lv1 = Data_bigarray_val(v1);
	LOAD_FUNCTION(glMatrixIndexuivARB);
	(*stub_glMatrixIndexuivARB)(lv0, lv1);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glMatrixIndexusvARB,(GLint, GLushort*),void);
value glstub_glMatrixIndexusvARB(value v0, value v1)
{
	CAMLparam2(v0, v1);
	GLint lv0 = Int_val(v0);
	GLushort* lv1 = Data_bigarray_val(v1);
	LOAD_FUNCTION(glMatrixIndexusvARB);
	(*stub_glMatrixIndexusvARB)(lv0, lv1);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glMatrixMode,(GLenum),void);
value glstub_glMatrixMode(value v0)
{
	CAMLparam1(v0);
	GLenum lv0 = Int_val(v0);
	LOAD_FUNCTION(glMatrixMode);
	(*stub_glMatrixMode)(lv0);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glMinmax,(GLenum, GLenum, GLboolean),void);
value glstub_glMinmax(value v0, value v1, value v2)
{
	CAMLparam3(v0, v1, v2);
	GLenum lv0 = Int_val(v0);
	GLenum lv1 = Int_val(v1);
	GLboolean lv2 = Bool_val(v2);
	LOAD_FUNCTION(glMinmax);
	(*stub_glMinmax)(lv0, lv1, lv2);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glMinmaxEXT,(GLenum, GLenum, GLboolean),void);
value glstub_glMinmaxEXT(value v0, value v1, value v2)
{
	CAMLparam3(v0, v1, v2);
	GLenum lv0 = Int_val(v0);
	GLenum lv1 = Int_val(v1);
	GLboolean lv2 = Bool_val(v2);
	LOAD_FUNCTION(glMinmaxEXT);
	(*stub_glMinmaxEXT)(lv0, lv1, lv2);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glMultMatrixd,(GLdouble*),void);
value glstub_glMultMatrixd(value v0)
{
	CAMLparam1(v0);
	GLdouble* lv0 = (Tag_val(v0) == Double_array_tag)? (double *)v0: Data_bigarray_val(v0);
	LOAD_FUNCTION(glMultMatrixd);
	(*stub_glMultMatrixd)(lv0);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glMultMatrixf,(GLfloat*),void);
value glstub_glMultMatrixf(value v0)
{
	CAMLparam1(v0);
	GLfloat* lv0 = Data_bigarray_val(v0);
	LOAD_FUNCTION(glMultMatrixf);
	(*stub_glMultMatrixf)(lv0);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glMultTransposeMatrixd,(GLdouble*),void);
value glstub_glMultTransposeMatrixd(value v0)
{
	CAMLparam1(v0);
	GLdouble* lv0 = (Tag_val(v0) == Double_array_tag)? (double *)v0: Data_bigarray_val(v0);
	LOAD_FUNCTION(glMultTransposeMatrixd);
	(*stub_glMultTransposeMatrixd)(lv0);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glMultTransposeMatrixdARB,(GLdouble*),void);
value glstub_glMultTransposeMatrixdARB(value v0)
{
	CAMLparam1(v0);
	GLdouble* lv0 = (Tag_val(v0) == Double_array_tag)? (double *)v0: Data_bigarray_val(v0);
	LOAD_FUNCTION(glMultTransposeMatrixdARB);
	(*stub_glMultTransposeMatrixdARB)(lv0);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glMultTransposeMatrixf,(GLfloat*),void);
value glstub_glMultTransposeMatrixf(value v0)
{
	CAMLparam1(v0);
	GLfloat* lv0 = Data_bigarray_val(v0);
	LOAD_FUNCTION(glMultTransposeMatrixf);
	(*stub_glMultTransposeMatrixf)(lv0);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glMultTransposeMatrixfARB,(GLfloat*),void);
value glstub_glMultTransposeMatrixfARB(value v0)
{
	CAMLparam1(v0);
	GLfloat* lv0 = Data_bigarray_val(v0);
	LOAD_FUNCTION(glMultTransposeMatrixfARB);
	(*stub_glMultTransposeMatrixfARB)(lv0);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glMultiDrawArrays,(GLenum, GLint*, GLsizei*, GLsizei),void);
value glstub_glMultiDrawArrays(value v0, value v1, value v2, value v3)
{
	CAMLparam4(v0, v1, v2, v3);
	GLenum lv0 = Int_val(v0);
	GLint* lv1 = Data_bigarray_val(v1);
	GLsizei* lv2 = Data_bigarray_val(v2);
	GLsizei lv3 = Int_val(v3);
	LOAD_FUNCTION(glMultiDrawArrays);
	(*stub_glMultiDrawArrays)(lv0, lv1, lv2, lv3);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glMultiDrawArraysEXT,(GLenum, GLint*, GLsizei*, GLsizei),void);
value glstub_glMultiDrawArraysEXT(value v0, value v1, value v2, value v3)
{
	CAMLparam4(v0, v1, v2, v3);
	GLenum lv0 = Int_val(v0);
	GLint* lv1 = Data_bigarray_val(v1);
	GLsizei* lv2 = Data_bigarray_val(v2);
	GLsizei lv3 = Int_val(v3);
	LOAD_FUNCTION(glMultiDrawArraysEXT);
	(*stub_glMultiDrawArraysEXT)(lv0, lv1, lv2, lv3);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glMultiDrawElementArrayAPPLE,(GLenum, GLint*, GLsizei*, GLsizei),void);
value glstub_glMultiDrawElementArrayAPPLE(value v0, value v1, value v2, value v3)
{
	CAMLparam4(v0, v1, v2, v3);
	GLenum lv0 = Int_val(v0);
	GLint* lv1 = Data_bigarray_val(v1);
	GLsizei* lv2 = Data_bigarray_val(v2);
	GLsizei lv3 = Int_val(v3);
	LOAD_FUNCTION(glMultiDrawElementArrayAPPLE);
	(*stub_glMultiDrawElementArrayAPPLE)(lv0, lv1, lv2, lv3);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glMultiDrawElements,(GLenum, GLsizei*, GLenum, GLvoid**, GLsizei),void);
value glstub_glMultiDrawElements(value v0, value v1, value v2, value v3, value v4)
{
	CAMLparam5(v0, v1, v2, v3, v4);
	GLenum lv0 = Int_val(v0);
	GLsizei* lv1 = Data_bigarray_val(v1);
	GLenum lv2 = Int_val(v2);
	GLvoid** lv3 = Data_bigarray_val(v3);
	GLsizei lv4 = Int_val(v4);
	LOAD_FUNCTION(glMultiDrawElements);
	(*stub_glMultiDrawElements)(lv0, lv1, lv2, lv3, lv4);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glMultiDrawElementsEXT,(GLenum, GLsizei*, GLenum, GLvoid**, GLsizei),void);
value glstub_glMultiDrawElementsEXT(value v0, value v1, value v2, value v3, value v4)
{
	CAMLparam5(v0, v1, v2, v3, v4);
	GLenum lv0 = Int_val(v0);
	GLsizei* lv1 = Data_bigarray_val(v1);
	GLenum lv2 = Int_val(v2);
	GLvoid** lv3 = Data_bigarray_val(v3);
	GLsizei lv4 = Int_val(v4);
	LOAD_FUNCTION(glMultiDrawElementsEXT);
	(*stub_glMultiDrawElementsEXT)(lv0, lv1, lv2, lv3, lv4);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glMultiDrawRangeElementArrayAPPLE,(GLenum, GLuint, GLuint, GLint*, GLsizei*, GLsizei),void);
value glstub_glMultiDrawRangeElementArrayAPPLE(value v0, value v1, value v2, value v3, value v4, value v5)
{
	CAMLparam5(v0, v1, v2, v3, v4);
	CAMLxparam1(v5);
	GLenum lv0 = Int_val(v0);
	GLuint lv1 = Int_val(v1);
	GLuint lv2 = Int_val(v2);
	GLint* lv3 = Data_bigarray_val(v3);
	GLsizei* lv4 = Data_bigarray_val(v4);
	GLsizei lv5 = Int_val(v5);
	LOAD_FUNCTION(glMultiDrawRangeElementArrayAPPLE);
	(*stub_glMultiDrawRangeElementArrayAPPLE)(lv0, lv1, lv2, lv3, lv4, lv5);
	CAMLreturn(Val_unit);
}

value glstub_glMultiDrawRangeElementArrayAPPLE_byte(value * argv, int n)
{
	return glstub_glMultiDrawRangeElementArrayAPPLE(argv[0], argv[1], argv[2], argv[3], argv[4], argv[5]);
}

DECLARE_FUNCTION(glMultiModeDrawArraysIBM,(GLenum*, GLint*, GLsizei*, GLsizei, GLint),void);
value glstub_glMultiModeDrawArraysIBM(value v0, value v1, value v2, value v3, value v4)
{
	CAMLparam5(v0, v1, v2, v3, v4);
	GLenum* lv0 = Data_bigarray_val(v0);
	GLint* lv1 = Data_bigarray_val(v1);
	GLsizei* lv2 = Data_bigarray_val(v2);
	GLsizei lv3 = Int_val(v3);
	GLint lv4 = Int_val(v4);
	LOAD_FUNCTION(glMultiModeDrawArraysIBM);
	(*stub_glMultiModeDrawArraysIBM)(lv0, lv1, lv2, lv3, lv4);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glMultiModeDrawElementsIBM,(GLenum*, GLsizei*, GLenum, GLvoid**, GLsizei, GLint),void);
value glstub_glMultiModeDrawElementsIBM(value v0, value v1, value v2, value v3, value v4, value v5)
{
	CAMLparam5(v0, v1, v2, v3, v4);
	CAMLxparam1(v5);
	GLenum* lv0 = Data_bigarray_val(v0);
	GLsizei* lv1 = Data_bigarray_val(v1);
	GLenum lv2 = Int_val(v2);
	GLvoid** lv3 = Data_bigarray_val(v3);
	GLsizei lv4 = Int_val(v4);
	GLint lv5 = Int_val(v5);
	LOAD_FUNCTION(glMultiModeDrawElementsIBM);
	(*stub_glMultiModeDrawElementsIBM)(lv0, lv1, lv2, lv3, lv4, lv5);
	CAMLreturn(Val_unit);
}

value glstub_glMultiModeDrawElementsIBM_byte(value * argv, int n)
{
	return glstub_glMultiModeDrawElementsIBM(argv[0], argv[1], argv[2], argv[3], argv[4], argv[5]);
}

DECLARE_FUNCTION(glMultiTexCoord1d,(GLenum, GLdouble),void);
value glstub_glMultiTexCoord1d(value v0, value v1)
{
	CAMLparam2(v0, v1);
	GLenum lv0 = Int_val(v0);
	GLdouble lv1 = Double_val(v1);
	LOAD_FUNCTION(glMultiTexCoord1d);
	(*stub_glMultiTexCoord1d)(lv0, lv1);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glMultiTexCoord1dARB,(GLenum, GLdouble),void);
value glstub_glMultiTexCoord1dARB(value v0, value v1)
{
	CAMLparam2(v0, v1);
	GLenum lv0 = Int_val(v0);
	GLdouble lv1 = Double_val(v1);
	LOAD_FUNCTION(glMultiTexCoord1dARB);
	(*stub_glMultiTexCoord1dARB)(lv0, lv1);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glMultiTexCoord1dv,(GLenum, GLdouble*),void);
value glstub_glMultiTexCoord1dv(value v0, value v1)
{
	CAMLparam2(v0, v1);
	GLenum lv0 = Int_val(v0);
	GLdouble* lv1 = (Tag_val(v1) == Double_array_tag)? (double *)v1: Data_bigarray_val(v1);
	LOAD_FUNCTION(glMultiTexCoord1dv);
	(*stub_glMultiTexCoord1dv)(lv0, lv1);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glMultiTexCoord1dvARB,(GLenum, GLdouble*),void);
value glstub_glMultiTexCoord1dvARB(value v0, value v1)
{
	CAMLparam2(v0, v1);
	GLenum lv0 = Int_val(v0);
	GLdouble* lv1 = (Tag_val(v1) == Double_array_tag)? (double *)v1: Data_bigarray_val(v1);
	LOAD_FUNCTION(glMultiTexCoord1dvARB);
	(*stub_glMultiTexCoord1dvARB)(lv0, lv1);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glMultiTexCoord1f,(GLenum, GLfloat),void);
value glstub_glMultiTexCoord1f(value v0, value v1)
{
	CAMLparam2(v0, v1);
	GLenum lv0 = Int_val(v0);
	GLfloat lv1 = Double_val(v1);
	LOAD_FUNCTION(glMultiTexCoord1f);
	(*stub_glMultiTexCoord1f)(lv0, lv1);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glMultiTexCoord1fARB,(GLenum, GLfloat),void);
value glstub_glMultiTexCoord1fARB(value v0, value v1)
{
	CAMLparam2(v0, v1);
	GLenum lv0 = Int_val(v0);
	GLfloat lv1 = Double_val(v1);
	LOAD_FUNCTION(glMultiTexCoord1fARB);
	(*stub_glMultiTexCoord1fARB)(lv0, lv1);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glMultiTexCoord1fv,(GLenum, GLfloat*),void);
value glstub_glMultiTexCoord1fv(value v0, value v1)
{
	CAMLparam2(v0, v1);
	GLenum lv0 = Int_val(v0);
	GLfloat* lv1 = Data_bigarray_val(v1);
	LOAD_FUNCTION(glMultiTexCoord1fv);
	(*stub_glMultiTexCoord1fv)(lv0, lv1);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glMultiTexCoord1fvARB,(GLenum, GLfloat*),void);
value glstub_glMultiTexCoord1fvARB(value v0, value v1)
{
	CAMLparam2(v0, v1);
	GLenum lv0 = Int_val(v0);
	GLfloat* lv1 = Data_bigarray_val(v1);
	LOAD_FUNCTION(glMultiTexCoord1fvARB);
	(*stub_glMultiTexCoord1fvARB)(lv0, lv1);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glMultiTexCoord1hNV,(GLenum, GLushort),void);
value glstub_glMultiTexCoord1hNV(value v0, value v1)
{
	CAMLparam2(v0, v1);
	GLenum lv0 = Int_val(v0);
	GLushort lv1 = Int_val(v1);
	LOAD_FUNCTION(glMultiTexCoord1hNV);
	(*stub_glMultiTexCoord1hNV)(lv0, lv1);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glMultiTexCoord1hvNV,(GLenum, GLushort*),void);
value glstub_glMultiTexCoord1hvNV(value v0, value v1)
{
	CAMLparam2(v0, v1);
	GLenum lv0 = Int_val(v0);
	GLushort* lv1 = Data_bigarray_val(v1);
	LOAD_FUNCTION(glMultiTexCoord1hvNV);
	(*stub_glMultiTexCoord1hvNV)(lv0, lv1);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glMultiTexCoord1i,(GLenum, GLint),void);
value glstub_glMultiTexCoord1i(value v0, value v1)
{
	CAMLparam2(v0, v1);
	GLenum lv0 = Int_val(v0);
	GLint lv1 = Int_val(v1);
	LOAD_FUNCTION(glMultiTexCoord1i);
	(*stub_glMultiTexCoord1i)(lv0, lv1);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glMultiTexCoord1iARB,(GLenum, GLint),void);
value glstub_glMultiTexCoord1iARB(value v0, value v1)
{
	CAMLparam2(v0, v1);
	GLenum lv0 = Int_val(v0);
	GLint lv1 = Int_val(v1);
	LOAD_FUNCTION(glMultiTexCoord1iARB);
	(*stub_glMultiTexCoord1iARB)(lv0, lv1);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glMultiTexCoord1iv,(GLenum, GLint*),void);
value glstub_glMultiTexCoord1iv(value v0, value v1)
{
	CAMLparam2(v0, v1);
	GLenum lv0 = Int_val(v0);
	GLint* lv1 = Data_bigarray_val(v1);
	LOAD_FUNCTION(glMultiTexCoord1iv);
	(*stub_glMultiTexCoord1iv)(lv0, lv1);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glMultiTexCoord1ivARB,(GLenum, GLint*),void);
value glstub_glMultiTexCoord1ivARB(value v0, value v1)
{
	CAMLparam2(v0, v1);
	GLenum lv0 = Int_val(v0);
	GLint* lv1 = Data_bigarray_val(v1);
	LOAD_FUNCTION(glMultiTexCoord1ivARB);
	(*stub_glMultiTexCoord1ivARB)(lv0, lv1);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glMultiTexCoord1s,(GLenum, GLshort),void);
value glstub_glMultiTexCoord1s(value v0, value v1)
{
	CAMLparam2(v0, v1);
	GLenum lv0 = Int_val(v0);
	GLshort lv1 = Int_val(v1);
	LOAD_FUNCTION(glMultiTexCoord1s);
	(*stub_glMultiTexCoord1s)(lv0, lv1);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glMultiTexCoord1sARB,(GLenum, GLshort),void);
value glstub_glMultiTexCoord1sARB(value v0, value v1)
{
	CAMLparam2(v0, v1);
	GLenum lv0 = Int_val(v0);
	GLshort lv1 = Int_val(v1);
	LOAD_FUNCTION(glMultiTexCoord1sARB);
	(*stub_glMultiTexCoord1sARB)(lv0, lv1);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glMultiTexCoord1sv,(GLenum, GLshort*),void);
value glstub_glMultiTexCoord1sv(value v0, value v1)
{
	CAMLparam2(v0, v1);
	GLenum lv0 = Int_val(v0);
	GLshort* lv1 = Data_bigarray_val(v1);
	LOAD_FUNCTION(glMultiTexCoord1sv);
	(*stub_glMultiTexCoord1sv)(lv0, lv1);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glMultiTexCoord1svARB,(GLenum, GLshort*),void);
value glstub_glMultiTexCoord1svARB(value v0, value v1)
{
	CAMLparam2(v0, v1);
	GLenum lv0 = Int_val(v0);
	GLshort* lv1 = Data_bigarray_val(v1);
	LOAD_FUNCTION(glMultiTexCoord1svARB);
	(*stub_glMultiTexCoord1svARB)(lv0, lv1);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glMultiTexCoord2d,(GLenum, GLdouble, GLdouble),void);
value glstub_glMultiTexCoord2d(value v0, value v1, value v2)
{
	CAMLparam3(v0, v1, v2);
	GLenum lv0 = Int_val(v0);
	GLdouble lv1 = Double_val(v1);
	GLdouble lv2 = Double_val(v2);
	LOAD_FUNCTION(glMultiTexCoord2d);
	(*stub_glMultiTexCoord2d)(lv0, lv1, lv2);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glMultiTexCoord2dARB,(GLenum, GLdouble, GLdouble),void);
value glstub_glMultiTexCoord2dARB(value v0, value v1, value v2)
{
	CAMLparam3(v0, v1, v2);
	GLenum lv0 = Int_val(v0);
	GLdouble lv1 = Double_val(v1);
	GLdouble lv2 = Double_val(v2);
	LOAD_FUNCTION(glMultiTexCoord2dARB);
	(*stub_glMultiTexCoord2dARB)(lv0, lv1, lv2);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glMultiTexCoord2dv,(GLenum, GLdouble*),void);
value glstub_glMultiTexCoord2dv(value v0, value v1)
{
	CAMLparam2(v0, v1);
	GLenum lv0 = Int_val(v0);
	GLdouble* lv1 = (Tag_val(v1) == Double_array_tag)? (double *)v1: Data_bigarray_val(v1);
	LOAD_FUNCTION(glMultiTexCoord2dv);
	(*stub_glMultiTexCoord2dv)(lv0, lv1);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glMultiTexCoord2dvARB,(GLenum, GLdouble*),void);
value glstub_glMultiTexCoord2dvARB(value v0, value v1)
{
	CAMLparam2(v0, v1);
	GLenum lv0 = Int_val(v0);
	GLdouble* lv1 = (Tag_val(v1) == Double_array_tag)? (double *)v1: Data_bigarray_val(v1);
	LOAD_FUNCTION(glMultiTexCoord2dvARB);
	(*stub_glMultiTexCoord2dvARB)(lv0, lv1);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glMultiTexCoord2f,(GLenum, GLfloat, GLfloat),void);
value glstub_glMultiTexCoord2f(value v0, value v1, value v2)
{
	CAMLparam3(v0, v1, v2);
	GLenum lv0 = Int_val(v0);
	GLfloat lv1 = Double_val(v1);
	GLfloat lv2 = Double_val(v2);
	LOAD_FUNCTION(glMultiTexCoord2f);
	(*stub_glMultiTexCoord2f)(lv0, lv1, lv2);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glMultiTexCoord2fARB,(GLenum, GLfloat, GLfloat),void);
value glstub_glMultiTexCoord2fARB(value v0, value v1, value v2)
{
	CAMLparam3(v0, v1, v2);
	GLenum lv0 = Int_val(v0);
	GLfloat lv1 = Double_val(v1);
	GLfloat lv2 = Double_val(v2);
	LOAD_FUNCTION(glMultiTexCoord2fARB);
	(*stub_glMultiTexCoord2fARB)(lv0, lv1, lv2);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glMultiTexCoord2fv,(GLenum, GLfloat*),void);
value glstub_glMultiTexCoord2fv(value v0, value v1)
{
	CAMLparam2(v0, v1);
	GLenum lv0 = Int_val(v0);
	GLfloat* lv1 = Data_bigarray_val(v1);
	LOAD_FUNCTION(glMultiTexCoord2fv);
	(*stub_glMultiTexCoord2fv)(lv0, lv1);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glMultiTexCoord2fvARB,(GLenum, GLfloat*),void);
value glstub_glMultiTexCoord2fvARB(value v0, value v1)
{
	CAMLparam2(v0, v1);
	GLenum lv0 = Int_val(v0);
	GLfloat* lv1 = Data_bigarray_val(v1);
	LOAD_FUNCTION(glMultiTexCoord2fvARB);
	(*stub_glMultiTexCoord2fvARB)(lv0, lv1);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glMultiTexCoord2hNV,(GLenum, GLushort, GLushort),void);
value glstub_glMultiTexCoord2hNV(value v0, value v1, value v2)
{
	CAMLparam3(v0, v1, v2);
	GLenum lv0 = Int_val(v0);
	GLushort lv1 = Int_val(v1);
	GLushort lv2 = Int_val(v2);
	LOAD_FUNCTION(glMultiTexCoord2hNV);
	(*stub_glMultiTexCoord2hNV)(lv0, lv1, lv2);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glMultiTexCoord2hvNV,(GLenum, GLushort*),void);
value glstub_glMultiTexCoord2hvNV(value v0, value v1)
{
	CAMLparam2(v0, v1);
	GLenum lv0 = Int_val(v0);
	GLushort* lv1 = Data_bigarray_val(v1);
	LOAD_FUNCTION(glMultiTexCoord2hvNV);
	(*stub_glMultiTexCoord2hvNV)(lv0, lv1);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glMultiTexCoord2i,(GLenum, GLint, GLint),void);
value glstub_glMultiTexCoord2i(value v0, value v1, value v2)
{
	CAMLparam3(v0, v1, v2);
	GLenum lv0 = Int_val(v0);
	GLint lv1 = Int_val(v1);
	GLint lv2 = Int_val(v2);
	LOAD_FUNCTION(glMultiTexCoord2i);
	(*stub_glMultiTexCoord2i)(lv0, lv1, lv2);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glMultiTexCoord2iARB,(GLenum, GLint, GLint),void);
value glstub_glMultiTexCoord2iARB(value v0, value v1, value v2)
{
	CAMLparam3(v0, v1, v2);
	GLenum lv0 = Int_val(v0);
	GLint lv1 = Int_val(v1);
	GLint lv2 = Int_val(v2);
	LOAD_FUNCTION(glMultiTexCoord2iARB);
	(*stub_glMultiTexCoord2iARB)(lv0, lv1, lv2);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glMultiTexCoord2iv,(GLenum, GLint*),void);
value glstub_glMultiTexCoord2iv(value v0, value v1)
{
	CAMLparam2(v0, v1);
	GLenum lv0 = Int_val(v0);
	GLint* lv1 = Data_bigarray_val(v1);
	LOAD_FUNCTION(glMultiTexCoord2iv);
	(*stub_glMultiTexCoord2iv)(lv0, lv1);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glMultiTexCoord2ivARB,(GLenum, GLint*),void);
value glstub_glMultiTexCoord2ivARB(value v0, value v1)
{
	CAMLparam2(v0, v1);
	GLenum lv0 = Int_val(v0);
	GLint* lv1 = Data_bigarray_val(v1);
	LOAD_FUNCTION(glMultiTexCoord2ivARB);
	(*stub_glMultiTexCoord2ivARB)(lv0, lv1);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glMultiTexCoord2s,(GLenum, GLshort, GLshort),void);
value glstub_glMultiTexCoord2s(value v0, value v1, value v2)
{
	CAMLparam3(v0, v1, v2);
	GLenum lv0 = Int_val(v0);
	GLshort lv1 = Int_val(v1);
	GLshort lv2 = Int_val(v2);
	LOAD_FUNCTION(glMultiTexCoord2s);
	(*stub_glMultiTexCoord2s)(lv0, lv1, lv2);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glMultiTexCoord2sARB,(GLenum, GLshort, GLshort),void);
value glstub_glMultiTexCoord2sARB(value v0, value v1, value v2)
{
	CAMLparam3(v0, v1, v2);
	GLenum lv0 = Int_val(v0);
	GLshort lv1 = Int_val(v1);
	GLshort lv2 = Int_val(v2);
	LOAD_FUNCTION(glMultiTexCoord2sARB);
	(*stub_glMultiTexCoord2sARB)(lv0, lv1, lv2);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glMultiTexCoord2sv,(GLenum, GLshort*),void);
value glstub_glMultiTexCoord2sv(value v0, value v1)
{
	CAMLparam2(v0, v1);
	GLenum lv0 = Int_val(v0);
	GLshort* lv1 = Data_bigarray_val(v1);
	LOAD_FUNCTION(glMultiTexCoord2sv);
	(*stub_glMultiTexCoord2sv)(lv0, lv1);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glMultiTexCoord2svARB,(GLenum, GLshort*),void);
value glstub_glMultiTexCoord2svARB(value v0, value v1)
{
	CAMLparam2(v0, v1);
	GLenum lv0 = Int_val(v0);
	GLshort* lv1 = Data_bigarray_val(v1);
	LOAD_FUNCTION(glMultiTexCoord2svARB);
	(*stub_glMultiTexCoord2svARB)(lv0, lv1);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glMultiTexCoord3d,(GLenum, GLdouble, GLdouble, GLdouble),void);
value glstub_glMultiTexCoord3d(value v0, value v1, value v2, value v3)
{
	CAMLparam4(v0, v1, v2, v3);
	GLenum lv0 = Int_val(v0);
	GLdouble lv1 = Double_val(v1);
	GLdouble lv2 = Double_val(v2);
	GLdouble lv3 = Double_val(v3);
	LOAD_FUNCTION(glMultiTexCoord3d);
	(*stub_glMultiTexCoord3d)(lv0, lv1, lv2, lv3);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glMultiTexCoord3dARB,(GLenum, GLdouble, GLdouble, GLdouble),void);
value glstub_glMultiTexCoord3dARB(value v0, value v1, value v2, value v3)
{
	CAMLparam4(v0, v1, v2, v3);
	GLenum lv0 = Int_val(v0);
	GLdouble lv1 = Double_val(v1);
	GLdouble lv2 = Double_val(v2);
	GLdouble lv3 = Double_val(v3);
	LOAD_FUNCTION(glMultiTexCoord3dARB);
	(*stub_glMultiTexCoord3dARB)(lv0, lv1, lv2, lv3);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glMultiTexCoord3dv,(GLenum, GLdouble*),void);
value glstub_glMultiTexCoord3dv(value v0, value v1)
{
	CAMLparam2(v0, v1);
	GLenum lv0 = Int_val(v0);
	GLdouble* lv1 = (Tag_val(v1) == Double_array_tag)? (double *)v1: Data_bigarray_val(v1);
	LOAD_FUNCTION(glMultiTexCoord3dv);
	(*stub_glMultiTexCoord3dv)(lv0, lv1);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glMultiTexCoord3dvARB,(GLenum, GLdouble*),void);
value glstub_glMultiTexCoord3dvARB(value v0, value v1)
{
	CAMLparam2(v0, v1);
	GLenum lv0 = Int_val(v0);
	GLdouble* lv1 = (Tag_val(v1) == Double_array_tag)? (double *)v1: Data_bigarray_val(v1);
	LOAD_FUNCTION(glMultiTexCoord3dvARB);
	(*stub_glMultiTexCoord3dvARB)(lv0, lv1);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glMultiTexCoord3f,(GLenum, GLfloat, GLfloat, GLfloat),void);
value glstub_glMultiTexCoord3f(value v0, value v1, value v2, value v3)
{
	CAMLparam4(v0, v1, v2, v3);
	GLenum lv0 = Int_val(v0);
	GLfloat lv1 = Double_val(v1);
	GLfloat lv2 = Double_val(v2);
	GLfloat lv3 = Double_val(v3);
	LOAD_FUNCTION(glMultiTexCoord3f);
	(*stub_glMultiTexCoord3f)(lv0, lv1, lv2, lv3);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glMultiTexCoord3fARB,(GLenum, GLfloat, GLfloat, GLfloat),void);
value glstub_glMultiTexCoord3fARB(value v0, value v1, value v2, value v3)
{
	CAMLparam4(v0, v1, v2, v3);
	GLenum lv0 = Int_val(v0);
	GLfloat lv1 = Double_val(v1);
	GLfloat lv2 = Double_val(v2);
	GLfloat lv3 = Double_val(v3);
	LOAD_FUNCTION(glMultiTexCoord3fARB);
	(*stub_glMultiTexCoord3fARB)(lv0, lv1, lv2, lv3);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glMultiTexCoord3fv,(GLenum, GLfloat*),void);
value glstub_glMultiTexCoord3fv(value v0, value v1)
{
	CAMLparam2(v0, v1);
	GLenum lv0 = Int_val(v0);
	GLfloat* lv1 = Data_bigarray_val(v1);
	LOAD_FUNCTION(glMultiTexCoord3fv);
	(*stub_glMultiTexCoord3fv)(lv0, lv1);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glMultiTexCoord3fvARB,(GLenum, GLfloat*),void);
value glstub_glMultiTexCoord3fvARB(value v0, value v1)
{
	CAMLparam2(v0, v1);
	GLenum lv0 = Int_val(v0);
	GLfloat* lv1 = Data_bigarray_val(v1);
	LOAD_FUNCTION(glMultiTexCoord3fvARB);
	(*stub_glMultiTexCoord3fvARB)(lv0, lv1);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glMultiTexCoord3hNV,(GLenum, GLushort, GLushort, GLushort),void);
value glstub_glMultiTexCoord3hNV(value v0, value v1, value v2, value v3)
{
	CAMLparam4(v0, v1, v2, v3);
	GLenum lv0 = Int_val(v0);
	GLushort lv1 = Int_val(v1);
	GLushort lv2 = Int_val(v2);
	GLushort lv3 = Int_val(v3);
	LOAD_FUNCTION(glMultiTexCoord3hNV);
	(*stub_glMultiTexCoord3hNV)(lv0, lv1, lv2, lv3);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glMultiTexCoord3hvNV,(GLenum, GLushort*),void);
value glstub_glMultiTexCoord3hvNV(value v0, value v1)
{
	CAMLparam2(v0, v1);
	GLenum lv0 = Int_val(v0);
	GLushort* lv1 = Data_bigarray_val(v1);
	LOAD_FUNCTION(glMultiTexCoord3hvNV);
	(*stub_glMultiTexCoord3hvNV)(lv0, lv1);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glMultiTexCoord3i,(GLenum, GLint, GLint, GLint),void);
value glstub_glMultiTexCoord3i(value v0, value v1, value v2, value v3)
{
	CAMLparam4(v0, v1, v2, v3);
	GLenum lv0 = Int_val(v0);
	GLint lv1 = Int_val(v1);
	GLint lv2 = Int_val(v2);
	GLint lv3 = Int_val(v3);
	LOAD_FUNCTION(glMultiTexCoord3i);
	(*stub_glMultiTexCoord3i)(lv0, lv1, lv2, lv3);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glMultiTexCoord3iARB,(GLenum, GLint, GLint, GLint),void);
value glstub_glMultiTexCoord3iARB(value v0, value v1, value v2, value v3)
{
	CAMLparam4(v0, v1, v2, v3);
	GLenum lv0 = Int_val(v0);
	GLint lv1 = Int_val(v1);
	GLint lv2 = Int_val(v2);
	GLint lv3 = Int_val(v3);
	LOAD_FUNCTION(glMultiTexCoord3iARB);
	(*stub_glMultiTexCoord3iARB)(lv0, lv1, lv2, lv3);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glMultiTexCoord3iv,(GLenum, GLint*),void);
value glstub_glMultiTexCoord3iv(value v0, value v1)
{
	CAMLparam2(v0, v1);
	GLenum lv0 = Int_val(v0);
	GLint* lv1 = Data_bigarray_val(v1);
	LOAD_FUNCTION(glMultiTexCoord3iv);
	(*stub_glMultiTexCoord3iv)(lv0, lv1);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glMultiTexCoord3ivARB,(GLenum, GLint*),void);
value glstub_glMultiTexCoord3ivARB(value v0, value v1)
{
	CAMLparam2(v0, v1);
	GLenum lv0 = Int_val(v0);
	GLint* lv1 = Data_bigarray_val(v1);
	LOAD_FUNCTION(glMultiTexCoord3ivARB);
	(*stub_glMultiTexCoord3ivARB)(lv0, lv1);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glMultiTexCoord3s,(GLenum, GLshort, GLshort, GLshort),void);
value glstub_glMultiTexCoord3s(value v0, value v1, value v2, value v3)
{
	CAMLparam4(v0, v1, v2, v3);
	GLenum lv0 = Int_val(v0);
	GLshort lv1 = Int_val(v1);
	GLshort lv2 = Int_val(v2);
	GLshort lv3 = Int_val(v3);
	LOAD_FUNCTION(glMultiTexCoord3s);
	(*stub_glMultiTexCoord3s)(lv0, lv1, lv2, lv3);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glMultiTexCoord3sARB,(GLenum, GLshort, GLshort, GLshort),void);
value glstub_glMultiTexCoord3sARB(value v0, value v1, value v2, value v3)
{
	CAMLparam4(v0, v1, v2, v3);
	GLenum lv0 = Int_val(v0);
	GLshort lv1 = Int_val(v1);
	GLshort lv2 = Int_val(v2);
	GLshort lv3 = Int_val(v3);
	LOAD_FUNCTION(glMultiTexCoord3sARB);
	(*stub_glMultiTexCoord3sARB)(lv0, lv1, lv2, lv3);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glMultiTexCoord3sv,(GLenum, GLshort*),void);
value glstub_glMultiTexCoord3sv(value v0, value v1)
{
	CAMLparam2(v0, v1);
	GLenum lv0 = Int_val(v0);
	GLshort* lv1 = Data_bigarray_val(v1);
	LOAD_FUNCTION(glMultiTexCoord3sv);
	(*stub_glMultiTexCoord3sv)(lv0, lv1);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glMultiTexCoord3svARB,(GLenum, GLshort*),void);
value glstub_glMultiTexCoord3svARB(value v0, value v1)
{
	CAMLparam2(v0, v1);
	GLenum lv0 = Int_val(v0);
	GLshort* lv1 = Data_bigarray_val(v1);
	LOAD_FUNCTION(glMultiTexCoord3svARB);
	(*stub_glMultiTexCoord3svARB)(lv0, lv1);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glMultiTexCoord4d,(GLenum, GLdouble, GLdouble, GLdouble, GLdouble),void);
value glstub_glMultiTexCoord4d(value v0, value v1, value v2, value v3, value v4)
{
	CAMLparam5(v0, v1, v2, v3, v4);
	GLenum lv0 = Int_val(v0);
	GLdouble lv1 = Double_val(v1);
	GLdouble lv2 = Double_val(v2);
	GLdouble lv3 = Double_val(v3);
	GLdouble lv4 = Double_val(v4);
	LOAD_FUNCTION(glMultiTexCoord4d);
	(*stub_glMultiTexCoord4d)(lv0, lv1, lv2, lv3, lv4);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glMultiTexCoord4dARB,(GLenum, GLdouble, GLdouble, GLdouble, GLdouble),void);
value glstub_glMultiTexCoord4dARB(value v0, value v1, value v2, value v3, value v4)
{
	CAMLparam5(v0, v1, v2, v3, v4);
	GLenum lv0 = Int_val(v0);
	GLdouble lv1 = Double_val(v1);
	GLdouble lv2 = Double_val(v2);
	GLdouble lv3 = Double_val(v3);
	GLdouble lv4 = Double_val(v4);
	LOAD_FUNCTION(glMultiTexCoord4dARB);
	(*stub_glMultiTexCoord4dARB)(lv0, lv1, lv2, lv3, lv4);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glMultiTexCoord4dv,(GLenum, GLdouble*),void);
value glstub_glMultiTexCoord4dv(value v0, value v1)
{
	CAMLparam2(v0, v1);
	GLenum lv0 = Int_val(v0);
	GLdouble* lv1 = (Tag_val(v1) == Double_array_tag)? (double *)v1: Data_bigarray_val(v1);
	LOAD_FUNCTION(glMultiTexCoord4dv);
	(*stub_glMultiTexCoord4dv)(lv0, lv1);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glMultiTexCoord4dvARB,(GLenum, GLdouble*),void);
value glstub_glMultiTexCoord4dvARB(value v0, value v1)
{
	CAMLparam2(v0, v1);
	GLenum lv0 = Int_val(v0);
	GLdouble* lv1 = (Tag_val(v1) == Double_array_tag)? (double *)v1: Data_bigarray_val(v1);
	LOAD_FUNCTION(glMultiTexCoord4dvARB);
	(*stub_glMultiTexCoord4dvARB)(lv0, lv1);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glMultiTexCoord4f,(GLenum, GLfloat, GLfloat, GLfloat, GLfloat),void);
value glstub_glMultiTexCoord4f(value v0, value v1, value v2, value v3, value v4)
{
	CAMLparam5(v0, v1, v2, v3, v4);
	GLenum lv0 = Int_val(v0);
	GLfloat lv1 = Double_val(v1);
	GLfloat lv2 = Double_val(v2);
	GLfloat lv3 = Double_val(v3);
	GLfloat lv4 = Double_val(v4);
	LOAD_FUNCTION(glMultiTexCoord4f);
	(*stub_glMultiTexCoord4f)(lv0, lv1, lv2, lv3, lv4);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glMultiTexCoord4fARB,(GLenum, GLfloat, GLfloat, GLfloat, GLfloat),void);
value glstub_glMultiTexCoord4fARB(value v0, value v1, value v2, value v3, value v4)
{
	CAMLparam5(v0, v1, v2, v3, v4);
	GLenum lv0 = Int_val(v0);
	GLfloat lv1 = Double_val(v1);
	GLfloat lv2 = Double_val(v2);
	GLfloat lv3 = Double_val(v3);
	GLfloat lv4 = Double_val(v4);
	LOAD_FUNCTION(glMultiTexCoord4fARB);
	(*stub_glMultiTexCoord4fARB)(lv0, lv1, lv2, lv3, lv4);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glMultiTexCoord4fv,(GLenum, GLfloat*),void);
value glstub_glMultiTexCoord4fv(value v0, value v1)
{
	CAMLparam2(v0, v1);
	GLenum lv0 = Int_val(v0);
	GLfloat* lv1 = Data_bigarray_val(v1);
	LOAD_FUNCTION(glMultiTexCoord4fv);
	(*stub_glMultiTexCoord4fv)(lv0, lv1);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glMultiTexCoord4fvARB,(GLenum, GLfloat*),void);
value glstub_glMultiTexCoord4fvARB(value v0, value v1)
{
	CAMLparam2(v0, v1);
	GLenum lv0 = Int_val(v0);
	GLfloat* lv1 = Data_bigarray_val(v1);
	LOAD_FUNCTION(glMultiTexCoord4fvARB);
	(*stub_glMultiTexCoord4fvARB)(lv0, lv1);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glMultiTexCoord4hNV,(GLenum, GLushort, GLushort, GLushort, GLushort),void);
value glstub_glMultiTexCoord4hNV(value v0, value v1, value v2, value v3, value v4)
{
	CAMLparam5(v0, v1, v2, v3, v4);
	GLenum lv0 = Int_val(v0);
	GLushort lv1 = Int_val(v1);
	GLushort lv2 = Int_val(v2);
	GLushort lv3 = Int_val(v3);
	GLushort lv4 = Int_val(v4);
	LOAD_FUNCTION(glMultiTexCoord4hNV);
	(*stub_glMultiTexCoord4hNV)(lv0, lv1, lv2, lv3, lv4);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glMultiTexCoord4hvNV,(GLenum, GLushort*),void);
value glstub_glMultiTexCoord4hvNV(value v0, value v1)
{
	CAMLparam2(v0, v1);
	GLenum lv0 = Int_val(v0);
	GLushort* lv1 = Data_bigarray_val(v1);
	LOAD_FUNCTION(glMultiTexCoord4hvNV);
	(*stub_glMultiTexCoord4hvNV)(lv0, lv1);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glMultiTexCoord4i,(GLenum, GLint, GLint, GLint, GLint),void);
value glstub_glMultiTexCoord4i(value v0, value v1, value v2, value v3, value v4)
{
	CAMLparam5(v0, v1, v2, v3, v4);
	GLenum lv0 = Int_val(v0);
	GLint lv1 = Int_val(v1);
	GLint lv2 = Int_val(v2);
	GLint lv3 = Int_val(v3);
	GLint lv4 = Int_val(v4);
	LOAD_FUNCTION(glMultiTexCoord4i);
	(*stub_glMultiTexCoord4i)(lv0, lv1, lv2, lv3, lv4);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glMultiTexCoord4iARB,(GLenum, GLint, GLint, GLint, GLint),void);
value glstub_glMultiTexCoord4iARB(value v0, value v1, value v2, value v3, value v4)
{
	CAMLparam5(v0, v1, v2, v3, v4);
	GLenum lv0 = Int_val(v0);
	GLint lv1 = Int_val(v1);
	GLint lv2 = Int_val(v2);
	GLint lv3 = Int_val(v3);
	GLint lv4 = Int_val(v4);
	LOAD_FUNCTION(glMultiTexCoord4iARB);
	(*stub_glMultiTexCoord4iARB)(lv0, lv1, lv2, lv3, lv4);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glMultiTexCoord4iv,(GLenum, GLint*),void);
value glstub_glMultiTexCoord4iv(value v0, value v1)
{
	CAMLparam2(v0, v1);
	GLenum lv0 = Int_val(v0);
	GLint* lv1 = Data_bigarray_val(v1);
	LOAD_FUNCTION(glMultiTexCoord4iv);
	(*stub_glMultiTexCoord4iv)(lv0, lv1);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glMultiTexCoord4ivARB,(GLenum, GLint*),void);
value glstub_glMultiTexCoord4ivARB(value v0, value v1)
{
	CAMLparam2(v0, v1);
	GLenum lv0 = Int_val(v0);
	GLint* lv1 = Data_bigarray_val(v1);
	LOAD_FUNCTION(glMultiTexCoord4ivARB);
	(*stub_glMultiTexCoord4ivARB)(lv0, lv1);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glMultiTexCoord4s,(GLenum, GLshort, GLshort, GLshort, GLshort),void);
value glstub_glMultiTexCoord4s(value v0, value v1, value v2, value v3, value v4)
{
	CAMLparam5(v0, v1, v2, v3, v4);
	GLenum lv0 = Int_val(v0);
	GLshort lv1 = Int_val(v1);
	GLshort lv2 = Int_val(v2);
	GLshort lv3 = Int_val(v3);
	GLshort lv4 = Int_val(v4);
	LOAD_FUNCTION(glMultiTexCoord4s);
	(*stub_glMultiTexCoord4s)(lv0, lv1, lv2, lv3, lv4);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glMultiTexCoord4sARB,(GLenum, GLshort, GLshort, GLshort, GLshort),void);
value glstub_glMultiTexCoord4sARB(value v0, value v1, value v2, value v3, value v4)
{
	CAMLparam5(v0, v1, v2, v3, v4);
	GLenum lv0 = Int_val(v0);
	GLshort lv1 = Int_val(v1);
	GLshort lv2 = Int_val(v2);
	GLshort lv3 = Int_val(v3);
	GLshort lv4 = Int_val(v4);
	LOAD_FUNCTION(glMultiTexCoord4sARB);
	(*stub_glMultiTexCoord4sARB)(lv0, lv1, lv2, lv3, lv4);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glMultiTexCoord4sv,(GLenum, GLshort*),void);
value glstub_glMultiTexCoord4sv(value v0, value v1)
{
	CAMLparam2(v0, v1);
	GLenum lv0 = Int_val(v0);
	GLshort* lv1 = Data_bigarray_val(v1);
	LOAD_FUNCTION(glMultiTexCoord4sv);
	(*stub_glMultiTexCoord4sv)(lv0, lv1);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glMultiTexCoord4svARB,(GLenum, GLshort*),void);
value glstub_glMultiTexCoord4svARB(value v0, value v1)
{
	CAMLparam2(v0, v1);
	GLenum lv0 = Int_val(v0);
	GLshort* lv1 = Data_bigarray_val(v1);
	LOAD_FUNCTION(glMultiTexCoord4svARB);
	(*stub_glMultiTexCoord4svARB)(lv0, lv1);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glNewBufferRegionEXT,(GLenum),GLuint);
value glstub_glNewBufferRegionEXT(value v0)
{
	CAMLparam1(v0);
	CAMLlocal1(result);
	GLenum lv0 = Int_val(v0);
	GLuint ret;
	LOAD_FUNCTION(glNewBufferRegionEXT);
	ret = (*stub_glNewBufferRegionEXT)(lv0);
	result = Val_int(ret);
	CAMLreturn(result);
}

DECLARE_FUNCTION(glNewList,(GLuint, GLenum),void);
value glstub_glNewList(value v0, value v1)
{
	CAMLparam2(v0, v1);
	GLuint lv0 = Int_val(v0);
	GLenum lv1 = Int_val(v1);
	LOAD_FUNCTION(glNewList);
	(*stub_glNewList)(lv0, lv1);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glNewObjectBufferATI,(GLsizei, GLvoid*, GLenum),GLuint);
value glstub_glNewObjectBufferATI(value v0, value v1, value v2)
{
	CAMLparam3(v0, v1, v2);
	CAMLlocal1(result);
	GLsizei lv0 = Int_val(v0);
	GLvoid* lv1 = (GLvoid *)((Tag_val(v1) == String_tag)? (String_val(v1)) : (Data_bigarray_val(v1)));
	GLenum lv2 = Int_val(v2);
	GLuint ret;
	LOAD_FUNCTION(glNewObjectBufferATI);
	ret = (*stub_glNewObjectBufferATI)(lv0, lv1, lv2);
	result = Val_int(ret);
	CAMLreturn(result);
}

DECLARE_FUNCTION(glNormal3b,(GLbyte, GLbyte, GLbyte),void);
value glstub_glNormal3b(value v0, value v1, value v2)
{
	CAMLparam3(v0, v1, v2);
	GLbyte lv0 = Int_val(v0);
	GLbyte lv1 = Int_val(v1);
	GLbyte lv2 = Int_val(v2);
	LOAD_FUNCTION(glNormal3b);
	(*stub_glNormal3b)(lv0, lv1, lv2);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glNormal3bv,(GLbyte*),void);
value glstub_glNormal3bv(value v0)
{
	CAMLparam1(v0);
	GLbyte* lv0 = Data_bigarray_val(v0);
	LOAD_FUNCTION(glNormal3bv);
	(*stub_glNormal3bv)(lv0);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glNormal3d,(GLdouble, GLdouble, GLdouble),void);
value glstub_glNormal3d(value v0, value v1, value v2)
{
	CAMLparam3(v0, v1, v2);
	GLdouble lv0 = Double_val(v0);
	GLdouble lv1 = Double_val(v1);
	GLdouble lv2 = Double_val(v2);
	LOAD_FUNCTION(glNormal3d);
	(*stub_glNormal3d)(lv0, lv1, lv2);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glNormal3dv,(GLdouble*),void);
value glstub_glNormal3dv(value v0)
{
	CAMLparam1(v0);
	GLdouble* lv0 = (Tag_val(v0) == Double_array_tag)? (double *)v0: Data_bigarray_val(v0);
	LOAD_FUNCTION(glNormal3dv);
	(*stub_glNormal3dv)(lv0);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glNormal3f,(GLfloat, GLfloat, GLfloat),void);
value glstub_glNormal3f(value v0, value v1, value v2)
{
	CAMLparam3(v0, v1, v2);
	GLfloat lv0 = Double_val(v0);
	GLfloat lv1 = Double_val(v1);
	GLfloat lv2 = Double_val(v2);
	LOAD_FUNCTION(glNormal3f);
	(*stub_glNormal3f)(lv0, lv1, lv2);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glNormal3fVertex3fSUN,(GLfloat, GLfloat, GLfloat, GLfloat, GLfloat, GLfloat),void);
value glstub_glNormal3fVertex3fSUN(value v0, value v1, value v2, value v3, value v4, value v5)
{
	CAMLparam5(v0, v1, v2, v3, v4);
	CAMLxparam1(v5);
	GLfloat lv0 = Double_val(v0);
	GLfloat lv1 = Double_val(v1);
	GLfloat lv2 = Double_val(v2);
	GLfloat lv3 = Double_val(v3);
	GLfloat lv4 = Double_val(v4);
	GLfloat lv5 = Double_val(v5);
	LOAD_FUNCTION(glNormal3fVertex3fSUN);
	(*stub_glNormal3fVertex3fSUN)(lv0, lv1, lv2, lv3, lv4, lv5);
	CAMLreturn(Val_unit);
}

value glstub_glNormal3fVertex3fSUN_byte(value * argv, int n)
{
	return glstub_glNormal3fVertex3fSUN(argv[0], argv[1], argv[2], argv[3], argv[4], argv[5]);
}

DECLARE_FUNCTION(glNormal3fVertex3fvSUN,(GLfloat*, GLfloat*),void);
value glstub_glNormal3fVertex3fvSUN(value v0, value v1)
{
	CAMLparam2(v0, v1);
	GLfloat* lv0 = Data_bigarray_val(v0);
	GLfloat* lv1 = Data_bigarray_val(v1);
	LOAD_FUNCTION(glNormal3fVertex3fvSUN);
	(*stub_glNormal3fVertex3fvSUN)(lv0, lv1);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glNormal3fv,(GLfloat*),void);
value glstub_glNormal3fv(value v0)
{
	CAMLparam1(v0);
	GLfloat* lv0 = Data_bigarray_val(v0);
	LOAD_FUNCTION(glNormal3fv);
	(*stub_glNormal3fv)(lv0);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glNormal3hNV,(GLushort, GLushort, GLushort),void);
value glstub_glNormal3hNV(value v0, value v1, value v2)
{
	CAMLparam3(v0, v1, v2);
	GLushort lv0 = Int_val(v0);
	GLushort lv1 = Int_val(v1);
	GLushort lv2 = Int_val(v2);
	LOAD_FUNCTION(glNormal3hNV);
	(*stub_glNormal3hNV)(lv0, lv1, lv2);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glNormal3hvNV,(GLushort*),void);
value glstub_glNormal3hvNV(value v0)
{
	CAMLparam1(v0);
	GLushort* lv0 = Data_bigarray_val(v0);
	LOAD_FUNCTION(glNormal3hvNV);
	(*stub_glNormal3hvNV)(lv0);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glNormal3i,(GLint, GLint, GLint),void);
value glstub_glNormal3i(value v0, value v1, value v2)
{
	CAMLparam3(v0, v1, v2);
	GLint lv0 = Int_val(v0);
	GLint lv1 = Int_val(v1);
	GLint lv2 = Int_val(v2);
	LOAD_FUNCTION(glNormal3i);
	(*stub_glNormal3i)(lv0, lv1, lv2);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glNormal3iv,(GLint*),void);
value glstub_glNormal3iv(value v0)
{
	CAMLparam1(v0);
	GLint* lv0 = Data_bigarray_val(v0);
	LOAD_FUNCTION(glNormal3iv);
	(*stub_glNormal3iv)(lv0);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glNormal3s,(GLshort, GLshort, GLshort),void);
value glstub_glNormal3s(value v0, value v1, value v2)
{
	CAMLparam3(v0, v1, v2);
	GLshort lv0 = Int_val(v0);
	GLshort lv1 = Int_val(v1);
	GLshort lv2 = Int_val(v2);
	LOAD_FUNCTION(glNormal3s);
	(*stub_glNormal3s)(lv0, lv1, lv2);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glNormal3sv,(GLshort*),void);
value glstub_glNormal3sv(value v0)
{
	CAMLparam1(v0);
	GLshort* lv0 = Data_bigarray_val(v0);
	LOAD_FUNCTION(glNormal3sv);
	(*stub_glNormal3sv)(lv0);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glNormalPointer,(GLenum, GLsizei, GLvoid*),void);
value glstub_glNormalPointer(value v0, value v1, value v2)
{
	CAMLparam3(v0, v1, v2);
	GLenum lv0 = Int_val(v0);
	GLsizei lv1 = Int_val(v1);
	GLvoid* lv2 = (GLvoid *)((Tag_val(v2) == String_tag)? (String_val(v2)) : (Data_bigarray_val(v2)));
	LOAD_FUNCTION(glNormalPointer);
	(*stub_glNormalPointer)(lv0, lv1, lv2);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glNormalPointerEXT,(GLenum, GLsizei, GLsizei, GLvoid*),void);
value glstub_glNormalPointerEXT(value v0, value v1, value v2, value v3)
{
	CAMLparam4(v0, v1, v2, v3);
	GLenum lv0 = Int_val(v0);
	GLsizei lv1 = Int_val(v1);
	GLsizei lv2 = Int_val(v2);
	GLvoid* lv3 = (GLvoid *)((Tag_val(v3) == String_tag)? (String_val(v3)) : (Data_bigarray_val(v3)));
	LOAD_FUNCTION(glNormalPointerEXT);
	(*stub_glNormalPointerEXT)(lv0, lv1, lv2, lv3);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glNormalPointerListIBM,(GLenum, GLint, GLvoid**, GLint),void);
value glstub_glNormalPointerListIBM(value v0, value v1, value v2, value v3)
{
	CAMLparam4(v0, v1, v2, v3);
	GLenum lv0 = Int_val(v0);
	GLint lv1 = Int_val(v1);
	GLvoid** lv2 = Data_bigarray_val(v2);
	GLint lv3 = Int_val(v3);
	LOAD_FUNCTION(glNormalPointerListIBM);
	(*stub_glNormalPointerListIBM)(lv0, lv1, lv2, lv3);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glNormalPointervINTEL,(GLenum, GLvoid**),void);
value glstub_glNormalPointervINTEL(value v0, value v1)
{
	CAMLparam2(v0, v1);
	GLenum lv0 = Int_val(v0);
	GLvoid** lv1 = Data_bigarray_val(v1);
	LOAD_FUNCTION(glNormalPointervINTEL);
	(*stub_glNormalPointervINTEL)(lv0, lv1);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glNormalStream3bATI,(GLenum, GLbyte, GLbyte, GLbyte),void);
value glstub_glNormalStream3bATI(value v0, value v1, value v2, value v3)
{
	CAMLparam4(v0, v1, v2, v3);
	GLenum lv0 = Int_val(v0);
	GLbyte lv1 = Int_val(v1);
	GLbyte lv2 = Int_val(v2);
	GLbyte lv3 = Int_val(v3);
	LOAD_FUNCTION(glNormalStream3bATI);
	(*stub_glNormalStream3bATI)(lv0, lv1, lv2, lv3);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glNormalStream3bvATI,(GLenum, GLbyte*),void);
value glstub_glNormalStream3bvATI(value v0, value v1)
{
	CAMLparam2(v0, v1);
	GLenum lv0 = Int_val(v0);
	GLbyte* lv1 = Data_bigarray_val(v1);
	LOAD_FUNCTION(glNormalStream3bvATI);
	(*stub_glNormalStream3bvATI)(lv0, lv1);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glNormalStream3dATI,(GLenum, GLdouble, GLdouble, GLdouble),void);
value glstub_glNormalStream3dATI(value v0, value v1, value v2, value v3)
{
	CAMLparam4(v0, v1, v2, v3);
	GLenum lv0 = Int_val(v0);
	GLdouble lv1 = Double_val(v1);
	GLdouble lv2 = Double_val(v2);
	GLdouble lv3 = Double_val(v3);
	LOAD_FUNCTION(glNormalStream3dATI);
	(*stub_glNormalStream3dATI)(lv0, lv1, lv2, lv3);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glNormalStream3dvATI,(GLenum, GLdouble*),void);
value glstub_glNormalStream3dvATI(value v0, value v1)
{
	CAMLparam2(v0, v1);
	GLenum lv0 = Int_val(v0);
	GLdouble* lv1 = (Tag_val(v1) == Double_array_tag)? (double *)v1: Data_bigarray_val(v1);
	LOAD_FUNCTION(glNormalStream3dvATI);
	(*stub_glNormalStream3dvATI)(lv0, lv1);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glNormalStream3fATI,(GLenum, GLfloat, GLfloat, GLfloat),void);
value glstub_glNormalStream3fATI(value v0, value v1, value v2, value v3)
{
	CAMLparam4(v0, v1, v2, v3);
	GLenum lv0 = Int_val(v0);
	GLfloat lv1 = Double_val(v1);
	GLfloat lv2 = Double_val(v2);
	GLfloat lv3 = Double_val(v3);
	LOAD_FUNCTION(glNormalStream3fATI);
	(*stub_glNormalStream3fATI)(lv0, lv1, lv2, lv3);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glNormalStream3fvATI,(GLenum, GLfloat*),void);
value glstub_glNormalStream3fvATI(value v0, value v1)
{
	CAMLparam2(v0, v1);
	GLenum lv0 = Int_val(v0);
	GLfloat* lv1 = Data_bigarray_val(v1);
	LOAD_FUNCTION(glNormalStream3fvATI);
	(*stub_glNormalStream3fvATI)(lv0, lv1);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glNormalStream3iATI,(GLenum, GLint, GLint, GLint),void);
value glstub_glNormalStream3iATI(value v0, value v1, value v2, value v3)
{
	CAMLparam4(v0, v1, v2, v3);
	GLenum lv0 = Int_val(v0);
	GLint lv1 = Int_val(v1);
	GLint lv2 = Int_val(v2);
	GLint lv3 = Int_val(v3);
	LOAD_FUNCTION(glNormalStream3iATI);
	(*stub_glNormalStream3iATI)(lv0, lv1, lv2, lv3);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glNormalStream3ivATI,(GLenum, GLint*),void);
value glstub_glNormalStream3ivATI(value v0, value v1)
{
	CAMLparam2(v0, v1);
	GLenum lv0 = Int_val(v0);
	GLint* lv1 = Data_bigarray_val(v1);
	LOAD_FUNCTION(glNormalStream3ivATI);
	(*stub_glNormalStream3ivATI)(lv0, lv1);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glNormalStream3sATI,(GLenum, GLshort, GLshort, GLshort),void);
value glstub_glNormalStream3sATI(value v0, value v1, value v2, value v3)
{
	CAMLparam4(v0, v1, v2, v3);
	GLenum lv0 = Int_val(v0);
	GLshort lv1 = Int_val(v1);
	GLshort lv2 = Int_val(v2);
	GLshort lv3 = Int_val(v3);
	LOAD_FUNCTION(glNormalStream3sATI);
	(*stub_glNormalStream3sATI)(lv0, lv1, lv2, lv3);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glNormalStream3svATI,(GLenum, GLshort*),void);
value glstub_glNormalStream3svATI(value v0, value v1)
{
	CAMLparam2(v0, v1);
	GLenum lv0 = Int_val(v0);
	GLshort* lv1 = Data_bigarray_val(v1);
	LOAD_FUNCTION(glNormalStream3svATI);
	(*stub_glNormalStream3svATI)(lv0, lv1);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glOrtho,(GLdouble, GLdouble, GLdouble, GLdouble, GLdouble, GLdouble),void);
value glstub_glOrtho(value v0, value v1, value v2, value v3, value v4, value v5)
{
	CAMLparam5(v0, v1, v2, v3, v4);
	CAMLxparam1(v5);
	GLdouble lv0 = Double_val(v0);
	GLdouble lv1 = Double_val(v1);
	GLdouble lv2 = Double_val(v2);
	GLdouble lv3 = Double_val(v3);
	GLdouble lv4 = Double_val(v4);
	GLdouble lv5 = Double_val(v5);
	LOAD_FUNCTION(glOrtho);
	(*stub_glOrtho)(lv0, lv1, lv2, lv3, lv4, lv5);
	CAMLreturn(Val_unit);
}

value glstub_glOrtho_byte(value * argv, int n)
{
	return glstub_glOrtho(argv[0], argv[1], argv[2], argv[3], argv[4], argv[5]);
}

DECLARE_FUNCTION(glOrthofOES,(GLfloat, GLfloat, GLfloat, GLfloat, GLfloat, GLfloat),void);
value glstub_glOrthofOES(value v0, value v1, value v2, value v3, value v4, value v5)
{
	CAMLparam5(v0, v1, v2, v3, v4);
	CAMLxparam1(v5);
	GLfloat lv0 = Double_val(v0);
	GLfloat lv1 = Double_val(v1);
	GLfloat lv2 = Double_val(v2);
	GLfloat lv3 = Double_val(v3);
	GLfloat lv4 = Double_val(v4);
	GLfloat lv5 = Double_val(v5);
	LOAD_FUNCTION(glOrthofOES);
	(*stub_glOrthofOES)(lv0, lv1, lv2, lv3, lv4, lv5);
	CAMLreturn(Val_unit);
}

value glstub_glOrthofOES_byte(value * argv, int n)
{
	return glstub_glOrthofOES(argv[0], argv[1], argv[2], argv[3], argv[4], argv[5]);
}

DECLARE_FUNCTION(glPNTrianglesfATI,(GLenum, GLfloat),void);
value glstub_glPNTrianglesfATI(value v0, value v1)
{
	CAMLparam2(v0, v1);
	GLenum lv0 = Int_val(v0);
	GLfloat lv1 = Double_val(v1);
	LOAD_FUNCTION(glPNTrianglesfATI);
	(*stub_glPNTrianglesfATI)(lv0, lv1);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glPNTrianglesiATI,(GLenum, GLint),void);
value glstub_glPNTrianglesiATI(value v0, value v1)
{
	CAMLparam2(v0, v1);
	GLenum lv0 = Int_val(v0);
	GLint lv1 = Int_val(v1);
	LOAD_FUNCTION(glPNTrianglesiATI);
	(*stub_glPNTrianglesiATI)(lv0, lv1);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glPassTexCoordATI,(GLuint, GLuint, GLenum),void);
value glstub_glPassTexCoordATI(value v0, value v1, value v2)
{
	CAMLparam3(v0, v1, v2);
	GLuint lv0 = Int_val(v0);
	GLuint lv1 = Int_val(v1);
	GLenum lv2 = Int_val(v2);
	LOAD_FUNCTION(glPassTexCoordATI);
	(*stub_glPassTexCoordATI)(lv0, lv1, lv2);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glPassThrough,(GLfloat),void);
value glstub_glPassThrough(value v0)
{
	CAMLparam1(v0);
	GLfloat lv0 = Double_val(v0);
	LOAD_FUNCTION(glPassThrough);
	(*stub_glPassThrough)(lv0);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glPixelDataRangeNV,(GLenum, GLsizei, GLvoid*),void);
value glstub_glPixelDataRangeNV(value v0, value v1, value v2)
{
	CAMLparam3(v0, v1, v2);
	GLenum lv0 = Int_val(v0);
	GLsizei lv1 = Int_val(v1);
	GLvoid* lv2 = (GLvoid *)((Tag_val(v2) == String_tag)? (String_val(v2)) : (Data_bigarray_val(v2)));
	LOAD_FUNCTION(glPixelDataRangeNV);
	(*stub_glPixelDataRangeNV)(lv0, lv1, lv2);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glPixelMapfv,(GLenum, GLsizei, GLfloat*),void);
value glstub_glPixelMapfv(value v0, value v1, value v2)
{
	CAMLparam3(v0, v1, v2);
	GLenum lv0 = Int_val(v0);
	GLsizei lv1 = Int_val(v1);
	GLfloat* lv2 = Data_bigarray_val(v2);
	LOAD_FUNCTION(glPixelMapfv);
	(*stub_glPixelMapfv)(lv0, lv1, lv2);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glPixelMapuiv,(GLenum, GLsizei, GLuint*),void);
value glstub_glPixelMapuiv(value v0, value v1, value v2)
{
	CAMLparam3(v0, v1, v2);
	GLenum lv0 = Int_val(v0);
	GLsizei lv1 = Int_val(v1);
	GLuint* lv2 = Data_bigarray_val(v2);
	LOAD_FUNCTION(glPixelMapuiv);
	(*stub_glPixelMapuiv)(lv0, lv1, lv2);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glPixelMapusv,(GLenum, GLsizei, GLushort*),void);
value glstub_glPixelMapusv(value v0, value v1, value v2)
{
	CAMLparam3(v0, v1, v2);
	GLenum lv0 = Int_val(v0);
	GLsizei lv1 = Int_val(v1);
	GLushort* lv2 = Data_bigarray_val(v2);
	LOAD_FUNCTION(glPixelMapusv);
	(*stub_glPixelMapusv)(lv0, lv1, lv2);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glPixelStoref,(GLenum, GLfloat),void);
value glstub_glPixelStoref(value v0, value v1)
{
	CAMLparam2(v0, v1);
	GLenum lv0 = Int_val(v0);
	GLfloat lv1 = Double_val(v1);
	LOAD_FUNCTION(glPixelStoref);
	(*stub_glPixelStoref)(lv0, lv1);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glPixelStorei,(GLenum, GLint),void);
value glstub_glPixelStorei(value v0, value v1)
{
	CAMLparam2(v0, v1);
	GLenum lv0 = Int_val(v0);
	GLint lv1 = Int_val(v1);
	LOAD_FUNCTION(glPixelStorei);
	(*stub_glPixelStorei)(lv0, lv1);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glPixelTexGenSGIX,(GLenum),void);
value glstub_glPixelTexGenSGIX(value v0)
{
	CAMLparam1(v0);
	GLenum lv0 = Int_val(v0);
	LOAD_FUNCTION(glPixelTexGenSGIX);
	(*stub_glPixelTexGenSGIX)(lv0);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glPixelTransferf,(GLenum, GLfloat),void);
value glstub_glPixelTransferf(value v0, value v1)
{
	CAMLparam2(v0, v1);
	GLenum lv0 = Int_val(v0);
	GLfloat lv1 = Double_val(v1);
	LOAD_FUNCTION(glPixelTransferf);
	(*stub_glPixelTransferf)(lv0, lv1);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glPixelTransferi,(GLenum, GLint),void);
value glstub_glPixelTransferi(value v0, value v1)
{
	CAMLparam2(v0, v1);
	GLenum lv0 = Int_val(v0);
	GLint lv1 = Int_val(v1);
	LOAD_FUNCTION(glPixelTransferi);
	(*stub_glPixelTransferi)(lv0, lv1);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glPixelTransformParameterfEXT,(GLenum, GLenum, GLfloat),void);
value glstub_glPixelTransformParameterfEXT(value v0, value v1, value v2)
{
	CAMLparam3(v0, v1, v2);
	GLenum lv0 = Int_val(v0);
	GLenum lv1 = Int_val(v1);
	GLfloat lv2 = Double_val(v2);
	LOAD_FUNCTION(glPixelTransformParameterfEXT);
	(*stub_glPixelTransformParameterfEXT)(lv0, lv1, lv2);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glPixelTransformParameterfvEXT,(GLenum, GLenum, GLfloat*),void);
value glstub_glPixelTransformParameterfvEXT(value v0, value v1, value v2)
{
	CAMLparam3(v0, v1, v2);
	GLenum lv0 = Int_val(v0);
	GLenum lv1 = Int_val(v1);
	GLfloat* lv2 = Data_bigarray_val(v2);
	LOAD_FUNCTION(glPixelTransformParameterfvEXT);
	(*stub_glPixelTransformParameterfvEXT)(lv0, lv1, lv2);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glPixelTransformParameteriEXT,(GLenum, GLenum, GLint),void);
value glstub_glPixelTransformParameteriEXT(value v0, value v1, value v2)
{
	CAMLparam3(v0, v1, v2);
	GLenum lv0 = Int_val(v0);
	GLenum lv1 = Int_val(v1);
	GLint lv2 = Int_val(v2);
	LOAD_FUNCTION(glPixelTransformParameteriEXT);
	(*stub_glPixelTransformParameteriEXT)(lv0, lv1, lv2);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glPixelTransformParameterivEXT,(GLenum, GLenum, GLint*),void);
value glstub_glPixelTransformParameterivEXT(value v0, value v1, value v2)
{
	CAMLparam3(v0, v1, v2);
	GLenum lv0 = Int_val(v0);
	GLenum lv1 = Int_val(v1);
	GLint* lv2 = Data_bigarray_val(v2);
	LOAD_FUNCTION(glPixelTransformParameterivEXT);
	(*stub_glPixelTransformParameterivEXT)(lv0, lv1, lv2);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glPixelZoom,(GLfloat, GLfloat),void);
value glstub_glPixelZoom(value v0, value v1)
{
	CAMLparam2(v0, v1);
	GLfloat lv0 = Double_val(v0);
	GLfloat lv1 = Double_val(v1);
	LOAD_FUNCTION(glPixelZoom);
	(*stub_glPixelZoom)(lv0, lv1);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glPointParameterf,(GLenum, GLfloat),void);
value glstub_glPointParameterf(value v0, value v1)
{
	CAMLparam2(v0, v1);
	GLenum lv0 = Int_val(v0);
	GLfloat lv1 = Double_val(v1);
	LOAD_FUNCTION(glPointParameterf);
	(*stub_glPointParameterf)(lv0, lv1);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glPointParameterfARB,(GLenum, GLfloat),void);
value glstub_glPointParameterfARB(value v0, value v1)
{
	CAMLparam2(v0, v1);
	GLenum lv0 = Int_val(v0);
	GLfloat lv1 = Double_val(v1);
	LOAD_FUNCTION(glPointParameterfARB);
	(*stub_glPointParameterfARB)(lv0, lv1);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glPointParameterfEXT,(GLenum, GLfloat),void);
value glstub_glPointParameterfEXT(value v0, value v1)
{
	CAMLparam2(v0, v1);
	GLenum lv0 = Int_val(v0);
	GLfloat lv1 = Double_val(v1);
	LOAD_FUNCTION(glPointParameterfEXT);
	(*stub_glPointParameterfEXT)(lv0, lv1);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glPointParameterfv,(GLenum, GLfloat*),void);
value glstub_glPointParameterfv(value v0, value v1)
{
	CAMLparam2(v0, v1);
	GLenum lv0 = Int_val(v0);
	GLfloat* lv1 = Data_bigarray_val(v1);
	LOAD_FUNCTION(glPointParameterfv);
	(*stub_glPointParameterfv)(lv0, lv1);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glPointParameterfvARB,(GLenum, GLfloat*),void);
value glstub_glPointParameterfvARB(value v0, value v1)
{
	CAMLparam2(v0, v1);
	GLenum lv0 = Int_val(v0);
	GLfloat* lv1 = Data_bigarray_val(v1);
	LOAD_FUNCTION(glPointParameterfvARB);
	(*stub_glPointParameterfvARB)(lv0, lv1);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glPointParameterfvEXT,(GLenum, GLfloat*),void);
value glstub_glPointParameterfvEXT(value v0, value v1)
{
	CAMLparam2(v0, v1);
	GLenum lv0 = Int_val(v0);
	GLfloat* lv1 = Data_bigarray_val(v1);
	LOAD_FUNCTION(glPointParameterfvEXT);
	(*stub_glPointParameterfvEXT)(lv0, lv1);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glPointParameteriNV,(GLenum, GLint),void);
value glstub_glPointParameteriNV(value v0, value v1)
{
	CAMLparam2(v0, v1);
	GLenum lv0 = Int_val(v0);
	GLint lv1 = Int_val(v1);
	LOAD_FUNCTION(glPointParameteriNV);
	(*stub_glPointParameteriNV)(lv0, lv1);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glPointParameterivNV,(GLenum, GLint*),void);
value glstub_glPointParameterivNV(value v0, value v1)
{
	CAMLparam2(v0, v1);
	GLenum lv0 = Int_val(v0);
	GLint* lv1 = Data_bigarray_val(v1);
	LOAD_FUNCTION(glPointParameterivNV);
	(*stub_glPointParameterivNV)(lv0, lv1);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glPointSize,(GLfloat),void);
value glstub_glPointSize(value v0)
{
	CAMLparam1(v0);
	GLfloat lv0 = Double_val(v0);
	LOAD_FUNCTION(glPointSize);
	(*stub_glPointSize)(lv0);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glPollAsyncSGIX,(GLuint*),GLint);
value glstub_glPollAsyncSGIX(value v0)
{
	CAMLparam1(v0);
	CAMLlocal1(result);
	GLuint* lv0 = Data_bigarray_val(v0);
	GLint ret;
	LOAD_FUNCTION(glPollAsyncSGIX);
	ret = (*stub_glPollAsyncSGIX)(lv0);
	result = Val_int(ret);
	CAMLreturn(result);
}

DECLARE_FUNCTION(glPolygonMode,(GLenum, GLenum),void);
value glstub_glPolygonMode(value v0, value v1)
{
	CAMLparam2(v0, v1);
	GLenum lv0 = Int_val(v0);
	GLenum lv1 = Int_val(v1);
	LOAD_FUNCTION(glPolygonMode);
	(*stub_glPolygonMode)(lv0, lv1);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glPolygonOffset,(GLfloat, GLfloat),void);
value glstub_glPolygonOffset(value v0, value v1)
{
	CAMLparam2(v0, v1);
	GLfloat lv0 = Double_val(v0);
	GLfloat lv1 = Double_val(v1);
	LOAD_FUNCTION(glPolygonOffset);
	(*stub_glPolygonOffset)(lv0, lv1);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glPolygonOffsetEXT,(GLfloat, GLfloat),void);
value glstub_glPolygonOffsetEXT(value v0, value v1)
{
	CAMLparam2(v0, v1);
	GLfloat lv0 = Double_val(v0);
	GLfloat lv1 = Double_val(v1);
	LOAD_FUNCTION(glPolygonOffsetEXT);
	(*stub_glPolygonOffsetEXT)(lv0, lv1);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glPolygonStipple,(GLubyte*),void);
value glstub_glPolygonStipple(value v0)
{
	CAMLparam1(v0);
	GLubyte* lv0 = Data_bigarray_val(v0);
	LOAD_FUNCTION(glPolygonStipple);
	(*stub_glPolygonStipple)(lv0);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glPopAttrib,(void),void);
value glstub_glPopAttrib(value v0)
{
	CAMLparam1(v0);
	LOAD_FUNCTION(glPopAttrib);
	(*stub_glPopAttrib)();
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glPopClientAttrib,(void),void);
value glstub_glPopClientAttrib(value v0)
{
	CAMLparam1(v0);
	LOAD_FUNCTION(glPopClientAttrib);
	(*stub_glPopClientAttrib)();
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glPopMatrix,(void),void);
value glstub_glPopMatrix(value v0)
{
	CAMLparam1(v0);
	LOAD_FUNCTION(glPopMatrix);
	(*stub_glPopMatrix)();
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glPopName,(void),void);
value glstub_glPopName(value v0)
{
	CAMLparam1(v0);
	LOAD_FUNCTION(glPopName);
	(*stub_glPopName)();
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glPrimitiveRestartIndexNV,(GLuint),void);
value glstub_glPrimitiveRestartIndexNV(value v0)
{
	CAMLparam1(v0);
	GLuint lv0 = Int_val(v0);
	LOAD_FUNCTION(glPrimitiveRestartIndexNV);
	(*stub_glPrimitiveRestartIndexNV)(lv0);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glPrimitiveRestartNV,(void),void);
value glstub_glPrimitiveRestartNV(value v0)
{
	CAMLparam1(v0);
	LOAD_FUNCTION(glPrimitiveRestartNV);
	(*stub_glPrimitiveRestartNV)();
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glPrioritizeTextures,(GLsizei, GLuint*, GLclampf*),void);
value glstub_glPrioritizeTextures(value v0, value v1, value v2)
{
	CAMLparam3(v0, v1, v2);
	GLsizei lv0 = Int_val(v0);
	GLuint* lv1 = Data_bigarray_val(v1);
	GLclampf* lv2 = Data_bigarray_val(v2);
	LOAD_FUNCTION(glPrioritizeTextures);
	(*stub_glPrioritizeTextures)(lv0, lv1, lv2);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glPrioritizeTexturesEXT,(GLsizei, GLuint*, GLclampf*),void);
value glstub_glPrioritizeTexturesEXT(value v0, value v1, value v2)
{
	CAMLparam3(v0, v1, v2);
	GLsizei lv0 = Int_val(v0);
	GLuint* lv1 = Data_bigarray_val(v1);
	GLclampf* lv2 = Data_bigarray_val(v2);
	LOAD_FUNCTION(glPrioritizeTexturesEXT);
	(*stub_glPrioritizeTexturesEXT)(lv0, lv1, lv2);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glProgramBufferParametersIivNV,(GLenum, GLuint, GLuint, GLsizei, GLint*),void);
value glstub_glProgramBufferParametersIivNV(value v0, value v1, value v2, value v3, value v4)
{
	CAMLparam5(v0, v1, v2, v3, v4);
	GLenum lv0 = Int_val(v0);
	GLuint lv1 = Int_val(v1);
	GLuint lv2 = Int_val(v2);
	GLsizei lv3 = Int_val(v3);
	GLint* lv4 = Data_bigarray_val(v4);
	LOAD_FUNCTION(glProgramBufferParametersIivNV);
	(*stub_glProgramBufferParametersIivNV)(lv0, lv1, lv2, lv3, lv4);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glProgramBufferParametersIuivNV,(GLenum, GLuint, GLuint, GLsizei, GLuint*),void);
value glstub_glProgramBufferParametersIuivNV(value v0, value v1, value v2, value v3, value v4)
{
	CAMLparam5(v0, v1, v2, v3, v4);
	GLenum lv0 = Int_val(v0);
	GLuint lv1 = Int_val(v1);
	GLuint lv2 = Int_val(v2);
	GLsizei lv3 = Int_val(v3);
	GLuint* lv4 = Data_bigarray_val(v4);
	LOAD_FUNCTION(glProgramBufferParametersIuivNV);
	(*stub_glProgramBufferParametersIuivNV)(lv0, lv1, lv2, lv3, lv4);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glProgramBufferParametersfvNV,(GLenum, GLuint, GLuint, GLsizei, GLfloat*),void);
value glstub_glProgramBufferParametersfvNV(value v0, value v1, value v2, value v3, value v4)
{
	CAMLparam5(v0, v1, v2, v3, v4);
	GLenum lv0 = Int_val(v0);
	GLuint lv1 = Int_val(v1);
	GLuint lv2 = Int_val(v2);
	GLsizei lv3 = Int_val(v3);
	GLfloat* lv4 = Data_bigarray_val(v4);
	LOAD_FUNCTION(glProgramBufferParametersfvNV);
	(*stub_glProgramBufferParametersfvNV)(lv0, lv1, lv2, lv3, lv4);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glProgramEnvParameter4dARB,(GLenum, GLuint, GLdouble, GLdouble, GLdouble, GLdouble),void);
value glstub_glProgramEnvParameter4dARB(value v0, value v1, value v2, value v3, value v4, value v5)
{
	CAMLparam5(v0, v1, v2, v3, v4);
	CAMLxparam1(v5);
	GLenum lv0 = Int_val(v0);
	GLuint lv1 = Int_val(v1);
	GLdouble lv2 = Double_val(v2);
	GLdouble lv3 = Double_val(v3);
	GLdouble lv4 = Double_val(v4);
	GLdouble lv5 = Double_val(v5);
	LOAD_FUNCTION(glProgramEnvParameter4dARB);
	(*stub_glProgramEnvParameter4dARB)(lv0, lv1, lv2, lv3, lv4, lv5);
	CAMLreturn(Val_unit);
}

value glstub_glProgramEnvParameter4dARB_byte(value * argv, int n)
{
	return glstub_glProgramEnvParameter4dARB(argv[0], argv[1], argv[2], argv[3], argv[4], argv[5]);
}

DECLARE_FUNCTION(glProgramEnvParameter4dvARB,(GLenum, GLuint, GLdouble*),void);
value glstub_glProgramEnvParameter4dvARB(value v0, value v1, value v2)
{
	CAMLparam3(v0, v1, v2);
	GLenum lv0 = Int_val(v0);
	GLuint lv1 = Int_val(v1);
	GLdouble* lv2 = (Tag_val(v2) == Double_array_tag)? (double *)v2: Data_bigarray_val(v2);
	LOAD_FUNCTION(glProgramEnvParameter4dvARB);
	(*stub_glProgramEnvParameter4dvARB)(lv0, lv1, lv2);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glProgramEnvParameter4fARB,(GLenum, GLuint, GLfloat, GLfloat, GLfloat, GLfloat),void);
value glstub_glProgramEnvParameter4fARB(value v0, value v1, value v2, value v3, value v4, value v5)
{
	CAMLparam5(v0, v1, v2, v3, v4);
	CAMLxparam1(v5);
	GLenum lv0 = Int_val(v0);
	GLuint lv1 = Int_val(v1);
	GLfloat lv2 = Double_val(v2);
	GLfloat lv3 = Double_val(v3);
	GLfloat lv4 = Double_val(v4);
	GLfloat lv5 = Double_val(v5);
	LOAD_FUNCTION(glProgramEnvParameter4fARB);
	(*stub_glProgramEnvParameter4fARB)(lv0, lv1, lv2, lv3, lv4, lv5);
	CAMLreturn(Val_unit);
}

value glstub_glProgramEnvParameter4fARB_byte(value * argv, int n)
{
	return glstub_glProgramEnvParameter4fARB(argv[0], argv[1], argv[2], argv[3], argv[4], argv[5]);
}

DECLARE_FUNCTION(glProgramEnvParameter4fvARB,(GLenum, GLuint, GLfloat*),void);
value glstub_glProgramEnvParameter4fvARB(value v0, value v1, value v2)
{
	CAMLparam3(v0, v1, v2);
	GLenum lv0 = Int_val(v0);
	GLuint lv1 = Int_val(v1);
	GLfloat* lv2 = Data_bigarray_val(v2);
	LOAD_FUNCTION(glProgramEnvParameter4fvARB);
	(*stub_glProgramEnvParameter4fvARB)(lv0, lv1, lv2);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glProgramEnvParameterI4iNV,(GLenum, GLuint, GLint, GLint, GLint, GLint),void);
value glstub_glProgramEnvParameterI4iNV(value v0, value v1, value v2, value v3, value v4, value v5)
{
	CAMLparam5(v0, v1, v2, v3, v4);
	CAMLxparam1(v5);
	GLenum lv0 = Int_val(v0);
	GLuint lv1 = Int_val(v1);
	GLint lv2 = Int_val(v2);
	GLint lv3 = Int_val(v3);
	GLint lv4 = Int_val(v4);
	GLint lv5 = Int_val(v5);
	LOAD_FUNCTION(glProgramEnvParameterI4iNV);
	(*stub_glProgramEnvParameterI4iNV)(lv0, lv1, lv2, lv3, lv4, lv5);
	CAMLreturn(Val_unit);
}

value glstub_glProgramEnvParameterI4iNV_byte(value * argv, int n)
{
	return glstub_glProgramEnvParameterI4iNV(argv[0], argv[1], argv[2], argv[3], argv[4], argv[5]);
}

DECLARE_FUNCTION(glProgramEnvParameterI4ivNV,(GLenum, GLuint, GLint*),void);
value glstub_glProgramEnvParameterI4ivNV(value v0, value v1, value v2)
{
	CAMLparam3(v0, v1, v2);
	GLenum lv0 = Int_val(v0);
	GLuint lv1 = Int_val(v1);
	GLint* lv2 = Data_bigarray_val(v2);
	LOAD_FUNCTION(glProgramEnvParameterI4ivNV);
	(*stub_glProgramEnvParameterI4ivNV)(lv0, lv1, lv2);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glProgramEnvParameterI4uiNV,(GLenum, GLuint, GLuint, GLuint, GLuint, GLuint),void);
value glstub_glProgramEnvParameterI4uiNV(value v0, value v1, value v2, value v3, value v4, value v5)
{
	CAMLparam5(v0, v1, v2, v3, v4);
	CAMLxparam1(v5);
	GLenum lv0 = Int_val(v0);
	GLuint lv1 = Int_val(v1);
	GLuint lv2 = Int_val(v2);
	GLuint lv3 = Int_val(v3);
	GLuint lv4 = Int_val(v4);
	GLuint lv5 = Int_val(v5);
	LOAD_FUNCTION(glProgramEnvParameterI4uiNV);
	(*stub_glProgramEnvParameterI4uiNV)(lv0, lv1, lv2, lv3, lv4, lv5);
	CAMLreturn(Val_unit);
}

value glstub_glProgramEnvParameterI4uiNV_byte(value * argv, int n)
{
	return glstub_glProgramEnvParameterI4uiNV(argv[0], argv[1], argv[2], argv[3], argv[4], argv[5]);
}

DECLARE_FUNCTION(glProgramEnvParameterI4uivNV,(GLenum, GLuint, GLuint*),void);
value glstub_glProgramEnvParameterI4uivNV(value v0, value v1, value v2)
{
	CAMLparam3(v0, v1, v2);
	GLenum lv0 = Int_val(v0);
	GLuint lv1 = Int_val(v1);
	GLuint* lv2 = Data_bigarray_val(v2);
	LOAD_FUNCTION(glProgramEnvParameterI4uivNV);
	(*stub_glProgramEnvParameterI4uivNV)(lv0, lv1, lv2);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glProgramEnvParameters4fvEXT,(GLenum, GLuint, GLsizei, GLfloat*),void);
value glstub_glProgramEnvParameters4fvEXT(value v0, value v1, value v2, value v3)
{
	CAMLparam4(v0, v1, v2, v3);
	GLenum lv0 = Int_val(v0);
	GLuint lv1 = Int_val(v1);
	GLsizei lv2 = Int_val(v2);
	GLfloat* lv3 = Data_bigarray_val(v3);
	LOAD_FUNCTION(glProgramEnvParameters4fvEXT);
	(*stub_glProgramEnvParameters4fvEXT)(lv0, lv1, lv2, lv3);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glProgramEnvParametersI4ivNV,(GLenum, GLuint, GLsizei, GLint*),void);
value glstub_glProgramEnvParametersI4ivNV(value v0, value v1, value v2, value v3)
{
	CAMLparam4(v0, v1, v2, v3);
	GLenum lv0 = Int_val(v0);
	GLuint lv1 = Int_val(v1);
	GLsizei lv2 = Int_val(v2);
	GLint* lv3 = Data_bigarray_val(v3);
	LOAD_FUNCTION(glProgramEnvParametersI4ivNV);
	(*stub_glProgramEnvParametersI4ivNV)(lv0, lv1, lv2, lv3);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glProgramEnvParametersI4uivNV,(GLenum, GLuint, GLsizei, GLuint*),void);
value glstub_glProgramEnvParametersI4uivNV(value v0, value v1, value v2, value v3)
{
	CAMLparam4(v0, v1, v2, v3);
	GLenum lv0 = Int_val(v0);
	GLuint lv1 = Int_val(v1);
	GLsizei lv2 = Int_val(v2);
	GLuint* lv3 = Data_bigarray_val(v3);
	LOAD_FUNCTION(glProgramEnvParametersI4uivNV);
	(*stub_glProgramEnvParametersI4uivNV)(lv0, lv1, lv2, lv3);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glProgramLocalParameter4dARB,(GLenum, GLuint, GLdouble, GLdouble, GLdouble, GLdouble),void);
value glstub_glProgramLocalParameter4dARB(value v0, value v1, value v2, value v3, value v4, value v5)
{
	CAMLparam5(v0, v1, v2, v3, v4);
	CAMLxparam1(v5);
	GLenum lv0 = Int_val(v0);
	GLuint lv1 = Int_val(v1);
	GLdouble lv2 = Double_val(v2);
	GLdouble lv3 = Double_val(v3);
	GLdouble lv4 = Double_val(v4);
	GLdouble lv5 = Double_val(v5);
	LOAD_FUNCTION(glProgramLocalParameter4dARB);
	(*stub_glProgramLocalParameter4dARB)(lv0, lv1, lv2, lv3, lv4, lv5);
	CAMLreturn(Val_unit);
}

value glstub_glProgramLocalParameter4dARB_byte(value * argv, int n)
{
	return glstub_glProgramLocalParameter4dARB(argv[0], argv[1], argv[2], argv[3], argv[4], argv[5]);
}

DECLARE_FUNCTION(glProgramLocalParameter4dvARB,(GLenum, GLuint, GLdouble*),void);
value glstub_glProgramLocalParameter4dvARB(value v0, value v1, value v2)
{
	CAMLparam3(v0, v1, v2);
	GLenum lv0 = Int_val(v0);
	GLuint lv1 = Int_val(v1);
	GLdouble* lv2 = (Tag_val(v2) == Double_array_tag)? (double *)v2: Data_bigarray_val(v2);
	LOAD_FUNCTION(glProgramLocalParameter4dvARB);
	(*stub_glProgramLocalParameter4dvARB)(lv0, lv1, lv2);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glProgramLocalParameter4fARB,(GLenum, GLuint, GLfloat, GLfloat, GLfloat, GLfloat),void);
value glstub_glProgramLocalParameter4fARB(value v0, value v1, value v2, value v3, value v4, value v5)
{
	CAMLparam5(v0, v1, v2, v3, v4);
	CAMLxparam1(v5);
	GLenum lv0 = Int_val(v0);
	GLuint lv1 = Int_val(v1);
	GLfloat lv2 = Double_val(v2);
	GLfloat lv3 = Double_val(v3);
	GLfloat lv4 = Double_val(v4);
	GLfloat lv5 = Double_val(v5);
	LOAD_FUNCTION(glProgramLocalParameter4fARB);
	(*stub_glProgramLocalParameter4fARB)(lv0, lv1, lv2, lv3, lv4, lv5);
	CAMLreturn(Val_unit);
}

value glstub_glProgramLocalParameter4fARB_byte(value * argv, int n)
{
	return glstub_glProgramLocalParameter4fARB(argv[0], argv[1], argv[2], argv[3], argv[4], argv[5]);
}

DECLARE_FUNCTION(glProgramLocalParameter4fvARB,(GLenum, GLuint, GLfloat*),void);
value glstub_glProgramLocalParameter4fvARB(value v0, value v1, value v2)
{
	CAMLparam3(v0, v1, v2);
	GLenum lv0 = Int_val(v0);
	GLuint lv1 = Int_val(v1);
	GLfloat* lv2 = Data_bigarray_val(v2);
	LOAD_FUNCTION(glProgramLocalParameter4fvARB);
	(*stub_glProgramLocalParameter4fvARB)(lv0, lv1, lv2);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glProgramLocalParameterI4iNV,(GLenum, GLuint, GLint, GLint, GLint, GLint),void);
value glstub_glProgramLocalParameterI4iNV(value v0, value v1, value v2, value v3, value v4, value v5)
{
	CAMLparam5(v0, v1, v2, v3, v4);
	CAMLxparam1(v5);
	GLenum lv0 = Int_val(v0);
	GLuint lv1 = Int_val(v1);
	GLint lv2 = Int_val(v2);
	GLint lv3 = Int_val(v3);
	GLint lv4 = Int_val(v4);
	GLint lv5 = Int_val(v5);
	LOAD_FUNCTION(glProgramLocalParameterI4iNV);
	(*stub_glProgramLocalParameterI4iNV)(lv0, lv1, lv2, lv3, lv4, lv5);
	CAMLreturn(Val_unit);
}

value glstub_glProgramLocalParameterI4iNV_byte(value * argv, int n)
{
	return glstub_glProgramLocalParameterI4iNV(argv[0], argv[1], argv[2], argv[3], argv[4], argv[5]);
}

DECLARE_FUNCTION(glProgramLocalParameterI4ivNV,(GLenum, GLuint, GLint*),void);
value glstub_glProgramLocalParameterI4ivNV(value v0, value v1, value v2)
{
	CAMLparam3(v0, v1, v2);
	GLenum lv0 = Int_val(v0);
	GLuint lv1 = Int_val(v1);
	GLint* lv2 = Data_bigarray_val(v2);
	LOAD_FUNCTION(glProgramLocalParameterI4ivNV);
	(*stub_glProgramLocalParameterI4ivNV)(lv0, lv1, lv2);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glProgramLocalParameterI4uiNV,(GLenum, GLuint, GLuint, GLuint, GLuint, GLuint),void);
value glstub_glProgramLocalParameterI4uiNV(value v0, value v1, value v2, value v3, value v4, value v5)
{
	CAMLparam5(v0, v1, v2, v3, v4);
	CAMLxparam1(v5);
	GLenum lv0 = Int_val(v0);
	GLuint lv1 = Int_val(v1);
	GLuint lv2 = Int_val(v2);
	GLuint lv3 = Int_val(v3);
	GLuint lv4 = Int_val(v4);
	GLuint lv5 = Int_val(v5);
	LOAD_FUNCTION(glProgramLocalParameterI4uiNV);
	(*stub_glProgramLocalParameterI4uiNV)(lv0, lv1, lv2, lv3, lv4, lv5);
	CAMLreturn(Val_unit);
}

value glstub_glProgramLocalParameterI4uiNV_byte(value * argv, int n)
{
	return glstub_glProgramLocalParameterI4uiNV(argv[0], argv[1], argv[2], argv[3], argv[4], argv[5]);
}

DECLARE_FUNCTION(glProgramLocalParameterI4uivNV,(GLenum, GLuint, GLuint*),void);
value glstub_glProgramLocalParameterI4uivNV(value v0, value v1, value v2)
{
	CAMLparam3(v0, v1, v2);
	GLenum lv0 = Int_val(v0);
	GLuint lv1 = Int_val(v1);
	GLuint* lv2 = Data_bigarray_val(v2);
	LOAD_FUNCTION(glProgramLocalParameterI4uivNV);
	(*stub_glProgramLocalParameterI4uivNV)(lv0, lv1, lv2);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glProgramLocalParameters4fvEXT,(GLenum, GLuint, GLsizei, GLfloat*),void);
value glstub_glProgramLocalParameters4fvEXT(value v0, value v1, value v2, value v3)
{
	CAMLparam4(v0, v1, v2, v3);
	GLenum lv0 = Int_val(v0);
	GLuint lv1 = Int_val(v1);
	GLsizei lv2 = Int_val(v2);
	GLfloat* lv3 = Data_bigarray_val(v3);
	LOAD_FUNCTION(glProgramLocalParameters4fvEXT);
	(*stub_glProgramLocalParameters4fvEXT)(lv0, lv1, lv2, lv3);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glProgramLocalParametersI4ivNV,(GLenum, GLuint, GLsizei, GLint*),void);
value glstub_glProgramLocalParametersI4ivNV(value v0, value v1, value v2, value v3)
{
	CAMLparam4(v0, v1, v2, v3);
	GLenum lv0 = Int_val(v0);
	GLuint lv1 = Int_val(v1);
	GLsizei lv2 = Int_val(v2);
	GLint* lv3 = Data_bigarray_val(v3);
	LOAD_FUNCTION(glProgramLocalParametersI4ivNV);
	(*stub_glProgramLocalParametersI4ivNV)(lv0, lv1, lv2, lv3);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glProgramLocalParametersI4uivNV,(GLenum, GLuint, GLsizei, GLuint*),void);
value glstub_glProgramLocalParametersI4uivNV(value v0, value v1, value v2, value v3)
{
	CAMLparam4(v0, v1, v2, v3);
	GLenum lv0 = Int_val(v0);
	GLuint lv1 = Int_val(v1);
	GLsizei lv2 = Int_val(v2);
	GLuint* lv3 = Data_bigarray_val(v3);
	LOAD_FUNCTION(glProgramLocalParametersI4uivNV);
	(*stub_glProgramLocalParametersI4uivNV)(lv0, lv1, lv2, lv3);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glProgramNamedParameter4dNV,(GLuint, GLsizei, GLubyte*, GLdouble, GLdouble, GLdouble, GLdouble),void);
value glstub_glProgramNamedParameter4dNV(value v0, value v1, value v2, value v3, value v4, value v5, value v6)
{
	CAMLparam5(v0, v1, v2, v3, v4);
	CAMLxparam2(v5, v6);
	GLuint lv0 = Int_val(v0);
	GLsizei lv1 = Int_val(v1);
	GLubyte* lv2 = Data_bigarray_val(v2);
	GLdouble lv3 = Double_val(v3);
	GLdouble lv4 = Double_val(v4);
	GLdouble lv5 = Double_val(v5);
	GLdouble lv6 = Double_val(v6);
	LOAD_FUNCTION(glProgramNamedParameter4dNV);
	(*stub_glProgramNamedParameter4dNV)(lv0, lv1, lv2, lv3, lv4, lv5, lv6);
	CAMLreturn(Val_unit);
}

value glstub_glProgramNamedParameter4dNV_byte(value * argv, int n)
{
	return glstub_glProgramNamedParameter4dNV(argv[0], argv[1], argv[2], argv[3], argv[4], argv[5], argv[6]);
}

DECLARE_FUNCTION(glProgramNamedParameter4dvNV,(GLuint, GLsizei, GLubyte*, GLdouble*),void);
value glstub_glProgramNamedParameter4dvNV(value v0, value v1, value v2, value v3)
{
	CAMLparam4(v0, v1, v2, v3);
	GLuint lv0 = Int_val(v0);
	GLsizei lv1 = Int_val(v1);
	GLubyte* lv2 = Data_bigarray_val(v2);
	GLdouble* lv3 = (Tag_val(v3) == Double_array_tag)? (double *)v3: Data_bigarray_val(v3);
	LOAD_FUNCTION(glProgramNamedParameter4dvNV);
	(*stub_glProgramNamedParameter4dvNV)(lv0, lv1, lv2, lv3);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glProgramNamedParameter4fNV,(GLuint, GLsizei, GLubyte*, GLfloat, GLfloat, GLfloat, GLfloat),void);
value glstub_glProgramNamedParameter4fNV(value v0, value v1, value v2, value v3, value v4, value v5, value v6)
{
	CAMLparam5(v0, v1, v2, v3, v4);
	CAMLxparam2(v5, v6);
	GLuint lv0 = Int_val(v0);
	GLsizei lv1 = Int_val(v1);
	GLubyte* lv2 = Data_bigarray_val(v2);
	GLfloat lv3 = Double_val(v3);
	GLfloat lv4 = Double_val(v4);
	GLfloat lv5 = Double_val(v5);
	GLfloat lv6 = Double_val(v6);
	LOAD_FUNCTION(glProgramNamedParameter4fNV);
	(*stub_glProgramNamedParameter4fNV)(lv0, lv1, lv2, lv3, lv4, lv5, lv6);
	CAMLreturn(Val_unit);
}

value glstub_glProgramNamedParameter4fNV_byte(value * argv, int n)
{
	return glstub_glProgramNamedParameter4fNV(argv[0], argv[1], argv[2], argv[3], argv[4], argv[5], argv[6]);
}

DECLARE_FUNCTION(glProgramNamedParameter4fvNV,(GLuint, GLsizei, GLubyte*, GLfloat*),void);
value glstub_glProgramNamedParameter4fvNV(value v0, value v1, value v2, value v3)
{
	CAMLparam4(v0, v1, v2, v3);
	GLuint lv0 = Int_val(v0);
	GLsizei lv1 = Int_val(v1);
	GLubyte* lv2 = Data_bigarray_val(v2);
	GLfloat* lv3 = Data_bigarray_val(v3);
	LOAD_FUNCTION(glProgramNamedParameter4fvNV);
	(*stub_glProgramNamedParameter4fvNV)(lv0, lv1, lv2, lv3);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glProgramParameter4dNV,(GLenum, GLuint, GLdouble, GLdouble, GLdouble, GLdouble),void);
value glstub_glProgramParameter4dNV(value v0, value v1, value v2, value v3, value v4, value v5)
{
	CAMLparam5(v0, v1, v2, v3, v4);
	CAMLxparam1(v5);
	GLenum lv0 = Int_val(v0);
	GLuint lv1 = Int_val(v1);
	GLdouble lv2 = Double_val(v2);
	GLdouble lv3 = Double_val(v3);
	GLdouble lv4 = Double_val(v4);
	GLdouble lv5 = Double_val(v5);
	LOAD_FUNCTION(glProgramParameter4dNV);
	(*stub_glProgramParameter4dNV)(lv0, lv1, lv2, lv3, lv4, lv5);
	CAMLreturn(Val_unit);
}

value glstub_glProgramParameter4dNV_byte(value * argv, int n)
{
	return glstub_glProgramParameter4dNV(argv[0], argv[1], argv[2], argv[3], argv[4], argv[5]);
}

DECLARE_FUNCTION(glProgramParameter4dvNV,(GLenum, GLuint, GLdouble*),void);
value glstub_glProgramParameter4dvNV(value v0, value v1, value v2)
{
	CAMLparam3(v0, v1, v2);
	GLenum lv0 = Int_val(v0);
	GLuint lv1 = Int_val(v1);
	GLdouble* lv2 = (Tag_val(v2) == Double_array_tag)? (double *)v2: Data_bigarray_val(v2);
	LOAD_FUNCTION(glProgramParameter4dvNV);
	(*stub_glProgramParameter4dvNV)(lv0, lv1, lv2);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glProgramParameter4fNV,(GLenum, GLuint, GLfloat, GLfloat, GLfloat, GLfloat),void);
value glstub_glProgramParameter4fNV(value v0, value v1, value v2, value v3, value v4, value v5)
{
	CAMLparam5(v0, v1, v2, v3, v4);
	CAMLxparam1(v5);
	GLenum lv0 = Int_val(v0);
	GLuint lv1 = Int_val(v1);
	GLfloat lv2 = Double_val(v2);
	GLfloat lv3 = Double_val(v3);
	GLfloat lv4 = Double_val(v4);
	GLfloat lv5 = Double_val(v5);
	LOAD_FUNCTION(glProgramParameter4fNV);
	(*stub_glProgramParameter4fNV)(lv0, lv1, lv2, lv3, lv4, lv5);
	CAMLreturn(Val_unit);
}

value glstub_glProgramParameter4fNV_byte(value * argv, int n)
{
	return glstub_glProgramParameter4fNV(argv[0], argv[1], argv[2], argv[3], argv[4], argv[5]);
}

DECLARE_FUNCTION(glProgramParameter4fvNV,(GLenum, GLuint, GLfloat*),void);
value glstub_glProgramParameter4fvNV(value v0, value v1, value v2)
{
	CAMLparam3(v0, v1, v2);
	GLenum lv0 = Int_val(v0);
	GLuint lv1 = Int_val(v1);
	GLfloat* lv2 = Data_bigarray_val(v2);
	LOAD_FUNCTION(glProgramParameter4fvNV);
	(*stub_glProgramParameter4fvNV)(lv0, lv1, lv2);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glProgramParameteriEXT,(GLuint, GLenum, GLint),void);
value glstub_glProgramParameteriEXT(value v0, value v1, value v2)
{
	CAMLparam3(v0, v1, v2);
	GLuint lv0 = Int_val(v0);
	GLenum lv1 = Int_val(v1);
	GLint lv2 = Int_val(v2);
	LOAD_FUNCTION(glProgramParameteriEXT);
	(*stub_glProgramParameteriEXT)(lv0, lv1, lv2);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glProgramParameters4dvNV,(GLenum, GLuint, GLuint, GLdouble*),void);
value glstub_glProgramParameters4dvNV(value v0, value v1, value v2, value v3)
{
	CAMLparam4(v0, v1, v2, v3);
	GLenum lv0 = Int_val(v0);
	GLuint lv1 = Int_val(v1);
	GLuint lv2 = Int_val(v2);
	GLdouble* lv3 = (Tag_val(v3) == Double_array_tag)? (double *)v3: Data_bigarray_val(v3);
	LOAD_FUNCTION(glProgramParameters4dvNV);
	(*stub_glProgramParameters4dvNV)(lv0, lv1, lv2, lv3);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glProgramParameters4fvNV,(GLenum, GLuint, GLuint, GLfloat*),void);
value glstub_glProgramParameters4fvNV(value v0, value v1, value v2, value v3)
{
	CAMLparam4(v0, v1, v2, v3);
	GLenum lv0 = Int_val(v0);
	GLuint lv1 = Int_val(v1);
	GLuint lv2 = Int_val(v2);
	GLfloat* lv3 = Data_bigarray_val(v3);
	LOAD_FUNCTION(glProgramParameters4fvNV);
	(*stub_glProgramParameters4fvNV)(lv0, lv1, lv2, lv3);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glProgramStringARB,(GLenum, GLenum, GLsizei, GLvoid*),void);
value glstub_glProgramStringARB(value v0, value v1, value v2, value v3)
{
	CAMLparam4(v0, v1, v2, v3);
	GLenum lv0 = Int_val(v0);
	GLenum lv1 = Int_val(v1);
	GLsizei lv2 = Int_val(v2);
	GLvoid* lv3 = (GLvoid *)((Tag_val(v3) == String_tag)? (String_val(v3)) : (Data_bigarray_val(v3)));
	LOAD_FUNCTION(glProgramStringARB);
	(*stub_glProgramStringARB)(lv0, lv1, lv2, lv3);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glProgramVertexLimitNV,(GLenum, GLint),void);
value glstub_glProgramVertexLimitNV(value v0, value v1)
{
	CAMLparam2(v0, v1);
	GLenum lv0 = Int_val(v0);
	GLint lv1 = Int_val(v1);
	LOAD_FUNCTION(glProgramVertexLimitNV);
	(*stub_glProgramVertexLimitNV)(lv0, lv1);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glPushAttrib,(GLbitfield),void);
value glstub_glPushAttrib(value v0)
{
	CAMLparam1(v0);
	GLbitfield lv0 = Int_val(v0);
	LOAD_FUNCTION(glPushAttrib);
	(*stub_glPushAttrib)(lv0);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glPushClientAttrib,(GLbitfield),void);
value glstub_glPushClientAttrib(value v0)
{
	CAMLparam1(v0);
	GLbitfield lv0 = Int_val(v0);
	LOAD_FUNCTION(glPushClientAttrib);
	(*stub_glPushClientAttrib)(lv0);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glPushMatrix,(void),void);
value glstub_glPushMatrix(value v0)
{
	CAMLparam1(v0);
	LOAD_FUNCTION(glPushMatrix);
	(*stub_glPushMatrix)();
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glPushName,(GLuint),void);
value glstub_glPushName(value v0)
{
	CAMLparam1(v0);
	GLuint lv0 = Int_val(v0);
	LOAD_FUNCTION(glPushName);
	(*stub_glPushName)(lv0);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glRasterPos2d,(GLdouble, GLdouble),void);
value glstub_glRasterPos2d(value v0, value v1)
{
	CAMLparam2(v0, v1);
	GLdouble lv0 = Double_val(v0);
	GLdouble lv1 = Double_val(v1);
	LOAD_FUNCTION(glRasterPos2d);
	(*stub_glRasterPos2d)(lv0, lv1);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glRasterPos2dv,(GLdouble*),void);
value glstub_glRasterPos2dv(value v0)
{
	CAMLparam1(v0);
	GLdouble* lv0 = (Tag_val(v0) == Double_array_tag)? (double *)v0: Data_bigarray_val(v0);
	LOAD_FUNCTION(glRasterPos2dv);
	(*stub_glRasterPos2dv)(lv0);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glRasterPos2f,(GLfloat, GLfloat),void);
value glstub_glRasterPos2f(value v0, value v1)
{
	CAMLparam2(v0, v1);
	GLfloat lv0 = Double_val(v0);
	GLfloat lv1 = Double_val(v1);
	LOAD_FUNCTION(glRasterPos2f);
	(*stub_glRasterPos2f)(lv0, lv1);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glRasterPos2fv,(GLfloat*),void);
value glstub_glRasterPos2fv(value v0)
{
	CAMLparam1(v0);
	GLfloat* lv0 = Data_bigarray_val(v0);
	LOAD_FUNCTION(glRasterPos2fv);
	(*stub_glRasterPos2fv)(lv0);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glRasterPos2i,(GLint, GLint),void);
value glstub_glRasterPos2i(value v0, value v1)
{
	CAMLparam2(v0, v1);
	GLint lv0 = Int_val(v0);
	GLint lv1 = Int_val(v1);
	LOAD_FUNCTION(glRasterPos2i);
	(*stub_glRasterPos2i)(lv0, lv1);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glRasterPos2iv,(GLint*),void);
value glstub_glRasterPos2iv(value v0)
{
	CAMLparam1(v0);
	GLint* lv0 = Data_bigarray_val(v0);
	LOAD_FUNCTION(glRasterPos2iv);
	(*stub_glRasterPos2iv)(lv0);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glRasterPos2s,(GLshort, GLshort),void);
value glstub_glRasterPos2s(value v0, value v1)
{
	CAMLparam2(v0, v1);
	GLshort lv0 = Int_val(v0);
	GLshort lv1 = Int_val(v1);
	LOAD_FUNCTION(glRasterPos2s);
	(*stub_glRasterPos2s)(lv0, lv1);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glRasterPos2sv,(GLshort*),void);
value glstub_glRasterPos2sv(value v0)
{
	CAMLparam1(v0);
	GLshort* lv0 = Data_bigarray_val(v0);
	LOAD_FUNCTION(glRasterPos2sv);
	(*stub_glRasterPos2sv)(lv0);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glRasterPos3d,(GLdouble, GLdouble, GLdouble),void);
value glstub_glRasterPos3d(value v0, value v1, value v2)
{
	CAMLparam3(v0, v1, v2);
	GLdouble lv0 = Double_val(v0);
	GLdouble lv1 = Double_val(v1);
	GLdouble lv2 = Double_val(v2);
	LOAD_FUNCTION(glRasterPos3d);
	(*stub_glRasterPos3d)(lv0, lv1, lv2);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glRasterPos3dv,(GLdouble*),void);
value glstub_glRasterPos3dv(value v0)
{
	CAMLparam1(v0);
	GLdouble* lv0 = (Tag_val(v0) == Double_array_tag)? (double *)v0: Data_bigarray_val(v0);
	LOAD_FUNCTION(glRasterPos3dv);
	(*stub_glRasterPos3dv)(lv0);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glRasterPos3f,(GLfloat, GLfloat, GLfloat),void);
value glstub_glRasterPos3f(value v0, value v1, value v2)
{
	CAMLparam3(v0, v1, v2);
	GLfloat lv0 = Double_val(v0);
	GLfloat lv1 = Double_val(v1);
	GLfloat lv2 = Double_val(v2);
	LOAD_FUNCTION(glRasterPos3f);
	(*stub_glRasterPos3f)(lv0, lv1, lv2);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glRasterPos3fv,(GLfloat*),void);
value glstub_glRasterPos3fv(value v0)
{
	CAMLparam1(v0);
	GLfloat* lv0 = Data_bigarray_val(v0);
	LOAD_FUNCTION(glRasterPos3fv);
	(*stub_glRasterPos3fv)(lv0);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glRasterPos3i,(GLint, GLint, GLint),void);
value glstub_glRasterPos3i(value v0, value v1, value v2)
{
	CAMLparam3(v0, v1, v2);
	GLint lv0 = Int_val(v0);
	GLint lv1 = Int_val(v1);
	GLint lv2 = Int_val(v2);
	LOAD_FUNCTION(glRasterPos3i);
	(*stub_glRasterPos3i)(lv0, lv1, lv2);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glRasterPos3iv,(GLint*),void);
value glstub_glRasterPos3iv(value v0)
{
	CAMLparam1(v0);
	GLint* lv0 = Data_bigarray_val(v0);
	LOAD_FUNCTION(glRasterPos3iv);
	(*stub_glRasterPos3iv)(lv0);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glRasterPos3s,(GLshort, GLshort, GLshort),void);
value glstub_glRasterPos3s(value v0, value v1, value v2)
{
	CAMLparam3(v0, v1, v2);
	GLshort lv0 = Int_val(v0);
	GLshort lv1 = Int_val(v1);
	GLshort lv2 = Int_val(v2);
	LOAD_FUNCTION(glRasterPos3s);
	(*stub_glRasterPos3s)(lv0, lv1, lv2);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glRasterPos3sv,(GLshort*),void);
value glstub_glRasterPos3sv(value v0)
{
	CAMLparam1(v0);
	GLshort* lv0 = Data_bigarray_val(v0);
	LOAD_FUNCTION(glRasterPos3sv);
	(*stub_glRasterPos3sv)(lv0);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glRasterPos4d,(GLdouble, GLdouble, GLdouble, GLdouble),void);
value glstub_glRasterPos4d(value v0, value v1, value v2, value v3)
{
	CAMLparam4(v0, v1, v2, v3);
	GLdouble lv0 = Double_val(v0);
	GLdouble lv1 = Double_val(v1);
	GLdouble lv2 = Double_val(v2);
	GLdouble lv3 = Double_val(v3);
	LOAD_FUNCTION(glRasterPos4d);
	(*stub_glRasterPos4d)(lv0, lv1, lv2, lv3);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glRasterPos4dv,(GLdouble*),void);
value glstub_glRasterPos4dv(value v0)
{
	CAMLparam1(v0);
	GLdouble* lv0 = (Tag_val(v0) == Double_array_tag)? (double *)v0: Data_bigarray_val(v0);
	LOAD_FUNCTION(glRasterPos4dv);
	(*stub_glRasterPos4dv)(lv0);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glRasterPos4f,(GLfloat, GLfloat, GLfloat, GLfloat),void);
value glstub_glRasterPos4f(value v0, value v1, value v2, value v3)
{
	CAMLparam4(v0, v1, v2, v3);
	GLfloat lv0 = Double_val(v0);
	GLfloat lv1 = Double_val(v1);
	GLfloat lv2 = Double_val(v2);
	GLfloat lv3 = Double_val(v3);
	LOAD_FUNCTION(glRasterPos4f);
	(*stub_glRasterPos4f)(lv0, lv1, lv2, lv3);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glRasterPos4fv,(GLfloat*),void);
value glstub_glRasterPos4fv(value v0)
{
	CAMLparam1(v0);
	GLfloat* lv0 = Data_bigarray_val(v0);
	LOAD_FUNCTION(glRasterPos4fv);
	(*stub_glRasterPos4fv)(lv0);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glRasterPos4i,(GLint, GLint, GLint, GLint),void);
value glstub_glRasterPos4i(value v0, value v1, value v2, value v3)
{
	CAMLparam4(v0, v1, v2, v3);
	GLint lv0 = Int_val(v0);
	GLint lv1 = Int_val(v1);
	GLint lv2 = Int_val(v2);
	GLint lv3 = Int_val(v3);
	LOAD_FUNCTION(glRasterPos4i);
	(*stub_glRasterPos4i)(lv0, lv1, lv2, lv3);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glRasterPos4iv,(GLint*),void);
value glstub_glRasterPos4iv(value v0)
{
	CAMLparam1(v0);
	GLint* lv0 = Data_bigarray_val(v0);
	LOAD_FUNCTION(glRasterPos4iv);
	(*stub_glRasterPos4iv)(lv0);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glRasterPos4s,(GLshort, GLshort, GLshort, GLshort),void);
value glstub_glRasterPos4s(value v0, value v1, value v2, value v3)
{
	CAMLparam4(v0, v1, v2, v3);
	GLshort lv0 = Int_val(v0);
	GLshort lv1 = Int_val(v1);
	GLshort lv2 = Int_val(v2);
	GLshort lv3 = Int_val(v3);
	LOAD_FUNCTION(glRasterPos4s);
	(*stub_glRasterPos4s)(lv0, lv1, lv2, lv3);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glRasterPos4sv,(GLshort*),void);
value glstub_glRasterPos4sv(value v0)
{
	CAMLparam1(v0);
	GLshort* lv0 = Data_bigarray_val(v0);
	LOAD_FUNCTION(glRasterPos4sv);
	(*stub_glRasterPos4sv)(lv0);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glReadBuffer,(GLenum),void);
value glstub_glReadBuffer(value v0)
{
	CAMLparam1(v0);
	GLenum lv0 = Int_val(v0);
	LOAD_FUNCTION(glReadBuffer);
	(*stub_glReadBuffer)(lv0);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glReadBufferRegionEXT,(GLuint, GLint, GLint, GLsizei, GLsizei),void);
value glstub_glReadBufferRegionEXT(value v0, value v1, value v2, value v3, value v4)
{
	CAMLparam5(v0, v1, v2, v3, v4);
	GLuint lv0 = Int_val(v0);
	GLint lv1 = Int_val(v1);
	GLint lv2 = Int_val(v2);
	GLsizei lv3 = Int_val(v3);
	GLsizei lv4 = Int_val(v4);
	LOAD_FUNCTION(glReadBufferRegionEXT);
	(*stub_glReadBufferRegionEXT)(lv0, lv1, lv2, lv3, lv4);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glReadPixels,(GLint, GLint, GLsizei, GLsizei, GLenum, GLenum, GLvoid*),void);
value glstub_glReadPixels(value v0, value v1, value v2, value v3, value v4, value v5, value v6)
{
	CAMLparam5(v0, v1, v2, v3, v4);
	CAMLxparam2(v5, v6);
	GLint lv0 = Int_val(v0);
	GLint lv1 = Int_val(v1);
	GLsizei lv2 = Int_val(v2);
	GLsizei lv3 = Int_val(v3);
	GLenum lv4 = Int_val(v4);
	GLenum lv5 = Int_val(v5);
	GLvoid* lv6 = (GLvoid *)((Tag_val(v6) == String_tag)? (String_val(v6)) : (Data_bigarray_val(v6)));
	LOAD_FUNCTION(glReadPixels);
	(*stub_glReadPixels)(lv0, lv1, lv2, lv3, lv4, lv5, lv6);
	CAMLreturn(Val_unit);
}

value glstub_glReadPixels_byte(value * argv, int n)
{
	return glstub_glReadPixels(argv[0], argv[1], argv[2], argv[3], argv[4], argv[5], argv[6]);
}

DECLARE_FUNCTION(glReadVideoPixelsSUN,(GLint, GLint, GLsizei, GLsizei, GLenum, GLenum, GLvoid*),void);
value glstub_glReadVideoPixelsSUN(value v0, value v1, value v2, value v3, value v4, value v5, value v6)
{
	CAMLparam5(v0, v1, v2, v3, v4);
	CAMLxparam2(v5, v6);
	GLint lv0 = Int_val(v0);
	GLint lv1 = Int_val(v1);
	GLsizei lv2 = Int_val(v2);
	GLsizei lv3 = Int_val(v3);
	GLenum lv4 = Int_val(v4);
	GLenum lv5 = Int_val(v5);
	GLvoid* lv6 = (GLvoid *)((Tag_val(v6) == String_tag)? (String_val(v6)) : (Data_bigarray_val(v6)));
	LOAD_FUNCTION(glReadVideoPixelsSUN);
	(*stub_glReadVideoPixelsSUN)(lv0, lv1, lv2, lv3, lv4, lv5, lv6);
	CAMLreturn(Val_unit);
}

value glstub_glReadVideoPixelsSUN_byte(value * argv, int n)
{
	return glstub_glReadVideoPixelsSUN(argv[0], argv[1], argv[2], argv[3], argv[4], argv[5], argv[6]);
}

DECLARE_FUNCTION(glRectd,(GLdouble, GLdouble, GLdouble, GLdouble),void);
value glstub_glRectd(value v0, value v1, value v2, value v3)
{
	CAMLparam4(v0, v1, v2, v3);
	GLdouble lv0 = Double_val(v0);
	GLdouble lv1 = Double_val(v1);
	GLdouble lv2 = Double_val(v2);
	GLdouble lv3 = Double_val(v3);
	LOAD_FUNCTION(glRectd);
	(*stub_glRectd)(lv0, lv1, lv2, lv3);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glRectdv,(GLdouble*, GLdouble*),void);
value glstub_glRectdv(value v0, value v1)
{
	CAMLparam2(v0, v1);
	GLdouble* lv0 = (Tag_val(v0) == Double_array_tag)? (double *)v0: Data_bigarray_val(v0);
	GLdouble* lv1 = (Tag_val(v1) == Double_array_tag)? (double *)v1: Data_bigarray_val(v1);
	LOAD_FUNCTION(glRectdv);
	(*stub_glRectdv)(lv0, lv1);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glRectf,(GLfloat, GLfloat, GLfloat, GLfloat),void);
value glstub_glRectf(value v0, value v1, value v2, value v3)
{
	CAMLparam4(v0, v1, v2, v3);
	GLfloat lv0 = Double_val(v0);
	GLfloat lv1 = Double_val(v1);
	GLfloat lv2 = Double_val(v2);
	GLfloat lv3 = Double_val(v3);
	LOAD_FUNCTION(glRectf);
	(*stub_glRectf)(lv0, lv1, lv2, lv3);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glRectfv,(GLfloat*, GLfloat*),void);
value glstub_glRectfv(value v0, value v1)
{
	CAMLparam2(v0, v1);
	GLfloat* lv0 = Data_bigarray_val(v0);
	GLfloat* lv1 = Data_bigarray_val(v1);
	LOAD_FUNCTION(glRectfv);
	(*stub_glRectfv)(lv0, lv1);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glRecti,(GLint, GLint, GLint, GLint),void);
value glstub_glRecti(value v0, value v1, value v2, value v3)
{
	CAMLparam4(v0, v1, v2, v3);
	GLint lv0 = Int_val(v0);
	GLint lv1 = Int_val(v1);
	GLint lv2 = Int_val(v2);
	GLint lv3 = Int_val(v3);
	LOAD_FUNCTION(glRecti);
	(*stub_glRecti)(lv0, lv1, lv2, lv3);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glRectiv,(GLint*, GLint*),void);
value glstub_glRectiv(value v0, value v1)
{
	CAMLparam2(v0, v1);
	GLint* lv0 = Data_bigarray_val(v0);
	GLint* lv1 = Data_bigarray_val(v1);
	LOAD_FUNCTION(glRectiv);
	(*stub_glRectiv)(lv0, lv1);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glRects,(GLshort, GLshort, GLshort, GLshort),void);
value glstub_glRects(value v0, value v1, value v2, value v3)
{
	CAMLparam4(v0, v1, v2, v3);
	GLshort lv0 = Int_val(v0);
	GLshort lv1 = Int_val(v1);
	GLshort lv2 = Int_val(v2);
	GLshort lv3 = Int_val(v3);
	LOAD_FUNCTION(glRects);
	(*stub_glRects)(lv0, lv1, lv2, lv3);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glRectsv,(GLshort*, GLshort*),void);
value glstub_glRectsv(value v0, value v1)
{
	CAMLparam2(v0, v1);
	GLshort* lv0 = Data_bigarray_val(v0);
	GLshort* lv1 = Data_bigarray_val(v1);
	LOAD_FUNCTION(glRectsv);
	(*stub_glRectsv)(lv0, lv1);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glReferencePlaneSGIX,(GLdouble*),void);
value glstub_glReferencePlaneSGIX(value v0)
{
	CAMLparam1(v0);
	GLdouble* lv0 = (Tag_val(v0) == Double_array_tag)? (double *)v0: Data_bigarray_val(v0);
	LOAD_FUNCTION(glReferencePlaneSGIX);
	(*stub_glReferencePlaneSGIX)(lv0);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glRenderMode,(GLenum),GLint);
value glstub_glRenderMode(value v0)
{
	CAMLparam1(v0);
	CAMLlocal1(result);
	GLenum lv0 = Int_val(v0);
	GLint ret;
	LOAD_FUNCTION(glRenderMode);
	ret = (*stub_glRenderMode)(lv0);
	result = Val_int(ret);
	CAMLreturn(result);
}

DECLARE_FUNCTION(glRenderbufferStorageEXT,(GLenum, GLenum, GLsizei, GLsizei),void);
value glstub_glRenderbufferStorageEXT(value v0, value v1, value v2, value v3)
{
	CAMLparam4(v0, v1, v2, v3);
	GLenum lv0 = Int_val(v0);
	GLenum lv1 = Int_val(v1);
	GLsizei lv2 = Int_val(v2);
	GLsizei lv3 = Int_val(v3);
	LOAD_FUNCTION(glRenderbufferStorageEXT);
	(*stub_glRenderbufferStorageEXT)(lv0, lv1, lv2, lv3);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glRenderbufferStorageMultisampleCoverageNV,(GLenum, GLsizei, GLsizei, GLenum, GLsizei, GLsizei),void);
value glstub_glRenderbufferStorageMultisampleCoverageNV(value v0, value v1, value v2, value v3, value v4, value v5)
{
	CAMLparam5(v0, v1, v2, v3, v4);
	CAMLxparam1(v5);
	GLenum lv0 = Int_val(v0);
	GLsizei lv1 = Int_val(v1);
	GLsizei lv2 = Int_val(v2);
	GLenum lv3 = Int_val(v3);
	GLsizei lv4 = Int_val(v4);
	GLsizei lv5 = Int_val(v5);
	LOAD_FUNCTION(glRenderbufferStorageMultisampleCoverageNV);
	(*stub_glRenderbufferStorageMultisampleCoverageNV)(lv0, lv1, lv2, lv3, lv4, lv5);
	CAMLreturn(Val_unit);
}

value glstub_glRenderbufferStorageMultisampleCoverageNV_byte(value * argv, int n)
{
	return glstub_glRenderbufferStorageMultisampleCoverageNV(argv[0], argv[1], argv[2], argv[3], argv[4], argv[5]);
}

DECLARE_FUNCTION(glRenderbufferStorageMultisampleEXT,(GLenum, GLsizei, GLenum, GLsizei, GLsizei),void);
value glstub_glRenderbufferStorageMultisampleEXT(value v0, value v1, value v2, value v3, value v4)
{
	CAMLparam5(v0, v1, v2, v3, v4);
	GLenum lv0 = Int_val(v0);
	GLsizei lv1 = Int_val(v1);
	GLenum lv2 = Int_val(v2);
	GLsizei lv3 = Int_val(v3);
	GLsizei lv4 = Int_val(v4);
	LOAD_FUNCTION(glRenderbufferStorageMultisampleEXT);
	(*stub_glRenderbufferStorageMultisampleEXT)(lv0, lv1, lv2, lv3, lv4);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glReplacementCodePointerSUN,(GLenum, GLsizei, GLvoid*),void);
value glstub_glReplacementCodePointerSUN(value v0, value v1, value v2)
{
	CAMLparam3(v0, v1, v2);
	GLenum lv0 = Int_val(v0);
	GLsizei lv1 = Int_val(v1);
	GLvoid* lv2 = (GLvoid *)((Tag_val(v2) == String_tag)? (String_val(v2)) : (Data_bigarray_val(v2)));
	LOAD_FUNCTION(glReplacementCodePointerSUN);
	(*stub_glReplacementCodePointerSUN)(lv0, lv1, lv2);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glReplacementCodeubSUN,(GLubyte),void);
value glstub_glReplacementCodeubSUN(value v0)
{
	CAMLparam1(v0);
	GLubyte lv0 = Int_val(v0);
	LOAD_FUNCTION(glReplacementCodeubSUN);
	(*stub_glReplacementCodeubSUN)(lv0);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glReplacementCodeubvSUN,(GLubyte*),void);
value glstub_glReplacementCodeubvSUN(value v0)
{
	CAMLparam1(v0);
	GLubyte* lv0 = Data_bigarray_val(v0);
	LOAD_FUNCTION(glReplacementCodeubvSUN);
	(*stub_glReplacementCodeubvSUN)(lv0);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glReplacementCodeuiColor3fVertex3fSUN,(GLuint, GLfloat, GLfloat, GLfloat, GLfloat, GLfloat, GLfloat),void);
value glstub_glReplacementCodeuiColor3fVertex3fSUN(value v0, value v1, value v2, value v3, value v4, value v5, value v6)
{
	CAMLparam5(v0, v1, v2, v3, v4);
	CAMLxparam2(v5, v6);
	GLuint lv0 = Int_val(v0);
	GLfloat lv1 = Double_val(v1);
	GLfloat lv2 = Double_val(v2);
	GLfloat lv3 = Double_val(v3);
	GLfloat lv4 = Double_val(v4);
	GLfloat lv5 = Double_val(v5);
	GLfloat lv6 = Double_val(v6);
	LOAD_FUNCTION(glReplacementCodeuiColor3fVertex3fSUN);
	(*stub_glReplacementCodeuiColor3fVertex3fSUN)(lv0, lv1, lv2, lv3, lv4, lv5, lv6);
	CAMLreturn(Val_unit);
}

value glstub_glReplacementCodeuiColor3fVertex3fSUN_byte(value * argv, int n)
{
	return glstub_glReplacementCodeuiColor3fVertex3fSUN(argv[0], argv[1], argv[2], argv[3], argv[4], argv[5], argv[6]);
}

DECLARE_FUNCTION(glReplacementCodeuiColor3fVertex3fvSUN,(GLuint*, GLfloat*, GLfloat*),void);
value glstub_glReplacementCodeuiColor3fVertex3fvSUN(value v0, value v1, value v2)
{
	CAMLparam3(v0, v1, v2);
	GLuint* lv0 = Data_bigarray_val(v0);
	GLfloat* lv1 = Data_bigarray_val(v1);
	GLfloat* lv2 = Data_bigarray_val(v2);
	LOAD_FUNCTION(glReplacementCodeuiColor3fVertex3fvSUN);
	(*stub_glReplacementCodeuiColor3fVertex3fvSUN)(lv0, lv1, lv2);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glReplacementCodeuiColor4fNormal3fVertex3fSUN,(GLuint, GLfloat, GLfloat, GLfloat, GLfloat, GLfloat, GLfloat, GLfloat, GLfloat, GLfloat, GLfloat),void);
value glstub_glReplacementCodeuiColor4fNormal3fVertex3fSUN(value v0, value v1, value v2, value v3, value v4, value v5, value v6, value v7, value v8, value v9, value v10)
{
	CAMLparam5(v0, v1, v2, v3, v4);
	CAMLxparam5(v5, v6, v7, v8, v9);
	CAMLxparam1(v10);
	GLuint lv0 = Int_val(v0);
	GLfloat lv1 = Double_val(v1);
	GLfloat lv2 = Double_val(v2);
	GLfloat lv3 = Double_val(v3);
	GLfloat lv4 = Double_val(v4);
	GLfloat lv5 = Double_val(v5);
	GLfloat lv6 = Double_val(v6);
	GLfloat lv7 = Double_val(v7);
	GLfloat lv8 = Double_val(v8);
	GLfloat lv9 = Double_val(v9);
	GLfloat lv10 = Double_val(v10);
	LOAD_FUNCTION(glReplacementCodeuiColor4fNormal3fVertex3fSUN);
	(*stub_glReplacementCodeuiColor4fNormal3fVertex3fSUN)(lv0, lv1, lv2, lv3, lv4, lv5, lv6, lv7, lv8, lv9, lv10);
	CAMLreturn(Val_unit);
}

value glstub_glReplacementCodeuiColor4fNormal3fVertex3fSUN_byte(value * argv, int n)
{
	return glstub_glReplacementCodeuiColor4fNormal3fVertex3fSUN(argv[0], argv[1], argv[2], argv[3], argv[4], argv[5], argv[6], argv[7], argv[8], argv[9], argv[10]);
}

DECLARE_FUNCTION(glReplacementCodeuiColor4fNormal3fVertex3fvSUN,(GLuint*, GLfloat*, GLfloat*, GLfloat*),void);
value glstub_glReplacementCodeuiColor4fNormal3fVertex3fvSUN(value v0, value v1, value v2, value v3)
{
	CAMLparam4(v0, v1, v2, v3);
	GLuint* lv0 = Data_bigarray_val(v0);
	GLfloat* lv1 = Data_bigarray_val(v1);
	GLfloat* lv2 = Data_bigarray_val(v2);
	GLfloat* lv3 = Data_bigarray_val(v3);
	LOAD_FUNCTION(glReplacementCodeuiColor4fNormal3fVertex3fvSUN);
	(*stub_glReplacementCodeuiColor4fNormal3fVertex3fvSUN)(lv0, lv1, lv2, lv3);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glReplacementCodeuiColor4ubVertex3fSUN,(GLuint, GLubyte, GLubyte, GLubyte, GLubyte, GLfloat, GLfloat, GLfloat),void);
value glstub_glReplacementCodeuiColor4ubVertex3fSUN(value v0, value v1, value v2, value v3, value v4, value v5, value v6, value v7)
{
	CAMLparam5(v0, v1, v2, v3, v4);
	CAMLxparam3(v5, v6, v7);
	GLuint lv0 = Int_val(v0);
	GLubyte lv1 = Int_val(v1);
	GLubyte lv2 = Int_val(v2);
	GLubyte lv3 = Int_val(v3);
	GLubyte lv4 = Int_val(v4);
	GLfloat lv5 = Double_val(v5);
	GLfloat lv6 = Double_val(v6);
	GLfloat lv7 = Double_val(v7);
	LOAD_FUNCTION(glReplacementCodeuiColor4ubVertex3fSUN);
	(*stub_glReplacementCodeuiColor4ubVertex3fSUN)(lv0, lv1, lv2, lv3, lv4, lv5, lv6, lv7);
	CAMLreturn(Val_unit);
}

value glstub_glReplacementCodeuiColor4ubVertex3fSUN_byte(value * argv, int n)
{
	return glstub_glReplacementCodeuiColor4ubVertex3fSUN(argv[0], argv[1], argv[2], argv[3], argv[4], argv[5], argv[6], argv[7]);
}

DECLARE_FUNCTION(glReplacementCodeuiColor4ubVertex3fvSUN,(GLuint*, GLubyte*, GLfloat*),void);
value glstub_glReplacementCodeuiColor4ubVertex3fvSUN(value v0, value v1, value v2)
{
	CAMLparam3(v0, v1, v2);
	GLuint* lv0 = Data_bigarray_val(v0);
	GLubyte* lv1 = Data_bigarray_val(v1);
	GLfloat* lv2 = Data_bigarray_val(v2);
	LOAD_FUNCTION(glReplacementCodeuiColor4ubVertex3fvSUN);
	(*stub_glReplacementCodeuiColor4ubVertex3fvSUN)(lv0, lv1, lv2);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glReplacementCodeuiNormal3fVertex3fSUN,(GLuint, GLfloat, GLfloat, GLfloat, GLfloat, GLfloat, GLfloat),void);
value glstub_glReplacementCodeuiNormal3fVertex3fSUN(value v0, value v1, value v2, value v3, value v4, value v5, value v6)
{
	CAMLparam5(v0, v1, v2, v3, v4);
	CAMLxparam2(v5, v6);
	GLuint lv0 = Int_val(v0);
	GLfloat lv1 = Double_val(v1);
	GLfloat lv2 = Double_val(v2);
	GLfloat lv3 = Double_val(v3);
	GLfloat lv4 = Double_val(v4);
	GLfloat lv5 = Double_val(v5);
	GLfloat lv6 = Double_val(v6);
	LOAD_FUNCTION(glReplacementCodeuiNormal3fVertex3fSUN);
	(*stub_glReplacementCodeuiNormal3fVertex3fSUN)(lv0, lv1, lv2, lv3, lv4, lv5, lv6);
	CAMLreturn(Val_unit);
}

value glstub_glReplacementCodeuiNormal3fVertex3fSUN_byte(value * argv, int n)
{
	return glstub_glReplacementCodeuiNormal3fVertex3fSUN(argv[0], argv[1], argv[2], argv[3], argv[4], argv[5], argv[6]);
}

DECLARE_FUNCTION(glReplacementCodeuiNormal3fVertex3fvSUN,(GLuint*, GLfloat*, GLfloat*),void);
value glstub_glReplacementCodeuiNormal3fVertex3fvSUN(value v0, value v1, value v2)
{
	CAMLparam3(v0, v1, v2);
	GLuint* lv0 = Data_bigarray_val(v0);
	GLfloat* lv1 = Data_bigarray_val(v1);
	GLfloat* lv2 = Data_bigarray_val(v2);
	LOAD_FUNCTION(glReplacementCodeuiNormal3fVertex3fvSUN);
	(*stub_glReplacementCodeuiNormal3fVertex3fvSUN)(lv0, lv1, lv2);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glReplacementCodeuiSUN,(GLuint),void);
value glstub_glReplacementCodeuiSUN(value v0)
{
	CAMLparam1(v0);
	GLuint lv0 = Int_val(v0);
	LOAD_FUNCTION(glReplacementCodeuiSUN);
	(*stub_glReplacementCodeuiSUN)(lv0);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glReplacementCodeuiTexCoord2fColor4fNormal3fVertex3fSUN,(GLuint, GLfloat, GLfloat, GLfloat, GLfloat, GLfloat, GLfloat, GLfloat, GLfloat, GLfloat, GLfloat, GLfloat, GLfloat),void);
value glstub_glReplacementCodeuiTexCoord2fColor4fNormal3fVertex3fSUN(value v0, value v1, value v2, value v3, value v4, value v5, value v6, value v7, value v8, value v9, value v10, value v11, value v12)
{
	CAMLparam5(v0, v1, v2, v3, v4);
	CAMLxparam5(v5, v6, v7, v8, v9);
	CAMLxparam3(v10, v11, v12);
	GLuint lv0 = Int_val(v0);
	GLfloat lv1 = Double_val(v1);
	GLfloat lv2 = Double_val(v2);
	GLfloat lv3 = Double_val(v3);
	GLfloat lv4 = Double_val(v4);
	GLfloat lv5 = Double_val(v5);
	GLfloat lv6 = Double_val(v6);
	GLfloat lv7 = Double_val(v7);
	GLfloat lv8 = Double_val(v8);
	GLfloat lv9 = Double_val(v9);
	GLfloat lv10 = Double_val(v10);
	GLfloat lv11 = Double_val(v11);
	GLfloat lv12 = Double_val(v12);
	LOAD_FUNCTION(glReplacementCodeuiTexCoord2fColor4fNormal3fVertex3fSUN);
	(*stub_glReplacementCodeuiTexCoord2fColor4fNormal3fVertex3fSUN)(lv0, lv1, lv2, lv3, lv4, lv5, lv6, lv7, lv8, lv9, lv10, lv11, lv12);
	CAMLreturn(Val_unit);
}

value glstub_glReplacementCodeuiTexCoord2fColor4fNormal3fVertex3fSUN_byte(value * argv, int n)
{
	return glstub_glReplacementCodeuiTexCoord2fColor4fNormal3fVertex3fSUN(argv[0], argv[1], argv[2], argv[3], argv[4], argv[5], argv[6], argv[7], argv[8], argv[9], argv[10], argv[11], argv[12]);
}

DECLARE_FUNCTION(glReplacementCodeuiTexCoord2fColor4fNormal3fVertex3fvSUN,(GLuint*, GLfloat*, GLfloat*, GLfloat*, GLfloat*),void);
value glstub_glReplacementCodeuiTexCoord2fColor4fNormal3fVertex3fvSUN(value v0, value v1, value v2, value v3, value v4)
{
	CAMLparam5(v0, v1, v2, v3, v4);
	GLuint* lv0 = Data_bigarray_val(v0);
	GLfloat* lv1 = Data_bigarray_val(v1);
	GLfloat* lv2 = Data_bigarray_val(v2);
	GLfloat* lv3 = Data_bigarray_val(v3);
	GLfloat* lv4 = Data_bigarray_val(v4);
	LOAD_FUNCTION(glReplacementCodeuiTexCoord2fColor4fNormal3fVertex3fvSUN);
	(*stub_glReplacementCodeuiTexCoord2fColor4fNormal3fVertex3fvSUN)(lv0, lv1, lv2, lv3, lv4);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glReplacementCodeuiTexCoord2fNormal3fVertex3fSUN,(GLuint, GLfloat, GLfloat, GLfloat, GLfloat, GLfloat, GLfloat, GLfloat, GLfloat),void);
value glstub_glReplacementCodeuiTexCoord2fNormal3fVertex3fSUN(value v0, value v1, value v2, value v3, value v4, value v5, value v6, value v7, value v8)
{
	CAMLparam5(v0, v1, v2, v3, v4);
	CAMLxparam4(v5, v6, v7, v8);
	GLuint lv0 = Int_val(v0);
	GLfloat lv1 = Double_val(v1);
	GLfloat lv2 = Double_val(v2);
	GLfloat lv3 = Double_val(v3);
	GLfloat lv4 = Double_val(v4);
	GLfloat lv5 = Double_val(v5);
	GLfloat lv6 = Double_val(v6);
	GLfloat lv7 = Double_val(v7);
	GLfloat lv8 = Double_val(v8);
	LOAD_FUNCTION(glReplacementCodeuiTexCoord2fNormal3fVertex3fSUN);
	(*stub_glReplacementCodeuiTexCoord2fNormal3fVertex3fSUN)(lv0, lv1, lv2, lv3, lv4, lv5, lv6, lv7, lv8);
	CAMLreturn(Val_unit);
}

value glstub_glReplacementCodeuiTexCoord2fNormal3fVertex3fSUN_byte(value * argv, int n)
{
	return glstub_glReplacementCodeuiTexCoord2fNormal3fVertex3fSUN(argv[0], argv[1], argv[2], argv[3], argv[4], argv[5], argv[6], argv[7], argv[8]);
}

DECLARE_FUNCTION(glReplacementCodeuiTexCoord2fNormal3fVertex3fvSUN,(GLuint*, GLfloat*, GLfloat*, GLfloat*),void);
value glstub_glReplacementCodeuiTexCoord2fNormal3fVertex3fvSUN(value v0, value v1, value v2, value v3)
{
	CAMLparam4(v0, v1, v2, v3);
	GLuint* lv0 = Data_bigarray_val(v0);
	GLfloat* lv1 = Data_bigarray_val(v1);
	GLfloat* lv2 = Data_bigarray_val(v2);
	GLfloat* lv3 = Data_bigarray_val(v3);
	LOAD_FUNCTION(glReplacementCodeuiTexCoord2fNormal3fVertex3fvSUN);
	(*stub_glReplacementCodeuiTexCoord2fNormal3fVertex3fvSUN)(lv0, lv1, lv2, lv3);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glReplacementCodeuiTexCoord2fVertex3fSUN,(GLuint, GLfloat, GLfloat, GLfloat, GLfloat, GLfloat),void);
value glstub_glReplacementCodeuiTexCoord2fVertex3fSUN(value v0, value v1, value v2, value v3, value v4, value v5)
{
	CAMLparam5(v0, v1, v2, v3, v4);
	CAMLxparam1(v5);
	GLuint lv0 = Int_val(v0);
	GLfloat lv1 = Double_val(v1);
	GLfloat lv2 = Double_val(v2);
	GLfloat lv3 = Double_val(v3);
	GLfloat lv4 = Double_val(v4);
	GLfloat lv5 = Double_val(v5);
	LOAD_FUNCTION(glReplacementCodeuiTexCoord2fVertex3fSUN);
	(*stub_glReplacementCodeuiTexCoord2fVertex3fSUN)(lv0, lv1, lv2, lv3, lv4, lv5);
	CAMLreturn(Val_unit);
}

value glstub_glReplacementCodeuiTexCoord2fVertex3fSUN_byte(value * argv, int n)
{
	return glstub_glReplacementCodeuiTexCoord2fVertex3fSUN(argv[0], argv[1], argv[2], argv[3], argv[4], argv[5]);
}

DECLARE_FUNCTION(glReplacementCodeuiTexCoord2fVertex3fvSUN,(GLuint*, GLfloat*, GLfloat*),void);
value glstub_glReplacementCodeuiTexCoord2fVertex3fvSUN(value v0, value v1, value v2)
{
	CAMLparam3(v0, v1, v2);
	GLuint* lv0 = Data_bigarray_val(v0);
	GLfloat* lv1 = Data_bigarray_val(v1);
	GLfloat* lv2 = Data_bigarray_val(v2);
	LOAD_FUNCTION(glReplacementCodeuiTexCoord2fVertex3fvSUN);
	(*stub_glReplacementCodeuiTexCoord2fVertex3fvSUN)(lv0, lv1, lv2);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glReplacementCodeuiVertex3fSUN,(GLuint, GLfloat, GLfloat, GLfloat),void);
value glstub_glReplacementCodeuiVertex3fSUN(value v0, value v1, value v2, value v3)
{
	CAMLparam4(v0, v1, v2, v3);
	GLuint lv0 = Int_val(v0);
	GLfloat lv1 = Double_val(v1);
	GLfloat lv2 = Double_val(v2);
	GLfloat lv3 = Double_val(v3);
	LOAD_FUNCTION(glReplacementCodeuiVertex3fSUN);
	(*stub_glReplacementCodeuiVertex3fSUN)(lv0, lv1, lv2, lv3);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glReplacementCodeuiVertex3fvSUN,(GLuint*, GLfloat*),void);
value glstub_glReplacementCodeuiVertex3fvSUN(value v0, value v1)
{
	CAMLparam2(v0, v1);
	GLuint* lv0 = Data_bigarray_val(v0);
	GLfloat* lv1 = Data_bigarray_val(v1);
	LOAD_FUNCTION(glReplacementCodeuiVertex3fvSUN);
	(*stub_glReplacementCodeuiVertex3fvSUN)(lv0, lv1);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glReplacementCodeuivSUN,(GLuint*),void);
value glstub_glReplacementCodeuivSUN(value v0)
{
	CAMLparam1(v0);
	GLuint* lv0 = Data_bigarray_val(v0);
	LOAD_FUNCTION(glReplacementCodeuivSUN);
	(*stub_glReplacementCodeuivSUN)(lv0);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glReplacementCodeusSUN,(GLushort),void);
value glstub_glReplacementCodeusSUN(value v0)
{
	CAMLparam1(v0);
	GLushort lv0 = Int_val(v0);
	LOAD_FUNCTION(glReplacementCodeusSUN);
	(*stub_glReplacementCodeusSUN)(lv0);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glReplacementCodeusvSUN,(GLushort*),void);
value glstub_glReplacementCodeusvSUN(value v0)
{
	CAMLparam1(v0);
	GLushort* lv0 = Data_bigarray_val(v0);
	LOAD_FUNCTION(glReplacementCodeusvSUN);
	(*stub_glReplacementCodeusvSUN)(lv0);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glRequestResidentProgramsNV,(GLsizei, GLuint*),void);
value glstub_glRequestResidentProgramsNV(value v0, value v1)
{
	CAMLparam2(v0, v1);
	GLsizei lv0 = Int_val(v0);
	GLuint* lv1 = Data_bigarray_val(v1);
	LOAD_FUNCTION(glRequestResidentProgramsNV);
	(*stub_glRequestResidentProgramsNV)(lv0, lv1);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glResetHistogram,(GLenum),void);
value glstub_glResetHistogram(value v0)
{
	CAMLparam1(v0);
	GLenum lv0 = Int_val(v0);
	LOAD_FUNCTION(glResetHistogram);
	(*stub_glResetHistogram)(lv0);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glResetHistogramEXT,(GLenum),void);
value glstub_glResetHistogramEXT(value v0)
{
	CAMLparam1(v0);
	GLenum lv0 = Int_val(v0);
	LOAD_FUNCTION(glResetHistogramEXT);
	(*stub_glResetHistogramEXT)(lv0);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glResetMinmax,(GLenum),void);
value glstub_glResetMinmax(value v0)
{
	CAMLparam1(v0);
	GLenum lv0 = Int_val(v0);
	LOAD_FUNCTION(glResetMinmax);
	(*stub_glResetMinmax)(lv0);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glResetMinmaxEXT,(GLenum),void);
value glstub_glResetMinmaxEXT(value v0)
{
	CAMLparam1(v0);
	GLenum lv0 = Int_val(v0);
	LOAD_FUNCTION(glResetMinmaxEXT);
	(*stub_glResetMinmaxEXT)(lv0);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glResizeBuffersMESA,(void),void);
value glstub_glResizeBuffersMESA(value v0)
{
	CAMLparam1(v0);
	LOAD_FUNCTION(glResizeBuffersMESA);
	(*stub_glResizeBuffersMESA)();
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glRotated,(GLdouble, GLdouble, GLdouble, GLdouble),void);
value glstub_glRotated(value v0, value v1, value v2, value v3)
{
	CAMLparam4(v0, v1, v2, v3);
	GLdouble lv0 = Double_val(v0);
	GLdouble lv1 = Double_val(v1);
	GLdouble lv2 = Double_val(v2);
	GLdouble lv3 = Double_val(v3);
	LOAD_FUNCTION(glRotated);
	(*stub_glRotated)(lv0, lv1, lv2, lv3);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glRotatef,(GLfloat, GLfloat, GLfloat, GLfloat),void);
value glstub_glRotatef(value v0, value v1, value v2, value v3)
{
	CAMLparam4(v0, v1, v2, v3);
	GLfloat lv0 = Double_val(v0);
	GLfloat lv1 = Double_val(v1);
	GLfloat lv2 = Double_val(v2);
	GLfloat lv3 = Double_val(v3);
	LOAD_FUNCTION(glRotatef);
	(*stub_glRotatef)(lv0, lv1, lv2, lv3);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glSampleCoverage,(GLclampf, GLboolean),void);
value glstub_glSampleCoverage(value v0, value v1)
{
	CAMLparam2(v0, v1);
	GLclampf lv0 = Double_val(v0);
	GLboolean lv1 = Bool_val(v1);
	LOAD_FUNCTION(glSampleCoverage);
	(*stub_glSampleCoverage)(lv0, lv1);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glSampleCoverageARB,(GLclampf, GLboolean),void);
value glstub_glSampleCoverageARB(value v0, value v1)
{
	CAMLparam2(v0, v1);
	GLclampf lv0 = Double_val(v0);
	GLboolean lv1 = Bool_val(v1);
	LOAD_FUNCTION(glSampleCoverageARB);
	(*stub_glSampleCoverageARB)(lv0, lv1);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glSampleMapATI,(GLuint, GLuint, GLenum),void);
value glstub_glSampleMapATI(value v0, value v1, value v2)
{
	CAMLparam3(v0, v1, v2);
	GLuint lv0 = Int_val(v0);
	GLuint lv1 = Int_val(v1);
	GLenum lv2 = Int_val(v2);
	LOAD_FUNCTION(glSampleMapATI);
	(*stub_glSampleMapATI)(lv0, lv1, lv2);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glSampleMaskEXT,(GLclampf, GLboolean),void);
value glstub_glSampleMaskEXT(value v0, value v1)
{
	CAMLparam2(v0, v1);
	GLclampf lv0 = Double_val(v0);
	GLboolean lv1 = Bool_val(v1);
	LOAD_FUNCTION(glSampleMaskEXT);
	(*stub_glSampleMaskEXT)(lv0, lv1);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glSampleMaskSGIS,(GLclampf, GLboolean),void);
value glstub_glSampleMaskSGIS(value v0, value v1)
{
	CAMLparam2(v0, v1);
	GLclampf lv0 = Double_val(v0);
	GLboolean lv1 = Bool_val(v1);
	LOAD_FUNCTION(glSampleMaskSGIS);
	(*stub_glSampleMaskSGIS)(lv0, lv1);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glSamplePatternEXT,(GLenum),void);
value glstub_glSamplePatternEXT(value v0)
{
	CAMLparam1(v0);
	GLenum lv0 = Int_val(v0);
	LOAD_FUNCTION(glSamplePatternEXT);
	(*stub_glSamplePatternEXT)(lv0);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glSamplePatternSGIS,(GLenum),void);
value glstub_glSamplePatternSGIS(value v0)
{
	CAMLparam1(v0);
	GLenum lv0 = Int_val(v0);
	LOAD_FUNCTION(glSamplePatternSGIS);
	(*stub_glSamplePatternSGIS)(lv0);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glScaled,(GLdouble, GLdouble, GLdouble),void);
value glstub_glScaled(value v0, value v1, value v2)
{
	CAMLparam3(v0, v1, v2);
	GLdouble lv0 = Double_val(v0);
	GLdouble lv1 = Double_val(v1);
	GLdouble lv2 = Double_val(v2);
	LOAD_FUNCTION(glScaled);
	(*stub_glScaled)(lv0, lv1, lv2);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glScalef,(GLfloat, GLfloat, GLfloat),void);
value glstub_glScalef(value v0, value v1, value v2)
{
	CAMLparam3(v0, v1, v2);
	GLfloat lv0 = Double_val(v0);
	GLfloat lv1 = Double_val(v1);
	GLfloat lv2 = Double_val(v2);
	LOAD_FUNCTION(glScalef);
	(*stub_glScalef)(lv0, lv1, lv2);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glScissor,(GLint, GLint, GLsizei, GLsizei),void);
value glstub_glScissor(value v0, value v1, value v2, value v3)
{
	CAMLparam4(v0, v1, v2, v3);
	GLint lv0 = Int_val(v0);
	GLint lv1 = Int_val(v1);
	GLsizei lv2 = Int_val(v2);
	GLsizei lv3 = Int_val(v3);
	LOAD_FUNCTION(glScissor);
	(*stub_glScissor)(lv0, lv1, lv2, lv3);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glSecondaryColor3b,(GLbyte, GLbyte, GLbyte),void);
value glstub_glSecondaryColor3b(value v0, value v1, value v2)
{
	CAMLparam3(v0, v1, v2);
	GLbyte lv0 = Int_val(v0);
	GLbyte lv1 = Int_val(v1);
	GLbyte lv2 = Int_val(v2);
	LOAD_FUNCTION(glSecondaryColor3b);
	(*stub_glSecondaryColor3b)(lv0, lv1, lv2);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glSecondaryColor3bEXT,(GLbyte, GLbyte, GLbyte),void);
value glstub_glSecondaryColor3bEXT(value v0, value v1, value v2)
{
	CAMLparam3(v0, v1, v2);
	GLbyte lv0 = Int_val(v0);
	GLbyte lv1 = Int_val(v1);
	GLbyte lv2 = Int_val(v2);
	LOAD_FUNCTION(glSecondaryColor3bEXT);
	(*stub_glSecondaryColor3bEXT)(lv0, lv1, lv2);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glSecondaryColor3bv,(GLbyte*),void);
value glstub_glSecondaryColor3bv(value v0)
{
	CAMLparam1(v0);
	GLbyte* lv0 = Data_bigarray_val(v0);
	LOAD_FUNCTION(glSecondaryColor3bv);
	(*stub_glSecondaryColor3bv)(lv0);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glSecondaryColor3bvEXT,(GLbyte*),void);
value glstub_glSecondaryColor3bvEXT(value v0)
{
	CAMLparam1(v0);
	GLbyte* lv0 = Data_bigarray_val(v0);
	LOAD_FUNCTION(glSecondaryColor3bvEXT);
	(*stub_glSecondaryColor3bvEXT)(lv0);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glSecondaryColor3d,(GLdouble, GLdouble, GLdouble),void);
value glstub_glSecondaryColor3d(value v0, value v1, value v2)
{
	CAMLparam3(v0, v1, v2);
	GLdouble lv0 = Double_val(v0);
	GLdouble lv1 = Double_val(v1);
	GLdouble lv2 = Double_val(v2);
	LOAD_FUNCTION(glSecondaryColor3d);
	(*stub_glSecondaryColor3d)(lv0, lv1, lv2);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glSecondaryColor3dEXT,(GLdouble, GLdouble, GLdouble),void);
value glstub_glSecondaryColor3dEXT(value v0, value v1, value v2)
{
	CAMLparam3(v0, v1, v2);
	GLdouble lv0 = Double_val(v0);
	GLdouble lv1 = Double_val(v1);
	GLdouble lv2 = Double_val(v2);
	LOAD_FUNCTION(glSecondaryColor3dEXT);
	(*stub_glSecondaryColor3dEXT)(lv0, lv1, lv2);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glSecondaryColor3dv,(GLdouble*),void);
value glstub_glSecondaryColor3dv(value v0)
{
	CAMLparam1(v0);
	GLdouble* lv0 = (Tag_val(v0) == Double_array_tag)? (double *)v0: Data_bigarray_val(v0);
	LOAD_FUNCTION(glSecondaryColor3dv);
	(*stub_glSecondaryColor3dv)(lv0);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glSecondaryColor3dvEXT,(GLdouble*),void);
value glstub_glSecondaryColor3dvEXT(value v0)
{
	CAMLparam1(v0);
	GLdouble* lv0 = (Tag_val(v0) == Double_array_tag)? (double *)v0: Data_bigarray_val(v0);
	LOAD_FUNCTION(glSecondaryColor3dvEXT);
	(*stub_glSecondaryColor3dvEXT)(lv0);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glSecondaryColor3f,(GLfloat, GLfloat, GLfloat),void);
value glstub_glSecondaryColor3f(value v0, value v1, value v2)
{
	CAMLparam3(v0, v1, v2);
	GLfloat lv0 = Double_val(v0);
	GLfloat lv1 = Double_val(v1);
	GLfloat lv2 = Double_val(v2);
	LOAD_FUNCTION(glSecondaryColor3f);
	(*stub_glSecondaryColor3f)(lv0, lv1, lv2);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glSecondaryColor3fEXT,(GLfloat, GLfloat, GLfloat),void);
value glstub_glSecondaryColor3fEXT(value v0, value v1, value v2)
{
	CAMLparam3(v0, v1, v2);
	GLfloat lv0 = Double_val(v0);
	GLfloat lv1 = Double_val(v1);
	GLfloat lv2 = Double_val(v2);
	LOAD_FUNCTION(glSecondaryColor3fEXT);
	(*stub_glSecondaryColor3fEXT)(lv0, lv1, lv2);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glSecondaryColor3fv,(GLfloat*),void);
value glstub_glSecondaryColor3fv(value v0)
{
	CAMLparam1(v0);
	GLfloat* lv0 = Data_bigarray_val(v0);
	LOAD_FUNCTION(glSecondaryColor3fv);
	(*stub_glSecondaryColor3fv)(lv0);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glSecondaryColor3fvEXT,(GLfloat*),void);
value glstub_glSecondaryColor3fvEXT(value v0)
{
	CAMLparam1(v0);
	GLfloat* lv0 = Data_bigarray_val(v0);
	LOAD_FUNCTION(glSecondaryColor3fvEXT);
	(*stub_glSecondaryColor3fvEXT)(lv0);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glSecondaryColor3hNV,(GLushort, GLushort, GLushort),void);
value glstub_glSecondaryColor3hNV(value v0, value v1, value v2)
{
	CAMLparam3(v0, v1, v2);
	GLushort lv0 = Int_val(v0);
	GLushort lv1 = Int_val(v1);
	GLushort lv2 = Int_val(v2);
	LOAD_FUNCTION(glSecondaryColor3hNV);
	(*stub_glSecondaryColor3hNV)(lv0, lv1, lv2);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glSecondaryColor3hvNV,(GLushort*),void);
value glstub_glSecondaryColor3hvNV(value v0)
{
	CAMLparam1(v0);
	GLushort* lv0 = Data_bigarray_val(v0);
	LOAD_FUNCTION(glSecondaryColor3hvNV);
	(*stub_glSecondaryColor3hvNV)(lv0);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glSecondaryColor3i,(GLint, GLint, GLint),void);
value glstub_glSecondaryColor3i(value v0, value v1, value v2)
{
	CAMLparam3(v0, v1, v2);
	GLint lv0 = Int_val(v0);
	GLint lv1 = Int_val(v1);
	GLint lv2 = Int_val(v2);
	LOAD_FUNCTION(glSecondaryColor3i);
	(*stub_glSecondaryColor3i)(lv0, lv1, lv2);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glSecondaryColor3iEXT,(GLint, GLint, GLint),void);
value glstub_glSecondaryColor3iEXT(value v0, value v1, value v2)
{
	CAMLparam3(v0, v1, v2);
	GLint lv0 = Int_val(v0);
	GLint lv1 = Int_val(v1);
	GLint lv2 = Int_val(v2);
	LOAD_FUNCTION(glSecondaryColor3iEXT);
	(*stub_glSecondaryColor3iEXT)(lv0, lv1, lv2);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glSecondaryColor3iv,(GLint*),void);
value glstub_glSecondaryColor3iv(value v0)
{
	CAMLparam1(v0);
	GLint* lv0 = Data_bigarray_val(v0);
	LOAD_FUNCTION(glSecondaryColor3iv);
	(*stub_glSecondaryColor3iv)(lv0);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glSecondaryColor3ivEXT,(GLint*),void);
value glstub_glSecondaryColor3ivEXT(value v0)
{
	CAMLparam1(v0);
	GLint* lv0 = Data_bigarray_val(v0);
	LOAD_FUNCTION(glSecondaryColor3ivEXT);
	(*stub_glSecondaryColor3ivEXT)(lv0);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glSecondaryColor3s,(GLshort, GLshort, GLshort),void);
value glstub_glSecondaryColor3s(value v0, value v1, value v2)
{
	CAMLparam3(v0, v1, v2);
	GLshort lv0 = Int_val(v0);
	GLshort lv1 = Int_val(v1);
	GLshort lv2 = Int_val(v2);
	LOAD_FUNCTION(glSecondaryColor3s);
	(*stub_glSecondaryColor3s)(lv0, lv1, lv2);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glSecondaryColor3sEXT,(GLshort, GLshort, GLshort),void);
value glstub_glSecondaryColor3sEXT(value v0, value v1, value v2)
{
	CAMLparam3(v0, v1, v2);
	GLshort lv0 = Int_val(v0);
	GLshort lv1 = Int_val(v1);
	GLshort lv2 = Int_val(v2);
	LOAD_FUNCTION(glSecondaryColor3sEXT);
	(*stub_glSecondaryColor3sEXT)(lv0, lv1, lv2);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glSecondaryColor3sv,(GLshort*),void);
value glstub_glSecondaryColor3sv(value v0)
{
	CAMLparam1(v0);
	GLshort* lv0 = Data_bigarray_val(v0);
	LOAD_FUNCTION(glSecondaryColor3sv);
	(*stub_glSecondaryColor3sv)(lv0);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glSecondaryColor3svEXT,(GLshort*),void);
value glstub_glSecondaryColor3svEXT(value v0)
{
	CAMLparam1(v0);
	GLshort* lv0 = Data_bigarray_val(v0);
	LOAD_FUNCTION(glSecondaryColor3svEXT);
	(*stub_glSecondaryColor3svEXT)(lv0);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glSecondaryColor3ub,(GLubyte, GLubyte, GLubyte),void);
value glstub_glSecondaryColor3ub(value v0, value v1, value v2)
{
	CAMLparam3(v0, v1, v2);
	GLubyte lv0 = Int_val(v0);
	GLubyte lv1 = Int_val(v1);
	GLubyte lv2 = Int_val(v2);
	LOAD_FUNCTION(glSecondaryColor3ub);
	(*stub_glSecondaryColor3ub)(lv0, lv1, lv2);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glSecondaryColor3ubEXT,(GLubyte, GLubyte, GLubyte),void);
value glstub_glSecondaryColor3ubEXT(value v0, value v1, value v2)
{
	CAMLparam3(v0, v1, v2);
	GLubyte lv0 = Int_val(v0);
	GLubyte lv1 = Int_val(v1);
	GLubyte lv2 = Int_val(v2);
	LOAD_FUNCTION(glSecondaryColor3ubEXT);
	(*stub_glSecondaryColor3ubEXT)(lv0, lv1, lv2);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glSecondaryColor3ubv,(GLubyte*),void);
value glstub_glSecondaryColor3ubv(value v0)
{
	CAMLparam1(v0);
	GLubyte* lv0 = Data_bigarray_val(v0);
	LOAD_FUNCTION(glSecondaryColor3ubv);
	(*stub_glSecondaryColor3ubv)(lv0);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glSecondaryColor3ubvEXT,(GLubyte*),void);
value glstub_glSecondaryColor3ubvEXT(value v0)
{
	CAMLparam1(v0);
	GLubyte* lv0 = Data_bigarray_val(v0);
	LOAD_FUNCTION(glSecondaryColor3ubvEXT);
	(*stub_glSecondaryColor3ubvEXT)(lv0);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glSecondaryColor3ui,(GLuint, GLuint, GLuint),void);
value glstub_glSecondaryColor3ui(value v0, value v1, value v2)
{
	CAMLparam3(v0, v1, v2);
	GLuint lv0 = Int_val(v0);
	GLuint lv1 = Int_val(v1);
	GLuint lv2 = Int_val(v2);
	LOAD_FUNCTION(glSecondaryColor3ui);
	(*stub_glSecondaryColor3ui)(lv0, lv1, lv2);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glSecondaryColor3uiEXT,(GLuint, GLuint, GLuint),void);
value glstub_glSecondaryColor3uiEXT(value v0, value v1, value v2)
{
	CAMLparam3(v0, v1, v2);
	GLuint lv0 = Int_val(v0);
	GLuint lv1 = Int_val(v1);
	GLuint lv2 = Int_val(v2);
	LOAD_FUNCTION(glSecondaryColor3uiEXT);
	(*stub_glSecondaryColor3uiEXT)(lv0, lv1, lv2);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glSecondaryColor3uiv,(GLuint*),void);
value glstub_glSecondaryColor3uiv(value v0)
{
	CAMLparam1(v0);
	GLuint* lv0 = Data_bigarray_val(v0);
	LOAD_FUNCTION(glSecondaryColor3uiv);
	(*stub_glSecondaryColor3uiv)(lv0);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glSecondaryColor3uivEXT,(GLuint*),void);
value glstub_glSecondaryColor3uivEXT(value v0)
{
	CAMLparam1(v0);
	GLuint* lv0 = Data_bigarray_val(v0);
	LOAD_FUNCTION(glSecondaryColor3uivEXT);
	(*stub_glSecondaryColor3uivEXT)(lv0);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glSecondaryColor3us,(GLushort, GLushort, GLushort),void);
value glstub_glSecondaryColor3us(value v0, value v1, value v2)
{
	CAMLparam3(v0, v1, v2);
	GLushort lv0 = Int_val(v0);
	GLushort lv1 = Int_val(v1);
	GLushort lv2 = Int_val(v2);
	LOAD_FUNCTION(glSecondaryColor3us);
	(*stub_glSecondaryColor3us)(lv0, lv1, lv2);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glSecondaryColor3usEXT,(GLushort, GLushort, GLushort),void);
value glstub_glSecondaryColor3usEXT(value v0, value v1, value v2)
{
	CAMLparam3(v0, v1, v2);
	GLushort lv0 = Int_val(v0);
	GLushort lv1 = Int_val(v1);
	GLushort lv2 = Int_val(v2);
	LOAD_FUNCTION(glSecondaryColor3usEXT);
	(*stub_glSecondaryColor3usEXT)(lv0, lv1, lv2);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glSecondaryColor3usv,(GLushort*),void);
value glstub_glSecondaryColor3usv(value v0)
{
	CAMLparam1(v0);
	GLushort* lv0 = Data_bigarray_val(v0);
	LOAD_FUNCTION(glSecondaryColor3usv);
	(*stub_glSecondaryColor3usv)(lv0);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glSecondaryColor3usvEXT,(GLushort*),void);
value glstub_glSecondaryColor3usvEXT(value v0)
{
	CAMLparam1(v0);
	GLushort* lv0 = Data_bigarray_val(v0);
	LOAD_FUNCTION(glSecondaryColor3usvEXT);
	(*stub_glSecondaryColor3usvEXT)(lv0);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glSecondaryColorPointer,(GLint, GLenum, GLsizei, GLvoid*),void);
value glstub_glSecondaryColorPointer(value v0, value v1, value v2, value v3)
{
	CAMLparam4(v0, v1, v2, v3);
	GLint lv0 = Int_val(v0);
	GLenum lv1 = Int_val(v1);
	GLsizei lv2 = Int_val(v2);
	GLvoid* lv3 = (GLvoid *)((Tag_val(v3) == String_tag)? (String_val(v3)) : (Data_bigarray_val(v3)));
	LOAD_FUNCTION(glSecondaryColorPointer);
	(*stub_glSecondaryColorPointer)(lv0, lv1, lv2, lv3);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glSecondaryColorPointerEXT,(GLint, GLenum, GLsizei, GLvoid*),void);
value glstub_glSecondaryColorPointerEXT(value v0, value v1, value v2, value v3)
{
	CAMLparam4(v0, v1, v2, v3);
	GLint lv0 = Int_val(v0);
	GLenum lv1 = Int_val(v1);
	GLsizei lv2 = Int_val(v2);
	GLvoid* lv3 = (GLvoid *)((Tag_val(v3) == String_tag)? (String_val(v3)) : (Data_bigarray_val(v3)));
	LOAD_FUNCTION(glSecondaryColorPointerEXT);
	(*stub_glSecondaryColorPointerEXT)(lv0, lv1, lv2, lv3);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glSecondaryColorPointerListIBM,(GLint, GLenum, GLint, GLvoid**, GLint),void);
value glstub_glSecondaryColorPointerListIBM(value v0, value v1, value v2, value v3, value v4)
{
	CAMLparam5(v0, v1, v2, v3, v4);
	GLint lv0 = Int_val(v0);
	GLenum lv1 = Int_val(v1);
	GLint lv2 = Int_val(v2);
	GLvoid** lv3 = Data_bigarray_val(v3);
	GLint lv4 = Int_val(v4);
	LOAD_FUNCTION(glSecondaryColorPointerListIBM);
	(*stub_glSecondaryColorPointerListIBM)(lv0, lv1, lv2, lv3, lv4);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glSelectBuffer,(GLsizei, GLuint*),void);
value glstub_glSelectBuffer(value v0, value v1)
{
	CAMLparam2(v0, v1);
	GLsizei lv0 = Int_val(v0);
	GLuint* lv1 = Data_bigarray_val(v1);
	LOAD_FUNCTION(glSelectBuffer);
	(*stub_glSelectBuffer)(lv0, lv1);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glSeparableFilter2D,(GLenum, GLenum, GLsizei, GLsizei, GLenum, GLenum, GLvoid*, GLvoid*),void);
value glstub_glSeparableFilter2D(value v0, value v1, value v2, value v3, value v4, value v5, value v6, value v7)
{
	CAMLparam5(v0, v1, v2, v3, v4);
	CAMLxparam3(v5, v6, v7);
	GLenum lv0 = Int_val(v0);
	GLenum lv1 = Int_val(v1);
	GLsizei lv2 = Int_val(v2);
	GLsizei lv3 = Int_val(v3);
	GLenum lv4 = Int_val(v4);
	GLenum lv5 = Int_val(v5);
	GLvoid* lv6 = (GLvoid *)((Tag_val(v6) == String_tag)? (String_val(v6)) : (Data_bigarray_val(v6)));
	GLvoid* lv7 = (GLvoid *)((Tag_val(v7) == String_tag)? (String_val(v7)) : (Data_bigarray_val(v7)));
	LOAD_FUNCTION(glSeparableFilter2D);
	(*stub_glSeparableFilter2D)(lv0, lv1, lv2, lv3, lv4, lv5, lv6, lv7);
	CAMLreturn(Val_unit);
}

value glstub_glSeparableFilter2D_byte(value * argv, int n)
{
	return glstub_glSeparableFilter2D(argv[0], argv[1], argv[2], argv[3], argv[4], argv[5], argv[6], argv[7]);
}

DECLARE_FUNCTION(glSeparableFilter2DEXT,(GLenum, GLenum, GLsizei, GLsizei, GLenum, GLenum, GLvoid*, GLvoid*),void);
value glstub_glSeparableFilter2DEXT(value v0, value v1, value v2, value v3, value v4, value v5, value v6, value v7)
{
	CAMLparam5(v0, v1, v2, v3, v4);
	CAMLxparam3(v5, v6, v7);
	GLenum lv0 = Int_val(v0);
	GLenum lv1 = Int_val(v1);
	GLsizei lv2 = Int_val(v2);
	GLsizei lv3 = Int_val(v3);
	GLenum lv4 = Int_val(v4);
	GLenum lv5 = Int_val(v5);
	GLvoid* lv6 = (GLvoid *)((Tag_val(v6) == String_tag)? (String_val(v6)) : (Data_bigarray_val(v6)));
	GLvoid* lv7 = (GLvoid *)((Tag_val(v7) == String_tag)? (String_val(v7)) : (Data_bigarray_val(v7)));
	LOAD_FUNCTION(glSeparableFilter2DEXT);
	(*stub_glSeparableFilter2DEXT)(lv0, lv1, lv2, lv3, lv4, lv5, lv6, lv7);
	CAMLreturn(Val_unit);
}

value glstub_glSeparableFilter2DEXT_byte(value * argv, int n)
{
	return glstub_glSeparableFilter2DEXT(argv[0], argv[1], argv[2], argv[3], argv[4], argv[5], argv[6], argv[7]);
}

DECLARE_FUNCTION(glSetFenceAPPLE,(GLuint),void);
value glstub_glSetFenceAPPLE(value v0)
{
	CAMLparam1(v0);
	GLuint lv0 = Int_val(v0);
	LOAD_FUNCTION(glSetFenceAPPLE);
	(*stub_glSetFenceAPPLE)(lv0);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glSetFenceNV,(GLuint, GLenum),void);
value glstub_glSetFenceNV(value v0, value v1)
{
	CAMLparam2(v0, v1);
	GLuint lv0 = Int_val(v0);
	GLenum lv1 = Int_val(v1);
	LOAD_FUNCTION(glSetFenceNV);
	(*stub_glSetFenceNV)(lv0, lv1);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glSetFragmentShaderConstantATI,(GLuint, GLfloat*),void);
value glstub_glSetFragmentShaderConstantATI(value v0, value v1)
{
	CAMLparam2(v0, v1);
	GLuint lv0 = Int_val(v0);
	GLfloat* lv1 = Data_bigarray_val(v1);
	LOAD_FUNCTION(glSetFragmentShaderConstantATI);
	(*stub_glSetFragmentShaderConstantATI)(lv0, lv1);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glSetInvariantEXT,(GLuint, GLenum, GLvoid*),void);
value glstub_glSetInvariantEXT(value v0, value v1, value v2)
{
	CAMLparam3(v0, v1, v2);
	GLuint lv0 = Int_val(v0);
	GLenum lv1 = Int_val(v1);
	GLvoid* lv2 = (GLvoid *)((Tag_val(v2) == String_tag)? (String_val(v2)) : (Data_bigarray_val(v2)));
	LOAD_FUNCTION(glSetInvariantEXT);
	(*stub_glSetInvariantEXT)(lv0, lv1, lv2);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glSetLocalConstantEXT,(GLuint, GLenum, GLvoid*),void);
value glstub_glSetLocalConstantEXT(value v0, value v1, value v2)
{
	CAMLparam3(v0, v1, v2);
	GLuint lv0 = Int_val(v0);
	GLenum lv1 = Int_val(v1);
	GLvoid* lv2 = (GLvoid *)((Tag_val(v2) == String_tag)? (String_val(v2)) : (Data_bigarray_val(v2)));
	LOAD_FUNCTION(glSetLocalConstantEXT);
	(*stub_glSetLocalConstantEXT)(lv0, lv1, lv2);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glShadeModel,(GLenum),void);
value glstub_glShadeModel(value v0)
{
	CAMLparam1(v0);
	GLenum lv0 = Int_val(v0);
	LOAD_FUNCTION(glShadeModel);
	(*stub_glShadeModel)(lv0);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glShaderOp1EXT,(GLenum, GLuint, GLuint),void);
value glstub_glShaderOp1EXT(value v0, value v1, value v2)
{
	CAMLparam3(v0, v1, v2);
	GLenum lv0 = Int_val(v0);
	GLuint lv1 = Int_val(v1);
	GLuint lv2 = Int_val(v2);
	LOAD_FUNCTION(glShaderOp1EXT);
	(*stub_glShaderOp1EXT)(lv0, lv1, lv2);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glShaderOp2EXT,(GLenum, GLuint, GLuint, GLuint),void);
value glstub_glShaderOp2EXT(value v0, value v1, value v2, value v3)
{
	CAMLparam4(v0, v1, v2, v3);
	GLenum lv0 = Int_val(v0);
	GLuint lv1 = Int_val(v1);
	GLuint lv2 = Int_val(v2);
	GLuint lv3 = Int_val(v3);
	LOAD_FUNCTION(glShaderOp2EXT);
	(*stub_glShaderOp2EXT)(lv0, lv1, lv2, lv3);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glShaderOp3EXT,(GLenum, GLuint, GLuint, GLuint, GLuint),void);
value glstub_glShaderOp3EXT(value v0, value v1, value v2, value v3, value v4)
{
	CAMLparam5(v0, v1, v2, v3, v4);
	GLenum lv0 = Int_val(v0);
	GLuint lv1 = Int_val(v1);
	GLuint lv2 = Int_val(v2);
	GLuint lv3 = Int_val(v3);
	GLuint lv4 = Int_val(v4);
	LOAD_FUNCTION(glShaderOp3EXT);
	(*stub_glShaderOp3EXT)(lv0, lv1, lv2, lv3, lv4);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glShaderSource,(GLuint, GLsizei, GLchar**, GLint*),void);
value glstub_glShaderSource(value v0, value v1, value v2, value v3)
{
	CAMLparam4(v0, v1, v2, v3);
	GLuint lv0 = Int_val(v0);
	GLsizei lv1 = Int_val(v1);
	GLchar** lv2 = (GLchar** )(v2);
	GLint* lv3 = Data_bigarray_val(v3);
	LOAD_FUNCTION(glShaderSource);
	(*stub_glShaderSource)(lv0, lv1, lv2, lv3);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glShaderSourceARB,(GLuint, GLsizei, GLchar**, GLint*),void);
value glstub_glShaderSourceARB(value v0, value v1, value v2, value v3)
{
	CAMLparam4(v0, v1, v2, v3);
	GLuint lv0 = Int_val(v0);
	GLsizei lv1 = Int_val(v1);
	GLchar** lv2 = (GLchar** )(v2);
	GLint* lv3 = Data_bigarray_val(v3);
	LOAD_FUNCTION(glShaderSourceARB);
	(*stub_glShaderSourceARB)(lv0, lv1, lv2, lv3);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glSharpenTexFuncSGIS,(GLenum, GLsizei, GLfloat*),void);
value glstub_glSharpenTexFuncSGIS(value v0, value v1, value v2)
{
	CAMLparam3(v0, v1, v2);
	GLenum lv0 = Int_val(v0);
	GLsizei lv1 = Int_val(v1);
	GLfloat* lv2 = Data_bigarray_val(v2);
	LOAD_FUNCTION(glSharpenTexFuncSGIS);
	(*stub_glSharpenTexFuncSGIS)(lv0, lv1, lv2);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glSpriteParameterfSGIX,(GLenum, GLfloat),void);
value glstub_glSpriteParameterfSGIX(value v0, value v1)
{
	CAMLparam2(v0, v1);
	GLenum lv0 = Int_val(v0);
	GLfloat lv1 = Double_val(v1);
	LOAD_FUNCTION(glSpriteParameterfSGIX);
	(*stub_glSpriteParameterfSGIX)(lv0, lv1);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glSpriteParameterfvSGIX,(GLenum, GLfloat*),void);
value glstub_glSpriteParameterfvSGIX(value v0, value v1)
{
	CAMLparam2(v0, v1);
	GLenum lv0 = Int_val(v0);
	GLfloat* lv1 = Data_bigarray_val(v1);
	LOAD_FUNCTION(glSpriteParameterfvSGIX);
	(*stub_glSpriteParameterfvSGIX)(lv0, lv1);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glSpriteParameteriSGIX,(GLenum, GLint),void);
value glstub_glSpriteParameteriSGIX(value v0, value v1)
{
	CAMLparam2(v0, v1);
	GLenum lv0 = Int_val(v0);
	GLint lv1 = Int_val(v1);
	LOAD_FUNCTION(glSpriteParameteriSGIX);
	(*stub_glSpriteParameteriSGIX)(lv0, lv1);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glSpriteParameterivSGIX,(GLenum, GLint*),void);
value glstub_glSpriteParameterivSGIX(value v0, value v1)
{
	CAMLparam2(v0, v1);
	GLenum lv0 = Int_val(v0);
	GLint* lv1 = Data_bigarray_val(v1);
	LOAD_FUNCTION(glSpriteParameterivSGIX);
	(*stub_glSpriteParameterivSGIX)(lv0, lv1);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glStencilFunc,(GLenum, GLint, GLuint),void);
value glstub_glStencilFunc(value v0, value v1, value v2)
{
	CAMLparam3(v0, v1, v2);
	GLenum lv0 = Int_val(v0);
	GLint lv1 = Int_val(v1);
	GLuint lv2 = Int_val(v2);
	LOAD_FUNCTION(glStencilFunc);
	(*stub_glStencilFunc)(lv0, lv1, lv2);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glStencilFuncSeparate,(GLenum, GLenum, GLint, GLuint),void);
value glstub_glStencilFuncSeparate(value v0, value v1, value v2, value v3)
{
	CAMLparam4(v0, v1, v2, v3);
	GLenum lv0 = Int_val(v0);
	GLenum lv1 = Int_val(v1);
	GLint lv2 = Int_val(v2);
	GLuint lv3 = Int_val(v3);
	LOAD_FUNCTION(glStencilFuncSeparate);
	(*stub_glStencilFuncSeparate)(lv0, lv1, lv2, lv3);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glStencilFuncSeparateATI,(GLenum, GLenum, GLint, GLuint),void);
value glstub_glStencilFuncSeparateATI(value v0, value v1, value v2, value v3)
{
	CAMLparam4(v0, v1, v2, v3);
	GLenum lv0 = Int_val(v0);
	GLenum lv1 = Int_val(v1);
	GLint lv2 = Int_val(v2);
	GLuint lv3 = Int_val(v3);
	LOAD_FUNCTION(glStencilFuncSeparateATI);
	(*stub_glStencilFuncSeparateATI)(lv0, lv1, lv2, lv3);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glStencilMask,(GLuint),void);
value glstub_glStencilMask(value v0)
{
	CAMLparam1(v0);
	GLuint lv0 = Int_val(v0);
	LOAD_FUNCTION(glStencilMask);
	(*stub_glStencilMask)(lv0);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glStencilMaskSeparate,(GLenum, GLuint),void);
value glstub_glStencilMaskSeparate(value v0, value v1)
{
	CAMLparam2(v0, v1);
	GLenum lv0 = Int_val(v0);
	GLuint lv1 = Int_val(v1);
	LOAD_FUNCTION(glStencilMaskSeparate);
	(*stub_glStencilMaskSeparate)(lv0, lv1);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glStencilOp,(GLenum, GLenum, GLenum),void);
value glstub_glStencilOp(value v0, value v1, value v2)
{
	CAMLparam3(v0, v1, v2);
	GLenum lv0 = Int_val(v0);
	GLenum lv1 = Int_val(v1);
	GLenum lv2 = Int_val(v2);
	LOAD_FUNCTION(glStencilOp);
	(*stub_glStencilOp)(lv0, lv1, lv2);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glStencilOpSeparate,(GLenum, GLenum, GLenum, GLenum),void);
value glstub_glStencilOpSeparate(value v0, value v1, value v2, value v3)
{
	CAMLparam4(v0, v1, v2, v3);
	GLenum lv0 = Int_val(v0);
	GLenum lv1 = Int_val(v1);
	GLenum lv2 = Int_val(v2);
	GLenum lv3 = Int_val(v3);
	LOAD_FUNCTION(glStencilOpSeparate);
	(*stub_glStencilOpSeparate)(lv0, lv1, lv2, lv3);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glStencilOpSeparateATI,(GLenum, GLenum, GLenum, GLenum),void);
value glstub_glStencilOpSeparateATI(value v0, value v1, value v2, value v3)
{
	CAMLparam4(v0, v1, v2, v3);
	GLenum lv0 = Int_val(v0);
	GLenum lv1 = Int_val(v1);
	GLenum lv2 = Int_val(v2);
	GLenum lv3 = Int_val(v3);
	LOAD_FUNCTION(glStencilOpSeparateATI);
	(*stub_glStencilOpSeparateATI)(lv0, lv1, lv2, lv3);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glStringMarkerGREMEDY,(GLsizei, GLvoid*),void);
value glstub_glStringMarkerGREMEDY(value v0, value v1)
{
	CAMLparam2(v0, v1);
	GLsizei lv0 = Int_val(v0);
	GLvoid* lv1 = (GLvoid *)((Tag_val(v1) == String_tag)? (String_val(v1)) : (Data_bigarray_val(v1)));
	LOAD_FUNCTION(glStringMarkerGREMEDY);
	(*stub_glStringMarkerGREMEDY)(lv0, lv1);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glSwizzleEXT,(GLuint, GLuint, GLenum, GLenum, GLenum, GLenum),void);
value glstub_glSwizzleEXT(value v0, value v1, value v2, value v3, value v4, value v5)
{
	CAMLparam5(v0, v1, v2, v3, v4);
	CAMLxparam1(v5);
	GLuint lv0 = Int_val(v0);
	GLuint lv1 = Int_val(v1);
	GLenum lv2 = Int_val(v2);
	GLenum lv3 = Int_val(v3);
	GLenum lv4 = Int_val(v4);
	GLenum lv5 = Int_val(v5);
	LOAD_FUNCTION(glSwizzleEXT);
	(*stub_glSwizzleEXT)(lv0, lv1, lv2, lv3, lv4, lv5);
	CAMLreturn(Val_unit);
}

value glstub_glSwizzleEXT_byte(value * argv, int n)
{
	return glstub_glSwizzleEXT(argv[0], argv[1], argv[2], argv[3], argv[4], argv[5]);
}

DECLARE_FUNCTION(glTagSampleBufferSGIX,(void),void);
value glstub_glTagSampleBufferSGIX(value v0)
{
	CAMLparam1(v0);
	LOAD_FUNCTION(glTagSampleBufferSGIX);
	(*stub_glTagSampleBufferSGIX)();
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glTangentPointerEXT,(GLenum, GLsizei, GLvoid*),void);
value glstub_glTangentPointerEXT(value v0, value v1, value v2)
{
	CAMLparam3(v0, v1, v2);
	GLenum lv0 = Int_val(v0);
	GLsizei lv1 = Int_val(v1);
	GLvoid* lv2 = (GLvoid *)((Tag_val(v2) == String_tag)? (String_val(v2)) : (Data_bigarray_val(v2)));
	LOAD_FUNCTION(glTangentPointerEXT);
	(*stub_glTangentPointerEXT)(lv0, lv1, lv2);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glTbufferMask3DFX,(GLuint),void);
value glstub_glTbufferMask3DFX(value v0)
{
	CAMLparam1(v0);
	GLuint lv0 = Int_val(v0);
	LOAD_FUNCTION(glTbufferMask3DFX);
	(*stub_glTbufferMask3DFX)(lv0);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glTestFenceAPPLE,(GLuint),GLboolean);
value glstub_glTestFenceAPPLE(value v0)
{
	CAMLparam1(v0);
	CAMLlocal1(result);
	GLuint lv0 = Int_val(v0);
	GLboolean ret;
	LOAD_FUNCTION(glTestFenceAPPLE);
	ret = (*stub_glTestFenceAPPLE)(lv0);
	result = Val_bool(ret);
	CAMLreturn(result);
}

DECLARE_FUNCTION(glTestFenceNV,(GLuint),GLboolean);
value glstub_glTestFenceNV(value v0)
{
	CAMLparam1(v0);
	CAMLlocal1(result);
	GLuint lv0 = Int_val(v0);
	GLboolean ret;
	LOAD_FUNCTION(glTestFenceNV);
	ret = (*stub_glTestFenceNV)(lv0);
	result = Val_bool(ret);
	CAMLreturn(result);
}

DECLARE_FUNCTION(glTestObjectAPPLE,(GLenum, GLuint),GLboolean);
value glstub_glTestObjectAPPLE(value v0, value v1)
{
	CAMLparam2(v0, v1);
	CAMLlocal1(result);
	GLenum lv0 = Int_val(v0);
	GLuint lv1 = Int_val(v1);
	GLboolean ret;
	LOAD_FUNCTION(glTestObjectAPPLE);
	ret = (*stub_glTestObjectAPPLE)(lv0, lv1);
	result = Val_bool(ret);
	CAMLreturn(result);
}

DECLARE_FUNCTION(glTexBufferEXT,(GLenum, GLenum, GLuint),void);
value glstub_glTexBufferEXT(value v0, value v1, value v2)
{
	CAMLparam3(v0, v1, v2);
	GLenum lv0 = Int_val(v0);
	GLenum lv1 = Int_val(v1);
	GLuint lv2 = Int_val(v2);
	LOAD_FUNCTION(glTexBufferEXT);
	(*stub_glTexBufferEXT)(lv0, lv1, lv2);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glTexBumpParameterfvATI,(GLenum, GLfloat*),void);
value glstub_glTexBumpParameterfvATI(value v0, value v1)
{
	CAMLparam2(v0, v1);
	GLenum lv0 = Int_val(v0);
	GLfloat* lv1 = Data_bigarray_val(v1);
	LOAD_FUNCTION(glTexBumpParameterfvATI);
	(*stub_glTexBumpParameterfvATI)(lv0, lv1);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glTexBumpParameterivATI,(GLenum, GLint*),void);
value glstub_glTexBumpParameterivATI(value v0, value v1)
{
	CAMLparam2(v0, v1);
	GLenum lv0 = Int_val(v0);
	GLint* lv1 = Data_bigarray_val(v1);
	LOAD_FUNCTION(glTexBumpParameterivATI);
	(*stub_glTexBumpParameterivATI)(lv0, lv1);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glTexCoord1d,(GLdouble),void);
value glstub_glTexCoord1d(value v0)
{
	CAMLparam1(v0);
	GLdouble lv0 = Double_val(v0);
	LOAD_FUNCTION(glTexCoord1d);
	(*stub_glTexCoord1d)(lv0);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glTexCoord1dv,(GLdouble*),void);
value glstub_glTexCoord1dv(value v0)
{
	CAMLparam1(v0);
	GLdouble* lv0 = (Tag_val(v0) == Double_array_tag)? (double *)v0: Data_bigarray_val(v0);
	LOAD_FUNCTION(glTexCoord1dv);
	(*stub_glTexCoord1dv)(lv0);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glTexCoord1f,(GLfloat),void);
value glstub_glTexCoord1f(value v0)
{
	CAMLparam1(v0);
	GLfloat lv0 = Double_val(v0);
	LOAD_FUNCTION(glTexCoord1f);
	(*stub_glTexCoord1f)(lv0);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glTexCoord1fv,(GLfloat*),void);
value glstub_glTexCoord1fv(value v0)
{
	CAMLparam1(v0);
	GLfloat* lv0 = Data_bigarray_val(v0);
	LOAD_FUNCTION(glTexCoord1fv);
	(*stub_glTexCoord1fv)(lv0);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glTexCoord1hNV,(GLushort),void);
value glstub_glTexCoord1hNV(value v0)
{
	CAMLparam1(v0);
	GLushort lv0 = Int_val(v0);
	LOAD_FUNCTION(glTexCoord1hNV);
	(*stub_glTexCoord1hNV)(lv0);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glTexCoord1hvNV,(GLushort*),void);
value glstub_glTexCoord1hvNV(value v0)
{
	CAMLparam1(v0);
	GLushort* lv0 = Data_bigarray_val(v0);
	LOAD_FUNCTION(glTexCoord1hvNV);
	(*stub_glTexCoord1hvNV)(lv0);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glTexCoord1i,(GLint),void);
value glstub_glTexCoord1i(value v0)
{
	CAMLparam1(v0);
	GLint lv0 = Int_val(v0);
	LOAD_FUNCTION(glTexCoord1i);
	(*stub_glTexCoord1i)(lv0);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glTexCoord1iv,(GLint*),void);
value glstub_glTexCoord1iv(value v0)
{
	CAMLparam1(v0);
	GLint* lv0 = Data_bigarray_val(v0);
	LOAD_FUNCTION(glTexCoord1iv);
	(*stub_glTexCoord1iv)(lv0);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glTexCoord1s,(GLshort),void);
value glstub_glTexCoord1s(value v0)
{
	CAMLparam1(v0);
	GLshort lv0 = Int_val(v0);
	LOAD_FUNCTION(glTexCoord1s);
	(*stub_glTexCoord1s)(lv0);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glTexCoord1sv,(GLshort*),void);
value glstub_glTexCoord1sv(value v0)
{
	CAMLparam1(v0);
	GLshort* lv0 = Data_bigarray_val(v0);
	LOAD_FUNCTION(glTexCoord1sv);
	(*stub_glTexCoord1sv)(lv0);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glTexCoord2d,(GLdouble, GLdouble),void);
value glstub_glTexCoord2d(value v0, value v1)
{
	CAMLparam2(v0, v1);
	GLdouble lv0 = Double_val(v0);
	GLdouble lv1 = Double_val(v1);
	LOAD_FUNCTION(glTexCoord2d);
	(*stub_glTexCoord2d)(lv0, lv1);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glTexCoord2dv,(GLdouble*),void);
value glstub_glTexCoord2dv(value v0)
{
	CAMLparam1(v0);
	GLdouble* lv0 = (Tag_val(v0) == Double_array_tag)? (double *)v0: Data_bigarray_val(v0);
	LOAD_FUNCTION(glTexCoord2dv);
	(*stub_glTexCoord2dv)(lv0);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glTexCoord2f,(GLfloat, GLfloat),void);
value glstub_glTexCoord2f(value v0, value v1)
{
	CAMLparam2(v0, v1);
	GLfloat lv0 = Double_val(v0);
	GLfloat lv1 = Double_val(v1);
	LOAD_FUNCTION(glTexCoord2f);
	(*stub_glTexCoord2f)(lv0, lv1);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glTexCoord2fColor3fVertex3fSUN,(GLfloat, GLfloat, GLfloat, GLfloat, GLfloat, GLfloat, GLfloat, GLfloat),void);
value glstub_glTexCoord2fColor3fVertex3fSUN(value v0, value v1, value v2, value v3, value v4, value v5, value v6, value v7)
{
	CAMLparam5(v0, v1, v2, v3, v4);
	CAMLxparam3(v5, v6, v7);
	GLfloat lv0 = Double_val(v0);
	GLfloat lv1 = Double_val(v1);
	GLfloat lv2 = Double_val(v2);
	GLfloat lv3 = Double_val(v3);
	GLfloat lv4 = Double_val(v4);
	GLfloat lv5 = Double_val(v5);
	GLfloat lv6 = Double_val(v6);
	GLfloat lv7 = Double_val(v7);
	LOAD_FUNCTION(glTexCoord2fColor3fVertex3fSUN);
	(*stub_glTexCoord2fColor3fVertex3fSUN)(lv0, lv1, lv2, lv3, lv4, lv5, lv6, lv7);
	CAMLreturn(Val_unit);
}

value glstub_glTexCoord2fColor3fVertex3fSUN_byte(value * argv, int n)
{
	return glstub_glTexCoord2fColor3fVertex3fSUN(argv[0], argv[1], argv[2], argv[3], argv[4], argv[5], argv[6], argv[7]);
}

DECLARE_FUNCTION(glTexCoord2fColor3fVertex3fvSUN,(GLfloat*, GLfloat*, GLfloat*),void);
value glstub_glTexCoord2fColor3fVertex3fvSUN(value v0, value v1, value v2)
{
	CAMLparam3(v0, v1, v2);
	GLfloat* lv0 = Data_bigarray_val(v0);
	GLfloat* lv1 = Data_bigarray_val(v1);
	GLfloat* lv2 = Data_bigarray_val(v2);
	LOAD_FUNCTION(glTexCoord2fColor3fVertex3fvSUN);
	(*stub_glTexCoord2fColor3fVertex3fvSUN)(lv0, lv1, lv2);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glTexCoord2fColor4fNormal3fVertex3fSUN,(GLfloat, GLfloat, GLfloat, GLfloat, GLfloat, GLfloat, GLfloat, GLfloat, GLfloat, GLfloat, GLfloat, GLfloat),void);
value glstub_glTexCoord2fColor4fNormal3fVertex3fSUN(value v0, value v1, value v2, value v3, value v4, value v5, value v6, value v7, value v8, value v9, value v10, value v11)
{
	CAMLparam5(v0, v1, v2, v3, v4);
	CAMLxparam5(v5, v6, v7, v8, v9);
	CAMLxparam2(v10, v11);
	GLfloat lv0 = Double_val(v0);
	GLfloat lv1 = Double_val(v1);
	GLfloat lv2 = Double_val(v2);
	GLfloat lv3 = Double_val(v3);
	GLfloat lv4 = Double_val(v4);
	GLfloat lv5 = Double_val(v5);
	GLfloat lv6 = Double_val(v6);
	GLfloat lv7 = Double_val(v7);
	GLfloat lv8 = Double_val(v8);
	GLfloat lv9 = Double_val(v9);
	GLfloat lv10 = Double_val(v10);
	GLfloat lv11 = Double_val(v11);
	LOAD_FUNCTION(glTexCoord2fColor4fNormal3fVertex3fSUN);
	(*stub_glTexCoord2fColor4fNormal3fVertex3fSUN)(lv0, lv1, lv2, lv3, lv4, lv5, lv6, lv7, lv8, lv9, lv10, lv11);
	CAMLreturn(Val_unit);
}

value glstub_glTexCoord2fColor4fNormal3fVertex3fSUN_byte(value * argv, int n)
{
	return glstub_glTexCoord2fColor4fNormal3fVertex3fSUN(argv[0], argv[1], argv[2], argv[3], argv[4], argv[5], argv[6], argv[7], argv[8], argv[9], argv[10], argv[11]);
}

DECLARE_FUNCTION(glTexCoord2fColor4fNormal3fVertex3fvSUN,(GLfloat*, GLfloat*, GLfloat*, GLfloat*),void);
value glstub_glTexCoord2fColor4fNormal3fVertex3fvSUN(value v0, value v1, value v2, value v3)
{
	CAMLparam4(v0, v1, v2, v3);
	GLfloat* lv0 = Data_bigarray_val(v0);
	GLfloat* lv1 = Data_bigarray_val(v1);
	GLfloat* lv2 = Data_bigarray_val(v2);
	GLfloat* lv3 = Data_bigarray_val(v3);
	LOAD_FUNCTION(glTexCoord2fColor4fNormal3fVertex3fvSUN);
	(*stub_glTexCoord2fColor4fNormal3fVertex3fvSUN)(lv0, lv1, lv2, lv3);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glTexCoord2fColor4ubVertex3fSUN,(GLfloat, GLfloat, GLubyte, GLubyte, GLubyte, GLubyte, GLfloat, GLfloat, GLfloat),void);
value glstub_glTexCoord2fColor4ubVertex3fSUN(value v0, value v1, value v2, value v3, value v4, value v5, value v6, value v7, value v8)
{
	CAMLparam5(v0, v1, v2, v3, v4);
	CAMLxparam4(v5, v6, v7, v8);
	GLfloat lv0 = Double_val(v0);
	GLfloat lv1 = Double_val(v1);
	GLubyte lv2 = Int_val(v2);
	GLubyte lv3 = Int_val(v3);
	GLubyte lv4 = Int_val(v4);
	GLubyte lv5 = Int_val(v5);
	GLfloat lv6 = Double_val(v6);
	GLfloat lv7 = Double_val(v7);
	GLfloat lv8 = Double_val(v8);
	LOAD_FUNCTION(glTexCoord2fColor4ubVertex3fSUN);
	(*stub_glTexCoord2fColor4ubVertex3fSUN)(lv0, lv1, lv2, lv3, lv4, lv5, lv6, lv7, lv8);
	CAMLreturn(Val_unit);
}

value glstub_glTexCoord2fColor4ubVertex3fSUN_byte(value * argv, int n)
{
	return glstub_glTexCoord2fColor4ubVertex3fSUN(argv[0], argv[1], argv[2], argv[3], argv[4], argv[5], argv[6], argv[7], argv[8]);
}

DECLARE_FUNCTION(glTexCoord2fColor4ubVertex3fvSUN,(GLfloat*, GLubyte*, GLfloat*),void);
value glstub_glTexCoord2fColor4ubVertex3fvSUN(value v0, value v1, value v2)
{
	CAMLparam3(v0, v1, v2);
	GLfloat* lv0 = Data_bigarray_val(v0);
	GLubyte* lv1 = Data_bigarray_val(v1);
	GLfloat* lv2 = Data_bigarray_val(v2);
	LOAD_FUNCTION(glTexCoord2fColor4ubVertex3fvSUN);
	(*stub_glTexCoord2fColor4ubVertex3fvSUN)(lv0, lv1, lv2);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glTexCoord2fNormal3fVertex3fSUN,(GLfloat, GLfloat, GLfloat, GLfloat, GLfloat, GLfloat, GLfloat, GLfloat),void);
value glstub_glTexCoord2fNormal3fVertex3fSUN(value v0, value v1, value v2, value v3, value v4, value v5, value v6, value v7)
{
	CAMLparam5(v0, v1, v2, v3, v4);
	CAMLxparam3(v5, v6, v7);
	GLfloat lv0 = Double_val(v0);
	GLfloat lv1 = Double_val(v1);
	GLfloat lv2 = Double_val(v2);
	GLfloat lv3 = Double_val(v3);
	GLfloat lv4 = Double_val(v4);
	GLfloat lv5 = Double_val(v5);
	GLfloat lv6 = Double_val(v6);
	GLfloat lv7 = Double_val(v7);
	LOAD_FUNCTION(glTexCoord2fNormal3fVertex3fSUN);
	(*stub_glTexCoord2fNormal3fVertex3fSUN)(lv0, lv1, lv2, lv3, lv4, lv5, lv6, lv7);
	CAMLreturn(Val_unit);
}

value glstub_glTexCoord2fNormal3fVertex3fSUN_byte(value * argv, int n)
{
	return glstub_glTexCoord2fNormal3fVertex3fSUN(argv[0], argv[1], argv[2], argv[3], argv[4], argv[5], argv[6], argv[7]);
}

DECLARE_FUNCTION(glTexCoord2fNormal3fVertex3fvSUN,(GLfloat*, GLfloat*, GLfloat*),void);
value glstub_glTexCoord2fNormal3fVertex3fvSUN(value v0, value v1, value v2)
{
	CAMLparam3(v0, v1, v2);
	GLfloat* lv0 = Data_bigarray_val(v0);
	GLfloat* lv1 = Data_bigarray_val(v1);
	GLfloat* lv2 = Data_bigarray_val(v2);
	LOAD_FUNCTION(glTexCoord2fNormal3fVertex3fvSUN);
	(*stub_glTexCoord2fNormal3fVertex3fvSUN)(lv0, lv1, lv2);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glTexCoord2fVertex3fSUN,(GLfloat, GLfloat, GLfloat, GLfloat, GLfloat),void);
value glstub_glTexCoord2fVertex3fSUN(value v0, value v1, value v2, value v3, value v4)
{
	CAMLparam5(v0, v1, v2, v3, v4);
	GLfloat lv0 = Double_val(v0);
	GLfloat lv1 = Double_val(v1);
	GLfloat lv2 = Double_val(v2);
	GLfloat lv3 = Double_val(v3);
	GLfloat lv4 = Double_val(v4);
	LOAD_FUNCTION(glTexCoord2fVertex3fSUN);
	(*stub_glTexCoord2fVertex3fSUN)(lv0, lv1, lv2, lv3, lv4);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glTexCoord2fVertex3fvSUN,(GLfloat*, GLfloat*),void);
value glstub_glTexCoord2fVertex3fvSUN(value v0, value v1)
{
	CAMLparam2(v0, v1);
	GLfloat* lv0 = Data_bigarray_val(v0);
	GLfloat* lv1 = Data_bigarray_val(v1);
	LOAD_FUNCTION(glTexCoord2fVertex3fvSUN);
	(*stub_glTexCoord2fVertex3fvSUN)(lv0, lv1);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glTexCoord2fv,(GLfloat*),void);
value glstub_glTexCoord2fv(value v0)
{
	CAMLparam1(v0);
	GLfloat* lv0 = Data_bigarray_val(v0);
	LOAD_FUNCTION(glTexCoord2fv);
	(*stub_glTexCoord2fv)(lv0);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glTexCoord2hNV,(GLushort, GLushort),void);
value glstub_glTexCoord2hNV(value v0, value v1)
{
	CAMLparam2(v0, v1);
	GLushort lv0 = Int_val(v0);
	GLushort lv1 = Int_val(v1);
	LOAD_FUNCTION(glTexCoord2hNV);
	(*stub_glTexCoord2hNV)(lv0, lv1);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glTexCoord2hvNV,(GLushort*),void);
value glstub_glTexCoord2hvNV(value v0)
{
	CAMLparam1(v0);
	GLushort* lv0 = Data_bigarray_val(v0);
	LOAD_FUNCTION(glTexCoord2hvNV);
	(*stub_glTexCoord2hvNV)(lv0);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glTexCoord2i,(GLint, GLint),void);
value glstub_glTexCoord2i(value v0, value v1)
{
	CAMLparam2(v0, v1);
	GLint lv0 = Int_val(v0);
	GLint lv1 = Int_val(v1);
	LOAD_FUNCTION(glTexCoord2i);
	(*stub_glTexCoord2i)(lv0, lv1);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glTexCoord2iv,(GLint*),void);
value glstub_glTexCoord2iv(value v0)
{
	CAMLparam1(v0);
	GLint* lv0 = Data_bigarray_val(v0);
	LOAD_FUNCTION(glTexCoord2iv);
	(*stub_glTexCoord2iv)(lv0);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glTexCoord2s,(GLshort, GLshort),void);
value glstub_glTexCoord2s(value v0, value v1)
{
	CAMLparam2(v0, v1);
	GLshort lv0 = Int_val(v0);
	GLshort lv1 = Int_val(v1);
	LOAD_FUNCTION(glTexCoord2s);
	(*stub_glTexCoord2s)(lv0, lv1);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glTexCoord2sv,(GLshort*),void);
value glstub_glTexCoord2sv(value v0)
{
	CAMLparam1(v0);
	GLshort* lv0 = Data_bigarray_val(v0);
	LOAD_FUNCTION(glTexCoord2sv);
	(*stub_glTexCoord2sv)(lv0);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glTexCoord3d,(GLdouble, GLdouble, GLdouble),void);
value glstub_glTexCoord3d(value v0, value v1, value v2)
{
	CAMLparam3(v0, v1, v2);
	GLdouble lv0 = Double_val(v0);
	GLdouble lv1 = Double_val(v1);
	GLdouble lv2 = Double_val(v2);
	LOAD_FUNCTION(glTexCoord3d);
	(*stub_glTexCoord3d)(lv0, lv1, lv2);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glTexCoord3dv,(GLdouble*),void);
value glstub_glTexCoord3dv(value v0)
{
	CAMLparam1(v0);
	GLdouble* lv0 = (Tag_val(v0) == Double_array_tag)? (double *)v0: Data_bigarray_val(v0);
	LOAD_FUNCTION(glTexCoord3dv);
	(*stub_glTexCoord3dv)(lv0);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glTexCoord3f,(GLfloat, GLfloat, GLfloat),void);
value glstub_glTexCoord3f(value v0, value v1, value v2)
{
	CAMLparam3(v0, v1, v2);
	GLfloat lv0 = Double_val(v0);
	GLfloat lv1 = Double_val(v1);
	GLfloat lv2 = Double_val(v2);
	LOAD_FUNCTION(glTexCoord3f);
	(*stub_glTexCoord3f)(lv0, lv1, lv2);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glTexCoord3fv,(GLfloat*),void);
value glstub_glTexCoord3fv(value v0)
{
	CAMLparam1(v0);
	GLfloat* lv0 = Data_bigarray_val(v0);
	LOAD_FUNCTION(glTexCoord3fv);
	(*stub_glTexCoord3fv)(lv0);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glTexCoord3hNV,(GLushort, GLushort, GLushort),void);
value glstub_glTexCoord3hNV(value v0, value v1, value v2)
{
	CAMLparam3(v0, v1, v2);
	GLushort lv0 = Int_val(v0);
	GLushort lv1 = Int_val(v1);
	GLushort lv2 = Int_val(v2);
	LOAD_FUNCTION(glTexCoord3hNV);
	(*stub_glTexCoord3hNV)(lv0, lv1, lv2);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glTexCoord3hvNV,(GLushort*),void);
value glstub_glTexCoord3hvNV(value v0)
{
	CAMLparam1(v0);
	GLushort* lv0 = Data_bigarray_val(v0);
	LOAD_FUNCTION(glTexCoord3hvNV);
	(*stub_glTexCoord3hvNV)(lv0);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glTexCoord3i,(GLint, GLint, GLint),void);
value glstub_glTexCoord3i(value v0, value v1, value v2)
{
	CAMLparam3(v0, v1, v2);
	GLint lv0 = Int_val(v0);
	GLint lv1 = Int_val(v1);
	GLint lv2 = Int_val(v2);
	LOAD_FUNCTION(glTexCoord3i);
	(*stub_glTexCoord3i)(lv0, lv1, lv2);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glTexCoord3iv,(GLint*),void);
value glstub_glTexCoord3iv(value v0)
{
	CAMLparam1(v0);
	GLint* lv0 = Data_bigarray_val(v0);
	LOAD_FUNCTION(glTexCoord3iv);
	(*stub_glTexCoord3iv)(lv0);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glTexCoord3s,(GLshort, GLshort, GLshort),void);
value glstub_glTexCoord3s(value v0, value v1, value v2)
{
	CAMLparam3(v0, v1, v2);
	GLshort lv0 = Int_val(v0);
	GLshort lv1 = Int_val(v1);
	GLshort lv2 = Int_val(v2);
	LOAD_FUNCTION(glTexCoord3s);
	(*stub_glTexCoord3s)(lv0, lv1, lv2);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glTexCoord3sv,(GLshort*),void);
value glstub_glTexCoord3sv(value v0)
{
	CAMLparam1(v0);
	GLshort* lv0 = Data_bigarray_val(v0);
	LOAD_FUNCTION(glTexCoord3sv);
	(*stub_glTexCoord3sv)(lv0);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glTexCoord4d,(GLdouble, GLdouble, GLdouble, GLdouble),void);
value glstub_glTexCoord4d(value v0, value v1, value v2, value v3)
{
	CAMLparam4(v0, v1, v2, v3);
	GLdouble lv0 = Double_val(v0);
	GLdouble lv1 = Double_val(v1);
	GLdouble lv2 = Double_val(v2);
	GLdouble lv3 = Double_val(v3);
	LOAD_FUNCTION(glTexCoord4d);
	(*stub_glTexCoord4d)(lv0, lv1, lv2, lv3);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glTexCoord4dv,(GLdouble*),void);
value glstub_glTexCoord4dv(value v0)
{
	CAMLparam1(v0);
	GLdouble* lv0 = (Tag_val(v0) == Double_array_tag)? (double *)v0: Data_bigarray_val(v0);
	LOAD_FUNCTION(glTexCoord4dv);
	(*stub_glTexCoord4dv)(lv0);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glTexCoord4f,(GLfloat, GLfloat, GLfloat, GLfloat),void);
value glstub_glTexCoord4f(value v0, value v1, value v2, value v3)
{
	CAMLparam4(v0, v1, v2, v3);
	GLfloat lv0 = Double_val(v0);
	GLfloat lv1 = Double_val(v1);
	GLfloat lv2 = Double_val(v2);
	GLfloat lv3 = Double_val(v3);
	LOAD_FUNCTION(glTexCoord4f);
	(*stub_glTexCoord4f)(lv0, lv1, lv2, lv3);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glTexCoord4fColor4fNormal3fVertex4fSUN,(GLfloat, GLfloat, GLfloat, GLfloat, GLfloat, GLfloat, GLfloat, GLfloat, GLfloat, GLfloat, GLfloat, GLfloat, GLfloat, GLfloat, GLfloat),void);
value glstub_glTexCoord4fColor4fNormal3fVertex4fSUN(value v0, value v1, value v2, value v3, value v4, value v5, value v6, value v7, value v8, value v9, value v10, value v11, value v12, value v13, value v14)
{
	CAMLparam5(v0, v1, v2, v3, v4);
	CAMLxparam5(v5, v6, v7, v8, v9);
	CAMLxparam5(v10, v11, v12, v13, v14);
	GLfloat lv0 = Double_val(v0);
	GLfloat lv1 = Double_val(v1);
	GLfloat lv2 = Double_val(v2);
	GLfloat lv3 = Double_val(v3);
	GLfloat lv4 = Double_val(v4);
	GLfloat lv5 = Double_val(v5);
	GLfloat lv6 = Double_val(v6);
	GLfloat lv7 = Double_val(v7);
	GLfloat lv8 = Double_val(v8);
	GLfloat lv9 = Double_val(v9);
	GLfloat lv10 = Double_val(v10);
	GLfloat lv11 = Double_val(v11);
	GLfloat lv12 = Double_val(v12);
	GLfloat lv13 = Double_val(v13);
	GLfloat lv14 = Double_val(v14);
	LOAD_FUNCTION(glTexCoord4fColor4fNormal3fVertex4fSUN);
	(*stub_glTexCoord4fColor4fNormal3fVertex4fSUN)(lv0, lv1, lv2, lv3, lv4, lv5, lv6, lv7, lv8, lv9, lv10, lv11, lv12, lv13, lv14);
	CAMLreturn(Val_unit);
}

value glstub_glTexCoord4fColor4fNormal3fVertex4fSUN_byte(value * argv, int n)
{
	return glstub_glTexCoord4fColor4fNormal3fVertex4fSUN(argv[0], argv[1], argv[2], argv[3], argv[4], argv[5], argv[6], argv[7], argv[8], argv[9], argv[10], argv[11], argv[12], argv[13], argv[14]);
}

DECLARE_FUNCTION(glTexCoord4fColor4fNormal3fVertex4fvSUN,(GLfloat*, GLfloat*, GLfloat*, GLfloat*),void);
value glstub_glTexCoord4fColor4fNormal3fVertex4fvSUN(value v0, value v1, value v2, value v3)
{
	CAMLparam4(v0, v1, v2, v3);
	GLfloat* lv0 = Data_bigarray_val(v0);
	GLfloat* lv1 = Data_bigarray_val(v1);
	GLfloat* lv2 = Data_bigarray_val(v2);
	GLfloat* lv3 = Data_bigarray_val(v3);
	LOAD_FUNCTION(glTexCoord4fColor4fNormal3fVertex4fvSUN);
	(*stub_glTexCoord4fColor4fNormal3fVertex4fvSUN)(lv0, lv1, lv2, lv3);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glTexCoord4fVertex4fSUN,(GLfloat, GLfloat, GLfloat, GLfloat, GLfloat, GLfloat, GLfloat, GLfloat),void);
value glstub_glTexCoord4fVertex4fSUN(value v0, value v1, value v2, value v3, value v4, value v5, value v6, value v7)
{
	CAMLparam5(v0, v1, v2, v3, v4);
	CAMLxparam3(v5, v6, v7);
	GLfloat lv0 = Double_val(v0);
	GLfloat lv1 = Double_val(v1);
	GLfloat lv2 = Double_val(v2);
	GLfloat lv3 = Double_val(v3);
	GLfloat lv4 = Double_val(v4);
	GLfloat lv5 = Double_val(v5);
	GLfloat lv6 = Double_val(v6);
	GLfloat lv7 = Double_val(v7);
	LOAD_FUNCTION(glTexCoord4fVertex4fSUN);
	(*stub_glTexCoord4fVertex4fSUN)(lv0, lv1, lv2, lv3, lv4, lv5, lv6, lv7);
	CAMLreturn(Val_unit);
}

value glstub_glTexCoord4fVertex4fSUN_byte(value * argv, int n)
{
	return glstub_glTexCoord4fVertex4fSUN(argv[0], argv[1], argv[2], argv[3], argv[4], argv[5], argv[6], argv[7]);
}

DECLARE_FUNCTION(glTexCoord4fVertex4fvSUN,(GLfloat*, GLfloat*),void);
value glstub_glTexCoord4fVertex4fvSUN(value v0, value v1)
{
	CAMLparam2(v0, v1);
	GLfloat* lv0 = Data_bigarray_val(v0);
	GLfloat* lv1 = Data_bigarray_val(v1);
	LOAD_FUNCTION(glTexCoord4fVertex4fvSUN);
	(*stub_glTexCoord4fVertex4fvSUN)(lv0, lv1);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glTexCoord4fv,(GLfloat*),void);
value glstub_glTexCoord4fv(value v0)
{
	CAMLparam1(v0);
	GLfloat* lv0 = Data_bigarray_val(v0);
	LOAD_FUNCTION(glTexCoord4fv);
	(*stub_glTexCoord4fv)(lv0);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glTexCoord4hNV,(GLushort, GLushort, GLushort, GLushort),void);
value glstub_glTexCoord4hNV(value v0, value v1, value v2, value v3)
{
	CAMLparam4(v0, v1, v2, v3);
	GLushort lv0 = Int_val(v0);
	GLushort lv1 = Int_val(v1);
	GLushort lv2 = Int_val(v2);
	GLushort lv3 = Int_val(v3);
	LOAD_FUNCTION(glTexCoord4hNV);
	(*stub_glTexCoord4hNV)(lv0, lv1, lv2, lv3);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glTexCoord4hvNV,(GLushort*),void);
value glstub_glTexCoord4hvNV(value v0)
{
	CAMLparam1(v0);
	GLushort* lv0 = Data_bigarray_val(v0);
	LOAD_FUNCTION(glTexCoord4hvNV);
	(*stub_glTexCoord4hvNV)(lv0);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glTexCoord4i,(GLint, GLint, GLint, GLint),void);
value glstub_glTexCoord4i(value v0, value v1, value v2, value v3)
{
	CAMLparam4(v0, v1, v2, v3);
	GLint lv0 = Int_val(v0);
	GLint lv1 = Int_val(v1);
	GLint lv2 = Int_val(v2);
	GLint lv3 = Int_val(v3);
	LOAD_FUNCTION(glTexCoord4i);
	(*stub_glTexCoord4i)(lv0, lv1, lv2, lv3);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glTexCoord4iv,(GLint*),void);
value glstub_glTexCoord4iv(value v0)
{
	CAMLparam1(v0);
	GLint* lv0 = Data_bigarray_val(v0);
	LOAD_FUNCTION(glTexCoord4iv);
	(*stub_glTexCoord4iv)(lv0);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glTexCoord4s,(GLshort, GLshort, GLshort, GLshort),void);
value glstub_glTexCoord4s(value v0, value v1, value v2, value v3)
{
	CAMLparam4(v0, v1, v2, v3);
	GLshort lv0 = Int_val(v0);
	GLshort lv1 = Int_val(v1);
	GLshort lv2 = Int_val(v2);
	GLshort lv3 = Int_val(v3);
	LOAD_FUNCTION(glTexCoord4s);
	(*stub_glTexCoord4s)(lv0, lv1, lv2, lv3);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glTexCoord4sv,(GLshort*),void);
value glstub_glTexCoord4sv(value v0)
{
	CAMLparam1(v0);
	GLshort* lv0 = Data_bigarray_val(v0);
	LOAD_FUNCTION(glTexCoord4sv);
	(*stub_glTexCoord4sv)(lv0);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glTexCoordPointer,(GLint, GLenum, GLsizei, GLvoid*),void);
value glstub_glTexCoordPointer(value v0, value v1, value v2, value v3)
{
	CAMLparam4(v0, v1, v2, v3);
	GLint lv0 = Int_val(v0);
	GLenum lv1 = Int_val(v1);
	GLsizei lv2 = Int_val(v2);
	GLvoid* lv3 = (GLvoid *)((Tag_val(v3) == String_tag)? (String_val(v3)) : (Data_bigarray_val(v3)));
	LOAD_FUNCTION(glTexCoordPointer);
	(*stub_glTexCoordPointer)(lv0, lv1, lv2, lv3);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glTexCoordPointerEXT,(GLint, GLenum, GLsizei, GLsizei, GLvoid*),void);
value glstub_glTexCoordPointerEXT(value v0, value v1, value v2, value v3, value v4)
{
	CAMLparam5(v0, v1, v2, v3, v4);
	GLint lv0 = Int_val(v0);
	GLenum lv1 = Int_val(v1);
	GLsizei lv2 = Int_val(v2);
	GLsizei lv3 = Int_val(v3);
	GLvoid* lv4 = (GLvoid *)((Tag_val(v4) == String_tag)? (String_val(v4)) : (Data_bigarray_val(v4)));
	LOAD_FUNCTION(glTexCoordPointerEXT);
	(*stub_glTexCoordPointerEXT)(lv0, lv1, lv2, lv3, lv4);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glTexCoordPointerListIBM,(GLint, GLenum, GLint, GLvoid**, GLint),void);
value glstub_glTexCoordPointerListIBM(value v0, value v1, value v2, value v3, value v4)
{
	CAMLparam5(v0, v1, v2, v3, v4);
	GLint lv0 = Int_val(v0);
	GLenum lv1 = Int_val(v1);
	GLint lv2 = Int_val(v2);
	GLvoid** lv3 = Data_bigarray_val(v3);
	GLint lv4 = Int_val(v4);
	LOAD_FUNCTION(glTexCoordPointerListIBM);
	(*stub_glTexCoordPointerListIBM)(lv0, lv1, lv2, lv3, lv4);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glTexCoordPointervINTEL,(GLint, GLenum, GLvoid**),void);
value glstub_glTexCoordPointervINTEL(value v0, value v1, value v2)
{
	CAMLparam3(v0, v1, v2);
	GLint lv0 = Int_val(v0);
	GLenum lv1 = Int_val(v1);
	GLvoid** lv2 = Data_bigarray_val(v2);
	LOAD_FUNCTION(glTexCoordPointervINTEL);
	(*stub_glTexCoordPointervINTEL)(lv0, lv1, lv2);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glTexEnvf,(GLenum, GLenum, GLfloat),void);
value glstub_glTexEnvf(value v0, value v1, value v2)
{
	CAMLparam3(v0, v1, v2);
	GLenum lv0 = Int_val(v0);
	GLenum lv1 = Int_val(v1);
	GLfloat lv2 = Double_val(v2);
	LOAD_FUNCTION(glTexEnvf);
	(*stub_glTexEnvf)(lv0, lv1, lv2);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glTexEnvfv,(GLenum, GLenum, GLfloat*),void);
value glstub_glTexEnvfv(value v0, value v1, value v2)
{
	CAMLparam3(v0, v1, v2);
	GLenum lv0 = Int_val(v0);
	GLenum lv1 = Int_val(v1);
	GLfloat* lv2 = Data_bigarray_val(v2);
	LOAD_FUNCTION(glTexEnvfv);
	(*stub_glTexEnvfv)(lv0, lv1, lv2);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glTexEnvi,(GLenum, GLenum, GLint),void);
value glstub_glTexEnvi(value v0, value v1, value v2)
{
	CAMLparam3(v0, v1, v2);
	GLenum lv0 = Int_val(v0);
	GLenum lv1 = Int_val(v1);
	GLint lv2 = Int_val(v2);
	LOAD_FUNCTION(glTexEnvi);
	(*stub_glTexEnvi)(lv0, lv1, lv2);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glTexEnviv,(GLenum, GLenum, GLint*),void);
value glstub_glTexEnviv(value v0, value v1, value v2)
{
	CAMLparam3(v0, v1, v2);
	GLenum lv0 = Int_val(v0);
	GLenum lv1 = Int_val(v1);
	GLint* lv2 = Data_bigarray_val(v2);
	LOAD_FUNCTION(glTexEnviv);
	(*stub_glTexEnviv)(lv0, lv1, lv2);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glTexFilterFuncSGIS,(GLenum, GLenum, GLsizei, GLfloat*),void);
value glstub_glTexFilterFuncSGIS(value v0, value v1, value v2, value v3)
{
	CAMLparam4(v0, v1, v2, v3);
	GLenum lv0 = Int_val(v0);
	GLenum lv1 = Int_val(v1);
	GLsizei lv2 = Int_val(v2);
	GLfloat* lv3 = Data_bigarray_val(v3);
	LOAD_FUNCTION(glTexFilterFuncSGIS);
	(*stub_glTexFilterFuncSGIS)(lv0, lv1, lv2, lv3);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glTexGend,(GLenum, GLenum, GLdouble),void);
value glstub_glTexGend(value v0, value v1, value v2)
{
	CAMLparam3(v0, v1, v2);
	GLenum lv0 = Int_val(v0);
	GLenum lv1 = Int_val(v1);
	GLdouble lv2 = Double_val(v2);
	LOAD_FUNCTION(glTexGend);
	(*stub_glTexGend)(lv0, lv1, lv2);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glTexGendv,(GLenum, GLenum, GLdouble*),void);
value glstub_glTexGendv(value v0, value v1, value v2)
{
	CAMLparam3(v0, v1, v2);
	GLenum lv0 = Int_val(v0);
	GLenum lv1 = Int_val(v1);
	GLdouble* lv2 = (Tag_val(v2) == Double_array_tag)? (double *)v2: Data_bigarray_val(v2);
	LOAD_FUNCTION(glTexGendv);
	(*stub_glTexGendv)(lv0, lv1, lv2);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glTexGenf,(GLenum, GLenum, GLfloat),void);
value glstub_glTexGenf(value v0, value v1, value v2)
{
	CAMLparam3(v0, v1, v2);
	GLenum lv0 = Int_val(v0);
	GLenum lv1 = Int_val(v1);
	GLfloat lv2 = Double_val(v2);
	LOAD_FUNCTION(glTexGenf);
	(*stub_glTexGenf)(lv0, lv1, lv2);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glTexGenfv,(GLenum, GLenum, GLfloat*),void);
value glstub_glTexGenfv(value v0, value v1, value v2)
{
	CAMLparam3(v0, v1, v2);
	GLenum lv0 = Int_val(v0);
	GLenum lv1 = Int_val(v1);
	GLfloat* lv2 = Data_bigarray_val(v2);
	LOAD_FUNCTION(glTexGenfv);
	(*stub_glTexGenfv)(lv0, lv1, lv2);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glTexGeni,(GLenum, GLenum, GLint),void);
value glstub_glTexGeni(value v0, value v1, value v2)
{
	CAMLparam3(v0, v1, v2);
	GLenum lv0 = Int_val(v0);
	GLenum lv1 = Int_val(v1);
	GLint lv2 = Int_val(v2);
	LOAD_FUNCTION(glTexGeni);
	(*stub_glTexGeni)(lv0, lv1, lv2);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glTexGeniv,(GLenum, GLenum, GLint*),void);
value glstub_glTexGeniv(value v0, value v1, value v2)
{
	CAMLparam3(v0, v1, v2);
	GLenum lv0 = Int_val(v0);
	GLenum lv1 = Int_val(v1);
	GLint* lv2 = Data_bigarray_val(v2);
	LOAD_FUNCTION(glTexGeniv);
	(*stub_glTexGeniv)(lv0, lv1, lv2);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glTexImage1D,(GLenum, GLint, GLint, GLsizei, GLint, GLenum, GLenum, GLvoid*),void);
value glstub_glTexImage1D(value v0, value v1, value v2, value v3, value v4, value v5, value v6, value v7)
{
	CAMLparam5(v0, v1, v2, v3, v4);
	CAMLxparam3(v5, v6, v7);
	GLenum lv0 = Int_val(v0);
	GLint lv1 = Int_val(v1);
	GLint lv2 = Int_val(v2);
	GLsizei lv3 = Int_val(v3);
	GLint lv4 = Int_val(v4);
	GLenum lv5 = Int_val(v5);
	GLenum lv6 = Int_val(v6);
	GLvoid* lv7 = (GLvoid *)((Tag_val(v7) == String_tag)? (String_val(v7)) : (Data_bigarray_val(v7)));
	LOAD_FUNCTION(glTexImage1D);
	(*stub_glTexImage1D)(lv0, lv1, lv2, lv3, lv4, lv5, lv6, lv7);
	CAMLreturn(Val_unit);
}

value glstub_glTexImage1D_byte(value * argv, int n)
{
	return glstub_glTexImage1D(argv[0], argv[1], argv[2], argv[3], argv[4], argv[5], argv[6], argv[7]);
}

DECLARE_FUNCTION(glTexImage2D,(GLenum, GLint, GLint, GLsizei, GLsizei, GLint, GLenum, GLenum, GLvoid*),void);
value glstub_glTexImage2D(value v0, value v1, value v2, value v3, value v4, value v5, value v6, value v7, value v8)
{
	CAMLparam5(v0, v1, v2, v3, v4);
	CAMLxparam4(v5, v6, v7, v8);
	GLenum lv0 = Int_val(v0);
	GLint lv1 = Int_val(v1);
	GLint lv2 = Int_val(v2);
	GLsizei lv3 = Int_val(v3);
	GLsizei lv4 = Int_val(v4);
	GLint lv5 = Int_val(v5);
	GLenum lv6 = Int_val(v6);
	GLenum lv7 = Int_val(v7);
	GLvoid* lv8 = (GLvoid *)((Tag_val(v8) == String_tag)? (String_val(v8)) : (Data_bigarray_val(v8)));
	LOAD_FUNCTION(glTexImage2D);
	(*stub_glTexImage2D)(lv0, lv1, lv2, lv3, lv4, lv5, lv6, lv7, lv8);
	CAMLreturn(Val_unit);
}

value glstub_glTexImage2D_byte(value * argv, int n)
{
	return glstub_glTexImage2D(argv[0], argv[1], argv[2], argv[3], argv[4], argv[5], argv[6], argv[7], argv[8]);
}

DECLARE_FUNCTION(glTexImage3D,(GLenum, GLint, GLint, GLsizei, GLsizei, GLsizei, GLint, GLenum, GLenum, GLvoid*),void);
value glstub_glTexImage3D(value v0, value v1, value v2, value v3, value v4, value v5, value v6, value v7, value v8, value v9)
{
	CAMLparam5(v0, v1, v2, v3, v4);
	CAMLxparam5(v5, v6, v7, v8, v9);
	GLenum lv0 = Int_val(v0);
	GLint lv1 = Int_val(v1);
	GLint lv2 = Int_val(v2);
	GLsizei lv3 = Int_val(v3);
	GLsizei lv4 = Int_val(v4);
	GLsizei lv5 = Int_val(v5);
	GLint lv6 = Int_val(v6);
	GLenum lv7 = Int_val(v7);
	GLenum lv8 = Int_val(v8);
	GLvoid* lv9 = (GLvoid *)((Tag_val(v9) == String_tag)? (String_val(v9)) : (Data_bigarray_val(v9)));
	LOAD_FUNCTION(glTexImage3D);
	(*stub_glTexImage3D)(lv0, lv1, lv2, lv3, lv4, lv5, lv6, lv7, lv8, lv9);
	CAMLreturn(Val_unit);
}

value glstub_glTexImage3D_byte(value * argv, int n)
{
	return glstub_glTexImage3D(argv[0], argv[1], argv[2], argv[3], argv[4], argv[5], argv[6], argv[7], argv[8], argv[9]);
}

DECLARE_FUNCTION(glTexImage3DEXT,(GLenum, GLint, GLenum, GLsizei, GLsizei, GLsizei, GLint, GLenum, GLenum, GLvoid*),void);
value glstub_glTexImage3DEXT(value v0, value v1, value v2, value v3, value v4, value v5, value v6, value v7, value v8, value v9)
{
	CAMLparam5(v0, v1, v2, v3, v4);
	CAMLxparam5(v5, v6, v7, v8, v9);
	GLenum lv0 = Int_val(v0);
	GLint lv1 = Int_val(v1);
	GLenum lv2 = Int_val(v2);
	GLsizei lv3 = Int_val(v3);
	GLsizei lv4 = Int_val(v4);
	GLsizei lv5 = Int_val(v5);
	GLint lv6 = Int_val(v6);
	GLenum lv7 = Int_val(v7);
	GLenum lv8 = Int_val(v8);
	GLvoid* lv9 = (GLvoid *)((Tag_val(v9) == String_tag)? (String_val(v9)) : (Data_bigarray_val(v9)));
	LOAD_FUNCTION(glTexImage3DEXT);
	(*stub_glTexImage3DEXT)(lv0, lv1, lv2, lv3, lv4, lv5, lv6, lv7, lv8, lv9);
	CAMLreturn(Val_unit);
}

value glstub_glTexImage3DEXT_byte(value * argv, int n)
{
	return glstub_glTexImage3DEXT(argv[0], argv[1], argv[2], argv[3], argv[4], argv[5], argv[6], argv[7], argv[8], argv[9]);
}

DECLARE_FUNCTION(glTexImage4DSGIS,(GLenum, GLint, GLenum, GLsizei, GLsizei, GLsizei, GLsizei, GLint, GLenum, GLenum, GLvoid*),void);
value glstub_glTexImage4DSGIS(value v0, value v1, value v2, value v3, value v4, value v5, value v6, value v7, value v8, value v9, value v10)
{
	CAMLparam5(v0, v1, v2, v3, v4);
	CAMLxparam5(v5, v6, v7, v8, v9);
	CAMLxparam1(v10);
	GLenum lv0 = Int_val(v0);
	GLint lv1 = Int_val(v1);
	GLenum lv2 = Int_val(v2);
	GLsizei lv3 = Int_val(v3);
	GLsizei lv4 = Int_val(v4);
	GLsizei lv5 = Int_val(v5);
	GLsizei lv6 = Int_val(v6);
	GLint lv7 = Int_val(v7);
	GLenum lv8 = Int_val(v8);
	GLenum lv9 = Int_val(v9);
	GLvoid* lv10 = (GLvoid *)((Tag_val(v10) == String_tag)? (String_val(v10)) : (Data_bigarray_val(v10)));
	LOAD_FUNCTION(glTexImage4DSGIS);
	(*stub_glTexImage4DSGIS)(lv0, lv1, lv2, lv3, lv4, lv5, lv6, lv7, lv8, lv9, lv10);
	CAMLreturn(Val_unit);
}

value glstub_glTexImage4DSGIS_byte(value * argv, int n)
{
	return glstub_glTexImage4DSGIS(argv[0], argv[1], argv[2], argv[3], argv[4], argv[5], argv[6], argv[7], argv[8], argv[9], argv[10]);
}

DECLARE_FUNCTION(glTexParameterIivEXT,(GLenum, GLenum, GLint*),void);
value glstub_glTexParameterIivEXT(value v0, value v1, value v2)
{
	CAMLparam3(v0, v1, v2);
	GLenum lv0 = Int_val(v0);
	GLenum lv1 = Int_val(v1);
	GLint* lv2 = Data_bigarray_val(v2);
	LOAD_FUNCTION(glTexParameterIivEXT);
	(*stub_glTexParameterIivEXT)(lv0, lv1, lv2);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glTexParameterIuivEXT,(GLenum, GLenum, GLuint*),void);
value glstub_glTexParameterIuivEXT(value v0, value v1, value v2)
{
	CAMLparam3(v0, v1, v2);
	GLenum lv0 = Int_val(v0);
	GLenum lv1 = Int_val(v1);
	GLuint* lv2 = Data_bigarray_val(v2);
	LOAD_FUNCTION(glTexParameterIuivEXT);
	(*stub_glTexParameterIuivEXT)(lv0, lv1, lv2);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glTexParameterf,(GLenum, GLenum, GLfloat),void);
value glstub_glTexParameterf(value v0, value v1, value v2)
{
	CAMLparam3(v0, v1, v2);
	GLenum lv0 = Int_val(v0);
	GLenum lv1 = Int_val(v1);
	GLfloat lv2 = Double_val(v2);
	LOAD_FUNCTION(glTexParameterf);
	(*stub_glTexParameterf)(lv0, lv1, lv2);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glTexParameterfv,(GLenum, GLenum, GLfloat*),void);
value glstub_glTexParameterfv(value v0, value v1, value v2)
{
	CAMLparam3(v0, v1, v2);
	GLenum lv0 = Int_val(v0);
	GLenum lv1 = Int_val(v1);
	GLfloat* lv2 = Data_bigarray_val(v2);
	LOAD_FUNCTION(glTexParameterfv);
	(*stub_glTexParameterfv)(lv0, lv1, lv2);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glTexParameteri,(GLenum, GLenum, GLint),void);
value glstub_glTexParameteri(value v0, value v1, value v2)
{
	CAMLparam3(v0, v1, v2);
	GLenum lv0 = Int_val(v0);
	GLenum lv1 = Int_val(v1);
	GLint lv2 = Int_val(v2);
	LOAD_FUNCTION(glTexParameteri);
	(*stub_glTexParameteri)(lv0, lv1, lv2);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glTexParameteriv,(GLenum, GLenum, GLint*),void);
value glstub_glTexParameteriv(value v0, value v1, value v2)
{
	CAMLparam3(v0, v1, v2);
	GLenum lv0 = Int_val(v0);
	GLenum lv1 = Int_val(v1);
	GLint* lv2 = Data_bigarray_val(v2);
	LOAD_FUNCTION(glTexParameteriv);
	(*stub_glTexParameteriv)(lv0, lv1, lv2);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glTexScissorFuncINTEL,(GLenum, GLenum, GLenum),void);
value glstub_glTexScissorFuncINTEL(value v0, value v1, value v2)
{
	CAMLparam3(v0, v1, v2);
	GLenum lv0 = Int_val(v0);
	GLenum lv1 = Int_val(v1);
	GLenum lv2 = Int_val(v2);
	LOAD_FUNCTION(glTexScissorFuncINTEL);
	(*stub_glTexScissorFuncINTEL)(lv0, lv1, lv2);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glTexScissorINTEL,(GLenum, GLclampf, GLclampf),void);
value glstub_glTexScissorINTEL(value v0, value v1, value v2)
{
	CAMLparam3(v0, v1, v2);
	GLenum lv0 = Int_val(v0);
	GLclampf lv1 = Double_val(v1);
	GLclampf lv2 = Double_val(v2);
	LOAD_FUNCTION(glTexScissorINTEL);
	(*stub_glTexScissorINTEL)(lv0, lv1, lv2);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glTexSubImage1D,(GLenum, GLint, GLint, GLsizei, GLenum, GLenum, GLvoid*),void);
value glstub_glTexSubImage1D(value v0, value v1, value v2, value v3, value v4, value v5, value v6)
{
	CAMLparam5(v0, v1, v2, v3, v4);
	CAMLxparam2(v5, v6);
	GLenum lv0 = Int_val(v0);
	GLint lv1 = Int_val(v1);
	GLint lv2 = Int_val(v2);
	GLsizei lv3 = Int_val(v3);
	GLenum lv4 = Int_val(v4);
	GLenum lv5 = Int_val(v5);
	GLvoid* lv6 = (GLvoid *)((Tag_val(v6) == String_tag)? (String_val(v6)) : (Data_bigarray_val(v6)));
	LOAD_FUNCTION(glTexSubImage1D);
	(*stub_glTexSubImage1D)(lv0, lv1, lv2, lv3, lv4, lv5, lv6);
	CAMLreturn(Val_unit);
}

value glstub_glTexSubImage1D_byte(value * argv, int n)
{
	return glstub_glTexSubImage1D(argv[0], argv[1], argv[2], argv[3], argv[4], argv[5], argv[6]);
}

DECLARE_FUNCTION(glTexSubImage1DEXT,(GLenum, GLint, GLint, GLsizei, GLenum, GLenum, GLvoid*),void);
value glstub_glTexSubImage1DEXT(value v0, value v1, value v2, value v3, value v4, value v5, value v6)
{
	CAMLparam5(v0, v1, v2, v3, v4);
	CAMLxparam2(v5, v6);
	GLenum lv0 = Int_val(v0);
	GLint lv1 = Int_val(v1);
	GLint lv2 = Int_val(v2);
	GLsizei lv3 = Int_val(v3);
	GLenum lv4 = Int_val(v4);
	GLenum lv5 = Int_val(v5);
	GLvoid* lv6 = (GLvoid *)((Tag_val(v6) == String_tag)? (String_val(v6)) : (Data_bigarray_val(v6)));
	LOAD_FUNCTION(glTexSubImage1DEXT);
	(*stub_glTexSubImage1DEXT)(lv0, lv1, lv2, lv3, lv4, lv5, lv6);
	CAMLreturn(Val_unit);
}

value glstub_glTexSubImage1DEXT_byte(value * argv, int n)
{
	return glstub_glTexSubImage1DEXT(argv[0], argv[1], argv[2], argv[3], argv[4], argv[5], argv[6]);
}

DECLARE_FUNCTION(glTexSubImage2D,(GLenum, GLint, GLint, GLint, GLsizei, GLsizei, GLenum, GLenum, GLvoid*),void);
value glstub_glTexSubImage2D(value v0, value v1, value v2, value v3, value v4, value v5, value v6, value v7, value v8)
{
	CAMLparam5(v0, v1, v2, v3, v4);
	CAMLxparam4(v5, v6, v7, v8);
	GLenum lv0 = Int_val(v0);
	GLint lv1 = Int_val(v1);
	GLint lv2 = Int_val(v2);
	GLint lv3 = Int_val(v3);
	GLsizei lv4 = Int_val(v4);
	GLsizei lv5 = Int_val(v5);
	GLenum lv6 = Int_val(v6);
	GLenum lv7 = Int_val(v7);
	GLvoid* lv8 = (GLvoid *)((Tag_val(v8) == String_tag)? (String_val(v8)) : (Data_bigarray_val(v8)));
	LOAD_FUNCTION(glTexSubImage2D);
	(*stub_glTexSubImage2D)(lv0, lv1, lv2, lv3, lv4, lv5, lv6, lv7, lv8);
	CAMLreturn(Val_unit);
}

value glstub_glTexSubImage2D_byte(value * argv, int n)
{
	return glstub_glTexSubImage2D(argv[0], argv[1], argv[2], argv[3], argv[4], argv[5], argv[6], argv[7], argv[8]);
}

DECLARE_FUNCTION(glTexSubImage2DEXT,(GLenum, GLint, GLint, GLint, GLsizei, GLsizei, GLenum, GLenum, GLvoid*),void);
value glstub_glTexSubImage2DEXT(value v0, value v1, value v2, value v3, value v4, value v5, value v6, value v7, value v8)
{
	CAMLparam5(v0, v1, v2, v3, v4);
	CAMLxparam4(v5, v6, v7, v8);
	GLenum lv0 = Int_val(v0);
	GLint lv1 = Int_val(v1);
	GLint lv2 = Int_val(v2);
	GLint lv3 = Int_val(v3);
	GLsizei lv4 = Int_val(v4);
	GLsizei lv5 = Int_val(v5);
	GLenum lv6 = Int_val(v6);
	GLenum lv7 = Int_val(v7);
	GLvoid* lv8 = (GLvoid *)((Tag_val(v8) == String_tag)? (String_val(v8)) : (Data_bigarray_val(v8)));
	LOAD_FUNCTION(glTexSubImage2DEXT);
	(*stub_glTexSubImage2DEXT)(lv0, lv1, lv2, lv3, lv4, lv5, lv6, lv7, lv8);
	CAMLreturn(Val_unit);
}

value glstub_glTexSubImage2DEXT_byte(value * argv, int n)
{
	return glstub_glTexSubImage2DEXT(argv[0], argv[1], argv[2], argv[3], argv[4], argv[5], argv[6], argv[7], argv[8]);
}

DECLARE_FUNCTION(glTexSubImage3D,(GLenum, GLint, GLint, GLint, GLint, GLsizei, GLsizei, GLsizei, GLenum, GLenum, GLvoid*),void);
value glstub_glTexSubImage3D(value v0, value v1, value v2, value v3, value v4, value v5, value v6, value v7, value v8, value v9, value v10)
{
	CAMLparam5(v0, v1, v2, v3, v4);
	CAMLxparam5(v5, v6, v7, v8, v9);
	CAMLxparam1(v10);
	GLenum lv0 = Int_val(v0);
	GLint lv1 = Int_val(v1);
	GLint lv2 = Int_val(v2);
	GLint lv3 = Int_val(v3);
	GLint lv4 = Int_val(v4);
	GLsizei lv5 = Int_val(v5);
	GLsizei lv6 = Int_val(v6);
	GLsizei lv7 = Int_val(v7);
	GLenum lv8 = Int_val(v8);
	GLenum lv9 = Int_val(v9);
	GLvoid* lv10 = (GLvoid *)((Tag_val(v10) == String_tag)? (String_val(v10)) : (Data_bigarray_val(v10)));
	LOAD_FUNCTION(glTexSubImage3D);
	(*stub_glTexSubImage3D)(lv0, lv1, lv2, lv3, lv4, lv5, lv6, lv7, lv8, lv9, lv10);
	CAMLreturn(Val_unit);
}

value glstub_glTexSubImage3D_byte(value * argv, int n)
{
	return glstub_glTexSubImage3D(argv[0], argv[1], argv[2], argv[3], argv[4], argv[5], argv[6], argv[7], argv[8], argv[9], argv[10]);
}

DECLARE_FUNCTION(glTexSubImage3DEXT,(GLenum, GLint, GLint, GLint, GLint, GLsizei, GLsizei, GLsizei, GLenum, GLenum, GLvoid*),void);
value glstub_glTexSubImage3DEXT(value v0, value v1, value v2, value v3, value v4, value v5, value v6, value v7, value v8, value v9, value v10)
{
	CAMLparam5(v0, v1, v2, v3, v4);
	CAMLxparam5(v5, v6, v7, v8, v9);
	CAMLxparam1(v10);
	GLenum lv0 = Int_val(v0);
	GLint lv1 = Int_val(v1);
	GLint lv2 = Int_val(v2);
	GLint lv3 = Int_val(v3);
	GLint lv4 = Int_val(v4);
	GLsizei lv5 = Int_val(v5);
	GLsizei lv6 = Int_val(v6);
	GLsizei lv7 = Int_val(v7);
	GLenum lv8 = Int_val(v8);
	GLenum lv9 = Int_val(v9);
	GLvoid* lv10 = (GLvoid *)((Tag_val(v10) == String_tag)? (String_val(v10)) : (Data_bigarray_val(v10)));
	LOAD_FUNCTION(glTexSubImage3DEXT);
	(*stub_glTexSubImage3DEXT)(lv0, lv1, lv2, lv3, lv4, lv5, lv6, lv7, lv8, lv9, lv10);
	CAMLreturn(Val_unit);
}

value glstub_glTexSubImage3DEXT_byte(value * argv, int n)
{
	return glstub_glTexSubImage3DEXT(argv[0], argv[1], argv[2], argv[3], argv[4], argv[5], argv[6], argv[7], argv[8], argv[9], argv[10]);
}

DECLARE_FUNCTION(glTexSubImage4DSGIS,(GLenum, GLint, GLint, GLint, GLint, GLint, GLsizei, GLsizei, GLsizei, GLsizei, GLenum, GLenum, GLvoid*),void);
value glstub_glTexSubImage4DSGIS(value v0, value v1, value v2, value v3, value v4, value v5, value v6, value v7, value v8, value v9, value v10, value v11, value v12)
{
	CAMLparam5(v0, v1, v2, v3, v4);
	CAMLxparam5(v5, v6, v7, v8, v9);
	CAMLxparam3(v10, v11, v12);
	GLenum lv0 = Int_val(v0);
	GLint lv1 = Int_val(v1);
	GLint lv2 = Int_val(v2);
	GLint lv3 = Int_val(v3);
	GLint lv4 = Int_val(v4);
	GLint lv5 = Int_val(v5);
	GLsizei lv6 = Int_val(v6);
	GLsizei lv7 = Int_val(v7);
	GLsizei lv8 = Int_val(v8);
	GLsizei lv9 = Int_val(v9);
	GLenum lv10 = Int_val(v10);
	GLenum lv11 = Int_val(v11);
	GLvoid* lv12 = (GLvoid *)((Tag_val(v12) == String_tag)? (String_val(v12)) : (Data_bigarray_val(v12)));
	LOAD_FUNCTION(glTexSubImage4DSGIS);
	(*stub_glTexSubImage4DSGIS)(lv0, lv1, lv2, lv3, lv4, lv5, lv6, lv7, lv8, lv9, lv10, lv11, lv12);
	CAMLreturn(Val_unit);
}

value glstub_glTexSubImage4DSGIS_byte(value * argv, int n)
{
	return glstub_glTexSubImage4DSGIS(argv[0], argv[1], argv[2], argv[3], argv[4], argv[5], argv[6], argv[7], argv[8], argv[9], argv[10], argv[11], argv[12]);
}

DECLARE_FUNCTION(glTextureFogSGIX,(GLenum),void);
value glstub_glTextureFogSGIX(value v0)
{
	CAMLparam1(v0);
	GLenum lv0 = Int_val(v0);
	LOAD_FUNCTION(glTextureFogSGIX);
	(*stub_glTextureFogSGIX)(lv0);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glTextureLightEXT,(GLenum),void);
value glstub_glTextureLightEXT(value v0)
{
	CAMLparam1(v0);
	GLenum lv0 = Int_val(v0);
	LOAD_FUNCTION(glTextureLightEXT);
	(*stub_glTextureLightEXT)(lv0);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glTextureMaterialEXT,(GLenum, GLenum),void);
value glstub_glTextureMaterialEXT(value v0, value v1)
{
	CAMLparam2(v0, v1);
	GLenum lv0 = Int_val(v0);
	GLenum lv1 = Int_val(v1);
	LOAD_FUNCTION(glTextureMaterialEXT);
	(*stub_glTextureMaterialEXT)(lv0, lv1);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glTextureNormalEXT,(GLenum),void);
value glstub_glTextureNormalEXT(value v0)
{
	CAMLparam1(v0);
	GLenum lv0 = Int_val(v0);
	LOAD_FUNCTION(glTextureNormalEXT);
	(*stub_glTextureNormalEXT)(lv0);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glTextureRangeAPPLE,(GLenum, GLsizei, GLvoid*),void);
value glstub_glTextureRangeAPPLE(value v0, value v1, value v2)
{
	CAMLparam3(v0, v1, v2);
	GLenum lv0 = Int_val(v0);
	GLsizei lv1 = Int_val(v1);
	GLvoid* lv2 = (GLvoid *)((Tag_val(v2) == String_tag)? (String_val(v2)) : (Data_bigarray_val(v2)));
	LOAD_FUNCTION(glTextureRangeAPPLE);
	(*stub_glTextureRangeAPPLE)(lv0, lv1, lv2);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glTrackMatrixNV,(GLenum, GLuint, GLenum, GLenum),void);
value glstub_glTrackMatrixNV(value v0, value v1, value v2, value v3)
{
	CAMLparam4(v0, v1, v2, v3);
	GLenum lv0 = Int_val(v0);
	GLuint lv1 = Int_val(v1);
	GLenum lv2 = Int_val(v2);
	GLenum lv3 = Int_val(v3);
	LOAD_FUNCTION(glTrackMatrixNV);
	(*stub_glTrackMatrixNV)(lv0, lv1, lv2, lv3);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glTransformFeedbackAttribsNV,(GLuint, GLint*, GLenum),void);
value glstub_glTransformFeedbackAttribsNV(value v0, value v1, value v2)
{
	CAMLparam3(v0, v1, v2);
	GLuint lv0 = Int_val(v0);
	GLint* lv1 = Data_bigarray_val(v1);
	GLenum lv2 = Int_val(v2);
	LOAD_FUNCTION(glTransformFeedbackAttribsNV);
	(*stub_glTransformFeedbackAttribsNV)(lv0, lv1, lv2);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glTransformFeedbackVaryingsNV,(GLuint, GLsizei, GLint*, GLenum),void);
value glstub_glTransformFeedbackVaryingsNV(value v0, value v1, value v2, value v3)
{
	CAMLparam4(v0, v1, v2, v3);
	GLuint lv0 = Int_val(v0);
	GLsizei lv1 = Int_val(v1);
	GLint* lv2 = Data_bigarray_val(v2);
	GLenum lv3 = Int_val(v3);
	LOAD_FUNCTION(glTransformFeedbackVaryingsNV);
	(*stub_glTransformFeedbackVaryingsNV)(lv0, lv1, lv2, lv3);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glTranslated,(GLdouble, GLdouble, GLdouble),void);
value glstub_glTranslated(value v0, value v1, value v2)
{
	CAMLparam3(v0, v1, v2);
	GLdouble lv0 = Double_val(v0);
	GLdouble lv1 = Double_val(v1);
	GLdouble lv2 = Double_val(v2);
	LOAD_FUNCTION(glTranslated);
	(*stub_glTranslated)(lv0, lv1, lv2);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glTranslatef,(GLfloat, GLfloat, GLfloat),void);
value glstub_glTranslatef(value v0, value v1, value v2)
{
	CAMLparam3(v0, v1, v2);
	GLfloat lv0 = Double_val(v0);
	GLfloat lv1 = Double_val(v1);
	GLfloat lv2 = Double_val(v2);
	LOAD_FUNCTION(glTranslatef);
	(*stub_glTranslatef)(lv0, lv1, lv2);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glUniform1f,(GLint, GLfloat),void);
value glstub_glUniform1f(value v0, value v1)
{
	CAMLparam2(v0, v1);
	GLint lv0 = Int_val(v0);
	GLfloat lv1 = Double_val(v1);
	LOAD_FUNCTION(glUniform1f);
	(*stub_glUniform1f)(lv0, lv1);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glUniform1fARB,(GLint, GLfloat),void);
value glstub_glUniform1fARB(value v0, value v1)
{
	CAMLparam2(v0, v1);
	GLint lv0 = Int_val(v0);
	GLfloat lv1 = Double_val(v1);
	LOAD_FUNCTION(glUniform1fARB);
	(*stub_glUniform1fARB)(lv0, lv1);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glUniform1fv,(GLint, GLsizei, GLfloat*),void);
value glstub_glUniform1fv(value v0, value v1, value v2)
{
	CAMLparam3(v0, v1, v2);
	GLint lv0 = Int_val(v0);
	GLsizei lv1 = Int_val(v1);
	GLfloat* lv2 = Data_bigarray_val(v2);
	LOAD_FUNCTION(glUniform1fv);
	(*stub_glUniform1fv)(lv0, lv1, lv2);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glUniform1fvARB,(GLint, GLsizei, GLfloat*),void);
value glstub_glUniform1fvARB(value v0, value v1, value v2)
{
	CAMLparam3(v0, v1, v2);
	GLint lv0 = Int_val(v0);
	GLsizei lv1 = Int_val(v1);
	GLfloat* lv2 = Data_bigarray_val(v2);
	LOAD_FUNCTION(glUniform1fvARB);
	(*stub_glUniform1fvARB)(lv0, lv1, lv2);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glUniform1i,(GLint, GLint),void);
value glstub_glUniform1i(value v0, value v1)
{
	CAMLparam2(v0, v1);
	GLint lv0 = Int_val(v0);
	GLint lv1 = Int_val(v1);
	LOAD_FUNCTION(glUniform1i);
	(*stub_glUniform1i)(lv0, lv1);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glUniform1iARB,(GLint, GLint),void);
value glstub_glUniform1iARB(value v0, value v1)
{
	CAMLparam2(v0, v1);
	GLint lv0 = Int_val(v0);
	GLint lv1 = Int_val(v1);
	LOAD_FUNCTION(glUniform1iARB);
	(*stub_glUniform1iARB)(lv0, lv1);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glUniform1iv,(GLint, GLsizei, GLint*),void);
value glstub_glUniform1iv(value v0, value v1, value v2)
{
	CAMLparam3(v0, v1, v2);
	GLint lv0 = Int_val(v0);
	GLsizei lv1 = Int_val(v1);
	GLint* lv2 = Data_bigarray_val(v2);
	LOAD_FUNCTION(glUniform1iv);
	(*stub_glUniform1iv)(lv0, lv1, lv2);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glUniform1ivARB,(GLint, GLsizei, GLint*),void);
value glstub_glUniform1ivARB(value v0, value v1, value v2)
{
	CAMLparam3(v0, v1, v2);
	GLint lv0 = Int_val(v0);
	GLsizei lv1 = Int_val(v1);
	GLint* lv2 = Data_bigarray_val(v2);
	LOAD_FUNCTION(glUniform1ivARB);
	(*stub_glUniform1ivARB)(lv0, lv1, lv2);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glUniform1uiEXT,(GLint, GLuint),void);
value glstub_glUniform1uiEXT(value v0, value v1)
{
	CAMLparam2(v0, v1);
	GLint lv0 = Int_val(v0);
	GLuint lv1 = Int_val(v1);
	LOAD_FUNCTION(glUniform1uiEXT);
	(*stub_glUniform1uiEXT)(lv0, lv1);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glUniform1uivEXT,(GLint, GLsizei, GLuint*),void);
value glstub_glUniform1uivEXT(value v0, value v1, value v2)
{
	CAMLparam3(v0, v1, v2);
	GLint lv0 = Int_val(v0);
	GLsizei lv1 = Int_val(v1);
	GLuint* lv2 = Data_bigarray_val(v2);
	LOAD_FUNCTION(glUniform1uivEXT);
	(*stub_glUniform1uivEXT)(lv0, lv1, lv2);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glUniform2f,(GLint, GLfloat, GLfloat),void);
value glstub_glUniform2f(value v0, value v1, value v2)
{
	CAMLparam3(v0, v1, v2);
	GLint lv0 = Int_val(v0);
	GLfloat lv1 = Double_val(v1);
	GLfloat lv2 = Double_val(v2);
	LOAD_FUNCTION(glUniform2f);
	(*stub_glUniform2f)(lv0, lv1, lv2);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glUniform2fARB,(GLint, GLfloat, GLfloat),void);
value glstub_glUniform2fARB(value v0, value v1, value v2)
{
	CAMLparam3(v0, v1, v2);
	GLint lv0 = Int_val(v0);
	GLfloat lv1 = Double_val(v1);
	GLfloat lv2 = Double_val(v2);
	LOAD_FUNCTION(glUniform2fARB);
	(*stub_glUniform2fARB)(lv0, lv1, lv2);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glUniform2fv,(GLint, GLsizei, GLfloat*),void);
value glstub_glUniform2fv(value v0, value v1, value v2)
{
	CAMLparam3(v0, v1, v2);
	GLint lv0 = Int_val(v0);
	GLsizei lv1 = Int_val(v1);
	GLfloat* lv2 = Data_bigarray_val(v2);
	LOAD_FUNCTION(glUniform2fv);
	(*stub_glUniform2fv)(lv0, lv1, lv2);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glUniform2fvARB,(GLint, GLsizei, GLfloat*),void);
value glstub_glUniform2fvARB(value v0, value v1, value v2)
{
	CAMLparam3(v0, v1, v2);
	GLint lv0 = Int_val(v0);
	GLsizei lv1 = Int_val(v1);
	GLfloat* lv2 = Data_bigarray_val(v2);
	LOAD_FUNCTION(glUniform2fvARB);
	(*stub_glUniform2fvARB)(lv0, lv1, lv2);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glUniform2i,(GLint, GLint, GLint),void);
value glstub_glUniform2i(value v0, value v1, value v2)
{
	CAMLparam3(v0, v1, v2);
	GLint lv0 = Int_val(v0);
	GLint lv1 = Int_val(v1);
	GLint lv2 = Int_val(v2);
	LOAD_FUNCTION(glUniform2i);
	(*stub_glUniform2i)(lv0, lv1, lv2);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glUniform2iARB,(GLint, GLint, GLint),void);
value glstub_glUniform2iARB(value v0, value v1, value v2)
{
	CAMLparam3(v0, v1, v2);
	GLint lv0 = Int_val(v0);
	GLint lv1 = Int_val(v1);
	GLint lv2 = Int_val(v2);
	LOAD_FUNCTION(glUniform2iARB);
	(*stub_glUniform2iARB)(lv0, lv1, lv2);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glUniform2iv,(GLint, GLsizei, GLint*),void);
value glstub_glUniform2iv(value v0, value v1, value v2)
{
	CAMLparam3(v0, v1, v2);
	GLint lv0 = Int_val(v0);
	GLsizei lv1 = Int_val(v1);
	GLint* lv2 = Data_bigarray_val(v2);
	LOAD_FUNCTION(glUniform2iv);
	(*stub_glUniform2iv)(lv0, lv1, lv2);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glUniform2ivARB,(GLint, GLsizei, GLint*),void);
value glstub_glUniform2ivARB(value v0, value v1, value v2)
{
	CAMLparam3(v0, v1, v2);
	GLint lv0 = Int_val(v0);
	GLsizei lv1 = Int_val(v1);
	GLint* lv2 = Data_bigarray_val(v2);
	LOAD_FUNCTION(glUniform2ivARB);
	(*stub_glUniform2ivARB)(lv0, lv1, lv2);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glUniform2uiEXT,(GLint, GLuint, GLuint),void);
value glstub_glUniform2uiEXT(value v0, value v1, value v2)
{
	CAMLparam3(v0, v1, v2);
	GLint lv0 = Int_val(v0);
	GLuint lv1 = Int_val(v1);
	GLuint lv2 = Int_val(v2);
	LOAD_FUNCTION(glUniform2uiEXT);
	(*stub_glUniform2uiEXT)(lv0, lv1, lv2);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glUniform2uivEXT,(GLint, GLsizei, GLuint*),void);
value glstub_glUniform2uivEXT(value v0, value v1, value v2)
{
	CAMLparam3(v0, v1, v2);
	GLint lv0 = Int_val(v0);
	GLsizei lv1 = Int_val(v1);
	GLuint* lv2 = Data_bigarray_val(v2);
	LOAD_FUNCTION(glUniform2uivEXT);
	(*stub_glUniform2uivEXT)(lv0, lv1, lv2);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glUniform3f,(GLint, GLfloat, GLfloat, GLfloat),void);
value glstub_glUniform3f(value v0, value v1, value v2, value v3)
{
	CAMLparam4(v0, v1, v2, v3);
	GLint lv0 = Int_val(v0);
	GLfloat lv1 = Double_val(v1);
	GLfloat lv2 = Double_val(v2);
	GLfloat lv3 = Double_val(v3);
	LOAD_FUNCTION(glUniform3f);
	(*stub_glUniform3f)(lv0, lv1, lv2, lv3);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glUniform3fARB,(GLint, GLfloat, GLfloat, GLfloat),void);
value glstub_glUniform3fARB(value v0, value v1, value v2, value v3)
{
	CAMLparam4(v0, v1, v2, v3);
	GLint lv0 = Int_val(v0);
	GLfloat lv1 = Double_val(v1);
	GLfloat lv2 = Double_val(v2);
	GLfloat lv3 = Double_val(v3);
	LOAD_FUNCTION(glUniform3fARB);
	(*stub_glUniform3fARB)(lv0, lv1, lv2, lv3);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glUniform3fv,(GLint, GLsizei, GLfloat*),void);
value glstub_glUniform3fv(value v0, value v1, value v2)
{
	CAMLparam3(v0, v1, v2);
	GLint lv0 = Int_val(v0);
	GLsizei lv1 = Int_val(v1);
	GLfloat* lv2 = Data_bigarray_val(v2);
	LOAD_FUNCTION(glUniform3fv);
	(*stub_glUniform3fv)(lv0, lv1, lv2);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glUniform3fvARB,(GLint, GLsizei, GLfloat*),void);
value glstub_glUniform3fvARB(value v0, value v1, value v2)
{
	CAMLparam3(v0, v1, v2);
	GLint lv0 = Int_val(v0);
	GLsizei lv1 = Int_val(v1);
	GLfloat* lv2 = Data_bigarray_val(v2);
	LOAD_FUNCTION(glUniform3fvARB);
	(*stub_glUniform3fvARB)(lv0, lv1, lv2);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glUniform3i,(GLint, GLint, GLint, GLint),void);
value glstub_glUniform3i(value v0, value v1, value v2, value v3)
{
	CAMLparam4(v0, v1, v2, v3);
	GLint lv0 = Int_val(v0);
	GLint lv1 = Int_val(v1);
	GLint lv2 = Int_val(v2);
	GLint lv3 = Int_val(v3);
	LOAD_FUNCTION(glUniform3i);
	(*stub_glUniform3i)(lv0, lv1, lv2, lv3);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glUniform3iARB,(GLint, GLint, GLint, GLint),void);
value glstub_glUniform3iARB(value v0, value v1, value v2, value v3)
{
	CAMLparam4(v0, v1, v2, v3);
	GLint lv0 = Int_val(v0);
	GLint lv1 = Int_val(v1);
	GLint lv2 = Int_val(v2);
	GLint lv3 = Int_val(v3);
	LOAD_FUNCTION(glUniform3iARB);
	(*stub_glUniform3iARB)(lv0, lv1, lv2, lv3);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glUniform3iv,(GLint, GLsizei, GLint*),void);
value glstub_glUniform3iv(value v0, value v1, value v2)
{
	CAMLparam3(v0, v1, v2);
	GLint lv0 = Int_val(v0);
	GLsizei lv1 = Int_val(v1);
	GLint* lv2 = Data_bigarray_val(v2);
	LOAD_FUNCTION(glUniform3iv);
	(*stub_glUniform3iv)(lv0, lv1, lv2);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glUniform3ivARB,(GLint, GLsizei, GLint*),void);
value glstub_glUniform3ivARB(value v0, value v1, value v2)
{
	CAMLparam3(v0, v1, v2);
	GLint lv0 = Int_val(v0);
	GLsizei lv1 = Int_val(v1);
	GLint* lv2 = Data_bigarray_val(v2);
	LOAD_FUNCTION(glUniform3ivARB);
	(*stub_glUniform3ivARB)(lv0, lv1, lv2);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glUniform3uiEXT,(GLint, GLuint, GLuint, GLuint),void);
value glstub_glUniform3uiEXT(value v0, value v1, value v2, value v3)
{
	CAMLparam4(v0, v1, v2, v3);
	GLint lv0 = Int_val(v0);
	GLuint lv1 = Int_val(v1);
	GLuint lv2 = Int_val(v2);
	GLuint lv3 = Int_val(v3);
	LOAD_FUNCTION(glUniform3uiEXT);
	(*stub_glUniform3uiEXT)(lv0, lv1, lv2, lv3);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glUniform3uivEXT,(GLint, GLsizei, GLuint*),void);
value glstub_glUniform3uivEXT(value v0, value v1, value v2)
{
	CAMLparam3(v0, v1, v2);
	GLint lv0 = Int_val(v0);
	GLsizei lv1 = Int_val(v1);
	GLuint* lv2 = Data_bigarray_val(v2);
	LOAD_FUNCTION(glUniform3uivEXT);
	(*stub_glUniform3uivEXT)(lv0, lv1, lv2);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glUniform4f,(GLint, GLfloat, GLfloat, GLfloat, GLfloat),void);
value glstub_glUniform4f(value v0, value v1, value v2, value v3, value v4)
{
	CAMLparam5(v0, v1, v2, v3, v4);
	GLint lv0 = Int_val(v0);
	GLfloat lv1 = Double_val(v1);
	GLfloat lv2 = Double_val(v2);
	GLfloat lv3 = Double_val(v3);
	GLfloat lv4 = Double_val(v4);
	LOAD_FUNCTION(glUniform4f);
	(*stub_glUniform4f)(lv0, lv1, lv2, lv3, lv4);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glUniform4fARB,(GLint, GLfloat, GLfloat, GLfloat, GLfloat),void);
value glstub_glUniform4fARB(value v0, value v1, value v2, value v3, value v4)
{
	CAMLparam5(v0, v1, v2, v3, v4);
	GLint lv0 = Int_val(v0);
	GLfloat lv1 = Double_val(v1);
	GLfloat lv2 = Double_val(v2);
	GLfloat lv3 = Double_val(v3);
	GLfloat lv4 = Double_val(v4);
	LOAD_FUNCTION(glUniform4fARB);
	(*stub_glUniform4fARB)(lv0, lv1, lv2, lv3, lv4);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glUniform4fv,(GLint, GLsizei, GLfloat*),void);
value glstub_glUniform4fv(value v0, value v1, value v2)
{
	CAMLparam3(v0, v1, v2);
	GLint lv0 = Int_val(v0);
	GLsizei lv1 = Int_val(v1);
	GLfloat* lv2 = Data_bigarray_val(v2);
	LOAD_FUNCTION(glUniform4fv);
	(*stub_glUniform4fv)(lv0, lv1, lv2);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glUniform4fvARB,(GLint, GLsizei, GLfloat*),void);
value glstub_glUniform4fvARB(value v0, value v1, value v2)
{
	CAMLparam3(v0, v1, v2);
	GLint lv0 = Int_val(v0);
	GLsizei lv1 = Int_val(v1);
	GLfloat* lv2 = Data_bigarray_val(v2);
	LOAD_FUNCTION(glUniform4fvARB);
	(*stub_glUniform4fvARB)(lv0, lv1, lv2);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glUniform4i,(GLint, GLint, GLint, GLint, GLint),void);
value glstub_glUniform4i(value v0, value v1, value v2, value v3, value v4)
{
	CAMLparam5(v0, v1, v2, v3, v4);
	GLint lv0 = Int_val(v0);
	GLint lv1 = Int_val(v1);
	GLint lv2 = Int_val(v2);
	GLint lv3 = Int_val(v3);
	GLint lv4 = Int_val(v4);
	LOAD_FUNCTION(glUniform4i);
	(*stub_glUniform4i)(lv0, lv1, lv2, lv3, lv4);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glUniform4iARB,(GLint, GLint, GLint, GLint, GLint),void);
value glstub_glUniform4iARB(value v0, value v1, value v2, value v3, value v4)
{
	CAMLparam5(v0, v1, v2, v3, v4);
	GLint lv0 = Int_val(v0);
	GLint lv1 = Int_val(v1);
	GLint lv2 = Int_val(v2);
	GLint lv3 = Int_val(v3);
	GLint lv4 = Int_val(v4);
	LOAD_FUNCTION(glUniform4iARB);
	(*stub_glUniform4iARB)(lv0, lv1, lv2, lv3, lv4);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glUniform4iv,(GLint, GLsizei, GLint*),void);
value glstub_glUniform4iv(value v0, value v1, value v2)
{
	CAMLparam3(v0, v1, v2);
	GLint lv0 = Int_val(v0);
	GLsizei lv1 = Int_val(v1);
	GLint* lv2 = Data_bigarray_val(v2);
	LOAD_FUNCTION(glUniform4iv);
	(*stub_glUniform4iv)(lv0, lv1, lv2);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glUniform4ivARB,(GLint, GLsizei, GLint*),void);
value glstub_glUniform4ivARB(value v0, value v1, value v2)
{
	CAMLparam3(v0, v1, v2);
	GLint lv0 = Int_val(v0);
	GLsizei lv1 = Int_val(v1);
	GLint* lv2 = Data_bigarray_val(v2);
	LOAD_FUNCTION(glUniform4ivARB);
	(*stub_glUniform4ivARB)(lv0, lv1, lv2);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glUniform4uiEXT,(GLint, GLuint, GLuint, GLuint, GLuint),void);
value glstub_glUniform4uiEXT(value v0, value v1, value v2, value v3, value v4)
{
	CAMLparam5(v0, v1, v2, v3, v4);
	GLint lv0 = Int_val(v0);
	GLuint lv1 = Int_val(v1);
	GLuint lv2 = Int_val(v2);
	GLuint lv3 = Int_val(v3);
	GLuint lv4 = Int_val(v4);
	LOAD_FUNCTION(glUniform4uiEXT);
	(*stub_glUniform4uiEXT)(lv0, lv1, lv2, lv3, lv4);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glUniform4uivEXT,(GLint, GLsizei, GLuint*),void);
value glstub_glUniform4uivEXT(value v0, value v1, value v2)
{
	CAMLparam3(v0, v1, v2);
	GLint lv0 = Int_val(v0);
	GLsizei lv1 = Int_val(v1);
	GLuint* lv2 = Data_bigarray_val(v2);
	LOAD_FUNCTION(glUniform4uivEXT);
	(*stub_glUniform4uivEXT)(lv0, lv1, lv2);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glUniformBufferEXT,(GLuint, GLint, GLuint),void);
value glstub_glUniformBufferEXT(value v0, value v1, value v2)
{
	CAMLparam3(v0, v1, v2);
	GLuint lv0 = Int_val(v0);
	GLint lv1 = Int_val(v1);
	GLuint lv2 = Int_val(v2);
	LOAD_FUNCTION(glUniformBufferEXT);
	(*stub_glUniformBufferEXT)(lv0, lv1, lv2);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glUniformMatrix2fv,(GLint, GLsizei, GLboolean, GLfloat*),void);
value glstub_glUniformMatrix2fv(value v0, value v1, value v2, value v3)
{
	CAMLparam4(v0, v1, v2, v3);
	GLint lv0 = Int_val(v0);
	GLsizei lv1 = Int_val(v1);
	GLboolean lv2 = Bool_val(v2);
	GLfloat* lv3 = Data_bigarray_val(v3);
	LOAD_FUNCTION(glUniformMatrix2fv);
	(*stub_glUniformMatrix2fv)(lv0, lv1, lv2, lv3);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glUniformMatrix2fvARB,(GLint, GLsizei, GLboolean, GLfloat*),void);
value glstub_glUniformMatrix2fvARB(value v0, value v1, value v2, value v3)
{
	CAMLparam4(v0, v1, v2, v3);
	GLint lv0 = Int_val(v0);
	GLsizei lv1 = Int_val(v1);
	GLboolean lv2 = Bool_val(v2);
	GLfloat* lv3 = Data_bigarray_val(v3);
	LOAD_FUNCTION(glUniformMatrix2fvARB);
	(*stub_glUniformMatrix2fvARB)(lv0, lv1, lv2, lv3);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glUniformMatrix2x3fv,(GLint, GLsizei, GLboolean, GLfloat*),void);
value glstub_glUniformMatrix2x3fv(value v0, value v1, value v2, value v3)
{
	CAMLparam4(v0, v1, v2, v3);
	GLint lv0 = Int_val(v0);
	GLsizei lv1 = Int_val(v1);
	GLboolean lv2 = Bool_val(v2);
	GLfloat* lv3 = Data_bigarray_val(v3);
	LOAD_FUNCTION(glUniformMatrix2x3fv);
	(*stub_glUniformMatrix2x3fv)(lv0, lv1, lv2, lv3);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glUniformMatrix2x4fv,(GLint, GLsizei, GLboolean, GLfloat*),void);
value glstub_glUniformMatrix2x4fv(value v0, value v1, value v2, value v3)
{
	CAMLparam4(v0, v1, v2, v3);
	GLint lv0 = Int_val(v0);
	GLsizei lv1 = Int_val(v1);
	GLboolean lv2 = Bool_val(v2);
	GLfloat* lv3 = Data_bigarray_val(v3);
	LOAD_FUNCTION(glUniformMatrix2x4fv);
	(*stub_glUniformMatrix2x4fv)(lv0, lv1, lv2, lv3);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glUniformMatrix3fv,(GLint, GLsizei, GLboolean, GLfloat*),void);
value glstub_glUniformMatrix3fv(value v0, value v1, value v2, value v3)
{
	CAMLparam4(v0, v1, v2, v3);
	GLint lv0 = Int_val(v0);
	GLsizei lv1 = Int_val(v1);
	GLboolean lv2 = Bool_val(v2);
	GLfloat* lv3 = Data_bigarray_val(v3);
	LOAD_FUNCTION(glUniformMatrix3fv);
	(*stub_glUniformMatrix3fv)(lv0, lv1, lv2, lv3);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glUniformMatrix3fvARB,(GLint, GLsizei, GLboolean, GLfloat*),void);
value glstub_glUniformMatrix3fvARB(value v0, value v1, value v2, value v3)
{
	CAMLparam4(v0, v1, v2, v3);
	GLint lv0 = Int_val(v0);
	GLsizei lv1 = Int_val(v1);
	GLboolean lv2 = Bool_val(v2);
	GLfloat* lv3 = Data_bigarray_val(v3);
	LOAD_FUNCTION(glUniformMatrix3fvARB);
	(*stub_glUniformMatrix3fvARB)(lv0, lv1, lv2, lv3);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glUniformMatrix3x2fv,(GLint, GLsizei, GLboolean, GLfloat*),void);
value glstub_glUniformMatrix3x2fv(value v0, value v1, value v2, value v3)
{
	CAMLparam4(v0, v1, v2, v3);
	GLint lv0 = Int_val(v0);
	GLsizei lv1 = Int_val(v1);
	GLboolean lv2 = Bool_val(v2);
	GLfloat* lv3 = Data_bigarray_val(v3);
	LOAD_FUNCTION(glUniformMatrix3x2fv);
	(*stub_glUniformMatrix3x2fv)(lv0, lv1, lv2, lv3);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glUniformMatrix3x4fv,(GLint, GLsizei, GLboolean, GLfloat*),void);
value glstub_glUniformMatrix3x4fv(value v0, value v1, value v2, value v3)
{
	CAMLparam4(v0, v1, v2, v3);
	GLint lv0 = Int_val(v0);
	GLsizei lv1 = Int_val(v1);
	GLboolean lv2 = Bool_val(v2);
	GLfloat* lv3 = Data_bigarray_val(v3);
	LOAD_FUNCTION(glUniformMatrix3x4fv);
	(*stub_glUniformMatrix3x4fv)(lv0, lv1, lv2, lv3);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glUniformMatrix4fv,(GLint, GLsizei, GLboolean, GLfloat*),void);
value glstub_glUniformMatrix4fv(value v0, value v1, value v2, value v3)
{
	CAMLparam4(v0, v1, v2, v3);
	GLint lv0 = Int_val(v0);
	GLsizei lv1 = Int_val(v1);
	GLboolean lv2 = Bool_val(v2);
	GLfloat* lv3 = Data_bigarray_val(v3);
	LOAD_FUNCTION(glUniformMatrix4fv);
	(*stub_glUniformMatrix4fv)(lv0, lv1, lv2, lv3);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glUniformMatrix4fvARB,(GLint, GLsizei, GLboolean, GLfloat*),void);
value glstub_glUniformMatrix4fvARB(value v0, value v1, value v2, value v3)
{
	CAMLparam4(v0, v1, v2, v3);
	GLint lv0 = Int_val(v0);
	GLsizei lv1 = Int_val(v1);
	GLboolean lv2 = Bool_val(v2);
	GLfloat* lv3 = Data_bigarray_val(v3);
	LOAD_FUNCTION(glUniformMatrix4fvARB);
	(*stub_glUniformMatrix4fvARB)(lv0, lv1, lv2, lv3);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glUniformMatrix4x2fv,(GLint, GLsizei, GLboolean, GLfloat*),void);
value glstub_glUniformMatrix4x2fv(value v0, value v1, value v2, value v3)
{
	CAMLparam4(v0, v1, v2, v3);
	GLint lv0 = Int_val(v0);
	GLsizei lv1 = Int_val(v1);
	GLboolean lv2 = Bool_val(v2);
	GLfloat* lv3 = Data_bigarray_val(v3);
	LOAD_FUNCTION(glUniformMatrix4x2fv);
	(*stub_glUniformMatrix4x2fv)(lv0, lv1, lv2, lv3);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glUniformMatrix4x3fv,(GLint, GLsizei, GLboolean, GLfloat*),void);
value glstub_glUniformMatrix4x3fv(value v0, value v1, value v2, value v3)
{
	CAMLparam4(v0, v1, v2, v3);
	GLint lv0 = Int_val(v0);
	GLsizei lv1 = Int_val(v1);
	GLboolean lv2 = Bool_val(v2);
	GLfloat* lv3 = Data_bigarray_val(v3);
	LOAD_FUNCTION(glUniformMatrix4x3fv);
	(*stub_glUniformMatrix4x3fv)(lv0, lv1, lv2, lv3);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glUnlockArraysEXT,(void),void);
value glstub_glUnlockArraysEXT(value v0)
{
	CAMLparam1(v0);
	LOAD_FUNCTION(glUnlockArraysEXT);
	(*stub_glUnlockArraysEXT)();
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glUnmapBuffer,(GLenum),GLboolean);
value glstub_glUnmapBuffer(value v0)
{
	CAMLparam1(v0);
	CAMLlocal1(result);
	GLenum lv0 = Int_val(v0);
	GLboolean ret;
	LOAD_FUNCTION(glUnmapBuffer);
	ret = (*stub_glUnmapBuffer)(lv0);
	result = Val_bool(ret);
	CAMLreturn(result);
}

DECLARE_FUNCTION(glUnmapBufferARB,(GLenum),GLboolean);
value glstub_glUnmapBufferARB(value v0)
{
	CAMLparam1(v0);
	CAMLlocal1(result);
	GLenum lv0 = Int_val(v0);
	GLboolean ret;
	LOAD_FUNCTION(glUnmapBufferARB);
	ret = (*stub_glUnmapBufferARB)(lv0);
	result = Val_bool(ret);
	CAMLreturn(result);
}

DECLARE_FUNCTION(glUnmapObjectBufferATI,(GLuint),void);
value glstub_glUnmapObjectBufferATI(value v0)
{
	CAMLparam1(v0);
	GLuint lv0 = Int_val(v0);
	LOAD_FUNCTION(glUnmapObjectBufferATI);
	(*stub_glUnmapObjectBufferATI)(lv0);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glUpdateObjectBufferATI,(GLuint, GLuint, GLsizei, GLvoid*, GLenum),void);
value glstub_glUpdateObjectBufferATI(value v0, value v1, value v2, value v3, value v4)
{
	CAMLparam5(v0, v1, v2, v3, v4);
	GLuint lv0 = Int_val(v0);
	GLuint lv1 = Int_val(v1);
	GLsizei lv2 = Int_val(v2);
	GLvoid* lv3 = (GLvoid *)((Tag_val(v3) == String_tag)? (String_val(v3)) : (Data_bigarray_val(v3)));
	GLenum lv4 = Int_val(v4);
	LOAD_FUNCTION(glUpdateObjectBufferATI);
	(*stub_glUpdateObjectBufferATI)(lv0, lv1, lv2, lv3, lv4);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glUseProgram,(GLuint),void);
value glstub_glUseProgram(value v0)
{
	CAMLparam1(v0);
	GLuint lv0 = Int_val(v0);
	LOAD_FUNCTION(glUseProgram);
	(*stub_glUseProgram)(lv0);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glUseProgramObjectARB,(GLuint),void);
value glstub_glUseProgramObjectARB(value v0)
{
	CAMLparam1(v0);
	GLuint lv0 = Int_val(v0);
	LOAD_FUNCTION(glUseProgramObjectARB);
	(*stub_glUseProgramObjectARB)(lv0);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glValidateProgram,(GLuint),void);
value glstub_glValidateProgram(value v0)
{
	CAMLparam1(v0);
	GLuint lv0 = Int_val(v0);
	LOAD_FUNCTION(glValidateProgram);
	(*stub_glValidateProgram)(lv0);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glValidateProgramARB,(GLuint),void);
value glstub_glValidateProgramARB(value v0)
{
	CAMLparam1(v0);
	GLuint lv0 = Int_val(v0);
	LOAD_FUNCTION(glValidateProgramARB);
	(*stub_glValidateProgramARB)(lv0);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glVariantArrayObjectATI,(GLuint, GLenum, GLsizei, GLuint, GLuint),void);
value glstub_glVariantArrayObjectATI(value v0, value v1, value v2, value v3, value v4)
{
	CAMLparam5(v0, v1, v2, v3, v4);
	GLuint lv0 = Int_val(v0);
	GLenum lv1 = Int_val(v1);
	GLsizei lv2 = Int_val(v2);
	GLuint lv3 = Int_val(v3);
	GLuint lv4 = Int_val(v4);
	LOAD_FUNCTION(glVariantArrayObjectATI);
	(*stub_glVariantArrayObjectATI)(lv0, lv1, lv2, lv3, lv4);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glVariantPointerEXT,(GLuint, GLenum, GLuint, GLvoid*),void);
value glstub_glVariantPointerEXT(value v0, value v1, value v2, value v3)
{
	CAMLparam4(v0, v1, v2, v3);
	GLuint lv0 = Int_val(v0);
	GLenum lv1 = Int_val(v1);
	GLuint lv2 = Int_val(v2);
	GLvoid* lv3 = (GLvoid *)((Tag_val(v3) == String_tag)? (String_val(v3)) : (Data_bigarray_val(v3)));
	LOAD_FUNCTION(glVariantPointerEXT);
	(*stub_glVariantPointerEXT)(lv0, lv1, lv2, lv3);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glVariantbvEXT,(GLuint, GLbyte*),void);
value glstub_glVariantbvEXT(value v0, value v1)
{
	CAMLparam2(v0, v1);
	GLuint lv0 = Int_val(v0);
	GLbyte* lv1 = Data_bigarray_val(v1);
	LOAD_FUNCTION(glVariantbvEXT);
	(*stub_glVariantbvEXT)(lv0, lv1);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glVariantdvEXT,(GLuint, GLdouble*),void);
value glstub_glVariantdvEXT(value v0, value v1)
{
	CAMLparam2(v0, v1);
	GLuint lv0 = Int_val(v0);
	GLdouble* lv1 = (Tag_val(v1) == Double_array_tag)? (double *)v1: Data_bigarray_val(v1);
	LOAD_FUNCTION(glVariantdvEXT);
	(*stub_glVariantdvEXT)(lv0, lv1);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glVariantfvEXT,(GLuint, GLfloat*),void);
value glstub_glVariantfvEXT(value v0, value v1)
{
	CAMLparam2(v0, v1);
	GLuint lv0 = Int_val(v0);
	GLfloat* lv1 = Data_bigarray_val(v1);
	LOAD_FUNCTION(glVariantfvEXT);
	(*stub_glVariantfvEXT)(lv0, lv1);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glVariantivEXT,(GLuint, GLint*),void);
value glstub_glVariantivEXT(value v0, value v1)
{
	CAMLparam2(v0, v1);
	GLuint lv0 = Int_val(v0);
	GLint* lv1 = Data_bigarray_val(v1);
	LOAD_FUNCTION(glVariantivEXT);
	(*stub_glVariantivEXT)(lv0, lv1);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glVariantsvEXT,(GLuint, GLshort*),void);
value glstub_glVariantsvEXT(value v0, value v1)
{
	CAMLparam2(v0, v1);
	GLuint lv0 = Int_val(v0);
	GLshort* lv1 = Data_bigarray_val(v1);
	LOAD_FUNCTION(glVariantsvEXT);
	(*stub_glVariantsvEXT)(lv0, lv1);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glVariantubvEXT,(GLuint, GLubyte*),void);
value glstub_glVariantubvEXT(value v0, value v1)
{
	CAMLparam2(v0, v1);
	GLuint lv0 = Int_val(v0);
	GLubyte* lv1 = Data_bigarray_val(v1);
	LOAD_FUNCTION(glVariantubvEXT);
	(*stub_glVariantubvEXT)(lv0, lv1);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glVariantuivEXT,(GLuint, GLuint*),void);
value glstub_glVariantuivEXT(value v0, value v1)
{
	CAMLparam2(v0, v1);
	GLuint lv0 = Int_val(v0);
	GLuint* lv1 = Data_bigarray_val(v1);
	LOAD_FUNCTION(glVariantuivEXT);
	(*stub_glVariantuivEXT)(lv0, lv1);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glVariantusvEXT,(GLuint, GLushort*),void);
value glstub_glVariantusvEXT(value v0, value v1)
{
	CAMLparam2(v0, v1);
	GLuint lv0 = Int_val(v0);
	GLushort* lv1 = Data_bigarray_val(v1);
	LOAD_FUNCTION(glVariantusvEXT);
	(*stub_glVariantusvEXT)(lv0, lv1);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glVertex2d,(GLdouble, GLdouble),void);
value glstub_glVertex2d(value v0, value v1)
{
	CAMLparam2(v0, v1);
	GLdouble lv0 = Double_val(v0);
	GLdouble lv1 = Double_val(v1);
	LOAD_FUNCTION(glVertex2d);
	(*stub_glVertex2d)(lv0, lv1);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glVertex2dv,(GLdouble*),void);
value glstub_glVertex2dv(value v0)
{
	CAMLparam1(v0);
	GLdouble* lv0 = (Tag_val(v0) == Double_array_tag)? (double *)v0: Data_bigarray_val(v0);
	LOAD_FUNCTION(glVertex2dv);
	(*stub_glVertex2dv)(lv0);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glVertex2f,(GLfloat, GLfloat),void);
value glstub_glVertex2f(value v0, value v1)
{
	CAMLparam2(v0, v1);
	GLfloat lv0 = Double_val(v0);
	GLfloat lv1 = Double_val(v1);
	LOAD_FUNCTION(glVertex2f);
	(*stub_glVertex2f)(lv0, lv1);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glVertex2fv,(GLfloat*),void);
value glstub_glVertex2fv(value v0)
{
	CAMLparam1(v0);
	GLfloat* lv0 = Data_bigarray_val(v0);
	LOAD_FUNCTION(glVertex2fv);
	(*stub_glVertex2fv)(lv0);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glVertex2hNV,(GLushort, GLushort),void);
value glstub_glVertex2hNV(value v0, value v1)
{
	CAMLparam2(v0, v1);
	GLushort lv0 = Int_val(v0);
	GLushort lv1 = Int_val(v1);
	LOAD_FUNCTION(glVertex2hNV);
	(*stub_glVertex2hNV)(lv0, lv1);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glVertex2hvNV,(GLushort*),void);
value glstub_glVertex2hvNV(value v0)
{
	CAMLparam1(v0);
	GLushort* lv0 = Data_bigarray_val(v0);
	LOAD_FUNCTION(glVertex2hvNV);
	(*stub_glVertex2hvNV)(lv0);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glVertex2i,(GLint, GLint),void);
value glstub_glVertex2i(value v0, value v1)
{
	CAMLparam2(v0, v1);
	GLint lv0 = Int_val(v0);
	GLint lv1 = Int_val(v1);
	LOAD_FUNCTION(glVertex2i);
	(*stub_glVertex2i)(lv0, lv1);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glVertex2iv,(GLint*),void);
value glstub_glVertex2iv(value v0)
{
	CAMLparam1(v0);
	GLint* lv0 = Data_bigarray_val(v0);
	LOAD_FUNCTION(glVertex2iv);
	(*stub_glVertex2iv)(lv0);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glVertex2s,(GLshort, GLshort),void);
value glstub_glVertex2s(value v0, value v1)
{
	CAMLparam2(v0, v1);
	GLshort lv0 = Int_val(v0);
	GLshort lv1 = Int_val(v1);
	LOAD_FUNCTION(glVertex2s);
	(*stub_glVertex2s)(lv0, lv1);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glVertex2sv,(GLshort*),void);
value glstub_glVertex2sv(value v0)
{
	CAMLparam1(v0);
	GLshort* lv0 = Data_bigarray_val(v0);
	LOAD_FUNCTION(glVertex2sv);
	(*stub_glVertex2sv)(lv0);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glVertex3d,(GLdouble, GLdouble, GLdouble),void);
value glstub_glVertex3d(value v0, value v1, value v2)
{
	CAMLparam3(v0, v1, v2);
	GLdouble lv0 = Double_val(v0);
	GLdouble lv1 = Double_val(v1);
	GLdouble lv2 = Double_val(v2);
	LOAD_FUNCTION(glVertex3d);
	(*stub_glVertex3d)(lv0, lv1, lv2);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glVertex3dv,(GLdouble*),void);
value glstub_glVertex3dv(value v0)
{
	CAMLparam1(v0);
	GLdouble* lv0 = (Tag_val(v0) == Double_array_tag)? (double *)v0: Data_bigarray_val(v0);
	LOAD_FUNCTION(glVertex3dv);
	(*stub_glVertex3dv)(lv0);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glVertex3f,(GLfloat, GLfloat, GLfloat),void);
value glstub_glVertex3f(value v0, value v1, value v2)
{
	CAMLparam3(v0, v1, v2);
	GLfloat lv0 = Double_val(v0);
	GLfloat lv1 = Double_val(v1);
	GLfloat lv2 = Double_val(v2);
	LOAD_FUNCTION(glVertex3f);
	(*stub_glVertex3f)(lv0, lv1, lv2);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glVertex3fv,(GLfloat*),void);
value glstub_glVertex3fv(value v0)
{
	CAMLparam1(v0);
	GLfloat* lv0 = Data_bigarray_val(v0);
	LOAD_FUNCTION(glVertex3fv);
	(*stub_glVertex3fv)(lv0);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glVertex3hNV,(GLushort, GLushort, GLushort),void);
value glstub_glVertex3hNV(value v0, value v1, value v2)
{
	CAMLparam3(v0, v1, v2);
	GLushort lv0 = Int_val(v0);
	GLushort lv1 = Int_val(v1);
	GLushort lv2 = Int_val(v2);
	LOAD_FUNCTION(glVertex3hNV);
	(*stub_glVertex3hNV)(lv0, lv1, lv2);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glVertex3hvNV,(GLushort*),void);
value glstub_glVertex3hvNV(value v0)
{
	CAMLparam1(v0);
	GLushort* lv0 = Data_bigarray_val(v0);
	LOAD_FUNCTION(glVertex3hvNV);
	(*stub_glVertex3hvNV)(lv0);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glVertex3i,(GLint, GLint, GLint),void);
value glstub_glVertex3i(value v0, value v1, value v2)
{
	CAMLparam3(v0, v1, v2);
	GLint lv0 = Int_val(v0);
	GLint lv1 = Int_val(v1);
	GLint lv2 = Int_val(v2);
	LOAD_FUNCTION(glVertex3i);
	(*stub_glVertex3i)(lv0, lv1, lv2);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glVertex3iv,(GLint*),void);
value glstub_glVertex3iv(value v0)
{
	CAMLparam1(v0);
	GLint* lv0 = Data_bigarray_val(v0);
	LOAD_FUNCTION(glVertex3iv);
	(*stub_glVertex3iv)(lv0);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glVertex3s,(GLshort, GLshort, GLshort),void);
value glstub_glVertex3s(value v0, value v1, value v2)
{
	CAMLparam3(v0, v1, v2);
	GLshort lv0 = Int_val(v0);
	GLshort lv1 = Int_val(v1);
	GLshort lv2 = Int_val(v2);
	LOAD_FUNCTION(glVertex3s);
	(*stub_glVertex3s)(lv0, lv1, lv2);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glVertex3sv,(GLshort*),void);
value glstub_glVertex3sv(value v0)
{
	CAMLparam1(v0);
	GLshort* lv0 = Data_bigarray_val(v0);
	LOAD_FUNCTION(glVertex3sv);
	(*stub_glVertex3sv)(lv0);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glVertex4d,(GLdouble, GLdouble, GLdouble, GLdouble),void);
value glstub_glVertex4d(value v0, value v1, value v2, value v3)
{
	CAMLparam4(v0, v1, v2, v3);
	GLdouble lv0 = Double_val(v0);
	GLdouble lv1 = Double_val(v1);
	GLdouble lv2 = Double_val(v2);
	GLdouble lv3 = Double_val(v3);
	LOAD_FUNCTION(glVertex4d);
	(*stub_glVertex4d)(lv0, lv1, lv2, lv3);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glVertex4dv,(GLdouble*),void);
value glstub_glVertex4dv(value v0)
{
	CAMLparam1(v0);
	GLdouble* lv0 = (Tag_val(v0) == Double_array_tag)? (double *)v0: Data_bigarray_val(v0);
	LOAD_FUNCTION(glVertex4dv);
	(*stub_glVertex4dv)(lv0);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glVertex4f,(GLfloat, GLfloat, GLfloat, GLfloat),void);
value glstub_glVertex4f(value v0, value v1, value v2, value v3)
{
	CAMLparam4(v0, v1, v2, v3);
	GLfloat lv0 = Double_val(v0);
	GLfloat lv1 = Double_val(v1);
	GLfloat lv2 = Double_val(v2);
	GLfloat lv3 = Double_val(v3);
	LOAD_FUNCTION(glVertex4f);
	(*stub_glVertex4f)(lv0, lv1, lv2, lv3);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glVertex4fv,(GLfloat*),void);
value glstub_glVertex4fv(value v0)
{
	CAMLparam1(v0);
	GLfloat* lv0 = Data_bigarray_val(v0);
	LOAD_FUNCTION(glVertex4fv);
	(*stub_glVertex4fv)(lv0);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glVertex4hNV,(GLushort, GLushort, GLushort, GLushort),void);
value glstub_glVertex4hNV(value v0, value v1, value v2, value v3)
{
	CAMLparam4(v0, v1, v2, v3);
	GLushort lv0 = Int_val(v0);
	GLushort lv1 = Int_val(v1);
	GLushort lv2 = Int_val(v2);
	GLushort lv3 = Int_val(v3);
	LOAD_FUNCTION(glVertex4hNV);
	(*stub_glVertex4hNV)(lv0, lv1, lv2, lv3);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glVertex4hvNV,(GLushort*),void);
value glstub_glVertex4hvNV(value v0)
{
	CAMLparam1(v0);
	GLushort* lv0 = Data_bigarray_val(v0);
	LOAD_FUNCTION(glVertex4hvNV);
	(*stub_glVertex4hvNV)(lv0);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glVertex4i,(GLint, GLint, GLint, GLint),void);
value glstub_glVertex4i(value v0, value v1, value v2, value v3)
{
	CAMLparam4(v0, v1, v2, v3);
	GLint lv0 = Int_val(v0);
	GLint lv1 = Int_val(v1);
	GLint lv2 = Int_val(v2);
	GLint lv3 = Int_val(v3);
	LOAD_FUNCTION(glVertex4i);
	(*stub_glVertex4i)(lv0, lv1, lv2, lv3);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glVertex4iv,(GLint*),void);
value glstub_glVertex4iv(value v0)
{
	CAMLparam1(v0);
	GLint* lv0 = Data_bigarray_val(v0);
	LOAD_FUNCTION(glVertex4iv);
	(*stub_glVertex4iv)(lv0);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glVertex4s,(GLshort, GLshort, GLshort, GLshort),void);
value glstub_glVertex4s(value v0, value v1, value v2, value v3)
{
	CAMLparam4(v0, v1, v2, v3);
	GLshort lv0 = Int_val(v0);
	GLshort lv1 = Int_val(v1);
	GLshort lv2 = Int_val(v2);
	GLshort lv3 = Int_val(v3);
	LOAD_FUNCTION(glVertex4s);
	(*stub_glVertex4s)(lv0, lv1, lv2, lv3);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glVertex4sv,(GLshort*),void);
value glstub_glVertex4sv(value v0)
{
	CAMLparam1(v0);
	GLshort* lv0 = Data_bigarray_val(v0);
	LOAD_FUNCTION(glVertex4sv);
	(*stub_glVertex4sv)(lv0);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glVertexArrayParameteriAPPLE,(GLenum, GLint),void);
value glstub_glVertexArrayParameteriAPPLE(value v0, value v1)
{
	CAMLparam2(v0, v1);
	GLenum lv0 = Int_val(v0);
	GLint lv1 = Int_val(v1);
	LOAD_FUNCTION(glVertexArrayParameteriAPPLE);
	(*stub_glVertexArrayParameteriAPPLE)(lv0, lv1);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glVertexArrayRangeAPPLE,(GLsizei, GLvoid*),void);
value glstub_glVertexArrayRangeAPPLE(value v0, value v1)
{
	CAMLparam2(v0, v1);
	GLsizei lv0 = Int_val(v0);
	GLvoid* lv1 = (GLvoid *)((Tag_val(v1) == String_tag)? (String_val(v1)) : (Data_bigarray_val(v1)));
	LOAD_FUNCTION(glVertexArrayRangeAPPLE);
	(*stub_glVertexArrayRangeAPPLE)(lv0, lv1);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glVertexArrayRangeNV,(GLsizei, GLvoid*),void);
value glstub_glVertexArrayRangeNV(value v0, value v1)
{
	CAMLparam2(v0, v1);
	GLsizei lv0 = Int_val(v0);
	GLvoid* lv1 = (GLvoid *)((Tag_val(v1) == String_tag)? (String_val(v1)) : (Data_bigarray_val(v1)));
	LOAD_FUNCTION(glVertexArrayRangeNV);
	(*stub_glVertexArrayRangeNV)(lv0, lv1);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glVertexAttrib1d,(GLuint, GLdouble),void);
value glstub_glVertexAttrib1d(value v0, value v1)
{
	CAMLparam2(v0, v1);
	GLuint lv0 = Int_val(v0);
	GLdouble lv1 = Double_val(v1);
	LOAD_FUNCTION(glVertexAttrib1d);
	(*stub_glVertexAttrib1d)(lv0, lv1);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glVertexAttrib1dARB,(GLuint, GLdouble),void);
value glstub_glVertexAttrib1dARB(value v0, value v1)
{
	CAMLparam2(v0, v1);
	GLuint lv0 = Int_val(v0);
	GLdouble lv1 = Double_val(v1);
	LOAD_FUNCTION(glVertexAttrib1dARB);
	(*stub_glVertexAttrib1dARB)(lv0, lv1);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glVertexAttrib1dNV,(GLuint, GLdouble),void);
value glstub_glVertexAttrib1dNV(value v0, value v1)
{
	CAMLparam2(v0, v1);
	GLuint lv0 = Int_val(v0);
	GLdouble lv1 = Double_val(v1);
	LOAD_FUNCTION(glVertexAttrib1dNV);
	(*stub_glVertexAttrib1dNV)(lv0, lv1);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glVertexAttrib1dv,(GLuint, GLdouble*),void);
value glstub_glVertexAttrib1dv(value v0, value v1)
{
	CAMLparam2(v0, v1);
	GLuint lv0 = Int_val(v0);
	GLdouble* lv1 = (Tag_val(v1) == Double_array_tag)? (double *)v1: Data_bigarray_val(v1);
	LOAD_FUNCTION(glVertexAttrib1dv);
	(*stub_glVertexAttrib1dv)(lv0, lv1);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glVertexAttrib1dvARB,(GLuint, GLdouble*),void);
value glstub_glVertexAttrib1dvARB(value v0, value v1)
{
	CAMLparam2(v0, v1);
	GLuint lv0 = Int_val(v0);
	GLdouble* lv1 = (Tag_val(v1) == Double_array_tag)? (double *)v1: Data_bigarray_val(v1);
	LOAD_FUNCTION(glVertexAttrib1dvARB);
	(*stub_glVertexAttrib1dvARB)(lv0, lv1);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glVertexAttrib1dvNV,(GLuint, GLdouble*),void);
value glstub_glVertexAttrib1dvNV(value v0, value v1)
{
	CAMLparam2(v0, v1);
	GLuint lv0 = Int_val(v0);
	GLdouble* lv1 = (Tag_val(v1) == Double_array_tag)? (double *)v1: Data_bigarray_val(v1);
	LOAD_FUNCTION(glVertexAttrib1dvNV);
	(*stub_glVertexAttrib1dvNV)(lv0, lv1);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glVertexAttrib1f,(GLuint, GLfloat),void);
value glstub_glVertexAttrib1f(value v0, value v1)
{
	CAMLparam2(v0, v1);
	GLuint lv0 = Int_val(v0);
	GLfloat lv1 = Double_val(v1);
	LOAD_FUNCTION(glVertexAttrib1f);
	(*stub_glVertexAttrib1f)(lv0, lv1);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glVertexAttrib1fARB,(GLuint, GLfloat),void);
value glstub_glVertexAttrib1fARB(value v0, value v1)
{
	CAMLparam2(v0, v1);
	GLuint lv0 = Int_val(v0);
	GLfloat lv1 = Double_val(v1);
	LOAD_FUNCTION(glVertexAttrib1fARB);
	(*stub_glVertexAttrib1fARB)(lv0, lv1);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glVertexAttrib1fNV,(GLuint, GLfloat),void);
value glstub_glVertexAttrib1fNV(value v0, value v1)
{
	CAMLparam2(v0, v1);
	GLuint lv0 = Int_val(v0);
	GLfloat lv1 = Double_val(v1);
	LOAD_FUNCTION(glVertexAttrib1fNV);
	(*stub_glVertexAttrib1fNV)(lv0, lv1);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glVertexAttrib1fv,(GLuint, GLfloat*),void);
value glstub_glVertexAttrib1fv(value v0, value v1)
{
	CAMLparam2(v0, v1);
	GLuint lv0 = Int_val(v0);
	GLfloat* lv1 = Data_bigarray_val(v1);
	LOAD_FUNCTION(glVertexAttrib1fv);
	(*stub_glVertexAttrib1fv)(lv0, lv1);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glVertexAttrib1fvARB,(GLuint, GLfloat*),void);
value glstub_glVertexAttrib1fvARB(value v0, value v1)
{
	CAMLparam2(v0, v1);
	GLuint lv0 = Int_val(v0);
	GLfloat* lv1 = Data_bigarray_val(v1);
	LOAD_FUNCTION(glVertexAttrib1fvARB);
	(*stub_glVertexAttrib1fvARB)(lv0, lv1);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glVertexAttrib1fvNV,(GLuint, GLfloat*),void);
value glstub_glVertexAttrib1fvNV(value v0, value v1)
{
	CAMLparam2(v0, v1);
	GLuint lv0 = Int_val(v0);
	GLfloat* lv1 = Data_bigarray_val(v1);
	LOAD_FUNCTION(glVertexAttrib1fvNV);
	(*stub_glVertexAttrib1fvNV)(lv0, lv1);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glVertexAttrib1hNV,(GLuint, GLushort),void);
value glstub_glVertexAttrib1hNV(value v0, value v1)
{
	CAMLparam2(v0, v1);
	GLuint lv0 = Int_val(v0);
	GLushort lv1 = Int_val(v1);
	LOAD_FUNCTION(glVertexAttrib1hNV);
	(*stub_glVertexAttrib1hNV)(lv0, lv1);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glVertexAttrib1hvNV,(GLuint, GLushort*),void);
value glstub_glVertexAttrib1hvNV(value v0, value v1)
{
	CAMLparam2(v0, v1);
	GLuint lv0 = Int_val(v0);
	GLushort* lv1 = Data_bigarray_val(v1);
	LOAD_FUNCTION(glVertexAttrib1hvNV);
	(*stub_glVertexAttrib1hvNV)(lv0, lv1);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glVertexAttrib1s,(GLuint, GLshort),void);
value glstub_glVertexAttrib1s(value v0, value v1)
{
	CAMLparam2(v0, v1);
	GLuint lv0 = Int_val(v0);
	GLshort lv1 = Int_val(v1);
	LOAD_FUNCTION(glVertexAttrib1s);
	(*stub_glVertexAttrib1s)(lv0, lv1);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glVertexAttrib1sARB,(GLuint, GLshort),void);
value glstub_glVertexAttrib1sARB(value v0, value v1)
{
	CAMLparam2(v0, v1);
	GLuint lv0 = Int_val(v0);
	GLshort lv1 = Int_val(v1);
	LOAD_FUNCTION(glVertexAttrib1sARB);
	(*stub_glVertexAttrib1sARB)(lv0, lv1);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glVertexAttrib1sNV,(GLuint, GLshort),void);
value glstub_glVertexAttrib1sNV(value v0, value v1)
{
	CAMLparam2(v0, v1);
	GLuint lv0 = Int_val(v0);
	GLshort lv1 = Int_val(v1);
	LOAD_FUNCTION(glVertexAttrib1sNV);
	(*stub_glVertexAttrib1sNV)(lv0, lv1);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glVertexAttrib1sv,(GLuint, GLshort*),void);
value glstub_glVertexAttrib1sv(value v0, value v1)
{
	CAMLparam2(v0, v1);
	GLuint lv0 = Int_val(v0);
	GLshort* lv1 = Data_bigarray_val(v1);
	LOAD_FUNCTION(glVertexAttrib1sv);
	(*stub_glVertexAttrib1sv)(lv0, lv1);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glVertexAttrib1svARB,(GLuint, GLshort*),void);
value glstub_glVertexAttrib1svARB(value v0, value v1)
{
	CAMLparam2(v0, v1);
	GLuint lv0 = Int_val(v0);
	GLshort* lv1 = Data_bigarray_val(v1);
	LOAD_FUNCTION(glVertexAttrib1svARB);
	(*stub_glVertexAttrib1svARB)(lv0, lv1);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glVertexAttrib1svNV,(GLuint, GLshort*),void);
value glstub_glVertexAttrib1svNV(value v0, value v1)
{
	CAMLparam2(v0, v1);
	GLuint lv0 = Int_val(v0);
	GLshort* lv1 = Data_bigarray_val(v1);
	LOAD_FUNCTION(glVertexAttrib1svNV);
	(*stub_glVertexAttrib1svNV)(lv0, lv1);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glVertexAttrib2d,(GLuint, GLdouble, GLdouble),void);
value glstub_glVertexAttrib2d(value v0, value v1, value v2)
{
	CAMLparam3(v0, v1, v2);
	GLuint lv0 = Int_val(v0);
	GLdouble lv1 = Double_val(v1);
	GLdouble lv2 = Double_val(v2);
	LOAD_FUNCTION(glVertexAttrib2d);
	(*stub_glVertexAttrib2d)(lv0, lv1, lv2);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glVertexAttrib2dARB,(GLuint, GLdouble, GLdouble),void);
value glstub_glVertexAttrib2dARB(value v0, value v1, value v2)
{
	CAMLparam3(v0, v1, v2);
	GLuint lv0 = Int_val(v0);
	GLdouble lv1 = Double_val(v1);
	GLdouble lv2 = Double_val(v2);
	LOAD_FUNCTION(glVertexAttrib2dARB);
	(*stub_glVertexAttrib2dARB)(lv0, lv1, lv2);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glVertexAttrib2dNV,(GLuint, GLdouble, GLdouble),void);
value glstub_glVertexAttrib2dNV(value v0, value v1, value v2)
{
	CAMLparam3(v0, v1, v2);
	GLuint lv0 = Int_val(v0);
	GLdouble lv1 = Double_val(v1);
	GLdouble lv2 = Double_val(v2);
	LOAD_FUNCTION(glVertexAttrib2dNV);
	(*stub_glVertexAttrib2dNV)(lv0, lv1, lv2);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glVertexAttrib2dv,(GLuint, GLdouble*),void);
value glstub_glVertexAttrib2dv(value v0, value v1)
{
	CAMLparam2(v0, v1);
	GLuint lv0 = Int_val(v0);
	GLdouble* lv1 = (Tag_val(v1) == Double_array_tag)? (double *)v1: Data_bigarray_val(v1);
	LOAD_FUNCTION(glVertexAttrib2dv);
	(*stub_glVertexAttrib2dv)(lv0, lv1);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glVertexAttrib2dvARB,(GLuint, GLdouble*),void);
value glstub_glVertexAttrib2dvARB(value v0, value v1)
{
	CAMLparam2(v0, v1);
	GLuint lv0 = Int_val(v0);
	GLdouble* lv1 = (Tag_val(v1) == Double_array_tag)? (double *)v1: Data_bigarray_val(v1);
	LOAD_FUNCTION(glVertexAttrib2dvARB);
	(*stub_glVertexAttrib2dvARB)(lv0, lv1);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glVertexAttrib2dvNV,(GLuint, GLdouble*),void);
value glstub_glVertexAttrib2dvNV(value v0, value v1)
{
	CAMLparam2(v0, v1);
	GLuint lv0 = Int_val(v0);
	GLdouble* lv1 = (Tag_val(v1) == Double_array_tag)? (double *)v1: Data_bigarray_val(v1);
	LOAD_FUNCTION(glVertexAttrib2dvNV);
	(*stub_glVertexAttrib2dvNV)(lv0, lv1);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glVertexAttrib2f,(GLuint, GLfloat, GLfloat),void);
value glstub_glVertexAttrib2f(value v0, value v1, value v2)
{
	CAMLparam3(v0, v1, v2);
	GLuint lv0 = Int_val(v0);
	GLfloat lv1 = Double_val(v1);
	GLfloat lv2 = Double_val(v2);
	LOAD_FUNCTION(glVertexAttrib2f);
	(*stub_glVertexAttrib2f)(lv0, lv1, lv2);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glVertexAttrib2fARB,(GLuint, GLfloat, GLfloat),void);
value glstub_glVertexAttrib2fARB(value v0, value v1, value v2)
{
	CAMLparam3(v0, v1, v2);
	GLuint lv0 = Int_val(v0);
	GLfloat lv1 = Double_val(v1);
	GLfloat lv2 = Double_val(v2);
	LOAD_FUNCTION(glVertexAttrib2fARB);
	(*stub_glVertexAttrib2fARB)(lv0, lv1, lv2);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glVertexAttrib2fNV,(GLuint, GLfloat, GLfloat),void);
value glstub_glVertexAttrib2fNV(value v0, value v1, value v2)
{
	CAMLparam3(v0, v1, v2);
	GLuint lv0 = Int_val(v0);
	GLfloat lv1 = Double_val(v1);
	GLfloat lv2 = Double_val(v2);
	LOAD_FUNCTION(glVertexAttrib2fNV);
	(*stub_glVertexAttrib2fNV)(lv0, lv1, lv2);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glVertexAttrib2fv,(GLuint, GLfloat*),void);
value glstub_glVertexAttrib2fv(value v0, value v1)
{
	CAMLparam2(v0, v1);
	GLuint lv0 = Int_val(v0);
	GLfloat* lv1 = Data_bigarray_val(v1);
	LOAD_FUNCTION(glVertexAttrib2fv);
	(*stub_glVertexAttrib2fv)(lv0, lv1);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glVertexAttrib2fvARB,(GLuint, GLfloat*),void);
value glstub_glVertexAttrib2fvARB(value v0, value v1)
{
	CAMLparam2(v0, v1);
	GLuint lv0 = Int_val(v0);
	GLfloat* lv1 = Data_bigarray_val(v1);
	LOAD_FUNCTION(glVertexAttrib2fvARB);
	(*stub_glVertexAttrib2fvARB)(lv0, lv1);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glVertexAttrib2fvNV,(GLuint, GLfloat*),void);
value glstub_glVertexAttrib2fvNV(value v0, value v1)
{
	CAMLparam2(v0, v1);
	GLuint lv0 = Int_val(v0);
	GLfloat* lv1 = Data_bigarray_val(v1);
	LOAD_FUNCTION(glVertexAttrib2fvNV);
	(*stub_glVertexAttrib2fvNV)(lv0, lv1);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glVertexAttrib2hNV,(GLuint, GLushort, GLushort),void);
value glstub_glVertexAttrib2hNV(value v0, value v1, value v2)
{
	CAMLparam3(v0, v1, v2);
	GLuint lv0 = Int_val(v0);
	GLushort lv1 = Int_val(v1);
	GLushort lv2 = Int_val(v2);
	LOAD_FUNCTION(glVertexAttrib2hNV);
	(*stub_glVertexAttrib2hNV)(lv0, lv1, lv2);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glVertexAttrib2hvNV,(GLuint, GLushort*),void);
value glstub_glVertexAttrib2hvNV(value v0, value v1)
{
	CAMLparam2(v0, v1);
	GLuint lv0 = Int_val(v0);
	GLushort* lv1 = Data_bigarray_val(v1);
	LOAD_FUNCTION(glVertexAttrib2hvNV);
	(*stub_glVertexAttrib2hvNV)(lv0, lv1);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glVertexAttrib2s,(GLuint, GLshort, GLshort),void);
value glstub_glVertexAttrib2s(value v0, value v1, value v2)
{
	CAMLparam3(v0, v1, v2);
	GLuint lv0 = Int_val(v0);
	GLshort lv1 = Int_val(v1);
	GLshort lv2 = Int_val(v2);
	LOAD_FUNCTION(glVertexAttrib2s);
	(*stub_glVertexAttrib2s)(lv0, lv1, lv2);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glVertexAttrib2sARB,(GLuint, GLshort, GLshort),void);
value glstub_glVertexAttrib2sARB(value v0, value v1, value v2)
{
	CAMLparam3(v0, v1, v2);
	GLuint lv0 = Int_val(v0);
	GLshort lv1 = Int_val(v1);
	GLshort lv2 = Int_val(v2);
	LOAD_FUNCTION(glVertexAttrib2sARB);
	(*stub_glVertexAttrib2sARB)(lv0, lv1, lv2);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glVertexAttrib2sNV,(GLuint, GLshort, GLshort),void);
value glstub_glVertexAttrib2sNV(value v0, value v1, value v2)
{
	CAMLparam3(v0, v1, v2);
	GLuint lv0 = Int_val(v0);
	GLshort lv1 = Int_val(v1);
	GLshort lv2 = Int_val(v2);
	LOAD_FUNCTION(glVertexAttrib2sNV);
	(*stub_glVertexAttrib2sNV)(lv0, lv1, lv2);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glVertexAttrib2sv,(GLuint, GLshort*),void);
value glstub_glVertexAttrib2sv(value v0, value v1)
{
	CAMLparam2(v0, v1);
	GLuint lv0 = Int_val(v0);
	GLshort* lv1 = Data_bigarray_val(v1);
	LOAD_FUNCTION(glVertexAttrib2sv);
	(*stub_glVertexAttrib2sv)(lv0, lv1);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glVertexAttrib2svARB,(GLuint, GLshort*),void);
value glstub_glVertexAttrib2svARB(value v0, value v1)
{
	CAMLparam2(v0, v1);
	GLuint lv0 = Int_val(v0);
	GLshort* lv1 = Data_bigarray_val(v1);
	LOAD_FUNCTION(glVertexAttrib2svARB);
	(*stub_glVertexAttrib2svARB)(lv0, lv1);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glVertexAttrib2svNV,(GLuint, GLshort*),void);
value glstub_glVertexAttrib2svNV(value v0, value v1)
{
	CAMLparam2(v0, v1);
	GLuint lv0 = Int_val(v0);
	GLshort* lv1 = Data_bigarray_val(v1);
	LOAD_FUNCTION(glVertexAttrib2svNV);
	(*stub_glVertexAttrib2svNV)(lv0, lv1);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glVertexAttrib3d,(GLuint, GLdouble, GLdouble, GLdouble),void);
value glstub_glVertexAttrib3d(value v0, value v1, value v2, value v3)
{
	CAMLparam4(v0, v1, v2, v3);
	GLuint lv0 = Int_val(v0);
	GLdouble lv1 = Double_val(v1);
	GLdouble lv2 = Double_val(v2);
	GLdouble lv3 = Double_val(v3);
	LOAD_FUNCTION(glVertexAttrib3d);
	(*stub_glVertexAttrib3d)(lv0, lv1, lv2, lv3);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glVertexAttrib3dARB,(GLuint, GLdouble, GLdouble, GLdouble),void);
value glstub_glVertexAttrib3dARB(value v0, value v1, value v2, value v3)
{
	CAMLparam4(v0, v1, v2, v3);
	GLuint lv0 = Int_val(v0);
	GLdouble lv1 = Double_val(v1);
	GLdouble lv2 = Double_val(v2);
	GLdouble lv3 = Double_val(v3);
	LOAD_FUNCTION(glVertexAttrib3dARB);
	(*stub_glVertexAttrib3dARB)(lv0, lv1, lv2, lv3);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glVertexAttrib3dNV,(GLuint, GLdouble, GLdouble, GLdouble),void);
value glstub_glVertexAttrib3dNV(value v0, value v1, value v2, value v3)
{
	CAMLparam4(v0, v1, v2, v3);
	GLuint lv0 = Int_val(v0);
	GLdouble lv1 = Double_val(v1);
	GLdouble lv2 = Double_val(v2);
	GLdouble lv3 = Double_val(v3);
	LOAD_FUNCTION(glVertexAttrib3dNV);
	(*stub_glVertexAttrib3dNV)(lv0, lv1, lv2, lv3);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glVertexAttrib3dv,(GLuint, GLdouble*),void);
value glstub_glVertexAttrib3dv(value v0, value v1)
{
	CAMLparam2(v0, v1);
	GLuint lv0 = Int_val(v0);
	GLdouble* lv1 = (Tag_val(v1) == Double_array_tag)? (double *)v1: Data_bigarray_val(v1);
	LOAD_FUNCTION(glVertexAttrib3dv);
	(*stub_glVertexAttrib3dv)(lv0, lv1);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glVertexAttrib3dvARB,(GLuint, GLdouble*),void);
value glstub_glVertexAttrib3dvARB(value v0, value v1)
{
	CAMLparam2(v0, v1);
	GLuint lv0 = Int_val(v0);
	GLdouble* lv1 = (Tag_val(v1) == Double_array_tag)? (double *)v1: Data_bigarray_val(v1);
	LOAD_FUNCTION(glVertexAttrib3dvARB);
	(*stub_glVertexAttrib3dvARB)(lv0, lv1);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glVertexAttrib3dvNV,(GLuint, GLdouble*),void);
value glstub_glVertexAttrib3dvNV(value v0, value v1)
{
	CAMLparam2(v0, v1);
	GLuint lv0 = Int_val(v0);
	GLdouble* lv1 = (Tag_val(v1) == Double_array_tag)? (double *)v1: Data_bigarray_val(v1);
	LOAD_FUNCTION(glVertexAttrib3dvNV);
	(*stub_glVertexAttrib3dvNV)(lv0, lv1);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glVertexAttrib3f,(GLuint, GLfloat, GLfloat, GLfloat),void);
value glstub_glVertexAttrib3f(value v0, value v1, value v2, value v3)
{
	CAMLparam4(v0, v1, v2, v3);
	GLuint lv0 = Int_val(v0);
	GLfloat lv1 = Double_val(v1);
	GLfloat lv2 = Double_val(v2);
	GLfloat lv3 = Double_val(v3);
	LOAD_FUNCTION(glVertexAttrib3f);
	(*stub_glVertexAttrib3f)(lv0, lv1, lv2, lv3);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glVertexAttrib3fARB,(GLuint, GLfloat, GLfloat, GLfloat),void);
value glstub_glVertexAttrib3fARB(value v0, value v1, value v2, value v3)
{
	CAMLparam4(v0, v1, v2, v3);
	GLuint lv0 = Int_val(v0);
	GLfloat lv1 = Double_val(v1);
	GLfloat lv2 = Double_val(v2);
	GLfloat lv3 = Double_val(v3);
	LOAD_FUNCTION(glVertexAttrib3fARB);
	(*stub_glVertexAttrib3fARB)(lv0, lv1, lv2, lv3);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glVertexAttrib3fNV,(GLuint, GLfloat, GLfloat, GLfloat),void);
value glstub_glVertexAttrib3fNV(value v0, value v1, value v2, value v3)
{
	CAMLparam4(v0, v1, v2, v3);
	GLuint lv0 = Int_val(v0);
	GLfloat lv1 = Double_val(v1);
	GLfloat lv2 = Double_val(v2);
	GLfloat lv3 = Double_val(v3);
	LOAD_FUNCTION(glVertexAttrib3fNV);
	(*stub_glVertexAttrib3fNV)(lv0, lv1, lv2, lv3);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glVertexAttrib3fv,(GLuint, GLfloat*),void);
value glstub_glVertexAttrib3fv(value v0, value v1)
{
	CAMLparam2(v0, v1);
	GLuint lv0 = Int_val(v0);
	GLfloat* lv1 = Data_bigarray_val(v1);
	LOAD_FUNCTION(glVertexAttrib3fv);
	(*stub_glVertexAttrib3fv)(lv0, lv1);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glVertexAttrib3fvARB,(GLuint, GLfloat*),void);
value glstub_glVertexAttrib3fvARB(value v0, value v1)
{
	CAMLparam2(v0, v1);
	GLuint lv0 = Int_val(v0);
	GLfloat* lv1 = Data_bigarray_val(v1);
	LOAD_FUNCTION(glVertexAttrib3fvARB);
	(*stub_glVertexAttrib3fvARB)(lv0, lv1);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glVertexAttrib3fvNV,(GLuint, GLfloat*),void);
value glstub_glVertexAttrib3fvNV(value v0, value v1)
{
	CAMLparam2(v0, v1);
	GLuint lv0 = Int_val(v0);
	GLfloat* lv1 = Data_bigarray_val(v1);
	LOAD_FUNCTION(glVertexAttrib3fvNV);
	(*stub_glVertexAttrib3fvNV)(lv0, lv1);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glVertexAttrib3hNV,(GLuint, GLushort, GLushort, GLushort),void);
value glstub_glVertexAttrib3hNV(value v0, value v1, value v2, value v3)
{
	CAMLparam4(v0, v1, v2, v3);
	GLuint lv0 = Int_val(v0);
	GLushort lv1 = Int_val(v1);
	GLushort lv2 = Int_val(v2);
	GLushort lv3 = Int_val(v3);
	LOAD_FUNCTION(glVertexAttrib3hNV);
	(*stub_glVertexAttrib3hNV)(lv0, lv1, lv2, lv3);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glVertexAttrib3hvNV,(GLuint, GLushort*),void);
value glstub_glVertexAttrib3hvNV(value v0, value v1)
{
	CAMLparam2(v0, v1);
	GLuint lv0 = Int_val(v0);
	GLushort* lv1 = Data_bigarray_val(v1);
	LOAD_FUNCTION(glVertexAttrib3hvNV);
	(*stub_glVertexAttrib3hvNV)(lv0, lv1);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glVertexAttrib3s,(GLuint, GLshort, GLshort, GLshort),void);
value glstub_glVertexAttrib3s(value v0, value v1, value v2, value v3)
{
	CAMLparam4(v0, v1, v2, v3);
	GLuint lv0 = Int_val(v0);
	GLshort lv1 = Int_val(v1);
	GLshort lv2 = Int_val(v2);
	GLshort lv3 = Int_val(v3);
	LOAD_FUNCTION(glVertexAttrib3s);
	(*stub_glVertexAttrib3s)(lv0, lv1, lv2, lv3);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glVertexAttrib3sARB,(GLuint, GLshort, GLshort, GLshort),void);
value glstub_glVertexAttrib3sARB(value v0, value v1, value v2, value v3)
{
	CAMLparam4(v0, v1, v2, v3);
	GLuint lv0 = Int_val(v0);
	GLshort lv1 = Int_val(v1);
	GLshort lv2 = Int_val(v2);
	GLshort lv3 = Int_val(v3);
	LOAD_FUNCTION(glVertexAttrib3sARB);
	(*stub_glVertexAttrib3sARB)(lv0, lv1, lv2, lv3);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glVertexAttrib3sNV,(GLuint, GLshort, GLshort, GLshort),void);
value glstub_glVertexAttrib3sNV(value v0, value v1, value v2, value v3)
{
	CAMLparam4(v0, v1, v2, v3);
	GLuint lv0 = Int_val(v0);
	GLshort lv1 = Int_val(v1);
	GLshort lv2 = Int_val(v2);
	GLshort lv3 = Int_val(v3);
	LOAD_FUNCTION(glVertexAttrib3sNV);
	(*stub_glVertexAttrib3sNV)(lv0, lv1, lv2, lv3);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glVertexAttrib3sv,(GLuint, GLshort*),void);
value glstub_glVertexAttrib3sv(value v0, value v1)
{
	CAMLparam2(v0, v1);
	GLuint lv0 = Int_val(v0);
	GLshort* lv1 = Data_bigarray_val(v1);
	LOAD_FUNCTION(glVertexAttrib3sv);
	(*stub_glVertexAttrib3sv)(lv0, lv1);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glVertexAttrib3svARB,(GLuint, GLshort*),void);
value glstub_glVertexAttrib3svARB(value v0, value v1)
{
	CAMLparam2(v0, v1);
	GLuint lv0 = Int_val(v0);
	GLshort* lv1 = Data_bigarray_val(v1);
	LOAD_FUNCTION(glVertexAttrib3svARB);
	(*stub_glVertexAttrib3svARB)(lv0, lv1);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glVertexAttrib3svNV,(GLuint, GLshort*),void);
value glstub_glVertexAttrib3svNV(value v0, value v1)
{
	CAMLparam2(v0, v1);
	GLuint lv0 = Int_val(v0);
	GLshort* lv1 = Data_bigarray_val(v1);
	LOAD_FUNCTION(glVertexAttrib3svNV);
	(*stub_glVertexAttrib3svNV)(lv0, lv1);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glVertexAttrib4Nbv,(GLuint, GLbyte*),void);
value glstub_glVertexAttrib4Nbv(value v0, value v1)
{
	CAMLparam2(v0, v1);
	GLuint lv0 = Int_val(v0);
	GLbyte* lv1 = Data_bigarray_val(v1);
	LOAD_FUNCTION(glVertexAttrib4Nbv);
	(*stub_glVertexAttrib4Nbv)(lv0, lv1);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glVertexAttrib4NbvARB,(GLuint, GLbyte*),void);
value glstub_glVertexAttrib4NbvARB(value v0, value v1)
{
	CAMLparam2(v0, v1);
	GLuint lv0 = Int_val(v0);
	GLbyte* lv1 = Data_bigarray_val(v1);
	LOAD_FUNCTION(glVertexAttrib4NbvARB);
	(*stub_glVertexAttrib4NbvARB)(lv0, lv1);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glVertexAttrib4Niv,(GLuint, GLint*),void);
value glstub_glVertexAttrib4Niv(value v0, value v1)
{
	CAMLparam2(v0, v1);
	GLuint lv0 = Int_val(v0);
	GLint* lv1 = Data_bigarray_val(v1);
	LOAD_FUNCTION(glVertexAttrib4Niv);
	(*stub_glVertexAttrib4Niv)(lv0, lv1);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glVertexAttrib4NivARB,(GLuint, GLint*),void);
value glstub_glVertexAttrib4NivARB(value v0, value v1)
{
	CAMLparam2(v0, v1);
	GLuint lv0 = Int_val(v0);
	GLint* lv1 = Data_bigarray_val(v1);
	LOAD_FUNCTION(glVertexAttrib4NivARB);
	(*stub_glVertexAttrib4NivARB)(lv0, lv1);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glVertexAttrib4Nsv,(GLuint, GLshort*),void);
value glstub_glVertexAttrib4Nsv(value v0, value v1)
{
	CAMLparam2(v0, v1);
	GLuint lv0 = Int_val(v0);
	GLshort* lv1 = Data_bigarray_val(v1);
	LOAD_FUNCTION(glVertexAttrib4Nsv);
	(*stub_glVertexAttrib4Nsv)(lv0, lv1);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glVertexAttrib4NsvARB,(GLuint, GLshort*),void);
value glstub_glVertexAttrib4NsvARB(value v0, value v1)
{
	CAMLparam2(v0, v1);
	GLuint lv0 = Int_val(v0);
	GLshort* lv1 = Data_bigarray_val(v1);
	LOAD_FUNCTION(glVertexAttrib4NsvARB);
	(*stub_glVertexAttrib4NsvARB)(lv0, lv1);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glVertexAttrib4Nub,(GLuint, GLubyte, GLubyte, GLubyte, GLubyte),void);
value glstub_glVertexAttrib4Nub(value v0, value v1, value v2, value v3, value v4)
{
	CAMLparam5(v0, v1, v2, v3, v4);
	GLuint lv0 = Int_val(v0);
	GLubyte lv1 = Int_val(v1);
	GLubyte lv2 = Int_val(v2);
	GLubyte lv3 = Int_val(v3);
	GLubyte lv4 = Int_val(v4);
	LOAD_FUNCTION(glVertexAttrib4Nub);
	(*stub_glVertexAttrib4Nub)(lv0, lv1, lv2, lv3, lv4);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glVertexAttrib4NubARB,(GLuint, GLubyte, GLubyte, GLubyte, GLubyte),void);
value glstub_glVertexAttrib4NubARB(value v0, value v1, value v2, value v3, value v4)
{
	CAMLparam5(v0, v1, v2, v3, v4);
	GLuint lv0 = Int_val(v0);
	GLubyte lv1 = Int_val(v1);
	GLubyte lv2 = Int_val(v2);
	GLubyte lv3 = Int_val(v3);
	GLubyte lv4 = Int_val(v4);
	LOAD_FUNCTION(glVertexAttrib4NubARB);
	(*stub_glVertexAttrib4NubARB)(lv0, lv1, lv2, lv3, lv4);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glVertexAttrib4Nubv,(GLuint, GLubyte*),void);
value glstub_glVertexAttrib4Nubv(value v0, value v1)
{
	CAMLparam2(v0, v1);
	GLuint lv0 = Int_val(v0);
	GLubyte* lv1 = Data_bigarray_val(v1);
	LOAD_FUNCTION(glVertexAttrib4Nubv);
	(*stub_glVertexAttrib4Nubv)(lv0, lv1);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glVertexAttrib4NubvARB,(GLuint, GLubyte*),void);
value glstub_glVertexAttrib4NubvARB(value v0, value v1)
{
	CAMLparam2(v0, v1);
	GLuint lv0 = Int_val(v0);
	GLubyte* lv1 = Data_bigarray_val(v1);
	LOAD_FUNCTION(glVertexAttrib4NubvARB);
	(*stub_glVertexAttrib4NubvARB)(lv0, lv1);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glVertexAttrib4Nuiv,(GLuint, GLuint*),void);
value glstub_glVertexAttrib4Nuiv(value v0, value v1)
{
	CAMLparam2(v0, v1);
	GLuint lv0 = Int_val(v0);
	GLuint* lv1 = Data_bigarray_val(v1);
	LOAD_FUNCTION(glVertexAttrib4Nuiv);
	(*stub_glVertexAttrib4Nuiv)(lv0, lv1);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glVertexAttrib4NuivARB,(GLuint, GLuint*),void);
value glstub_glVertexAttrib4NuivARB(value v0, value v1)
{
	CAMLparam2(v0, v1);
	GLuint lv0 = Int_val(v0);
	GLuint* lv1 = Data_bigarray_val(v1);
	LOAD_FUNCTION(glVertexAttrib4NuivARB);
	(*stub_glVertexAttrib4NuivARB)(lv0, lv1);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glVertexAttrib4Nusv,(GLuint, GLushort*),void);
value glstub_glVertexAttrib4Nusv(value v0, value v1)
{
	CAMLparam2(v0, v1);
	GLuint lv0 = Int_val(v0);
	GLushort* lv1 = Data_bigarray_val(v1);
	LOAD_FUNCTION(glVertexAttrib4Nusv);
	(*stub_glVertexAttrib4Nusv)(lv0, lv1);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glVertexAttrib4NusvARB,(GLuint, GLushort*),void);
value glstub_glVertexAttrib4NusvARB(value v0, value v1)
{
	CAMLparam2(v0, v1);
	GLuint lv0 = Int_val(v0);
	GLushort* lv1 = Data_bigarray_val(v1);
	LOAD_FUNCTION(glVertexAttrib4NusvARB);
	(*stub_glVertexAttrib4NusvARB)(lv0, lv1);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glVertexAttrib4bv,(GLuint, GLbyte*),void);
value glstub_glVertexAttrib4bv(value v0, value v1)
{
	CAMLparam2(v0, v1);
	GLuint lv0 = Int_val(v0);
	GLbyte* lv1 = Data_bigarray_val(v1);
	LOAD_FUNCTION(glVertexAttrib4bv);
	(*stub_glVertexAttrib4bv)(lv0, lv1);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glVertexAttrib4bvARB,(GLuint, GLbyte*),void);
value glstub_glVertexAttrib4bvARB(value v0, value v1)
{
	CAMLparam2(v0, v1);
	GLuint lv0 = Int_val(v0);
	GLbyte* lv1 = Data_bigarray_val(v1);
	LOAD_FUNCTION(glVertexAttrib4bvARB);
	(*stub_glVertexAttrib4bvARB)(lv0, lv1);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glVertexAttrib4d,(GLuint, GLdouble, GLdouble, GLdouble, GLdouble),void);
value glstub_glVertexAttrib4d(value v0, value v1, value v2, value v3, value v4)
{
	CAMLparam5(v0, v1, v2, v3, v4);
	GLuint lv0 = Int_val(v0);
	GLdouble lv1 = Double_val(v1);
	GLdouble lv2 = Double_val(v2);
	GLdouble lv3 = Double_val(v3);
	GLdouble lv4 = Double_val(v4);
	LOAD_FUNCTION(glVertexAttrib4d);
	(*stub_glVertexAttrib4d)(lv0, lv1, lv2, lv3, lv4);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glVertexAttrib4dARB,(GLuint, GLdouble, GLdouble, GLdouble, GLdouble),void);
value glstub_glVertexAttrib4dARB(value v0, value v1, value v2, value v3, value v4)
{
	CAMLparam5(v0, v1, v2, v3, v4);
	GLuint lv0 = Int_val(v0);
	GLdouble lv1 = Double_val(v1);
	GLdouble lv2 = Double_val(v2);
	GLdouble lv3 = Double_val(v3);
	GLdouble lv4 = Double_val(v4);
	LOAD_FUNCTION(glVertexAttrib4dARB);
	(*stub_glVertexAttrib4dARB)(lv0, lv1, lv2, lv3, lv4);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glVertexAttrib4dNV,(GLuint, GLdouble, GLdouble, GLdouble, GLdouble),void);
value glstub_glVertexAttrib4dNV(value v0, value v1, value v2, value v3, value v4)
{
	CAMLparam5(v0, v1, v2, v3, v4);
	GLuint lv0 = Int_val(v0);
	GLdouble lv1 = Double_val(v1);
	GLdouble lv2 = Double_val(v2);
	GLdouble lv3 = Double_val(v3);
	GLdouble lv4 = Double_val(v4);
	LOAD_FUNCTION(glVertexAttrib4dNV);
	(*stub_glVertexAttrib4dNV)(lv0, lv1, lv2, lv3, lv4);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glVertexAttrib4dv,(GLuint, GLdouble*),void);
value glstub_glVertexAttrib4dv(value v0, value v1)
{
	CAMLparam2(v0, v1);
	GLuint lv0 = Int_val(v0);
	GLdouble* lv1 = (Tag_val(v1) == Double_array_tag)? (double *)v1: Data_bigarray_val(v1);
	LOAD_FUNCTION(glVertexAttrib4dv);
	(*stub_glVertexAttrib4dv)(lv0, lv1);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glVertexAttrib4dvARB,(GLuint, GLdouble*),void);
value glstub_glVertexAttrib4dvARB(value v0, value v1)
{
	CAMLparam2(v0, v1);
	GLuint lv0 = Int_val(v0);
	GLdouble* lv1 = (Tag_val(v1) == Double_array_tag)? (double *)v1: Data_bigarray_val(v1);
	LOAD_FUNCTION(glVertexAttrib4dvARB);
	(*stub_glVertexAttrib4dvARB)(lv0, lv1);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glVertexAttrib4dvNV,(GLuint, GLdouble*),void);
value glstub_glVertexAttrib4dvNV(value v0, value v1)
{
	CAMLparam2(v0, v1);
	GLuint lv0 = Int_val(v0);
	GLdouble* lv1 = (Tag_val(v1) == Double_array_tag)? (double *)v1: Data_bigarray_val(v1);
	LOAD_FUNCTION(glVertexAttrib4dvNV);
	(*stub_glVertexAttrib4dvNV)(lv0, lv1);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glVertexAttrib4f,(GLuint, GLfloat, GLfloat, GLfloat, GLfloat),void);
value glstub_glVertexAttrib4f(value v0, value v1, value v2, value v3, value v4)
{
	CAMLparam5(v0, v1, v2, v3, v4);
	GLuint lv0 = Int_val(v0);
	GLfloat lv1 = Double_val(v1);
	GLfloat lv2 = Double_val(v2);
	GLfloat lv3 = Double_val(v3);
	GLfloat lv4 = Double_val(v4);
	LOAD_FUNCTION(glVertexAttrib4f);
	(*stub_glVertexAttrib4f)(lv0, lv1, lv2, lv3, lv4);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glVertexAttrib4fARB,(GLuint, GLfloat, GLfloat, GLfloat, GLfloat),void);
value glstub_glVertexAttrib4fARB(value v0, value v1, value v2, value v3, value v4)
{
	CAMLparam5(v0, v1, v2, v3, v4);
	GLuint lv0 = Int_val(v0);
	GLfloat lv1 = Double_val(v1);
	GLfloat lv2 = Double_val(v2);
	GLfloat lv3 = Double_val(v3);
	GLfloat lv4 = Double_val(v4);
	LOAD_FUNCTION(glVertexAttrib4fARB);
	(*stub_glVertexAttrib4fARB)(lv0, lv1, lv2, lv3, lv4);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glVertexAttrib4fNV,(GLuint, GLfloat, GLfloat, GLfloat, GLfloat),void);
value glstub_glVertexAttrib4fNV(value v0, value v1, value v2, value v3, value v4)
{
	CAMLparam5(v0, v1, v2, v3, v4);
	GLuint lv0 = Int_val(v0);
	GLfloat lv1 = Double_val(v1);
	GLfloat lv2 = Double_val(v2);
	GLfloat lv3 = Double_val(v3);
	GLfloat lv4 = Double_val(v4);
	LOAD_FUNCTION(glVertexAttrib4fNV);
	(*stub_glVertexAttrib4fNV)(lv0, lv1, lv2, lv3, lv4);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glVertexAttrib4fv,(GLuint, GLfloat*),void);
value glstub_glVertexAttrib4fv(value v0, value v1)
{
	CAMLparam2(v0, v1);
	GLuint lv0 = Int_val(v0);
	GLfloat* lv1 = Data_bigarray_val(v1);
	LOAD_FUNCTION(glVertexAttrib4fv);
	(*stub_glVertexAttrib4fv)(lv0, lv1);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glVertexAttrib4fvARB,(GLuint, GLfloat*),void);
value glstub_glVertexAttrib4fvARB(value v0, value v1)
{
	CAMLparam2(v0, v1);
	GLuint lv0 = Int_val(v0);
	GLfloat* lv1 = Data_bigarray_val(v1);
	LOAD_FUNCTION(glVertexAttrib4fvARB);
	(*stub_glVertexAttrib4fvARB)(lv0, lv1);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glVertexAttrib4fvNV,(GLuint, GLfloat*),void);
value glstub_glVertexAttrib4fvNV(value v0, value v1)
{
	CAMLparam2(v0, v1);
	GLuint lv0 = Int_val(v0);
	GLfloat* lv1 = Data_bigarray_val(v1);
	LOAD_FUNCTION(glVertexAttrib4fvNV);
	(*stub_glVertexAttrib4fvNV)(lv0, lv1);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glVertexAttrib4hNV,(GLuint, GLushort, GLushort, GLushort, GLushort),void);
value glstub_glVertexAttrib4hNV(value v0, value v1, value v2, value v3, value v4)
{
	CAMLparam5(v0, v1, v2, v3, v4);
	GLuint lv0 = Int_val(v0);
	GLushort lv1 = Int_val(v1);
	GLushort lv2 = Int_val(v2);
	GLushort lv3 = Int_val(v3);
	GLushort lv4 = Int_val(v4);
	LOAD_FUNCTION(glVertexAttrib4hNV);
	(*stub_glVertexAttrib4hNV)(lv0, lv1, lv2, lv3, lv4);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glVertexAttrib4hvNV,(GLuint, GLushort*),void);
value glstub_glVertexAttrib4hvNV(value v0, value v1)
{
	CAMLparam2(v0, v1);
	GLuint lv0 = Int_val(v0);
	GLushort* lv1 = Data_bigarray_val(v1);
	LOAD_FUNCTION(glVertexAttrib4hvNV);
	(*stub_glVertexAttrib4hvNV)(lv0, lv1);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glVertexAttrib4iv,(GLuint, GLint*),void);
value glstub_glVertexAttrib4iv(value v0, value v1)
{
	CAMLparam2(v0, v1);
	GLuint lv0 = Int_val(v0);
	GLint* lv1 = Data_bigarray_val(v1);
	LOAD_FUNCTION(glVertexAttrib4iv);
	(*stub_glVertexAttrib4iv)(lv0, lv1);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glVertexAttrib4ivARB,(GLuint, GLint*),void);
value glstub_glVertexAttrib4ivARB(value v0, value v1)
{
	CAMLparam2(v0, v1);
	GLuint lv0 = Int_val(v0);
	GLint* lv1 = Data_bigarray_val(v1);
	LOAD_FUNCTION(glVertexAttrib4ivARB);
	(*stub_glVertexAttrib4ivARB)(lv0, lv1);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glVertexAttrib4s,(GLuint, GLshort, GLshort, GLshort, GLshort),void);
value glstub_glVertexAttrib4s(value v0, value v1, value v2, value v3, value v4)
{
	CAMLparam5(v0, v1, v2, v3, v4);
	GLuint lv0 = Int_val(v0);
	GLshort lv1 = Int_val(v1);
	GLshort lv2 = Int_val(v2);
	GLshort lv3 = Int_val(v3);
	GLshort lv4 = Int_val(v4);
	LOAD_FUNCTION(glVertexAttrib4s);
	(*stub_glVertexAttrib4s)(lv0, lv1, lv2, lv3, lv4);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glVertexAttrib4sARB,(GLuint, GLshort, GLshort, GLshort, GLshort),void);
value glstub_glVertexAttrib4sARB(value v0, value v1, value v2, value v3, value v4)
{
	CAMLparam5(v0, v1, v2, v3, v4);
	GLuint lv0 = Int_val(v0);
	GLshort lv1 = Int_val(v1);
	GLshort lv2 = Int_val(v2);
	GLshort lv3 = Int_val(v3);
	GLshort lv4 = Int_val(v4);
	LOAD_FUNCTION(glVertexAttrib4sARB);
	(*stub_glVertexAttrib4sARB)(lv0, lv1, lv2, lv3, lv4);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glVertexAttrib4sNV,(GLuint, GLshort, GLshort, GLshort, GLshort),void);
value glstub_glVertexAttrib4sNV(value v0, value v1, value v2, value v3, value v4)
{
	CAMLparam5(v0, v1, v2, v3, v4);
	GLuint lv0 = Int_val(v0);
	GLshort lv1 = Int_val(v1);
	GLshort lv2 = Int_val(v2);
	GLshort lv3 = Int_val(v3);
	GLshort lv4 = Int_val(v4);
	LOAD_FUNCTION(glVertexAttrib4sNV);
	(*stub_glVertexAttrib4sNV)(lv0, lv1, lv2, lv3, lv4);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glVertexAttrib4sv,(GLuint, GLshort*),void);
value glstub_glVertexAttrib4sv(value v0, value v1)
{
	CAMLparam2(v0, v1);
	GLuint lv0 = Int_val(v0);
	GLshort* lv1 = Data_bigarray_val(v1);
	LOAD_FUNCTION(glVertexAttrib4sv);
	(*stub_glVertexAttrib4sv)(lv0, lv1);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glVertexAttrib4svARB,(GLuint, GLshort*),void);
value glstub_glVertexAttrib4svARB(value v0, value v1)
{
	CAMLparam2(v0, v1);
	GLuint lv0 = Int_val(v0);
	GLshort* lv1 = Data_bigarray_val(v1);
	LOAD_FUNCTION(glVertexAttrib4svARB);
	(*stub_glVertexAttrib4svARB)(lv0, lv1);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glVertexAttrib4svNV,(GLuint, GLshort*),void);
value glstub_glVertexAttrib4svNV(value v0, value v1)
{
	CAMLparam2(v0, v1);
	GLuint lv0 = Int_val(v0);
	GLshort* lv1 = Data_bigarray_val(v1);
	LOAD_FUNCTION(glVertexAttrib4svNV);
	(*stub_glVertexAttrib4svNV)(lv0, lv1);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glVertexAttrib4ubNV,(GLuint, GLubyte, GLubyte, GLubyte, GLubyte),void);
value glstub_glVertexAttrib4ubNV(value v0, value v1, value v2, value v3, value v4)
{
	CAMLparam5(v0, v1, v2, v3, v4);
	GLuint lv0 = Int_val(v0);
	GLubyte lv1 = Int_val(v1);
	GLubyte lv2 = Int_val(v2);
	GLubyte lv3 = Int_val(v3);
	GLubyte lv4 = Int_val(v4);
	LOAD_FUNCTION(glVertexAttrib4ubNV);
	(*stub_glVertexAttrib4ubNV)(lv0, lv1, lv2, lv3, lv4);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glVertexAttrib4ubv,(GLuint, GLubyte*),void);
value glstub_glVertexAttrib4ubv(value v0, value v1)
{
	CAMLparam2(v0, v1);
	GLuint lv0 = Int_val(v0);
	GLubyte* lv1 = Data_bigarray_val(v1);
	LOAD_FUNCTION(glVertexAttrib4ubv);
	(*stub_glVertexAttrib4ubv)(lv0, lv1);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glVertexAttrib4ubvARB,(GLuint, GLubyte*),void);
value glstub_glVertexAttrib4ubvARB(value v0, value v1)
{
	CAMLparam2(v0, v1);
	GLuint lv0 = Int_val(v0);
	GLubyte* lv1 = Data_bigarray_val(v1);
	LOAD_FUNCTION(glVertexAttrib4ubvARB);
	(*stub_glVertexAttrib4ubvARB)(lv0, lv1);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glVertexAttrib4ubvNV,(GLuint, GLubyte*),void);
value glstub_glVertexAttrib4ubvNV(value v0, value v1)
{
	CAMLparam2(v0, v1);
	GLuint lv0 = Int_val(v0);
	GLubyte* lv1 = Data_bigarray_val(v1);
	LOAD_FUNCTION(glVertexAttrib4ubvNV);
	(*stub_glVertexAttrib4ubvNV)(lv0, lv1);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glVertexAttrib4uiv,(GLuint, GLuint*),void);
value glstub_glVertexAttrib4uiv(value v0, value v1)
{
	CAMLparam2(v0, v1);
	GLuint lv0 = Int_val(v0);
	GLuint* lv1 = Data_bigarray_val(v1);
	LOAD_FUNCTION(glVertexAttrib4uiv);
	(*stub_glVertexAttrib4uiv)(lv0, lv1);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glVertexAttrib4uivARB,(GLuint, GLuint*),void);
value glstub_glVertexAttrib4uivARB(value v0, value v1)
{
	CAMLparam2(v0, v1);
	GLuint lv0 = Int_val(v0);
	GLuint* lv1 = Data_bigarray_val(v1);
	LOAD_FUNCTION(glVertexAttrib4uivARB);
	(*stub_glVertexAttrib4uivARB)(lv0, lv1);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glVertexAttrib4usv,(GLuint, GLushort*),void);
value glstub_glVertexAttrib4usv(value v0, value v1)
{
	CAMLparam2(v0, v1);
	GLuint lv0 = Int_val(v0);
	GLushort* lv1 = Data_bigarray_val(v1);
	LOAD_FUNCTION(glVertexAttrib4usv);
	(*stub_glVertexAttrib4usv)(lv0, lv1);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glVertexAttrib4usvARB,(GLuint, GLushort*),void);
value glstub_glVertexAttrib4usvARB(value v0, value v1)
{
	CAMLparam2(v0, v1);
	GLuint lv0 = Int_val(v0);
	GLushort* lv1 = Data_bigarray_val(v1);
	LOAD_FUNCTION(glVertexAttrib4usvARB);
	(*stub_glVertexAttrib4usvARB)(lv0, lv1);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glVertexAttribArrayObjectATI,(GLuint, GLint, GLenum, GLboolean, GLsizei, GLuint, GLuint),void);
value glstub_glVertexAttribArrayObjectATI(value v0, value v1, value v2, value v3, value v4, value v5, value v6)
{
	CAMLparam5(v0, v1, v2, v3, v4);
	CAMLxparam2(v5, v6);
	GLuint lv0 = Int_val(v0);
	GLint lv1 = Int_val(v1);
	GLenum lv2 = Int_val(v2);
	GLboolean lv3 = Bool_val(v3);
	GLsizei lv4 = Int_val(v4);
	GLuint lv5 = Int_val(v5);
	GLuint lv6 = Int_val(v6);
	LOAD_FUNCTION(glVertexAttribArrayObjectATI);
	(*stub_glVertexAttribArrayObjectATI)(lv0, lv1, lv2, lv3, lv4, lv5, lv6);
	CAMLreturn(Val_unit);
}

value glstub_glVertexAttribArrayObjectATI_byte(value * argv, int n)
{
	return glstub_glVertexAttribArrayObjectATI(argv[0], argv[1], argv[2], argv[3], argv[4], argv[5], argv[6]);
}

DECLARE_FUNCTION(glVertexAttribI1iEXT,(GLuint, GLint),void);
value glstub_glVertexAttribI1iEXT(value v0, value v1)
{
	CAMLparam2(v0, v1);
	GLuint lv0 = Int_val(v0);
	GLint lv1 = Int_val(v1);
	LOAD_FUNCTION(glVertexAttribI1iEXT);
	(*stub_glVertexAttribI1iEXT)(lv0, lv1);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glVertexAttribI1ivEXT,(GLuint, GLint*),void);
value glstub_glVertexAttribI1ivEXT(value v0, value v1)
{
	CAMLparam2(v0, v1);
	GLuint lv0 = Int_val(v0);
	GLint* lv1 = Data_bigarray_val(v1);
	LOAD_FUNCTION(glVertexAttribI1ivEXT);
	(*stub_glVertexAttribI1ivEXT)(lv0, lv1);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glVertexAttribI1uiEXT,(GLuint, GLuint),void);
value glstub_glVertexAttribI1uiEXT(value v0, value v1)
{
	CAMLparam2(v0, v1);
	GLuint lv0 = Int_val(v0);
	GLuint lv1 = Int_val(v1);
	LOAD_FUNCTION(glVertexAttribI1uiEXT);
	(*stub_glVertexAttribI1uiEXT)(lv0, lv1);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glVertexAttribI1uivEXT,(GLuint, GLuint*),void);
value glstub_glVertexAttribI1uivEXT(value v0, value v1)
{
	CAMLparam2(v0, v1);
	GLuint lv0 = Int_val(v0);
	GLuint* lv1 = Data_bigarray_val(v1);
	LOAD_FUNCTION(glVertexAttribI1uivEXT);
	(*stub_glVertexAttribI1uivEXT)(lv0, lv1);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glVertexAttribI2iEXT,(GLuint, GLint, GLint),void);
value glstub_glVertexAttribI2iEXT(value v0, value v1, value v2)
{
	CAMLparam3(v0, v1, v2);
	GLuint lv0 = Int_val(v0);
	GLint lv1 = Int_val(v1);
	GLint lv2 = Int_val(v2);
	LOAD_FUNCTION(glVertexAttribI2iEXT);
	(*stub_glVertexAttribI2iEXT)(lv0, lv1, lv2);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glVertexAttribI2ivEXT,(GLuint, GLint*),void);
value glstub_glVertexAttribI2ivEXT(value v0, value v1)
{
	CAMLparam2(v0, v1);
	GLuint lv0 = Int_val(v0);
	GLint* lv1 = Data_bigarray_val(v1);
	LOAD_FUNCTION(glVertexAttribI2ivEXT);
	(*stub_glVertexAttribI2ivEXT)(lv0, lv1);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glVertexAttribI2uiEXT,(GLuint, GLuint, GLuint),void);
value glstub_glVertexAttribI2uiEXT(value v0, value v1, value v2)
{
	CAMLparam3(v0, v1, v2);
	GLuint lv0 = Int_val(v0);
	GLuint lv1 = Int_val(v1);
	GLuint lv2 = Int_val(v2);
	LOAD_FUNCTION(glVertexAttribI2uiEXT);
	(*stub_glVertexAttribI2uiEXT)(lv0, lv1, lv2);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glVertexAttribI2uivEXT,(GLuint, GLuint*),void);
value glstub_glVertexAttribI2uivEXT(value v0, value v1)
{
	CAMLparam2(v0, v1);
	GLuint lv0 = Int_val(v0);
	GLuint* lv1 = Data_bigarray_val(v1);
	LOAD_FUNCTION(glVertexAttribI2uivEXT);
	(*stub_glVertexAttribI2uivEXT)(lv0, lv1);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glVertexAttribI3iEXT,(GLuint, GLint, GLint, GLint),void);
value glstub_glVertexAttribI3iEXT(value v0, value v1, value v2, value v3)
{
	CAMLparam4(v0, v1, v2, v3);
	GLuint lv0 = Int_val(v0);
	GLint lv1 = Int_val(v1);
	GLint lv2 = Int_val(v2);
	GLint lv3 = Int_val(v3);
	LOAD_FUNCTION(glVertexAttribI3iEXT);
	(*stub_glVertexAttribI3iEXT)(lv0, lv1, lv2, lv3);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glVertexAttribI3ivEXT,(GLuint, GLint*),void);
value glstub_glVertexAttribI3ivEXT(value v0, value v1)
{
	CAMLparam2(v0, v1);
	GLuint lv0 = Int_val(v0);
	GLint* lv1 = Data_bigarray_val(v1);
	LOAD_FUNCTION(glVertexAttribI3ivEXT);
	(*stub_glVertexAttribI3ivEXT)(lv0, lv1);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glVertexAttribI3uiEXT,(GLuint, GLuint, GLuint, GLuint),void);
value glstub_glVertexAttribI3uiEXT(value v0, value v1, value v2, value v3)
{
	CAMLparam4(v0, v1, v2, v3);
	GLuint lv0 = Int_val(v0);
	GLuint lv1 = Int_val(v1);
	GLuint lv2 = Int_val(v2);
	GLuint lv3 = Int_val(v3);
	LOAD_FUNCTION(glVertexAttribI3uiEXT);
	(*stub_glVertexAttribI3uiEXT)(lv0, lv1, lv2, lv3);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glVertexAttribI3uivEXT,(GLuint, GLuint*),void);
value glstub_glVertexAttribI3uivEXT(value v0, value v1)
{
	CAMLparam2(v0, v1);
	GLuint lv0 = Int_val(v0);
	GLuint* lv1 = Data_bigarray_val(v1);
	LOAD_FUNCTION(glVertexAttribI3uivEXT);
	(*stub_glVertexAttribI3uivEXT)(lv0, lv1);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glVertexAttribI4bvEXT,(GLuint, GLbyte*),void);
value glstub_glVertexAttribI4bvEXT(value v0, value v1)
{
	CAMLparam2(v0, v1);
	GLuint lv0 = Int_val(v0);
	GLbyte* lv1 = Data_bigarray_val(v1);
	LOAD_FUNCTION(glVertexAttribI4bvEXT);
	(*stub_glVertexAttribI4bvEXT)(lv0, lv1);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glVertexAttribI4iEXT,(GLuint, GLint, GLint, GLint, GLint),void);
value glstub_glVertexAttribI4iEXT(value v0, value v1, value v2, value v3, value v4)
{
	CAMLparam5(v0, v1, v2, v3, v4);
	GLuint lv0 = Int_val(v0);
	GLint lv1 = Int_val(v1);
	GLint lv2 = Int_val(v2);
	GLint lv3 = Int_val(v3);
	GLint lv4 = Int_val(v4);
	LOAD_FUNCTION(glVertexAttribI4iEXT);
	(*stub_glVertexAttribI4iEXT)(lv0, lv1, lv2, lv3, lv4);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glVertexAttribI4ivEXT,(GLuint, GLint*),void);
value glstub_glVertexAttribI4ivEXT(value v0, value v1)
{
	CAMLparam2(v0, v1);
	GLuint lv0 = Int_val(v0);
	GLint* lv1 = Data_bigarray_val(v1);
	LOAD_FUNCTION(glVertexAttribI4ivEXT);
	(*stub_glVertexAttribI4ivEXT)(lv0, lv1);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glVertexAttribI4svEXT,(GLuint, GLshort*),void);
value glstub_glVertexAttribI4svEXT(value v0, value v1)
{
	CAMLparam2(v0, v1);
	GLuint lv0 = Int_val(v0);
	GLshort* lv1 = Data_bigarray_val(v1);
	LOAD_FUNCTION(glVertexAttribI4svEXT);
	(*stub_glVertexAttribI4svEXT)(lv0, lv1);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glVertexAttribI4ubvEXT,(GLuint, GLubyte*),void);
value glstub_glVertexAttribI4ubvEXT(value v0, value v1)
{
	CAMLparam2(v0, v1);
	GLuint lv0 = Int_val(v0);
	GLubyte* lv1 = Data_bigarray_val(v1);
	LOAD_FUNCTION(glVertexAttribI4ubvEXT);
	(*stub_glVertexAttribI4ubvEXT)(lv0, lv1);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glVertexAttribI4uiEXT,(GLuint, GLuint, GLuint, GLuint, GLuint),void);
value glstub_glVertexAttribI4uiEXT(value v0, value v1, value v2, value v3, value v4)
{
	CAMLparam5(v0, v1, v2, v3, v4);
	GLuint lv0 = Int_val(v0);
	GLuint lv1 = Int_val(v1);
	GLuint lv2 = Int_val(v2);
	GLuint lv3 = Int_val(v3);
	GLuint lv4 = Int_val(v4);
	LOAD_FUNCTION(glVertexAttribI4uiEXT);
	(*stub_glVertexAttribI4uiEXT)(lv0, lv1, lv2, lv3, lv4);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glVertexAttribI4uivEXT,(GLuint, GLuint*),void);
value glstub_glVertexAttribI4uivEXT(value v0, value v1)
{
	CAMLparam2(v0, v1);
	GLuint lv0 = Int_val(v0);
	GLuint* lv1 = Data_bigarray_val(v1);
	LOAD_FUNCTION(glVertexAttribI4uivEXT);
	(*stub_glVertexAttribI4uivEXT)(lv0, lv1);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glVertexAttribI4usvEXT,(GLuint, GLushort*),void);
value glstub_glVertexAttribI4usvEXT(value v0, value v1)
{
	CAMLparam2(v0, v1);
	GLuint lv0 = Int_val(v0);
	GLushort* lv1 = Data_bigarray_val(v1);
	LOAD_FUNCTION(glVertexAttribI4usvEXT);
	(*stub_glVertexAttribI4usvEXT)(lv0, lv1);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glVertexAttribIPointerEXT,(GLuint, GLint, GLenum, GLsizei, GLvoid*),void);
value glstub_glVertexAttribIPointerEXT(value v0, value v1, value v2, value v3, value v4)
{
	CAMLparam5(v0, v1, v2, v3, v4);
	GLuint lv0 = Int_val(v0);
	GLint lv1 = Int_val(v1);
	GLenum lv2 = Int_val(v2);
	GLsizei lv3 = Int_val(v3);
	GLvoid* lv4 = (GLvoid *)((Tag_val(v4) == String_tag)? (String_val(v4)) : (Data_bigarray_val(v4)));
	LOAD_FUNCTION(glVertexAttribIPointerEXT);
	(*stub_glVertexAttribIPointerEXT)(lv0, lv1, lv2, lv3, lv4);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glVertexAttribPointer,(GLuint, GLint, GLenum, GLboolean, GLsizei, GLvoid*),void);
value glstub_glVertexAttribPointer(value v0, value v1, value v2, value v3, value v4, value v5)
{
	CAMLparam5(v0, v1, v2, v3, v4);
	CAMLxparam1(v5);
	GLuint lv0 = Int_val(v0);
	GLint lv1 = Int_val(v1);
	GLenum lv2 = Int_val(v2);
	GLboolean lv3 = Bool_val(v3);
	GLsizei lv4 = Int_val(v4);
	GLvoid* lv5 = (GLvoid *)((Tag_val(v5) == String_tag)? (String_val(v5)) : (Data_bigarray_val(v5)));
	LOAD_FUNCTION(glVertexAttribPointer);
	(*stub_glVertexAttribPointer)(lv0, lv1, lv2, lv3, lv4, lv5);
	CAMLreturn(Val_unit);
}

value glstub_glVertexAttribPointer_byte(value * argv, int n)
{
	return glstub_glVertexAttribPointer(argv[0], argv[1], argv[2], argv[3], argv[4], argv[5]);
}

DECLARE_FUNCTION(glVertexAttribPointerARB,(GLuint, GLint, GLenum, GLboolean, GLsizei, GLvoid*),void);
value glstub_glVertexAttribPointerARB(value v0, value v1, value v2, value v3, value v4, value v5)
{
	CAMLparam5(v0, v1, v2, v3, v4);
	CAMLxparam1(v5);
	GLuint lv0 = Int_val(v0);
	GLint lv1 = Int_val(v1);
	GLenum lv2 = Int_val(v2);
	GLboolean lv3 = Bool_val(v3);
	GLsizei lv4 = Int_val(v4);
	GLvoid* lv5 = (GLvoid *)((Tag_val(v5) == String_tag)? (String_val(v5)) : (Data_bigarray_val(v5)));
	LOAD_FUNCTION(glVertexAttribPointerARB);
	(*stub_glVertexAttribPointerARB)(lv0, lv1, lv2, lv3, lv4, lv5);
	CAMLreturn(Val_unit);
}

value glstub_glVertexAttribPointerARB_byte(value * argv, int n)
{
	return glstub_glVertexAttribPointerARB(argv[0], argv[1], argv[2], argv[3], argv[4], argv[5]);
}

DECLARE_FUNCTION(glVertexAttribPointerNV,(GLuint, GLint, GLenum, GLsizei, GLvoid*),void);
value glstub_glVertexAttribPointerNV(value v0, value v1, value v2, value v3, value v4)
{
	CAMLparam5(v0, v1, v2, v3, v4);
	GLuint lv0 = Int_val(v0);
	GLint lv1 = Int_val(v1);
	GLenum lv2 = Int_val(v2);
	GLsizei lv3 = Int_val(v3);
	GLvoid* lv4 = (GLvoid *)((Tag_val(v4) == String_tag)? (String_val(v4)) : (Data_bigarray_val(v4)));
	LOAD_FUNCTION(glVertexAttribPointerNV);
	(*stub_glVertexAttribPointerNV)(lv0, lv1, lv2, lv3, lv4);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glVertexAttribs1dvNV,(GLuint, GLsizei, GLdouble*),void);
value glstub_glVertexAttribs1dvNV(value v0, value v1, value v2)
{
	CAMLparam3(v0, v1, v2);
	GLuint lv0 = Int_val(v0);
	GLsizei lv1 = Int_val(v1);
	GLdouble* lv2 = (Tag_val(v2) == Double_array_tag)? (double *)v2: Data_bigarray_val(v2);
	LOAD_FUNCTION(glVertexAttribs1dvNV);
	(*stub_glVertexAttribs1dvNV)(lv0, lv1, lv2);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glVertexAttribs1fvNV,(GLuint, GLsizei, GLfloat*),void);
value glstub_glVertexAttribs1fvNV(value v0, value v1, value v2)
{
	CAMLparam3(v0, v1, v2);
	GLuint lv0 = Int_val(v0);
	GLsizei lv1 = Int_val(v1);
	GLfloat* lv2 = Data_bigarray_val(v2);
	LOAD_FUNCTION(glVertexAttribs1fvNV);
	(*stub_glVertexAttribs1fvNV)(lv0, lv1, lv2);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glVertexAttribs1hvNV,(GLuint, GLsizei, GLushort*),void);
value glstub_glVertexAttribs1hvNV(value v0, value v1, value v2)
{
	CAMLparam3(v0, v1, v2);
	GLuint lv0 = Int_val(v0);
	GLsizei lv1 = Int_val(v1);
	GLushort* lv2 = Data_bigarray_val(v2);
	LOAD_FUNCTION(glVertexAttribs1hvNV);
	(*stub_glVertexAttribs1hvNV)(lv0, lv1, lv2);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glVertexAttribs1svNV,(GLuint, GLsizei, GLshort*),void);
value glstub_glVertexAttribs1svNV(value v0, value v1, value v2)
{
	CAMLparam3(v0, v1, v2);
	GLuint lv0 = Int_val(v0);
	GLsizei lv1 = Int_val(v1);
	GLshort* lv2 = Data_bigarray_val(v2);
	LOAD_FUNCTION(glVertexAttribs1svNV);
	(*stub_glVertexAttribs1svNV)(lv0, lv1, lv2);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glVertexAttribs2dvNV,(GLuint, GLsizei, GLdouble*),void);
value glstub_glVertexAttribs2dvNV(value v0, value v1, value v2)
{
	CAMLparam3(v0, v1, v2);
	GLuint lv0 = Int_val(v0);
	GLsizei lv1 = Int_val(v1);
	GLdouble* lv2 = (Tag_val(v2) == Double_array_tag)? (double *)v2: Data_bigarray_val(v2);
	LOAD_FUNCTION(glVertexAttribs2dvNV);
	(*stub_glVertexAttribs2dvNV)(lv0, lv1, lv2);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glVertexAttribs2fvNV,(GLuint, GLsizei, GLfloat*),void);
value glstub_glVertexAttribs2fvNV(value v0, value v1, value v2)
{
	CAMLparam3(v0, v1, v2);
	GLuint lv0 = Int_val(v0);
	GLsizei lv1 = Int_val(v1);
	GLfloat* lv2 = Data_bigarray_val(v2);
	LOAD_FUNCTION(glVertexAttribs2fvNV);
	(*stub_glVertexAttribs2fvNV)(lv0, lv1, lv2);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glVertexAttribs2hvNV,(GLuint, GLsizei, GLushort*),void);
value glstub_glVertexAttribs2hvNV(value v0, value v1, value v2)
{
	CAMLparam3(v0, v1, v2);
	GLuint lv0 = Int_val(v0);
	GLsizei lv1 = Int_val(v1);
	GLushort* lv2 = Data_bigarray_val(v2);
	LOAD_FUNCTION(glVertexAttribs2hvNV);
	(*stub_glVertexAttribs2hvNV)(lv0, lv1, lv2);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glVertexAttribs2svNV,(GLuint, GLsizei, GLshort*),void);
value glstub_glVertexAttribs2svNV(value v0, value v1, value v2)
{
	CAMLparam3(v0, v1, v2);
	GLuint lv0 = Int_val(v0);
	GLsizei lv1 = Int_val(v1);
	GLshort* lv2 = Data_bigarray_val(v2);
	LOAD_FUNCTION(glVertexAttribs2svNV);
	(*stub_glVertexAttribs2svNV)(lv0, lv1, lv2);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glVertexAttribs3dvNV,(GLuint, GLsizei, GLdouble*),void);
value glstub_glVertexAttribs3dvNV(value v0, value v1, value v2)
{
	CAMLparam3(v0, v1, v2);
	GLuint lv0 = Int_val(v0);
	GLsizei lv1 = Int_val(v1);
	GLdouble* lv2 = (Tag_val(v2) == Double_array_tag)? (double *)v2: Data_bigarray_val(v2);
	LOAD_FUNCTION(glVertexAttribs3dvNV);
	(*stub_glVertexAttribs3dvNV)(lv0, lv1, lv2);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glVertexAttribs3fvNV,(GLuint, GLsizei, GLfloat*),void);
value glstub_glVertexAttribs3fvNV(value v0, value v1, value v2)
{
	CAMLparam3(v0, v1, v2);
	GLuint lv0 = Int_val(v0);
	GLsizei lv1 = Int_val(v1);
	GLfloat* lv2 = Data_bigarray_val(v2);
	LOAD_FUNCTION(glVertexAttribs3fvNV);
	(*stub_glVertexAttribs3fvNV)(lv0, lv1, lv2);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glVertexAttribs3hvNV,(GLuint, GLsizei, GLushort*),void);
value glstub_glVertexAttribs3hvNV(value v0, value v1, value v2)
{
	CAMLparam3(v0, v1, v2);
	GLuint lv0 = Int_val(v0);
	GLsizei lv1 = Int_val(v1);
	GLushort* lv2 = Data_bigarray_val(v2);
	LOAD_FUNCTION(glVertexAttribs3hvNV);
	(*stub_glVertexAttribs3hvNV)(lv0, lv1, lv2);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glVertexAttribs3svNV,(GLuint, GLsizei, GLshort*),void);
value glstub_glVertexAttribs3svNV(value v0, value v1, value v2)
{
	CAMLparam3(v0, v1, v2);
	GLuint lv0 = Int_val(v0);
	GLsizei lv1 = Int_val(v1);
	GLshort* lv2 = Data_bigarray_val(v2);
	LOAD_FUNCTION(glVertexAttribs3svNV);
	(*stub_glVertexAttribs3svNV)(lv0, lv1, lv2);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glVertexAttribs4dvNV,(GLuint, GLsizei, GLdouble*),void);
value glstub_glVertexAttribs4dvNV(value v0, value v1, value v2)
{
	CAMLparam3(v0, v1, v2);
	GLuint lv0 = Int_val(v0);
	GLsizei lv1 = Int_val(v1);
	GLdouble* lv2 = (Tag_val(v2) == Double_array_tag)? (double *)v2: Data_bigarray_val(v2);
	LOAD_FUNCTION(glVertexAttribs4dvNV);
	(*stub_glVertexAttribs4dvNV)(lv0, lv1, lv2);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glVertexAttribs4fvNV,(GLuint, GLsizei, GLfloat*),void);
value glstub_glVertexAttribs4fvNV(value v0, value v1, value v2)
{
	CAMLparam3(v0, v1, v2);
	GLuint lv0 = Int_val(v0);
	GLsizei lv1 = Int_val(v1);
	GLfloat* lv2 = Data_bigarray_val(v2);
	LOAD_FUNCTION(glVertexAttribs4fvNV);
	(*stub_glVertexAttribs4fvNV)(lv0, lv1, lv2);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glVertexAttribs4hvNV,(GLuint, GLsizei, GLushort*),void);
value glstub_glVertexAttribs4hvNV(value v0, value v1, value v2)
{
	CAMLparam3(v0, v1, v2);
	GLuint lv0 = Int_val(v0);
	GLsizei lv1 = Int_val(v1);
	GLushort* lv2 = Data_bigarray_val(v2);
	LOAD_FUNCTION(glVertexAttribs4hvNV);
	(*stub_glVertexAttribs4hvNV)(lv0, lv1, lv2);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glVertexAttribs4svNV,(GLuint, GLsizei, GLshort*),void);
value glstub_glVertexAttribs4svNV(value v0, value v1, value v2)
{
	CAMLparam3(v0, v1, v2);
	GLuint lv0 = Int_val(v0);
	GLsizei lv1 = Int_val(v1);
	GLshort* lv2 = Data_bigarray_val(v2);
	LOAD_FUNCTION(glVertexAttribs4svNV);
	(*stub_glVertexAttribs4svNV)(lv0, lv1, lv2);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glVertexAttribs4ubvNV,(GLuint, GLsizei, GLubyte*),void);
value glstub_glVertexAttribs4ubvNV(value v0, value v1, value v2)
{
	CAMLparam3(v0, v1, v2);
	GLuint lv0 = Int_val(v0);
	GLsizei lv1 = Int_val(v1);
	GLubyte* lv2 = Data_bigarray_val(v2);
	LOAD_FUNCTION(glVertexAttribs4ubvNV);
	(*stub_glVertexAttribs4ubvNV)(lv0, lv1, lv2);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glVertexBlendARB,(GLint),void);
value glstub_glVertexBlendARB(value v0)
{
	CAMLparam1(v0);
	GLint lv0 = Int_val(v0);
	LOAD_FUNCTION(glVertexBlendARB);
	(*stub_glVertexBlendARB)(lv0);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glVertexBlendEnvfATI,(GLenum, GLfloat),void);
value glstub_glVertexBlendEnvfATI(value v0, value v1)
{
	CAMLparam2(v0, v1);
	GLenum lv0 = Int_val(v0);
	GLfloat lv1 = Double_val(v1);
	LOAD_FUNCTION(glVertexBlendEnvfATI);
	(*stub_glVertexBlendEnvfATI)(lv0, lv1);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glVertexBlendEnviATI,(GLenum, GLint),void);
value glstub_glVertexBlendEnviATI(value v0, value v1)
{
	CAMLparam2(v0, v1);
	GLenum lv0 = Int_val(v0);
	GLint lv1 = Int_val(v1);
	LOAD_FUNCTION(glVertexBlendEnviATI);
	(*stub_glVertexBlendEnviATI)(lv0, lv1);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glVertexPointer,(GLint, GLenum, GLsizei, GLvoid*),void);
value glstub_glVertexPointer(value v0, value v1, value v2, value v3)
{
	CAMLparam4(v0, v1, v2, v3);
	GLint lv0 = Int_val(v0);
	GLenum lv1 = Int_val(v1);
	GLsizei lv2 = Int_val(v2);
	GLvoid* lv3 = (GLvoid *)((Tag_val(v3) == String_tag)? (String_val(v3)) : (Data_bigarray_val(v3)));
	LOAD_FUNCTION(glVertexPointer);
	(*stub_glVertexPointer)(lv0, lv1, lv2, lv3);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glVertexPointerEXT,(GLint, GLenum, GLsizei, GLsizei, GLvoid*),void);
value glstub_glVertexPointerEXT(value v0, value v1, value v2, value v3, value v4)
{
	CAMLparam5(v0, v1, v2, v3, v4);
	GLint lv0 = Int_val(v0);
	GLenum lv1 = Int_val(v1);
	GLsizei lv2 = Int_val(v2);
	GLsizei lv3 = Int_val(v3);
	GLvoid* lv4 = (GLvoid *)((Tag_val(v4) == String_tag)? (String_val(v4)) : (Data_bigarray_val(v4)));
	LOAD_FUNCTION(glVertexPointerEXT);
	(*stub_glVertexPointerEXT)(lv0, lv1, lv2, lv3, lv4);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glVertexPointerListIBM,(GLint, GLenum, GLint, GLvoid**, GLint),void);
value glstub_glVertexPointerListIBM(value v0, value v1, value v2, value v3, value v4)
{
	CAMLparam5(v0, v1, v2, v3, v4);
	GLint lv0 = Int_val(v0);
	GLenum lv1 = Int_val(v1);
	GLint lv2 = Int_val(v2);
	GLvoid** lv3 = Data_bigarray_val(v3);
	GLint lv4 = Int_val(v4);
	LOAD_FUNCTION(glVertexPointerListIBM);
	(*stub_glVertexPointerListIBM)(lv0, lv1, lv2, lv3, lv4);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glVertexPointervINTEL,(GLint, GLenum, GLvoid**),void);
value glstub_glVertexPointervINTEL(value v0, value v1, value v2)
{
	CAMLparam3(v0, v1, v2);
	GLint lv0 = Int_val(v0);
	GLenum lv1 = Int_val(v1);
	GLvoid** lv2 = Data_bigarray_val(v2);
	LOAD_FUNCTION(glVertexPointervINTEL);
	(*stub_glVertexPointervINTEL)(lv0, lv1, lv2);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glVertexStream2dATI,(GLenum, GLdouble, GLdouble),void);
value glstub_glVertexStream2dATI(value v0, value v1, value v2)
{
	CAMLparam3(v0, v1, v2);
	GLenum lv0 = Int_val(v0);
	GLdouble lv1 = Double_val(v1);
	GLdouble lv2 = Double_val(v2);
	LOAD_FUNCTION(glVertexStream2dATI);
	(*stub_glVertexStream2dATI)(lv0, lv1, lv2);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glVertexStream2dvATI,(GLenum, GLdouble*),void);
value glstub_glVertexStream2dvATI(value v0, value v1)
{
	CAMLparam2(v0, v1);
	GLenum lv0 = Int_val(v0);
	GLdouble* lv1 = (Tag_val(v1) == Double_array_tag)? (double *)v1: Data_bigarray_val(v1);
	LOAD_FUNCTION(glVertexStream2dvATI);
	(*stub_glVertexStream2dvATI)(lv0, lv1);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glVertexStream2fATI,(GLenum, GLfloat, GLfloat),void);
value glstub_glVertexStream2fATI(value v0, value v1, value v2)
{
	CAMLparam3(v0, v1, v2);
	GLenum lv0 = Int_val(v0);
	GLfloat lv1 = Double_val(v1);
	GLfloat lv2 = Double_val(v2);
	LOAD_FUNCTION(glVertexStream2fATI);
	(*stub_glVertexStream2fATI)(lv0, lv1, lv2);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glVertexStream2fvATI,(GLenum, GLfloat*),void);
value glstub_glVertexStream2fvATI(value v0, value v1)
{
	CAMLparam2(v0, v1);
	GLenum lv0 = Int_val(v0);
	GLfloat* lv1 = Data_bigarray_val(v1);
	LOAD_FUNCTION(glVertexStream2fvATI);
	(*stub_glVertexStream2fvATI)(lv0, lv1);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glVertexStream2iATI,(GLenum, GLint, GLint),void);
value glstub_glVertexStream2iATI(value v0, value v1, value v2)
{
	CAMLparam3(v0, v1, v2);
	GLenum lv0 = Int_val(v0);
	GLint lv1 = Int_val(v1);
	GLint lv2 = Int_val(v2);
	LOAD_FUNCTION(glVertexStream2iATI);
	(*stub_glVertexStream2iATI)(lv0, lv1, lv2);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glVertexStream2ivATI,(GLenum, GLint*),void);
value glstub_glVertexStream2ivATI(value v0, value v1)
{
	CAMLparam2(v0, v1);
	GLenum lv0 = Int_val(v0);
	GLint* lv1 = Data_bigarray_val(v1);
	LOAD_FUNCTION(glVertexStream2ivATI);
	(*stub_glVertexStream2ivATI)(lv0, lv1);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glVertexStream2sATI,(GLenum, GLshort, GLshort),void);
value glstub_glVertexStream2sATI(value v0, value v1, value v2)
{
	CAMLparam3(v0, v1, v2);
	GLenum lv0 = Int_val(v0);
	GLshort lv1 = Int_val(v1);
	GLshort lv2 = Int_val(v2);
	LOAD_FUNCTION(glVertexStream2sATI);
	(*stub_glVertexStream2sATI)(lv0, lv1, lv2);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glVertexStream2svATI,(GLenum, GLshort*),void);
value glstub_glVertexStream2svATI(value v0, value v1)
{
	CAMLparam2(v0, v1);
	GLenum lv0 = Int_val(v0);
	GLshort* lv1 = Data_bigarray_val(v1);
	LOAD_FUNCTION(glVertexStream2svATI);
	(*stub_glVertexStream2svATI)(lv0, lv1);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glVertexStream3dATI,(GLenum, GLdouble, GLdouble, GLdouble),void);
value glstub_glVertexStream3dATI(value v0, value v1, value v2, value v3)
{
	CAMLparam4(v0, v1, v2, v3);
	GLenum lv0 = Int_val(v0);
	GLdouble lv1 = Double_val(v1);
	GLdouble lv2 = Double_val(v2);
	GLdouble lv3 = Double_val(v3);
	LOAD_FUNCTION(glVertexStream3dATI);
	(*stub_glVertexStream3dATI)(lv0, lv1, lv2, lv3);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glVertexStream3dvATI,(GLenum, GLdouble*),void);
value glstub_glVertexStream3dvATI(value v0, value v1)
{
	CAMLparam2(v0, v1);
	GLenum lv0 = Int_val(v0);
	GLdouble* lv1 = (Tag_val(v1) == Double_array_tag)? (double *)v1: Data_bigarray_val(v1);
	LOAD_FUNCTION(glVertexStream3dvATI);
	(*stub_glVertexStream3dvATI)(lv0, lv1);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glVertexStream3fATI,(GLenum, GLfloat, GLfloat, GLfloat),void);
value glstub_glVertexStream3fATI(value v0, value v1, value v2, value v3)
{
	CAMLparam4(v0, v1, v2, v3);
	GLenum lv0 = Int_val(v0);
	GLfloat lv1 = Double_val(v1);
	GLfloat lv2 = Double_val(v2);
	GLfloat lv3 = Double_val(v3);
	LOAD_FUNCTION(glVertexStream3fATI);
	(*stub_glVertexStream3fATI)(lv0, lv1, lv2, lv3);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glVertexStream3fvATI,(GLenum, GLfloat*),void);
value glstub_glVertexStream3fvATI(value v0, value v1)
{
	CAMLparam2(v0, v1);
	GLenum lv0 = Int_val(v0);
	GLfloat* lv1 = Data_bigarray_val(v1);
	LOAD_FUNCTION(glVertexStream3fvATI);
	(*stub_glVertexStream3fvATI)(lv0, lv1);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glVertexStream3iATI,(GLenum, GLint, GLint, GLint),void);
value glstub_glVertexStream3iATI(value v0, value v1, value v2, value v3)
{
	CAMLparam4(v0, v1, v2, v3);
	GLenum lv0 = Int_val(v0);
	GLint lv1 = Int_val(v1);
	GLint lv2 = Int_val(v2);
	GLint lv3 = Int_val(v3);
	LOAD_FUNCTION(glVertexStream3iATI);
	(*stub_glVertexStream3iATI)(lv0, lv1, lv2, lv3);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glVertexStream3ivATI,(GLenum, GLint*),void);
value glstub_glVertexStream3ivATI(value v0, value v1)
{
	CAMLparam2(v0, v1);
	GLenum lv0 = Int_val(v0);
	GLint* lv1 = Data_bigarray_val(v1);
	LOAD_FUNCTION(glVertexStream3ivATI);
	(*stub_glVertexStream3ivATI)(lv0, lv1);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glVertexStream3sATI,(GLenum, GLshort, GLshort, GLshort),void);
value glstub_glVertexStream3sATI(value v0, value v1, value v2, value v3)
{
	CAMLparam4(v0, v1, v2, v3);
	GLenum lv0 = Int_val(v0);
	GLshort lv1 = Int_val(v1);
	GLshort lv2 = Int_val(v2);
	GLshort lv3 = Int_val(v3);
	LOAD_FUNCTION(glVertexStream3sATI);
	(*stub_glVertexStream3sATI)(lv0, lv1, lv2, lv3);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glVertexStream3svATI,(GLenum, GLshort*),void);
value glstub_glVertexStream3svATI(value v0, value v1)
{
	CAMLparam2(v0, v1);
	GLenum lv0 = Int_val(v0);
	GLshort* lv1 = Data_bigarray_val(v1);
	LOAD_FUNCTION(glVertexStream3svATI);
	(*stub_glVertexStream3svATI)(lv0, lv1);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glVertexStream4dATI,(GLenum, GLdouble, GLdouble, GLdouble, GLdouble),void);
value glstub_glVertexStream4dATI(value v0, value v1, value v2, value v3, value v4)
{
	CAMLparam5(v0, v1, v2, v3, v4);
	GLenum lv0 = Int_val(v0);
	GLdouble lv1 = Double_val(v1);
	GLdouble lv2 = Double_val(v2);
	GLdouble lv3 = Double_val(v3);
	GLdouble lv4 = Double_val(v4);
	LOAD_FUNCTION(glVertexStream4dATI);
	(*stub_glVertexStream4dATI)(lv0, lv1, lv2, lv3, lv4);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glVertexStream4dvATI,(GLenum, GLdouble*),void);
value glstub_glVertexStream4dvATI(value v0, value v1)
{
	CAMLparam2(v0, v1);
	GLenum lv0 = Int_val(v0);
	GLdouble* lv1 = (Tag_val(v1) == Double_array_tag)? (double *)v1: Data_bigarray_val(v1);
	LOAD_FUNCTION(glVertexStream4dvATI);
	(*stub_glVertexStream4dvATI)(lv0, lv1);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glVertexStream4fATI,(GLenum, GLfloat, GLfloat, GLfloat, GLfloat),void);
value glstub_glVertexStream4fATI(value v0, value v1, value v2, value v3, value v4)
{
	CAMLparam5(v0, v1, v2, v3, v4);
	GLenum lv0 = Int_val(v0);
	GLfloat lv1 = Double_val(v1);
	GLfloat lv2 = Double_val(v2);
	GLfloat lv3 = Double_val(v3);
	GLfloat lv4 = Double_val(v4);
	LOAD_FUNCTION(glVertexStream4fATI);
	(*stub_glVertexStream4fATI)(lv0, lv1, lv2, lv3, lv4);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glVertexStream4fvATI,(GLenum, GLfloat*),void);
value glstub_glVertexStream4fvATI(value v0, value v1)
{
	CAMLparam2(v0, v1);
	GLenum lv0 = Int_val(v0);
	GLfloat* lv1 = Data_bigarray_val(v1);
	LOAD_FUNCTION(glVertexStream4fvATI);
	(*stub_glVertexStream4fvATI)(lv0, lv1);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glVertexStream4iATI,(GLenum, GLint, GLint, GLint, GLint),void);
value glstub_glVertexStream4iATI(value v0, value v1, value v2, value v3, value v4)
{
	CAMLparam5(v0, v1, v2, v3, v4);
	GLenum lv0 = Int_val(v0);
	GLint lv1 = Int_val(v1);
	GLint lv2 = Int_val(v2);
	GLint lv3 = Int_val(v3);
	GLint lv4 = Int_val(v4);
	LOAD_FUNCTION(glVertexStream4iATI);
	(*stub_glVertexStream4iATI)(lv0, lv1, lv2, lv3, lv4);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glVertexStream4ivATI,(GLenum, GLint*),void);
value glstub_glVertexStream4ivATI(value v0, value v1)
{
	CAMLparam2(v0, v1);
	GLenum lv0 = Int_val(v0);
	GLint* lv1 = Data_bigarray_val(v1);
	LOAD_FUNCTION(glVertexStream4ivATI);
	(*stub_glVertexStream4ivATI)(lv0, lv1);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glVertexStream4sATI,(GLenum, GLshort, GLshort, GLshort, GLshort),void);
value glstub_glVertexStream4sATI(value v0, value v1, value v2, value v3, value v4)
{
	CAMLparam5(v0, v1, v2, v3, v4);
	GLenum lv0 = Int_val(v0);
	GLshort lv1 = Int_val(v1);
	GLshort lv2 = Int_val(v2);
	GLshort lv3 = Int_val(v3);
	GLshort lv4 = Int_val(v4);
	LOAD_FUNCTION(glVertexStream4sATI);
	(*stub_glVertexStream4sATI)(lv0, lv1, lv2, lv3, lv4);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glVertexStream4svATI,(GLenum, GLshort*),void);
value glstub_glVertexStream4svATI(value v0, value v1)
{
	CAMLparam2(v0, v1);
	GLenum lv0 = Int_val(v0);
	GLshort* lv1 = Data_bigarray_val(v1);
	LOAD_FUNCTION(glVertexStream4svATI);
	(*stub_glVertexStream4svATI)(lv0, lv1);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glVertexWeightPointerEXT,(GLint, GLenum, GLsizei, GLvoid*),void);
value glstub_glVertexWeightPointerEXT(value v0, value v1, value v2, value v3)
{
	CAMLparam4(v0, v1, v2, v3);
	GLint lv0 = Int_val(v0);
	GLenum lv1 = Int_val(v1);
	GLsizei lv2 = Int_val(v2);
	GLvoid* lv3 = (GLvoid *)((Tag_val(v3) == String_tag)? (String_val(v3)) : (Data_bigarray_val(v3)));
	LOAD_FUNCTION(glVertexWeightPointerEXT);
	(*stub_glVertexWeightPointerEXT)(lv0, lv1, lv2, lv3);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glVertexWeightfEXT,(GLfloat),void);
value glstub_glVertexWeightfEXT(value v0)
{
	CAMLparam1(v0);
	GLfloat lv0 = Double_val(v0);
	LOAD_FUNCTION(glVertexWeightfEXT);
	(*stub_glVertexWeightfEXT)(lv0);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glVertexWeightfvEXT,(GLfloat*),void);
value glstub_glVertexWeightfvEXT(value v0)
{
	CAMLparam1(v0);
	GLfloat* lv0 = Data_bigarray_val(v0);
	LOAD_FUNCTION(glVertexWeightfvEXT);
	(*stub_glVertexWeightfvEXT)(lv0);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glVertexWeighthNV,(GLushort),void);
value glstub_glVertexWeighthNV(value v0)
{
	CAMLparam1(v0);
	GLushort lv0 = Int_val(v0);
	LOAD_FUNCTION(glVertexWeighthNV);
	(*stub_glVertexWeighthNV)(lv0);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glVertexWeighthvNV,(GLushort*),void);
value glstub_glVertexWeighthvNV(value v0)
{
	CAMLparam1(v0);
	GLushort* lv0 = Data_bigarray_val(v0);
	LOAD_FUNCTION(glVertexWeighthvNV);
	(*stub_glVertexWeighthvNV)(lv0);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glViewport,(GLint, GLint, GLsizei, GLsizei),void);
value glstub_glViewport(value v0, value v1, value v2, value v3)
{
	CAMLparam4(v0, v1, v2, v3);
	GLint lv0 = Int_val(v0);
	GLint lv1 = Int_val(v1);
	GLsizei lv2 = Int_val(v2);
	GLsizei lv3 = Int_val(v3);
	LOAD_FUNCTION(glViewport);
	(*stub_glViewport)(lv0, lv1, lv2, lv3);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glWeightPointerARB,(GLint, GLenum, GLsizei, GLvoid*),void);
value glstub_glWeightPointerARB(value v0, value v1, value v2, value v3)
{
	CAMLparam4(v0, v1, v2, v3);
	GLint lv0 = Int_val(v0);
	GLenum lv1 = Int_val(v1);
	GLsizei lv2 = Int_val(v2);
	GLvoid* lv3 = (GLvoid *)((Tag_val(v3) == String_tag)? (String_val(v3)) : (Data_bigarray_val(v3)));
	LOAD_FUNCTION(glWeightPointerARB);
	(*stub_glWeightPointerARB)(lv0, lv1, lv2, lv3);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glWeightbvARB,(GLint, GLbyte*),void);
value glstub_glWeightbvARB(value v0, value v1)
{
	CAMLparam2(v0, v1);
	GLint lv0 = Int_val(v0);
	GLbyte* lv1 = Data_bigarray_val(v1);
	LOAD_FUNCTION(glWeightbvARB);
	(*stub_glWeightbvARB)(lv0, lv1);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glWeightdvARB,(GLint, GLdouble*),void);
value glstub_glWeightdvARB(value v0, value v1)
{
	CAMLparam2(v0, v1);
	GLint lv0 = Int_val(v0);
	GLdouble* lv1 = (Tag_val(v1) == Double_array_tag)? (double *)v1: Data_bigarray_val(v1);
	LOAD_FUNCTION(glWeightdvARB);
	(*stub_glWeightdvARB)(lv0, lv1);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glWeightfvARB,(GLint, GLfloat*),void);
value glstub_glWeightfvARB(value v0, value v1)
{
	CAMLparam2(v0, v1);
	GLint lv0 = Int_val(v0);
	GLfloat* lv1 = Data_bigarray_val(v1);
	LOAD_FUNCTION(glWeightfvARB);
	(*stub_glWeightfvARB)(lv0, lv1);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glWeightivARB,(GLint, GLint*),void);
value glstub_glWeightivARB(value v0, value v1)
{
	CAMLparam2(v0, v1);
	GLint lv0 = Int_val(v0);
	GLint* lv1 = Data_bigarray_val(v1);
	LOAD_FUNCTION(glWeightivARB);
	(*stub_glWeightivARB)(lv0, lv1);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glWeightsvARB,(GLint, GLshort*),void);
value glstub_glWeightsvARB(value v0, value v1)
{
	CAMLparam2(v0, v1);
	GLint lv0 = Int_val(v0);
	GLshort* lv1 = Data_bigarray_val(v1);
	LOAD_FUNCTION(glWeightsvARB);
	(*stub_glWeightsvARB)(lv0, lv1);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glWeightubvARB,(GLint, GLubyte*),void);
value glstub_glWeightubvARB(value v0, value v1)
{
	CAMLparam2(v0, v1);
	GLint lv0 = Int_val(v0);
	GLubyte* lv1 = Data_bigarray_val(v1);
	LOAD_FUNCTION(glWeightubvARB);
	(*stub_glWeightubvARB)(lv0, lv1);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glWeightuivARB,(GLint, GLuint*),void);
value glstub_glWeightuivARB(value v0, value v1)
{
	CAMLparam2(v0, v1);
	GLint lv0 = Int_val(v0);
	GLuint* lv1 = Data_bigarray_val(v1);
	LOAD_FUNCTION(glWeightuivARB);
	(*stub_glWeightuivARB)(lv0, lv1);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glWeightusvARB,(GLint, GLushort*),void);
value glstub_glWeightusvARB(value v0, value v1)
{
	CAMLparam2(v0, v1);
	GLint lv0 = Int_val(v0);
	GLushort* lv1 = Data_bigarray_val(v1);
	LOAD_FUNCTION(glWeightusvARB);
	(*stub_glWeightusvARB)(lv0, lv1);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glWindowPos2d,(GLdouble, GLdouble),void);
value glstub_glWindowPos2d(value v0, value v1)
{
	CAMLparam2(v0, v1);
	GLdouble lv0 = Double_val(v0);
	GLdouble lv1 = Double_val(v1);
	LOAD_FUNCTION(glWindowPos2d);
	(*stub_glWindowPos2d)(lv0, lv1);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glWindowPos2dARB,(GLdouble, GLdouble),void);
value glstub_glWindowPos2dARB(value v0, value v1)
{
	CAMLparam2(v0, v1);
	GLdouble lv0 = Double_val(v0);
	GLdouble lv1 = Double_val(v1);
	LOAD_FUNCTION(glWindowPos2dARB);
	(*stub_glWindowPos2dARB)(lv0, lv1);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glWindowPos2dMESA,(GLdouble, GLdouble),void);
value glstub_glWindowPos2dMESA(value v0, value v1)
{
	CAMLparam2(v0, v1);
	GLdouble lv0 = Double_val(v0);
	GLdouble lv1 = Double_val(v1);
	LOAD_FUNCTION(glWindowPos2dMESA);
	(*stub_glWindowPos2dMESA)(lv0, lv1);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glWindowPos2dv,(GLdouble*),void);
value glstub_glWindowPos2dv(value v0)
{
	CAMLparam1(v0);
	GLdouble* lv0 = (Tag_val(v0) == Double_array_tag)? (double *)v0: Data_bigarray_val(v0);
	LOAD_FUNCTION(glWindowPos2dv);
	(*stub_glWindowPos2dv)(lv0);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glWindowPos2dvARB,(GLdouble*),void);
value glstub_glWindowPos2dvARB(value v0)
{
	CAMLparam1(v0);
	GLdouble* lv0 = (Tag_val(v0) == Double_array_tag)? (double *)v0: Data_bigarray_val(v0);
	LOAD_FUNCTION(glWindowPos2dvARB);
	(*stub_glWindowPos2dvARB)(lv0);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glWindowPos2dvMESA,(GLdouble*),void);
value glstub_glWindowPos2dvMESA(value v0)
{
	CAMLparam1(v0);
	GLdouble* lv0 = (Tag_val(v0) == Double_array_tag)? (double *)v0: Data_bigarray_val(v0);
	LOAD_FUNCTION(glWindowPos2dvMESA);
	(*stub_glWindowPos2dvMESA)(lv0);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glWindowPos2f,(GLfloat, GLfloat),void);
value glstub_glWindowPos2f(value v0, value v1)
{
	CAMLparam2(v0, v1);
	GLfloat lv0 = Double_val(v0);
	GLfloat lv1 = Double_val(v1);
	LOAD_FUNCTION(glWindowPos2f);
	(*stub_glWindowPos2f)(lv0, lv1);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glWindowPos2fARB,(GLfloat, GLfloat),void);
value glstub_glWindowPos2fARB(value v0, value v1)
{
	CAMLparam2(v0, v1);
	GLfloat lv0 = Double_val(v0);
	GLfloat lv1 = Double_val(v1);
	LOAD_FUNCTION(glWindowPos2fARB);
	(*stub_glWindowPos2fARB)(lv0, lv1);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glWindowPos2fMESA,(GLfloat, GLfloat),void);
value glstub_glWindowPos2fMESA(value v0, value v1)
{
	CAMLparam2(v0, v1);
	GLfloat lv0 = Double_val(v0);
	GLfloat lv1 = Double_val(v1);
	LOAD_FUNCTION(glWindowPos2fMESA);
	(*stub_glWindowPos2fMESA)(lv0, lv1);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glWindowPos2fv,(GLfloat*),void);
value glstub_glWindowPos2fv(value v0)
{
	CAMLparam1(v0);
	GLfloat* lv0 = Data_bigarray_val(v0);
	LOAD_FUNCTION(glWindowPos2fv);
	(*stub_glWindowPos2fv)(lv0);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glWindowPos2fvARB,(GLfloat*),void);
value glstub_glWindowPos2fvARB(value v0)
{
	CAMLparam1(v0);
	GLfloat* lv0 = Data_bigarray_val(v0);
	LOAD_FUNCTION(glWindowPos2fvARB);
	(*stub_glWindowPos2fvARB)(lv0);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glWindowPos2fvMESA,(GLfloat*),void);
value glstub_glWindowPos2fvMESA(value v0)
{
	CAMLparam1(v0);
	GLfloat* lv0 = Data_bigarray_val(v0);
	LOAD_FUNCTION(glWindowPos2fvMESA);
	(*stub_glWindowPos2fvMESA)(lv0);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glWindowPos2i,(GLint, GLint),void);
value glstub_glWindowPos2i(value v0, value v1)
{
	CAMLparam2(v0, v1);
	GLint lv0 = Int_val(v0);
	GLint lv1 = Int_val(v1);
	LOAD_FUNCTION(glWindowPos2i);
	(*stub_glWindowPos2i)(lv0, lv1);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glWindowPos2iARB,(GLint, GLint),void);
value glstub_glWindowPos2iARB(value v0, value v1)
{
	CAMLparam2(v0, v1);
	GLint lv0 = Int_val(v0);
	GLint lv1 = Int_val(v1);
	LOAD_FUNCTION(glWindowPos2iARB);
	(*stub_glWindowPos2iARB)(lv0, lv1);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glWindowPos2iMESA,(GLint, GLint),void);
value glstub_glWindowPos2iMESA(value v0, value v1)
{
	CAMLparam2(v0, v1);
	GLint lv0 = Int_val(v0);
	GLint lv1 = Int_val(v1);
	LOAD_FUNCTION(glWindowPos2iMESA);
	(*stub_glWindowPos2iMESA)(lv0, lv1);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glWindowPos2iv,(GLint*),void);
value glstub_glWindowPos2iv(value v0)
{
	CAMLparam1(v0);
	GLint* lv0 = Data_bigarray_val(v0);
	LOAD_FUNCTION(glWindowPos2iv);
	(*stub_glWindowPos2iv)(lv0);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glWindowPos2ivARB,(GLint*),void);
value glstub_glWindowPos2ivARB(value v0)
{
	CAMLparam1(v0);
	GLint* lv0 = Data_bigarray_val(v0);
	LOAD_FUNCTION(glWindowPos2ivARB);
	(*stub_glWindowPos2ivARB)(lv0);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glWindowPos2ivMESA,(GLint*),void);
value glstub_glWindowPos2ivMESA(value v0)
{
	CAMLparam1(v0);
	GLint* lv0 = Data_bigarray_val(v0);
	LOAD_FUNCTION(glWindowPos2ivMESA);
	(*stub_glWindowPos2ivMESA)(lv0);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glWindowPos2s,(GLshort, GLshort),void);
value glstub_glWindowPos2s(value v0, value v1)
{
	CAMLparam2(v0, v1);
	GLshort lv0 = Int_val(v0);
	GLshort lv1 = Int_val(v1);
	LOAD_FUNCTION(glWindowPos2s);
	(*stub_glWindowPos2s)(lv0, lv1);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glWindowPos2sARB,(GLshort, GLshort),void);
value glstub_glWindowPos2sARB(value v0, value v1)
{
	CAMLparam2(v0, v1);
	GLshort lv0 = Int_val(v0);
	GLshort lv1 = Int_val(v1);
	LOAD_FUNCTION(glWindowPos2sARB);
	(*stub_glWindowPos2sARB)(lv0, lv1);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glWindowPos2sMESA,(GLshort, GLshort),void);
value glstub_glWindowPos2sMESA(value v0, value v1)
{
	CAMLparam2(v0, v1);
	GLshort lv0 = Int_val(v0);
	GLshort lv1 = Int_val(v1);
	LOAD_FUNCTION(glWindowPos2sMESA);
	(*stub_glWindowPos2sMESA)(lv0, lv1);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glWindowPos2sv,(GLshort*),void);
value glstub_glWindowPos2sv(value v0)
{
	CAMLparam1(v0);
	GLshort* lv0 = Data_bigarray_val(v0);
	LOAD_FUNCTION(glWindowPos2sv);
	(*stub_glWindowPos2sv)(lv0);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glWindowPos2svARB,(GLshort*),void);
value glstub_glWindowPos2svARB(value v0)
{
	CAMLparam1(v0);
	GLshort* lv0 = Data_bigarray_val(v0);
	LOAD_FUNCTION(glWindowPos2svARB);
	(*stub_glWindowPos2svARB)(lv0);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glWindowPos2svMESA,(GLshort*),void);
value glstub_glWindowPos2svMESA(value v0)
{
	CAMLparam1(v0);
	GLshort* lv0 = Data_bigarray_val(v0);
	LOAD_FUNCTION(glWindowPos2svMESA);
	(*stub_glWindowPos2svMESA)(lv0);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glWindowPos3d,(GLdouble, GLdouble, GLdouble),void);
value glstub_glWindowPos3d(value v0, value v1, value v2)
{
	CAMLparam3(v0, v1, v2);
	GLdouble lv0 = Double_val(v0);
	GLdouble lv1 = Double_val(v1);
	GLdouble lv2 = Double_val(v2);
	LOAD_FUNCTION(glWindowPos3d);
	(*stub_glWindowPos3d)(lv0, lv1, lv2);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glWindowPos3dARB,(GLdouble, GLdouble, GLdouble),void);
value glstub_glWindowPos3dARB(value v0, value v1, value v2)
{
	CAMLparam3(v0, v1, v2);
	GLdouble lv0 = Double_val(v0);
	GLdouble lv1 = Double_val(v1);
	GLdouble lv2 = Double_val(v2);
	LOAD_FUNCTION(glWindowPos3dARB);
	(*stub_glWindowPos3dARB)(lv0, lv1, lv2);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glWindowPos3dMESA,(GLdouble, GLdouble, GLdouble),void);
value glstub_glWindowPos3dMESA(value v0, value v1, value v2)
{
	CAMLparam3(v0, v1, v2);
	GLdouble lv0 = Double_val(v0);
	GLdouble lv1 = Double_val(v1);
	GLdouble lv2 = Double_val(v2);
	LOAD_FUNCTION(glWindowPos3dMESA);
	(*stub_glWindowPos3dMESA)(lv0, lv1, lv2);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glWindowPos3dv,(GLdouble*),void);
value glstub_glWindowPos3dv(value v0)
{
	CAMLparam1(v0);
	GLdouble* lv0 = (Tag_val(v0) == Double_array_tag)? (double *)v0: Data_bigarray_val(v0);
	LOAD_FUNCTION(glWindowPos3dv);
	(*stub_glWindowPos3dv)(lv0);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glWindowPos3dvARB,(GLdouble*),void);
value glstub_glWindowPos3dvARB(value v0)
{
	CAMLparam1(v0);
	GLdouble* lv0 = (Tag_val(v0) == Double_array_tag)? (double *)v0: Data_bigarray_val(v0);
	LOAD_FUNCTION(glWindowPos3dvARB);
	(*stub_glWindowPos3dvARB)(lv0);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glWindowPos3dvMESA,(GLdouble*),void);
value glstub_glWindowPos3dvMESA(value v0)
{
	CAMLparam1(v0);
	GLdouble* lv0 = (Tag_val(v0) == Double_array_tag)? (double *)v0: Data_bigarray_val(v0);
	LOAD_FUNCTION(glWindowPos3dvMESA);
	(*stub_glWindowPos3dvMESA)(lv0);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glWindowPos3f,(GLfloat, GLfloat, GLfloat),void);
value glstub_glWindowPos3f(value v0, value v1, value v2)
{
	CAMLparam3(v0, v1, v2);
	GLfloat lv0 = Double_val(v0);
	GLfloat lv1 = Double_val(v1);
	GLfloat lv2 = Double_val(v2);
	LOAD_FUNCTION(glWindowPos3f);
	(*stub_glWindowPos3f)(lv0, lv1, lv2);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glWindowPos3fARB,(GLfloat, GLfloat, GLfloat),void);
value glstub_glWindowPos3fARB(value v0, value v1, value v2)
{
	CAMLparam3(v0, v1, v2);
	GLfloat lv0 = Double_val(v0);
	GLfloat lv1 = Double_val(v1);
	GLfloat lv2 = Double_val(v2);
	LOAD_FUNCTION(glWindowPos3fARB);
	(*stub_glWindowPos3fARB)(lv0, lv1, lv2);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glWindowPos3fMESA,(GLfloat, GLfloat, GLfloat),void);
value glstub_glWindowPos3fMESA(value v0, value v1, value v2)
{
	CAMLparam3(v0, v1, v2);
	GLfloat lv0 = Double_val(v0);
	GLfloat lv1 = Double_val(v1);
	GLfloat lv2 = Double_val(v2);
	LOAD_FUNCTION(glWindowPos3fMESA);
	(*stub_glWindowPos3fMESA)(lv0, lv1, lv2);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glWindowPos3fv,(GLfloat*),void);
value glstub_glWindowPos3fv(value v0)
{
	CAMLparam1(v0);
	GLfloat* lv0 = Data_bigarray_val(v0);
	LOAD_FUNCTION(glWindowPos3fv);
	(*stub_glWindowPos3fv)(lv0);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glWindowPos3fvARB,(GLfloat*),void);
value glstub_glWindowPos3fvARB(value v0)
{
	CAMLparam1(v0);
	GLfloat* lv0 = Data_bigarray_val(v0);
	LOAD_FUNCTION(glWindowPos3fvARB);
	(*stub_glWindowPos3fvARB)(lv0);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glWindowPos3fvMESA,(GLfloat*),void);
value glstub_glWindowPos3fvMESA(value v0)
{
	CAMLparam1(v0);
	GLfloat* lv0 = Data_bigarray_val(v0);
	LOAD_FUNCTION(glWindowPos3fvMESA);
	(*stub_glWindowPos3fvMESA)(lv0);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glWindowPos3i,(GLint, GLint, GLint),void);
value glstub_glWindowPos3i(value v0, value v1, value v2)
{
	CAMLparam3(v0, v1, v2);
	GLint lv0 = Int_val(v0);
	GLint lv1 = Int_val(v1);
	GLint lv2 = Int_val(v2);
	LOAD_FUNCTION(glWindowPos3i);
	(*stub_glWindowPos3i)(lv0, lv1, lv2);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glWindowPos3iARB,(GLint, GLint, GLint),void);
value glstub_glWindowPos3iARB(value v0, value v1, value v2)
{
	CAMLparam3(v0, v1, v2);
	GLint lv0 = Int_val(v0);
	GLint lv1 = Int_val(v1);
	GLint lv2 = Int_val(v2);
	LOAD_FUNCTION(glWindowPos3iARB);
	(*stub_glWindowPos3iARB)(lv0, lv1, lv2);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glWindowPos3iMESA,(GLint, GLint, GLint),void);
value glstub_glWindowPos3iMESA(value v0, value v1, value v2)
{
	CAMLparam3(v0, v1, v2);
	GLint lv0 = Int_val(v0);
	GLint lv1 = Int_val(v1);
	GLint lv2 = Int_val(v2);
	LOAD_FUNCTION(glWindowPos3iMESA);
	(*stub_glWindowPos3iMESA)(lv0, lv1, lv2);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glWindowPos3iv,(GLint*),void);
value glstub_glWindowPos3iv(value v0)
{
	CAMLparam1(v0);
	GLint* lv0 = Data_bigarray_val(v0);
	LOAD_FUNCTION(glWindowPos3iv);
	(*stub_glWindowPos3iv)(lv0);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glWindowPos3ivARB,(GLint*),void);
value glstub_glWindowPos3ivARB(value v0)
{
	CAMLparam1(v0);
	GLint* lv0 = Data_bigarray_val(v0);
	LOAD_FUNCTION(glWindowPos3ivARB);
	(*stub_glWindowPos3ivARB)(lv0);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glWindowPos3ivMESA,(GLint*),void);
value glstub_glWindowPos3ivMESA(value v0)
{
	CAMLparam1(v0);
	GLint* lv0 = Data_bigarray_val(v0);
	LOAD_FUNCTION(glWindowPos3ivMESA);
	(*stub_glWindowPos3ivMESA)(lv0);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glWindowPos3s,(GLshort, GLshort, GLshort),void);
value glstub_glWindowPos3s(value v0, value v1, value v2)
{
	CAMLparam3(v0, v1, v2);
	GLshort lv0 = Int_val(v0);
	GLshort lv1 = Int_val(v1);
	GLshort lv2 = Int_val(v2);
	LOAD_FUNCTION(glWindowPos3s);
	(*stub_glWindowPos3s)(lv0, lv1, lv2);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glWindowPos3sARB,(GLshort, GLshort, GLshort),void);
value glstub_glWindowPos3sARB(value v0, value v1, value v2)
{
	CAMLparam3(v0, v1, v2);
	GLshort lv0 = Int_val(v0);
	GLshort lv1 = Int_val(v1);
	GLshort lv2 = Int_val(v2);
	LOAD_FUNCTION(glWindowPos3sARB);
	(*stub_glWindowPos3sARB)(lv0, lv1, lv2);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glWindowPos3sMESA,(GLshort, GLshort, GLshort),void);
value glstub_glWindowPos3sMESA(value v0, value v1, value v2)
{
	CAMLparam3(v0, v1, v2);
	GLshort lv0 = Int_val(v0);
	GLshort lv1 = Int_val(v1);
	GLshort lv2 = Int_val(v2);
	LOAD_FUNCTION(glWindowPos3sMESA);
	(*stub_glWindowPos3sMESA)(lv0, lv1, lv2);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glWindowPos3sv,(GLshort*),void);
value glstub_glWindowPos3sv(value v0)
{
	CAMLparam1(v0);
	GLshort* lv0 = Data_bigarray_val(v0);
	LOAD_FUNCTION(glWindowPos3sv);
	(*stub_glWindowPos3sv)(lv0);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glWindowPos3svARB,(GLshort*),void);
value glstub_glWindowPos3svARB(value v0)
{
	CAMLparam1(v0);
	GLshort* lv0 = Data_bigarray_val(v0);
	LOAD_FUNCTION(glWindowPos3svARB);
	(*stub_glWindowPos3svARB)(lv0);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glWindowPos3svMESA,(GLshort*),void);
value glstub_glWindowPos3svMESA(value v0)
{
	CAMLparam1(v0);
	GLshort* lv0 = Data_bigarray_val(v0);
	LOAD_FUNCTION(glWindowPos3svMESA);
	(*stub_glWindowPos3svMESA)(lv0);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glWindowPos4dMESA,(GLdouble, GLdouble, GLdouble, GLdouble),void);
value glstub_glWindowPos4dMESA(value v0, value v1, value v2, value v3)
{
	CAMLparam4(v0, v1, v2, v3);
	GLdouble lv0 = Double_val(v0);
	GLdouble lv1 = Double_val(v1);
	GLdouble lv2 = Double_val(v2);
	GLdouble lv3 = Double_val(v3);
	LOAD_FUNCTION(glWindowPos4dMESA);
	(*stub_glWindowPos4dMESA)(lv0, lv1, lv2, lv3);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glWindowPos4dvMESA,(GLdouble*),void);
value glstub_glWindowPos4dvMESA(value v0)
{
	CAMLparam1(v0);
	GLdouble* lv0 = (Tag_val(v0) == Double_array_tag)? (double *)v0: Data_bigarray_val(v0);
	LOAD_FUNCTION(glWindowPos4dvMESA);
	(*stub_glWindowPos4dvMESA)(lv0);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glWindowPos4fMESA,(GLfloat, GLfloat, GLfloat, GLfloat),void);
value glstub_glWindowPos4fMESA(value v0, value v1, value v2, value v3)
{
	CAMLparam4(v0, v1, v2, v3);
	GLfloat lv0 = Double_val(v0);
	GLfloat lv1 = Double_val(v1);
	GLfloat lv2 = Double_val(v2);
	GLfloat lv3 = Double_val(v3);
	LOAD_FUNCTION(glWindowPos4fMESA);
	(*stub_glWindowPos4fMESA)(lv0, lv1, lv2, lv3);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glWindowPos4fvMESA,(GLfloat*),void);
value glstub_glWindowPos4fvMESA(value v0)
{
	CAMLparam1(v0);
	GLfloat* lv0 = Data_bigarray_val(v0);
	LOAD_FUNCTION(glWindowPos4fvMESA);
	(*stub_glWindowPos4fvMESA)(lv0);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glWindowPos4iMESA,(GLint, GLint, GLint, GLint),void);
value glstub_glWindowPos4iMESA(value v0, value v1, value v2, value v3)
{
	CAMLparam4(v0, v1, v2, v3);
	GLint lv0 = Int_val(v0);
	GLint lv1 = Int_val(v1);
	GLint lv2 = Int_val(v2);
	GLint lv3 = Int_val(v3);
	LOAD_FUNCTION(glWindowPos4iMESA);
	(*stub_glWindowPos4iMESA)(lv0, lv1, lv2, lv3);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glWindowPos4ivMESA,(GLint*),void);
value glstub_glWindowPos4ivMESA(value v0)
{
	CAMLparam1(v0);
	GLint* lv0 = Data_bigarray_val(v0);
	LOAD_FUNCTION(glWindowPos4ivMESA);
	(*stub_glWindowPos4ivMESA)(lv0);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glWindowPos4sMESA,(GLshort, GLshort, GLshort, GLshort),void);
value glstub_glWindowPos4sMESA(value v0, value v1, value v2, value v3)
{
	CAMLparam4(v0, v1, v2, v3);
	GLshort lv0 = Int_val(v0);
	GLshort lv1 = Int_val(v1);
	GLshort lv2 = Int_val(v2);
	GLshort lv3 = Int_val(v3);
	LOAD_FUNCTION(glWindowPos4sMESA);
	(*stub_glWindowPos4sMESA)(lv0, lv1, lv2, lv3);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glWindowPos4svMESA,(GLshort*),void);
value glstub_glWindowPos4svMESA(value v0)
{
	CAMLparam1(v0);
	GLshort* lv0 = Data_bigarray_val(v0);
	LOAD_FUNCTION(glWindowPos4svMESA);
	(*stub_glWindowPos4svMESA)(lv0);
	CAMLreturn(Val_unit);
}

DECLARE_FUNCTION(glWriteMaskEXT,(GLuint, GLuint, GLenum, GLenum, GLenum, GLenum),void);
value glstub_glWriteMaskEXT(value v0, value v1, value v2, value v3, value v4, value v5)
{
	CAMLparam5(v0, v1, v2, v3, v4);
	CAMLxparam1(v5);
	GLuint lv0 = Int_val(v0);
	GLuint lv1 = Int_val(v1);
	GLenum lv2 = Int_val(v2);
	GLenum lv3 = Int_val(v3);
	GLenum lv4 = Int_val(v4);
	GLenum lv5 = Int_val(v5);
	LOAD_FUNCTION(glWriteMaskEXT);
	(*stub_glWriteMaskEXT)(lv0, lv1, lv2, lv3, lv4, lv5);
	CAMLreturn(Val_unit);
}

value glstub_glWriteMaskEXT_byte(value * argv, int n)
{
	return glstub_glWriteMaskEXT(argv[0], argv[1], argv[2], argv[3], argv[4], argv[5]);
}

