#!/bin/bash

cd ${format_data_work_dir}/results/${format_data_tag}/  # - Change to working directory
source global.conf                                      # - Source all global variables
source ${ROOT_DIR}/masks/${format_data_mask}            # - Source mask variables

#${ROOT_DIR}/utils/format_data.sh;
#echo $(EXPORT_FORM_DAT) | tr " " "\n" | awk 'NF > 0' | sort > $(form_dat_out_tag).config

echo -e "format_data.sh running"

#INPUT=chisquare_table.dat
INPUT=${OUTPUT_BIG_TABLE_ALLINFO}
OUTPUT_BASE=${format_data_out_label}
OUTPUT_DAT=${format_data_out_label}_formatted.dat
OUTPUT_ALLOWED_DAT=${format_data_out_label}_formatted_allowed.dat
OUTPUT_MIN=${format_data_out_label}_chisqmin.dat
OUTPUT_GNUPLOT=${format_data_out_label}_gnu.conf
OPTION=${format_data_option}

# Format of the 'paramspace_table.dat'
# Note: Please check whether the format has been updated recently.
# cba_in sba tb_in Z4_in Z5_in Z7_in m12_2 l1 l2 l3 l4 l5 l6 l7 mh_in mH_in mHc mA gh gH gHc gA stb uni per S T U V W X drho damu chisq tot_hbobs" > $file_paramspace_table

##########################################################

# Create filtered text with coloumns sorted
# Option: 1 - default
# Option: 2 - not yet set
# Output: out_filtered.tmp

#echo "format_data_filterfield5: ${format_data_filterfield5}"
#echo "format_data_filterval5:   ${format_data_filterval5}"
echo "Option: ${OPTION}"
echo -e "WORK_DIR: ${format_data_work_dir}"
echo -e "Job tag: ${format_data_tag}"
echo -e "format_data label: ${format_data_out_label}"
echo -e "Input: ${INPUT}"
echo -e "Filter field number: ${format_data_filterfield1} value: ${format_data_filterval1}"
echo -e "Filter field number: ${format_data_filterfield2} value: ${format_data_filterval2}"
echo -e "Filter field number: ${format_data_filterfield3} value: ${format_data_filterval3}"
echo -e "Filter field number: ${format_data_filterfield4} value: ${format_data_filterval4}"
echo -e "Filter field number: ${format_data_filterfield5} value: ${format_data_filterval5}"
echo -e "ChiSqFieldNo: $ChiSqFieldNo"


if [ $OPTION -eq 1 ]
then
awk \
	-v tolerance=2.0\
	-v format_data_filterval1="$format_data_filterval1" -v format_data_filterval2="$format_data_filterval2" -v format_data_filterval3="$format_data_filterval3" -v format_data_filterval4="$format_data_filterval4" -v format_data_filterval5="$format_data_filterval5" \
	-v format_data_filterfield1="$format_data_filterfield1" -v format_data_filterfield2="$format_data_filterfield2" -v format_data_filterfield3="$format_data_filterfield3" -v format_data_filterfield4="$format_data_filterfield4" -v format_data_filterfield5="$format_data_filterfield5" \
	'NR>1 && ($format_data_filterfield1 == format_data_filterval1) && ($format_data_filterfield2 == format_data_filterval2) && ($format_data_filterfield3 == format_data_filterval3) && (($format_data_filterfield4 - format_data_filterval4) < tolerance) && ((format_data_filterval4 - $format_data_filterfield4 ) < tolerance) && (($format_data_filterfield5 - format_data_filterval5) < tolerance) && ((format_data_filterval5 - $format_data_filterfield5 ) < tolerance)' \
	${INPUT} | sort -gk${format_data_XVar} -gk${format_data_YVar} > out_filtered.tmp
fi

# Find minimum
# output: OUTPUT_MIN

${ROOT_DIR}/awk/findmin.awk -v field="$ChiSqFieldNo" out_filtered.tmp > ${OUTPUT_MIN}
min=$(awk -v field="$ChiSqFieldNo" '{val = $field} END{printf("%.4f", val)}' ${OUTPUT_MIN})

