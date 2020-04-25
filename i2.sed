s/@X@/i2/g
s/@SX@/i2/g
s/@S@//g
s/@CONJG@//g
s/@TYPE@/integer/g
s/@RTYPE@/integer/g
s/@FKIND@/psb_i2pk_/g
s/@IXKIND@/psb_ipk_/g	
s/@RT@/m/g

s/@SIZET@/psb_sizeof_i2p/g 

s/@XZERO@/i2zero/g
s/@XONE@/i2one/g

s/@RZERO@/i2zero/g
s/@RONE@/i2one/g

/^ *@NOTINTS@ *$/,/^ *@NOTINTE@ *$/d
/^ *@LINTS@ *$/,/^ *@LINTE@ *$/d
/^ *@INTS@ *$/d
/^ *@INTE@ *$/d
/^ *@CPLXS@ *$/,/^ *@CPLXE@ *$/d
/^ *@NOTCPLXS@ *$/d
/^ *@NOTCPLXE@ *$/d
/^ *@REALS@ *$/d
/^ *@REALE@ *$/d

s/@DOT@/i2dot/g
s/@NRM2@/i2nrm2/g


s/@MPI_TYPE@/psb_mpi_i2pk_/g
s/@PSB_TAG@/psb_int2_tag/g
s/@PSB_SWAP_TAG@/psb_int2_swap_tag/g	