##################################################
### -- chisq_chisqdiff_brazilian.gp plotter -- ###
##################################################

folderPATH = "../../output/RB_test_run/"

# General settings
# Terminal type
set term postscript enh color dashed font "Helvetica,10"

cba 			  = 3
tb  			  = 1
rchi2combined = 20

dataFILEbasename = folderPATH
dataFILEcom68  = folderPATH."2hdm.typ2m1_com5.68"
dataFILEcom95  = folderPATH."2hdm.typ2m1_com5.95"
dataFILEcom99  = folderPATH."2hdm.typ2m1_com5.99"

fig_cba_tanb = "| ps2pdf - cosba-tanb.pdf"
fig_mA       = "| ps2pdf - mA.pdf"


msg = sprintf("filename: %s", dataFILEcom68)
print msg


set xlabel "cos({/Symbol b}-{/Symbol a})"
set ylabel "tan({/Symbol b})"

set xrange [-1.0:1.0]
set yrange [0:20.0]

set output fig_cba_tanb

plot dataFILEcom95 using cba:tb lt 1 lc rgb "green" tit "99 %", \
	  dataFILEcom95 using cba:tb lt 1 lc rgb "yellow" tit "95 %", \
     dataFILEcom68 using cba:tb lt 1 lc rgb "blue" tit "68 %"

#################################################################3

set xlabel ""
set ylabel ""

set autoscale x
set autoscale y

set output "| ps2pdf - chisqcombined.pdf"
plot dataFILEcom95 using 1:rchi2combined lt 1 lc rgb "black" tit "chisq"
