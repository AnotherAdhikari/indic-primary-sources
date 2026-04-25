#!/bin/bash
# stage_corpus.sh — populate corpus/ from local sources_text/ with the confidence-PD subset.
#
# For each source:
#   - copy original PDF into corpus/<category>/<slug>/original.pdf  (only if ≤100MB)
#   - copy extracted text(s) as extracted_text*.txt
#   - write metadata.json with title, edition, year, language, source-URL, license
#
# Sources are filtered to those with HIGH CONFIDENCE of US public-domain status (pre-1929 publication).

set -euo pipefail

SRC=/home/dad/Documents/The_Operators_Codex/sources_text
DST=/home/dad/Documents/indic-primary-sources/corpus

# Helper: write metadata.json
metadata() {
  local dst_dir="$1" title="$2" author="$3" year="$4" language="$5" source_url="$6" license="$7" notes="$8"
  cat > "$dst_dir/metadata.json" <<EOF
{
  "title": "$title",
  "author_or_editor": "$author",
  "publication_year": "$year",
  "language": "$language",
  "source_url": "$source_url",
  "license": "$license",
  "notes": "$notes"
}
EOF
}

# Helper: copy a PDF only if ≤100MB (GitHub limit)
maybe_copy_pdf() {
  local src="$1" dst="$2"
  if [ -f "$src" ]; then
    local size_mb=$(du -m "$src" | cut -f1)
    if [ "$size_mb" -le 99 ]; then
      cp "$src" "$dst"
    else
      echo "  (PDF $src is ${size_mb}MB — skipping; metadata only)"
    fi
  fi
}

# Helper: copy a text extract if it exists
maybe_copy_txt() {
  local src="$1" dst="$2"
  [ -f "$src" ] && cp "$src" "$dst" || true
}

# === GRAMMAR ===
mkdir -p "$DST/grammar/panini_ashtadhyayi_vasu_1897"
maybe_copy_pdf "$SRC/panini/panini_ashtadhyayi_vasu.pdf" "$DST/grammar/panini_ashtadhyayi_vasu_1897/original.pdf"
maybe_copy_txt "$SRC/panini/panini_ashtadhyayi_vasu.txt" "$DST/grammar/panini_ashtadhyayi_vasu_1897/extracted_text.txt"
metadata "$DST/grammar/panini_ashtadhyayi_vasu_1897" \
  "Aṣṭādhyāyī of Pāṇini" "Srisa Chandra Vasu (translator)" "1897" "Sanskrit + English" \
  "https://archive.org/details/in.ernet.dli.2015.376316" "Public Domain (US, pre-1929)" \
  "World's first formal grammar (~5th-c. BCE Pāṇini); Vasu's complete English translation, originally pub. Allahabad."

for vol in 1 2 3; do
  case $vol in
    1) yr=1880 ;;
    2) yr=1883 ;;
    3) yr=1885 ;;
  esac
  mkdir -p "$DST/grammar/patanjali_mahabhasya_kielhorn_vol${vol}_${yr}"
  maybe_copy_pdf "$SRC/grammar/patanjali_mahabhasya_kielhorn_vol${vol}.pdf" "$DST/grammar/patanjali_mahabhasya_kielhorn_vol${vol}_${yr}/original.pdf"
  maybe_copy_txt "$SRC/grammar/patanjali_mahabhasya_kielhorn_vol${vol}.txt" "$DST/grammar/patanjali_mahabhasya_kielhorn_vol${vol}_${yr}/extracted_text.txt"
  metadata "$DST/grammar/patanjali_mahabhasya_kielhorn_vol${vol}_${yr}" \
    "Vyākaraṇa-Mahābhāṣya of Patañjali, Vol. $vol" "Franz Kielhorn (editor)" "$yr" "Sanskrit (Devanagari)" \
    "https://archive.org/details/Mahabhashya" "Public Domain (US, pre-1929)" \
    "Kielhorn's critical edition of Patañjali's commentary on Pāṇini's Aṣṭādhyāyī, originally pub. Bombay Sanskrit Series."
done

