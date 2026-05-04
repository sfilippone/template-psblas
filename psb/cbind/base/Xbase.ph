#ifndef @PSB_C_T@BASE_
#define @PSB_C_T@BASE_
#include "psb_c_base.h"

#ifdef __cplusplus
extern "C" {
#endif

typedef struct @PSB_C_T@VECTOR {
  void *@tvector@;
} @psb_c_t@vector;

typedef struct @PSB_C_T@SPMAT {
  void *@tspmat@;
} @psb_c_t@spmat;


/* dense vectors */
@psb_c_t@vector* psb_c_new_@tvector@();
psb_i_t    @psb_c_t@vect_get_nrows(@psb_c_t@vector *xh);
@psb_t_t@   *@psb_c_t@vect_get_cpy(@psb_c_t@vector *xh);
psb_i_t    @psb_c_t@vect_f_get_cpy(@psb_t_t@  *v, @psb_c_t@vector *xh);
psb_i_t    @psb_c_t@vect_zero(@psb_c_t@vector *xh);
@psb_t_t@   *@psb_c_t@vect_f_get_pnt(@psb_c_t@vector *xh);
psb_i_t    @psb_c_t@vect_clone(@psb_c_t@vector *xh, @psb_c_t@vector *yh);

psb_i_t    @psb_c_t@geall(@psb_c_t@vector *xh, psb_c_descriptor *cdh);
psb_i_t    @psb_c_t@geall_remote(@psb_c_t@vector *xh, psb_c_descriptor *cdh);
psb_i_t    @psb_c_t@geall_remote_options(@psb_c_t@vector *xh, psb_c_descriptor *cdh,
	   				 psb_i_t bldmode, psb_i_t dupl);
psb_i_t    @psb_c_t@geins(psb_i_t nz, const psb_l_t *irw, const @psb_t_t@ *val,
		    @psb_c_t@vector *xh, psb_c_descriptor *cdh);
psb_i_t    @psb_c_t@geins_add(psb_i_t nz, const psb_l_t *irw, const @psb_t_t@ *val,
			@psb_c_t@vector *xh, psb_c_descriptor *cdh);
psb_i_t    @psb_c_t@geasb(@psb_c_t@vector *xh, psb_c_descriptor *cdh);
psb_i_t    @psb_c_t@geasb_options(@psb_c_t@vector *xh, psb_c_descriptor *cdh, psb_i_t dupl);
psb_i_t	   @psb_c_t@geasb_options_format(@psb_c_t@vector *xh, psb_c_descriptor *cdh,
	    				psb_i_t dupl, const char *fmt);	

psb_i_t    @psb_c_t@gefree(@psb_c_t@vector *xh, psb_c_descriptor *cdh);
psb_i_t    @psb_c_t@gereinit(@psb_c_t@vector *xh, psb_c_descriptor *cdh, bool clear);
@psb_t_t@    @psb_c_t@getelem(@psb_c_t@vector *xh,psb_l_t index,psb_c_descriptor *cd);
@psb_t_t@	   @psb_c_t@matgetelem(@psb_c_t@spmat *ah,psb_l_t rowindex,psb_l_t colindex,psb_c_descriptor *cdh);	
psb_i_t    @psb_c_t@setelem(psb_l_t index, @psb_t_t@ val,
			  @psb_c_t@vector *xh, psb_c_descriptor *cd);


/* sparse matrices*/
@psb_c_t@spmat* psb_c_new_@tspmat@();
psb_i_t    @psb_c_t@spall(@psb_c_t@spmat *mh, psb_c_descriptor *cdh);
psb_i_t    @psb_c_t@spall_remote(@psb_c_t@spmat *mh, psb_c_descriptor *cdh);
psb_i_t    @psb_c_t@spasb(@psb_c_t@spmat *mh, psb_c_descriptor *cdh);
psb_i_t    @psb_c_t@spfree(@psb_c_t@spmat *mh, psb_c_descriptor *cdh);
psb_i_t    @psb_c_t@spins(psb_i_t nz, const psb_l_t *irw, const psb_l_t *icl,
			const @psb_t_t@ *val, @psb_c_t@spmat *mh, psb_c_descriptor *cdh);
psb_i_t    @psb_c_t@mat_get_nrows(@psb_c_t@spmat *mh);
psb_i_t    @psb_c_t@mat_get_ncols(@psb_c_t@spmat *mh);
psb_l_t    @psb_c_t@nnz(@psb_c_t@spmat *mh,psb_c_descriptor *cdh);
bool       @psb_c_t@is_matupd(@psb_c_t@spmat *mh,psb_c_descriptor *cdh);
bool       @psb_c_t@is_matasb(@psb_c_t@spmat *mh,psb_c_descriptor *cdh);
bool       @psb_c_t@is_matbld(@psb_c_t@spmat *mh,psb_c_descriptor *cdh);
psb_i_t    @psb_c_t@set_matupd(@psb_c_t@spmat *mh,psb_c_descriptor *cdh);
psb_i_t    @psb_c_t@set_matasb(@psb_c_t@spmat *mh,psb_c_descriptor *cdh);
psb_i_t    @psb_c_t@set_matbld(@psb_c_t@spmat *mh,psb_c_descriptor *cdh);
psb_i_t	   @psb_c_t@copy_mat(@psb_c_t@spmat *ah,@psb_c_t@spmat *bh,psb_c_descriptor *cdh);

/* psb_i_t    @psb_c_t@spasb_opt(@psb_c_t@spmat *mh, psb_c_descriptor *cdh,  */
/* 			const char *afmt, psb_i_t upd, psb_i_t dupl); */
psb_i_t    @psb_c_t@sprn(@psb_c_t@spmat *mh, psb_c_descriptor *cdh, _Bool clear);
psb_i_t    @psb_c_t@mat_name_print(@psb_c_t@spmat *mh, char *name);
psb_i_t	   @psb_c_t@vect_set_scal(@psb_c_t@vector *xh, @psb_t_t@ val);
psb_i_t	   @psb_c_t@vect_set_scal_bound(@psb_c_t@vector *xh, @psb_t_t@ val,
				      psb_i_t ifirst, psb_i_t ilast);
psb_i_t	   @psb_c_t@vect_set_vect(@psb_c_t@vector *xh, @psb_t_t@ *val, psb_i_t n);
@psb_t_t@    @psb_c_t@vect_get_entry(@psb_c_t@vector *xh, psb_i_t index);
psb_i_t    @psb_c_t@vect_set_entry(@psb_c_t@vector *xh, psb_i_t index, @psb_t_t@ val);

/* psblas computational routines */
@psb_t_t@ @psb_c_t@gedot(@psb_c_t@vector *xh, @psb_c_t@vector *yh, psb_c_descriptor *cdh);
@psb_rt_t@ @psb_c_t@genrm2(@psb_c_t@vector *xh, psb_c_descriptor *cdh);
@psb_rt_t@ @psb_c_t@geamax(@psb_c_t@vector *xh, psb_c_descriptor *cdh);
@psb_rt_t@ @psb_c_t@geasum(@psb_c_t@vector *xh, psb_c_descriptor *cdh);
@psb_rt_t@ @psb_c_t@genrmi(@psb_c_t@vector *ah, psb_c_descriptor *cdh);
psb_i_t @psb_c_t@geaxpby(@psb_t_t@ alpha, @psb_c_t@vector *xh,
		       @psb_t_t@ beta, @psb_c_t@vector *yh, psb_c_descriptor *cdh);
psb_i_t @psb_c_t@geaxpbyz(@psb_t_t@ alpha, @psb_c_t@vector *xh,
 		       @psb_t_t@ beta, @psb_c_t@vector *yh, @psb_c_t@vector *zh, psb_c_descriptor *cdh);
psb_i_t @psb_c_t@spmm(@psb_t_t@ alpha, @psb_c_t@spmat *ah, @psb_c_t@vector *xh,
		    @psb_t_t@ beta, @psb_c_t@vector *yh, psb_c_descriptor *cdh);
psb_i_t @psb_c_t@spmm_opt(@psb_t_t@ alpha, @psb_c_t@spmat *ah, @psb_c_t@vector *xh,
			@psb_t_t@ beta, @psb_c_t@vector *yh, psb_c_descriptor *cdh,
			char *trans, bool doswap);
psb_i_t @psb_c_t@spsm(@psb_t_t@ alpha, @psb_c_t@spmat *th, @psb_c_t@vector *xh,
		      @psb_t_t@ beta, @psb_c_t@vector *yh, psb_c_descriptor *cdh);
/* Additional computational routines */
psb_i_t @psb_c_t@gemlt(@psb_c_t@vector *xh,@psb_c_t@vector *yh,psb_c_descriptor *cdh);
psb_i_t @psb_c_t@gemlt2(@psb_t_t@ alpha, @psb_c_t@vector *xh, @psb_c_t@vector *yh, @psb_t_t@ beta, @psb_c_t@vector *zh, psb_c_descriptor *cdh);
psb_i_t @psb_c_t@gediv(@psb_c_t@vector *xh,@psb_c_t@vector *yh,psb_c_descriptor *cdh);
psb_i_t @psb_c_t@gediv_check(@psb_c_t@vector *xh,@psb_c_t@vector *yh,psb_c_descriptor *cdh, bool flag);
psb_i_t @psb_c_t@gediv2(@psb_c_t@vector *xh,@psb_c_t@vector *yh,@psb_c_t@vector *zh,psb_c_descriptor *cdh);
psb_i_t @psb_c_t@gediv2_check(@psb_c_t@vector *xh,@psb_c_t@vector *yh,@psb_c_t@vector *zh,psb_c_descriptor *cdh, bool flag);
psb_i_t @psb_c_t@geinv(@psb_c_t@vector *xh,@psb_c_t@vector *yh,psb_c_descriptor *cdh);
psb_i_t @psb_c_t@geinv_check(@psb_c_t@vector *xh,@psb_c_t@vector *yh,psb_c_descriptor *cdh, bool flag);
psb_i_t @psb_c_t@geabs(@psb_c_t@vector *xh,@psb_c_t@vector *yh, psb_c_descriptor *cdh);
psb_i_t @psb_c_t@gecmp(@psb_c_t@vector *xh,@psb_rt_t@ ch,@psb_c_t@vector *zh,psb_c_descriptor *cdh);
bool    @psb_c_t@gecmpmat(@psb_c_t@spmat *ah,@psb_c_t@spmat *bh,@psb_rt_t@ tol,psb_c_descriptor *cdh);
bool    @psb_c_t@gecmpmat_val(@psb_c_t@spmat *ah,@psb_t_t@ val,@psb_rt_t@ tol,psb_c_descriptor *cdh);
psb_i_t @psb_c_t@geaddconst(@psb_c_t@vector *xh,@psb_t_t@ bh,@psb_c_t@vector *zh,psb_c_descriptor *cdh);
@psb_rt_t@ @psb_c_t@genrm2_weight(@psb_c_t@vector *xh,@psb_c_t@vector *wh,psb_c_descriptor *cdh);
@psb_rt_t@ @psb_c_t@genrm2_weightmask(@psb_c_t@vector *xh,@psb_c_t@vector *wh,@psb_c_t@vector *idvh,psb_c_descriptor *cdh);
psb_i_t @psb_c_t@mask(@psb_c_t@vector *ch,@psb_c_t@vector *xh,@psb_c_t@vector *mh, bool *t, psb_c_descriptor *cdh);
@psb_t_t@ @psb_c_t@gemin(@psb_c_t@vector *xh,psb_c_descriptor *cdh);
@psb_t_t@ @psb_c_t@minquotient(@psb_c_t@vector *xh,@psb_c_t@vector *yh, psb_c_descriptor *cdh);
psb_i_t @psb_c_t@spscal(@psb_t_t@ alpha, @psb_c_t@spmat *ah, psb_c_descriptor *cdh);
psb_i_t @psb_c_t@spscalpid(@psb_t_t@ alpha, @psb_c_t@spmat *ah, psb_c_descriptor *cdh);
psb_i_t @psb_c_t@spaxpby(@psb_t_t@ alpha, @psb_c_t@spmat *ah, @psb_t_t@ beta, @psb_c_t@spmat *bh, psb_c_descriptor *cdh);

#ifdef __cplusplus
}
#endif  /* __cplusplus */

#endif
