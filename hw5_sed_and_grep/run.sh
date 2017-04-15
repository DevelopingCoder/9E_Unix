#!/bin/bash

for img in images/*.jpg; do
	expr1=$(echo "img_\([0-9]\{2\}\)-\([0-9]\{2\}\)-\([0-9]\{2\}\)_\([0-9]\{2,3\}\)")
	getname=$(echo $img | sed "s/$expr1/new_years_20\1-\2-\3_\4/;s/_\([0-9]\{2\}\).jpg$/_0\1.jpg/")
	mv $img $getname
done

