s/@X@/l/g
s/@CONJG@//g
s/@TYPE@/integer/g
s/@RTYPE@/integer/g
s/@FKIND@/psb_lpk_/g
s/@IXKIND@/psb_lpk_/g	
s/@RT@/l/g

s/@SIZET@/psb_sizeof_int/g 

s/@XZERO@/lzero/g
s/@XONE@/lone/g

s/@RZERO@/lzero/g
s/@RONE@/lone/g

/^ *@NOTINTS@ *$/,/^ *@NOTINTE@ *$/d
/^ *@INTS@ *$/d
/^ *@INTE@ *$/d
/^ *@CPLXS@ *$/,/^ *@CPLXE@ *$/d
/^ *@REALS@ *$/d
/^ *@REALE@ *$/d

s/@DOT@/ldot/g
s/@NRM2@/lnrm2/g


s/@MPI_TYPE@/psb_mpi_ipk_integer/g
s/@PSB_SWAP_TAG@/psb_int8_swap_tag/g