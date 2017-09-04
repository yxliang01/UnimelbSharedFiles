#!/bin/bash


#Author: Xiaoliang Yu
#This bash script takes one argument which is the path to the python interpreter
#You must place test_phase1.py in the working directory
#This script will automatically compare wine.xml, adult.xml and iris.xml with output-wine.xml, output-adult.xml and output-iris.xml correspondingly

if [ -z ${1+x} ]; then
python="python2"
else
python=$1
fi

for file in adult wine iris
do
	$python ./test_phase1.py "$file".xml output-"$file".xml
done
