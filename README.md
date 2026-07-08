# Where does the data come from?

**Reproducible data management for big neuroimaging** — a 30-minute workshop talk built around [DataLad](https://www.datalad.org/).

[![Open In Colab](https://colab.research.google.com/assets/colab-badge.svg)](https://colab.research.google.com/github/arush-arun/AS4SAN-Workshop/blob/master/AS4SAN_Workshop_DataLad.ipynb)

## Build the slides

Requires [Quarto](https://quarto.org/) (tested with 1.9.38).

```bash
# Self-contained HTML deck
quarto render slides.qmd --to html

# PDF fallback (uses Quarto's built-in typst engine)
quarto render slides.qmd --to typst --output slides.pdf
```

Outputs: `slides.html` and `slides.pdf` (both gitignored).

## Record the demo cast

Requires [asciinema](https://asciinema.org/) and [DataLad](https://www.datalad.org/).

```bash
./demo/record.sh
```

The cast is saved to `demo/casts/demo.cast` and embedded in slide 5.

## Create the example dataset

```bash
./example-dataset/make_example_dataset.sh
```

Requires DataLad and git-annex. Exits gracefully if they're not installed.

## Repo structure

```
├── slides.qmd                    # the deck (Quarto → reveal.js)
├── _quarto.yml                   # Quarto project config
├── demo/
│   ├── demo.sh                   # DataLad core loop demo script
│   ├── record.sh                 # asciinema recording helper
│   └── casts/                    # recorded .cast files
├── example-dataset/
│   └── make_example_dataset.sh   # creates a tiny DataLad dataset
├── assets/                       # images, diagrams, logos
└── environment.md                # pinned tool versions
```

## Tool versions

See [environment.md](environment.md) for the full list.
