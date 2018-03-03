#include ../../Make.inc
TOP=../../../..
BASIC_MODS=
UTIL_MODS =

MODULES=$(BASIC_MODS) $(UTIL_MODS)

VSRC=

SRC=X_realloc_mod.P90
SRCI=Xi_p2p_mod.P90  Xi_reduce_mod.P90 

#Xi_penv_mod.P90



FSRC1=$(patsubst %.p90, %.f90, $(subst X, psb_$(ARITH), $(filter %.p90, $(SRC))))
FSRC2=$(patsubst %.P90, %.F90, $(subst X, psb_$(ARITH), $(filter %.P90, $(SRC))))
FSRCI=$(patsubst %.p90, %.f90, $(subst Xi, psi_$(ARITH), $(filter %.p90, $(SRCI))))
FSRCI2=$(patsubst %.P90, %.F90, $(subst Xi, psi_$(ARITH), $(filter %.P90, $(SRCI))))	
FVSRC1=$(patsubst %.p90, %.f90, $(subst X, psb_$(ARITH), $(filter %.p90, $(VSRC))))
FVSRC2=$(patsubst %.P90, %.F90, $(subst X, psb_$(ARITH), $(filter %.P90, $(VSRC))))
FVSRC= $(FVSRC1) $(FVSRC2)
FSRC=$(FSRC1) $(FSRC2) 

LIBMOD=
LIBDIR=..
CINCLUDES=-I.
FINCLUDES=$(FMFLAG)$(LIBDIR) $(FMFLAG). $(FIFLAG).


src: ssingle sdouble scomplex sdcompl smint seint

ssingle:
	$(MAKE) bsrc ARITH=s
sdouble:
	$(MAKE) bsrc ARITH=d
scomplex:
	$(MAKE) bsrc ARITH=c
sdcompl:
	$(MAKE) bsrc ARITH=z

smint:
	$(MAKE) bsrc ARITH=m

seint:
	$(MAKE) bsrc ARITH=e


bsrc: vsrc isrc $(FSRC)
vsrc: $(FVSRC)
isrc: $(FSRCI) $(FSRCI2)


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


clean:
	/bin/rm -f *.f90 *.F90 *.o 


