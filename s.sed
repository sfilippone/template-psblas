s/@X@/s/g
s/@SX@/s/g
s/@IX@/s/g
s/@LX@/ls/g
s/@S@//g
s/@CONJG@//g
s/@TYPE@/real/g
s/@RTYPE@/real/g
s/@FKIND@/psb_spk_/g
s/@IXKIND@/psb_ipk_/g	
s/@LXKIND@/psb_lpk_/g	
s/@RT@/s/g

s/@SIZET@/psb_sizeof_sp/g 

s/@XZERO@/szero/g
s/@XONE@/sone/g

s/@RZERO@/szero/g
s/@RONE@/sone/g

s/@DOT@/sdot/g
s/@NRM2@/snrm2/g
/^ *@I2INTS@ *$/,/^ *@I2INTE@ *$/d
/^ *@INTS@ *$/,/^ *@INTE@ *$/d
/^ *@LINTS@ *$/,/^ *@LINTE@ *$/d
/^ *@NOTINTS@ *$/d
/^ *@NOTINTE@ *$/d
/^ *@CPLXS@ *$/,/^ *@CPLXE@ *$/d
/^ *@NOTCPLXS@ *$/d
/^ *@NOTCPLXE@ *$/d
/^ *@REALS@ *$/d
/^ *@REALE@ *$/d
/^ *@DPKS@ *$/,/^ *@DPKE@ *$/d
/^ *@SPKS@ *$/d
/^ *@SPKE@ *$/d

s/@MPI_TYPE@/psb_mpi_r_spk_/g
s/@PSB_TAG@/psb_real_tag/g
s/@PSB_SWAP_TAG@/psb_real_swap_tag/g

s/@SPGPU_TYPE@/spgpu_type_float/g

s/@CTYPE@/Float/g
s/@FLAG_COMPLEX@//g
s/@FCKIND@/c_float/g
s/@FRCKIND@/c_float/g

s/@PSB_C_T@/PSB_C_S/g
s/@psb_c_t_t@/psb_c_s_t/g
s/@psb_rt_t@/psb_c_s_t/g
s/@psb_c_t@/psb_c_s/g
s/@tvector@/svector/gi
s/@tspmat@/sspmat/gi