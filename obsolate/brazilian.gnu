set title "2HDM Type-II parameter space {/Symbol D}{/Symbol c}^2 distribution" font "Helvetica, 12"

dataFILE="./chisquare_reduced.dat"

#set pm3d
set style data pm3d
set pm3d map
set palette model RGB

set term postscript enh color dashed font "Helvetica,10"
set output "./paramspace_chisq.ps"

set pm3d interpolate 2,2

set xyplane 0 
#set view 20, 160, 1, 1

#set xlabel "cos({/Symbol b}-{/Symbol a)"

#set xrange [0:0.09]

#   Fit results box  #
labelx=0.08
labely=0.88
boxw=0.17
boxh=0.30
rowspace=0.055

set object 1 rect from graph (labelx-0.01),(labely-boxh) to graph (labelx+boxw),(labely+0.035) front fillcolor rgb "white" fillstyle solid 1.0 border 0

set nokey


set label "Hybrid basis:" at graph labelx,(labely) front
set label "m_{h} = 125 GeV/c^{2}" at graph labelx,(labely-rowspace) front
set label "m_{H} = 300 GeV/c^{2}"at graph labelx,(labely-(2*rowspace)) front
set label "Z4 = -2" at graph labelx,(labely-(3*rowspace)) front
set label "Z5 = -2" at graph labelx,(labely-(4*rowspace)) front
set label "Z7 =  0" at graph labelx,(labely-(5*rowspace)) front

set yrange [1.0:10]

set xlabel "cos({/Symbol b}-{/Symbol a)"
set ylabel "tan({/Symbol b})"
#set zlabel "{/Symbol c}" rotate by 90
set cblabel "{/Symbol D}{/Symbol c}^2={/Symbol c}^2_{tot}-{/Symbol c}^2_{min}" offset 1.2

splot dataFILE using 1:2:3 tit ''
#splot dataFILE using 1:2:($3<2.11?1:1/0) tit ''
