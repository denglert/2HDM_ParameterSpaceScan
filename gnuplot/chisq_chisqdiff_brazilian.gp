# Gnuplot 5.0-3 compatible script

# General settings

# Load configfile
load config

dataFILEbasename = folderPATH.formTAG
dataFILE     = dataFILEbasename."_formated.dat"

fig_chisq     = "| ps2pdf - ".formTAG."_chisq.pdf"
fig_chisqdiff = "| ps2pdf - ".formTAG."_chisqdiff.pdf"
fig_gammaA    = "| ps2pdf - ".formTAG."_gammaA.pdf"
fig_brazilian = "| ps2pdf - ".formTAG."_brazilian.pdf"
fig_brazilian_mA = "| ps2pdf - ".formTAG."_brazilian_mA.pdf"

# - Format - #
cba       =  1
sba       =  2
tb        =  2
Z4        =  4
Z5        =  5
Z7        =  6
m12       =  7
l1        =  8
l2        =  9
l3        = 10
l4        = 11
l5        = 12
l6        = 13
l7        = 14
mh        = 15
mH        = 16
mHc       = 17
mA        = 18
Gammah    = 19
GammaH    = 20
GammaHc   = 21
GammaA    = 22
br_tt     = 23
br_bb     = 24
br_gg     = 25
br_tautau = 26
br_zh     = 27
stb       = 28
uni       = 29
per       = 30
S         = 31
T         = 32
U         = 33
V         = 34
W         = 35
X         = 36
delta_rho = 37
delta_amu = 38
hbobs     = 39
mostsens  = 40
chi       = 41
chidiff   = 42

######################
### --- Format --- ###
######################
# podo "#009e73" green
# podo "#e69f00" gold
# podo "#0072b2" blue

podo_violet = "dark-violet"
podo_green  = "#009e73"
podo_gold   = "#e69f00"
podo_yellow = "#f0e442"
podo_blue   = "#0072b2"

sigma1_color = podo_yellow
sigma2_color = podo_green
sigma3_color = podo_violet
uni_color    = "blue"
stb_color    = "black"
per_color    = "magenta"
hb_color     = "red"

titleformat = "Helvetica, 18"
labelformat = "Helvetica, 16"

# Oblique parameters

# U=0 case:
# HEPfit
#mu_S   = 0.10
#mu_T   = 0.12
#rho_ST = 0.86
#sig_S  = 0.08
#sig_T  = 0.07

# Gfitter
mu_S   = 0.05
mu_T   = 0.09
rho_ST = 0.90
sig_S  = 0.11
sig_T  = 0.13


# Chi square
#chisq_ST(x,y) = ((x - mu_S)**2)/( (sig_S**2)*(1-rho_ST**2) )  - 2.0*(x - mu_S)*( y - mu_T)/(sig_S*sig_T*(1 - rho_ST**2)) + ((y - mu_T)**2)/((sig_T**2)*(1 - rho_ST**2))
chisq_ST(x,y) = ((x - mu_S)**2)/( (sig_S**2)*(1-rho_ST**2) )  - 2.0*rho_ST*(x - mu_S)*( y - mu_T)/(sig_S*sig_T*(1 - rho_ST**2)) + ((y - mu_T)**2)/((sig_T**2)*(1 - rho_ST**2))

# lambda coupling function
lambda(t,u,v,w) = (4.0*sqrt(t*u)*(v+w+sqrt(t*u)) )/ (t+u+2.0*sqrt(t*u))

# Terminal type
set term postscript enh color dashed font "Helvetica,12"

# Fit results box
labelx = -0.05
labely = 0.86
boxw = 0.18
boxh = 0.35
rowspace = 0.055

set tmargin at screen 1.00
set bmargin at screen 0.00
set lmargin at screen 0.21
set rmargin at screen 1.00
set object 1 rect from screen (labelx-0.01),(labely-0.02) to screen (labelx+boxw),(labely-boxh) front fillcolor rgb "white" fillstyle solid border -1
set nokey

set size 0.8,1.0

