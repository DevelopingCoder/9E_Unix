#Start at same position
./catmouse-fw.sh 0 1 0 10
if [[ $? == 2 ]] ; then
	echo "Success: Caught mouse when starting at same position"
fi

#Catch mouse at max step
./catmouse-fw.sh 0 3 0 6
if [[ $? == 2 ]] ; then
	echo "Success: Caught mouse at max step"
fi

#Give up because 1 step short
./catmouse-fw.sh 0 3 0 5
if [[ $? != 1 ]]; then
	echo "Success: Gave up, but is 1 short of the mouse"
fi