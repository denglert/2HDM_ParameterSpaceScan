#!/bin/bash

# Load variables from global.conf
cd     ${WORK_DIR}/results/${TAG}
source global.conf

###########################################################################

it=0

echo -e "TAG:           ${TAG}"
echo -e "JOB_SCRIPT:    ${JOB_SCRIPT}"
echo -e "JOB_RESRCLIST: ${JOB_RESRCLIST}"

while read f; do
	echo -e "Submitting job #${it} - file: ${f}"

	# Create job dir
	mkdir -p ./jobs/job_${it}
	mv ${f} ./jobs/job_${it}

	if [ -z ${JOB_RESRCLIST} ]
	then
		qsub -v "TAG=${TAG}, INPUT=${f}, LABEL=${it}, WORK_DIR=${WORK_DIR}" ${JOB_SCRIPT}
	else
		qsub -l ${JOB_RESRCLIST} -v "TAG=${TAG}, INPUT=${f}, LABEL=${it}, WORK_DIR=${WORK_DIR}" ${JOB_SCRIPT}
	fi

	it=$(( it + 1 ))
done < ${PARAM_PTS_FILENAME_LIST}


echo -e "All jobs should be submitted - check the output of qstat below."
echo -e ""
echo -e "qstat:"
qstat
