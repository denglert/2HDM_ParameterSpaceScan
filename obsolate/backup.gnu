#set pm3d
load config

set style data pm3d
set pm3d map
set palette model RGB

dataFILEbasename = folderPATH.formTAG
dataFILE_chisq     = dataFILEbasename."_chisq.dat"
dataFILE_chisqdiff = dataFILEbasename."_chisqdiff.dat"

fig_chisq     = formTAG."_chisq.ps"
fig_chisqdiff = formTAG."_chisqdiff.ps"
fig_brazilian = formTAG."_brazilian.ps"

set term postscript enh color dashed font "Helvetica,10"
set output fig_chisq

set pm3d interpolate 2,2

set xyplane 0 

#set view 20, 160, 1, 1
#set xlabel "cos({/Symbol b}-{/Symbol a)"
#set xrange [0:0.09]

#   Fit results box  #
labelx = 0.01
labely = 0.86
boxw = 0.14
boxh = 0.30
rowspace = 0.055

set lmargin at screen 0.20
set rmargin at screen 0.88

set object 1 rect from screen (labelx-0.01),(labely-0.02) to screen (labelx+boxw),(labely-boxh) front fillcolor rgb "white" fillstyle solid border -1

set nokey

set xlabel xlab
set ylabel ylab

set size 0.8,1.0

set label "Hybrid basis:" at screen labelx,(labely) front
set label infobox_line1, infobox_val1 at screen labelx,(labely-(1*rowspace)) front
set label infobox_line2, infobox_val2 at screen labelx,(labely-(2*rowspace)) front
set label infobox_line3, infobox_val3 at screen labelx,(labely-(3*rowspace)) front
set label infobox_line4, infobox_val4 at screen labelx,(labely-(4*rowspace)) front
set label infobox_line5, infobox_val5 at screen labelx,(labely-(5*rowspace)) front

set title "2HDM Type-II parameter space {/Symbol c}^2 distribution" font "Helvetica, 12"
set cblabel "{/Symbol c}^2" offset 1.2


splot dataFILE_chisq every :::1 using 1:2:3 tit ''
#splot dataFILE using 1:2:($3<2.11?1:1/0) tit ''

set title "2HDM Type-II parameter space {/Symbol D}{/Symbol c}^2 distribution" font "Helvetica, 12"
set cblabel "{/Symbol D}{/Symbol c}^2={/Symbol c}^2_{tot}-{/Symbol c}^2_{min}" offset 1.2
set output fig_chisqdiff

splot dataFILE_chisqdiff every :::1 using 1:2:3 tit ''

###

set title "2HDM Type-II parameter space exclusion region" font "Helvetica, 12"
#set cblabel "{/Symbol D}{/Symbol c}^2={/Symbol c}^2_{tot}-{/Symbol c}^2_{min}" offset 1.2
set output fig_brazilian

sigma1 = 2.30   # green,  1
sigma2 = 6.18   # yellow, 2
sigma3 = 11.83  # blue,   0

#set palette defined ( 0 "blue", 1 "green", 2 "yellow", 4 "white" )


set pm3d interpolate 4,4
unset cblabel
unset colorbox
set cbrange [0:20]
set palette maxcolors 4
set palette defined ( sigma1 "green",  sigma2 "yellow", sigma3 "blue", 15 "white" )
set cntrparam bspline
set cntrparam levels discrete sigma1,sigma2,sigma3
#set contour

#unset colorbox

#set xrange [:]
#set yrange [:]

mh = 125
mH = 300
Z5 = -2.00
vac = 246

mA(x)=sqrt(mH*mH*(1-x*x) + mh*mh*x*x-Z5*vac*vac)

#set key at graph 0.
#set dgrid3d 50,50
#set table "interpolated.dat"
#unset colorbox
#set pm3d map
#set view map

# Set for manual
#unset surface
#set table "contour_interpol.dat"

splot dataFILE_chisqdiff every :::1 using 1:2:3

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
