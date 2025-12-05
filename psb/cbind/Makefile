TOP=../..
include $(TOP)/Make.inc

BASIC_MODS=
UTIL_MODS =


src: sbase sprec slinsolve sutil


sbase:
	cd base && $(MAKE) src

sprec:
	cd prec && $(MAKE) src

slinsolve:
	cd linsolve && $(MAKE) src

sutil:
	cd util && $(MAKE) src

cpy:
	cd base && $(MAKE) cpy
	cd prec && $(MAKE) cpy
	cd linsolve && $(MAKE) cpy
	cd util && $(MAKE) cpy


clean:
	cd base && $(MAKE) clean
	cd prec && $(MAKE) clean
	cd linsolve && $(MAKE) clean
	cd util && $(MAKE) clean
