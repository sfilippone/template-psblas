TOP=../..
include $(TOP)/Make.inc
BASIC_MODS=
UTIL_MODS =

SRC= \
X_cuda_cp_csrg_from_coo.P90 \
X_cuda_cp_csrg_from_fmt.P90 \
X_cuda_cp_elg_from_coo.P90 \
X_cuda_cp_elg_from_fmt.P90 \
X_cuda_cp_hlg_from_coo.P90 \
X_cuda_cp_hlg_from_fmt.P90 \
X_cuda_cp_hybg_from_coo.P90 \
X_cuda_cp_hybg_from_fmt.P90 \
X_cuda_csrg_allocate_mnnz.P90 \
X_cuda_csrg_csmm.P90 \
X_cuda_csrg_csmv.P90 \
X_cuda_csrg_inner_vect_sv.P90 \
X_cuda_csrg_mold.P90 \
X_cuda_csrg_reallocate_nz.P90 \
X_cuda_csrg_scal.P90 \
X_cuda_csrg_scals.P90 \
X_cuda_csrg_from_gpu.P90 \
X_cuda_csrg_to_gpu.P90 \
X_cuda_csrg_vect_mv.P90 \
X_cuda_elg_allocate_mnnz.P90 \
X_cuda_elg_asb.p90 \
X_cuda_elg_csmm.P90 \
X_cuda_elg_csmv.P90 \
X_cuda_elg_csput.P90 \
X_cuda_elg_from_gpu.P90 \
X_cuda_elg_inner_vect_sv.P90 \
X_cuda_elg_mold.P90 \
X_cuda_elg_reallocate_nz.P90 \
X_cuda_elg_scal.P90 \
X_cuda_elg_scals.P90 \
X_cuda_elg_to_gpu.P90 \
X_cuda_elg_trim.p90 \
X_cuda_elg_vect_mv.P90 \
X_cuda_hlg_allocate_mnnz.P90 \
X_cuda_hlg_csmm.P90 \
X_cuda_hlg_csmv.P90 \
X_cuda_hlg_inner_vect_sv.P90 \
X_cuda_hlg_mold.P90 \
X_cuda_hlg_reallocate_nz.P90 \
X_cuda_hlg_scal.P90 \
X_cuda_hlg_scals.P90 \
X_cuda_hlg_from_gpu.P90 \
X_cuda_hlg_to_gpu.P90 \
X_cuda_hlg_vect_mv.P90 \
X_cuda_hybg_allocate_mnnz.P90 \
X_cuda_hybg_csmm.P90 \
X_cuda_hybg_csmv.P90 \
X_cuda_hybg_inner_vect_sv.P90 \
X_cuda_hybg_mold.P90 \
X_cuda_hybg_reallocate_nz.P90 \
X_cuda_hybg_scal.P90 \
X_cuda_hybg_scals.P90 \
X_cuda_hybg_to_gpu.P90 \
X_cuda_hybg_vect_mv.P90 \
X_cuda_mv_csrg_from_coo.P90 \
X_cuda_mv_csrg_from_fmt.P90 \
X_cuda_mv_elg_from_coo.P90 \
X_cuda_mv_elg_from_fmt.P90 \
X_cuda_mv_hlg_from_coo.P90 \
X_cuda_mv_hlg_from_fmt.P90 \
X_cuda_mv_hybg_from_coo.P90 \
X_cuda_mv_hybg_from_fmt.P90 \
X_cuda_cp_diag_from_coo.P90  \
X_cuda_diag_mold.P90    \
X_cuda_diag_vect_mv.P90 \
X_cuda_diag_csmv.P90    \
X_cuda_diag_to_gpu.P90  \
X_cuda_mv_diag_from_coo.P90 \
X_cuda_cp_hdiag_from_coo.P90 \
X_cuda_hdiag_mold.P90 \
X_cuda_hdiag_vect_mv.P90 \
X_cuda_hdiag_csmv.P90 \
X_cuda_hdiag_to_gpu.P90 \
X_cuda_mv_hdiag_from_coo.P90 \
X_cuda_dnsg_mat_impl.P90

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

cpy: 
	($(TOP)/cpy.sh $(TOP) $(TARGET)/cuda/impl *.f90 *.F90)


$(FSRC1): psb_$(ARITH)%.f90 : X%.p90
	sed -f $(TOP)/$(ARITH).sed $< >$@
$(FSRC2): psb_$(ARITH)%.F90 : X%.P90 
	sed -f $(TOP)/$(ARITH).sed $< >$@

clean: 
	/bin/rm -f *.f90 *.F90 *.o 

