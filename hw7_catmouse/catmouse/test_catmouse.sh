#!/bin/bash

source catmouse-fw.sh
#Test angle_reduce
if ! angle_between 10 20 30 ; then
	echo "angle_between1 failure"
fi

if ! angle_between 350 20 50 ; then
	echo "angle_between2 failure"
fi

if angle_between 30 20 40 ; then
	echo "angle_between3 failure"
fi

#Test Does_cat_see_mouse
if ! does_cat_see_mouse 0 "1.5" 5 ; then
	echo "cat_see_mouse1 failure"
fi

if does_cat_see_mouse 0 1 180 ; then
	echo "cat_see_mouse2 failure"
fi

if ! does_cat_see_mouse 0 2 10 ; then
    echo "cat_see_mouse3 failure"
fi


#Test next_step
#Params: $state $steps $cat_angle $cat_radius $mouse_angle $max_steps)
if [[ $(next_step 0 1 0 1 0 5) != "2 1 0 1 0 5" ]] ; then
	echo "next_step1 failure"
fi

pi=$(bashcalc "4*a(1)")
new_mouse_angle=$(bashcalc "1 * (180/$pi)")

if [[ $(next_step 0 1 0 2 0 5) != "0 2 0 1 $new_mouse_angle 5" ]] ; then
	echo "next_step2 failure"
fi
