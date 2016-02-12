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
source ~/lib/build/hep/root/bin/thisroot.sh
module load gsl

###############################

PROGBIN=../../bin/ParameterScan_RB
file_param_chisq=output/$TAG/chisquare_table.dat

# Clear up and make directories
rm -rf output/$TAG
mkdir output/$TAG
cd output/$TAG

$PROGBIN
