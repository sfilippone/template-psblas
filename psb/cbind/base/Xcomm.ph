#ifndef @PSB_C_T@COMM_
#define @PSB_C_T@COMM_
#include "@psb_c_t@base.h"

#ifdef __cplusplus
extern "C" {
#endif

  psb_i_t       @psb_c_t@halo(@psb_c_t@vector *xh, psb_c_descriptor *cdh);
  psb_i_t       @psb_c_t@halo_opt(@psb_c_t@vector *xh, psb_c_descriptor *cdh,
				char *trans, psb_i_t mode);
  psb_i_t       @psb_c_t@ovrl(@psb_c_t@vector *xh, psb_c_descriptor *cdh);
  psb_i_t       @psb_c_t@ovrl_opt(@psb_c_t@vector *xh, psb_c_descriptor *cdh,
				psb_i_t update, psb_i_t mode);
  psb_i_t       @psb_c_t@vscatter(psb_l_t ng, psb_c_t *gx, @psb_c_t@vector *xh,
				psb_c_descriptor *cdh);

  @psb_t_t@*      @psb_c_t@vgather(@psb_c_t@vector *xh, psb_c_descriptor *cdh);
  @psb_c_t@spmat* @psb_c_t@spgather(@psb_c_t@spmat *ah, psb_c_descriptor *cdh);
  
  psb_i_t       @psb_c_t@vgather_f(@psb_t_t@* gv, @psb_c_t@vector *xh, psb_c_descriptor *cdh);
  psb_i_t       @psb_c_t@spgather_f(@psb_c_t@spmat* ga, @psb_c_t@spmat *ah,
				  psb_c_descriptor *cdh);


#ifdef __cplusplus
}
#endif  /* __cplusplus */

#endif
