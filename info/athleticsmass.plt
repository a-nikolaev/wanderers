
set style line 1 lt 1 lc rgb "#eeaa22" lw 2
set style line 2 lt 1 lc rgb "#aaee22" lw 2
set style line 3 lt 1 lc rgb "#22eeaa" lw 2

set lmargin 10.0
set rmargin 4.0
set bmargin 4.0
set tmargin 3.0

set grid

set output "athleticsmass.eps"
set terminal postscript eps enhanced color lw 1.8 size 10cm, 10cm # width, height
set multiplot layout 1,1

set xrange [-0.2:1.2]
set yrange [0:*]

f(x) = 5.5*log(x+0.4) + 14.5

plot 50 + 50*x ls 1, 5.5*(8.5 + 7.5*sqrt(x)) ls 2, 5.5*(f(x)) ls 3

unset multiplot
