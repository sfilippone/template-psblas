TOP=..
include $(TOP)/Make.inc

BASIC_MODS=
UTIL_MODS =


src: sbase sprec slinslv sutil stest scbind

sbase:
	cd base && $(MAKE) src
sprec:
	cd prec && $(MAKE) src

slinslv:
	cd linsolve && $(MAKE) src
sutil:
	cd util && $(MAKE) src
stest:
	cd test  && $(MAKE) src
scbind:
	cd cbind && $(MAKE) src

cpy:  
	cd base && $(MAKE) cpy 
	cd prec && $(MAKE) cpy 
	cd linsolve && $(MAKE) cpy 
	cd util && $(MAKE) cpy 
	cd test && $(MAKE) cpy
	cd cbind && $(MAKE) cpy 

clean:
	cd base && $(MAKE) clean
	cd prec && $(MAKE) clean
	cd linsolve && $(MAKE) clean
	cd util && $(MAKE) clean
	cd test && $(MAKE) clean
	cd cbind && $(MAKE) clean

