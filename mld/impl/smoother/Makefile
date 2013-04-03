#include ../../Make.inc

BASIC_MODS=
UTIL_MODS =

MODULES=$(BASIC_MODS) $(UTIL_MODS)

SRC=X_as_smoother_apply.p90 X_as_smoother_apply_vect.p90 X_as_smoother_bld.p90 \
    X_as_smoother_check.p90 X_as_smoother_dmp.p90 X_as_smoother_free.p90 \
    X_as_smoother_setc.p90 X_as_smoother_seti.p90 X_as_smoother_setr.p90 \
    X_as_smoother_csetc.p90  X_as_smoother_csetr.p90 X_as_smoother_cseti.p90 \
    X_as_smoother_clone.p90 \
    X_base_smoother_apply.p90 X_base_smoother_apply_vect.p90 X_base_smoother_bld.p90 \
    X_base_smoother_check.p90 X_base_smoother_descr.p90 X_base_smoother_dmp.p90 \
    X_base_smoother_free.p90 X_base_smoother_setc.p90 X_base_smoother_seti.p90 \
    X_base_smoother_cseti.p90   X_base_smoother_csetc.p90  X_base_smoother_csetr.p90 \
    X_base_smoother_setr.p90 X_base_smoother_clone.p90 \
    X_jac_smoother_apply.p90 X_jac_smoother_apply_vect.p90  X_jac_smoother_bld.p90  \
    X_jac_smoother_clone.p90





FSRC1=$(patsubst %.p90, %.f90, $(subst X, mld_$(ARITH), $(filter %.p90, $(SRC))))
FSRC2=$(patsubst %.P90, %.F90, $(subst X, mld_$(ARITH), $(filter %.P90, $(SRC))))
FSRC=$(FSRC1) $(FSRC2)
FOBJS1=$(FSRC1:.f90=.o)
FOBJS2=$(FSRC2:.F90=.o)
FOBJS=$(FOBJS1) $(FOBJS2)

LIBMOD=
# OBJS= $(SFOBJS) $(DFOBJS) $(CFOBJS) $(ZFOBJS)
# SRCS= $(SFSRC) $(DFSRC) $(CFSRC) $(ZFSRC)
LIBDIR=..
CINCLUDES=-I.
FINCLUDES=$(FMFLAG)$(LIBDIR) $(FMFLAG). $(FIFLAG).


src: ssingle sdouble scomplex sdcompl
ssingle:
	$(MAKE) bsrc ARITH=s
sdouble:
	$(MAKE) bsrc ARITH=d
scomplex:
	$(MAKE) bsrc ARITH=c
sdcompl:
	$(MAKE) bsrc ARITH=z

all:  single double complex dcompl

single:
	$(MAKE) lib ARITH=s
double:
	$(MAKE) lib ARITH=d
complex:
	$(MAKE) lib ARITH=c
dcompl:
	$(MAKE) lib ARITH=z


bsrc: $(FSRC)

lib: $(FOBJS)



$(FSRC1): mld_$(ARITH)%.f90 : X%.p90
	sed -f ../../../$(ARITH).sed $< >$@
$(FSRC2): mld_$(ARITH)%.F90 : X%.P90 
	sed -f ../../../$(ARITH).sed $< >$@

clean:
	/bin/rm -f *.f90 *.F90 *.o

