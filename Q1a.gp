set datafile separator ","
set terminal png
set output "Q1a_current.png"
set key outside
set grid
set title "Transmission Gate plot: Ic vs Vin"
set ylabel "Output Current (Ic) in Amperes"
set xlabel "Input Voltage (Vin) in Volts"
set style line 1 pointtype 7 linecolor rgb '#9400d3'
plot "Q1_current.csv" using 1:2 title "" with linespoints linestyle 1