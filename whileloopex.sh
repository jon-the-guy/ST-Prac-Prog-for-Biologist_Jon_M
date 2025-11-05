#! /bin/bash

#while reading variable LINE
while read LINE
do 
	echo $LINE #echo value of variable line 
	echo -e "\n\n"
done < mylist.txt #this is the name of the file we're looping through

