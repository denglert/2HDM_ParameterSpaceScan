#!/bin/sh


gnuplot ../../gnuplot/exclusion_RB.gnu

### Convert .ps to .pdf if .pdf.
for x in *.ps; do
	echo "Converting $x";
		ps2pdf $x ${x/%ps/pdf};
done

# Compress the pdf-s
tar -cvf "${fig_job_tag}_pdfs.tar" *.pdf
gzip ${fig_job_tag}_pdfs.tar

### Convert .ps to .pdf if .pdf doesn't exist.
#for x in *.ps; do
#	if [ -f ${x/%ps/pdf} ];
#	then
#		echo "${x/%ps/pdf} already exists";
#	else
#	echo "Converting $x";
#		ps2pdf $x ${x/%ps/pdf};
#	fi
#done
