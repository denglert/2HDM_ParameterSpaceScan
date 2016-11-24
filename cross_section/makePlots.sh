#!/bin/sh

#file="benchmarklist_smeared_0.01"
#file="benchmarklist_generator"
#file="benchmarklist_test"
#file="benchmarklist_BSM_qqZH_ggZH_withoutbox"
#file="benchmarklist_qqZH_ggZH_nobox"
#file="benchmarklist_qqZH_ggZH_withbox"
#file="benchmarklist_SM_qqZH_ggZH_withbox_run2"
file="benchmarklist_SM_qqZH_ggZH_triangle_only_largestat"
#GNUBIN="/home/de3u14/lib/build/gnuplot/gnuplot-5.0.3/bin/gnuplot"
GNUBIN="/home/de3u14/lib/build/gnuplot/gnuplot-5.0.3/bin/gnuplot"

while read basename
do
	echo -e "Plotting: $basename"
 	$GNUBIN -e "basename='$basename'" plotspectra.gnu
#	$GNUBIN -e "basename='$basename'" plotspectra_SM.gnu
done <$file
