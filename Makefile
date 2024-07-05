include ./Make.inc
TOP=.
BASIC_MODS=
UTIL_MODS =


src:
	cd psb && $(MAKE) src
	cd ext && $(MAKE) src
	cd cuda && $(MAKE) src

cpy: src
	cd psb && $(MAKE) cpy 
	cd ext && $(MAKE) cpy
	cd cuda && $(MAKE) cpy
clean:
	cd psb && $(MAKE) clean
	cd ext && $(MAKE) clean
	cd cuda && $(MAKE) clean