set label "Hybrid basis:" at screen labelx,(labely) front
set label sprintf(infobox_line1, infobox_val1) at screen labelx,(labely-(1*rowspace)) front
set label sprintf(infobox_line2, infobox_val2) at screen labelx,(labely-(2*rowspace)) front
set label sprintf(infobox_line3, infobox_val3) at screen labelx,(labely-(3*rowspace)) front
set label sprintf(infobox_line4, infobox_val4) at screen labelx,(labely-(4*rowspace)) front
set label sprintf(infobox_line5, infobox_val5) at screen labelx,(labely-(5*rowspace)) front
#set label infobox_line2, infobox_val2 at screen labelx,(labely-(2*rowspace)) front
#set label infobox_line1, infobox_val1 at screen labelx,(labely-(1*rowspace)) front
#set label infobox_line3, infobox_val3 at screen labelx,(labely-(3*rowspace)) front
#set label infobox_line4, infobox_val4 at screen labelx,(labely-(4*rowspace)) front
#set label infobox_line5, infobox_val5 at screen labelx,(labely-(5*rowspace)) front


# Plotting style
set xlabel xlab offset 0,-1 font labelformat
set ylabel ylab offset -1,0 font labelformat

set style data pm3d
set pm3d map
set palette model RGB
set pm3d interpolate 2,2
set xyplane 0 

#set view 20, 160, 1, 1
#set xlabel "cos({/Symbol b}-{/Symbol a)"
#set xrange [0:0.09]

set xrange [-0.70:0.70]
set yrange [-0.5:21]

##############################
### - Sensitive channels - ###
##############################

set key rmargin

set output "| ps2pdf - ".formTAG."_sensitive_ch.pdf"
set title "2HDM Type-II parameter space - HB sensitive channels" font titleformat
splot dataFILE every :::1 using (column(int(XVar))):(column(int(YVar))):(column(int(hbobs)) < 1.0 ? 1/0 : 1) with points pt 4 lc -1 lw 2 tit 'HB. excl', \
         dataFILE every :::1 using (column(int(XVar))):(column(int(YVar))):((column(mostsens)==552) ? 1:1/0) with points pt 3 lc 1 tit '552', \
         dataFILE every :::1 using (column(int(XVar))):(column(int(YVar))):((column(mostsens)==554) ? 1:1/0) with points pt 3 lc 2 tit '554', \
         dataFILE every :::1 using (column(int(XVar))):(column(int(YVar))):((column(mostsens)==531) ? 1:1/0) with points pt 3 lc 3 tit '531', \
         dataFILE every :::1 using (column(int(XVar))):(column(int(YVar))):((column(mostsens)==277) ? 1:1/0) with points pt 3 lc 4 tit '277', \
         dataFILE every :::1 using (column(int(XVar))):(column(int(YVar))):((column(mostsens)==226) ? 1:1/0) with points pt 3 lc 5 tit '226', \
         dataFILE every :::1 using (column(int(XVar))):(column(int(YVar))):((column(mostsens)==211) ? 1:1/0) with points pt 3 lc 6 tit '211', \
         dataFILE every :::1 using (column(int(XVar))):(column(int(YVar))):((column(mostsens)==337) ? 1:1/0) with points pt 3 lc 7 tit '337', \
         dataFILE every :::1 using (column(int(XVar))):(column(int(YVar))):((column(mostsens)==425) ? 1:1/0) with points pt 3 lc 8 tit '425', \
         dataFILE every :::1 using (column(int(XVar))):(column(int(YVar))):((column(mostsens)==148) ? 1:1/0) with points pt 3 lc 9 tit '148', \


set output "| ps2pdf - ".formTAG."_sensitive_ch_excl.pdf"
splot dataFILE every :::1 using (column(int(XVar))):(column(int(YVar))):(column(int(hbobs)) < 1.0 ? 1/0 : 1) with points pt 4 lc -1 lw 2 tit 'HB. excl'


