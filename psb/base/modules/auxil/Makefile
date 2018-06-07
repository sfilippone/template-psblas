#include ../../Make.inc
TOP=../../../..
BASIC_MODS=
UTIL_MODS =

MODULES=$(BASIC_MODS) $(UTIL_MODS)

VSRC=X_hsort_x_mod.p90  X_sort_mod.p90
ESRC=X_ip_reord_mod.P90 X_hsort_mod.p90 X_isort_mod.p90 X_qsort_mod.p90 \
	X_msort_mod.p90 X_realloc_mod.P90
SRCI=Xi_serial_mod.p90



FSRC1=$(patsubst %.p90, %.f90, $(subst X, psb_$(ARITH), $(filter %.p90, $(SRC))))
FSRC2=$(patsubst %.P90, %.F90, $(subst X, psb_$(ARITH), $(filter %.P90, $(SRC))))
FSRCI=$(patsubst %.p90, %.f90, $(subst Xi, psi_$(ARITH), $(filter %.p90, $(SRCI))))
FESRC=$(patsubst %.p90, %.f90, $(subst X, psb_$(ARITH), $(filter %.p90, $(ESRC))))
FESRC1=$(patsubst %.P90, %.F90, $(subst X, psb_$(ARITH), $(filter %.P90, $(ESRC))))
FVSRC1=$(patsubst %.p90, %.f90, $(subst X, psb_$(ARITH), $(filter %.p90, $(VSRC))))
FVSRC2=$(patsubst %.P90, %.F90, $(subst X, psb_$(ARITH), $(filter %.P90, $(VSRC))))
FVSRC= $(FVSRC1) $(FVSRC2)
FSRC=$(FSRC1) $(FSRC2) 

LIBMOD=
# OBJS= $(SFOBJS) $(DFOBJS) $(CFOBJS) $(ZFOBJS)
# SRCS= $(SFSRC) $(DFSRC) $(CFSRC) $(ZFSRC)
LIBDIR=..
CINCLUDES=-I.
FINCLUDES=$(FMFLAG)$(LIBDIR) $(FMFLAG). $(FIFLAG).


src: ssingle sdouble scomplex sdcompl sint slong sepk smpk
ssingle:
	$(MAKE) bsrc ARITH=s
sdouble:
	$(MAKE) bsrc ARITH=d
scomplex:
	$(MAKE) bsrc ARITH=c
sdcompl:
	$(MAKE) bsrc ARITH=z
sint:
	$(MAKE) vsrc ARITH=i
slong:
	$(MAKE) vsrc ARITH=l
smpk:
	$(MAKE) esrc ARITH=m

sepk:
	$(MAKE) esrc ARITH=e


bsrc: vsrc esrc $(FSRC)
vsrc: $(FVSRC)
esrc: $(FESRC) $(FESRC1) $(FSRCI)

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
$(FESRC): psb_$(ARITH)%.f90 : X%.p90 
	sed -f $(TOP)/$(ARITH).sed $< >$@
$(FESRC1): psb_$(ARITH)%.F90 : X%.P90 
	sed -f $(TOP)/$(ARITH).sed $< >$@

clean:
	/bin/rm -f *.f90 *.F90 *.o 