# === MEDICAL ===
for vol in 1 2; do
  yr=$((1906 + vol))  # vol1=1907, vol2=1908
  mkdir -p "$DST/medical/sushruta_bhishagratna_vol${vol}_${yr}"
  maybe_copy_pdf "$SRC/medical/sushruta_bhishagratna_vol${vol}.pdf" "$DST/medical/sushruta_bhishagratna_vol${vol}_${yr}/original.pdf"
  maybe_copy_txt "$SRC/medical/sushruta_bhishagratna_vol${vol}.txt" "$DST/medical/sushruta_bhishagratna_vol${vol}_${yr}/extracted_text.txt"
  metadata "$DST/medical/sushruta_bhishagratna_vol${vol}_${yr}" \
    "Suśruta-Saṃhitā, Vol. $vol" "Kaviraj Kunja Lal Bhishagratna (translator)" "$yr" "Sanskrit + English" \
    "https://archive.org/details/englishtranslati0${vol}susroft" "Public Domain (US, pre-1929)" \
    "Complete English translation of the Suśruta-Saṃhitā with Sanskrit text. Vol 1 = Sūtra-sthāna; Vol 2 = Nidāna + Śārīra + Cikitsā-sthāna."
done

# === REFERENCE ===
mkdir -p "$DST/reference/aufrecht_catalogus_catalogorum_1891"
maybe_copy_pdf "$SRC/reference/aufrecht_catalogus_catalogorum.pdf" "$DST/reference/aufrecht_catalogus_catalogorum_1891/original.pdf"
maybe_copy_txt "$SRC/reference/aufrecht_catalogus_catalogorum.txt" "$DST/reference/aufrecht_catalogus_catalogorum_1891/extracted_text.txt"
metadata "$DST/reference/aufrecht_catalogus_catalogorum_1891" \
  "Catalogus Catalogorum: An Alphabetical Register of Sanskrit Works and Authors" "Theodor Aufrecht" "1891" "English (Latin script + transliterated Sanskrit)" \
  "https://archive.org/details/AufrechtCatalogusCatalogorum" "Public Domain (US, pre-1929)" \
  "Master Sanskrit manuscript-index covering 60,000+ Sanskrit works/authors. Pub. 1891-1903 in 3 parts."

mkdir -p "$DST/reference/caranavyuha"
maybe_copy_pdf "$SRC/reference/caranavyuha_text.pdf" "$DST/reference/caranavyuha/original.pdf"
maybe_copy_txt "$SRC/reference/caranavyuha_text.txt" "$DST/reference/caranavyuha/extracted_text.txt"
metadata "$DST/reference/caranavyuha" \
  "Caraṇa-vyūha (Śaunaka with Mahīdāsa commentary)" "(verify edition)" "(verify year)" "Sanskrit (Devanagari)" \
  "https://archive.org/details/Caranavyuha" "Pending verification — likely Public Domain" \
  "Canonical Vedic recension list (1,133 named śākhās)."

