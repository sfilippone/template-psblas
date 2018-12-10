include ./Make.inc
TOP=.
BASIC_MODS=
UTIL_MODS =


src:
	cd psb && $(MAKE) src

cpy: src
	cd psb && $(MAKE) cpy 

clean:
	cd psb && $(MAKE) clean

