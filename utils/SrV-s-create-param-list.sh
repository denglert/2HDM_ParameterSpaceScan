#!/bin/bash

# Load variables from global.conf
source global.conf

###########################################################################

##########################
# - Internal variables - #
##########################

# Numerical constants
vev=246.2206 # GeV

###########################################################################

# Number of parameter space points
nPoints=$(( ${nmhBins} * ${nmHBins} * ${nmHcBins} * ${nmABins} * ${nCosBABins} * ${nTanBBins} * ${nZ7Bins} ))
echo -e "nPoints=${nPoints}"                                 >> global.conf

# - Division by zero test - #
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

if [ $nmHcBins -eq 1 ]; then
mHcBinWidth=0
else
mHcBinWidth=$( echo "scale = 10; ($mHcMax - $mHcMin)/($nmHcBins-1)" |bc )
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
# - Division by zero test - #

# - Print the parameters to stdout - #
echo "### - Using the following config file:"
echo "      $CONFIG"
echo ""
echo "Number of parameter space points: ${nPoints}"
echo ""
echo "mhMin: $mhMin"
echo "mhMax: $mhMax"
echo "mhBinWidth: $mhBinWidth"

echo "mHMin: $mHMin"
echo "mHMax: $mHMax"
echo "mHBinWidth: $mHBinWidth"

echo "mHcMin: $mHcMin"
echo "mHcMax: $mHcMax"
echo "mHcBinWidth: $mHcBinWidth"

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
echo ""
# - Print the parameters to stdout - #


#####################################
# - Make header for the PARAM_PTS_TABLE
# - Header:
# - mh mH cba tb Z4 Z5 Z7

echo "mh mH cba tb Z4 Z5 Z7" > ${PARAM_PTS_TABLE}

##########################################
# - Loops for creating parameter space - #
##########################################

for (( imh=0; imh < ${nmhBins}; imh++))
do

for (( imH=0; imH < ${nmHBins}; imH++))
do

for (( imHc=0; imHc < ${nmHcBins}; imHc++))
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
 	    mHc=$( echo "scale = 10; ($mHcMin + ($imHc*$mHcBinWidth))" |bc )
 	  CosBA=$( echo "scale = 10; ($CosBAMin + ($iCosBA*$CosBABinWidth))" |bc )
		TanB=$( echo "scale = 10; ($TanBMin + ($iTanB*$TanBBinWidth))" |bc )
		  mA=$( echo "scale = 10; ($mAMin + ($imA*$mABinWidth))" |bc )
		  Z7=$( echo "scale = 10; ($Z7Min + ($iZ7*$Z7BinWidth))" |bc )

		  # Auxiliary variables
		  #echo "Calculating auxiliary variables"
		  Beta=$( echo "scale = 10; a($TanB)" |bc -l)
		  Tan2B=$( echo "scale = 10; (s(2*$Beta)/c(2*$Beta))" |bc -l)
		  SinBA=$( echo "scale = 10; sqrt(1 - $CosBA*$CosBA)" |bc -l)
		  CosBA2=$( echo "scale = 10; $CosBA*$CosBA" |bc )
		  SinBA2=$( echo "scale = 10; $SinBA*$SinBA" |bc )
      # Z6=$( echo "scale = 10; (${mh}*${mh} - ${mH}*${mH})*$SinBA*$CosBA/$vev/$vev" |bc )

		  # Calculate Z5 & Z4
		  #echo "Calculating Z5 & Z4"
		  Z5=$( echo "scale = 10; ( ${mh}*${mh}*${CosBA2} + ${mH}*${mH}*${SinBA2} - ${mA}*${mA})/${vev}/${vev}" |bc )
		  Z4=$( echo "scale = 10; 2*( ${mA}*${mA} - ${mHc}*${mHc} )/(${vev}*${vev}) + ${Z5}" |bc )
		# Z7=$( echo "scale = 10; ($Z6 + 2*(${mH}*${mH}*${SinBA2} + ${mh}*${mh}*$CosBA2)/$Tan2B/$vev/$vev)" |bc )

	echo -e "$mh $mH $CosBA $TanB $Z4 $Z5 $Z7" >> ${PARAM_PTS_TABLE}

done
done
done
done
done
done
done


echo -e "${PARAM_PTS_TABLE} is created.\n" # Message
