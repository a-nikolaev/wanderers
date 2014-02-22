LIBDIR=lib
SRCDIR=src
BINDIR=bin
CLIBS=SDL
LIBS=graphics unix bigarray
SDL_SOURCE=$(LIBDIR)/sdl_stub.c $(LIBDIR)/sdl.mli $(LIBDIR)/sdl.ml
GL_SOURCE=$(LIBDIR)/glcaml_stub.c $(LIBDIR)/glcaml.mli $(LIBDIR)/glcaml.ml
ifdef NOSDL
	WIN_SOURCE=$(LIBDIR)/win_stub.c $(LIBDIR)/win.mli $(LIBDIR)/win.ml
	SDL_SOURCE=
	CLIBS=GL
	ifdef WIN32
	CLIBS=opengl32 gdi32
	endif
	LIBS=graphics unix bigarray
endif	

# OCAMLFLAGS += -g

#OCAMLNCFLAGS += -p
#OCAMLLDFLAGS += -p
#OCAMLBCFLAGS += -p
#OCAMLBLDFLAGS += -p

CC=gcc
SOURCES=$(WIN_SOURCE) $(SDL_SOURCE) $(GL_SOURCE) \
  $(SRCDIR)/prob.ml \
  $(SRCDIR)/base.ml \
  $(SRCDIR)/fencing.ml \
  $(SRCDIR)/item.ml \
  $(SRCDIR)/inv.ml \
  $(SRCDIR)/common.ml \
  $(SRCDIR)/global.ml \
  $(SRCDIR)/org.ml \
  $(SRCDIR)/simorg.ml \
  $(SRCDIR)/genreg.ml \
  $(SRCDIR)/globalmove.ml \
  $(SRCDIR)/genmap.ml \
	$(SRCDIR)/vision.ml \
	$(SRCDIR)/politics.ml \
	$(SRCDIR)/top.ml \
	$(SRCDIR)/simobj.ml \
	$(SRCDIR)/state.ml \
	$(SRCDIR)/sim.ml \
	$(SRCDIR)/grafx.ml \
	$(SRCDIR)/view.ml \
	$(SRCDIR)/main.ml
RESULT=wanderers
-include OCamlMakefile
