#!/bin/bash

echo -e "format_data.sh running"

#INPUT=chisquare_table.dat
#INPUT=paramspace_table.dat
INPUT=param_pts_processed_0.dat
OUTPUT_BASE=${form_dat_out_tag}
OUTPUT_DAT=${form_dat_out_tag}_formated.dat
OUTPUT_ALLOWED_DAT=${form_dat_out_tag}_formated_allowed.dat
OUTPUT_MIN=${form_dat_out_tag}_chisqmin.dat
OUTPUT_GNUPLOT=${form_dat_out_tag}_gnu.conf
OPTION=${form_dat_opt}


# Format of the 'paramspace_table.dat'
# Note: Please check whether the format has been updated recently.
# cba_in sba tb_in Z4_in Z5_in Z7_in m12_2 l1 l2 l3 l4 l5 l6 l7 mh_in mH_in mHc mA gh gH gHc gA stb uni per S T U V W X drho damu chisq tot_hbobs" > $file_paramspace_table

#
ChiSqFieldNo=41

# Field keynames
FIELD[1]="cba"
FIELD[3]="tb"
FIELD[15]="mh"
FIELD[16]="mH"
FIELD[4]="Z4"
FIELD[5]="Z5"
FIELD[6]="Z7"
FIELD[41]="chisq"

# Info sidebar
label[1]="cos({/Symbol b}-{/Symbol a}) = %.2f"
label[1]="sin({/Symbol b}-{/Symbol a}) = %.2f"
label[3]="tan({/Symbol b}) = %.2f"
label[4]="Z4 = %.2f"
label[5]="Z5 = %.2f"
label[6]="Z7 = %.2f"
label[7]="m_{12}^{2} = %.2f"
label[8]="{/Symbol l}_{1} = %.2f"
label[9]="{/Symbol l}_{2} = %.2f"
label[15]="m_{h} = %.2f GeV/c^{2}"
label[16]="m_{H} = %.2f GeV/c^{2}"
label[17]="m_{H^{+/-}} = %.2f GeV/c^{2}"
label[18]="m_{A} = %.2f GeV/c^{2}"

# Axis labels
axis_label[1]="cos({/Symbol b}-{/Symbol a})"
axis_label[3]="tan({/Symbol b})"
axis_label[4]="Z4"
axis_label[5]="Z5"
axis_label[6]="Z7"
axis_label[15]="m_{h} [GeV/c^{2}]"
axis_label[16]="m_{H} [GeV/c^{2}]"

##########################################################

# Create filtered text with coloumns sorted
# Option: 1 - default
# Option: 2 - not yet set
# Output: out_filtered.tmp

#echo "form_dat_filterfield5: ${form_dat_filterfield5}"
#echo "form_dat_filterval5:   ${form_dat_filterval5}"
echo "Option: ${OPTION}"

if [ $OPTION -eq 1 ]
then
awk \
	-v tolerance=2.0\
	-v form_dat_filterval1="$form_dat_filterval1" -v form_dat_filterval2="$form_dat_filterval2" -v form_dat_filterval3="$form_dat_filterval3" -v form_dat_filterval4="$form_dat_filterval4" -v form_dat_filterval5="$form_dat_filterval5" \
	-v form_dat_filterfield1="$form_dat_filterfield1" -v form_dat_filterfield2="$form_dat_filterfield2" -v form_dat_filterfield3="$form_dat_filterfield3" -v form_dat_filterfield4="$form_dat_filterfield4" -v form_dat_filterfield5="$form_dat_filterfield5" \
	'NR>1 && ($form_dat_filterfield1 == form_dat_filterval1) && ($form_dat_filterfield2 == form_dat_filterval2) && ($form_dat_filterfield3 == form_dat_filterval3) && (($form_dat_filterfield4 - form_dat_filterval4) < tolerance) && ((form_dat_filterval4 - $form_dat_filterfield4 ) < tolerance) && (($form_dat_filterfield5 - form_dat_filterval5) < tolerance) && ((form_dat_filterval5 - $form_dat_filterfield5 ) < tolerance)' \
	${INPUT} | sort -gk${form_dat_XVar} -gk${form_dat_YVar} > out_filtered.tmp
