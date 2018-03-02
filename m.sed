s/@X@/m/g
s/@CONJG@//g
s/@TYPE@/integer/g
s/@RTYPE@/integer/g
s/@FKIND@/psb_mpk_/g
s/@IXKIND@/psb_ipk_/g	
s/@RT@/m/g

s/@SIZET@/psb_sizeof_mp/g 

s/@XZERO@/mzero/g
s/@XONE@/mone/g

s/@RZERO@/mzero/g
s/@RONE@/mone/g

/^ *@NOTINTS@ *$/,/^ *@NOTINTE@ *$/d
/^ *@INTS@ *$/d
/^ *@INTE@ *$/d
/^ *@CPLXS@ *$/,/^ *@CPLXE@ *$/d
/^ *@REALS@ *$/d
/^ *@REALE@ *$/d

s/@DOT@/mdot/g
s/@NRM2@/mnrm2/g


s/@MPI_TYPE@/psb_mpi_mpk_int/g
s/@PSB_SWAP_TAG@/psb_int4_swap_tag/g