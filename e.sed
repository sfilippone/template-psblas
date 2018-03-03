s/@X@/e/g
s/@CONJG@//g
s/@TYPE@/integer/g
s/@RTYPE@/integer/g
s/@FKIND@/psb_epk_/g
s/@IXKIND@/psb_epk_/g	
s/@RT@/e/g

s/@SIZET@/psb_sizeof_ep/g 

s/@XZERO@/ezero/g
s/@XONE@/eone/g

s/@RZERO@/ezero/g
s/@RONE@/eone/g

/^ *@NOTINTS@ *$/,/^ *@NOTINTE@ *$/d
/^ *@INTS@ *$/d
/^ *@INTE@ *$/d
/^ *@CPLXS@ *$/,/^ *@CPLXE@ *$/d
/^ *@NOTCPLXS@ *$/d
/^ *@NOTCPLXE@ *$/d
/^ *@REALS@ *$/d
/^ *@REALE@ *$/d

s/@DOT@/edot/g
s/@NRM2@/enrm2/g


s/@MPI_TYPE@/psb_mpi_epk_/g
s/@PSB_TAG@/psb_int8_tag/g
s/@PSB_SWAP_TAG@/psb_int8_swap_tag/g	
