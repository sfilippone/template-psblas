TOP=../../..
include $(TOP)/Make.inc

src: scg sspmv sswapdata

scg:
	cd cg && $(MAKE) src
sspmv:
	cd spmv && $(MAKE) src
sswapdata:
	cd swapdata && $(MAKE) src

cpy:
	cd cg && $(MAKE) cpy
	cd spmv && $(MAKE) cpy
	cd swapdata && $(MAKE) cpy

clean: ccg cspmv cswapdata

ccg:
	cd cg && $(MAKE) clean
cspmv:
	cd spmv && $(MAKE) clean
cswapdata:
	cd swapdata && $(MAKE) clean
