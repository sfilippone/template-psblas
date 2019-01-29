TOP=..
include $(TOP)/Make.inc

BASIC_MODS=
UTIL_MODS =


src: sbase sprec skryl sutil stest scbind

sbase:
	cd base && $(MAKE) src
sprec:
	cd prec && $(MAKE) src

skryl:
	cd krylov && $(MAKE) src
sutil:
	cd util && $(MAKE) src
stest:
	cd test  && $(MAKE) src
scbind:
	cd cbind && $(MAKE) src

cpy:  
	cd base && $(MAKE) cpy 
	cd prec && $(MAKE) cpy 
	cd krylov && $(MAKE) cpy 
	cd util && $(MAKE) cpy 
	cd test && $(MAKE) cpy
	cd cbind && $(MAKE) cpy 

clean:
	cd base && $(MAKE) clean
	cd prec && $(MAKE) clean
	cd krylov && $(MAKE) clean
	cd util && $(MAKE) clean
	cd test && $(MAKE) clean
	cd cbind && $(MAKE) clean

