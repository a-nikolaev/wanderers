MAKE=make
# Uncomment the following line on WIN32
# MAKE=make WIN32=true

all: sdl 

sdl:
	$(MAKE) -f makefile.inc nc

nosdl:	
	$(MAKE) -f makefile.inc NOSDL=true
	
clean:
	$(MAKE) -f makefile.inc clean

htmldoc:
	ocamldoc -html lib/sdl.mli lib/glcaml.mli lib/win.mli -d doc
