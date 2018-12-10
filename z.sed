s/@X@/z/g
s/@SX@/z/g
s/@S@//g
s/@IX@/z/g
s/@LX@/lz/g
s/@CONJG@/conjg/g
s/@TYPE@/complex/g
s/@RTYPE@/real/g
s/@FKIND@/psb_dpk_/g
s/@IXKIND@/psb_ipk_/g	
s/@LXKIND@/psb_lpk_/g	
s/@RT@/d/g

s/@SIZET@/(2*psb_sizeof_dp)/g 

s/@XZERO@/zzero/g
s/@XONE@/zone/g

s/@RZERO@/dzero/g
s/@RONE@/done/g

s/@DOT@/zdotc/g
s/@NRM2@/dznrm2/g
/^ *@INTS@ *$/,/^ *@INTE@ *$/d
/^ *@LINTS@ *$/,/^ *@LINTE@ *$/d
/^ *@NOTINTS@ *$/d
/^ *@NOTINTE@ *$/d
/^ *@REALS@ *$/,/^ *@REALE@ *$/d
/^ *@CPLXS@ *$/d
/^ *@CPLXE@ *$/d
/^ *@NOTCPLXS@ *$/,/^ *@NOTCPLXE@ *$/d
/^ *@DPKS@ *$/d
/^ *@DPKE@ *$/d
/^ *@SPKS@ *$/,/^ *@SPKE@ *$/d


s/@MPI_TYPE@/psb_mpi_c_dpk_/g
s/@PSB_TAG@/psb_dcomplex_tag/g
s/@PSB_SWAP_TAG@/psb_dcomplex_swap_tag/g

s/@SPGPU_TYPE@/spgpu_type_complex_double/g
s/@CTYPE@/DoubleComplex/g
s/@FLAG_COMPLEX@/Complex/g
s/@FCKIND@/c_double_complex/g
s/@FRCKIND@/c_double/g