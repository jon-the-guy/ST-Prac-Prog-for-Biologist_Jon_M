#! /bin/bash

#add header line 
echo "These are my friends:" > myfriends.txt

# set a counter equal to 1 
COUNTER=1

#run for loop on list of friends 
for FRIEND in Elie Hasita Juhi Jon Lu Caroline #for variable friend do
do
        echo $friend >> myfriends.txt
        echo "on friend number $COUNTER" >> myfriends.txt
        ((COUNTER++)) #increase my counter by 1 
done


#decrease counter by 1 to get accurate count 
#((COUNTER--))

#echo total number of friends to file
echo "Total number of Friends: $COUNTER" >> myfriends.txt

#echo completion to standar out 
echo "Script completed"
