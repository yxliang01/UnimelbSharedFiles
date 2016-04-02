for file in "wine" "adult" "iris"
do 
	cp "$file.csv" "input.csv"
	$1 phase1.py 
	mv "output.xml" "$file".xml
	rm "input.csv"
done 