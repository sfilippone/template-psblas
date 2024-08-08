TOP=../..
include $(TOP)/Make.inc
BASIC_MODS=
UTIL_MODS =

SRC= \
X_oacc_mlt_v_2.p90 \
X_oacc_mlt_v.p90 \
X_oacc_csr_allocate_mnnz.P90 \
X_oacc_csr_cp_from_coo.P90 \
X_oacc_csr_cp_from_fmt.P90 \
X_oacc_csr_csmm.P90 \
X_oacc_csr_csmv.P90 \
X_oacc_csr_inner_vect_sv.P90 \
X_oacc_csr_mold.P90 \
X_oacc_csr_mv_from_coo.P90 \
X_oacc_csr_mv_from_fmt.P90 \
X_oacc_csr_reallocate_nz.P90 \
X_oacc_csr_scal.P90 \
X_oacc_csr_scals.P90 \
X_oacc_csr_vect_mv.P90 \
X_oacc_ell_allocate_mnnz.P90 \
X_oacc_ell_cp_from_coo.P90 \
X_oacc_ell_cp_from_fmt.P90 \
X_oacc_ell_csmm.P90 \
X_oacc_ell_csmv.P90 \
X_oacc_ell_inner_vect_sv.P90 \
X_oacc_ell_mold.P90 \
X_oacc_ell_mv_from_coo.P90 \
X_oacc_ell_mv_from_fmt.P90 \
X_oacc_ell_reallocate_nz.P90 \
X_oacc_ell_scal.P90 \
X_oacc_ell_scals.P90 \
X_oacc_ell_vect_mv.P90 \
X_oacc_hll_allocate_mnnz.P90 \
X_oacc_hll_cp_from_coo.P90 \
X_oacc_hll_cp_from_fmt.P90 \
X_oacc_hll_csmm.P90 \
X_oacc_hll_csmv.P90 \
X_oacc_hll_inner_vect_sv.P90 \
X_oacc_hll_mold.P90 \
X_oacc_hll_mv_from_coo.P90 \
X_oacc_hll_mv_from_fmt.P90 \
X_oacc_hll_reallocate_nz.P90 \
X_oacc_hll_scal.P90 \
X_oacc_hll_scals.P90 \
X_oacc_hll_vect_mv.P90 


SRCI=

FSRC1=$(patsubst %.p90, %.f90, $(subst X, psb_$(ARITH), $(filter %.p90, $(SRC))))
FSRC2=$(patsubst %.P90, %.F90, $(subst X, psb_$(ARITH), $(filter %.P90, $(SRC))))
FSRC3=$(patsubst %.p90, %.f90, $(subst Xi, psi_$(ARITH), $(filter %.p90, $(SRCI))))
FSRC=$(FSRC1) $(FSRC2) $(FSRC3)
FOBJS1=$(FSRC1:.f90=.o)
FOBJS2=$(FSRC2:.F90=.o)
FOBJS3=$(FSRC3:.f90=.o)
FOBJS=$(FOBJS1) $(FOBJS2) $(FOBJS3)


src: ssingle sdouble scomplex sdcompl
ssingle:
	$(MAKE) bsrc ARITH=s
sdouble:
	$(MAKE) bsrc ARITH=d
scomplex:
	$(MAKE) bsrc ARITH=c
sdcompl:
	$(MAKE) bsrc ARITH=z

bsrc: $(FSRC)

cpy: 
	($(TOP)/cpy.sh $(TOP) $(TARGET)/openacc/impl *.f90 *.F90)


$(FSRC1): psb_$(ARITH)%.f90 : X%.p90
	sed -f $(TOP)/$(ARITH).sed $< >$@
$(FSRC2): psb_$(ARITH)%.F90 : X%.P90 
	sed -f $(TOP)/$(ARITH).sed $< >$@
$(FSRC3): psi_$(ARITH)%.f90 : Xi%.p90 
	sed -f $(TOP)/$(ARITH).sed $< >$@

clean: 
	/bin/rm -f *.f90 *.F90 *.o 

