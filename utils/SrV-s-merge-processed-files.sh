#!/bin/bash

# Load variables from global.conf
cd     ${WORK_DIR}/results/${TAG}
source global.conf

###########################################################################

# Get list of processed files
FILES=$(find . -name "*processed*" | sort)

# Merge them
cat ${FILES} > ${OUTPUT_BIG_TABLE_ALLINFO}
