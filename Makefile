######################################################
### --- Makefile for 2HDM Parameter space scan --- ###
######################################################

#############################
### -- Interactive run -- ###
#############################

#run_TASK     = "task_ParamScan_Multi.sh"
#run_TAG      = "test1234"
#run_CONFIG   = "ParamSpace.config"
#run_WRITELHA = 0

#run_TASK     = "task_ParamScan_Multi.sh"
#run_TAG      = "run_Hybrid_low_mA_mH_350_detailed"
#run_CONFIG   = "ParamSpace_low_mA.config"
#run_WRITELHA = 0

#run_TASK     = "task_ParamScan_Physical_Multi.sh"
#run_TAG      = "Physical_test"
#run_CONFIG   = "ParamSpace_Physical_default.config"
#run_WRITELHA = 0

#run_TASK     = "task_ParamScan_Hybrid_mH_eq_mHc.sh"
#run_TAG      = "Hybrid_mH_eq_mHc_500_mA_150-400_8bins_pert_8pi"
#run_CONFIG   = "ParamSpace_Hybrid_mH_eq_mHc.config"
#run_WRITELHA = 0

#run_TASK     = "task_ParamScan_RB.sh"
#run_TAG      = "RB_test_run"
#run_WRITELHA = 0

#run_TASK     = "task_ParamScan_Hybrid_mH_eq_mHc.sh"
#run_TAG      = "test"
#run_CONFIG   = "ParamSpace_Hybrid_mH_eq_mHc.config"
#run_WRITELHA = 0

#run_TASK     = "task_ParamScan_Hybrid_mH_eq_mHc.sh"
#run_TAG      = "Hybrid_mH_eq_mHc_mA_low_pert_8pi"
#run_CONFIG   = "ParamSpace_Hybrid_mH_eq_mHc.config"
#run_WRITELHA = 0

#run_TASK     = "task_ParamScan_Hybrid_mH_eq_mHc.sh"
#run_TAG      = "test2"
#run_CONFIG   = "ParamSpace_Hybrid_mH_eq_mHc.config"
#run_WRITELHA = 0

#run_TASK     = "task_ParamScan_Hybrid_mH_eq_mHc.sh"
#run_TAG      = "test3"
#run_CONFIG   = "ParamSpace_Hybrid_mH_eq_mHc_test.config"
#run_WRITELHA = 0

#run_TASK     = "task_ParamScan_Hybrid_modified_mA_mHc.sh"
#run_TAG      = "test_Hybrid_modified"
#run_CONFIG   = "ParamSpace_Hybrid_modified_mA_mHc_lowmA_mH_500_mHc_500.config"
#run_WRITELHA = 0

#run_TASK     = "task_ParamScan_Hybrid_modified_mA_mHc_EWPO_survey.sh"
#run_TAG      = "test_Hybrid_modified_EWPO"
#run_CONFIG   = "ParamSpace_Hybrid_modified_mA_mHc_EWPO_survey.config"
#run_WRITELHA = 0

# - Test
#run_TASK     = "task_ParamScan_Hybrid_modified_mA_mHc_EWPO_survey.sh"
#run_TAG      = "test123"
#run_CONFIG   = "ParamSpace_Hybrid_modified_mA_mHc_EWPO_survey.config"
#run_WRITELHA = 0
#run_ytype    = 2

run_TASK     = "task_ParamScan_Hybrid_modified_mA_mHc.sh"
run_TAG      = "Alpha_mA_200_mH_560_mHc_500_split_Z7_0.6"
run_CONFIG   = "ParamSpace_Hybrid_modified_mA_200_mH_mHc_split.config"
run_WRITELHA = 0
run_ytype    = 2

#run_TASK     = "task_ParamScan_Physical_LinCos.sh"
#run_TAG      = "Physical_LinCos_test"
#run_CONFIG   = "ParamSpace_Physical_Cos_default.config"
#run_WRITELHA = 0

# Extract Makefile variables having 'run_' string; strip the prefix 'run_';
# make <varname>=<varvalue> pairs; pass these variable list to shell

