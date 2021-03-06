#!/bin/sh

input=benchmark.pts
BINARY=../../cross_section/ggZH_BSM

######################
### --- Config --- ###
######################

sqrts="13.0d3"
icut=1
ptcut="20.d0"
etacut="2.5d0"
rmcut="2.5d0"
ncall=7500000
#ncall=750000
itmax=5
acc=-1.d0
iseed=987654321

#################

cbafld=3
tbfld=4
mAfld=13
gammaAfld=15
mHcfld=16
mhfld=1
mHfld=2
Z4fld=5
Z5fld=6
Z7fld=7

#################

label[13]="m_{A} = %.2f GeV/c^{2}"
label[15]="{/Symbol G}_{A} = %.3f GeV"
label[3]="cos({/Symbol b}-{/Symbol a}) = %.2f"
label[4]="tan({/Symbol b}) = %.2f"
label[2]="m_{H} = %.2f GeV/c^{2}"
label[16]="m_{H^{+/-}} = %.2f GeV/c^{2}"
label[1]="m_{h} = %.2f GeV/c^{2}"
label[5]="Z4 = %.2f"
label[6]="Z5 = %.2f"
label[7]="Z7 = %.2f"

#################
nLines=$(wc -l < $input)

rm -f benchmarklist

for (( i=2; i<=$nLines; i++ ))
do

#		  IsEmpty=$(awk -v line="$i" '{if((NR==line) && (NF==0)) print 1; else if (NR==line)) print 0;}' $input )
#	echo "$IsEmpty"
#	if [ $IsEmpty == 1 ]
#	then
#		echo "Empty line"
#		continue
#	fi

		 cbaval=$(awk -v line="$i" -v    field="$cbafld" '{if(NR==line) print $field}' $input )
	    tbval=$(awk -v line="$i" -v      field="$tbfld" '{if(NR==line) print $field}' $input )
	    mAval=$(awk -v line="$i" -v      field="$mAfld" '{if(NR==line) print $field}' $input )
	    mhval=$(awk -v line="$i" -v      field="$mhfld" '{if(NR==line) print $field}' $input )
	    mHval=$(awk -v line="$i" -v      field="$mHfld" '{if(NR==line) print $field}' $input )
	   mHcval=$(awk -v line="$i" -v      field="$mHcfld" '{if(NR==line) print $field}' $input )
	gammaAval=$(awk -v line="$i" -v  field="$gammaAfld" '{if(NR==line) print $field}' $input )
	    Z4val=$(awk -v line="$i" -v  field="$Z4fld" '{if(NR==line) print $field}' $input )
	    Z5val=$(awk -v line="$i" -v  field="$Z5fld" '{if(NR==line) print $field}' $input )
	    Z7val=$(awk -v line="$i" -v  field="$Z7fld" '{if(NR==line) print $field}' $input )

 	basename="benchmark_mA_${mAval}_cba_${cbaval}_tb_${tbval}"
 	gnuconf="${basename}_gnu.conf"
 	rm -f $gnuconf

	echo "infobox_line1  = \"${label[13]}\"" >> $gnuconf
	echo "infobox_line2  = \"${label[15]}\"" >> $gnuconf
	echo "infobox_line3  = \"${label[3]}\""  >> $gnuconf
	echo "infobox_line4  = \"${label[4]}\""  >> $gnuconf
	echo "infobox_line5  = \"${label[1]}\""  >> $gnuconf
	echo "infobox_line6  = \"${label[2]}\"" >> $gnuconf
	echo "infobox_line7  = \"${label[16]}\""  >> $gnuconf
	echo "infobox_line8  = \"${label[5]}\""  >> $gnuconf
	echo "infobox_line9  = \"${label[6]}\""  >> $gnuconf
	echo "infobox_line10 = \"${label[7]}\""  >> $gnuconf
	echo "infobox_val1 = \"${mAval}\"" >> $gnuconf
	echo "infobox_val2 = \"${gammaAval}\"" >> $gnuconf
	echo "infobox_val3 = \"${cbaval}\""  >> $gnuconf
	echo "infobox_val4 = \"${tbval}\""  >> $gnuconf
	echo "infobox_val5 =  \"${mhval}\""  >> $gnuconf
	echo "infobox_val6 =  \"${mHval}\"" >> $gnuconf
	echo "infobox_val7 =  \"${mHcval}\"" >> $gnuconf
	echo "infobox_val8 =  \"${Z4val}\""  >> $gnuconf
	echo "infobox_val9 =  \"${Z5val}\""  >> $gnuconf
	echo "infobox_val10 = \"${Z7val}\""  >> $gnuconf

	echo -e "$basename" >> benchmarklist

	# BGFLAG loop
	for iBGFLAG in {0..3}; 
	do

		echo "cbaval: $cbaval"
		echo "tbval: $tbval"
		echo "mAval: $mAval"
		echo "gammaAval: $gammaAval"
		echo "iBGFLAG: $iBGFLAG"
 		echo -e "$sqrts\n$icut\n$ptcut,$etacut\n$rmcut\n$ncall\n$itmax\n$acc\n$iseed\n$cbaval\n$tbval\n$mAval\n$gammaAval\n$iBGFLAG\n" | $BINARY

		#echo -e "$(cat ./com/${com})\n$iBGFLAG" | $BINARY
 		output="${basename}_${iBGFLAG}.dat"
 		mv fort.79 $output
	done

	  sigZval=$(awk -v line="518" -v  field="4" '{if(NR==line) print $field}' ${basename}_0.dat )
	  sigAval=$(awk -v line="518" -v  field="4" '{if(NR==line) print $field}' ${basename}_1.dat )
	 sigAZval=$(awk -v line="518" -v  field="4" '{if(NR==line) print $field}' ${basename}_2.dat )
	sigintval=$(awk -v line="518" -v  field="4" '{if(NR==line) print $field}' ${basename}_3.dat )

	echo -e "sigma Z = $sigZval"
	echo -e "sigma A = $sigAval"
	echo -e "sigma AZ = $sigAZval"

	echo "sigZ   = \"${sigZval}\""  >> $gnuconf
	echo "sigA   = \"${sigAval}\""  >> $gnuconf
	echo "sigAZ  = \"${sigAZval}\""  >> $gnuconf
	echo "sigint = \"${sigintval}\""  >> $gnuconf

done

