##################################################
### -- chisq_chisqdiff_brazilian.gp plotter -- ###
##################################################

# General settings

# Load configfile

dataFILE = "combined".mA.".txt"

fig_Z 	="| ps2pdf - "."mA_".mA."_sigma_Z.pdf"
fig_A 	="| ps2pdf - "."mA_".mA."_sigma_A.pdf"
fig_int 	="| ps2pdf - "."mA_".mA."_sigma_AZinterference.pdf"
fig_com 	="| ps2pdf - "."mA_".mA."_combined.pdf"

chi      = 8
chidiff  = 26
#chidiff = 22
XVar     = 5
YVar     = 4
hbobs    = 9
stb      = 10
uni      = 11
per      = 12
GammaA   = 15
sigZ     = 1
sigA     = 2
sigint   = 3

xlab = "cos({/Symbol b}-{/Symbol a})"
ylab = "tan({/Symbol b})"
# Terminal type
set term postscript portrait enh color dashed font "Helvetica,10"

# Fit results box
labelx = 0.01
labely = 0.86
boxw = 0.14
boxh = 0.30
rowspace = 0.055

set lmargin at screen 0.20
set rmargin at screen 0.88

#set object 1 rect from screen (labelx-0.01),(labely-0.02) to screen (labelx+boxw),(labely-boxh) front fillcolor rgb "white" fillstyle solid border -1

set nokey

#set size 0.8,1.0

#set label "Hybrid basis:" at screen labelx,(labely) front
#set label "m_{A} = %.2f GeV", mA at screen labelx,(labely-(1*rowspace)) front
#set label infobox_line2, infobox_val2 at screen labelx,(labely-(2*rowspace)) front
#set label infobox_line3, infobox_val3 at screen labelx,(labely-(3*rowspace)) front
#set label infobox_line4, infobox_val4 at screen labelx,(labely-(4*rowspace)) front
#set label infobox_line5, infobox_val5 at screen labelx,(labely-(5*rowspace)) front

# Plotting style
set xlabel xlab
set ylabel ylab

#set style data pm3d
#set pm3d map
#set palette model RGB
#set pm3d interpolate 2,2
#set xyplane 0 

set pm3d map
#set palette model RGB
#set dgrid3d 51,51
#set pm3d interpolate 2,2
set xyplane 0 


#set view 20, 160, 1, 1
#set xlabel "cos({/Symbol b}-{/Symbol a)"
#set xrange [0:0.09]


###############################
### - Chisq distribution -- ###
###############################
#
#set title "2HDM Type-II parameter space {/Symbol c}^2 distribution" font "Helvetica, 12"
#set cblabel "{/Symbol c}^2" offset 1.2
#
#set output fig_chisq
#splot dataFILE every :::1 using XVar:YVar:chi tit ''
#
####################################
#### - Chisqdiff distribution -- ###
####################################
#
##splot dataFILE using 1:2:($3<2.11?1:1/0) tit ''
#
#set title "2HDM Type-II parameter space {/Symbol D}{/Symbol c}^2 distribution" font "Helvetica, 12"
#set cblabel "{/Symbol D}{/Symbol c}^2={/Symbol c}^2_{tot}-{/Symbol c}^2_{min}" offset 1.2
#
#set output fig_chisqdiff
#splot dataFILE every :::1 using XVar:YVar:chidiff tit ''

###############################
### - Gamma distribution -- ###
###############################

#splot dataFILE using 1:2:($3<2.11?1:1/0) tit ''

set xrange [-1.0:1.0]
set yrange [0:10.0]


###########################
### - Z contribution -- ###
###########################

set title "2HDM Type-II, {/Symbol s} (gg -> Z -> Zh)" font "Helvetica, 12"
set cblabel "{/Symbol s} [fb]" offset 1.2

#set output fig_Z 
#splot dataFILE every ::1 using XVar:YVar:sigZ tit "" with points pt 5 palette

###########################
### - A contribution -- ###
###########################

set title "2HDM Type-II, {/Symbol s} (gg -> A -> Zh) " font "Helvetica, 12"
set cblabel "{/Symbol s} [fb]" offset 1.2

#set output fig_A 
#splot dataFILE every ::1 using XVar:YVar:sigA tit "" with points pt 5 palette

##########################################
### - A+Z interference contribution -- ###
##########################################

set title "2HDM Type-II, {/Symbol s} (gg -> Z + A -> Zh) interference " font "Helvetica, 12"
set cblabel "{/Symbol s} [fb]" offset 1.2

#set output fig_int
#splot dataFILE every ::1 using XVar:YVar:sigint tit "" with points pt 5 palette


#####################
### - Combined -- ###
#####################

#set size ratio 1
set title "2HDM Type-II, {/Symbol s} Z/A/(Z+A) interference" font "Helvetica, 12"
set cblabel "{/Symbol s} [fb]" offset 1.2

set output fig_com
set multiplot layout 3,1 rowsfirst

set title "2HDM Type-II, {/Symbol s} (gg -> Z -> Zh)" font "Helvetica, 12"
splot dataFILE every ::1 using XVar:YVar:sigZ   tit "Z"     with points pt 5 palette
set title "2HDM Type-II, {/Symbol s} (gg -> A -> Zh) " font "Helvetica, 12"
splot dataFILE every ::1 using XVar:YVar:sigA   tit "A"     with points pt 5 palette
set title "2HDM Type-II, {/Symbol s} (gg -> Z + A -> Zh) interference " font "Helvetica, 12"
splot dataFILE every ::1 using XVar:YVar:sigint tit "inter" with points pt 5 palette

unset multiplot
