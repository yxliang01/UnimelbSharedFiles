for file in adult wine iris
do
	$1 ./test_phase1.py "$file".xml output-"$file".xml
done