set title "2HDM Type-II parameter space - HB sensitive channel no.s" font titleformat
set output "| ps2pdf - ".formTAG."_sensitive_ch_no.pdf"
plot dataFILE every :3::1 using (column(int(XVar))):(column(int(YVar))):(sprintf('%d', $40)) with labels font "3" notitle
#plot dataFILE every :3::1 using (column(int(XVar))):(column(int(YVar))):(($40==552) ? 3/0:1) with labels font "3" textcolor rgb "red" notitle
#		dataFILE every :::1 using (column(int(XVar))):(column(int(YVar))):(column(per)==1 ? 1/0:1)        with points pt 4 lc rgb per_color 
#	   dataFILE every :3::1 using (column(int(XVar))):(column(int(YVar))):(column(int(hbobs)) < 1.0 ? 1/0 : 1) with points pt 1 lc 1

###############################
### - Chisq distribution -- ###
###############################

set title "2HDM Type-II parameter space {/Symbol c}^2 distribution" font titleformat
set cblabel "{/Symbol c}^2" offset 1.2

fig_chisq     = "| ps2pdf - ".formTAG."_chisq.pdf"
set output fig_chisq
splot dataFILE every :::1 using (column(int(XVar))):(column(int(YVar))):(column(int(chi))) tit ''

###################################
### - Chisqdiff distribution -- ###
###################################

#splot dataFILE using 1:2:($3<2.11?1:1/0) tit ''

set title "2HDM Type-II parameter space {/Symbol D}{/Symbol c}^2 distribution" font titleformat
set cblabel "{/Symbol D}{/Symbol c}^2={/Symbol c}^2_{tot}-{/Symbol c}^2_{min}" offset 1.2

set output fig_chisqdiff
splot dataFILE every :::1 using (column(int(XVar))):(column(int(YVar))):(column(int(chidiff))) tit ''

###############################
### - Gamma distribution -- ###
###############################

#splot dataFILE using 1:2:($3<2.11?1:1/0) tit ''

set title "2HDM Type-II {/Symbol G}_{A} distribution" font titleformat
set cblabel "{/Symbol G}_{A} [GeV]" offset 1.2

set cbrange [0.001:10]
set logscale cb 10

set output fig_gammaA
splot dataFILE every ::1 using (column(int(XVar))):(column(int(YVar))):GammaA tit ''

############################
### - Allowed regions -- ###
############################

set title "2HDM Type-II parameter space excluded/allowed regions" font titleformat
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
set palette defined ( sigma1 sigma1_color,  sigma2 sigma2_color, sigma3 sigma3_color, 15 "white" )
set cntrparam bspline
set cntrparam levels discrete sigma1,sigma2,sigma3

boxh = 0.75
unset object
set object 1 rect from screen (labelx-0.01),(labely-0.02) to screen (labelx+boxw),(labely-boxh) front fillcolor rgb "white" fillstyle solid border -1

set label "Hybrid basis:" at screen labelx,(labely) front
#set label infobox_line1, infobox_val1 at screen labelx,(labely-(1*rowspace)) front
#set label grpintf("%s %.2f", infobox_line1, infobox_val1) at screen labelx,(labely-(1*rowspace)) front

set label 1 sprintf(infobox_line1, infobox_val1) at screen labelx,(labely-(1*rowspace)) front
set label 2 sprintf(infobox_line2, infobox_val2) at screen labelx,(labely-(2*rowspace)) front
set label 3 sprintf(infobox_line3, infobox_val3) at screen labelx,(labely-(3*rowspace)) front
set label 4 sprintf(infobox_line4, infobox_val4) at screen labelx,(labely-(4*rowspace)) front
set label 5 sprintf(infobox_line5, infobox_val5) at screen labelx,(labely-(5*rowspace)) front
set label 6 "1{/Symbol s} h coupling allowed" at screen labelx,(labely-(6*rowspace)) textcolor rgb sigma1_color front
set label 7 "2{/Symbol s} h coupling allowed" at screen labelx,(labely-(7*rowspace)) textcolor rgb sigma2_color front
set label 8 "3{/Symbol s} h coupling allowed" at screen labelx,(labely-(8*rowspace)) textcolor rgb sigma3_color front

