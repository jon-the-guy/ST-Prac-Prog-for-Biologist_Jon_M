#! /bin/bash

###### GOAL OF PROGRAM IS TO CREATE AN ARRAY WITH THE FRUIT CONATINED IN COLUMN 1 OF FRUIT 


#create variable FRUIT that holds file name 
FRUIT="fruit.txt"

#echo value of variable FRUIT
echo $FRUIT

#cut column 1 from file, remove header, and redirect output to new variable 
cut -f1 $FRUIT | tail -n +2 > fruit_1.txt

#cat fruit_1.txt
#cat fruit_1.txt

#create counter 
COUNTER=0


#echo starting
echo "creating assay"

#########  CREATING ARRAY WITH FRUIT NAMES 
#########

#while READING lines in the file fruit_1.txt that I created 
while read LINE 
do 

	my_fruit[$COUNTER]=$LINE #populate the element with the value of line 
	echo ${my_fruit[$COUNTER]}  #echo the value of the element in the array that I just po
	let COUNTER=COUNTER+1  #increase the counter by 1
	

done < fruit_1.txt  #feed it the file and close the while loop

########## CREATING ARRAY WITH YUM SCALE VALUES 
########### 


#extract data in column 2 from FRUIT
cut -f2 $FRUIT | head -n +2 > fruit_2.txt

#reset counter to 0
COUNTER=0

#while reading the line in file fruit_2.txt
while read LINE
do 

		yum_scale[$COUNTER]=$LINE  #declare array yum_scale to conatin yum values from file 
		echo ${yum_scale[$COUNTER]} #echo value of element in array to standard out 
		let $COUNTER=$COUNTER+1  #increment counter by 1 

done < fruit_2.txt #feed it the file and close the loop


###### OPEN IF/ELSE LOOP TO RETURN ONLY YUMMY FRUITS TO STANDARD OUT 

#reset the counter 
COUNTER=0


#if the value of the element in our second array equal yummy 
if [ ${yum_scale[$COUNTER]} = "yummy" ];  #if the value of my yum scale element 
then #then
		echo ${my_fruit[$COUNTER]} #echo the value of the corresponding 
		let COUNTER=COUNTER+1 #increment counter 
else #otherwise 
	
	let 
	echo ${my_fruit[$COUNTER]}
done 





