# -----------------------------------# 
# For IROS 2011 paper                #  
# HRP2 visual servoing experiment    #
#                                    #
# -----------------------------------#


# -----------------------------------#
# Global settings                    #
# -----------------------------------#

set grid
set key left
set autoscale
set style data lines 
set key on inside right top


debut  = 2500 # first sample line
fin    = 6500 # last salpe line
deltaT = 25   # time step for figure related to time
T0     = 1299229552.91365 # timestamp at the beginning of the expo

# -----------------------------------#
# Error Norm                         #
# -----------------------------------#
set title "Error Norm"
set xtics 0,deltaT,8000
set ytics 0,0.5,5
plot  "dumpcommand.dat" every ::debut::fin using ($1-T0):8 title 'Error Norm'

set terminal postscript eps color lw 3 "Helvetica" 20
set out "res/ErrorNorm.ps"
replot
set term pop

# -----------------------------------#
# Error Values                       #
# -----------------------------------#
set title "Error Values"
set style data lines
set xtics 0,deltaT,8000
set ytics -3,0.5,3
plot  "dumpcommand.dat"   every::debut::fin using ($1-T0):9 title 'tx',\
"dumpcommand.dat"   every ::debut::fin using ($1-T0):10 title 'ty',\
"dumpcommand.dat"   every ::debut::fin using ($1-T0):11 title 'tz',\
"dumpcommand.dat"   every ::debut::fin using ($1-T0):12 title 'rx',\
"dumpcommand.dat"   every ::debut::fin using ($1-T0):13 title 'ry',\
"dumpcommand.dat"   every ::debut::fin using ($1-T0):14 title 'rz'

set terminal postscript eps color lw 1 "Helvetica" 20
set out "res/Error.ps"
replot
set term pop



# -----------------------------------#
# Object position in camera's frame  #
# -----------------------------------#
set title "Position over time"
set autoscale
set xtics 0,deltaT,8000
set ytics -5,0.5,5

plot "dumpcommand.dat"  every ::debut::fin using  ($1-T0):2 title 'x',\
"dumpcommand.dat"  every ::debut::fin using  ($1-T0):3 title 'y',\
"dumpcommand.dat"  every ::debut::fin using  ($1-T0):4 title 'z',\
"dumpcommand.dat"  every ::debut::fin using  ($1-T0):5 title 'rx',\
"dumpcommand.dat"  every ::debut::fin using  ($1-T0):6 title 'ry',\
"dumpcommand.dat"  every ::debut::fin using  ($1-T0):7 title 'rz'

set terminal postscript eps color lw 3 "Helvetica" 20
set out "res/PositionTime.ps"
replot
set term pop


# -----------------------------------#
# Top view of the object position in the cam frame  #
# -----------------------------------#
set title "Position Top view"
set xtics -5,0.5,5
set ytics -5,0.5,5

plot "dumpcommand.dat"  every ::debut::fin u 2:4 title 'position'

set terminal postscript eps color lw 3 "Helvetica" 20
set out "res/PositionTopView.ps"
replot
set term pop

set title " Visual Servoing"
set xtics 0,deltaT,10
set ytics -2,0.2,2
plot "dumpcommand.dat"  every ::debut::fin u ($1-T0):21 title 'vx',\
 "dumpcommand.dat"  every ::debut::fin u ($1-T0):22 title 'vy',\
 "dumpcommand.dat"  every ::debut::fin u ($1-T0):23 title 'vz',\
 "dumpcommand.dat"  every ::debut::fin u ($1-T0):24 title 'rx',\
 "dumpcommand.dat"  every ::debut::fin u ($1-T0):25 title 'ry',\
 "dumpcommand.dat"  every ::debut::fin u ($1-T0):26 title 'rz'

set terminal postscript eps color lw 3 "Helvetica" 20
set out "res/ControlVelocityCam.ps"
replot
set term pop


# -----------------------------------#
# Control sent to the PG             #
# -----------------------------------#
set title "Input Control into the PG"
set xtics 0,deltaT,10
set ytics -2,0.1,2
set yrange [-0.3:0.3]

plot "dumpcommand.dat"  every ::debut::fin u ($1-T0):33 title 'Tx',\
     "dumpcommand.dat"  every ::debut::fin u ($1-T0):34 title 'Ty',\
     "dumpcommand.dat"  every ::debut::fin u ($1-T0):35 title 'rz'

set terminal postscript eps color lw 3 "Helvetica" 20
set out "res/ControlInput.ps"
replot
set term pop


# -----------------------------------#
# Control output from the PG         #
# -----------------------------------#
set title "Output Control from the PG"
set xtics 0,deltaT,10
set ytics -2,0.1,2
set yrange [-0.3:0.3]
plot "dumpcommand.dat"  every ::debut::fin u ($1-T0):39 title 'Tx',\
     "dumpcommand.dat"  every ::debut::fin u ($1-T0):40 title 'Ty'

set terminal postscript eps color lw 3 "Helvetica" 20
set out "res/ControlOutput.ps"
replot
set term pop

