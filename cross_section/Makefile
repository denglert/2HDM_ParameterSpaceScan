####

com 			= ./com/LHC_custom-cuts.com
topdrawfile = plots.top
output 		= fort.89

##############################################################
LIBDIR = lib

#SRC_CMN = rambo.f alpha.f dhelas_all.f rangen.f initialize.f
#OBJ1 = $(SRC_CMN:.f=.f.o)
#OBJ_CMN = $(addprefix $(LIBDIR)/, $(OBJ1))
#TMP_1 = $(shell find . -name *.f -not -path "./src/*")
#TMP_2 = $(notdir $(TMP_1))
#TMP_3 = $(TMP_2:.f=.f.o)
#TMP_4 = $(addprefix lib/, $(TMP_3))

TMP1 = $(shell find . -name *.f -not -path "./src/*" -not -path "./backup/*" | sed 's/\.f/\.f.o/' | xargs -n 1 basename)
TMP2 = $(addprefix ./lib/,$(TMP1))
OBJ_CMN = $(TMP2) $(TMP_F90_2) ./lib/initialize.f.o 

TMP_F90_1 = $(shell find . -name *.f90 -not -path "./src/*" -not -path "./backup/*" | sed 's/\.f90/\.f90.o/' | xargs -n 1 basename)
TMP_F90_2 = $(addprefix ./lib/,$(TMP_F90_1))

#OBJ_ggZH_BSM = ./lib/Amplitudes.cpp.o ./lib/ggZstarH_BSM.f.o ./lib/gg_ZH_BSM.f.o $(OBJ_CMN) ./lib/squarecontribution.F90.o 
OBJ_ggZH_BSM = ./lib/Amplitudes.cpp.o ./lib/ggZstarH_BSM.f.o ./lib/gg_ZH_BSM.f.o $(OBJ_CMN) ./lib/squarecontributionfuture.F90.o ./lib/squarecontribution.F90.o 
OBJ_qqZH_BSM = ./lib/qqZstarH_BSM.f.o ./lib/qq_ZH_BSM.f.o $(OBJ_CMN)
OBJ_test_random = ./lib/test_random.f.o $(OBJ_CMN)

#################################################

#FLFLAGS = 
FLFLAGS = -lstdc++ $(ROOTLFLAGS) $(LOOPTOOLSLFLAGS)
FCFLAGS = -c $(LOOPTOOLSCFLAGS)
F77     = gfortran


#################################################

CC     = g++
#CC     = icc

CCFLAGS = -I./inc/ -MMD -MF .depend_cpp $(LOOPTOOLSCFLAGS)
CLFLAGS = $(ROOTLFLAGS) $(LOOPTOOLSLFLAGS)

# ROOT flags can also be set to environment variables
ROOTCFLAGS = `root-config --cflags`
#ROOTLFLAGS = -L/home/de3u14/lib/build/hep/root/lib -lCore -lCint -lRIO -lNet -lHist -lGraf -lGraf3d -lGpad -lTree -lRint -lPostscript -lMatrix -lPhysics -lMathCore -lThread -limf -lm -ldl
ROOTLFLAGS = -L/home/de3u14/lib/build/hep/root/lib -lCore -lCint -lRIO -lNet -lHist -lGraf -lGraf3d -lGpad -lTree -lRint -lPostscript -lMatrix -lPhysics -lMathCore -lThread -lm -ldl

LOOPTOOLSCFLAGS = -I/home/de3u14/lib/build/hep/Feyn/LoopTools/LoopTools-2.13/x86_64-Linux/include
LOOPTOOLSLFLAGS = -L/home/de3u14/lib/build/hep/Feyn/LoopTools/LoopTools-2.13/x86_64-Linux/lib64 -looptools

####################################################
# This is where Makefile tries to look for src files
VPATH = src:rambo:DHELAS:alpha_QCD:CTEQ5:random

all : ggZH_BSM qqZH_BSM test_random

run_com : 
	@echo "-n"
	@echo "Input com file: $(com)"
	@cat $(com)
	@echo "-n"
	ggZH_BSM < $(com)
	mv $(output) $(topdrawfile)

figure :
	./td -b -d postscr $(topdrawfile)
	ps2pdf plots.ps plots.pdf

ggZH_BSM: $(OBJ_ggZH_BSM)
	$(F77) -o $@ $^ $(FLFLAGS) 

qqZH_BSM: $(OBJ_qqZH_BSM)
	$(F77) -o $@ $(FLFLAGS) $^

test_random: $(OBJ_test_random)
	$(F77) -o $@ $(FLFLAGS) $^

### General compilation rule for .f sources

./lib/%.f.o : %.f 
	$(F77) $(FCFLAGS) $< -o $@ 

./lib/%.f90.o : %.f90 
	$(F77) $(FCFLAGS) $< -o $@ 

./lib/%.F90.o : %.F90 
	$(F77) $(FCFLAGS) $< -o $@ 

### General compilation rule for .cpp sources
./lib/%.cpp.o : %.cpp
	$(CC) $(ROOTCFLAGS) $(CCFLAGS) -c $< -o $@

test :
	echo "$(TMP1)"
	echo "$(TMP2)"
	echo "$(OBJ_CMN)"
