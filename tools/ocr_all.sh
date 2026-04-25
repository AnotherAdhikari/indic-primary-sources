#!/bin/bash
# OCR all scanned PDFs that produced empty text output
# Uses ocrmypdf + tesseract, then re-runs pdftotext
# Repeatable: skips files that already have non-empty .txt output

cd "$(dirname "$0")/.."
SRC_DIR="sources"
DST_DIR="sources_text"
OCR_DIR="sources/ocr_cache"  # Store OCR'd PDFs here (will be gitignored)

mkdir -p "$OCR_DIR"

total=0
processed=0
skipped=0
failed=0

while IFS= read -r pdf; do
    total=$((total+1))
    rel="${pdf#$SRC_DIR/}"
    txt="$DST_DIR/${rel%.pdf}.txt"

    # Skip if we already have non-empty text
    if [ -s "$txt" ] && [ "$(wc -l < "$txt")" -gt 100 ]; then
        skipped=$((skipped+1))
        continue
    fi

    # Output OCR'd PDF
    ocr_pdf="$OCR_DIR/$(basename "$pdf" .pdf)_ocr.pdf"

    echo "=== OCR: $rel ==="
    if [ -f "$ocr_pdf" ] && [ -s "$ocr_pdf" ]; then
        echo "  Using cached OCR'd PDF"
    else
        ocrmypdf --skip-text --output-type pdf --optimize 0 --jobs 4 \
            "$pdf" "$ocr_pdf" 2>&1 | grep -E "ERROR|WARNING|real" | head -5
        if [ ! -s "$ocr_pdf" ]; then
            echo "  FAILED: ocrmypdf produced no output"
            rm -f "$ocr_pdf"
            failed=$((failed+1))
            continue
        fi
    fi

    # Extract text from OCR'd PDF
    mkdir -p "$(dirname "$txt")"
    pdftotext -layout "$ocr_pdf" "$txt" 2>/dev/null
    if [ -s "$txt" ]; then
        lines=$(wc -l < "$txt")
        size=$(du -h "$txt" | cut -f1)
        echo "  OK: $size, $lines lines"
        processed=$((processed+1))
    else
        echo "  FAILED: text extraction produced empty file"
        rm -f "$txt"
        failed=$((failed+1))
    fi
done < <(find "$SRC_DIR" -name "*.pdf" -not -path "*/ocr_cache/*" | sort)

echo ""
echo "=== SUMMARY ==="
echo "Total:     $total"
echo "Processed: $processed"
echo "Skipped:   $skipped (already had text)"
echo "Failed:    $failed"
