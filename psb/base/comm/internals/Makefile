TOP=../../../..
include $(TOP)/Make.inc
BASIC_MODS=
UTIL_MODS =

MODULES=$(BASIC_MODS) $(UTIL_MODS)

SRC=Xswapdata.P90 Xswaptran.P90 Xovrl_restr.p90 Xovrl_save.p90 Xovrl_upd.p90
ESRC=Xswapdata_a.P90 Xswaptran_a.P90 Xovrl_restr_a.p90 Xovrl_save_a.p90 Xovrl_upd_a.p90




FSRC1=$(patsubst %.p90, %.f90, $(subst X, psi_$(ARITH), $(filter %.p90, $(SRC))))
FSRC2=$(patsubst %.P90, %.F90, $(subst X, psi_$(ARITH), $(filter %.P90, $(SRC))))
FSRC=$(FSRC1) $(FSRC2) 

FESRC1=$(patsubst %.p90, %.f90, $(subst X, psi_$(ARITH), $(filter %.p90, $(ESRC))))
FESRC2=$(patsubst %.P90, %.F90, $(subst X, psi_$(ARITH), $(filter %.P90, $(ESRC))))
FESRC=$(FESRC1) $(FESRC2) 


LIBMOD=
# OBJS= $(SFOBJS) $(DFOBJS) $(CFOBJS) $(ZFOBJS)
# SRCS= $(SFSRC) $(DFSRC) $(CFSRC) $(ZFSRC)
LIBDIR=..
CINCLUDES=-I.
FINCLUDES=$(FMFLAG)$(LIBDIR) $(FMFLAG). $(FIFLAG).


src: ssingle sdouble scomplex sdcompl sint

sint:
	$(MAKE) bsrc ARITH=i
	$(MAKE) bsrc ARITH=l
	$(MAKE) esrc ARITH=m
	$(MAKE) esrc ARITH=e
	$(MAKE) esrc ARITH=i2
ssingle:
	$(MAKE) bsrc esrc ARITH=s	
sdouble:
	$(MAKE) bsrc esrc ARITH=d
scomplex:
	$(MAKE) bsrc esrc ARITH=c
sdcompl:
	$(MAKE) bsrc esrc ARITH=z

bsrc:  $(FSRC)
esrc: $(FESRC)

cpy: 
	($(TOP)/cpy.sh $(TOP) $(TARGET)/base/comm/internals *.f90 *.F90)

$(FSRC1): psi_$(ARITH)%.f90 : X%.p90
	sed -f $(TOP)/$(ARITH).sed $< >$@
$(FSRC2): psi_$(ARITH)%.F90 : X%.P90 
	sed -f $(TOP)/$(ARITH).sed $< >$@
$(FESRC1): psi_$(ARITH)%.f90 : X%.p90
	sed -f $(TOP)/$(ARITH).sed $< >$@
$(FESRC2): psi_$(ARITH)%.F90 : X%.P90 
	sed -f $(TOP)/$(ARITH).sed $< >$@

clean:
	/bin/rm -f *.f90 *.F90 


