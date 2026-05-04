TOP=../../..
include $(TOP)/Make.inc
BASIC_MODS=
UTIL_MODS =

MODULES=$(BASIC_MODS) $(UTIL_MODS)

SRC=X_psblas_cbind_mod.p90 X_serial_cbind_mod.P90 \
    X_tools_cbind_mod.P90 X_comm_cbind_mod.p90 \
    X_serial_cbind_impl.P90 X_comm_cbind_impl.p90 \
    X_psblas_cbind_impl.p90 X_tools_cbind_impl.P90
CSRC=Xbase.pc Xcomm.pc
HSRC=Xbase.ph Xcomm.ph



FSRC1=$(patsubst %.p90, %.f90, $(subst X, psb_$(ARITH), $(filter %.p90, $(SRC))))
FSRC2=$(patsubst %.P90, %.F90, $(subst X, psb_$(ARITH), $(filter %.P90, $(SRC))))
FSRC=$(FSRC1) $(FSRC2) 
FOBJS1=$(FSRC1:.f90=.o)
FOBJS2=$(FSRC2:.F90=.o)
FOBJS=$(FOBJS1) $(FOBJS2)
CSRC1=$(patsubst %.pc, %.c, $(subst X, psb_c_$(ARITH), $(CSRC)))
HSRC1=$(patsubst %.ph, %.h, $(subst X, psb_c_$(ARITH), $(HSRC)))
CHSRC=$(CSRC1) $(HSRC1)
LIBMOD=
LIBDIR=..
CINCLUDES=-I.
FINCLUDES=$(FMFLAG)$(LIBDIR) $(FMFLAG). $(FIFLAG).


src: ssingle sdouble scomplex sdcompl

sint:
	$(MAKE) bsrc ARITH=i
ssingle:
	$(MAKE) bsrc ARITH=s
sdouble:
	$(MAKE) bsrc ARITH=d
scomplex:
	$(MAKE) bsrc ARITH=c
sdcompl:
	$(MAKE) bsrc ARITH=z

bsrc: $(FSRC) $(CHSRC)

lib: $(FOBJS)

cpy: 
	($(TOP)/cpy.sh $(TOP) $(TARGET)/cbind/base *.f90 *.F90 *.c *.h)

$(FSRC1): psb_$(ARITH)%.f90 : X%.p90
	sed -f $(TOP)/$(ARITH).sed $< >$@
$(FSRC2): psb_$(ARITH)%.F90 : X%.P90 
	sed -f $(TOP)/$(ARITH).sed $< >$@

$(CSRC1): psb_c_$(ARITH)%.c : X%.pc
	sed -f $(TOP)/$(ARITH).sed $< >$@
$(HSRC1): psb_c_$(ARITH)%.h : X%.ph
	sed -f $(TOP)/$(ARITH).sed $< >$@

clean:
	/bin/rm -f *.f90 *.F90 *.o *.c *.h 


