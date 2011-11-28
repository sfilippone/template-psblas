#include ../../Make.inc

BASIC_MODS=
UTIL_MODS =


src: smodules stools sser


stools sser: smodules

smodules:
	cd modules && $(MAKE) src
stools:
	cd tools && $(MAKE) src

sser: 
	cd serial && $(MAKE) src
clean:
	cd modules && $(MAKE) clean
	cd tools && $(MAKE) clean
	cd serial && $(MAKE) clean


