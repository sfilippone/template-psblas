#include ../../Make.inc
TOP=../../..
BASIC_MODS=
UTIL_MODS =

SRC= \
X_cp_dia_from_coo.p90 \
X_cp_dia_to_coo.p90 \
X_cp_ell_from_coo.p90 \
X_cp_ell_from_fmt.p90 \
X_cp_ell_to_coo.p90 \
X_cp_ell_to_fmt.p90 \
X_cp_hdia_from_coo.p90 \
X_cp_hdia_to_coo.p90 \
X_cp_hll_from_coo.p90 \
X_cp_hll_from_fmt.p90 \
X_cp_hll_to_coo.p90 \
X_cp_hll_to_fmt.p90 \
X_dia_aclsum.p90 \
X_dia_allocate_mnnz.p90 \
X_dia_arwsum.p90 \
X_dia_colsum.p90 \
X_dia_csgetptn.p90 \
X_dia_csgetrow.p90 \
X_dia_csmm.p90 \
X_dia_csmv.p90 \
X_dia_get_diag.p90 \
X_dia_maxval.p90 \
X_dia_mold.p90 \
X_dia_print.p90 \
X_dia_reallocate_nz.p90 \
X_dia_reinit.p90 \
X_dia_rowsum.p90 \
X_dia_scal.p90 \
X_dia_scals.p90 \
X_ell_aclsum.p90 \
X_ell_allocate_mnnz.p90 \
X_ell_arwsum.p90 \
X_ell_colsum.p90 \
X_ell_csgetblk.p90 \
X_ell_csgetptn.p90 \
X_ell_csgetrow.p90 \
X_ell_csmm.p90 \
X_ell_csmv.p90 \
X_ell_csnm1.p90 \
X_ell_csnmi.p90 \
X_ell_csput.p90 \
X_ell_cssm.p90 \
X_ell_cssv.p90 \
X_ell_get_diag.p90 \
X_ell_maxval.p90 \
X_ell_mold.p90 \
X_ell_print.p90 \
X_ell_reallocate_nz.p90 \
X_ell_reinit.p90 \
X_ell_rowsum.p90 \
X_ell_scal.p90 \
X_ell_scals.p90 \
X_ell_trim.p90 \
X_hdia_allocate_mnnz.p90 \
X_hdia_csmv.p90 \
X_hdia_mold.p90 \
X_hdia_print.p90 \
X_hll_aclsum.p90 \
X_hll_allocate_mnnz.p90 \
X_hll_arwsum.p90 \
X_hll_colsum.p90 \
X_hll_csgetblk.p90 \
X_hll_csgetptn.p90 \
X_hll_csgetrow.p90 \
X_hll_csmm.p90 \
X_hll_csmv.p90 \
X_hll_csnm1.p90 \
X_hll_csnmi.p90 \
X_hll_csput.p90 \
X_hll_cssm.p90 \
X_hll_cssv.p90 \
X_hll_get_diag.p90 \
X_hll_maxval.p90 \
X_hll_mold.p90 \
X_hll_print.p90 \
X_hll_reallocate_nz.p90 \
X_hll_reinit.p90 \
X_hll_rowsum.p90 \
X_hll_scal.p90 \
X_hll_scals.p90 \
X_mv_dia_from_coo.p90 \
X_mv_ell_from_coo.p90 \
X_mv_ell_from_fmt.p90 \
X_mv_ell_to_coo.p90 \
X_mv_ell_to_fmt.p90 \
X_mv_hdia_from_coo.p90 \
X_mv_hdia_to_coo.p90 \
X_mv_hll_from_coo.p90 \
X_mv_hll_from_fmt.p90 \
X_mv_hll_to_coo.p90 \
X_mv_hll_to_fmt.p90

SRCI=Xi_convert_hll_from_coo.p90 \
Xi_xtr_dia_from_coo.p90 \
Xi_convert_dia_from_coo.p90

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



$(FSRC1): psb_$(ARITH)%.f90 : X%.p90
	sed -f $(TOP)/$(ARITH).sed $< >$@
$(FSRC2): psb_$(ARITH)%.F90 : X%.P90 
	sed -f $(TOP)/$(ARITH).sed $< >$@
$(FSRC3): psi_$(ARITH)%.f90 : Xi%.p90 
	sed -f $(TOP)/$(ARITH).sed $< >$@

clean: 
	/bin/rm -f *.f90 *.F90 *.o 

