##################################################
### -- chisq_chisqdiff_brazilian.gp plotter -- ###
##################################################

XVar = 1
YVar = 2

#basename = "benchmark_mA_150.000188_cba_0.104000_tb_2.610000"

config 		  = basename."_gnu.conf"
fig_out 		  = "| ps2pdf - ".basename.".pdf"
fig_out_zoom  = "| ps2pdf - ".basename."_zoomed.pdf"
data_Z        = basename."_0.dat" 
data_A        = basename."_1.dat" 
data_AZ       = basename."_2.dat" 
data_interfer = basename."_3.dat" 

load config

# General settings
# Terminal type
set term postscript enhanced color dashed font "Helvetica,10"

set title "2HDM Type-II, d{/Symbol s}/dm_{Zh}, LHC at 13 TeV, (gg -> Z + A -> Zh) process" font "Helvetica, 12"

# Fit results box
labelx = 0.01
labely = 0.86
boxw = 0.14
boxh = 0.60
rowspace = 0.055

set lmargin at screen 0.25
set rmargin at screen 0.88

set object 1 rect from screen (labelx-0.01),(labely-0.02) to screen (labelx+boxw),(labely-boxh) front fillcolor rgb "white" fillstyle solid border -1

set size 0.8,1.0

set label "Hybrid basis:" at screen labelx,(labely) front
set label infobox_line1, infobox_val1 at screen labelx,(labely-(1*rowspace)) front
set label infobox_line2, infobox_val2 at screen labelx,(labely-(2*rowspace)) front
set label infobox_line3, infobox_val3 at screen labelx,(labely-(3*rowspace)) front
set label infobox_line4, infobox_val4 at screen labelx,(labely-(4*rowspace)) front
set label infobox_line5, infobox_val5 at screen labelx,(labely-(5*rowspace)) front
set label infobox_line6, infobox_val6 at screen labelx,(labely-(6*rowspace)) front
set label infobox_line7, infobox_val7 at screen labelx,(labely-(7*rowspace)) front
set label infobox_line8, infobox_val8 at screen labelx,(labely-(8*rowspace)) front
set label infobox_line9, infobox_val9 at screen labelx,(labely-(9*rowspace)) front
set label infobox_line10, infobox_val10 at screen labelx,(labely-(10*rowspace)) front

labelsigx = 0.02
labelsigy = 0.20
labelsigrowspace = 0.035

set label "{/Symbol s}(Z)   = %.2f fb",   sigZ  textcolor rgb "blue"    at screen labelsigx, labelsigy-0*labelsigrowspace front
set label "{/Symbol s}(A)   = %.2f fb",   sigA  textcolor rgb "red"     at screen labelsigx, labelsigy-1*labelsigrowspace front
set label "{/Symbol s}(A+Z) = %.2f fb",  sigAZ  textcolor rgb "black"   at screen labelsigx, labelsigy-2*labelsigrowspace front
set label "{/Symbol s}(int) = %.2f fb", sigint  textcolor rgb "green" at screen labelsigx, labelsigy-3*labelsigrowspace front

# Load configfile
xlab = "m_{ZH} [GeV/c^{2}]"
ylab = "d{/Symbol s}/dm_{Zh}"

set xlabel xlab
set ylabel ylab

set xrange [100:900]

set output fig_out
plot data_Z 		 every ::118::517 using XVar:YVar tit 'Z'         with lines lt 2 lc 3 lw 1, \
     data_A 		 every ::118::517 using XVar:YVar tit 'A'         with lines lt 2 lc 1 lw 1, \
     data_AZ		 every ::118::517 using XVar:YVar tit 'A+Z'       with lines lt 1 lc 0 lw 3, \
     data_interfer every ::118::517 using XVar:YVar tit 'interfer.' with lines lt 3 lc 2 lw 1

set xrange [(infobox_val1-100):(infobox_val1+300)]

set output fig_out_zoom
plot data_Z 		 every ::118::517 using XVar:YVar tit 'Z'         with lines lt 2 lc 3 lw 1, \
     data_A 		 every ::118::517 using XVar:YVar tit 'A'         with lines lt 2 lc 1 lw 1, \
     data_AZ		 every ::118::517 using XVar:YVar tit 'A+Z'       with lines lt 1 lc 0 lw 3, \
     data_interfer every ::118::517 using XVar:YVar tit 'interfer.' with lines lt 3 lc 2 lw 1
