s/@X@/c/g
s/@SX@/c/g
s/@IX@/c/g
s/@LX@/lc/g
s/@S@//g
s/@CONJG@/conjg/g
s/@TYPE@/complex/g
s/@RTYPE@/real/g
s/@FKIND@/psb_spk_/g
s/@IXKIND@/psb_ipk_/g	
s/@LXKIND@/psb_lpk_/g	
s/@SIZET@/(2*psb_sizeof_sp)/g 

s/@RT@/s/g

s/@XZERO@/czero/g
s/@XONE@/cone/g

s/@RZERO@/szero/g
s/@RONE@/sone/g

s/@DOT@/cdotc/g
s/@NRM2@/scnrm2/g
/^ *@INTS@ *$/,/^ *@INTE@ *$/d
/^ *@LINTS@ *$/,/^ *@LINTE@ *$/d
/^ *@NOTINTS@ *$/d
/^ *@NOTINTE@ *$/d
/^ *@REALS@ *$/,/^ *@REALE@ *$/d
/^ *@CPLXS@ *$/d
/^ *@CPLXE@ *$/d
/^ *@NOTCPLXS@ *$/,/^ *@NOTCPLXE@ *$/d
/^ *@DPKS@ *$/,/^ *@DPKE@ *$/d
/^ *@SPKS@ *$/d
/^ *@SPKE@ *$/d

s/@MPI_TYPE@/psb_mpi_c_spk_/g
s/@PSB_TAG@/psb_complex_tag/g
s/@PSB_SWAP_TAG@/psb_complex_swap_tag/g	

s/@SPGPU_TYPE@/spgpu_type_complex_float/g

s/@CTYPE@/FloatComplex/g
s/@FLAG_COMPLEX@/Complex/g
s/@FCKIND@/c_float_complex/g
s/@FRCKIND@/c_float/g