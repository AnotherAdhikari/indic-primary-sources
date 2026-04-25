#!/bin/bash
# ocr_sanskrit.sh — Direct page-by-page Sanskrit+English OCR using tesseract
# Bypasses ocrmypdf which has text-embedding issues with Devanagari.
#
# Usage: ocr_sanskrit.sh <input.pdf> <output.txt> [lang_string]
# Default lang_string: san+hin+eng
# Requires: /home/dad/.tessdata/ with san.traineddata, hin.traineddata, eng.traineddata

set -euo pipefail

INPUT_PDF="${1:?Usage: $0 <input.pdf> <output.txt> [lang_string]}"
OUTPUT_TXT="${2:?Usage: $0 <input.pdf> <output.txt> [lang_string]}"
LANG="${3:-san+hin+eng}"
DPI=300

TMPDIR=$(mktemp -d)
trap "rm -rf $TMPDIR" EXIT

export TESSDATA_PREFIX=/home/dad/.tessdata

# Get page count
PAGES=$(pdfinfo "$INPUT_PDF" 2>/dev/null | awk '/^Pages:/ {print $2}')
echo "[$(date -Iseconds)] OCR starting: $INPUT_PDF ($PAGES pages, lang=$LANG)"

> "$OUTPUT_TXT"

# Process pages in batches of 10 to keep memory usage reasonable
BATCH=10
for START in $(seq 1 $BATCH $PAGES); do
    END=$((START + BATCH - 1))
    [ $END -gt $PAGES ] && END=$PAGES

    # Rasterize batch
    pdftoppm -r $DPI -f $START -l $END "$INPUT_PDF" "$TMPDIR/page" 2>/dev/null

    # OCR each page image
    for IMG in "$TMPDIR"/page-*.ppm; do
        [ -f "$IMG" ] || continue
        PAGENUM=$(basename "$IMG" .ppm | sed 's/page-0*//')
        echo "" >> "$OUTPUT_TXT"
        echo "===== Page $PAGENUM =====" >> "$OUTPUT_TXT"
        tesseract "$IMG" - -l "$LANG" 2>/dev/null >> "$OUTPUT_TXT" || true
        rm -f "$IMG"
    done

    # Progress update
    echo "[$(date -Iseconds)] Processed pages $START-$END / $PAGES"
done

echo "[$(date -Iseconds)] OCR complete: $(wc -l < "$OUTPUT_TXT") lines, $(wc -c < "$OUTPUT_TXT") bytes"
