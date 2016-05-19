dataFile = "comparison"
fig_out  = "| ps2pdf - comparison.pdf"

set term postscript enhanced color dashed font "Helvetica,12"

set output fig_out

binwidth = 1e3
bin(x,width)=width*floor(x/width)


#set yrange [0:1e10]


# Histogram
#set xrange [0:1e8]
#set xlabel "ratio = new/original"
#set ylabel "frequency"
#plot dataFile using (bin($3,binwidth)):(1.0) smooth freq with boxes
#plot dataFile using 3

# Correlation
set xlabel "calculation #"
set ylabel "ratio"

#set yrange restore

#stats dataFile using 1 name "stef"
#stats dataFile using 2 name "matt"
#stats dataFile using 3 name "dave"
#
#s_mean = stef_mean
#m_mean = matt_mean
#d_mean = dave_mean

#set yrange [0.995:1.005]
set yrange [0.5:1.5]

#set label 1 "Off-shell case" at graph 0.2, 0.8
#set label 2 "David z=p_z^2" at graph 0.2, 0.75
#set label 3 "Matt z=m_Z^2" at graph 0.2, 0.70

#set label 1 gprintf("r_{mean} %.8f", (s_mean/d_mean)/(32)) at graph 0.1, 0.9
#set label 2 gprintf("r_{mean} %.8f", (s_mean/d_mean)/(32*pi*pi)) at graph 0.1, 0.85
#set label 3 gprintf("r_{mean} %.8f", (s_mean/d_mean)/(32*pi*pi*pi)) at graph 0.1, 0.80

set multiplot layout 3, 2 title "Comparison of the different implementations of gg->Zh amplitude (SM scenario)"

plot dataFile using (column(0)):(($1)/($3)) lt 1 lc 1 tit 'Stefano/(David old)     (triangle only)'

plot dataFile using (column(0)):(($1)/($2)) lt 1 lc 2 tit '(Stefano)/(Matt old) (triangle only)'

plot dataFile using (column(0)):(($5)/($3)) lt 1 lc 3 tit '(David new)/(David old) (triangle only)'

plot dataFile using (column(0)):(($4)/($2)) lt 1 lc 4 tit '(Matt new)/(Matt old) (triangle only)'

plot dataFile using (column(0)):(($6)/($7)) lt 2 lc 5 tit '(Matt new)/(David new) (tri+box)'

unset multiplot
#	  dataFile using (column(0)):(($2)/($3)) lt 3 lc 3 tit 'Matt/David'
#	  dataFile using (column(0)):3 lt 1 lc 3 tit 'my code'

