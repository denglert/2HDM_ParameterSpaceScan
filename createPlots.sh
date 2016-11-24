#!/bin/bash

for mA in $(seq 150 10 250)
do
	echo "mA = $mA"
	make SrV-format-data SrV_format_data_mA=$mA;
	make SrV-plot-data SrV_format_data_mA=$mA;
done
