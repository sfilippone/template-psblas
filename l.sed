s/@X@/l/g
s/@SX@/l/g
s/@RX@/l/g
s/@S@//g
s/@CONJG@//g
s/@TYPE@/integer/g
s/@RTYPE@/integer/g
s/@FKIND@/psb_lpk_/g
s/@IXKIND@/psb_lpk_/g	
s/@RT@/l/g

s/@SIZET@/psb_sizeof_lp/g 

s/@XZERO@/lzero/g
s/@XONE@/lone/g

s/@RZERO@/lzero/g
s/@RONE@/lone/g

/^ *@NOTINTS@ *$/,/^ *@NOTINTE@ *$/d
/^ *@INTS@ *$/d
/^ *@INTE@ *$/d
/^ *@IINTS@ *$/,/^ *@IINTE@ *$/d
/^ *@LINTS@ *$/d
/^ *@LINTE@ *$/d
/^ *@CPLXS@ *$/,/^ *@CPLXE@ *$/d
/^ *@NOTCPLXS@ *$/d
/^ *@NOTCPLXE@ *$/d
/^ *@REALS@ *$/d
/^ *@REALE@ *$/d

s/@DOT@/ldot/g
s/@NRM2@/lnrm2/g


s/@MPI_TYPE@/psb_mpi_lpk_/g
s/@PSB_TAG@/psb_long_tag/g
s/@PSB_SWAP_TAG@/psb_long_swap_tag/g
