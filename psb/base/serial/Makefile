TOP=../../..
include $(TOP)/Make.inc
BASIC_MODS=
UTIL_MODS =

SRC= Xsymbmm.p90 Xnumbmm.p90 Xamax_s.p90 Xasum_s.p90 Xspspmm.p90 Xrwextd.p90
SRCI=Xi_serial_impl.P90


FSRC1=$(patsubst %.p90, %.f90, $(subst X, psb_$(ARITH), $(filter %.p90, $(SRC))))
FSRC2=$(patsubst %.P90, %.F90, $(subst X, psb_$(ARITH), $(filter %.P90, $(SRC))))
FSRCI=$(patsubst %.p90, %.f90, $(subst Xi, psi_$(ARITH), $(filter %.p90, $(SRCI))))
FSRCI2=$(patsubst %.P90, %.F90, $(subst Xi, psi_$(ARITH), $(filter %.P90, $(SRCI))))

FSRC=$(FSRC1) $(FSRC2) $(FSRCI) $(FSRCI2)
FOBJS1=$(FSRC1:.f90=.o)
FOBJS2=$(FSRC2:.F90=.o)
FOBJS=$(FOBJS1) $(FOBJS2)


src: simpl ssort  ssingle sdouble scomplex sdcompl sint
ssingle:
	$(MAKE) bsrc ARITH=s
sdouble:
	$(MAKE) bsrc ARITH=d
scomplex:
	$(MAKE) bsrc ARITH=c
sdcompl:
	$(MAKE) bsrc ARITH=z

sint:
	$(MAKE) isrc ARITH=m
	$(MAKE) isrc ARITH=e
	$(MAKE) isrc ARITH=i2

bsrc: $(FSRC)

isrc: $(FSRCI) $(FSRCI2)

ssort:
	cd sort && $(MAKE) src

sclean:
	cd sort && $(MAKE) clean

simpl:
	cd impl && $(MAKE) src

iclean:
	cd impl && $(MAKE) clean

cpy: 
	($(TOP)/cpy.sh $(TOP) $(TARGET)/base/serial *.f90 *.F90)
	cd impl && $(MAKE) cpy
	cd sort && $(MAKE) cpy


$(FSRC1): psb_$(ARITH)%.f90 : X%.p90
	sed -f $(TOP)/$(ARITH).sed $< >$@
$(FSRC2): psb_$(ARITH)%.F90 : X%.P90 
	sed -f $(TOP)/$(ARITH).sed $< >$@
$(FSRCI): psi_$(ARITH)%.f90 : Xi%.p90 
	sed -f $(TOP)/$(ARITH).sed $< >$@
$(FSRCI2): psi_$(ARITH)%.F90 : Xi%.P90 
	sed -f $(TOP)/$(ARITH).sed $< >$@

clean: iclean sclean
	/bin/rm -f *.f90 *.F90 *.o 

