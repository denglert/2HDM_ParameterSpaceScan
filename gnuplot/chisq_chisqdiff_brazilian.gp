##################################################
### -- chisq_chisqdiff_brazilian.gp plotter -- ###
##################################################

# General settings

# Load configfile
load config

dataFILEbasename = folderPATH.formTAG
dataFILE     = dataFILEbasename."_formated.dat"

fig_chisq     = formTAG."_chisq.ps"
fig_chisqdiff = formTAG."_chisqdiff.ps"
fig_gammaA    = "| ps2pdf - ".formTAG."_gammaA.pdf"
fig_brazilian = formTAG."_brazilian.ps"
fig_brazilian_mA = formTAG."_brazilian_mA.ps"

chi      = 8
chidiff  = 26
#chidiff = 22
mA       = 13
XVar     = 3
hbobs    = 9
stb      = 10
uni      = 11
per      = 12
GammaA   = 15

# Terminal type
set term postscript enh color dashed font "Helvetica,10"

# Fit results box
labelx = 0.01
labely = 0.86
boxw = 0.14
boxh = 0.30
rowspace = 0.055

set lmargin at screen 0.20
set rmargin at screen 0.88

set object 1 rect from screen (labelx-0.01),(labely-0.02) to screen (labelx+boxw),(labely-boxh) front fillcolor rgb "white" fillstyle solid border -1

set nokey

set size 0.8,1.0

set label "Hybrid basis:" at screen labelx,(labely) front
set label infobox_line1, infobox_val1 at screen labelx,(labely-(1*rowspace)) front
set label infobox_line2, infobox_val2 at screen labelx,(labely-(2*rowspace)) front
set label infobox_line3, infobox_val3 at screen labelx,(labely-(3*rowspace)) front
set label infobox_line4, infobox_val4 at screen labelx,(labely-(4*rowspace)) front
set label infobox_line5, infobox_val5 at screen labelx,(labely-(5*rowspace)) front

# Plotting style
set xlabel xlab
set ylabel ylab

set style data pm3d
set pm3d map
set palette model RGB
set pm3d interpolate 2,2
set xyplane 0 

#set view 20, 160, 1, 1
#set xlabel "cos({/Symbol b}-{/Symbol a)"
#set xrange [0:0.09]


###############################
### - Chisq distribution -- ###
###############################

set title "2HDM Type-II parameter space {/Symbol c}^2 distribution" font "Helvetica, 12"
set cblabel "{/Symbol c}^2" offset 1.2

set output fig_chisq
splot dataFILE every :::1 using XVar:YVar:chi tit ''

###################################
### - Chisqdiff distribution -- ###
###################################

#splot dataFILE using 1:2:($3<2.11?1:1/0) tit ''

set title "2HDM Type-II parameter space {/Symbol D}{/Symbol c}^2 distribution" font "Helvetica, 12"
set cblabel "{/Symbol D}{/Symbol c}^2={/Symbol c}^2_{tot}-{/Symbol c}^2_{min}" offset 1.2

set output fig_chisqdiff
splot dataFILE every :::1 using XVar:YVar:chidiff tit ''

###############################
### - Gamma distribution -- ###
###############################

#splot dataFILE using 1:2:($3<2.11?1:1/0) tit ''

set title "2HDM Type-II {/Symbol G}_{A} distribution" font "Helvetica, 12"
set cblabel "{/Symbol G}_{A} [GeV]" offset 1.2

set cbrange [0.001:10]
set logscale cb 10

set output fig_gammaA
splot dataFILE every ::1 using XVar:YVar:GammaA tit ''

############################
### - Allowed regions -- ###
############################

set title "2HDM Type-II parameter space excluded/allowed regions" font "Helvetica, 12"
set output fig_brazilian

sigma1 = 2.30   # 1sigma - 68.27% green,  1
sigma2 = 6.18   # 2sigma - 95.45% yellow, 2
sigma3 = 11.83  # 3sigma - 99.73% blue,   0

#set cblabel "{/Symbol D}{/Symbol c}^2={/Symbol c}^2_{tot}-{/Symbol c}^2_{min}" offset 1.2
#set palette defined ( 0 "blue", 1 "green", 2 "yellow", 4 "white" )
#set contour
#unset colorbox
#set xrange [:]
#set yrange [:]
#set style line 1 lc rgb 'black' pt 5   # square
#set style line 2 lc rgb 'black' pt 7   # circle
#set style line 3 lc rgb 'black' pt 9   # triangle

set pm3d interpolate 4,4
unset cblabel
unset colorbox
unset logscale cb
set cbrange [0:20]
set palette maxcolors 4
set palette defined ( sigma1 "green",  sigma2 "yellow", sigma3 "blue", 15 "white" )
set cntrparam bspline
set cntrparam levels discrete sigma1,sigma2,sigma3

