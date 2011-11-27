#include ../../Make.inc

BASIC_MODS=
UTIL_MODS =


src: sbase stools


sbase:
	cd base && $(MAKE) src
stools:
	cd tools && $(MAKE) src

clean:
	cd base && $(MAKE) clean
	cd tools && $(MAKE) clean


