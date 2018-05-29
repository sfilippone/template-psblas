s/@X@/d/g
s/@SX@/d/g
s/@S@//g
s/@CONJG@//g
s/@TYPE@/real/g
s/@RTYPE@/real/g
s/@FKIND@/psb_dpk_/g
s/@IXKIND@/psb_ipk_/g	
s/@RT@/d/g

s/@SIZET@/psb_sizeof_dp/g 

s/@XZERO@/dzero/g
s/@XONE@/done/g

s/@RZERO@/dzero/g
s/@RONE@/done/g

s/@DOT@/ddot/g
s/@NRM2@/dnrm2/g
/^ *@INTS@ *$/,/^ *@INTE@ *$/d
/^ *@LINTS@ *$/,/^ *@LINTE@ *$/d
/^ *@NOTINTS@ *$/d
/^ *@NOTINTE@ *$/d
/^ *@CPLXS@ *$/,/^ *@CPLXE@ *$/d
/^ *@NOTCPLXS@ *$/d
/^ *@NOTCPLXE@ *$/d
/^ *@REALS@ *$/d
/^ *@REALE@ *$/d
/^ *@DPKS@ *$/d
/^ *@DPKE@ *$/d
/^ *@SPKS@ *$/,/^ *@SPKE@ *$/d


s/@MPI_TYPE@/psb_mpi_r_dpk_/g
s/@PSB_TAG@/psb_double_tag/g
s/@PSB_SWAP_TAG@/psb_double_swap_tag/g	

s/@SPGPU_TYPE@/spgpu_type_double/g


s/@CTYPE@/Double/g
s/@FLAG_COMPLEX@//g
s/@FCKIND@/c_double/g
s/@FRCKIND@/c_double/g