TOP=../../..
include $(TOP)/Make.inc
BASIC_MODS=
UTIL_MODS =

MODULES=$(BASIC_MODS) $(UTIL_MODS)

SRC=X_prec_type_impl.p90 X_diagprec_impl.p90 Xprecinit.p90\
    X_bjacprec_impl.p90 X_nullprec_impl.p90 Xprecbld.p90 \
    X_ilu0_fact.p90 X_iluk_fact.p90 X_ilut_fact.p90 \
		X_sp_drop.p90 X_sparsify.p90 Xrwclip.p90 \
		Xsparse_biconjg_llk_noth.P90 Xsparse_biconjg_llk.P90 \
		Xsparse_biconjg_mlk.P90 Xsparse_biconjg_s_llk.P90 \
		Xsparse_biconjg_s_ft_llk.P90 X_ainv_bld.p90 \
		X_invt_fact.p90 X_invk_fact.p90



FSRC1=$(patsubst %.p90, %.f90, $(subst X, psb_$(ARITH), $(filter %.p90, $(SRC))))
FSRC2=$(patsubst %.P90, %.F90, $(subst X, psb_$(ARITH), $(filter %.P90, $(SRC))))
FSRC=$(FSRC1) $(FSRC2)
FOBJS1=$(FSRC1:.f90=.o)
FOBJS2=$(FSRC2:.F90=.o)
FOBJS=$(FOBJS1) $(FOBJS2)

LIBMOD=
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

cpy:
	($(TOP)/cpy.sh $(TOP) $(TARGET)/prec/impl *.f90 *.F90)


$(FSRC1): psb_$(ARITH)%.f90 : X%.p90
	sed -f $(TOP)/$(ARITH).sed $< >$@
$(FSRC2): psb_$(ARITH)%.F90 : X%.P90
	sed -f $(TOP)/$(ARITH).sed $< >$@

clean:
	/bin/rm -f *.f90 *.F90 *.o
