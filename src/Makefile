
OBJ_ParameterScan_Physical_MultiDim = ../lib/ParameterScan_Physical_MultiDim.cpp.o
OBJ_ParameterScan_Hybrid_MultiDim = ../lib/ParameterScan_Hybrid_MultiDim.cpp.o
OBJ_ParameterScan_Hybrid_General = ../lib/ParameterScan_Hybrid_General.cpp.o
OBJ_ParameterScan_Hybrid_EWPO = ../lib/ParameterScan_Hybrid_EWPO.cpp.o
OBJ_ParameterScan_RB = ../lib/ParameterScan_RB.f.o

CMN =

binaries : ../bin/ParameterScan_Hybrid_General \
		     ../bin/ParameterScan_Hybrid_EWPO \
		     ../bin/ParameterScan_Hybrid_MultiDim \
			  ../bin/ParameterScan_Physical_MultiDim  \
			  ../bin/ParameterScan_RB

#######

#LINKER = ifort
LINKER = g++

#../bin/ParameterScan: $(OBJ_ParameterScan)
#ifeq ($(LINKER),ifort)
#	$(FC) -o $@ $^ $(FLFLAGS) 
#endif
#ifeq ($(LINKER),g++)
#	$(CC) $^ $(CLFLAGS) -o $@  
#endif

../bin/ParameterScan_Hybrid_EWPO: $(OBJ_ParameterScan_Hybrid_EWPO)
ifeq ($(LINKER),ifort)
	$(FC) -o $@ $^ $(FLFLAGS) 
endif
ifeq ($(LINKER),g++)
	$(CC) $^ $(CLFLAGS_2HDMCSTANDALONE) -o $@
endif

../bin/ParameterScan_Hybrid_General: $(OBJ_ParameterScan_Hybrid_General)
ifeq ($(LINKER),ifort)
	$(FC) -o $@ $^ $(FLFLAGS) 
endif
ifeq ($(LINKER),g++)
	$(CC) $^ $(CLFLAGS) -o $@
endif

../bin/ParameterScan_Hybrid_MultiDim: $(OBJ_ParameterScan_Hybrid_MultiDim)
ifeq ($(LINKER),ifort)
	$(FC) -o $@ $^ $(FLFLAGS) 
endif
ifeq ($(LINKER),g++)
	$(CC) $^ $(CLFLAGS) -o $@
endif

../bin/ParameterScan_Physical_MultiDim: $(OBJ_ParameterScan_Physical_MultiDim)
ifeq ($(LINKER),ifort)
	$(FC) -o $@ $^ $(FLFLAGS) 
endif
ifeq ($(LINKER),g++)
	$(CC) $^ $(CLFLAGS) -o $@
endif

../bin/ParameterScan_RB: $(OBJ_ParameterScan_RB)
	$(FC) -o $@ $^

####################
## -- Linking -- ###
####################

LIBDIRLINK = $(HOME)/lib/links/libs
INCDIRLINK = $(HOME)/lib/links/inc

####################
## -- Fortran -- ###
####################

FC    = gfortran
#FC     = ifort

FCFLAGS = -c

#FLFLAGS = -cxxlib -nofor_main -\#
FLFLAGS = -cxxlib -nofor_main $(ROOTLFLAGS)

../lib/%.f.o : %.f
	$(FC) $(FCFLAGS) $< -o $@ 

#################
### -- C++ -- ###
#################

CC     = g++
#CC     = icc

CLFLAGS_2HDMCSTANDALONE = $(ROOTLFLAGS) -L$(LIBDIRLINK) -l2HDMC_standalone -L/local/software/gsl/1.15/lib -lgsl -lgslcblas -lgfortran
#CLFLAGS_2HDMCSTANDALONE = $(ROOTLFLAGS) -L$(LIBDIRLINK) -l2HDMC -L/local/software/gsl/1.15/lib -lgsl -lgslcblas -lgfortran

CCFLAGS = -I../inc/ -I$(INCDIRLINK) $(ROOTCFLAGS) $(2HDMCCFLAGS) -MMD -MF .depend_cpp
CLFLAGS = $(ROOTLFLAGS) $(2HDMCLFLAGS) $(HB_HS_LFLAGS)

# 2HDMC
2HDMCCFLAGS = -I/local/software/gsl/1.15/include -DHiggsBounds
2HDMCLFLAGS = -L$(LIBDIRLINK) -l2HDMC_withHBHS -L/local/software/gsl/1.15/lib -lgsl -lgslcblas -lgfortran

# HiggsBounds/HiggsSignals
#HB_HS_LFLAGS = -L$(LIBDIRLINK) -lHB -lHS
HB_HS_LFLAGS = -L$(LIBDIRLINK) -lHB-4.3.1 -lHS
#HB_HS_LFLAGS = -L$(LIBDIRLINK) -lHB-4.2.1 -lHS

#../lib/ParameterScan_Hybrid_EWPO.cpp.o : ParameterScan_Hybrid_EWPO.cpp
#	$(CC) -I../inc/ -I$(INCDIRLINK) $(ROOTCFLAGS) -I/local/software/gsl/1.15/include -MMD -MF .depend_cpp -c $< -o $@

# ROOT
ROOTCFLAGS = `root-config --cflags`
ROOTLFLAGS = -L/home/de3u14/lib/build/hep/ROOT/build/root_v5.34.36/lib/root -lCore -lCint -lRIO -lNet -lHist -lGraf -lGraf3d -lGpad -lTree -lRint -lPostscript -lMatrix -lPhysics -lMathCore -lThread -lm -ldl

### General compilation rule for .cpp sources
../lib/%.cpp.o : %.cpp
	$(CC) $(CCFLAGS) -c $< -o $@

include .depend_cpp
