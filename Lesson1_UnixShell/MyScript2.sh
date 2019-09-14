#!/bin/bash
#path to bash shell that will execute this file

# this script outputs the highest life exp.
#usage: ./MyScript2.sh

#define an input variable
input=Data/ByCountry/Mexico.txt
output=HighestLE2.txt

cut -f1,3,4 $input | sort -nk3 | tail -n1 > $output