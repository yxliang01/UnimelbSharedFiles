#!/bin/bash

program="./ass1"
outputpath="./out"
inputfilepath="./test"
diffprogram="diff"
dot="dot"

str_invalid="Invalid topological ordering"

filenames=(`ls "$inputfilepath"/*.txt`)

for ((i=0; i < "${#filenames[@]}"; i++))
do
	filenames[$i]=`basename "${filenames[$i]}" .txt`
done

for FILE in "${filenames[@]}"
do
	echo "=================	For $FILE"

	$program -p "$outputpath"/"$FILE".dot "$inputfilepath"/"$FILE".txt
	$dot "$outputpath"/"$FILE".dot -Tpng -o "$outputpath"/"$FILE".png

	$program -m 1 "$inputfilepath"/"$FILE".txt > "$outputpath"/"$FILE"_toposort1.txt
	$program -m 2 "$inputfilepath"/"$FILE".txt > "$outputpath"/"$FILE"_toposort2.txt

	$diffprogram "$outputpath"/"$FILE"_toposort1.txt "$outputpath"/"$FILE"_toposort2.txt > /dev/null

	if [ $? -ne 0 ];
	then
		echo -e "for $FILE.txt two different methods created \e[1;31m different result!\e[1;30m"
	fi

	for outputfile in "$FILE"_toposort1.txt "$FILE"_toposort2.txt
	do

	output=`$program -v $inputfilepath/$FILE.txt < $outputpath/$outputfile`

	echo "$output for $outputfile"
	done


	printf "\n\n\n"

done