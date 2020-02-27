TOP=../../../..
include $(TOP)/Make.inc
BASIC_MODS=
UTIL_MODS =

MODULES=$(BASIC_MODS) $(UTIL_MODS)

VSRC=X_tools_mod.P90 
SRCE=X_tools_a_mod.p90 



FSRC1=$(patsubst %.p90, %.f90, $(subst X, psb_$(ARITH), $(filter %.p90, $(SRC))))
FSRC2=$(patsubst %.P90, %.F90, $(subst X, psb_$(ARITH), $(filter %.P90, $(SRC))))
FSRCE=$(patsubst %.p90, %.f90, $(subst X, psb_$(ARITH), $(filter %.p90, $(SRCE))))
FVSRC1=$(patsubst %.p90, %.f90, $(subst X, psb_$(ARITH), $(filter %.p90, $(VSRC))))
FVSRC2=$(patsubst %.P90, %.F90, $(subst X, psb_$(ARITH), $(filter %.P90, $(VSRC))))
FVSRC= $(FVSRC1) $(FVSRC2)
FSRC=$(FSRC1) $(FSRC2) 
FOBJS1=$(FSRC1:.f90=.o)
FOBJS2=$(FSRC2:.F90=.o)
FOBJS=$(FOBJS1) $(FOBJS2)

LIBMOD=
LIBDIR=..
CINCLUDES=-I.
FINCLUDES=$(FMFLAG)$(LIBDIR) $(FMFLAG). $(FIFLAG).


src: ssingle sdouble scomplex sdcompl sint 

ssingle:
	$(MAKE) bsrc esrc ARITH=s
sdouble:
	$(MAKE) bsrc esrc ARITH=d
scomplex:
	$(MAKE) bsrc esrc ARITH=c
sdcompl:
	$(MAKE) bsrc esrc ARITH=z

sint:
	$(MAKE) vsrc isrc ARITH=i
	$(MAKE) vsrc isrc ARITH=l
	$(MAKE) esrc ARITH=m
	$(MAKE) esrc ARITH=e
	$(MAKE) esrc ARITH=i2

bsrc: vsrc isrc $(FSRC)
vsrc: $(FVSRC) 
isrc: $(FSRCI) $(FSRCI2)
esrc: $(FSRCE)



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
$(FSRCE): psb_$(ARITH)%.f90 : X%.p90 
	sed -f $(TOP)/$(ARITH).sed $< >$@

cpy: 
	($(TOP)/cpy.sh $(TOP) $(TARGET)/base/modules/tools *.f90 *.F90)

clean:
	/bin/rm -f *.f90 *.F90 *.o 


