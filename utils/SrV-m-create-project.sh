#!/bin/bash

##########################################################################
### - This bash script creates a new project for 2HDM parameter scan - ###
##########################################################################

# -  Input environment variables (need to be defined before calling this script):
#    - TAG
#    - CONFIG 
#    - WRITELHA
#    - nJOBS
#    - yukawa_TYPE

###############################################

# - Variables - #

# Paths
ROOT_DIR=/home/de3u14/lib/projects/2HDM/2HDM_ParameterSpaceScan # - Root directory          (int. var)
BACKUP_DIR=./backup                                             # - Backup directory path   (int. var)
RESULTS_DIR=results                                           # - Result directory name   (int. var)

# Config files
PARAM_PTS_CONFIG_PATH=${ROOT_DIR}/config/${CONFIG}              # - Parameter space configuration (input)
GLOBAL_CONFIG=./global.conf                                     # - Global configuration file     (output)

# Utility scripts
PARAM_PTS_GEN=${ROOT_DIR}/utils/SrV-s-create-param-list.sh  # - Parameter pts generator       (utility)
PARAM_PTS_SPLIT=${ROOT_DIR}/utils/SrV-s-split-param-list.sh # - Split script                  (utility)

# Job script
JOB_SCRIPT=${ROOT_DIR}/tasks/SrV-job-task-template.sh   # - job script                        (utility)

# Output file
PARAM_PTS_TABLE=param_pts_table.dat                      # - Table of the parameter points           (output)
PARAM_PTS_FILENAME_LIST=param_pts_filenames.list         # - List of splitted filenames              (output)
OUTPUT_BIG_TABLE_ALLINFO=param_pts_big_table_allinfo.dat # - Table of the processed parameter points (output)

###############################################


echo -e ""
echo -e "###############################"
echo -e "### - SrV project creator - ###"
echo -e "###############################"
echo -e ""
echo -e "Working directory: ${WORK_DIR}";

# - If variable 'TAG' tag is unset, then exit shell.
# - This is a protection for unset TAG, in order not to wipe out ./results directory.

if [ -z ${TAG+x} ]; then

	echo -e "\nVariable TAG is unset. Please specify TAG variable.";
	exit -1

else 

	# - If ./results/${TAG} already exists then make a backup
	if [ -d ${WORK_DIR}/${RESULTS_DIR}/${TAG} ]; then
		echo "";
		echo "There is already a ./results/${TAG}. Making a copy to ./backup, overwriting ./backup/${TAG}";
		mkdir -p ${WORK_DIR}/${BACKUP_DIR}
		cp -rf ${WORK_DIR}/${RESULTS_DIR}/${TAG}/ ${WORK_DIR}/${BACKUP_DIR}/${TAG}/;
		rm -rf ${WORK_DIR}/${RESULTS_DIR}/${TAG};
	fi

	###########################################
	### - Normal behaviour of this script - ###
	###########################################

	# - Creating new directory structure - #
	echo -e "\nCreating new project directory ${WORK_DIR}/${RESULTS_DIR}/${TAG}.\n";

	mkdir -p ${WORK_DIR}/${RESULTS_DIR}/${TAG}/jobs/;
	mkdir -p ${WORK_DIR}/${RESULTS_DIR}/${TAG}/figures/cross-section;
	mkdir -p ${WORK_DIR}/${RESULTS_DIR}/${TAG}/figures/spectrum;
	mkdir -p ${WORK_DIR}/${RESULTS_DIR}/${TAG}/figures/paramspace;
	mkdir -p ${WORK_DIR}/${RESULTS_DIR}/${TAG}/LHA/;

	# - Change directory - #
	cd ${WORK_DIR}/results/${TAG}/

	# - Create the GLOBAL_CONFIG from the parameter space config file - #
	cp ${PARAM_PTS_CONFIG_PATH} ${GLOBAL_CONFIG}

	# Source variables
	source ${GLOBAL_CONFIG}

	# - Append these variables to GLOBAL_CONFIG - #
	echo -e ""                                                   >> ${GLOBAL_CONFIG}
	echo -e "# Project variables"                                >> ${GLOBAL_CONFIG}
	echo -e "TAG=${TAG}"                                         >> ${GLOBAL_CONFIG}
	echo -e "WORK_DIR=${WORK_DIR}"                               >> ${GLOBAL_CONFIG}
	echo -e "BINARY=${BINARY}"                                   >> ${GLOBAL_CONFIG}
	echo -e "WRITELHA=${WRITELHA}"                               >> ${GLOBAL_CONFIG}
	echo -e "PARAM_PTS_TABLE=${PARAM_PTS_TABLE}"                 >> ${GLOBAL_CONFIG}
	echo -e "PARAM_PTS_FILENAME_LIST=${PARAM_PTS_FILENAME_LIST}" >> ${GLOBAL_CONFIG}
	echo -e "nJOBS=${nJOBS}"                                     >> ${GLOBAL_CONFIG}
	echo -e "yukawa_TYPE=${yukawa_TYPE}"                         >> ${GLOBAL_CONFIG}
	echo -e "JOB_SCRIPT=${JOB_SCRIPT}"                           >> ${GLOBAL_CONFIG}
	echo -e "JOB_RESRCLIST=${JOB_RESRCLIST}"                     >> ${GLOBAL_CONFIG}
	echo -e "ROOT_DIR=${ROOT_DIR}"                               >> ${GLOBAL_CONFIG}
	echo -e "OUTPUT_BIG_TABLE_ALLINFO=${OUTPUT_BIG_TABLE_ALLINFO}"                     >> ${GLOBAL_CONFIG}

	# - Call parameter list generator - #
	${PARAM_PTS_GEN}

	# - Split the parameter list into multiple files - #
	${PARAM_PTS_SPLIT}

	# - End message - #
	echo -e "The new project >>> ${TAG} <<< is created.\n"

fi


# mkdir -p
# no error if existing, make parent directories as needed