# Old gnuplot format
#set label infobox_line2, infobox_val2 at screen labelx,(labely-(2*rowspace)) front
#set label infobox_line3, infobox_val3 at screen labelx,(labely-(3*rowspace)) front
#set label infobox_line4, infobox_val4 at screen labelx,(labely-(4*rowspace)) front
#set label infobox_line5, infobox_val5 at screen labelx,(labely-(5*rowspace)) front
#set label 1 "1 {/Symbol s} exp. fit allowed" at screen labelx,(labely-(6*rowspace)) textcolor rgbcolor "green" front
#set label 2 "2 {/Symbol s} exp. fit allowed" at screen labelx,(labely-(7*rowspace)) textcolor rgbcolor "yellow" front
#set label 3 "3 {/Symbol s} exp. fit allowed" at screen labelx,(labely-(8*rowspace)) textcolor rgbcolor "blue" front

#splot dataFILE every :::1 using (column(int(XVar))):(column(int(YVar))):chidiff, \
#		dataFILE every :::1 using (column(int(XVar))):(column(int(YVar))):(column(per)==1 ? 1/0:1) with points pt 4 lc 13, \
#		dataFILE every :::1 using (column(int(XVar))):(column(int(YVar))):(column(stb)==1 ? 1/0:1) with points pt 2 lc -1, \
#		dataFILE every :::1 using (column(int(XVar))):(column(int(YVar))):(column(uni)==1 ? 1/0:1) with points pt 7 lc  5, \
#		dataFILE every :::1 using (column(int(XVar))):(column(int(YVar))):(column(hbobs) < 1.0 ? 1/0 : 1) with points pt 1 lc 1


#  		dataFILE every :::1 using (column(int(XVar))):(column(int(YVar))):( ( (column(l1) > 0) && (column(l2) >0)  && ( (column(l3) + sqrt(column(l1)*column(l2)) ) > 0 ) && ( lambda(column(l1),column(l2),column(l3),column(l4)) > -0.065) ) ==1 ? 1/0:1) with points pt 2 lc -1, \
#lc=SuperTab('n')
#		dataFILE every :::1 using (column(int(XVar))):(column(int(YVar))):( ( (column(l1) > 0) && (column(l2) >0)  && ( (column(l3) + sqrt(column(l1)*column(l2)) ) > 0 )  ) ==1 ? 1/0:1) with points pt 2 lc -1, \
# 		dataFILE every :::1 using (column(int(XVar))):(column(int(YVar))):( ( (column(l1) > 0) && (column(l2) >0)  && ( (column(l3) + sqrt(column(l1)*column(l2)) ) > 0 ) && ( (column(l3) + column(l4) + sqrt(column(l1)*column(l2)) ) > 0 )  ) ==1 ? 1/0:1) with points pt 2 lc -1, \


# Higgs signal fit only
set output "| ps2pdf - ".formTAG."_allowed_HS.pdf"
splot dataFILE every :::1 using (column(int(XVar))):(column(int(YVar))):chidiff

# + HB
set label 9 "{/ZapfDingbats ;} HB. 95% CL. excl." at screen labelx,(labely-(9*rowspace)) textcolor rgbcolor hb_color front
set output "| ps2pdf - ".formTAG."_allowed_HB.pdf"

splot dataFILE every :::1 using (column(int(XVar))):(column(int(YVar))):chidiff, \
		dataFILE every :::1 using (column(int(XVar))):(column(int(YVar))):(column(hbobs) < 1.0 ? 1/0 : 1) with points pt 1 lc rgb hb_color


# + Unitarity
set label 10 "{/ZapfDingbats l} uni. excluded" at screen labelx,(labely-(10*rowspace)) textcolor rgbcolor uni_color front
set output "| ps2pdf - ".formTAG."_allowed_uni.pdf"

