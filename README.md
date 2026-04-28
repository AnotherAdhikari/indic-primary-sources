# Indic Primary Sources

An open archive of public-domain primary sources from the Indic traditions (Vedic, Tantric, Purāṇic, and related), organized for researchers, students, translators, and the curious.

This repository collects:
- **Extracted text** from pre-1929 (US public-domain) editions of Indic primary texts
- **OCR'd text** from scanned PDFs (re-processed with appropriate language models)
- **Metadata** for each source (edition, year, language, provenance)

## What's here

The corpus spans the major textual traditions of classical India. Both **Vedic** (Śruti/Smṛti) and **Tantric** (Āgama/Tantra) traditions are represented — these are parallel transmissions with a shared substrate, not parent-child.

| Category | Texts | Description |
|---|---|---|
| **Āgamas** | 1 | Ahirbudhnya Saṃhitā (Schrader/Adyar 1916) — Pāñcarātra Vaiṣṇava |
| **Brāhmaṇas** | 11 | Śatapatha (all 5 pts), Aitareya, Kauṣītaki, Gopatha, Ṛgveda Brāhmaṇas (Keith/Eggeling/Bloomfield/Mitra) |
| **Epics** | 3 | Mahābhārata (Ganguli, all 18 Parvas), Rāmāyaṇa (Griffith), Bhagavad Gītā with Śaṅkara (Mahadeva Sastri) |
| **Grammar** | 4 | Pāṇini Aṣṭādhyāyī (Vasu), Patañjali Mahābhāṣya 3 vols (Kielhorn) |
| **Medical** | 4 | Charaka Saṃhitā (Kaviratna 1890), Suśruta Saṃhitā 3 vols (Bhishagratna) |
| **Purāṇas** | 5 | Viṣṇu (Wilson), Devī Bhāgavata (Vijnanananda), Mārkaṇḍeya (Pargiter), Agni (Dutt 1904), Garuḍa (Dutt 1908) |
| **Śilpa Śāstra** | 1 | Mānasāra (Acharya 1927) — temple architecture |
| **Tantric** | 21 | KSTS Kashmir Śaivism texts (8), Tantrāloka Sanskrit 7 vols (KSTS 1918–1926), Avalon Tantric Texts (4), Lalitā-Sahasranāma (Ananthakrishna Sastry), Śakti and Śākta (Woodroffe) |
| **Vedic Saṃhitās** | 2 | Four Vedas (Griffith/Keith/Bloomfield), Gaṇapati Atharvaśīrṣa |
| **Yoga** | 3 | Laghu Yoga Vāsiṣṭha (Aiyer 1896), Yoga Sūtras (Rāma Prasāda 1912), Haṭha Yoga Pradīpikā (Pancham Sinh 1915) |
| **Alchemy** | 2 | Rasārṇava (Kaviratna 1910), Rasaratna-Samuccaya (1927) |
| **Astronomy** | 2 | Sūrya-Siddhānta (Burgess 1860), Bṛhat Saṃhitā (Iyer 1884, partial) |
| **Reference** | 2 | Aufrecht Catalogus Catalogorum, Caraṇa-vyūha |
| **Misc** | 1 | Arthaśāstra (Shamasastry 1909) |

**Total: 67 public-domain text files, ~2.05M lines** (additional texts pending OCR)

## Copyright texts in our research corpus

We maintain a separate research corpus of ~130 texts (~4.1M lines) that includes modern translations still under copyright. These cannot be hosted here, but we provide a complete list with estimated public-domain entry dates:

**See [`COPYRIGHT_TEXTS_IN_CORPUS.md`](COPYRIGHT_TEXTS_IN_CORPUS.md)** — 41 copyright texts catalogued with translator, publisher, publication year, and estimated US PD date (earliest: 2030s; most: 2050s–2070s).

