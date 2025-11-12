#!/bin/bash

# Exam 2 : Q3 

# Purpose: Find largest male and female individuals and compare their collection sites
# Input: Exam2_Levine_et_al_body_size.csv
# Output: largest_individuals.txt

INPUT_FILE="/home/shared/FA25_coding/Exam_2/Exam2_Levine_et_al_body_size.csv"
OUTPUT_FILE="largest_individuals.txt"

# Check if input file exists
if [ ! -f "$INPUT_FILE" ]; then
    echo "Error: Input file $INPUT_FILE not found!"
    exit 1
fi

echo "Finding largest individuals..."

# Part A: Find largest male
LARGEST_MALE=$(grep ",M," "$INPUT_FILE" | sort -t',' -k4 -nr | head -1)
MALE_LENGTH=$(echo "$LARGEST_MALE" | cut -d',' -f4)
MALE_SITE=$(echo "$LARGEST_MALE" | cut -d',' -f2)

# Part B: Find largest female  
LARGEST_FEMALE=$(grep ",F," "$INPUT_FILE" | sort -t',' -k4 -nr | head -1)
FEMALE_LENGTH=$(echo "$LARGEST_FEMALE" | cut -d',' -f4)
FEMALE_SITE=$(echo "$LARGEST_FEMALE" | cut -d',' -f2)

# Part C: Check if same site
SAME_SITE="No"
if [ "$MALE_SITE" = "$FEMALE_SITE" ]; then
    SAME_SITE="Yes"
fi

# Write results to output file
echo "Largest Individuals Report" > "$OUTPUT_FILE"
echo "=========================" >> "$OUTPUT_FILE"
echo "Largest Male: $MALE_LENGTH mm from site $MALE_SITE" >> "$OUTPUT_FILE"
echo "Largest Female: $FEMALE_LENGTH mm from site $FEMALE_SITE" >> "$OUTPUT_FILE"
echo "Collected from same site: $SAME_SITE" >> "$OUTPUT_FILE"

echo "Largest individuals analysis completed. Results saved to $OUTPUT_FILE"
