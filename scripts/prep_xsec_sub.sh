#!/bin/sh

# Input
WORKTAG=$1
nSplitLines=$2

WORKDIR="./results/$WORKTAG"

# Base filename of the output
outputbase="output_array_"

# Change into WORKDIR
cd $WORKDIR

#####################
### Merge options ###

awk 'FNR > 1' *formated_allowed.dat > output_combined_big.dat

#####################
### Split options ###

# Length of the suffix
nSuffixLength=3

# Headers
# Start from line no.:
StartLine=1

#####################

#split -a $nSuffixLength -d -l $nSplitLines $inputfile $outputbase
#cat $inputfile | split -a $nSuffixLength -d -l $nSplitLines - $outputbase
tail -n +$StartLine output_combined_big.dat | split -a $nSuffixLength -d -l $nSplitLines - $outputbase
