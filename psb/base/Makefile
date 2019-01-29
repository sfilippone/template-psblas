#include ../../Make.inc

BASIC_MODS=
UTIL_MODS =


src: smodules stools sser scomm spsb

spsb scomm sinter stools sser: smodules

smodules:
	cd modules && $(MAKE) src
stools:
	cd tools && $(MAKE) src
scomm:
	cd comm && $(MAKE) src
spsb:
	cd psblas && $(MAKE) src

sser: 
	cd serial && $(MAKE) src

cpy: 
	cd modules && $(MAKE) cpy
	cd comm && $(MAKE) cpy
	cd tools && $(MAKE) cpy
	cd serial && $(MAKE) cpy
	cd psblas && $(MAKE) cpy

clean:
	cd modules && $(MAKE) clean
	cd tools && $(MAKE) clean
	cd serial && $(MAKE) clean
	cd psblas && $(MAKE) clean
	cd comm && $(MAKE) clean


