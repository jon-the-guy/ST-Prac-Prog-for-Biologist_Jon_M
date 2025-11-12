#!/bin/bash

#exam 2 : q2

# Script: Urbanization_classification.sh
# Purpose: Classify sites as Rural, Suburban, or Urban based on %IP-5KM values

INPUT_FILE="/home/shared/FA25_coding/Exam_2/Exam2_Levine_et_al_body_size.csv"
OUTPUT_FILE="urbanization_classification.txt"

# Check if input file exists
if [ ! -f "$INPUT_FILE" ]; then
    echo "Error: Input file $INPUT_FILE not found!"
    exit 1
fi

echo "Classifying sites by urbanization level..."

# Create header for output file
echo -e "Site_Code\tClass" > "$OUTPUT_FILE"

# Use awk to process the entire file
awk -F',' '
NR == 1 { next }  # Skip header
!seen[$2]++ {     # Process only first occurrence of each site
    ip_int = int($5)

    if (ip_int < 15) class = "Rural"
    else if (ip_int <= 49) class = "Suburban"
    else class = "Urban"

    print $2 "\t" class
}' "$INPUT_FILE" | sort >> "$OUTPUT_FILE"

echo "Urbanization classification completed. Results saved to $OUTPUT_FILE" 

# Quick verification
echo "=== VERIFICATION ==="
echo "Expected: A5=Rural, A19=Suburban, B12=Rural, A1=Urban, B15=Suburban, E1=Urban"
grep -E "^(A5|A19|B12|A1|B15|E1)" "$OUTPUT_FILE"
