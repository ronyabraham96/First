#!/bin/bash
#path to bash shell that will execute this file

# this script outputs the highest life exp.
#usage: ./MyScript3.sh input > output

#define an input variable

#$1 is a special variable that accepts from the command line
input=$1

cut -f1,3,4 $input | sort -nk3 | tail -n1