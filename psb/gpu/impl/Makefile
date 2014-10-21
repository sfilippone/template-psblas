#include ../../Make.inc

BASIC_MODS=
UTIL_MODS =

SRC= \
X_cp_csrg_from_coo.P90 \
X_cp_csrg_from_fmt.P90 \
X_cp_elg_from_coo.P90 \
X_cp_elg_from_fmt.P90 \
X_cp_hlg_from_coo.P90 \
X_cp_hlg_from_fmt.P90 \
X_cp_hybg_from_coo.P90 \
X_cp_hybg_from_fmt.P90 \
X_csrg_allocate_mnnz.P90 \
X_csrg_csmm.P90 \
X_csrg_csmv.P90 \
X_csrg_inner_vect_sv.P90 \
X_csrg_mold.P90 \
X_csrg_reallocate_nz.P90 \
X_csrg_scal.P90 \
X_csrg_scals.P90 \
X_csrg_to_gpu.P90 \
X_csrg_vect_mv.P90 \
X_elg_allocate_mnnz.P90 \
X_elg_asb.p90 \
X_elg_csmm.P90 \
X_elg_csmv.P90 \
X_elg_csput.P90 \
X_elg_from_gpu.P90 \
X_elg_inner_vect_sv.P90 \
X_elg_mold.P90 \
X_elg_reallocate_nz.P90 \
X_elg_scal.P90 \
X_elg_scals.P90 \
X_elg_to_gpu.P90 \
X_elg_trim.p90 \
X_elg_vect_mv.P90 \
X_hlg_allocate_mnnz.P90 \
X_hlg_csmm.P90 \
X_hlg_csmv.P90 \
X_hlg_inner_vect_sv.P90 \
X_hlg_mold.P90 \
X_hlg_reallocate_nz.P90 \
X_hlg_scal.P90 \
X_hlg_scals.P90 \
X_hlg_to_gpu.P90 \
X_hlg_vect_mv.P90 \
X_hybg_allocate_mnnz.P90 \
X_hybg_csmm.P90 \
X_hybg_csmv.P90 \
X_hybg_inner_vect_sv.P90 \
X_hybg_mold.P90 \
X_hybg_reallocate_nz.P90 \
X_hybg_scal.P90 \
X_hybg_scals.P90 \
X_hybg_to_gpu.P90 \
X_hybg_vect_mv.P90 \
X_mv_csrg_from_coo.P90 \
X_mv_csrg_from_fmt.P90 \
X_mv_elg_from_coo.P90 \
X_mv_elg_from_fmt.P90 \
X_mv_hlg_from_coo.P90 \
X_mv_hlg_from_fmt.P90 \
X_mv_hybg_from_coo.P90 \
X_mv_hybg_from_fmt.P90 \
X_cp_diag_from_coo.P90  \
X_diag_mold.P90    \
X_diag_vect_mv.P90 \
X_diag_csmv.P90    \
X_diag_to_gpu.P90  \
X_mv_diag_from_coo.P90 \
X_cp_hdiag_from_coo.P90 \
X_hdiag_mold.P90 \
X_hdiag_vect_mv.P90 \
X_hdiag_csmv.P90 \
X_hdiag_to_gpu.P90 \
X_mv_hdiag_from_coo.P90

FSRC1=$(patsubst %.p90, %.f90, $(subst X, psb_$(ARITH), $(filter %.p90, $(SRC))))
FSRC2=$(patsubst %.P90, %.F90, $(subst X, psb_$(ARITH), $(filter %.P90, $(SRC))))
FSRC=$(FSRC1) $(FSRC2) 
FOBJS1=$(FSRC1:.f90=.o)
FOBJS2=$(FSRC2:.F90=.o)
FOBJS=$(FOBJS1) $(FOBJS2)


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
	sed -f ../../../$(ARITH).sed $< >$@
$(FSRC2): psb_$(ARITH)%.F90 : X%.P90 
	sed -f ../../../$(ARITH).sed $< >$@

clean: 
	/bin/rm -f *.f90 *.F90 *.o 

