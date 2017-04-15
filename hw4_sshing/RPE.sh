#!/bin/bash
for login in cs9e-2-aaj@{ashby,cory}.cs.berkeley.edu; do
ssh $login who 
done | uniq | sort 
