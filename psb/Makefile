#include ../../Make.inc

BASIC_MODS=
UTIL_MODS =


src: smodules stools


smodules:
	cd modules && $(MAKE) src
stools:
	cd tools && $(MAKE) src

clean:
	cd modules && $(MAKE) clean
	cd tools && $(MAKE) clean