splot dataFILE every :::1 using (column(int(XVar))):(column(int(YVar))):chidiff, \
		dataFILE every :::1 using (column(int(XVar))):(column(int(YVar))):(column(hbobs) < 1.0 ? 1/0 : 1) with points pt 1 lc rgb hb_color, \
		dataFILE every :::1 using (column(int(XVar))):(column(int(YVar))):(column(uni)==1 ? 1/0:1)        with points pt 7 lc rgb uni_color

# + Perturbativity
set label 11 "{/ZapfDingbats o} per. excluded" at screen labelx,(labely-(11*rowspace)) textcolor rgbcolor per_color front
set output "| ps2pdf - ".formTAG."_allowed_per.pdf"

splot dataFILE every :::1 using (column(int(XVar))):(column(int(YVar))):chidiff, \
		dataFILE every :::1 using (column(int(XVar))):(column(int(YVar))):(column(hbobs) < 1.0 ? 1/0 : 1) with points pt 1 lc rgb hb_color, \
		dataFILE every :::1 using (column(int(XVar))):(column(int(YVar))):(column(uni)==1 ? 1/0:1)        with points pt 7 lc rgb uni_color , \
		dataFILE every :::1 using (column(int(XVar))):(column(int(YVar))):(column(per)==1 ? 1/0:1)        with points pt 4 lc rgb per_color 

# + Stability
set label 12 "{/ZapfDingbats 5} stb. excluded" at screen labelx,(labely-(12*rowspace)) textcolor rgbcolor stb_color front
set output "| ps2pdf - ".formTAG."_allowed_stb.pdf"

splot dataFILE every :::1 using (column(int(XVar))):(column(int(YVar))):chidiff, \
		dataFILE every :::1 using (column(int(XVar))):(column(int(YVar))):(column(hbobs) < 1.0 ? 1/0 : 1) with points pt 1 lc rgb hb_color, \
		dataFILE every :::1 using (column(int(XVar))):(column(int(YVar))):(column(uni)==1 ? 1/0:1)        with points pt 7 lc rgb uni_color, \
		dataFILE every :::1 using (column(int(XVar))):(column(int(YVar))):(column(per)==1 ? 1/0:1)        with points pt 4 lc rgb per_color, \
 		dataFILE every :::1 using (column(int(XVar))):(column(int(YVar))):(column(stb)==1 ? 1/0:1)        with points pt 2 lc rgb stb_color



# + Loose stability
unset label 12
set label 12 "{/ZapfDingbats 5} stb. excluded" at screen labelx,(labely-(12*rowspace)) textcolor rgbcolor stb_color front
set output "| ps2pdf - ".formTAG."_allowed_loose-stb.pdf"

splot dataFILE every :::1 using (column(int(XVar))):(column(int(YVar))):chidiff, \
		dataFILE every :::1 using (column(int(XVar))):(column(int(YVar))):(column(hbobs) < 1.0 ? 1/0 : 1) with points pt 1 lc rgb hb_color, \
		dataFILE every :::1 using (column(int(XVar))):(column(int(YVar))):(column(uni)==1 ? 1/0:1)        with points pt 7 lc rgb uni_color, \
		dataFILE every :::1 using (column(int(XVar))):(column(int(YVar))):(column(per)==1 ? 1/0:1)        with points pt 4 lc rgb per_color, \
 		dataFILE every :::1 using (column(int(XVar))):(column(int(YVar))):( ( (column(l1) > 0) && (column(l2) >0)  && ( (column(l3) + sqrt(column(l1)*column(l2)) ) > 0 )  ) ==1 ? 1/0:1) with points pt 2 lc rgb per_color


# Final
set label 6 "1 {/Symbol s}_{HS+ST} fit allowed" at screen labelx,(labely-(6*rowspace)) textcolor rgbcolor sigma1_color front
set label 7 "2 {/Symbol s}_{HS+ST} fit allowed" at screen labelx,(labely-(7*rowspace)) textcolor rgbcolor sigma2_color front
set label 8 "3 {/Symbol s}_{HS+ST} fit allowed" at screen labelx,(labely-(8*rowspace)) textcolor rgbcolor sigma3_color front

