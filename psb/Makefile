include ../../Make.inc

BASIC_MODS=
UTIL_MODS =

MODULES=$(BASIC_MODS) $(UTIL_MODS)

SRC=X_base_vect_mod.p90 X_base_mat_mod.p90 X_csc_mat_mod.p90 \
    X_csr_mat_mod.p90 X_base_mat_impl.p90 \
    X_coo_impl.p90 X_csr_impl.p90  X_csc_impl.p90 \
    X_mat_mod.p90 X_mat_impl.P90 



FSRC1=$(patsubst %.p90, %.f90, $(subst X, psb_$(ARITH), $(filter %.p90, $(SRC))))
FSRC2=$(patsubst %.P90, %.F90, $(subst X, psb_$(ARITH), $(filter %.P90, $(SRC))))
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

all:  single double complex dcompl

single:
	(make lib ARITH=s)
double:
	(make lib ARITH=d)
complex:
	(make lib ARITH=c)
dcompl:
	(make lib ARITH=z)

lib: $(FOBJS)

X_mat_impl.P90:  X_mat_mod.p90 
	touch $@
X_base_mat_mod.p90: X_base_vect_mod.p90
	touch $@
X_csc_mat_mod.p90 X_csr_mat_mod.p90: X_base_mat_mod.p90 
	touch $@
X_base_mat_impl.p90 X_coo_impl.p90: X_base_mat_mod.p90
	touch $@
X_csr_impl.p90: X_csr_mat_mod.p90
	touch $@

X_csc_impl.p90: X_csc_mat_mod.p90
	touch $@
X_mat_mod.p90: X_base_mat_mod.p90 X_csc_mat_mod.p90 X_csr_mat_mod.p90 
	touch $@

$(FSRC1): psb_$(ARITH)%.f90 : X%.p90
	sed -f $(ARITH).sed $< >$@
$(FSRC2): psb_$(ARITH)%.F90 : X%.P90
	sed -f $(ARITH).sed $< >$@

# clean:
        # /bin/rm -f $(MODULES) $(OBJS) $(MPFOBJS) *$(.mod)

veryclean: clean
	/bin/rm -f $(SRCS)