boxh = 0.70
unset object
set object 1 rect from screen (labelx-0.01),(labely-0.02) to screen (labelx+boxw),(labely-boxh) front fillcolor rgb "white" fillstyle solid border -1


set label "Hybrid basis:" at screen labelx,(labely) front
set label infobox_line1, infobox_val1 at screen labelx,(labely-(1*rowspace)) front
set label infobox_line2, infobox_val2 at screen labelx,(labely-(2*rowspace)) front
set label infobox_line3, infobox_val3 at screen labelx,(labely-(3*rowspace)) front
set label infobox_line4, infobox_val4 at screen labelx,(labely-(4*rowspace)) front
set label infobox_line5, infobox_val5 at screen labelx,(labely-(5*rowspace)) front
set label "1 {/Symbol s} exp. fit allowed" at screen labelx,(labely-(6*rowspace)) textcolor rgbcolor "green" front
set label "2 {/Symbol s} exp. fit allowed" at screen labelx,(labely-(7*rowspace)) textcolor rgbcolor "yellow" front
set label "3 {/Symbol s} exp. fit allowed" at screen labelx,(labely-(8*rowspace)) textcolor rgbcolor "blue" front
set label "{/ZapfDingbats 5} stb. excluded" at screen labelx,(labely-(9*rowspace)) textcolor rgbcolor "black" front
set label "{/ZapfDingbats l} uni. excluded" at screen labelx,(labely-(10*rowspace)) textcolor rgbcolor "cyan" front
set label "{/ZapfDingbats o} per. excluded" at screen labelx,(labely-(11*rowspace)) textcolor rgbcolor "magenta" front
set label "{/ZapfDingbats ;} HB. 95% CL. excl." at screen labelx,(labely-(12*rowspace)) textcolor rgbcolor "red" front

splot dataFILE every :::1 using XVar:YVar:chidiff, \
		dataFILE every :::1 using XVar:YVar:(column(per)==1 ? 1/0:1) with points pt 4 lc 13, \
		dataFILE every :::1 using XVar:YVar:(column(stb)==1 ? 1/0:1) with points pt 2 lc -1, \
		dataFILE every :::1 using XVar:YVar:(column(uni)==1 ? 1/0:1) with points pt 7 lc  5, \
		dataFILE every :::1 using XVar:YVar:(column(hbobs) < 1.0 ? 1/0 : 1) with points pt 1 lc 1

############################
### - Allowed regions -- ###
############################
# as a function of mA

set output fig_brazilian_mA

mh = 125
mH = 300
Z5 = -2.00
vac = 246

#mA(x)=sqrt(mH*mH*(1-x*x) + mh*mh*x*x-Z5*vac*vac)

#set xrange [370:470]

set xlabel "m_{A} [GeV/c^{2}]"
splot dataFILE every :::1 using mA:YVar:chidiff
#		dataFILE every :::1 using mA:YVar:(column(stb)==1?-1/0:1) with points pt 2 lc -1, \
#		dataFILE every :::1 using mA:YVar:(column(uni)==1?-1/0:1) with points pt 7 lc  5, \
#		dataFILE every :::1 using mA:YVar:(column(per)==1?-1/0:1) with points pt 4 lc 13



#set key at graph 0.
#set dgrid3d 50,50
#set table "interpolated.dat"
#unset colorbox
#set pm3d map
#set view map

# Set for manual
#unset surface
#set table "contour_interpol.dat"


#unset table
#reset
#set style fill pattern 2
#plot "contour_interpol.dat" every :::1 using 1:2:($3 == sigma1? $3:1/0) with filledcurves lc 3
#     "contour_interpol.dat" every :::1 using 1:2:($3 == sigma2? $3:1/0) with lines lc 2, \
#     "contour_interpol.dat" every :::1 using 1:2:($3 == sigma3? $3:1/0) with lines lc 1
#set pm3d interpolate 6,6

#set palette defined ( sigma1 "green", sigma2 "yellow", sigma3 "blue", 20 "white" )

#splot dataFILE_chisqdiff every :::1 using 1:2:3
#splot dataFILE_chisqdiff every :::1 using 1:2:($3 <= sigma3 ? 0:1/0 ), \
#		dataFILE_chisqdiff every :::1 using 1:2:($3 <= sigma2 ? 2:1/0 ), \
#      dataFILE_chisqdiff every :::1 using 1:2:($3 <= sigma1 ? 1:1/0 ) , \
#      dataFILE_chisqdiff every :::1 using 1:2:3
#      dataFILE_chisqdiff every ::1 using 1:2:($3 <= sigma1 ? 1:1/0) tit '1 {/Symbol s}' with pm3d


