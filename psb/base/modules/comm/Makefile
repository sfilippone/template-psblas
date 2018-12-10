TOP=../../../..
include $(TOP)/Make.inc
BASIC_MODS=
UTIL_MODS =

MODULES=$(BASIC_MODS) $(UTIL_MODS)

SRC=X_linmap_mod.p90
VSRC=X_comm_mod.p90
VSRCE=X_comm_a_mod.p90 	
SRCI=Xi_comm_v_mod.p90
SRCE=Xi_comm_a_mod.p90 



FSRC1=$(patsubst %.p90, %.f90, $(subst X, psb_$(ARITH), $(filter %.p90, $(SRC))))
FSRC2=$(patsubst %.P90, %.F90, $(subst X, psb_$(ARITH), $(filter %.P90, $(SRC))))
FSRC=$(FSRC1) $(FSRC2) 
FSRCI=$(patsubst %.p90, %.f90, $(subst Xi, psi_$(ARITH), $(filter %.p90, $(SRCI))))
FSRCE=$(patsubst %.p90, %.f90, $(subst Xi, psi_$(ARITH), $(filter %.p90, $(SRCE))))
FVSRC1=$(patsubst %.p90, %.f90, $(subst X, psb_$(ARITH), $(filter %.p90, $(VSRC))))
FVSRC2=$(patsubst %.P90, %.F90, $(subst X, psb_$(ARITH), $(filter %.P90, $(VSRC))))
FVSRC= $(FVSRC1) $(FVSRC2)
FVSRCE1=$(patsubst %.p90, %.f90, $(subst X, psb_$(ARITH), $(filter %.p90, $(VSRCE))))
FVSRCE2=$(patsubst %.P90, %.F90, $(subst X, psb_$(ARITH), $(filter %.P90, $(VSRCE))))
FVSRCE= $(FVSRCE1) $(FVSRCE2)

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

bsrc: vsrc isrc $(FSRC) $(FSRCE)
vsrc: $(FVSRC)
isrc: $(FSRCI)
esrc: $(FSRCE) $(FVSRCE)

lib: $(FOBJS)


$(FSRC1): psb_$(ARITH)%.f90 : X%.p90
	sed -f $(TOP)/$(ARITH).sed $< >$@
$(FSRC2): psb_$(ARITH)%.F90 : X%.P90 
	sed -f $(TOP)/$(ARITH).sed $< >$@
$(FVSRCE1): psb_$(ARITH)%.f90 : X%.p90 
	sed -f $(TOP)/$(ARITH).sed $< >$@
$(FVSRCE2): psb_$(ARITH)%.F90 : X%.P90 
	sed -f $(TOP)/$(ARITH).sed $< >$@
$(FVSRC1): psb_$(ARITH)%.f90 : X%.p90 
	sed -f $(TOP)/$(ARITH).sed $< >$@
$(FVSRC2): psb_$(ARITH)%.F90 : X%.P90 
	sed -f $(TOP)/$(ARITH).sed $< >$@
$(FSRCI): psi_$(ARITH)%.f90 : Xi%.p90 
	sed -f $(TOP)/$(ARITH).sed $< >$@
$(FSRCE): psi_$(ARITH)%.f90 : Xi%.p90 
	sed -f $(TOP)/$(ARITH).sed $< >$@

cpy: 
	($(TOP)/cpy.sh $(TOP) $(TARGET)/base/modules/comm *.f90 *.F90)


clean:
	/bin/rm -f *.f90 *.F90 *.o 


