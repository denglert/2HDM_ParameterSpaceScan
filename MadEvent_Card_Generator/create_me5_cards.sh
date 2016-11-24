#!/bin/bash
# Example command:
# ./MadEvent_Card_Generator/create_me5_cards.sh ./benchmarks/All_and_STU_satisfied/benchmark.pts test 10000


INPUT=$1   # benchmark.pts
TAGNAME=$2 # TAGNAME
nEvents=$3 # TAGNAME

TEMPLATE=/home/de3u14/lib/projects/2HDM/2HDM_ParameterSpaceScan/MadEvent_Card_Generator/template.me5

################
create_MadEvent_card()
{
	CARDNAME=$1

	cba=$(printf "%.2f" ${cba_val})
	tb=$( printf "%.2f" ${tb_val})
	mA=$( printf "%.2f" ${mA_val} )
	nevents=$( printf "%d" ${nEvents} )

	OUTPUT=${CARDNAME}_cba_${cba}_tb_${tb}_mA_${mA}_nEv_${nEvents}.me5

	cp ${TEMPLATE} ${OUTPUT}
	sed -i "s@<benchmark_file>@${INPUT}@g" ${OUTPUT}
	sed -i "s@<benchmark_lineno>@${lineno}@g" ${OUTPUT}
	sed -i "s@<benchmark_it>@${it}@g" ${OUTPUT}

	sed -i "s/<nevents>/${nEvents}/g" ${OUTPUT}
	sed -i "s/<run_name>/${CARDNAME}/g" ${OUTPUT}

	sed -i "s/<sinbma>/${sba_val}/g" ${OUTPUT}
	sed -i "s/<tanbeta>/${tb_val}/g" ${OUTPUT}

	sed -i "s/<l2>/${l2_val}/g" ${OUTPUT}
	sed -i "s/<l3>/${l3_val}/g" ${OUTPUT}
	sed -i "s/<lr7>/${l7_val}/g" ${OUTPUT}

	sed -i "s/<mh>/${mh_val}/g" ${OUTPUT}
	sed -i "s/<mH>/${mH_val}/g" ${OUTPUT}
	sed -i "s/<mA>/${mA_val}/g" ${OUTPUT}
	sed -i "s/<mHc>/${mHc_val}/g" ${OUTPUT}

	sed -i "s/<wh>/${Gh_val}/g" ${OUTPUT}
	sed -i "s/<wH>/${GH_val}/g" ${OUTPUT}
	sed -i "s/<wA>/${GA_val}/g" ${OUTPUT}
	sed -i "s/<wHc>/${GHc_val}/g" ${OUTPUT}
}

################
get_parameters()
{
	benchmark_file=$1
	lineno=$2

	cba_col=1
	sba_col=2
	tb_col=3
	l2_col=9
	l3_col=10
	l7_col=14
	
	mh_col=15
	mH_col=16
	mHc_col=17
	mA_col=18
	
	Gh_col=19
	GH_col=20
	GHc_col=21
	GA_col=22

	Z7_col=6
	
	cba_val=$(awk -v col=${cba_col} -v lineno=${lineno} '{if(NR==lineno) value=$col} END{printf("%.2e\n", value)}' ${benchmark_file})
	
	sba_val=$(awk -v col=${sba_col} -v lineno=${lineno} '{if(NR==lineno) value=$col} END{printf("%.2e\n", value)}' ${benchmark_file})
	tb_val=$(awk -v col=${tb_col} -v lineno=${lineno} '{if(NR==lineno) value=$col}   END{printf("%.2e\n", value)}' ${benchmark_file})
	
	l2_val=$(awk -v col=${l2_col} -v lineno=${lineno} '{if(NR==lineno) value=$col}   END{printf("%.2e\n", value)}' ${benchmark_file})
	l3_val=$(awk -v col=${l3_col} -v lineno=${lineno} '{if(NR==lineno) value=$col}   END{printf("%.2e\n", value)}' ${benchmark_file})
	l7_val=$(awk -v col=${l7_col} -v lineno=${lineno} '{if(NR==lineno) value=$col}   END{printf("%.2e\n", value)}' ${benchmark_file})

	mh_val=$(awk -v col=${mh_col} -v lineno=${lineno} '{if(NR==lineno) value=$col}   END{printf("%.2e\n", value)}' ${benchmark_file})
	mH_val=$(awk -v col=${mH_col} -v lineno=${lineno} '{if(NR==lineno) value=$col}   END{printf("%.2e\n", value)}' ${benchmark_file})
	mHc_val=$(awk -v col=${mHc_col} -v lineno=${lineno} '{if(NR==lineno) value=$col} END{printf("%.2e\n", value)}' ${benchmark_file})
	mA_val=$(awk -v col=${mA_col} -v lineno=${lineno} '{if(NR==lineno) value=$col}   END{printf("%.2e\n", value)}' ${benchmark_file})

	Gh_val=$(awk -v col=${Gh_col} -v lineno=${lineno} '{if(NR==lineno) value=$col}   END{printf("%.2e\n", value)}' ${benchmark_file})
	GH_val=$(awk -v col=${GH_col} -v lineno=${lineno} '{if(NR==lineno) value=$col}   END{printf("%.2e\n", value)}' ${benchmark_file})
	GHc_val=$(awk -v col=${GHc_col} -v lineno=${lineno} '{if(NR==lineno) value=$col} END{printf("%.2e\n", value)}' ${benchmark_file})
	GA_val=$(awk -v col=${GA_col} -v lineno=${lineno} '{if(NR==lineno) value=$col}   END{printf("%.2e\n", value)}' ${benchmark_file})

	Z7_val=$(awk -v col=${Z7_col} -v lineno=${lineno} '{if(NR==lineno) value=$col}   END{printf("%.2e\n", value)}' ${benchmark_file})
}

####################################
### --- Loop over benchmarks --- ###
####################################

echo ""
echo "Reading in benchmark points from ${INPUT}."
echo ""

it=0
lineno=0
while read line; do

	lineno=$(( lineno+1 ))
	case "$line" in \#*) continue ;; esac

	get_parameters ${INPUT} ${lineno}

	echo "it: ${it} lineno: ${lineno} cba: ${cba_val} sba: ${sba_val} tanb: ${tb_val} mA: ${mA_val} mH: ${mH_val} mHc: ${mHc_val} Z7: ${Z7_val}"

	cardname=${TAGNAME}_${it}
	create_MadEvent_card ${cardname}

	it=$(( it+1 ))
done < ${INPUT}

#####################################