VAR_RUN    = $(shell echo '$(.VARIABLES)' |  awk -v RS=' ' '/run_/' | sed 's/run_//g' )
EXPORT_RUN = $(foreach v,$(VAR_RUN),$(v)="$(run_$(v))")

################################
### -- Submit job to qsub -- ###
################################

# command: make submit_job

#job_RESOURCELIST = "walltime=60:00:00"
#job_TASK     	  = "task_ParamScan_Multi.sh"
#job_TAG      	  = "job_test4321"
#job_CONFIG   	  = "ParamSpace.config"
#job_WRITELHA 	  = 0

#job_RESOURCELIST = ""
#job_TASK     	  = "task_ParamScan_Multi.sh"
#job_TAG      	  = "job_mHc_eq_mH_500"
#job_CONFIG   	  = "ParamSpace_mHc_eq_mH.config"
#job_WRITELHA 	  = 0

#job_RESOURCELIST = "walltime=60:00:00"
#job_RESOURCELIST = ""
#job_RESOURCELIST = "walltime=10:00:00"
#job_TASK     	  = "task_ParamScan_Multi.sh"
#job_TAG      	  = "Hybrid_job_low_mA_sweep_mH"
#job_CONFIG   	  = "ParamSpace_Hybrid_job_low_mA.config"
#job_WRITELHA 	  = 0

#job_RESOURCELIST = "walltime=10:00:00"
#job_TASK     	  = "task_ParamScan_Hybrid_mH_eq_mHc.sh"
#job_TAG      	  = "Hybrid_job_mH_eq_mHc_400_mA_from_150_to_400_8bins"
#job_CONFIG   	  = "ParamSpace_Hybrid_mH_eq_mHc.config"
#job_WRITELHA 	  = 0

job_RESOURCELIST = "walltime=8:00:00"
job_TASK     	  = "task_ParamScan_Hybrid_modified_mA_mHc.sh"
job_TAG      	  = "Hybrid_modified-mH_500-mHc_500-mA_150-250_10bins-Z7_0_pert_8pi-fixedHB431_withBRs"
job_CONFIG   	  = "ParamSpace_Hybrid_modified_mA_mHc_lowmA_mH_500_mHc_500.config"
job_WRITELHA 	  = 0

VAR_JOB    = $(shell echo '$(.VARIABLES)' |  awk -v RS=' ' '/^job_/' | sed 's/job_//g' )
EXPORT_JOB = $(foreach v,$(VAR_JOB),$(v)="$(job_$(v))")

#################################
### -- SrV project creator -- ###
#################################
# - Command: make SrV

# - Test
#SrV_TAG           = test123
#SrV_CONFIG        = ParamSpace_Hybrid_modified_mA_mHc_test.config
#SrV_WRITELHA      = 0
#SrV_nJOBS         = 1
#SrV_BINARY        = ParameterScan_Hybrid_EWPO 
#SrV_yukawa_TYPE   = 2
#SrV_WORK_DIR       = /scratch/de3u14/2HDM-Zh/ParameterScans

# - EWPO survey
#SrV_TAG           = EWPO_survey_mH_mHc_from_200_to_600_9_9_bins
#SrV_CONFIG        = ParamSpace_Hybrid_modified_mA_mHc_EWPO_survey_job_mH_mHc_9_9.config
#SrV_WRITELHA      = 0
#SrV_nJOBS         = 100
#SrV_BINARY        = ParameterScan_Hybrid_EWPO 
#SrV_yukawa_TYPE   = 2
#SrV_WORK_DIR       = /scratch/de3u14/2HDM-Zh/ParameterScans

# - Alpha
#SrV_TAG           = Alpha_mA_200_mHc_500_mH_500-550_Z7-m0.5-p0.5
#SrV_CONFIG        = ParamSpace_Hybrid_modified_mA_200_mH_mHc_split_job.config
#SrV_WRITELHA      = 0
#SrV_nJOBS         = 100
#SrV_BINARY        = ParameterScan_Hybrid_General
#SrV_yukawa_TYPE   = 2
#SrV_WORK_DIR      = /scratch/de3u14/2HDM-Zh/ParameterScans

