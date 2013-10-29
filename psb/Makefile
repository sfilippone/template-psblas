#include ../../Make.inc

BASIC_MODS=
UTIL_MODS =


src: sbase sprec skryl sext sgpu



sbase:
	cd base && $(MAKE) src
sprec:
	cd prec && $(MAKE) src

skryl:
	cd krylov && $(MAKE) src
sext:
	cd ext && $(MAKE) src
sgpu:
	cd gpu && $(MAKE) src

clean:
	cd base && $(MAKE) clean
	cd prec && $(MAKE) clean
	cd krylov && $(MAKE) clean
	cd ext && $(MAKE) clean
	cd gpu && $(MAKE) clean


