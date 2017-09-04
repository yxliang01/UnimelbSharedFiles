#!/bin/bash

#Author: Xiaoliang Yu
#This bash script takes one argument which is the path to the python interpreter
#wine.csv, adult.csv and iris.csv must be placed in the working directory
#wine.xml, adult.xml and iris.xml will be the output files

if [ -z ${1+x} ]; then
python="python2"
else
python=$1
fi

for file in "wine" "adult" "iris"
do 
	cp "$file.csv" "input.csv"
	$python phase1.py 
	mv "output.xml" "$file".xml
	rm "input.csv"
done 