# - Beta dataset mA = [150,250] - #
#SrV_TAG           = Beta_mA_150-250_mHc_500_mH_560_Z7_0.6
#SrV_CONFIG        = ParamSpace_Hybrid_modified_mA_150-250_mH_mHc_split_job.config
#SrV_WRITELHA      = 0
#SrV_nJOBS         = 100
#SrV_BINARY        = ParameterScan_Hybrid_General
#SrV_yukawa_TYPE   = 2
#SrV_WORK_DIR      = /scratch/de3u14/2HDM-Zh/ParameterScans

# - Beta dataset mA = [100,700] - #
SrV_TAG           = Beta_mA_100-700_mHc_500_mH_560_Z7_0.6
SrV_CONFIG        = ParamSpace_Hybrid_modified_mA_100-700_mH_mHc_split_job.config
SrV_WRITELHA      = 0
SrV_nJOBS         = 100
SrV_BINARY        = ParameterScan_Hybrid_General
SrV_yukawa_TYPE   = 2
SrV_WORK_DIR      = /scratch/de3u14/2HDM-Zh/ParameterScans

#SrV_JOB_RESRCLIST =
#SrV_JOB-RESRCLIST = "walltime=8:00:00"

###################################
### --- SrV data formatting --- ###
###################################
# - Command: make SrV-format-data

#SrV_format_data_work_dir  = /scratch/de3u14/2HDM-Zh/ParameterScans
#SrV_format_data_tag       = test123
#SrV_format_data_out_label = formatted_dat_mA_200.0
#SrV_format_data_mask      = EWPO.mask
##SrV_format_data_eval      = mA='150.0' mh='150'

SrV_format_data_work_dir  = /scratch/de3u14/2HDM-Zh/ParameterScans
#SrV_format_data_tag       = Alpha_mA_200_mH_mHc_split
#SrV_format_data_tag       = Alpha_mA_200_mHc_500_mH_500-550_Z7-m0.5-p0.5
#SrV_format_data_tag       = Alpha_mA_200_mHc_500_mH_560_Z7_0.6
SrV_format_data_tag       = Beta_mA_150-250_mHc_500_mH_560_Z7_0.6
SrV_format_data_mA        = 200.0
SrV_format_data_mH        = 560.0
SrV_format_data_mHc       = 500.0
SrV_format_data_Z7        = 0.6
SrV_format_data_out_label = formatted_dat_mA_$(SrV_format_data_mA)_mH_$(SrV_format_data_mH)_mHc_$(SrV_format_data_mHc)
SrV_format_data_mask      = General_custom_mA_mH_mHc_Z7.mask
SrV_format_data_eval      = mA='$(SrV_format_data_mA)' mH='$(SrV_format_data_mH)' mHc='$(SrV_format_data_mHc)' Z7='$(SrV_format_data_Z7)'

#############################
### --- SrV plot data --- ###
#############################
# - Command: make SrV-plot-data

#SrV_fig_work_dir       = /scratch/de3u14/2HDM-Zh/ParameterScans
#SrV_fig_tag            = $(SrV_format_data_tag)
#SrV_fig_out_label      = $(SrV_format_data_out_label)
#SrV_fig_gnuplot_script = plot_EWPO.gnu

# - General
SrV_fig_work_dir       = /scratch/de3u14/2HDM-Zh/ParameterScans
SrV_fig_tag            = $(SrV_format_data_tag)
SrV_fig_out_label      = $(SrV_format_data_out_label)
SrV_fig_gnuplot_script = plot_General.gnu


#SrV_fig_mask = EWPO.mask
#SrV_fig_eval = mA='150.0' mh='150'

VAR_SrV    = $(shell echo '$(.VARIABLES)' |  awk -v RS=' ' '/^SrV_/' | sed 's/SrV_//g' )
EXPORT_SrV = $(foreach v,$(VAR_SrV),$(v)="$(SrV_$(v))")

