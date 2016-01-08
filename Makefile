######################################################
### --- Makefile for 2HDM Parameter space scan --- ###
######################################################

#################################
### -- Interactive job run -- ###
#################################

run_TASK     = "task_ParamScan_Multi.sh"
run_TAG      = "test1234"
run_CONFIG   = "ParamSpace.config"
run_WRITELHA = 0

# Extract Makefile variables having 'run_' string; strip the prefix 'run_';
# make <varname>=<varvalue> pairs; pass these variable list to shell

VAR_RUN    := $(shell echo '$(.VARIABLES)' |  awk -v RS=' ' '/run_/' | sed 's/run_//g' )
EXPORT_RUN := $(foreach v,$(VAR_RUN),$(v)="$(run_$(v))")

####################################
### -- Job submission to qsub -- ###
####################################

#job_RESOURCELIST = "walltime=60:00:00"
job_RESOURCELIST = "walltime=00:05:00"
job_TASK     	  = "task_ParamScan_Multi.sh"
job_TAG      	  = "job_test4321"
job_CONFIG   	  = "ParamSpace.config"
job_WRITELHA 	  = 0

VAR_JOB    := $(shell echo '$(.VARIABLES)' |  awk -v RS=' ' '/job_/' | sed 's/job_//g' )
EXPORT_JOB := $(foreach v,$(VAR_JOB),$(v)="$(job_$(v))")

#############################
### -- Formatting data -- ###
#############################

#form_dat_job_tag = job_cba_tb_50_50
#form_dat_job_tag = job_cba_tb_201_by_201
#form_dat_out_tag = output

#form_dat_job_tag = job_cba_tb_51_51
#form_dat_out_tag = output

form_dat_job_tag = job_mH_cba_tb
form_dat_out_tag = output_mH_${form_dat_mH}

form_dat_mh    = 125.000000# Field 1
form_dat_mH    = 333.333333# Field 2
#form_dat_mH    = 377.777778# Field 2
#form_dat_mH    = 422.222222# Field 2
form_dat_cosba =   0.000000# Field 3
form_dat_tanb  =   0.000000# Field 4 
form_dat_Z4    =  -2.000000# Field 5
form_dat_Z5    =  -2.000000# Field 6
form_dat_Z7    =   0.000000# Field 7

form_dat_XVar = 3
form_dat_YVar = 4
form_dat_filterfield1 = 1
form_dat_filterfield2 = 2
form_dat_filterfield3 = 5
form_dat_filterfield4 = 6
form_dat_filterfield5 = 7

###

#form_dat_job_tag = job_wide_6_by_6
#form_dat_out_tag = reduced_test

#######

form_dat_filterval1 = $(form_dat_mh)
form_dat_filterval2 = $(form_dat_mH)
form_dat_filterval3 = $(form_dat_Z4)
form_dat_filterval4 = $(form_dat_Z5)
form_dat_filterval5 = $(form_dat_Z7)

# Extract Makefile variables having 'form_dat' string; make <varname>=<varvalue>
# pairs; pass these variable list to shell

VAR_FORM_DAT    := $(shell echo '$(.VARIABLES)' |  awk -v RS=' ' '/form_dat/')
EXPORT_FORM_DAT := $(foreach v,$(VAR_FORM_DAT),$(v)='$($(v))')

############################
### -- Making figures -- ###
############################

#fig_job_tag = job_cba_tb_50_50
#fig_out_tag = reduced_test

#fig_job_tag = job_cba_tb_201_by_201
#fig_out_tag = output

#fig_job_tag = job_cba_tb_51_51
#fig_out_tag = output

fig_job_tag = job_mH_cba_tb
fig_out_tag = output_mH_${form_dat_mH}

###################################################################################


test :
	@echo "This is VAR_RUN:"
	@echo "$(VAR_JOB)"
	@echo "This is EXPORT_RUN:"
	@echo "$(EXPORT_JOB)"

run :
	@mkdir -p output/$(run_TAG); $(EXPORT_RUN) ./tasks/$(run_TASK); 

submit_job :
	@mkdir -p output/$(job_TAG)
	@cp ./tasks/$(job_TASK) ./output/$(job_TAG)/$(job_TASK)
	@echo $(EXPORT_JOB) | tr " " "\n" | awk 'NF > 0' | sort | cat - ./output/$(job_TAG)/$(job_TASK) > temp; echo "#!/bin/sh" | cat - temp > temp2  && mv temp2 ./output/$(job_TAG)/$(job_TASK)
	@$(EXPORT_JOB) ./qsub/submit.sh

figures : 
	@mkdir -p figures/$(fig_job_tag); cd figures/$(fig_job_tag); ../../gnuplot/plot_all.sh $(fig_job_tag) $(fig_out_tag)
#	cd figures/$(fig_job_tag); gnuplot -e "config=../../output/${fig_job_tag}/${fig_out_tag}_gnu.conf; ../../gnuplot/chisq_distr.gnu


format_data : 
	@cd output/$(form_dat_job_tag); $(EXPORT_FORM_DAT) ../../awk/format_data.sh; echo $(EXPORT_FORM_DAT) | tr " " "\n" | awk 'NF > 0' | sort > $(form_dat_out_tag).config


build : build_allbinaries


build_allbinaries : 
	@ cd src; make binaries;


clean :
	rm -f ./lib/*.o
	find ./bin/ -type f -not -name 'dummy' | xargs rm -f
	rm -f ./src/.depend_cpp
	touch ./src/.depend_cpp


.PHONY: figures
