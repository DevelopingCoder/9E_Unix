#!/bin/bash
# Cat & Mouse Framework
# CS9E - Assignment 4.2
#
# Framework by Jeremy Huddleston <jeremyhu@cs.berkeley.edu>
# $LastChangedDate: 2007-10-11 15:49:54 -0700 (Thu, 11 Oct 2007) $
# $Id: catmouse-fw.sh 88 2007-10-11 22:49:54Z selfpace $

# Source the file containing your calculator functions:
. bashcalc-fw.sh

# Additional math functions:

# angle_between <A> <B> <C>
# Returns true (exit code 0) if angle B is between angles A and C and false otherwise
function angle_between {
	local A=$(angle_reduce $1)
	local B=$(angle_reduce $2)
	local C=$(angle_reduce $3)

	# ADD CODE HERE FOR PART 1
    cond_1=$(float_lt $(cosine $(bashcalc "$C - $A")) $(cosine $(bashcalc "$B - $A")))
    cond_2=$(float_lt $(cosine $(bashcalc "$C - $A")) $(cosine $(bashcalc "$C - $B")))
    
    [[ $cond_1 == 1 ]] && [[ $cond_2 == 1 ]]
}

### Simulation Functions ###
# Variables for the state
RUNNING=0
GIVEUP=1
CAUGHT=2

# does_cat_see_mouse <cat angle> <cat radius> <mouse angle>
#
# Returns true (exit code 0) if the cat can see the mouse, false otherwise.
#
# The cat sees the mouse if
# (cat radius) * cos (cat angle - mouse angle)
# is at least 1.0.
function does_cat_see_mouse {
	local cat_angle=$(angle_reduce $1)
	local cat_radius=$2
	local mouse_angle=$(angle_reduce $3)

	# ADD CODE HERE FOR PART 1
	cos_term=$(cosine $(bashcalc "$cat_angle - $mouse_angle"))
	[[ $(float_lte "1.0" "$cat_radius * $cos_term") == 1 ]]
}


# next_step <current state> <current step #> <cat angle> <cat radius> <mouse angle> <max steps>
# returns string output similar to the input, but for the next step:
# <state at next step> <next step #> <cat angle> <cat radius> <mouse angle> <max steps>
#
# exit code of this function (return value) should be the state at the next step.  This allows for easy
# integration into a while loop.
function next_step {
	local state=$1
	local -i step=$2
	local old_cat_angle=$3
	local old_cat_radius=$4
	local old_mouse_angle=$5
	local -i max_steps=$6

	local new_cat_angle=${old_cat_angle}
	local new_cat_radius=${old_cat_radius}
	local new_mouse_angle=${old_mouse_angle}
	local -i statue_radius=1
	local pi=$(bashcalc "4*a(1)")

	# First, make sure we are still running
	if (( ${state} != ${RUNNING} )) ; then
		echo ${state} ${step} ${old_cat_angle} ${old_cat_radius} ${old_mouse_angle} ${max_steps}
		return ${state}
	fi

	# ADD CODE HERE FOR PART 2

	#Corner case
	if [[ $new_cat_radius == $statue_radius ]] && [[ $old_cat_angle == $old_mouse_angle ]] ; then
		state=$CAUGHT
		echo ${state} ${step} ${old_cat_angle} ${old_cat_radius} ${old_mouse_angle} ${max_steps}
		return ${state}
	fi

	# Move the cat first
	if [[ $old_cat_radius != $statue_radius ]] && $(does_cat_see_mouse $old_cat_angle $old_cat_radius $old_mouse_angle); then
		# Move the cat in if it's not at the statue and it can see the mouse
		new_cat_radius=$(bashcalc "$old_cat_radius - 1")
		if [[ $new_cat_radius < $statue_radius ]]; then
			new_cat_radius=$statue_radius
		fi
		new_cat_angle=$old_cat_angle
	else
		# Move the cat around if it's at the statue or it can't see the mouse
		# Check if the cat caught the mouse
		local new_location_radians=$(bashcalc "$(angle_reduce $old_cat_angle) + 1.25")
		new_cat_angle=$(bashcalc "$new_location_radians * (180/$pi)")
		new_cat_radius=$statue_radius
	fi

	if [[ $new_cat_radius == $statue_radius ]] && $(angle_between $old_cat_angle $old_mouse_angle $new_cat_angle) ; then
		state=$CAUGHT
		echo ${state} ${step} ${new_cat_angle} ${new_cat_radius} ${old_mouse_angle} ${max_steps}
		return ${state}
	fi

	# Now move the mouse if it wasn't caught
	if [[ $state != $CAUGHT ]]; then
		# Move the mouse
		local new_location_radians=$(bashcalc "$(angle_reduce $old_mouse_angle) + 1")
		new_mouse_angle=$(bashcalc "$new_location_radians * (180/$pi)")
		# Give up if we're at the last step and haven't caught the mouse
		if [[ $step == $max_steps ]] ; then
			state=$GIVEUP
		fi
	fi

	(( step+= 1 ))
	echo ${state} ${step} ${new_cat_angle} ${new_cat_radius} ${new_mouse_angle} ${max_steps}
	return ${state}
}

### Main Script ###

if [[ ${#} != 4 ]] ; then
	echo "$0: usage" >&2
	echo "$0 <cat angle> <cat radius> <mouse angle> <max steps>" >&2
	exit 1
fi

# ADD CODE HERE FOR PART 3
cat_angle=$1
cat_radius=$2
mouse_angle=$3
max_steps=$4
state=$RUNNING
steps=1
params=$(echo $state $steps $cat_angle $cat_radius $mouse_angle $max_steps)
echo "Starting Simulation with params: $params"
while [[ $? == $RUNNING ]]; do
	#statements
	params=$(next_step $params)
done

echo "Finish Params: $params"
exit_status=$(echo "$params" | cut -d" " -f1)
exit $exit_status
