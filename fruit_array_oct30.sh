#! /bin/bash

######### GOAL OF PROGRAM IS TO CREATE AN ARRAY WITH THE FRUIT CONTAINED IN COLUMN 1 OF FRUIT.TXT


#create variable FRUIT that holds file name
FRUIT="fruit.txt"

#echo value of variable FRUIT
#echo $FRUIT

#cut column 1 from file, remove header, and redirect output to new file
cut -f1 $FRUIT | tail -n +2 > fruit_1.txt

#cat fruit_1.txt
#cat fruit_1.txt

#create counter and set equal to zero
COUNTER=0

#echo starting
echo "creating array"

############# CREATING ARRAY WITH FRUIT NAMES
############
#while reading lines in the file fruit_1.txt that I just created
while read LINE
do

	my_fruit[$COUNTER]=$LINE  #populate the element with the value of line
	#echo ${my_fruit[$COUNTER]} #echo the value of the element in the array that I just populated
	let COUNTER=COUNTER+1  #increase the counter by 1


done < fruit_1.txt  #feed it the file and close the while loop


############### CREATING ARRAY WITH YUM SCALE VALUES
##############

#extract data in column 2 from FRUIT
cut -f2 $FRUIT | tail -n +2 > fruit_2.txt

#reset counter to 0
COUNTER=0

#while reading the line in file fruit_2.txt
while read LINE
do
	
	yum_scale[$COUNTER]=$LINE #declare array yum_scale to contain yum values from file
	#echo ${yum_scale[$COUNTER]} #echo value of element in array to standard out
	let COUNTER=COUNTER+1   #increment counter by 1

done < fruit_2.txt #feed it the file and close the loop 

######### OPEN IF/ELSE LOOP TO RETURN ONLY YUMMY FRUITS TO STANDARD OUT

#reset the counter
COUNTER=0

#start a while loop to loop through arrays
while [ $COUNTER -lt ${#yum_scale[@]} ] #while value of counter is less than number of elements in array
do
	if [ ${yum_scale[$COUNTER]} = "yummy" ]; then #if value of the element in the yum_scale array is equal to yummy
		echo ${my_fruit[$COUNTER]} #echo the value of the fruit array to standard out (this is the yummy fruit)
	else
		echo "This fruit is not yummy" #echo this is not yummy
	fi #closes the if/else loop
	let COUNTER=COUNTER+1 #increment counter
done #closes the while loop
