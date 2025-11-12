#!/bin/bash

# Exam 2 : Q1

# Simple version with basic CSV parsing

INPUT_FILE="/home/shared/FA25_coding/Exam_2/Exam2_Levine_et_al_body_size.csv"
OUTPUT_FILE="sampling_summary.txt"

echo "Checking file structure..." >&2
head -5 "$INPUT_FILE" >&2

# Skip header and process data
echo "Number of sites:$(tail -n +2 "$INPUT_FILE" | cut -d',' -f2 | sort -u | wc -l)" > "$OUTPUT_FILE"
echo -e "Site_Code\tN_Samples\tN_Males\tN_Females" >> "$OUTPUT_FILE"

# Count by site and sex
tail -n +2 "$INPUT_FILE" | cut -d',' -f2,3 | sort | uniq -c | while read count site_sex; do
    site=$(echo "$site_sex" | cut -d',' -f1)
    sex=$(echo "$site_sex" | cut -d',' -f2)
    echo "$site $sex $count"
done | awk '
    {
        site = $1
        sex = $2
        count = $3
        
        total[site] += count
        if (sex == "M") males[site] += count
        else if (sex == "F") females[site] += count
    }
    END {
        for (site in total) {
            print site "\t" total[site] "\t" (males[site] ? males[site] : 0) "\t" (females[site] ? females[site] : 0)
        }
    }
' | sort >> "$OUTPUT_FILE"

echo "Sampling summary completed. Results saved to $OUTPUT_FILE"
