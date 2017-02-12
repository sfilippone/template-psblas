#include ../../Make.inc

BASIC_MODS=
UTIL_MODS =


src: sbase sprec skryl sutil stest


sbase:
	cd base && $(MAKE) src
sprec:
	cd prec && $(MAKE) src

skryl:
	cd krylov && $(MAKE) src
sutil:
	cd util && $(MAKE) src
stest:
	cd test  && $(MAKE) src

clean:
	cd base && $(MAKE) clean
	cd prec && $(MAKE) clean
	cd krylov && $(MAKE) clean
	cd util && $(MAKE) clean
	cd test && $(MAKE) clean


