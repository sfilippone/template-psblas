TOP=../..
include $(TOP)/Make.inc
BASIC_MODS=
UTIL_MODS =

MODULES=$(BASIC_MODS) $(UTIL_MODS)

SRC=



FSRC1=$(patsubst %.p90, %.f90, $(subst X, psb_$(ARITH), $(filter %.p90, $(SRC))))
FSRC2=$(patsubst %.P90, %.F90, $(subst X, psb_$(ARITH), $(filter %.P90, $(SRC))))
FSRC=$(FSRC1) $(FSRC2)
FOBJS1=$(FSRC1:.f90=.o)
FOBJS2=$(FSRC2:.F90=.o)
FOBJS=$(FOBJS1) $(FOBJS2)

LIBMOD=
LIBDIR=..
CINCLUDES=-I.
FINCLUDES=$(FMFLAG)$(LIBDIR) $(FMFLAG). $(FIFLAG).


src: sfileread spargen

cpy: 
	cd fileread && $(MAKE) cpy
	cd pargen && $(MAKE) cpy

ssingle:
	$(MAKE) bsrc ARITH=s
sdouble:
	$(MAKE) bsrc ARITH=d
scomplex:
	$(MAKE) bsrc ARITH=c
sdcompl:
	$(MAKE) bsrc ARITH=z


sfileread:
	cd fileread && $(MAKE) src
spargen:
	cd pargen && $(MAKE) src

cfileread:
	cd fileread && $(MAKE) clean
cpargen:
	cd pargen && $(MAKE) clean



bsrc: $(FSRC)



$(FSRC1): psb_$(ARITH)%.f90 : X%.p90
	sed -f $(TOP)/$(ARITH).sed $< >$@
$(FSRC2): psb_$(ARITH)%.F90 : X%.P90 
	sed -f $(TOP)/$(ARITH).sed $< >$@

clean: cfileread cpargen
	/bin/rm -f *.f90 *.F90 *.o


