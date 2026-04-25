#!/bin/bash
# Extract text from all source PDFs using pdftotext (poppler)
# Repeatable: skips existing .txt files
# Output: sources_text/ mirrors sources/ structure but with .txt files

cd "$(dirname "$0")/.."
SRC_DIR="sources"
DST_DIR="sources_text"

mkdir -p "$DST_DIR"

total=0
success=0
failed=0
skipped=0

while IFS= read -r pdf; do
    total=$((total+1))
    rel="${pdf#$SRC_DIR/}"
    txt="$DST_DIR/${rel%.pdf}.txt"
    mkdir -p "$(dirname "$txt")"

    if [ -f "$txt" ] && [ -s "$txt" ]; then
        skipped=$((skipped+1))
        continue
    fi

    echo "Extracting: $rel"
    if pdftotext -layout "$pdf" "$txt" 2>/dev/null; then
        if [ -s "$txt" ]; then
            lines=$(wc -l < "$txt")
            size=$(du -h "$txt" | cut -f1)
            echo "  OK: $size, $lines lines"
            success=$((success+1))
        else
            echo "  FAILED: empty output"
            rm -f "$txt"
            failed=$((failed+1))
        fi
    else
        echo "  FAILED: pdftotext error"
        rm -f "$txt"
        failed=$((failed+1))
    fi
done < <(find "$SRC_DIR" -name "*.pdf" | sort)

echo ""
echo "=== SUMMARY ==="
echo "Total:   $total"
echo "Success: $success"
echo "Skipped: $skipped (already extracted)"
echo "Failed:  $failed"
echo ""
echo "=== SIZE COMPARISON ==="
echo "PDF total:  $(du -sh $SRC_DIR | cut -f1)"
echo "Text total: $(du -sh $DST_DIR | cut -f1)"
