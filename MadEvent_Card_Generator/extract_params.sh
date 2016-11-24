#!/bin/bash

#tag=$1
#label=$2
#lineno=$3

mA=200.0
mHc=500.0
mH=560.0

tag="Beta_mA_150-250_mHc_500_mH_560_Z7_0.6"
label="mA_${mA}_mH_${mH}_mHc_${mHc}"
lineno=5

#file=./results/${tag}/formatted_dat_${label}_formated_allowed.dat
#file=/scratch/de3u14/2HDM-Zh/ParameterScans/results/${tag}/formatted_dat_${label}_formatted_allowed.dat
file=/home/de3u14/lib/projects/2HDM/2HDM_ParameterSpaceScan/benchmarks/All_and_STU_satisfied/benchmark.pts
#/scratch/de3u14/2HDM-Zh/ParameterScans/results/Beta_mA_150-250_mHc_500_mH_560_Z7_0.6/formatted_dat_mA_200.0_mH_560.0_mHc_500.0_formatted_allowed.dat


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


cba_val=$(awk -v col=${cba_col} -v lineno=${lineno} '{if(NR==lineno) value=$col} END{printf("%.2e\n", value)}' ${file})

sba_val=$(awk -v col=${sba_col} -v lineno=${lineno} '{if(NR==lineno) value=$col} END{printf("%.2e\n", value)}' ${file})
tb_val=$(awk -v col=${tb_col} -v lineno=${lineno} '{if(NR==lineno) value=$col}   END{printf("%.2e\n", value)}' ${file})

l2_val=$(awk -v col=${l2_col} -v lineno=${lineno} '{if(NR==lineno) value=$col}   END{printf("%.2e\n", value)}' ${file})
l3_val=$(awk -v col=${l3_col} -v lineno=${lineno} '{if(NR==lineno) value=$col}   END{printf("%.2e\n", value)}' ${file})
l7_val=$(awk -v col=${l7_col} -v lineno=${lineno} '{if(NR==lineno) value=$col}   END{printf("%.2e\n", value)}' ${file})

mh_val=$(awk -v col=${mh_col} -v lineno=${lineno} '{if(NR==lineno) value=$col}   END{printf("%.2e\n", value)}' ${file})
mH_val=$(awk -v col=${mH_col} -v lineno=${lineno} '{if(NR==lineno) value=$col}   END{printf("%.2e\n", value)}' ${file})
mHc_val=$(awk -v col=${mHc_col} -v lineno=${lineno} '{if(NR==lineno) value=$col} END{printf("%.2e\n", value)}' ${file})
mA_val=$(awk -v col=${mA_col} -v lineno=${lineno} '{if(NR==lineno) value=$col}   END{printf("%.2e\n", value)}' ${file})

Gh_val=$(awk -v col=${Gh_col} -v lineno=${lineno} '{if(NR==lineno) value=$col}   END{printf("%.2e\n", value)}' ${file})
GH_val=$(awk -v col=${GH_col} -v lineno=${lineno} '{if(NR==lineno) value=$col}   END{printf("%.2e\n", value)}' ${file})
GHc_val=$(awk -v col=${GHc_col} -v lineno=${lineno} '{if(NR==lineno) value=$col} END{printf("%.2e\n", value)}' ${file})
GA_val=$(awk -v col=${GA_col} -v lineno=${lineno} '{if(NR==lineno) value=$col}   END{printf("%.2e\n", value)}' ${file})


#l7_val=$(awk -v col=${l7_col} '{if(NR==1) header=$col; if(NR==2) value=$col} END{printf("%s: %.2e\n", header, value)}' ${file})

echo "cos(b-a):   ${cba_val}" 

echo "### - MadEvent card - ###"
echo "set sinbma  ${sba_val}  # sin(b-a)" 
echo "set tanbeta ${tb_val}  # tan(b)" 
                  
echo "" 
echo "set l2      ${l2_val}  # lambda_{2}" 
echo "set l3      ${l3_val}  # lambda_{3}" 
echo "set lr7     ${l7_val}  # Re{lambda_{7}}" 
                 
echo "" 
echo "set mh1     ${mh_val}  # m_{h}" 
echo "set mh2     ${mH_val}  # m_{H}" 
echo "set mh3     ${mA_val}  # m_{A}" 
echo "set mhc     ${mHc_val}  # m_{Hc}" 
                 
echo "" 
echo "set wh1     ${Gh_val}  # Gamma_{h}" 
echo "set wh2     ${GH_val}  # Gamma_{H}" 
echo "set wh3     ${GA_val}  # Gamma_{A}" 
echo "set whc     ${GHc_val}  # Gamma_{Hc}" 