set output "| ps2pdf - ".formTAG."_allowed_final.pdf"

splot dataFILE every :::1 using (column(int(XVar))):(column(int(YVar))):(chisq_ST(column(S),column(T))+column(chidiff)), \
		dataFILE every :::1 using (column(int(XVar))):(column(int(YVar))):(column(hbobs) < 1.0 ? 1/0 : 1) with points pt 1 lc rgb hb_color, \
		dataFILE every :::1 using (column(int(XVar))):(column(int(YVar))):(column(uni)==1 ? 1/0:1)        with points pt 7 lc rgb uni_color, \
		dataFILE every :::1 using (column(int(XVar))):(column(int(YVar))):(column(per)==1 ? 1/0:1)        with points pt 4 lc rgb per_color, \
 		dataFILE every :::1 using (column(int(XVar))):(column(int(YVar))):(column(stb)==1 ? 1/0:1)        with points pt 2 lc rgb stb_color


##################################################################################################

############################################
### --- S,T allowed parameter region --- ###
############################################

unset label 6
unset label 7
unset label 8
unset label 9
unset label 10
unset label 11
unset label 12

sigma1 = 1.00  # 1sigma - 68.27% green,  1
sigma2 = 4.00  # 2sigma - 95.45% yellow, 2
sigma3 = 9.00  # 3sigma - 99.73% blue,   0

sigma1_color = podo_yellow
sigma2_color = podo_green
sigma3_color = podo_violet

set pm3d interpolate 4,4
unset cblabel
unset colorbox
unset logscale cb
set cbrange [0:20]
set palette maxcolors 4
set palette defined ( sigma1 sigma1_color,  sigma2 sigma2_color, sigma3 sigma3_color, 15 "white" )
set cntrparam bspline
set cntrparam levels discrete sigma1,sigma2,sigma3

# Gfitter
mu_S   = 0.05
mu_T   = 0.09
rho_ST = 0.90
sig_S  = 0.11
sig_T  = 0.13

set label 6 "68.27% CL contours" at screen labelx,(labely-(6*rowspace)) textcolor rgbcolor sigma1_color front
set label 7 "95.45% CL contours" at screen labelx,(labely-(7*rowspace)) textcolor rgbcolor sigma2_color front
set label 8 "99.73% CL contours" at screen labelx,(labely-(8*rowspace)) textcolor rgbcolor sigma3_color front
set label 9 sprintf("GFitter values:") at screen labelx,(labely-(9*rowspace)) textcolor rgbcolor "black" front
set label 10 sprintf("S = %.2f +/- %.2f", mu_S, sig_S) at screen labelx,(labely-(10*rowspace)) textcolor rgbcolor "black" front
set label 11 sprintf("T = %.2f +/- %.2f", mu_T, sig_T) at screen labelx,(labely-(11*rowspace)) textcolor rgbcolor "black" front
set label 12 sprintf("{/Symbol r}_{ST} = %.2f", rho_ST) at screen labelx,(labely-(12*rowspace)) textcolor rgbcolor "black" front

set title "2HDM Type-II parameter space S,T fit confidence level regions" font titleformat

set label 13 sprintf("1 - CL(a,{/Symbol m}) = Prob({/Symbol D}{/Symbol c}^{2}(a,{/Symbol m}), dim[a]) )") at screen 0.00,0.9 textcolor rgbcolor "black" front
set label 14 sprintf("a = cos({/Symbol b}-{/Symbol a)}, dim[a]=1") at screen 0.00,0.87 textcolor rgbcolor "black" front

set output "| ps2pdf - ".formTAG."_chisqr_ST_allowed.pdf"
splot dataFILE every :::1 using (column(int(XVar))):(column(int(YVar))):(chisq_ST(column(S),column(T))) tit ""

##################################################################################################

unset label 6
unset label 7
unset label 8
unset label 13
unset label 14

unset cblabel
unset logscale cb
unset cntrparam
unset cbrange

set colorbox
set style data pm3d
set pm3d map
set palette
set autoscale cb
set palette model RGB
set pm3d interpolate 2,2
set xyplane 0 