#########################
### -- Format data -- ###
#########################
# field# = <val#>

#form_dat_job_tag = job_cba_tb_50_50
#form_dat_job_tag = job_cba_tb_201_by_201
#form_dat_out_tag = output

#form_dat_job_tag = job_cba_tb_51_51
#form_dat_out_tag = output

#form_dat_job_tag = job_mH_cba_tb
#form_dat_out_tag = output_mH_${form_dat_mH}

#form_dat_job_tag = job_mHc_eq_mH_500
#form_dat_job_tag = interactive_mHc_eq_mH
#form_dat_out_tag = output

#form_dat_job_tag = Physical_LinCos_run2
#form_dat_job_tag = Physical_LinCos_mH_400_mA_150
#form_dat_job_tag = Physical_LinCos_mA_150_mH_300

#form_dat_job_tag = run_Hybrid_low_mA
#form_dat_out_tag = output

#form_dat_job_tag = run_Hybrid_low_mA_mH_350_detailed
#form_dat_out_tag = output_form_dat_mH_$(form_dat_mH)

#form_dat_job_tag = Hybrid_mH_eq_mHc_400_mA_150-400_8bins_Z7_0.00
#form_dat_job_tag = Hybrid_mH_eq_mHc_mA_from_150_to_400_8bins

#form_dat_job_tag = Hybrid_mH_eq_mHc_mA_from_150_to_400_8bins_Z7_2.00
#form_dat_job_tag = Hybrid_mH_eq_mHc_mA_from_150_to_400_8bins_Z7_-2.00
#form_dat_out_tag = output_form_dat_mA_$(form_dat_mA)

#form_dat_job_tag = Hybrid_mH_eq_mHc_500_mA_150-400_8bins_pert_8pi
#form_dat_out_tag = output_form_dat_mA_$(form_dat_mA)

#form_dat_job_tag = Hybrid_mH_eq_mHc_500_mA_150-400_8bins_pert_8pi
#form_dat_out_tag = output_form_dat_mA_$(form_dat_mA)

#form_dat_job_tag = test

#form_dat_job_tag = Hybrid_mH_eq_mHc_mA_low_pert_8pi
#form_dat_out_tag = output_form_dat_mA_$(form_dat_mA)

#form_dat_job_tag = Hybrid_modified_mH_500_mHc_500_mA_150-250_10bins_Z7_0_pert_8pi
#form_dat_out_tag = formatted_dat_mA_$(form_dat_mA)

#form_dat_job_tag = Hybrid_modified-mH_500-mHc_500-mA_150-250_10bins-Z7_0_pert_8pi-fixedHB431_withBRs
#form_dat_out_tag = formatted_dat_mA_$(form_dat_mA)

#form_dat_job_tag = Alpha_mA_200_mH_560_mHc_500_split_Z7_0.6
form_dat_job_tag = Alpha_mA_200_mH_560_mHc_500_split_Z7_0.0
form_dat_out_tag = formatted_dat_mA_$(form_dat_mA)

form_dat_opt   = 1
#form_dat_mA    = 185.428642# Field 13

form_dat_mh    = 125.0
form_dat_mH    = 560.0
form_dat_mHc   = 500.0
#form_dat_mA    = 150.0
#form_dat_mA    = 160.0
#form_dat_mA    = 170.0
#form_dat_mA    = 180.0
#form_dat_mA    = 190.0
#form_dat_mA    = 200.0
#form_dat_mA    = 210.0
#form_dat_mA    = 220.0
#form_dat_mA    = 230.0
#form_dat_mA    = 240.0
form_dat_mA    = 200.0
form_dat_cosba = 0.000000
form_dat_tanb  = 0.000000 

form_dat_Z4    =  -1.000000
form_dat_Z5    =   1.000000

form_dat_Z7    =  0.000000

form_dat_l6    =   0.000000e+00
form_dat_l7    =   0.000000e+00
form_dat_m12_2 =   1.580000e+04

form_dat_XVar = 1
form_dat_YVar = 3

