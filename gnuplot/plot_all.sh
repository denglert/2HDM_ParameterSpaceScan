#!/bin/sh

fig_job_tag=$1
fig_out_tag=$2

gnuplot -e "config=\"../../output/${fig_job_tag}/${fig_out_tag}_gnu.conf\"" ../../gnuplot/ chisq_chisqdiff_brazilian.gp

echo "$PWD"

for x in *.ps; do
	echo $x;
	ps2pdf $x ${x/%ps/pdf};
done