set title "2HDM Type-II parameter space {/Symbol c}^{2}_{ST} distribution" font titleformat
set output "| ps2pdf - ".formTAG."_chisqr_ST.pdf"
splot dataFILE every :::1 using (column(int(XVar))):(column(int(YVar))):(chisq_ST(column(S),column(T))) tit "{/Symbol c}_{ST}"

##

set title "2HDM Type-II parameter space {/Symbol D} {/Symbol r} parameter" font titleformat
set output "| ps2pdf - ".formTAG."_delta_rho.pdf"
splot dataFILE every :::1 using (column(int(XVar))):(column(int(YVar))):delta_rho tit 'drho'



# S
set title "2HDM Type-II parameter space S parameter" font titleformat
set output "| ps2pdf - ".formTAG."_S.pdf"
splot dataFILE every :::1 using (column(int(XVar))):(column(int(YVar))):S tit 'S'

# T
set title "2HDM Type-II parameter space T parameter" font titleformat
set output "| ps2pdf - ".formTAG."_T.pdf"
splot dataFILE every :::1 using (column(int(XVar))):(column(int(YVar))):T tit 'T'

# U
set title "2HDM Type-II parameter space U parameter" font titleformat
set output "| ps2pdf - ".formTAG."_U.pdf"
splot dataFILE every :::1 using (column(int(XVar))):(column(int(YVar))):U tit 'U'

###############
unset label 9
unset label 10
unset label 11
unset label 12

set logscale cb 10
set contour
set cntrparam levels auto 10
unset object 1
set object 1 rect from screen (labelx-0.01),(labely-0.02) to screen (labelx+boxw),(labely-boxh)
#set style textbox opaque noborder margins 0.5, 0.5
set key at screen 0.10,0.50
set style textbox opaque

set cbrange [0.00001:1.0]
set title "2HDM Type-II parameter space: BR(A->{/Symbol t} {/Symbol t})" font titleformat
set output "| ps2pdf - ".formTAG."_br_tautau.pdf"
splot dataFILE every :::1 using (column(int(XVar))):(column(int(YVar))):(column(br_tautau)) tit ""


set title "2HDM Type-II parameter space: BR(A->Zh)" font titleformat
set output "| ps2pdf - ".formTAG."_br_Zh.pdf"
splot dataFILE every :::1 using (column(int(XVar))):(column(int(YVar))):(column(br_zh)) tit ""


set title "2HDM Type-II parameter space: BR(A->bb)" font titleformat
set output "| ps2pdf - ".formTAG."_br_bb.pdf"
splot dataFILE every :::1 using (column(int(XVar))):(column(int(YVar))):(column(br_bb)) tit ""


#####################################################################################
reset

set xrange [-0.70:0.70]
#set yrange [-0.5:21]

# Fit results box
labelx = 0.01
labely = 0.86
boxw = 0.14
boxh = 0.35
rowspace = 0.055

set lmargin at screen 0.21
set rmargin at screen 0.88
boxh = 0.75
unset object
set object 1 rect from screen (labelx-0.01),(labely-0.02) to screen (labelx+boxw),(labely-boxh) front fillcolor rgb "white" fillstyle solid border -1

set label "Hybrid basis:" at screen labelx,(labely) front
#set label infobox_line1, infobox_val1 at screen labelx,(labely-(1*rowspace)) front
#set label grpintf("%s %.2f", infobox_line1, infobox_val1) at screen labelx,(labely-(1*rowspace)) front



set size 0.8,1.0