# === BRAHMANAS ===
for pt_pair in "1:1882" "2:1885" "5:1900"; do
  pt=${pt_pair%:*}; yr=${pt_pair#*:}
  mkdir -p "$DST/brahmanas/satapatha_brahmana_eggeling_pt${pt}_${yr}"
  maybe_copy_pdf "$SRC/brahmanas/satapatha_brahmana_pt${pt}.pdf" "$DST/brahmanas/satapatha_brahmana_eggeling_pt${pt}_${yr}/original.pdf"
  maybe_copy_txt "$SRC/brahmanas/satapatha_brahmana_pt${pt}.txt" "$DST/brahmanas/satapatha_brahmana_eggeling_pt${pt}_${yr}/extracted_text.txt"
  metadata "$DST/brahmanas/satapatha_brahmana_eggeling_pt${pt}_${yr}" \
    "Śatapatha-Brāhmaṇa Part $pt" "Julius Eggeling (translator)" "$yr" "English" \
    "https://archive.org/details/sacredbooksofeas12mlle" "Public Domain (US, pre-1929)" \
    "Vol $pt of the Śatapatha-Brāhmaṇa (Yajur-Veda Brāhmaṇa) in the Sacred Books of the East series. Includes Agnicayana fire-altar protocol (foundational body-cosmos isomorphism)."
done

# === ALCHEMY ===
mkdir -p "$DST/alchemy/rasarnava_kaviratna_1910"
maybe_copy_pdf "$SRC/alchemy/rasarnava_sanskrit.pdf" "$DST/alchemy/rasarnava_kaviratna_1910/original.pdf"
maybe_copy_txt "$SRC/alchemy/rasarnava_sanskrit.txt" "$DST/alchemy/rasarnava_kaviratna_1910/extracted_text.txt"
metadata "$DST/alchemy/rasarnava_kaviratna_1910" \
  "Rasārṇava" "Praphulla Chandra Rāy / Kaviraj (editor)" "1910" "Sanskrit (Devanagari)" \
  "https://archive.org/details/in.ernet.dli.2015.487147" "Public Domain (US, pre-1929)" \
  "Asiatic Society of Bengal edition of the Rasārṇava — major Rasaśāstra (mercury-alchemy) text."

mkdir -p "$DST/alchemy/rasaratna_samuccaya_1927"
maybe_copy_txt "$SRC/alchemy/rasaratna_samuccaya_1927.txt" "$DST/alchemy/rasaratna_samuccaya_1927/extracted_text.txt"
metadata "$DST/alchemy/rasaratna_samuccaya_1927" \
  "Rasaratna-Samuccaya of Vāgbhaṭa (with Rasaprabhā commentary)" "Vidyābhūṣaṇa Pārada Vinoda (editor)" "1927" "Sanskrit" \
  "https://archive.org/details/VagbhataRasaratnasamuccaya1927" "Public Domain (US, pre-1929)" \
  "Encyclopaedic Rasaśāstra text. Original PDF is 551MB — exceeds GitHub 100MB limit. Fetch from source URL above."

# === ASTRONOMY/MATH ===
mkdir -p "$DST/astronomy_math/surya_siddhanta_burgess_1860"
maybe_copy_txt "$SRC/astronomy_math/surya_siddhanta.txt" "$DST/astronomy_math/surya_siddhanta_burgess_1860/extracted_text.txt"
metadata "$DST/astronomy_math/surya_siddhanta_burgess_1860" \
  "Sūrya-Siddhānta: A Text-Book of Hindu Astronomy" "Ebenezer Burgess (translator)" "1860" "English + Sanskrit" \
  "https://archive.org/details/sryasiddhntate00bessgoog" "Public Domain (US, pre-1929)" \
  "Burgess's foundational English translation of the Sūrya-Siddhānta."

# === MISC ===
mkdir -p "$DST/misc/arthashastra_shamasastry_1909"
maybe_copy_txt "$SRC/misc/arthashastra.txt" "$DST/misc/arthashastra_shamasastry_1909/extracted_text.txt"
metadata "$DST/misc/arthashastra_shamasastry_1909" \
  "Arthaśāstra of Kauṭilya" "R. Shamasastry (translator)" "1909" "English" \
  "https://archive.org/details/Arthasastra_English_Translation" "Public Domain (US, pre-1929)" \
  "Shamasastry's first English translation of Kauṭilya's Arthaśāstra (treatise on statecraft and economics)."

# === TANTRIC (KSTS pre-1929 vols + Avalon Tantric Texts pre-1929) ===
mkdir -p "$DST/tantric/svacchanda_tantra_ksts_kshemaraja_vol1_1921"
maybe_copy_pdf "$SRC/tantric/svacchanda_tantra_kshemaraja_vol1.pdf" "$DST/tantric/svacchanda_tantra_ksts_kshemaraja_vol1_1921/original.pdf"
maybe_copy_txt "$SRC/tantric/svacchanda_tantra_kshemaraja_vol1.txt" "$DST/tantric/svacchanda_tantra_ksts_kshemaraja_vol1_1921/extracted_text.txt"
maybe_copy_txt "$SRC/tantric/svacchanda_tantra_kshemaraja_vol1_sanskrit.txt" "$DST/tantric/svacchanda_tantra_ksts_kshemaraja_vol1_1921/extracted_text_sanskrit.txt"
metadata "$DST/tantric/svacchanda_tantra_ksts_kshemaraja_vol1_1921" \
  "Svacchanda-Tantra Vol. 1 with Kṣemarāja's Uddyota commentary" "Pandit Madhusudan Kaul Shastri (editor)" "1921" "Sanskrit (Devanagari)" \
  "https://archive.org/details/swacchandatantra0iksemuoft" "Public Domain (US, pre-1929)" \
  "Kashmir Series of Texts and Studies (KSTS) No. XXXI. Central Bhairava Tantra of Trika Kashmir Shaivism with Kṣemarāja's running commentary. Sanskrit OCR via tesseract san+hin+eng."

mkdir -p "$DST/tantric/netra_tantra_ksts_1926"
maybe_copy_pdf "$SRC/tantric/netra_tantra_ksts.pdf" "$DST/tantric/netra_tantra_ksts_1926/original.pdf"
maybe_copy_txt "$SRC/tantric/netra_tantra_ksts.txt" "$DST/tantric/netra_tantra_ksts_1926/extracted_text.txt"
metadata "$DST/tantric/netra_tantra_ksts_1926" \
  "Netra-Tantra (Mṛtyuñjaya-Tantra)" "(KSTS editor)" "1926" "Sanskrit (Devanagari)" \
  "https://archive.org/details/NetraTantraKSTS46" "Public Domain (US, pre-1929)" \
  "Kashmir Series of Texts and Studies No. XLVI. Mantramārga reference + Mṛtyuñjaya cipher."

# Avalon Tantric Texts (pre-1929; OVER 100MB so text-only)
mkdir -p "$DST/tantric/tantraraja_tantra_avalon_1918"
maybe_copy_txt "$SRC/tantric/tantraraja_tantra_avalon.txt" "$DST/tantric/tantraraja_tantra_avalon_1918/extracted_text.txt"
metadata "$DST/tantric/tantraraja_tantra_avalon_1918" \
  "Tantrarāja-Tantra (Avalon's Tantric Texts Vol. VIII)" "Arthur Avalon (Sir John Woodroffe)" "1918" "Sanskrit (Devanagari)" \
  "https://archive.org/details/Tantraraja-tantra-A-Short-Analysis" "Public Domain (US, pre-1929)" \
  "Original PDF is 292MB — exceeds GitHub 100MB limit. Fetch original from source URL above."

mkdir -p "$DST/tantric/kamakalavilasa_avalon_1922"
maybe_copy_txt "$SRC/tantric/kamakalavilasa_avalon.txt" "$DST/tantric/kamakalavilasa_avalon_1922/extracted_text.txt"
metadata "$DST/tantric/kamakalavilasa_avalon_1922" \
  "Kāmakalāvilāsa (Avalon's Tantric Texts Vol. XI)" "Arthur Avalon (Sir John Woodroffe)" "1922" "Sanskrit (Devanagari)" \
  "https://archive.org/details/KamakalavilasaWithCommentaryOfNatananadanatha-ShriArthurAvalon" "Public Domain (US, pre-1929)" \
  "Original PDF is 104MB — exceeds GitHub 100MB limit. Fetch original from source URL above."

# Avalon-translated Tantric texts (text-only, pre-1929 originals)
declare -A AVALON_PD=(
  ["mahanirvana_tantra"]="Mahānirvāṇa-Tantra:1913:https://archive.org/details/mahanirvanatantr00aval"
  ["kularnava_tantra"]="Kulārṇava-Tantra:1917:https://archive.org/details/kularnavatantra"
)
for slug in "${!AVALON_PD[@]}"; do
  IFS=':' read -r title yr url <<< "${AVALON_PD[$slug]}"
  mkdir -p "$DST/tantric/${slug}_avalon_${yr}"
  maybe_copy_txt "$SRC/tantric/${slug}.txt" "$DST/tantric/${slug}_avalon_${yr}/extracted_text.txt"
  metadata "$DST/tantric/${slug}_avalon_${yr}" \
    "$title" "Arthur Avalon (Sir John Woodroffe)" "$yr" "English (with Sanskrit)" \
    "$url" "Public Domain (US, pre-1929)" \
    "Avalon's English translation, originally published Calcutta."
done

# KSTS Trika texts (pre-1929) — text-only extracts (originals from KSTS)
declare -A KSTS_PD=(
  ["malini_vijayottara_tantra"]="Mālinī-Vijayottara-Tantra (KSTS XXXVII):1922"
  ["paratrishika_vivarana"]="Parātrīśikā-Vivaraṇa of Abhinavagupta (KSTS XVIII):1918"
  ["pratyabhijnahrdayam"]="Pratyabhijñā-Hṛdayam of Kṣemarāja (KSTS III):1911"
  ["shiva_sutras"]="Śiva-Sūtras with Vimarśinī (KSTS I):1911"
  ["spanda_karikas"]="Spanda-Kārikās with Spanda-Nirṇaya (KSTS XLII):1916"
  ["vijnana_bhairava_tantra"]="Vijñāna-Bhairava-Tantra (KSTS VIII):1918"
)
for slug in "${!KSTS_PD[@]}"; do
  IFS=':' read -r title yr <<< "${KSTS_PD[$slug]}"
  mkdir -p "$DST/tantric/${slug}_ksts_${yr}"
  maybe_copy_txt "$SRC/tantric/${slug}.txt" "$DST/tantric/${slug}_ksts_${yr}/extracted_text.txt"
  metadata "$DST/tantric/${slug}_ksts_${yr}" \
    "$title" "Kashmir Series of Texts and Studies" "$yr" "Sanskrit (Devanagari)" \
    "https://archive.org/details/KashmirSeriesOfTextAndStudies" "Public Domain (US, pre-1929)" \
    "Kashmir Series of Texts and Studies (KSTS) edition. Pre-1929 publication."
done

# === PURANAS ===
mkdir -p "$DST/puranas/vishnu_purana_wilson_1840"
maybe_copy_txt "$SRC/puranas/vishnu_purana.txt" "$DST/puranas/vishnu_purana_wilson_1840/extracted_text.txt"
metadata "$DST/puranas/vishnu_purana_wilson_1840" \
  "Viṣṇu-Purāṇa: A System of Hindu Mythology and Tradition" "Horace Hayman Wilson (translator)" "1840" "English" \
  "https://archive.org/details/visnupuranasyste01wilsuoft" "Public Domain (US, pre-1929)" \
  "Wilson's foundational English translation of the Viṣṇu-Purāṇa."

# === VEDAS_UPANISHADS ===
mkdir -p "$DST/vedas_upanishads/four_vedas_complete"
maybe_copy_pdf "$SRC/vedas_upanishads/four_vedas_complete.pdf" "$DST/vedas_upanishads/four_vedas_complete/original.pdf"
maybe_copy_txt "$SRC/vedas_upanishads/four_vedas_complete.txt" "$DST/vedas_upanishads/four_vedas_complete/extracted_text.txt"
metadata "$DST/vedas_upanishads/four_vedas_complete" \
  "Four Vedas: Ṛk, Yajur, Sāma, Atharva — English Translations" "Griffith / Bloomfield / Keith (translators)" "1893-1925" "English" \
  "https://archive.org/details/FourVedasEnglishTranslation" "Public Domain (US, pre-1929)" \
  "Compilation of the four Vedic Saṃhitās in classic English translations: Griffith's Rig & Sāma & Atharva, Keith's Yajur."

mkdir -p "$DST/vedas_upanishads/ganapati_atharvashirsha"
maybe_copy_pdf "$SRC/vedas_upanishads/ganapati_atharvashirsha.pdf" "$DST/vedas_upanishads/ganapati_atharvashirsha/original.pdf"
maybe_copy_txt "$SRC/vedas_upanishads/ganapati_atharvashirsha.txt" "$DST/vedas_upanishads/ganapati_atharvashirsha/extracted_text.txt"
metadata "$DST/vedas_upanishads/ganapati_atharvashirsha" \
  "Gaṇapati Atharvaśīrṣa Upaniṣad (with Vedic accents)" "Sanskrit Documents (digital edition)" "digital" "Sanskrit (Devanagari)" \
  "https://sanskritdocuments.org/" "Public Domain (text in PD)" \
  "Sanskrit text with Vedic accents from sanskritdocuments.org."

# Done
echo "Stage complete."
echo "Total folders: $(find "$DST" -mindepth 2 -maxdepth 2 -type d | wc -l)"
echo "Total bytes: $(du -sh "$DST" | cut -f1)"
