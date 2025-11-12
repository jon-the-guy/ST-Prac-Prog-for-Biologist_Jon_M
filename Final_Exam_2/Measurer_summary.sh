#!/bin/bash

#Q4 exam 2

# Purpose: Summarize sampling effort by each measurer across urbanization classes
# Input: Exam2_Levine_et_al_body_size.csv
# Output: measurer_summary.txt

INPUT_FILE="/home/shared/FA25_coding/Exam_2/Exam2_Levine_et_al_body_size.csv"
OUTPUT_FILE="measurer_summary.txt"

# Check if input file exists
if [ ! -f "$INPUT_FILE" ]; then
    echo "Error: Input file $INPUT_FILE not found!"
    exit 1
fi

echo "Generating measurer summary..."

# Create header for output file
echo -e "Measurer\t#Samples\t#Rural\t#Suburban\t#Urban" > "$OUTPUT_FILE"

# Get unique measurers
MEASURERS=$(tail -n +2 "$INPUT_FILE" | cut -d',' -f1 | sort | uniq)

# Process each measurer
for measurer in $MEASURERS; do
    echo "Processing measurer: $measurer"
    
    # Use awk for reliable field processing
    RESULTS=$(grep "^$measurer," "$INPUT_FILE" | awk -F',' '
    {
        ip_int = int($5)  # Convert 5th field to integer
        total++
        if (ip_int < 15) rural++
        else if (ip_int >= 15 && ip_int <= 49) suburban++  
        else urban++
    } 
    END {
        printf "%d %d %d %d", total, rural, suburban, urban
    }')
    
    # Extract the results
    read -r TOTAL RURAL SUBURBAN URBAN <<< "$RESULTS"
    
    # Write results for this measurer
    echo -e "$measurer\t$TOTAL\t$RURAL\t$SUBURBAN\t$URBAN" >> "$OUTPUT_FILE"
    echo "  Results: Total=$TOTAL, Rural=$RURAL, Suburban=$SUBURBAN, Urban=$URBAN"
done

echo "Measurer summary completed. Results saved to $OUTPUT_FILE"
