s/@X@/z/g
s/@CONJG@/conjg/g
s/@TYPE@/complex/g
s/@RTYPE@/real/g
s/@FKIND@/psb_dpk_/g
s/@RT@/d/g

s/@SIZET@/(2*psb_sizeof_dp)/g 

s/@XZERO@/zzero/g
s/@XONE@/zone/g

s/@RZERO@/dzero/g
s/@RONE@/done/g

s/@DOT@/zdotc/g
s/@NRM2@/dznrm2/g
/^ *@IS@ *$/,/^ *@IE@ *$/d
/^ *@NOTIS@ *$/d
/^ *@NOTIE@ *$/d
/^ *@NOTCS@ *$/,/^ *@NOTCE@ *$/d
/^ *@CS@ *$/d
/^ *@CE@ *$/d


s/@MPI_TYPE@/psb_mpi_c_dpk_/g
s/@PSB_SWAP_TAG@/psb_dcomplex_swap_tag/g

s/@SPGPU_TYPE@/spgpu_type_complex_double/g
s/@CTYPE@/DoubleComplex/g
s/@FLAG_COMPLEX@/Complex/g
s/@FCKIND@/c_double_complex/g
s/@FRCKIND@/c_double/g