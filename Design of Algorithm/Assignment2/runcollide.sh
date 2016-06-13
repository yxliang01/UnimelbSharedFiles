#!/bin/bash
./ass2 -t s -c "$1" -s "$2" 1element.txt > out.txt
./ass2 -t s -s "$2" -h u -f out.txt out.txt