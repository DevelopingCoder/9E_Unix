#!/bin/bash
# Bash Calculator Framework
# CS9E - Assignment 4.1
#
# Framework by Jeremy Huddleston <jeremyhu@cs.berkeley.edu>
# $LastChangedDate: 2007-10-11 15:49:54 -0700 (Thu, 11 Oct 2007) $
# $Id: bashcalc-fw.sh 88 2007-10-11 22:49:54Z selfpace $

## Floating Point Math Functions ##

# bashcalc <expression>
# This function simply passes in the given expressions to 'bc -l' and prints the result

function bashcalc {
	# ADD CODE HERE FOR PART 2
	echo "$1" | bc -l
}

# sine <expression>
# This function prints the cosine of the given expression
function sine {
	# ADD CODE HERE FOR PART 3
	bashcalc "s($1)" 
}
# cosine <expression>
# This function prints the cosine of the given expression
function cosine {
	# ADD CODE HERE FOR PART 3
	bashcalc "c($1)" 
}

# angle_reduce <angle>
# Prints the angle given expressed as a value between 0 and 2pi
function angle_reduce {
	# ADD CODE HERE FOR PART 3
	local pi=$(bashcalc "4*a(1)")
	local simplified_angle=$(bashcalc "scale=0; $1 % 360")
	bashcalc "$simplified_angle*($pi/180)" 	
}
# float_{lt,lte,eq} <expr 1> <expr 2>
# These functions returns true (exit code 0) if the first value is less than the second (lt),
# less than or equal to the second (lte), or equal to the second (eq).
# Note: We can't just use BASH's builtin [[ ... < ... ]] operator because that is
#       for integer math.
function float_lt {
	# ADD CODE HERE FOR PART 3i
	bashcalc "$1 < $2"
}

function float_eq {
	# ADD CODE HERE FOR PART 3
	bashcalc "$1 == $2"
}

function float_lte {
	# ADD CODE HERE FOR PART 3
	bashcalc "$1 <= $2" 
}
