TOP=../../..
include $(TOP)/Make.inc

BASIC_MODS=
UTIL_MODS =

MODULES=$(BASIC_MODS) $(UTIL_MODS)

VSRC=Xallc.p90 Xins.p90 Xasb.p90 Xfree.p90
ESRC=Xallc_a.p90 Xins_a.p90 Xasb_a.p90 Xfree_a.p90
SRC=X_map.p90 Xsphalo.P90 Xcdbldext.P90 Xspalloc.p90 Xspins.p90 \
	Xsprn.p90 Xspasb.p90 Xspfree.p90 X_par_csr_spspmm.p90 $(VSRC)




FSRC1=$(patsubst %.p90, %.f90, $(subst X, psb_$(ARITH), $(filter %.p90, $(SRC))))
FSRC2=$(patsubst %.P90, %.F90, $(subst X, psb_$(ARITH), $(filter %.P90, $(SRC))))
FSRC=$(FSRC1) $(FSRC2) 
FVSRC1=$(patsubst %.p90, %.f90, $(subst X, psb_$(ARITH), $(filter %.p90, $(VSRC))))
FVSRC2=$(patsubst %.P90, %.F90, $(subst X, psb_$(ARITH), $(filter %.P90, $(VSRC))))
FVSRC=$(FVSRC1) $(FVSRC2) 
FESRC1=$(patsubst %.p90, %.f90, $(subst X, psb_$(ARITH), $(filter %.p90, $(ESRC))))
FESRC2=$(patsubst %.P90, %.F90, $(subst X, psb_$(ARITH), $(filter %.P90, $(ESRC))))
FESRC=$(FESRC1) $(FESRC2) 



LIBMOD=
LIBDIR=..
CINCLUDES=-I.
FINCLUDES=$(FMFLAG)$(LIBDIR) $(FMFLAG). $(FIFLAG).


src: ssingle sdouble scomplex sdcompl sint
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
	$(MAKE) vsrc ARITH=l
	$(MAKE) esrc ARITH=m
	$(MAKE) esrc ARITH=e


bsrc: $(FSRC) $(FESRC) 
vsrc: $(FVSRC)
esrc: $(FESRC)

lib: $(FOBJS)

cpy: 
	($(TOP)/cpy.sh $(TOP) $(TARGET)/base/tools *.f90 *.F90)



$(FSRC1): psb_$(ARITH)%.f90 : X%.p90
	sed -f ../../../$(ARITH).sed $< >$@
$(FSRC2): psb_$(ARITH)%.F90 : X%.P90 
	sed -f ../../../$(ARITH).sed $< >$@
# $(FVSRC1): psb_$(ARITH)%.f90 : X%.p90
# 	sed -f ../../../$(ARITH).sed $< >$@
# $(FVSRC2): psb_$(ARITH)%.F90 : X%.P90 
# 	sed -f ../../../$(ARITH).sed $< >$@
$(FESRC1): psb_$(ARITH)%.f90 : X%.p90
	sed -f ../../../$(ARITH).sed $< >$@
$(FESRC2): psb_$(ARITH)%.F90 : X%.P90 
	sed -f ../../../$(ARITH).sed $< >$@

clean:
	/bin/rm -f *.f90 *.F90 *.o 