fi

# Find minimum
# output: OUTPUT_MIN

../../awk/findmin.awk -v field="$ChiSqFieldNo" out_filtered.tmp > $OUTPUT_MIN
min=$(awk -v field="$ChiSqFieldNo" '{val = $field} END{printf("%.4f", val)}' $OUTPUT_MIN)

echo -e "Minimum chisq value: $min"

# strip unnecessary coloumns
# output: out_filtered_stripped
#../../awk/stripfield.awk -v field_X="$form_dat_XVar" -v field_Y="$form_dat_YVar" -v field_Z="8" out_filtered.tmp > out_filtered_stripped.tmp
#awk -v min=$min '{ if ($0!="") {print $1, $2, ($3-min)} else {print }; }' $OUTPUT_CHI > $OUTPUT_CHIDIFF

# Append subtracted coloumn
# output: OUTPUT_CHIDIFF

../../awk/append_diff.awk -v field="$ChiSqFieldNo" -v val="$min" out_filtered.tmp > out_filtered_appended.tmp

# insert blank lines
# output: OUTPUT_CHI

../../awk/insertblanklines.awk -v field="$form_dat_XVar" out_filtered_appended.tmp > $OUTPUT_DAT

# Get allowed region
# output: OUTPUT_CHI

../../awk/getallowed.awk $OUTPUT_DAT > $OUTPUT_ALLOWED_DAT

# Make headers

header="$(head -n1 ${INPUT})"
header=$(echo "$header" |sed 's/[[:space:]]\+/ /g')
header=$(echo "$header chisqdiff")

sed -i "1s/.*/$header/" $OUTPUT_DAT
sed -i "1s/.*/$header/" $OUTPUT_ALLOWED_DAT

#sed -i "1s/.*/${FIELD[${form_dat_XVar}]} ${FIELD[${form_dat_YVar}]} chisq /" $OUTPUT_CHI
#sed -i "1s/.*/${FIELD[${form_dat_XVar}]} ${FIELD[${form_dat_YVar}]} chisqdiff /" $OUTPUT_CHIDIFF

# Make gnuplot config file

rm -f ${OUTPUT_GNUPLOT}
touch ${OUTPUT_GNUPLOT}

#echo "folderPATH = \"../../results/${form_dat_job_tag}/\"" >> $OUTPUT_GNUPLOT
echo "folderPATH = \"../../\"" >> $OUTPUT_GNUPLOT
echo "formTAG = \"${form_dat_out_tag}\"" >> $OUTPUT_GNUPLOT

echo "infobox_line1 = \"${label[${form_dat_filterfield1}]}\"" >> $OUTPUT_GNUPLOT
echo "infobox_line2 = \"${label[${form_dat_filterfield2}]}\"" >> $OUTPUT_GNUPLOT
echo "infobox_line3 = \"${label[${form_dat_filterfield3}]}\"" >> $OUTPUT_GNUPLOT
echo "infobox_line4 = \"${label[${form_dat_filterfield4}]}\"" >> $OUTPUT_GNUPLOT
echo "infobox_line5 = \"${label[${form_dat_filterfield5}]}\"" >> $OUTPUT_GNUPLOT

echo "infobox_val1 = ${form_dat_filterval1}" >> $OUTPUT_GNUPLOT
echo "infobox_val2 = ${form_dat_filterval2}" >> $OUTPUT_GNUPLOT
echo "infobox_val3 = ${form_dat_filterval3}" >> $OUTPUT_GNUPLOT
echo "infobox_val4 = ${form_dat_filterval4}" >> $OUTPUT_GNUPLOT
echo "infobox_val5 = ${form_dat_filterval5}" >> $OUTPUT_GNUPLOT

echo "xlab = \"${axis_label[${form_dat_XVar}]}\"" >> $OUTPUT_GNUPLOT
echo "ylab = \"${axis_label[${form_dat_YVar}]}\"" >> $OUTPUT_GNUPLOT

echo "XVar = ${form_dat_XVar}" >> $OUTPUT_GNUPLOT
echo "YVar = ${form_dat_YVar}" >> $OUTPUT_GNUPLOT
