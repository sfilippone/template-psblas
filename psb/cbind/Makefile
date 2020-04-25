TOP=../..
include $(TOP)/Make.inc

BASIC_MODS=
UTIL_MODS =


src: sbase sprec skrylov sutil


sbase:
	cd base && $(MAKE) src

sprec:
	cd prec && $(MAKE) src

skrylov:
	cd krylov && $(MAKE) src

sutil:
	cd util && $(MAKE) src

cpy:
	cd base && $(MAKE) cpy
	cd prec && $(MAKE) cpy
	cd krylov && $(MAKE) cpy
	cd util && $(MAKE) cpy


clean:
	cd base && $(MAKE) clean
	cd prec && $(MAKE) clean
	cd krylov && $(MAKE) clean
	cd util && $(MAKE) clean
