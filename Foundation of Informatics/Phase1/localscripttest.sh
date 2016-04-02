#Author: Xiaoliang Yu
#This bash script takes one argument which is the path to the python interpreter
#wine.csv, adult.csv and iris.csv must be placed in the working directory
#wine.xml, adult.xml and iris.xml will be the output files

for file in "wine" "adult" "iris"
do 
	cp "$file.csv" "input.csv"
	$1 phase1.py 
	mv "output.xml" "$file".xml
	rm "input.csv"
done 