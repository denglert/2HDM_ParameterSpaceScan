#!/bin/bash

array_job_tag=Hybrid_modified-mH_500-mHc_500-mA_150-250_10bins-Z7_0_pert_8pi-fixedHB431_withBRs

form_dat_opt=1

form_dat_mh=125.0
form_dat_mH=500.0
form_dat_mHc=${form_dat_mH}
form_dat_mA=150.0

form_dat_cosba=0.000000
form_dat_tanb=0.000000 

form_dat_Z4=-1.000000
form_dat_Z5=1.000000

form_dat_Z7=0.000000

form_dat_l6=0.000000e+00
form_dat_l7=0.000000e+00
form_dat_m12_2=1.580000e+04

form_dat_XVar=1
form_dat_YVar=3

###
# Filterfields:
# 15 = mh 
# 16 = mH
# 6 = Z7
# 17 = mHc
# 18 = mA

form_dat_filterfield1=15
form_dat_filterfield2=16
form_dat_filterfield3=6
form_dat_filterfield4=17
form_dat_filterfield5=18

form_dat_filterval1=${form_dat_mh}
form_dat_filterval2=${form_dat_mH}
form_dat_filterval3=${form_dat_Z7}
form_dat_filterval4=${form_dat_mHc}
form_dat_filterval5=${form_dat_mA}

#mA_array = 150.0 160.0 170.0 180.0 190.0 200.0 210.0 220.0 230.0 240.0 250.0

#export form_dat_filterval1
#export form_dat_filterval2
#export form_dat_filterval3
#export form_dat_filterval4
#export form_dat_filterval5
#
#export form_dat_filterfield1
#export form_dat_filterfield2
#export form_dat_filterfield3
#export form_dat_filterfield4
#export form_dat_filterfield5
#
#
#
#
#export array_job_tag
#export 
#export form_dat_opt
#export 
#export form_dat_mh
#export form_dat_mH=500
#export form_dat_mHc=${
#export form_dat_mA=150
#export 
#export form_dat_cosba=
#export form_dat_tanb=0
#export 
#export form_dat_Z4=-1.
#export form_dat_Z5=1.0
#export 
#export form_dat_Z7=0.0
#export 
#export form_dat_l6=0.0
#export form_dat_l7=0.0
#export form_dat_m12_2=
#export 
#export form_dat_XVar=1
#export form_dat_YVar=3








cd results/${array_jon_tag}

source ../../awk/format_data.sh

#echo $(EXPORT_FORM_DAT) | tr " " "\n" | awk 'NF > 0' | sort > $(form_dat_out_tag).config

#	@cd ./results/$(fig_job_tag)/figures/paramspace; ../../../../gnuplot/plot_all.sh $(fig_job_tag) $(fig_out_tag)
#fig_param : 
#	@cd ./results/$(fig_job_tag)/figures/paramspace; ../../../../gnuplot/plot_all.sh $(fig_job_tag) $(fig_out_tag)
#
#
#format_data : 
#	@cd results/$(form_dat_job_tag); $(EXPORT_FORM_DAT) ../../awk/format_data.sh; echo $(EXPORT_FORM_DAT) | tr " " "\n" | awk 'NF > 0' | sort > $(form_dat_out_tag).config
