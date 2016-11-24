#!/bin/bash

# Load variables from global.conf
source global.conf

###########################################################################

##########################
# - Internal variables - #
##########################

INPUT=${PARAM_PTS_TABLE}
OUTPUTBASE=param_pts_list_split_
FILENAME_LIST=${PARAM_PTS_FILENAME_LIST}

nStartLine=2
nSuffixLength=3

# Get number of lines
nLines=$(wc -l < ${INPUT})
nPts=$( echo "scale = 10; ($nLines - 1)" |bc )
nSplitLines=$( echo "scale = 10; ${nPts} / ${nJOBS} " |bc )
nSplitLines=$( echo "${nSplitLines} / 1 " |bc )
nSplitLines=$(( ${nSplitLines} + 1 ))

echo -e "\n# - split-List.sh - #\n"
echo -e "nLines:      ${nLines}"
echo -e "nPts:        ${nPts}"
echo -e "nJOBS:       ${nJOBS}"
echo -e "nSplitLines: ${nSplitLines}\n"

###########################################################################

# Split PARAM_PTS_LIST into multiple files
tail -n +${nStartLine} ${INPUT} | split -a ${nSuffixLength} -d -l ${nSplitLines} - ${OUTPUTBASE}

# - Create SPLITFILENAMES_LIST file containing the list of splitted files
ls | grep split > ${FILENAME_LIST}

# -a suffix length
# -d numeric suffix
# -l number of lines
# See 'split --help'
