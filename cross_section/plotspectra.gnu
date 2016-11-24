##################################################
### -- chisq_chisqdiff_brazilian.gp plotter -- ###
##################################################

config 		  = basename."_gnu.conf"
load config

XVar = 1

ggZHVar = 2
qqZHVar = 4

row_start = 118
row_stop = 367

pTZ_start = 414
pTZ_stop  = 813

mA = infobox_val1
mA_min = 100.
mA_max = 600.
mA_range = mA_max-mA_min
mA_nBins = 250.0
mA_BinWidth = mA_range/mA_nBins
mA_bin = floor((mA-mA_min)/mA_BinWidth)
gammaA = infobox_val2

mA_neg3gamma = mA - 5.0
mA_pos3gamma = mA + 5.0

mA_neg3gamma_bin = floor((mA_neg3gamma - mA_min)/mA_BinWidth)
mA_pos3gamma_bin = floor((mA_pos3gamma - mA_min)/mA_BinWidth)

print gprintf("mA_bin: %f", mA_bin)


mA_neg3gamma_pos = row_start + mA_neg3gamma_bin
mA_pos3gamma_pos = row_start + mA_pos3gamma_bin
mA_position = row_start + mA_bin

#basename = "benchmark_mA_150.000188_cba_0.104000_tb_2.610000"

fig_out 		  = "| ps2pdf - ".basename.".pdf"
fig_out_cut   = "| ps2pdf - ".basename."_cuttop.pdf"
fig_out_pTZ   = "| ps2pdf - ".basename."_pTZ.pdf"

data_Z        = "< paste ".basename."_ggZH_0.dat ".basename."_qqZH_2.dat "
data_A        = "< paste ".basename."_ggZH_1.dat ".basename."_qqZH_2.dat "
data_AZ       = "< paste ".basename."_ggZH_2.dat ".basename."_qqZH_2.dat "
data_interfer = basename."_ggZH_3.dat"
data_box      = "< paste ".basename."_ggZH_4.dat ".basename."_qqZH_2.dat "
data_tri_box  = "< paste ".basename."_ggZH_5.dat ".basename."_qqZH_2.dat "
data_tri_box_interfer  = "< paste ".basename."_ggZH_5.dat ".basename."_ggZH_2.dat ".basename."_ggZH_4.dat "

# General settings
# Terminal type
set term postscript enhanced color dashed font "Helvetica,10"


# Fit results box
labelx = 0.01
labely = 0.86
boxw = 0.14
boxh = 0.60
rowspace = 0.055

set lmargin at screen 0.25
#set rmargin at screen 0.88
set rmargin at screen 0.70

set object 1 rect from screen (labelx-0.01),(labely-0.02) to screen (labelx+boxw),(labely-boxh) front fillcolor rgb "white" fillstyle solid border -1

set size 0.8,1.0

set label "Hybrid basis:" at screen labelx,(labely) front
set label gprintf(infobox_line1, infobox_val1) at screen labelx,(labely-(1*rowspace)) front
set label gprintf(infobox_line2, infobox_val2) at screen labelx,(labely-(2*rowspace)) front
set label gprintf(infobox_line3, infobox_val3) at screen labelx,(labely-(3*rowspace)) front
set label gprintf(infobox_line4, infobox_val4) at screen labelx,(labely-(4*rowspace)) front
set label gprintf(infobox_line5, infobox_val5) at screen labelx,(labely-(5*rowspace)) front
set label gprintf(infobox_line6, infobox_val6) at screen labelx,(labely-(6*rowspace)) front
set label gprintf(infobox_line7, infobox_val7) at screen labelx,(labely-(7*rowspace)) front
set label gprintf(infobox_line8, infobox_val8) at screen labelx,(labely-(8*rowspace)) front
set label gprintf(infobox_line9, infobox_val9) at screen labelx,(labely-(9*rowspace)) front
set label gprintf(infobox_line10, infobox_val10) at screen labelx,(labely-(10*rowspace)) front

labelsigx = 0.75
labelsigy = 0.43
labelsigrowspace = 0.035

stats data_Z every ::row_start::row_stop using ggZHVar name "Z"
stats data_A every ::row_start::row_stop using ggZHVar name "A"
stats data_AZ every ::row_start::row_stop using ggZHVar name "AZ"
stats data_interfer every ::row_start::mA_position using ggZHVar name "intleft"
stats data_interfer every ::(mA_position+1)::row_stop using ggZHVar name "intright"
stats data_interfer every ::row_start::row_stop using ggZHVar name "int"
stats data_A every ::mA_neg3gamma_pos::mA_pos3gamma_pos using ggZHVar name  "ApeakA"
stats data_AZ every ::mA_neg3gamma_pos::mA_pos3gamma_pos using ggZHVar name "AZpeakA"

