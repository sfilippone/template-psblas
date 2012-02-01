#include ../../Make.inc

BASIC_MODS=
UTIL_MODS =


src: sbase sprec



sbase:
	cd base && $(MAKE) src
sprec:
	cd prec && $(MAKE) src

clean:
	cd base && $(MAKE) clean
	cd prec && $(MAKE) clean


