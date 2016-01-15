#!/bin/sh

#####################
### Configuration ###

# Variables 'TAG', 'CONFIG' and 'WRITELHA' need to be set.

#TAG="job_mA_mHc_Z7_cba_tb"
#CONFIG="ParamSpace_mA_mHc_Z7_cba_tb.config"
#WRITELHA=0

##################################
### Setting up the environment ###

WORKDIR=/home/de3u14/lib/projects/2HDM/2HDM_ParameterSpaceScan/
cd $WORKDIR
source ./config/$CONFIG
source ~/lib/build/hep/root/bin/thisroot.sh
module load gsl

###############################

PROGBIN=./bin/ParameterScan_Physical_MultiDim
file_param_chisq=output/$TAG/chisquare_table.dat

# Clear up and make directories
rm -rf output/$TAG
mkdir output/$TAG
mkdir output/$TAG/LHA

# Make copy of the .config file
cp ./config/$CONFIG ./output/$TAG/


# Make header for the .dat file
# mh mH cba tb, mA, mHc, Z7, chisq, tot_hbobs, stability, unitarity,
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

if [ $nmABins -eq 1 ]; then
mABinWidth=0
else
mABinWidth=$( echo "scale = 10; ($mAMax - $mAMin)/($nmABins-1)" |bc )
fi

if [ $nmHcBins -eq 1 ]; then
mHcBinWidth=0
else
mHcBinWidth=$( echo "scale = 10; ($mHcMax - $mHcMin)/($nmHcBins-1)" |bc )
fi

SinBABinWidth=$( echo "scale = 10; ($SinBAMax - $SinBAMin)/($nSinBABins-1)" |bc )
TanBBinWidth=$( echo "scale = 10; ($TanBMax - $TanBMin)/($nTanBBins-1)" |bc )

if [ $nl6Bins -eq 1 ]; then
l6BinWidth=0
else
l6BinWidth=$( echo "scale = 10; ($l6Max - $l6Min)/($nl6Bins-1)" |bc )
fi

if [ $nl7Bins -eq 1 ]; then
l7BinWidth=0
else
l7BinWidth=$( echo "scale = 10; ($l7Max - $l7Min)/($nl7Bins-1)" |bc )
fi

if [ $nm12_2Bins -eq 1 ]; then
m12_2BinWidth=0
else
m12_2BinWidth=$( echo "scale = 10; ($m12_2Max - $m12_2Min)/($nm12_2Bins-1)" |bc )
fi

# Print out the parameters to stdout
echo "mhMin: $mhMin"
echo "mhMax: $mhMax"
echo "mhBinWidth: $mhBinWidth"

echo "mHMin: $mHMin"
echo "mHMax: $mHMax"
echo "mHBinWidth: $mHBinWidth"

echo "SinBAMin: $SinBAMin"
echo "SinBAMax: $SinBAMax"
echo "SinBABinWidth: $SinBABinWidth"

echo "TanBMin: $TanBMin"
echo "TanBMax: $TanBMax"
echo "TanBBinWidth: $TanBBinWidth"

echo "mAMin: $mAMin"
echo "mAMax: $mAMax"
echo "mABinWidth: $mABinWidth"

echo "mHcMin: $mHcMin"
echo "mHcMax: $mHcMax"
echo "mHcBinWidth: $mHcBinWidth"

echo "l6Min: $l6Min"
echo "l6Max: $l6Max"
echo "l6BinWidth: $l6BinWidth"

echo "l7Min: $l7Min"
echo "l7Max: $l7Max"
echo "l7BinWidth: $l7BinWidth"

echo "m12_2Min: $m12_2Min"
echo "m12_2Max: $m12_2Max"
echo "m12_2BinWidth: $m12_2BinWidth"

echo -e "\nBefore start of Loop"

####################################
# Loops for scanning parameter space

for (( imh=0; imh < ${nmhBins}; imh++))
do

for (( imH=0; imH < ${nmHBins}; imH++))
do

for (( iSinBA=0; iSinBA < ${nSinBABins}; iSinBA++))
do

for (( iTanB=0; iTanB < ${nTanBBins}; iTanB++))
do

for (( imA=0; imA < ${nmABins}; imA++))
do

for (( imHc=0; imHc < ${nmHcBins}; imHc++))
do

for (( il6=0; il6 < ${nl6Bins}; il6++))
do

for (( il7=0; il7 < ${nl7Bins}; il7++))
do

for (( im12_2=0; im12_2 < ${nm12_2Bins}; im12_2++))
do

 	     mh=$( echo "scale = 10; ($mhMin + ($imh*$mhBinWidth))" |bc )
 	     mH=$( echo "scale = 10; ($mHMin + ($imH*$mHBinWidth))" |bc )
	  	  mA=$( echo "scale = 10; ($mAMin + ($imA*$mABinWidth))" |bc )
		 mHc=$( echo "scale = 10; ($mHcMin + ($imHc*$mHcBinWidth))" |bc )
 	  SinBA=$( echo "scale = 10; ($SinBAMin + ($iSinBA*$SinBABinWidth))" |bc )
		TanB=$( echo "scale = 10; ($TanBMin + ($iTanB*$TanBBinWidth))" |bc )
		  l6=$( echo "scale = 10; ($l6Min + ($il6*$l6BinWidth))" |bc )
		  l7=$( echo "scale = 10; ($l7Min + ($il7*$l7BinWidth))" |bc )
	  m12_2=$( echo "scale = 10; ($m12_2Min + ($im12_2*$m12_2BinWidth))" |bc )

	echo "mh: $mh"
	echo "mH: $mH"
	echo "mA: $mA"
	echo "mHc: $mHc"
	echo "SinBA: $SinBA"
	echo "TanB: $TanB"
	echo "l6: $l6"
	echo "l7: $l7"
	echo "m12_2: $m12_2"

	echo -e "$PROGBIN $TAG $WRITELHA $mh $mH $mA $mHc $SinBA $TanB $l6 $l7 $m12_2 $ytype"
	$PROGBIN $TAG $WRITELHA $mh $mH $mA $mHc $SinBA $TanB $l6 $l7 $m12_2 $ytype

done
done
done
done
done
done
done
done
done
