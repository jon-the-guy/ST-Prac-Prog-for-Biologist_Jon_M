#! /bin/bash



#set variable BTS equal to value of file name 
BTS="BTS_data_txt"

#create list of unique BTS IDs in field 1 without header
tail -n +2 $BTS | cut -f 1 | sort -k1 | uniq > BTS_ids.txt

BTS_IDS="BTS_ids.txt"

#echo a phrase to standard out  
echo -e "these are my fav snake:"

#loop through BTS_ids.txt and echo lines to standar out 
while read LINE
do 
	echo $LINE
	echo -e "\n"
done < BTS_ids.txt #file to loop through
