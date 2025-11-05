#!/bin/bash 

#variable and array 
COUNTER=1
my_array=()

while [ $COUNTER -lt 100 ]; do
    my_array+=("file_$COUNTER")
    ((COUNTER++))
done

# making files from array
for kclass in "${my_array[@]}"; do
    touch "$kclass"
    echo "$kclass" > "$kclass"
    echo "Created: $kclass"
done