set label 1 sprintf(infobox_line1, infobox_val1) at screen labelx,(labely-(1*rowspace)) front
set label 2 sprintf(infobox_line2, infobox_val2) at screen labelx,(labely-(2*rowspace)) front
set label 3 sprintf(infobox_line3, infobox_val3) at screen labelx,(labely-(3*rowspace)) front
set label 4 sprintf(infobox_line4, infobox_val4) at screen labelx,(labely-(4*rowspace)) front
set label 5 sprintf(infobox_line5, infobox_val5) at screen labelx,(labely-(5*rowspace)) front
set label 9 sprintf("GFitter values:") at screen labelx,(labely-(9*rowspace)) textcolor rgbcolor "black" front
set label 10 sprintf("S = %.2f +/- %.2f", mu_S, sig_S) at screen labelx,(labely-(10*rowspace)) textcolor rgbcolor "black" front
set label 11 sprintf("T = %.2f +/- %.2f", mu_T, sig_T) at screen labelx,(labely-(11*rowspace)) textcolor rgbcolor "black" front
set label 12 sprintf("{/Symbol r}_{ST} = %.2f", rho_ST) at screen labelx,(labely-(12*rowspace)) textcolor rgbcolor "black" front



# S
set title "2HDM Type-II parameter space S parameter" font titleformat
set output "| ps2pdf - ".formTAG."_cba_S.pdf"
plot dataFILE every :::1 using XVar:S tit ''

# T
set title "2HDM Type-II parameter space T parameter" font titleformat
set output "| ps2pdf - ".formTAG."_cba_T.pdf"
plot dataFILE every :::1 using XVar:T tit ''

# U
set title "2HDM Type-II parameter space U parameter" font titleformat
set output "| ps2pdf - ".formTAG."_cba_U.pdf"
plot dataFILE every :::1 using XVar:U tit ''

# chisqr
set yrange [-1.0:15.0]
set title "2HDM Type-II parameter space {/Symbol c}^{2}_{ST} fit" font titleformat
set output "| ps2pdf - ".formTAG."_cba_chisqr.pdf"
plot dataFILE every :::1 using XVar:(chisq_ST(column(S),column(T))) tit ''


############################
### - Allowed regions -- ###
############################
# as a function of mA
#
#set output fig_brazilian_mA
#
#mh = 125
#mH = 300
#Z5 = -2.00
#vac = 246
#
##mA(x)=sqrt(mH*mH*(1-x*x) + mh*mh*x*x-Z5*vac*vac)
#
##set xrange [370:470]
#
#set xlabel "m_{A} [GeV/c^{2}]"
#splot dataFILE every :::1 using mA:YVar:chidiff
##		dataFILE every :::1 using mA:YVar:(column(stb)==1?-1/0:1) with points pt 2 lc -1, \
##		dataFILE every :::1 using mA:YVar:(column(uni)==1?-1/0:1) with points pt 7 lc  5, \
##		dataFILE every :::1 using mA:YVar:(column(per)==1?-1/0:1) with points pt 4 lc 13
#
#
#
##set key at graph 0.
##set dgrid3d 50,50
##set table "interpolated.dat"
##unset colorbox
##set pm3d map
##set view map
#
## Set for manual
##unset surface
##set table "contour_interpol.dat"
#
#
##unset table
##reset
##set style fill pattern 2
##plot "contour_interpol.dat" every :::1 using 1:2:($3 == sigma1? $3:1/0) with filledcurves lc 3
##     "contour_interpol.dat" every :::1 using 1:2:($3 == sigma2? $3:1/0) with lines lc 2, \
##     "contour_interpol.dat" every :::1 using 1:2:($3 == sigma3? $3:1/0) with lines lc 1
##set pm3d interpolate 6,6
#
##set palette defined ( sigma1 "green", sigma2 "yellow", sigma3 "blue", 20 "white" )
#
##splot dataFILE_chisqdiff every :::1 using 1:2:3
##splot dataFILE_chisqdiff every :::1 using 1:2:($3 <= sigma3 ? 0:1/0 ), \
##		dataFILE_chisqdiff every :::1 using 1:2:($3 <= sigma2 ? 2:1/0 ), \
##      dataFILE_chisqdiff every :::1 using 1:2:($3 <= sigma1 ? 1:1/0 ) , \
##      dataFILE_chisqdiff every :::1 using 1:2:3
##      dataFILE_chisqdiff every ::1 using 1:2:($3 <= sigma1 ? 1:1/0) tit '1 {/Symbol s}' with pm3d
#
#