sigZ = Z_sum*mA_BinWidth
sigA = A_sum*mA_BinWidth
sigAZ = AZ_sum*mA_BinWidth
sigint_left  = intleft_sum*mA_BinWidth
sigint_right = intright_sum*mA_BinWidth
sigint       = int_sum*mA_BinWidth
sigApeakA    = ApeakA_sum*mA_BinWidth
sigAZpeakA   = AZpeakA_sum*mA_BinWidth

y_max = AZ_mean*10

set label 20 gprintf("{/Symbol s}(Z)   = %.2f fb",   sigZ)  tc lt 6  at screen labelsigx, labelsigy-0*labelsigrowspace front
set label 21 gprintf("{/Symbol s}(A)   = %.2f fb",   sigA)  tc lt 7  at screen labelsigx, labelsigy-1*labelsigrowspace front
set label 22 gprintf("{/Symbol s}(A+Z) = %.2f fb",  sigAZ)  tc lt 1  at screen labelsigx, labelsigy-2*labelsigrowspace front
set label 23 gprintf("{/Symbol s}(interference left)  = %.2f fb", sigint_left)   tc lt 2 at screen labelsigx, labelsigy-3*labelsigrowspace front
set label 24 gprintf("{/Symbol s}(interference right) = %.2f fb", sigint_right)  tc lt 2 at screen labelsigx, labelsigy-4*labelsigrowspace front
set label 25 gprintf("{/Symbol s}(interference tot) = %.2f fb", sigint)          tc lt 2 at screen labelsigx, labelsigy-5*labelsigrowspace front
set label 26 gprintf("{/Symbol s}(A)[m_A+/-5 GeV] = %.2f fb", sigApeakA)         tc rgb "red" at screen labelsigx, labelsigy-6*labelsigrowspace front
set label 27 gprintf("{/Symbol s}(A+Z)[m_A+/-5 GeV] = %.2f fb", sigAZpeakA)      tc rgb "black" at screen labelsigx, labelsigy-7*labelsigrowspace front
set label 28 "w/o any kin. cuts"  tc lt 0 at screen labelsigx, labelsigy-8*labelsigrowspace front
#set label gprintf("mA_bin: %f", mA_bin)  tc lt 0 at screen labelsigx, labelsigy-8*labelsigrowspace front
#set label gprintf("mA_pos: %f", mA_position)  tc lt 0 at screen labelsigx, labelsigy-9*labelsigrowspace front
#set label gprintf("mA_neg-3gamma: %f", mA_neg3gamma_pos)  tc lt 0 at screen labelsigx, labelsigy-10*labelsigrowspace front
#set label gprintf("mA_pos-3gamma: %f", mA_pos3gamma_pos)  tc lt 0 at screen labelsigx, labelsigy-11*labelsigrowspace front

# Load configfile
xlab = "m_{Zh} [GeV/c^{2}]"
ylab = "d{/Symbol s}/dm_{Zh} [fb/GeV]"

set xlabel xlab
set ylabel ylab

set xrange [100:600]
#set yrange [-0.2:1.5]

set output fig_out

### Multiplot stuff
#set size ratio 1
#set title "2HDM Type-II, {/Symbol s} Z/A/(Z+A) interference" font "Helvetica, 12"
#set cblabel "{/Symbol s} [fb]" offset 1.2
#
#set output fig_com
#set multiplot layout 3,1 rowsfirst
#
#set title "2HDM Type-II, {/Symbol s} (gg -> Z -> Zh)" font "Helvetica, 12"
#splot dataFILE every ::1 using XVar:YVar:sigZ   tit "Z"     with points pt 5 palette
#set title "2HDM Type-II, {/Symbol s} (gg -> A -> Zh) " font "Helvetica, 12"
#splot dataFILE every ::1 using XVar:YVar:sigA   tit "A"     with points pt 5 palette
#set title "2HDM Type-II, {/Symbol s} (gg -> Z + A -> Zh) interference " font "Helvetica, 12"
#splot dataFILE every ::1 using XVar:YVar:sigint tit "inter" with points pt 5 palette
#
#unset multiplot


set multiplot layout 2,1 rowsfirst

set title "2HDM Type-II, d{/Symbol s}/dm_{Zh}, LHC at 13 TeV, (gg  qq) -> (q triangle Z+A ) + (q box) -> Zh process" font "Helvetica, 12"
#plot data_tri_box	 every ::row_start::row_stop using XVar:(column(ggZHVar)+column(qqZHVar)) tit 'qqZh+ggZh' with lines lt 1 lc rgb "black"   lw 3 there is comma backslash missing her

