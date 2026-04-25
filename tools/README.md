# Tools

Helper scripts used to build this corpus.

## ocr_sanskrit.sh

Direct page-by-page Sanskrit + Hindi + English OCR using `tesseract`. Bypasses `ocrmypdf` which has known text-embedding issues with Devanagari script.

**Requires:** `tesseract`, `pdftoppm`, and the `san`, `hin`, `eng` traineddata files in `$TESSDATA_PREFIX` (defaults to `/home/dad/.tessdata` — adjust for your system).

**Usage:**
```
ocr_sanskrit.sh <input.pdf> <output.txt> [lang_string]
```

Default `lang_string` is `san+hin+eng`. For Bengali sources use `san+ben+eng`.

## extract_all.sh / ocr_all.sh

Batch wrappers that walk a directory tree and extract text from every PDF using `pdftotext` (text-searchable PDFs) or `ocr_sanskrit.sh` (image-only PDFs).

## stage_corpus.sh

Builds the `corpus/` directory tree from a local working source directory. Used once to populate this repo. Adjust the `SRC` path at the top of the script for your own setup.

---

These scripts are released under the same CC0 license as the rest of the repository compilation.
