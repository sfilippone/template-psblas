TOP=../../..
include $(TOP)/Make.inc
BASIC_MODS=
UTIL_MODS =

MODULES=$(BASIC_MODS) $(UTIL_MODS)

VSRC=
SRC=
SRCI=Xi_mod.P90
SRCE=


FSRC1=$(patsubst %.p90, %.f90, $(subst X, psb_$(ARITH), $(filter %.p90, $(SRC))))
FSRC2=$(patsubst %.P90, %.F90, $(subst X, psb_$(ARITH), $(filter %.P90, $(SRC))))
FSRCI=$(patsubst %.p90, %.f90, $(subst Xi, psi_$(ARITH), $(filter %.p90, $(SRCI))))
FSRCI2=$(patsubst %.P90, %.F90, $(subst Xi, psi_$(ARITH), $(filter %.P90, $(SRCI))))
FSRCE=$(patsubst %.p90, %.f90, $(subst Xi, psi_$(ARITH), $(filter %.p90, $(SRCE))))
FVSRC1=$(patsubst %.p90, %.f90, $(subst X, psb_$(ARITH), $(filter %.p90, $(VSRC))))
FVSRC2=$(patsubst %.P90, %.F90, $(subst X, psb_$(ARITH), $(filter %.P90, $(VSRC))))
FVSRC= $(FVSRC1) $(FVSRC2)
FSRC=$(FSRC1) $(FSRC2) 
FOBJS1=$(FSRC1:.f90=.o)
FOBJS2=$(FSRC2:.F90=.o)
FOBJS=$(FOBJS1) $(FOBJS2)
SRCS=$(FSRC) $(FVSRC) $(FSRCI) $(FSRCI2) $(FSRCE)
LIBMOD=
LIBDIR=..
CINCLUDES=-I.
FINCLUDES=$(FMFLAG)$(LIBDIR) $(FMFLAG). $(FIFLAG).


src: ssingle sdouble scomplex sdcompl sint sauxil spenv scomm spsb sser stl
ssingle:
	$(MAKE) bsrc ARITH=s
sdouble:
	$(MAKE) bsrc ARITH=d
scomplex:
	$(MAKE) bsrc ARITH=c
sdcompl:
	$(MAKE) bsrc ARITH=z

sint:
	$(MAKE) vsrc isrc ARITH=i
	$(MAKE) vsrc isrc ARITH=l
	$(MAKE) esrc ARITH=m
	$(MAKE) esrc ARITH=e

sauxil:
	cd auxil && $(MAKE) src
spenv:
	cd penv && $(MAKE) src
scomm:
	cd comm && $(MAKE) src
spsb:
	cd psblas && $(MAKE) src
sser:
	cd serial && $(MAKE) src
stl:
	cd tools && $(MAKE) src

bsrc: vsrc isrc $(FSRC)
vsrc: $(FVSRC) 
isrc: $(FSRCI) $(FSRCI2)
esrc: $(FSRCE)

cpy: 
	($(TOP)/cpy.sh $(TOP) $(TARGET)/base/modules *.f90 *.F90)
	cd auxil  && $(MAKE) cpy
	cd comm   && $(MAKE) cpy
	cd penv   && $(MAKE) cpy
	cd psblas && $(MAKE) cpy
	cd serial && $(MAKE) cpy
	cd tools  && $(MAKE) cpy	

$(FSRC1): psb_$(ARITH)%.f90 : X%.p90
	sed -f $(TOP)/$(ARITH).sed $< >$@
$(FSRC2): psb_$(ARITH)%.F90 : X%.P90 
	sed -f $(TOP)/$(ARITH).sed $< >$@
$(FVSRC1): psb_$(ARITH)%.f90 : X%.p90 
	sed -f $(TOP)/$(ARITH).sed $< >$@
$(FVSRC2): psb_$(ARITH)%.F90 : X%.P90 
	sed -f $(TOP)/$(ARITH).sed $< >$@
$(FSRCI): psi_$(ARITH)%.f90 : Xi%.p90 
	sed -f $(TOP)/$(ARITH).sed $< >$@
$(FSRCI2): psi_$(ARITH)%.F90 : Xi%.P90 
	sed -f $(TOP)/$(ARITH).sed $< >$@
$(FSRCE): psi_$(ARITH)%.f90 : Xi%.p90 
	sed -f $(TOP)/$(ARITH).sed $< >$@


clean:
	cd auxil && $(MAKE) clean
	cd penv && $(MAKE) clean
	cd comm && $(MAKE) clean
	cd psblas && $(MAKE) clean
	cd serial && $(MAKE) clean
	cd tools && $(MAKE) clean	
	/bin/rm -f *.f90 *.F90 *.o 


