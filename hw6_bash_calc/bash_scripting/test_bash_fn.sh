#!/bin/bash

source bashcalc-fw.sh  
#Test Part 1


if [[ $(./bashcalc-1.sh "s(3.14159*0.25)") != .70710631209355760535 ]]
then 
	echo "Part 1 Unsuccessful"
fi

if [[ $(./bashcalc-1.sh "5 * 3") != 15 ]]
then
        echo "Part 1 Unsuccessful"
fi

#Test Part 2

#Test bashcalc-1.sh behaves like bashcalc
if [[ $(./bashcalc-1.sh "s(3.14159*0.25)") != $(bashcalc "s(3.14159*0.25)") ]]
then
	echo "Part 2.1 Unsucessful"
fi

#Test sine
if [[ $(sine "3.14159*0.25") != $(bashcalc "s(3.14159*0.25)") ]]
then
        echo "Sine Unsucessful"
fi

#Test Cosine
if [[ $(cosine "3.14159*0.25") != $(bashcalc "c(3.14159*0.25)") ]]
then
        echo "Cosine Unsucessful"
fi

#Test AngleReduce
if [[ $(bashcalc "2 * $(angle_reduce 90)") != $(angle_reduce "180") ]]
then
	echo "Angle reduce unsuccessful" 
fi

if [[ $(angle_reduce "450") != $(angle_reduce "90") ]] 
then
	echo "Angle reduce unsuccessful"
fi

#Test Float Less Than
if [[ $(float_lt 3.0 4.1) != 1 ]]
then
	echo "float_lt unsucessful"
fi

if [[ $(float_lt 3.2 3.2) != 0 ]]
then
        echo "float_lt unsucessful"
fi

if [[ $(float_lt 4.2 3.2) != 0 ]]
then
        echo "float_lt unsucessful"
fi

#Test Float less than equals
if [[ $(float_lte 3.2 3.2) != 1 ]]
then
        echo "float_lte unsucessful"
fi

if [[ $(float_lte 3.0 4.1) != 1 ]]
then
        echo "float_lte unsucessful"
fi

if [[ $(float_lte 4.2 3.2) != 0 ]]
then
        echo "float_lte unsucessful"
fi

#Test float equals

if [[ $(float_eq 19.2 13.0) != 0 ]]
then
	echo "float_eq unsucessful"
fi

if [[ $(float_eq 13.0 13.0) != 1 ]]
then
        echo "float_eq unsucessful"
fi