###
# Filterfields:
# 15 = mh 
# 16 = mH
# 6 = Z7
# 17 = mHc
# 18 = mA

form_dat_filterfield1 = 15
form_dat_filterfield2 = 16
form_dat_filterfield3 = 6
form_dat_filterfield4 = 17
form_dat_filterfield5 = 18

form_dat_filterval1 = $(form_dat_mh)
form_dat_filterval2 = $(form_dat_mH)
form_dat_filterval3 = $(form_dat_Z7)
form_dat_filterval4 = $(form_dat_mHc)
form_dat_filterval5 = $(form_dat_mA)


#form_dat_filterfield1 = 1
#form_dat_filterfield2 = 13
#form_dat_filterfield3 = 2
#form_dat_filterfield4 = 16
#form_dat_filterfield5 = 7
#
#form_dat_filterval1 = $(form_dat_mh)
#form_dat_filterval2 = $(form_dat_mA)
#form_dat_filterval3 = $(form_dat_mH)
#form_dat_filterval4 = $(form_dat_mHc)
#form_dat_filterval5 = $(form_dat_Z7)

#form_dat_filterfield1 = 1
#form_dat_filterfield2 = 2
#form_dat_filterfield3 = 5
#form_dat_filterfield4 = 6
#form_dat_filterfield5 = 7

#form_dat_filterfield1 = 1
#form_dat_filterfield2 = 2
#form_dat_filterfield3 = 17
#form_dat_filterfield4 = 18
#form_dat_filterfield5 = 19

###########
## Array ##
###########

mA_array = 150.0 160.0 170.0 180.0 190.0 200.0 210.0 220.0 230.0 240.0 250.0
array_job_tag = Hybrid_modified-mH_500-mHc_500-mA_150-250_10bins-Z7_0_pert_8pi-fixedHB431_withBRs



#form_dat_filterval1 = $(form_dat_mh)
#form_dat_filterval2 = $(form_dat_mH)
#form_dat_filterval3 = $(form_dat_Z4)
#form_dat_filterval4 = $(form_dat_Z5)
#form_dat_filterval5 = $(form_dat_Z7)

#form_dat_filterval1 = $(form_dat_mh)
#form_dat_filterval2 = $(form_dat_mH)
#form_dat_filterval3 = $(form_dat_l6)
#form_dat_filterval4 = $(form_dat_l7)
#form_dat_filterval5 = $(form_dat_m12_2)

# Extract Makefile variables having 'form_dat' string; make <varname>=<varvalue>
# pairs; pass these variable list to shell

VAR_FORM_DAT    := $(shell echo '$(.VARIABLES)' |  awk -v RS=' ' '/form_dat/')
EXPORT_FORM_DAT := $(foreach v,$(VAR_FORM_DAT),$(v)='$($(v))')

##########################
### -- Make figures -- ###
##########################

#fig_job_tag = job_cba_tb_50_50
#fig_out_tag = reduced_test

#fig_job_tag = job_cba_tb_201_by_201
#fig_out_tag = output

#fig_job_tag = job_cba_tb_51_51
#fig_out_tag = output

#fig_job_tag = job_mH_cba_tb
#fig_out_tag = output_mH_${form_dat_mH}

#fig_job_tag = job_mHc_eq_mH_500

#fig_job_tag = interactive_mHc_eq_mH
#fig_out_tag = output

#fig_job_tag = Physical_LinCos_mH_400_mA_150

#fig_job_tag = Physical_LinCos_mA_150_mH_300
#fig_job_tag = Hybrid_job_low_mA_sweep_mH

#fig_job_tag = run_Hybrid_low_mA_mH_350_detailed

fig_job_tag = $(form_dat_job_tag)
fig_out_tag = $(form_dat_out_tag)

#fig_job_tag = benchmarks_Hybrid_mH_eq_mHc_500_mA_150-400_Z7_0.00_pert_8pi
#fig_out_tag = test

### Not developed further...
#############################
### -- Make benchmarks -- ###
#############################

#benchmark_tag  = "trial"
#benchmark_list = "benchmark.pts"

