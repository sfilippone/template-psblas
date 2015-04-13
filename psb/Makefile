#include ../../Make.inc

BASIC_MODS=
UTIL_MODS =


src: sbase sprec skryl 


sbase:
	cd base && $(MAKE) src
sprec:
	cd prec && $(MAKE) src

skryl:
	cd krylov && $(MAKE) src

clean:
	cd base && $(MAKE) clean
	cd prec && $(MAKE) clean
	cd krylov && $(MAKE) clean


