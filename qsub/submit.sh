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
echo -e "qsub output:"

if [ -z ${RESOURCELIST} ]
then
	qsub ./output/${TAG}/${TASK}
else
	qsub -l ${RESOURCELIST} ./output/${TAG}/${TASK}
fi

echo -e ""
