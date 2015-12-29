#!/bin/sh

echo -e "format_data.sh running"

INPUT=chisquare_table.dat
OUTPUT_BASE=${form_dat_out_tag}
OUTPUT_CHI=${form_dat_out_tag}_chisq.dat
OUTPUT_CHIDIFF=${form_dat_out_tag}_chisqdiff.dat
OUTPUT_MIN=${form_dat_out_tag}_chisqmin.dat

# Step 1
# Create filtered text with coloumns sorted
# output: out_filtered.tmp

awk \
	-v form_dat_filterval1="$form_dat_filterval1" -v form_dat_filterval2="$form_dat_filterval2" -v form_dat_filterval3="$form_dat_filterval3" -v form_dat_filterval4="$form_dat_filterval4" -v form_dat_filterval5="$form_dat_filterval5" \
	-v form_dat_filterfield1="$form_dat_filterfield1" -v form_dat_filterfield2="$form_dat_filterfield2" -v form_dat_filterfield3="$form_dat_filterfield3" -v form_dat_filterfield4="$form_dat_filterfield4" -v form_dat_filterfield5="$form_dat_filterfield5" \
	 'NR>1 && ($form_dat_filterfield1 == form_dat_filterval1) && ($form_dat_filterfield2 == form_dat_filterval2) && ($form_dat_filterfield3 = form_dat_filterval3) && ($form_dat_filterfield4 == form_dat_filterval4) && ($form_dat_filterfield5 == form_dat_filterval5)' \
	${INPUT} | sort -gk${form_dat_XVar} -gk${form_dat_YVar} > out_filtered.tmp

# Step 3
# insert blank lines
# output: OUTPUT_MIN

../../awk/findmin.awk out_filtered.tmp > $OUTPUT_MIN

# Step 4
# strip unnecessary coloumns
# output: out_filtered_stripped

../../awk/stripfield.awk -v field_X="$form_dat_XVar" -v field_Y="$form_dat_YVar" -v field_Z="8" out_filtered.tmp > out_filtered_stripped.tmp


# Step 5
# insert blank lines
# output: OUTPUT_CHI

../../awk/insertblanklines.awk out_filtered_stripped.tmp > $OUTPUT_CHI

# Step 6
# Subtract minimum
# output: OUTPUT_CHIDIFF

awk '{ if ($0!="") {print $1, $2, ($3-min)} else {print }; }' $OUTPUT_CHI > $OUTPUT_CHIDIFF



