#!/bin/sh

#####################
### Configuration ###

# Variables 'TAG', 'CONFIG' and 'WRITELHA' need to be set.

#TAG="job_Z4_Z5_Z7_cba_tb"
#CONFIG="ParamSpace_Z4_Z5_Z7_cba_tb.config"
#WRITELHA=0

##################################
### Setting up the environment ###

WORKDIR=/home/de3u14/lib/projects/2HDM/2HDM_ParameterSpaceScan/
cd $WORKDIR
source ./config/$CONFIG
source ~/lib/build/hep/root/bin/thisroot.sh
module load gsl

###############################

PROGBIN=./bin/ParameterScan_Hybrid_MultiDim
file_param_chisq=output/$TAG/chisquare_table.dat

# Clear up and make directories
rm -rf output/$TAG
mkdir output/$TAG
mkdir output/$TAG/LHA

# Make copy of the .config file
cp ./config/$CONFIG ./output/$TAG/


# Make header for the .dat file
# mh mH cba tb, Z4, Z5, Z7, chisq, tot_hbobs, stability, unitarity,
# perturbativity, mA, GammaA, Gammah 
echo "mh mH cba tb Z4 Z5 Z7 chisq tot_hbobs stb uni per mA Gamma_h Gamma_A mHc l6 l7 m12_2 S T U V W X " > $file_param_chisq

# Division by zero test
if [ $nmhBins -eq 1 ]; then
mhBinWidth=0
else
mhBinWidth=$( echo "scale = 10; ($mhMax - $mhMin)/($nmhBins-1)" |bc )
fi

if [ $nmHBins -eq 1 ]; then
mHBinWidth=0
else
mHBinWidth=$( echo "scale = 10; ($mHMax - $mHMin)/($nmHBins-1)" |bc )
fi

CosBABinWidth=$( echo "scale = 10; ($CosBAMax - $CosBAMin)/($nCosBABins-1)" |bc )
TanBBinWidth=$( echo "scale = 10; ($TanBMax - $TanBMin)/($nTanBBins-1)" |bc )

if [ $nZ4Bins -eq 1 ]; then
Z4BinWidth=0
else
Z4BinWidth=$( echo "scale = 10; ($Z4Max - $Z4Min)/($nZ4Bins-1)" |bc )
fi

if [ $nZ5Bins -eq 1 ]; then
Z5BinWidth=0
else
Z5BinWidth=$( echo "scale = 10; ($Z5Max - $Z5Min)/($nZ5Bins-1)" |bc )
fi

if [ $nZ7Bins -eq 1 ]; then
Z7BinWidth=0
else
Z7BinWidth=$( echo "scale = 10; ($Z7Max - $Z7Min)/($nZ7Bins-1)" |bc )
fi

# Print out the parameters to stdout
echo "mhMin: $mhMin"
echo "mhMax: $mhMax"
echo "mhBinWidth: $mhBinWidth"

echo "mHMin: $mHMin"
echo "mHMax: $mHMax"
echo "mHBinWidth: $mHBinWidth"

echo "CosBAMin: $CosBAMin"
echo "CosBAMax: $CosBAMax"
echo "CosBABinWidth: $CosBABinWidth"

echo "TanBMin: $TanBMin"
echo "TanBMax: $TanBMax"
echo "TanBBinWidth: $TanBBinWidth"

echo "Z4Min: $Z4Min"
echo "Z4Max: $Z4Max"
echo "Z4BinWidth: $Z4BinWidth"

echo "Z5Min: $Z5Min"
echo "Z5Max: $Z5Max"
echo "Z5BinWidth: $Z5BinWidth"

echo "Z7Min: $Z7Min"
echo "Z7Max: $Z7Max"
echo "Z7BinWidth: $Z7BinWidth"

echo -e "\nBefore start of Loop"

####################################
# Loops for scanning parameter space

for (( imh=0; imh < ${nmhBins}; imh++))
do

for (( imH=0; imH < ${nmHBins}; imH++))
do

for (( iCosBA=0; iCosBA < ${nCosBABins}; iCosBA++))
do

for (( iTanB=0; iTanB < ${nTanBBins}; iTanB++))
do

for (( iZ4=0; iZ4 < ${nZ4Bins}; iZ4++))
do

for (( iZ5=0; iZ5 < ${nZ5Bins}; iZ5++))
do

for (( iZ7=0; iZ7 < ${nZ7Bins}; iZ7++))
do

 	     mh=$( echo "scale = 10; ($mhMin + ($imh*$mhBinWidth))" |bc )
 	     mH=$( echo "scale = 10; ($mHMin + ($imH*$mHBinWidth))" |bc )
 	  CosBA=$( echo "scale = 10; ($CosBAMin + ($iCosBA*$CosBABinWidth))" |bc )
		TanB=$( echo "scale = 10; ($TanBMin + ($iTanB*$TanBBinWidth))" |bc )
		  Z4=$( echo "scale = 10; ($Z4Min + ($iZ4*$Z4BinWidth))" |bc )
		  Z5=$( echo "scale = 10; ($Z5Min + ($iZ5*$Z5BinWidth))" |bc )
		  Z7=$( echo "scale = 10; ($Z7Min + ($iZ7*$Z7BinWidth))" |bc )

	echo "mh: $mh"
	echo "mH: $mH"
	echo "CosBA: $CosBA"
	echo "TanB: $TanB"
	echo "Z4: $Z4"
	echo "Z5: $Z5"
	echo "Z7: $Z7"

	echo -e "$PROGBIN $TAG $WRITELHA $mh $mH $CosBA $TanB $Z4 $Z5 $Z7 $ytype"
	$PROGBIN $TAG $WRITELHA $mh $mH $CosBA $TanB $Z4 $Z5 $Z7 $ytype

done
done
done
done
done
done
done
