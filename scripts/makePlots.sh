#!/bin/sh

file="benchmarklist"

while read basename
do
	echo -e "Plotting: $basename"
	gnuplot -e "basename='$basename'" plotspectra.gnu
done <$file
