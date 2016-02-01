# General settings

# Terminal type
set term postscript enh color dashed font "Helvetica,10"

# Global settings
set pm3d map
set palette model RGB
set nokey

# Constants
mh  = 125.
vev = 246.

# Global functions
mA_cba_mH_Z5(x,y,z) = sqrt(y*y*(1-x*x) + (mh*mh*x*x) - (z*vev*vev))
Z5_cba_mH_Z4(x,y,z) = (2*x*x*(mh*mh-y*y)/vev/vev) - z

##########################
### ---  Z7 graph --- ### 
##########################

# Auxiliary

# Labels
set xlabel "cos({/Symbol a} - {/Symbol b})"
set ylabel "m_{H} [GeV/c^{2}]"

# Functions
Z6(x,y) = (mh*mh-y*y)*sqrt(1-x*x)*x/vev/vev

# Title
tanb  = 2.0
beta = atan(tanb)
tan2b = tan(2*beta)
Z7(x,y) = Z6(x,y) + 2*(y*y*(1-x*x)+mh*mh*x*x)/vev/vev/(tan2b)
titletxt = sprintf("Z7 value, mbar^{2} = 0, tan({/Symbol b}) = %.4f", tanb)
set title titletxt font "Helvetica, 12"
Z7_filename = sprintf("| ps2pdf - ./figures/auxiliary/Z7_cosba_mH_tanb_%.2f.pdf", tanb)
set output Z7_filename
splot [-1:1] [300:600] Z7(x,y)

# Title
tanb  = 5.0
beta = atan(tanb)
tan2b = tan(2*beta)
Z7(x,y) = Z6(x,y) + 2*(y*y*(1-x*x)+mh*mh*x*x)/vev/vev/(tan2b)
titletxt = sprintf("Z7 value, mbar^{2} = 0, tan({/Symbol b}) = %.4f", tanb)
set title titletxt font "Helvetica, 12"
Z7_filename = sprintf("| ps2pdf - ./figures/auxiliary/Z7_cosba_mH_tanb_%.2f.pdf", tanb)
set output Z7_filename
splot [-1:1] [300:600] Z7(x,y)

# Title
tanb  = 10.0
beta = atan(tanb)
tan2b = tan(2*beta)
Z7(x,y) = Z6(x,y) + 2*(y*y*(1-x*x)+mh*mh*x*x)/vev/vev/(tan2b)
titletxt = sprintf("Z7 value, mbar^{2} = 0, tan({/Symbol b}) = %.4f", tanb)
set title titletxt font "Helvetica, 12"
Z7_filename = sprintf("| ps2pdf - ./figures/auxiliary/Z7_cosba_mH_tanb_%.2f.pdf", tanb)
set output Z7_filename
splot [-1:1] [300:600] Z7(x,y)

#########################
### --- Z5 graph --- ####
#########################

# Input
Z4 = 5.0

mH = 500
#Z5_filename = sprintf("| ps2pdf - ./figures/auxiliary/Z5_cosba_mH_Z4_%.2f.pdf", Z4)
Z5_filename = sprintf("| ps2pdf - ./figures/auxiliary/Z5_cosba_mA_mH_%.2f.pdf",mH)

# Labels
set xlabel "cos({/Symbol a} - {/Symbol b})"
set ylabel "m_{A} [GeV/c^{2}]"

# Functions
# Here y = mH, x = cos(b-a)
#Z5(x,y) = (2*x*x*(mh*mh-y*y)/vev/vev) - Z4

# Here y = mA, x = cos(b-a)
Z5(x,y) = (2*x*x*(mh*mh-mH*mH)/vev/vev) - ((y*y/vev/vev) - (mH*mH/vev/vev) - (x*x*(mH*mH-mh*mh)/vev/vev))

# Title
#titletxt = sprintf("Z5 value, Z4 = %.4f", Z4)
titletxt = sprintf("Z5 value, m_{H} = %.4f", mH)
set title titletxt font "Helvetica, 12"

# Ranges
#set zrange [-10:10]

set output Z5_filename
splot [-1:1] [150:400] Z5(x,y)

###############################################################
# mA graph
#
## Input
#mh = 125
#
#mA_filename = sprintf("| ps2pdf - ./figures/auxiliary/mA_cosba_mH_Z4.pdf")
#
## Labels
#set xlabel "cos({/Symbol a} - {/Symbol b})"
#set ylabel "m_{H} {GeV/c^{2}}"
#set zlabel "Z4"
#
## Functions
#Z5(x,y) = (2*x*x*(mh*mh-y*y)/vev/vev) - Z4
#
## Title
#titletxt = sprintf("Z5 value, Z4 = %.4f", Z4)
#set title titletxt font "Helvetica, 12"
#
## Ranges
##set zrange [-10:10]
#
#set output Z5_filename
#splot [-1:1] [300:600] Z5(x,y)

###############################################################
# Z4 as a function of cos(b-a) and mA

# Input

# Labels
set xlabel "cos({/Symbol a} - {/Symbol b})"
set ylabel "m_{A} [GeV/c^{2}]"

# Functions

# Ranges
#set zrange [-5:10]

#
mH = 300.
Z4(x,y) = (y*y/vev/vev) - (mH*mH/vev/vev) - (x*x*(mH*mH-mh*mh)/vev/vev)
Z4_filename = sprintf("| ps2pdf - ./figures/auxiliary/Z4_cosba_mA_mH_%.2f.pdf", mH)
titletxt = sprintf("Z4 value, m_{H} = m_{H^{+/-}} = %.2f GeV/c^2", mH)
set title titletxt font "Helvetica, 12"
set output Z4_filename
splot [-1:1] [100:400] Z4(x,y), \
                       (abs(Z4(x,y))<5 ? 1/0:1) with points pt 4 lc -1

#
mH = 500.
Z4(x,y) = (y*y/vev/vev) - (mH*mH/vev/vev) - (x*x*(mH*mH-mh*mh)/vev/vev)
Z4_filename = sprintf("| ps2pdf - ./figures/auxiliary/Z4_cosba_mA_mH_%.2f.pdf", mH)
titletxt = sprintf("Z4 value, m_{H} = m_{H^{+/-}} = %.2f GeV/c^2", mH)
set title titletxt font "Helvetica, 12"
set output Z4_filename
splot [-1:1] [100:400] Z4(x,y), \
                       (abs(Z4(x,y))<5 ? 1/0:1) with points pt 4 lc -1

######
#cba = 0.25
#mH  = 600.
#Z4 = -5.
#mA = 300.
#
#mH = 600.
#Z4(x,y) = (y*y/vev/vev) - (mH*mH/vev/vev) - (x*x*(mH*mH-mh*mh)/vev/vev)
#
##############
#txt1 = sprintf("Z4: %.4f", Z4(cba,mA))
#print "Z4 calculation"
#print "cba: ", cba
#print "mH: ", mH
#print "mA: ", mA
#print txt1
#
############
#Z5val = Z5_cba_mH_Z4(cba,mH,Z4)
#txt2 = sprintf("mA: %.4f", mA_cba_mH_Z5(cba,mH,Z5val))
#print ""
#print "mA calculation"
#print "cba: ", cba
#print "mH: ", mH
#print "Z4: ", Z4
#print txt2
