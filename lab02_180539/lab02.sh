#!/bin/bash

function next() {
	# echo "done"	
	exit
}

if [ $# != 2 ]
then 
	echo "Usage: $0 inputfile outputfile"
	exit
fi
if [ -f "$1" ]
then
	sed 's/;/@/g' $1
	# grep "Japan" $1 | cut -d ";" -f 1 > $2
	awk -F ";" -f "lab01.awk" $1 > $2
	awk -F ";" -f "lab01_2.awk" $1 >> $2
	awk -F ";" -f "lab01_3.awk" $1 >> $2
	next
else
	echo "Error: $1 doesn't exit or is not a file"
	exit
fi
