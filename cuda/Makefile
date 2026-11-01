TOP=..
include $(TOP)/Make.inc
BASIC_MODS=
UTIL_MODS =

MODULES=$(BASIC_MODS) $(UTIL_MODS)

psbSRC= X_cuda_csrg_mat_mod.P90 X_cuda_elg_mat_mod.P90 \
     X_cuda_vect_mod.P90 X_cuda_hlg_mat_mod.P90 \
     X_cuda_hybg_mat_mod.P90 X_cuda_diag_mat_mod.P90 \
     X_cuda_hdiag_mat_mod.P90 X_cuda_dnsg_mat_mod.P90 \
     X_vectordev_mod.P90

cusSRC=X_cusparse_mod.P90

psbFSRC1=$(patsubst %.p90, %.f90, $(subst X, psb_$(ARITH), $(filter %.p90, $(psbSRC))))
psbFSRC2=$(patsubst %.P90, %.F90, $(subst X, psb_$(ARITH), $(filter %.P90, $(psbSRC))))
psbFSRC=$(psbFSRC1) $(psbFSRC2)

psbFOBJS1=$(psbFSRC1:.f90=.o)
psbFOBJS2=$(psbFSRC2:.F90=.o)

cusSRC2=$(patsubst %.P90, %.F90, $(subst X, $(ARITH), $(filter %.P90, $(cusSRC))))
cusFSRC=$(cusSRC2)
cusOBJS2=$(cusSRC2:.F90=.o)


FOBJS=$(psbFOBJS1) $(psbFOBJS2) $(cusOBJS2)

LIBMOD=
# OBJS= $(SFOBJS) $(DFOBJS) $(CFOBJS) $(ZFOBJS)
# SRCS= $(SFSRC) $(DFSRC) $(CFSRC) $(ZFSRC)
LIBDIR=..
CINCLUDES=-I.
FINCLUDES=$(FMFLAG)$(LIBDIR) $(FMFLAG). $(FIFLAG).


src: ssingle sdouble scomplex sdcompl sint simpl
sint:
	$(MAKE) bsrc ARITH=i
ssingle:
	$(MAKE) bsrc ARITH=s
	$(MAKE) csrc ARITH=s
sdouble:
	$(MAKE) bsrc ARITH=d
	$(MAKE) csrc ARITH=d
scomplex:
	$(MAKE) bsrc ARITH=c
	$(MAKE) csrc ARITH=c
sdcompl:
	$(MAKE) bsrc ARITH=z
	$(MAKE) csrc ARITH=z


simpl:
	cd impl && $(MAKE) src

iclean:
	cd impl && $(MAKE) clean



all:  single double 

single:
	$(MAKE) lib ARITH=s
double:
	$(MAKE) lib ARITH=d
complex:
	$(MAKE) lib ARITH=c
dcompl:
	$(MAKE) lib ARITH=z


bsrc: $(psbFSRC)
csrc: $(cusFSRC)

lib: $(FOBJS)

cpy: 
	($(TOP)/cpy.sh $(TOP) $(TARGET)/cuda *.f90 *.F90 *.h)
	cd impl && $(MAKE) cpy

$(psbFSRC1): psb_$(ARITH)%.f90 : X%.p90
	sed -f $(TOP)/$(ARITH).sed $< >$@
$(psbFSRC2): psb_$(ARITH)%.F90 : X%.P90 
	sed -f $(TOP)/$(ARITH).sed $< >$@
$(cusFSRC): $(ARITH)%.F90 : X%.P90
	sed -f $(TOP)/$(ARITH).sed $< >$@

clean: iclean
	/bin/rm -f *.f90 *.F90 *.o

