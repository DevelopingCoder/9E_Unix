#!/bin/bash

expr=$1
echo "$expr" | bc -l
