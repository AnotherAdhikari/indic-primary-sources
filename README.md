# Indic Primary Sources

An open archive of public-domain primary sources in Sanskrit and other Indic languages, organized for researchers, students, translators, and the curious.

This repository collects:
- **Original PDF scans** of pre-1929 (US public-domain) and Creative Commons-licensed editions of Indic primary texts
- **Extracted text** from those scans (via `pdftotext`, `tesseract san+hin+eng`, and similar pipelines)
- **Metadata** for each source (edition, year, language, original location)

## What's here

The corpus spans the major textual traditions of classical India:

| Category | Description | Examples |
|---|---|---|
| **Vedic Saṃhitās** | Ṛk, Yajur, Sāma, Atharva | Griffith / Bloomfield / Keith translations (1893–1925) |
| **Brāhmaṇas** | Ritual exegesis | Eggeling's Śatapatha-Brāhmaṇa (1882–1900) |
| **Upaniṣads** | Mukhya + minor | (selected PD editions) |
| **Purāṇas** | Major Mahāpurāṇas | Wilson's Viṣṇu-Purāṇa (1840), etc. |
| **Āgamas** | Śaiva ritual manuals | Pre-1929 KSTS volumes (Svacchanda, Netra, etc.) |
| **Tantras** | Bhairava, Kaula, Śākta, Trika | Avalon (Woodroffe) Tantric Texts series 1913–1922; KSTS Trika texts |
| **Śilpa-Śāstras** | Architecture / iconography | Acharya's Mānasāra, etc. (pre-1929 eds where available) |
| **Vyākaraṇa** (Grammar) | Pāṇinian + commentaries | Vasu's Aṣṭādhyāyī (1897), Kielhorn's Mahābhāṣya (1880–1885) |
| **Āyurveda** | Medical | Bhishagratna's Suśruta-Saṃhitā (1907–1916) |
| **Rasaśāstra** (Alchemy) | Mercury / mineral / elixir | Vidyabhusana's Rasaratna-Samuccaya (1927), Kaviratna's Rasarṇava (1910) |
| **Astronomy / Math** | Jyotiṣa | Burgess's Sūrya-Siddhānta (1860) |
| **Polity / Statecraft** | | Shamasastry's Arthaśāstra (1909) |
| **Reference** | Catalogues, recension lists | Aufrecht's *Catalogus Catalogorum* (1891–1903), Caraṇa-vyūha |

A separate `creative_commons/` subdirectory hosts CC-licensed modern editions whose terms permit redistribution (currently: Singh + Maheshvarananda's 8-volume *Sri Tantraloka & other works*, CC BY-NC-ND 4.0).

## Why this repository exists

Two practical problems this archive addresses:

1. **Discovery.** Many of these texts exist on archive.org or other OCR-archives but are scattered across hundreds of unindexed items, often poorly tagged. This repo indexes them by category, edition, and provenance.

2. **Text extraction.** The OCR layer that ships with most archive.org Sanskrit-text PDFs is generated with English-only models, producing garbled output. We re-OCR with the `san+hin+eng` tesseract language pack to produce usable Devanagari text. Where the original PDF is text-searchable, we extract directly with `pdftotext -layout`. Each file's extracted text is bundled alongside its source PDF.

## Repository structure

```
corpus/
├── agamas/          # Śaiva Tantric ritual texts (KSTS pre-1929 vols)
├── alchemy/         # Rasaśāstra: Rasārṇava, Rasaratna-Samuccaya, etc.
├── astronomy_math/  # Sūrya-Siddhānta and others
├── brahmanas/       # Eggeling's Śatapatha-Brāhmaṇa
├── grammar/         # Pāṇini, Patañjali Mahābhāṣya
├── medical/         # Suśruta-Saṃhitā (Bhishagratna)
├── misc/            # Arthaśāstra (Shamasastry)
├── puranas/         # PD-edition Mahāpurāṇa translations
├── reference/       # Aufrecht's CC, Caraṇa-vyūha
├── shilpa_shastras/ # Mānasāra, Mayamata (PD editions where available)
├── tantric/         # Avalon Tantric Texts series + KSTS Kashmir Shaivism
├── vedas_upanishads/# Saṃhitās + selected Upaniṣads
└── creative_commons/
    └── tantraloka_singh_maheshvarananda/  # CC BY-NC-ND 4.0
tools/
└── (extraction scripts: pdftotext wrappers, ocr_sanskrit.sh)
COPYRIGHT_NOTICES.md
LICENSE
README.md  ← you are here
```

Each text-folder contains:
- `original.pdf` (when ≤100MB)
- `extracted_text.txt` (pdftotext output)
- `extracted_text_sanskrit.txt` (tesseract `san+hin+eng` output, for OCR'd Sanskrit-script PDFs)
- `metadata.json` (title, edition, year, language, source-URL, license)

If `original.pdf` is absent because of GitHub's 100MB-file limit, `metadata.json` provides the source-URL so users can fetch the original from archive.org or the noted source.

## Copyright

Every item in `corpus/` is one of:
1. **Public domain in the US** (publication ≤ 1928), OR
2. **Public domain by author-life-+70-years rule**, OR
3. **Creative Commons-licensed**, with the license explicitly noted

We do not host modern critical editions, modern translations, or any work whose copyright remains active.

See `COPYRIGHT_NOTICES.md` for the per-source attribution and edition details.

If you believe a specific item has been included in error, please open an issue and we will remove it pending review.

## License

The compilation, indexing, extracted-text artifacts (where derived from PD originals), and the metadata are released under **CC0 1.0 Universal** — no rights reserved on our compilation effort. The underlying source-text content is in the public domain or as noted per-item.

## Contributing

Issues and PRs welcome for:
- Additional public-domain editions of Indic primary texts
- Improved OCR for already-included items
- Metadata corrections
- Translation suggestions or alignment between editions

## Acknowledgments

These texts owe their preservation to centuries of paṇḍita transmission, 19th- and early-20th-century Indological scholarship (Eggeling, Burgess, Wilson, Avalon, Vasu, Bhishagratna, Aufrecht, Kielhorn, etc.), and the open archives — Internet Archive, Sacred-Texts.com, Sanskrit Documents, KSTS, IFP, Adyar Library — that have made their digitization possible.
