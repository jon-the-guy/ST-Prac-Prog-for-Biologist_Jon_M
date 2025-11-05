# Check what we're actually working with
INPUT_FILE="/home/shared/FA25_coding/Exam_1/SLF_genomic.gff"

echo "=== QUICK DIAGNOSTIC ==="
echo "Total features for NC_134455.1:"
grep -v '^#' "$INPUT_FILE" | grep -c "^NC_134455.1"

echo "Gene features for NC_134455.1:" 
grep -v '^#' "$INPUT_FILE" | grep "^NC_134455.1" | cut -f3 | grep -c "^gene$"

echo "All feature types for NC_134455.1:"
grep -v '^#' "$INPUT_FILE" | grep "^NC_134455.1" | cut -f3 | sort | uniq -c