This list also identifies **PD alternatives** that could replace some copyright editions (e.g., M.N. Dutt's 1903–08 Purāṇa translations could replace the 1950s–70s AITM editions).

## Why this repository exists

1. **Discovery.** Many of these texts exist on archive.org but are scattered across hundreds of poorly-tagged items. This repo indexes them by category, edition, and provenance.

2. **Quality.** The OCR layer on many archive.org PDFs was generated with English-only models on Sanskrit-script originals, producing garbled output. We re-OCR with appropriate language packs and verify readability. The Śatapatha Brāhmaṇa (all 5 parts) was re-OCR'd with `ocrmypdf --force-ocr -l eng` to produce readable English from previously garbled Hindi-model OCR.

3. **Organization.** Vedic and Tantric traditions are often conflated. Our corpus classification (in the research project) identifies every text by tradition and highlights the 7 key overlap-zone texts where both traditions meet.

## Repository structure

```
corpus/
├── agamas/              # Āgamic ritual texts (Pāñcarātra, Śaiva Siddhānta)
├── alchemy/             # Rasaśāstra: Rasārṇava, Rasaratna-Samuccaya
├── astronomy_math/      # Sūrya-Siddhānta
├── brahmanas/           # Śatapatha (5 pts), Aitareya, Kauṣītaki, Gopatha, etc.
├── epics/               # Mahābhārata, Rāmāyaṇa, Bhagavad Gītā
├── grammar/             # Pāṇini Aṣṭādhyāyī, Patañjali Mahābhāṣya
├── medical/             # Charaka Saṃhitā, Suśruta Saṃhitā (3 vols)
├── misc/                # Arthaśāstra
├── puranas/             # PD-edition Mahāpurāṇa translations
├── reference/           # Aufrecht Catalogus, Caraṇa-vyūha
├── shilpa_shastras/     # Mānasāra (temple architecture)
├── tantric/             # KSTS Kashmir Śaivism + Avalon Tantric Texts + Śrī Vidyā
├── vedas_upanishads/    # Four Saṃhitās + Gaṇapati Atharvaśīrṣa
└── yoga/                # Laghu Yoga Vāsiṣṭha
tools/                   # Extraction scripts
COPYRIGHT_NOTICES.md     # Per-source PD attribution
COPYRIGHT_TEXTS_IN_CORPUS.md  # Copyright texts NOT hosted (with PD dates)
LICENSE
README.md
```

Each text-folder contains:
- `extracted_text.txt` — primary text extraction
- `extracted_text_sanskrit.txt` — Sanskrit OCR where applicable
- Additional variant files where multiple extractions exist

## Copyright

Every item in `corpus/` is one of:
1. **Public domain in the US** (publication ≤ 1928), OR
2. **Public domain by author-life rule**, OR
3. **Creative Commons-licensed**, with the license explicitly noted

We do not host modern critical editions, modern translations, or any work whose copyright remains active.

See `COPYRIGHT_NOTICES.md` for per-source attribution and `COPYRIGHT_TEXTS_IN_CORPUS.md` for the complete list of copyright texts we track but do not host.

If you believe a specific item has been included in error, please open an issue and we will remove it pending review.

## License

The compilation, indexing, extracted-text artifacts (where derived from PD originals), and metadata are released under **CC0 1.0 Universal** — no rights reserved on our compilation effort. The underlying source-text content is in the public domain as noted per-item.

## Contributing

Issues and PRs welcome for:
- Additional public-domain editions of Indic primary texts
- Improved OCR for already-included items
- Metadata corrections
- PD-alternative editions to replace copyright texts listed in `COPYRIGHT_TEXTS_IN_CORPUS.md`

## Acknowledgments

These texts owe their preservation to centuries of paṇḍita transmission, 19th- and early-20th-century Indological scholarship (Eggeling, Burgess, Wilson, Avalon, Vasu, Bhishagratna, Keith, Griffith, Ganguli, Pargiter, Acharya, Woodroffe, Kaviratna, Aufrecht, Kielhorn, Schrader, Bloomfield, Mitra, Aiyer, Ananthakrishna Sastry, Mahadeva Sastri, Vijnanananda, and many others), and the open archives — Internet Archive, Sacred-Texts.com, Sanskrit Documents, KSTS, IFP, Adyar Library — that have made their digitization possible.
