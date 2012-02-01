#include ../../Make.inc

BASIC_MODS=
UTIL_MODS =


src: smodules stools sser sinter scomm spsb


spsb scomm sinter stools sser: smodules

smodules:
	cd modules && $(MAKE) src
stools:
	cd tools && $(MAKE) src
sinter:
	cd internals && $(MAKE) src
scomm:
	cd comm && $(MAKE) src
spsb:
	cd psblas && $(MAKE) src

sser: 
	cd serial && $(MAKE) src
clean:
	cd modules && $(MAKE) clean
	cd tools && $(MAKE) clean
	cd serial && $(MAKE) clean
	cd internals && $(MAKE) clean
	cd psblas && $(MAKE) clean
	cd comm && $(MAKE) clean