plot data_AZ	 every ::row_start::row_stop using XVar:(column(ggZHVar)+column(qqZHVar)) tit 'qqZh+ggZh' with lines lt 1 lc rgb "black"   lw 3, \
     data_Z 		 every ::row_start::row_stop using XVar:(column(qqZHVar))                 tit 'qqZh' with lines lt 5 dashtype 2 lc rgb "magenta" lw 3

set title "2HDM Type-II, d{/Symbol s}/dm_{Zh}, LHC at 13 TeV, (gg) -> (q triangle  Z + A -> Zh) process" font "Helvetica, 12"

#set logscale y
#set yrange [0.001:0.9]

plot data_Z 		          every ::row_start::row_stop using XVar:(column(ggZHVar)) tit 'Z'         with lines lt 2 lc 6 lw 1 dashtype 3, \
     data_A 		          every ::row_start::row_stop using XVar:(column(ggZHVar)) tit 'A'         with lines lt 2 lc 7 lw 1 dashtype 3, \
     data_AZ		          every ::row_start::row_stop using XVar:(column(ggZHVar)) tit 'A+Z'       with lines lt 3 lc 1 lw 3 dashtype 2, \
     data_interfer          every ::row_start::row_stop using XVar:ggZHVar                           tit 'A+Z tri interfer.' with lines lt 3 lc 2   lw 1, \
     data_box               every ::row_start::row_stop using XVar:ggZHVar                           tit 'box' with lines lt 3 lc 4   lw 1, \
     data_tri_box           every ::row_start::row_stop using XVar:ggZHVar                           tit 'tri+box' with lines lt 3 lc 0   lw 3,\
     data_tri_box_interfer  every ::row_start::row_stop using XVar:(column(ggZHVar)-column(4)-column(6))   tit 'tri+box inter' with lines lt 3 lc 6   lw 1

unset multiplot

set output fig_out_cut
set yrange [:y_max]

plot data_Z 		 every ::row_start::row_stop using XVar:ggZHVar tit 'Z'         with lines lt 2 lc 3 lw 1, \
     data_A 		 every ::row_start::row_stop using XVar:ggZHVar tit 'A'         with lines lt 2 lc 1 lw 1, \
     data_AZ		 every ::row_start::row_stop using XVar:ggZHVar tit 'A+Z'       with lines lt 1 lc 0 lw 3, \
     data_interfer every ::row_start::row_stop using XVar:ggZHVar tit 'interfer.' with lines lt 3 lc 2 lw 1

set output fig_out_pTZ

set xlabel "p_{T} (Z) [GeV]"
set ylabel "d{/Symbol s}/dp_{T}(Z) [fb/GeV]"

unset label 20 
unset label 21 
unset label 22 
unset label 23 
unset label 24 
unset label 25 
unset label 26 
unset label 27 

plot data_Z 		          every ::pTZ_start::pTZ_stop using XVar:(column(ggZHVar)) tit 'Z'         with lines lt 2 lc 6 lw 1 dashtype 3, \
     data_A 		          every ::pTZ_start::pTZ_stop using XVar:(column(ggZHVar)) tit 'A'         with lines lt 2 lc 7 lw 1 dashtype 3, \
     data_AZ		          every ::pTZ_start::pTZ_stop using XVar:(column(ggZHVar)) tit 'A+Z'       with lines lt 3 lc 1 lw 3 dashtype 2, \
     data_interfer          every ::pTZ_start::pTZ_stop using XVar:ggZHVar                           tit 'A+Z tri interfer.' with lines lt 3 lc 2   lw 1, \
     data_box               every ::pTZ_start::pTZ_stop using XVar:ggZHVar                           tit 'box' with lines lt 3 lc 4   lw 1, \
     data_tri_box           every ::pTZ_start::pTZ_stop using XVar:ggZHVar                           tit 'tri+box' with lines lt 3 lc 0   lw 3,\
     data_tri_box_interfer  every ::pTZ_start::pTZ_stop using XVar:(column(ggZHVar)-column(4)-column(6))   tit 'tri+box inter' with lines lt 3 lc 6   lw 1


#plot data_Z 		 every ::118::517 using XVar:ggZHVar tit 'Z'         with lines lt 2 lc 3 lw 1, \
#     data_A 		 every ::118::517 using XVar:ggZHVar tit 'A'         with lines lt 2 lc 1 lw 1, \
#     data_AZ		 every ::118::517 using XVar:ggZHVar tit 'A+Z'       with lines lt 1 lc 0 lw 3, \
#     data_interfer every ::118::517 using XVar:ggZHVar tit 'interfer.' with lines lt 3 lc 2 lw 1
