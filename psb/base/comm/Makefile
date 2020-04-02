TOP=../../..
include $(TOP)/Make.inc
BASIC_MODS=
UTIL_MODS =

MODULES=$(BASIC_MODS) $(UTIL_MODS)

SRC=Xhalo.p90 Xovrl.p90 Xspgather.P90 Xscatter.P90 Xgather.p90
ESRC=Xhalo_a.p90 Xovrl_a.p90  Xscatter_a.P90 Xgather_a.p90



FSRC1=$(patsubst %.p90, %.f90, $(subst X, psb_$(ARITH), $(filter %.p90, $(SRC))))
FSRC2=$(patsubst %.P90, %.F90, $(subst X, psb_$(ARITH), $(filter %.P90, $(SRC))))
FSRC=$(FSRC1) $(FSRC2) 
FESRC1=$(patsubst %.p90, %.f90, $(subst X, psb_$(ARITH), $(filter %.p90, $(ESRC))))
FESRC2=$(patsubst %.P90, %.F90, $(subst X, psb_$(ARITH), $(filter %.P90, $(ESRC))))
FESRC=$(FESRC1) $(FESRC2) 

LIBMOD=
# OBJS= $(SFOBJS) $(DFOBJS) $(CFOBJS) $(ZFOBJS)
# SRCS= $(SFSRC) $(DFSRC) $(CFSRC) $(ZFSRC)
LIBDIR=..
CINCLUDES=-I.
FINCLUDES=$(FMFLAG)$(LIBDIR) $(FMFLAG). $(FIFLAG).


src: ssingle sdouble scomplex sdcompl sint sinternals
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

bsrc: $(FSRC)
esrc: $(FESRC)

lib: $(FOBJS)

sinternals:
	cd internals && $(MAKE) src

cpy: 
	($(TOP)/cpy.sh $(TOP) $(TARGET)/base/comm *.f90 *.F90)
	cd internals && $(MAKE) cpy

$(FSRC1): psb_$(ARITH)%.f90 : X%.p90
	sed -f $(TOP)/$(ARITH).sed $< >$@
$(FSRC2): psb_$(ARITH)%.F90 : X%.P90 
	sed -f $(TOP)/$(ARITH).sed $< >$@
$(FESRC1): psb_$(ARITH)%.f90 : X%.p90
	sed -f $(TOP)/$(ARITH).sed $< >$@
$(FESRC2): psb_$(ARITH)%.F90 : X%.P90 
	sed -f $(TOP)/$(ARITH).sed $< >$@

clean:
	cd internals && $(MAKE) clean
	/bin/rm -f *.f90 *.F90 *.o 