###########################
### -- Make spectrum -- ###
###########################

#fig_spectra_job_tag = $(form_dat_job_tag)
#fig_spectra_out_tag = $(form_dat_out_tag)

##########################################
### -- Cross section job submission -- ###
##########################################

xsec_job_tag   = "test"
xsec_job_split = 5

###################################################################################

#	@cd results/$(form_dat_job_tag); $(EXPORT_FORM_DAT) ../../awk/format_data.sh; echo $(EXPORT_FORM_DAT) | tr " " "\n" | awk 'NF > 0' | sort > $(form_dat_out_tag).config
#  @cd ./results/$(fig_job_tag)/figures/paramspace; ../../../../gnuplot/plot_all.sh $(fig_job_tag) $(fig_out_tag)


test : .PHONY
	@echo "This is VAR_RUN:"
	@echo "$(VAR_RUN)"
	@echo "This is EXPORT_JOB:"
	@echo "$(EXPORT_JOB)"
	@echo "This is EXPORT_FORM_DAT:"
	@echo "$(EXPORT_FORM_DAT)"
	@echo "This is SrV_format_data_eval:"
	@echo "$(SrV_format_data_eval)"


run : build
	@$(EXPORT_RUN) ./tasks/$(run_TASK); 

new : 
	@TAG=$(TAG); ./scripts/createWD.sh

submit_job :
	@if [ -d ./results/$(job_TAG) ]; then cp -f ./results/$(job_TAG) ./backup/$(job_TAG); rm -rf results/$(job_TAG); fi;
	@mkdir -p results/$(job_TAG)
	@cp ./tasks/$(job_TASK) ./results/$(job_TAG)/$(job_TASK)
	@echo $(EXPORT_JOB) | tr " " "\n" | awk 'NF > 0' | sort | cat - ./results/$(job_TAG)/$(job_TASK) > temp; echo "#!/bin/sh" | cat - temp > temp2  && mv temp2 ./results/$(job_TAG)/$(job_TASK)
	@$(EXPORT_JOB) ./qsub/submit.sh

SrV :
	@$(EXPORT_SrV) ./utils/SrV-m-create-project.sh

SrV-check :
	@$(EXPORT_SrV) ./utils/SrV-s-check-setup.sh

SrV-merge :
	@$(EXPORT_SrV) ./utils/SrV-s-merge-processed-files.sh

SrV-submit-jobs :
	@$(EXPORT_SrV) ./utils/SrV-s-submit-jobs.sh

SrV-format-data :
	@$(EXPORT_SrV) $(SrV_format_data_eval) ./utils/SrV-s-format-data.sh

SrV-plot-data :
	@$(EXPORT_SrV) ./utils/SrV-s-plot-data.sh


fig_param : 
	@cd ./results/$(fig_job_tag)/figures/paramspace; ../../../../gnuplot/plot_all.sh $(fig_job_tag) $(fig_out_tag)
#	cd figures/$(fig_job_tag); gnuplot -e "config=../../results/${fig_job_tag}/${fig_out_tag}_gnu.conf; ../../gnuplot/chisq_distr.gnu

# Not developed further
#fig_spectra : 

#benchmark : 
#	@cd ./results/${benchmark_tag}; input="../../benchmarks/$(benchmark_list)" ../../scripts/makeBenchmarks.sh

format_data : 
	@cd results/$(form_dat_job_tag); $(EXPORT_FORM_DAT) ../../awk/format_data.sh; echo $(EXPORT_FORM_DAT) | tr " " "\n" | awk 'NF > 0' | sort > $(form_dat_out_tag).config

build : build_allbinaries


build_allbinaries : 
	@ cd src; make binaries;

prep_xsec_sub :
	./scripts/prep_xsec_sub.sh $(xsec_job_tag) $(xsec_job_split)


clean :
	rm -f ./lib/*.o
	find ./bin/ -type f -not -name 'dummy' | xargs rm -f
	rm -f ./src/.depend_cpp
	touch ./src/.depend_cpp


.PHONY: figures
