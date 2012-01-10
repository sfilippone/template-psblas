#include ../../Make.inc

BASIC_MODS=
UTIL_MODS =

MODULES=$(BASIC_MODS) $(UTIL_MODS)

SRC=X_prec_type.p90 X_prec_mod.p90 X_move_alloc_mod.p90 \
  X_base_solver_mod.p90 X_base_smoother_mod.p90 X_onelev_mod.p90\
  X_as_smoother.p90 X_jac_smoother.p90 X_diag_solver.p90 X_id_solver.p90\
  X_ilu_solver.p90



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


src: ssingle sdouble scomplex sdcompl simpl
ssingle:
	$(MAKE) bsrc ARITH=s
sdouble:
	$(MAKE) bsrc ARITH=d
scomplex:
	$(MAKE) bsrc ARITH=c
sdcompl:
	$(MAKE) bsrc ARITH=z


simpl:
	cd impl && $(MAKE) src

iclean:
	cd impl && $(MAKE) clean



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


X_prec_type.p90: X_onelev_mod.p90
	touch $@
X_onelev_mod.p90: X_base_smoother_mod.p90
	touch $@
X_base_smoother_mod.p90: X_base_solver_mod.p90
	touch $@

X_move_alloc_mod.p90: X_prec_type.p90 
	touch $@


$(FSRC1): mld_$(ARITH)%.f90 : X%.p90
	sed -f ../$(ARITH).sed $< >$@
$(FSRC2): mld_$(ARITH)%.F90 : X%.P90 
	sed -f ../$(ARITH).sed $< >$@

clean: iclean
	/bin/rm -f *.f90 *.F90 *.o


