#!/bin/sh

tag=test

SinBAMin=-0.999
SinBAMax=0.999
nSinBABins=31

TanBMin=0.01
TanBMax=10.0
nTanBBins=21

########################

PROGBIN=./PhaseSpaceScan
file_param_chisq=output_param_chisq/$tag.dat

rm -rf output_LHA/$tag
mkdir output_LHA/$tag


rm -rf $file_param_chisq
#mkdir output_param_chisq/$tag

SinBABinWidth=$( echo "scale = 10; ($SinBAMax - $SinBAMin)/$nSinBABins" |bc )
TanBBinWidth=$( echo "scale = 10; ($TanBMax - $TanBMin)/$nTanBBins" |bc )

echo "SinBAMin: $SinBAMin"
echo "SinBAMax: $SinBAMax"
echo "SinBABinWidth: $SinBABinWidth"

echo "TanBMin: $TanBMin"
echo "TanBMax: $TanBMax"
echo "TanBBinWidth: $TanBBinWidth"

for (( iSinBA=0; iSinBA < ${nSinBABins}; iSinBA++))
do

	for (( iTanB=0; iTanB < ${nTanBBins}; iTanB++))
	do

 	  SinBA=$( echo "scale = 10; ($SinBAMin + ($iSinBA*$SinBABinWidth))" |bc )
		TanB=$( echo "scale = 10; ($TanBMin + ($iTanB*$TanBBinWidth))" |bc )

		echo "SinBA: $SinBA"
		echo "TanB: $TanB"

	$PROGBIN $tag $SinBA $TanB

	done

	echo "" >> $file_param_chisq

done
