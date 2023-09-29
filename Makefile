include ./Make.inc
TOP=.
BASIC_MODS=
UTIL_MODS =


src:
	cd psb && $(MAKE) src
	cd ext && $(MAKE) src
	cd gpu && $(MAKE) src

cpy: src
	cd psb && $(MAKE) cpy 
	cd ext && $(MAKE) cpy
	cd gpu && $(MAKE) cpy
clean:
	cd psb && $(MAKE) clean
	cd ext && $(MAKE) clean
	cd gpu && $(MAKE) clean