echo -e "Minimum chisq value: $min"

# strip unnecessary coloumns
# output: out_filtered_stripped
#${ROOT_DIR}/awk/stripfield.awk -v field_X="$format_data_XVar" -v field_Y="$format_data_YVar" -v field_Z="8" out_filtered.tmp > out_filtered_stripped.tmp
#awk -v min=$min '{ if ($0!="") {print $1, $2, ($3-min)} else {print }; }' $OUTPUT_CHI > $OUTPUT_CHIDIFF

# Append subtracted coloumn
# output: OUTPUT_CHIDIFF

${ROOT_DIR}/awk/append_diff.awk -v field="$ChiSqFieldNo" -v val="$min" out_filtered.tmp > out_filtered_appended.tmp

# insert blank lines
# output: OUTPUT_CHI

${ROOT_DIR}/awk/insertblanklines.awk -v field="$format_data_XVar" out_filtered_appended.tmp > $OUTPUT_DAT

# Get allowed region
# output: OUTPUT_CHI

${ROOT_DIR}/awk/getallowed.awk $OUTPUT_DAT > $OUTPUT_ALLOWED_DAT

# Make headers

header="$(head -n1 ${INPUT})"
header=$(echo "$header" |sed 's/[[:space:]]\+/ /g')
header=$(echo "$header chisqdiff")

sed -i "1s/.*/$header/" $OUTPUT_DAT
sed -i "1s/.*/$header/" $OUTPUT_ALLOWED_DAT

#sed -i "1s/.*/${FIELD[${format_data_XVar}]} ${FIELD[${format_data_YVar}]} chisq /" $OUTPUT_CHI
#sed -i "1s/.*/${FIELD[${format_data_XVar}]} ${FIELD[${format_data_YVar}]} chisqdiff /" $OUTPUT_CHIDIFF

# Make gnuplot config file

rm -f ${OUTPUT_GNUPLOT}
touch ${OUTPUT_GNUPLOT}

#echo "folderPATH = \"${ROOT_DIR}/results/${format_data_job_tag}/\"" >> $OUTPUT_GNUPLOT
echo "folderPATH = \"${format_data_work_dir}/results/${format_data_tag}/\"" >> $OUTPUT_GNUPLOT
echo "formLABEL = \"${format_data_out_label}\"" >> $OUTPUT_GNUPLOT

echo "infobox_line1 = \"${label[${format_data_filterfield1}]}\"" >> $OUTPUT_GNUPLOT
echo "infobox_line2 = \"${label[${format_data_filterfield2}]}\"" >> $OUTPUT_GNUPLOT
echo "infobox_line3 = \"${label[${format_data_filterfield3}]}\"" >> $OUTPUT_GNUPLOT
echo "infobox_line4 = \"${label[${format_data_filterfield4}]}\"" >> $OUTPUT_GNUPLOT
echo "infobox_line5 = \"${label[${format_data_filterfield5}]}\"" >> $OUTPUT_GNUPLOT

echo "infobox_val1 = ${format_data_filterval1}" >> $OUTPUT_GNUPLOT
echo "infobox_val2 = ${format_data_filterval2}" >> $OUTPUT_GNUPLOT
echo "infobox_val3 = ${format_data_filterval3}" >> $OUTPUT_GNUPLOT
echo "infobox_val4 = ${format_data_filterval4}" >> $OUTPUT_GNUPLOT
echo "infobox_val5 = ${format_data_filterval5}" >> $OUTPUT_GNUPLOT

echo "xlab = \"${axis_label[${format_data_XVar}]}\"" >> $OUTPUT_GNUPLOT
echo "ylab = \"${axis_label[${format_data_YVar}]}\"" >> $OUTPUT_GNUPLOT

echo "XVar = ${format_data_XVar}" >> $OUTPUT_GNUPLOT
echo "YVar = ${format_data_YVar}" >> $OUTPUT_GNUPLOT
