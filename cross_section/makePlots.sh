#!/bin/sh

#file="benchmarklist_smeared_0.01"
#file="benchmarklist_generator"
#file="benchmarklist_test"
#file="benchmarklist_qqZH_ggZH_nobox"
file="benchmarklist_qqZH_ggZH_withbox"
GNUBIN="/home/de3u14/lib/build/gnuplot/gnuplot-5.0.3/bin/gnuplot"

while read basename
do
	echo -e "Plotting: $basename"
	$GNUBIN -e "basename='$basename'" plotspectra.gnu
done <$file
