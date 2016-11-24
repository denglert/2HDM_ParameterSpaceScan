#!/bin/bash

# - Load variables from global.conf
cd     ${WORK_DIR}/results/${TAG}
source global.conf

PtsPerJob=$( echo "scale = 10; (${nPoints} / ${nJOBS}) " |bc )

echo -e "### - Contents of global.conf - ###\n"
cat global.conf
echo -e "### - End of contents - ###\n"

echo -e "Number of parameter space points: ${nPoints}"
echo -e "Number of jobs:                   ${nJOBS}"
echo -e "Number of points/per:             ${PtsPerJob}"

# - List contents of the directory
echo -e "### - Directory contents - ###\n"
ls -l -h
