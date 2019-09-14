#!/bin/bash 

cut -f1,3,4 Data/ByCountry/Mexico.txt|sort -nk3|tail -n1 > HighestLE_Mexico.txt