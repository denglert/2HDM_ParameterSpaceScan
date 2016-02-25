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
module load gsl

###############################

PROGBIN=../../bin/ParameterScan_Hybrid_MultiDim
file_param_chisq=./chisquare_table.dat

# Clear up and make directories
if [ -d ./results/$TAG ]; then cp -f ./results/$TAG ./backup/$TAG; fi;
rm -rf results/$TAG
mkdir results/$TAG
mkdir results/$TAG/LHA
mkdir results/$TAG/figures
mkdir results/$TAG/figures/cross-section
mkdir results/$TAG/figures/paramspace

# Make copy of the .config file
cp ./config/$CONFIG ./results/$TAG/

# Change into working directory
cd ./results/$TAG

# Load variables
source ./$CONFIG
source ~/lib/build/hep/root/bin/thisroot.sh

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

if [ $nCosBABins -eq 1 ]; then
	CosBABinWidth=0
else
	CosBABinWidth=$( echo "scale = 10; ($CosBAMax - $CosBAMin)/($nCosBABins-1)" |bc )
fi


if [ $nTanBBins -eq 1 ]; then
	TanBBinWidth=0
else
	TanBBinWidth=$( echo "scale = 10; ($TanBMax - $TanBMin)/($nTanBBins-1)" |bc )
fi

if [ $nmABins -eq 1 ]; then
	mABinWidth=0
else
	mABinWidth=$( echo "scale = 10; ($mAMax - $mAMin)/($nmABins-1)" |bc )
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

echo "mAMin: $mAMin"
echo "mAMax: $mAMax"
echo "mABinWidth: $mABinWidth"

echo "Z7Min: $Z7Min"
echo "Z7Max: $Z7Max"
echo "Z7BinWidth: $Z7BinWidth"

#######################
# Numerical constants

vev=246.2206 # GeV

echo -e "\nBefore start of Loop"

####################################
# Loops for scanning parameter space

for (( imh=0; imh < ${nmhBins}; imh++))
do

for (( imH=0; imH < ${nmHBins}; imH++))
do

for (( imA=0; imA < ${nmABins}; imA++))
do

for (( iCosBA=0; iCosBA < ${nCosBABins}; iCosBA++))
do

for (( iTanB=0; iTanB < ${nTanBBins}; iTanB++))
do

for (( iZ7=0; iZ7 < ${nZ7Bins}; iZ7++))
do

		  # Assigning actual values
 	     mh=$( echo "scale = 10; ($mhMin + ($imh*$mhBinWidth))" |bc )
 	     mH=$( echo "scale = 10; ($mHMin + ($imH*$mHBinWidth))" |bc )
 	  CosBA=$( echo "scale = 10; ($CosBAMin + ($iCosBA*$CosBABinWidth))" |bc )
		TanB=$( echo "scale = 10; ($TanBMin + ($iTanB*$TanBBinWidth))" |bc )
		  mA=$( echo "scale = 10; ($mAMin + ($imA*$mABinWidth))" |bc )
		  Z7=$( echo "scale = 10; ($Z7Min + ($iZ7*$Z7BinWidth))" |bc )

		  # Auxiliary variables
		  echo "Calculating auxiliary variables"
		  Beta=$( echo "scale = 10; a($TanB)" |bc -l)
		  Tan2B=$( echo "scale = 10; (s(2*$Beta)/c(2*$Beta))" |bc -l)
		  SinBA=$( echo "scale = 10; sqrt(1 - $CosBA*$CosBA)" |bc -l)
		  CosBA2=$( echo "scale = 10; $CosBA*$CosBA" |bc )
		  SinBA2=$( echo "scale = 10; $SinBA*$SinBA" |bc )
		  Z6=$( echo "scale = 10; (${mh}*${mh} - ${mH}*${mH})*$SinBA*$CosBA/$vev/$vev" |bc )

		  # Calculate Z5
		  echo "Calculating Z5 & Z7"
		  Z4=$( echo "scale = 10; ($mA*$mA/$vev/$vev) - ($mH*$mH/$vev/$vev) - ($CosBA2*($mH*$mH - $mh*$mh)/$vev/$vev)" |bc )
		  Z5=$( echo "scale = 10; (2*${CosBA2}*(${mh}*${mh} - ${mH}*${mH})/$vev/$vev) - $Z4" |bc )
#	  Z7=$( echo "scale = 10; ($Z6 + 2*(${mH}*${mH}*${SinBA2} + ${mh}*${mh}*$CosBA2)/$Tan2B/$vev/$vev)" |bc )

	echo "Variables:"
	echo "mh: $mh"
	echo "mH: $mH"
	echo "mA: $mA"
	echo "CosBA: $CosBA"
	echo "SinBA: $SinBA"
	echo "TanB: $TanB"
	echo "Z4: $Z4"
	echo "Z5: $Z5"
	echo "Z6: $Z6"
	echo "Z7: $Z7"

	echo -e "$PROGBIN $TAG $WRITELHA $mh $mH $CosBA $TanB $Z4 $Z5 $Z7 $ytype"
	$PROGBIN $TAG $WRITELHA $mh $mH $CosBA $TanB $Z4 $Z5 $Z7 $ytype

done
done
done
done
done
done
