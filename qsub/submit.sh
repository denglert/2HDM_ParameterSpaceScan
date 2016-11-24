#!/bin/sh
# Submit job to qsub
# Look at ./Makefile

echo -e ""
echo -e "###############################"
echo -e "### --- Job information --- ###"
echo -e "###############################"
echo -e ""
echo -e "Resource specification: $RESOURCELIST"
echo -e "Task: $TASK"
echo -e "Tag: $TAG"
echo -e "Config: $CONFIG"
echo -e "LHA: $WRITELHA"
echo -e ""
echo -e "qsub results:"

if [ -z ${RESOURCELIST} ]
then
	qsub ./results/${TAG}/${TASK}
else
	qsub -l ${RESOURCELIST} ./results/${TAG}/${TASK}
fi

echo -e ""
