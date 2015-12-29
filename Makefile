
##############################
## Formatting .dat ASCI txt ##
##############################

form_dat_job_tag = job_cba_tb_50_50
form_dat_out_tag = reduced_test

form_dat_mh    = 125.000000 # Field 1
form_dat_mH    = 300.000000 # Field 2
form_dat_cosba =   0.000000 # Field 3
form_dat_tanb  =   0.000000 # Field 4 
form_dat_Z4    =  -2.000000 # Field 5
form_dat_Z5    =  -2.000000 # Field 6
form_dat_Z7    =   0.000000 # Field 7

form_dat_XVar = 3
form_dat_YVar = 4
form_dat_filterfield1 = 1
form_dat_filterfield2 = 2
form_dat_filterfield3 = 5
form_dat_filterfield4 = 6
form_dat_filterfield5 = 7

form_dat_filterval1 = $(form_dat_mh)
form_dat_filterval2 = $(form_dat_mH)
form_dat_filterval3 = $(form_dat_Z4)
form_dat_filterval4 = $(form_dat_Z5)
form_dat_filterval5 = $(form_dat_Z7)

VAR_FORM_DAT := $(shell echo '$(.VARIABLES)' |  awk -v RS=' ' '/form_dat/')
EXPORT_FORM_DAT := $(foreach v,$(VAR_FORM_DAT),$(v)='$($(v))')

#############################

test :

figures : 

format_data : 
	@ cd output/$(form_dat_job_tag); $(EXPORT_FORM_DAT) ../../awk/format_data.sh

build : build_allbinaries

build_allbinaries : 
	@ cd src; make binaries;

clean :
	rm -f ./lib/*.o
	find ./bin/ -type f -not -name 'dummy' | xargs rm -f
	rm -f ./src/.depend_cpp
	touch ./src/.depend_cpp
