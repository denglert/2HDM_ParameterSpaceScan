#!/bin/bash

cd ${fig_work_dir}/results/${fig_tag}/figures/paramspace  # - Change to working directory
source ../../global.conf                                   # - Source all global variables

# - gnuplot versions
GNUPLOT=/home/de3u14/lib/build/gnuplot/gnuplot-5.0.3/bin/gnuplot
#GNUPLOT=gnuplot

GNUPLOT_SCRIPT=${fig_gnuplot_script}

$GNUPLOT -e "config=\"../../${fig_out_label}_gnu.conf\"" ${ROOT_DIR}/gnuplot/${GNUPLOT_SCRIPT}
