# Claude Code task: scaffold a reproducible Quarto talk repo

## Context

I'm giving a **20-minute workshop talk** on reproducible data management for big
neuroimaging, built around **DataLad**. The talk's own thesis is "know where your
data comes from and track it," so the slides themselves should be a clean,
version-controlled, diffable git repo — the medium is part of the message.

Your job is to **scaffold the repository and its build/demo tooling**. Do **not**
write the actual slide prose — I'm drafting that separately and will paste it in.
Leave clearly marked `TODO` placeholders for all slide content.

## Tech stack (use exactly this)

- **Slides:** Quarto → reveal.js. Markdown source (`.qmd`) so it diffs cleanly in git.
- **Outputs:** a self-contained HTML deck (`embed-resources: true`) **and** a PDF
  fallback for offline/projector safety. Both must actually build — verify this.
- **Demo:** a shell script of the DataLad steps, recorded to an **asciinema** cast.
  The fragile git-annex parts stay pre-recorded, never run live.
- **Example dataset:** a tiny DataLad dataset creation script, guarded so the repo
  still works if `datalad` isn't installed.

## Environment — check, don't assume

Assume a local machine with `git`. At the start, check whether `quarto`,
`asciinema`, `datalad`, and `git-annex` are installed. **Report what's missing with
install instructions rather than silently installing system packages.** The deck
must render to HTML and PDF **without** `datalad` present — do not make rendering
depend on datalad being installed (any datalad output on slides should be
pre-captured static text/casts, not executed at render time).

## Target repo structure

```
datalad-workshop-talk/
├── README.md                     # what this is, how to build HTML + PDF, tool versions
├── _quarto.yml                   # project config
├── slides.qmd                    # the deck — STRUCTURE ONLY, content as TODOs
├── demo/
│   ├── demo.sh                   # install → get → run → rerun, commented
│   ├── record.sh                 # asciinema recording helper
│   └── casts/                    # recorded .cast files live here
├── example-dataset/
│   └── make_example_dataset.sh   # creates a tiny DataLad dataset (guarded)
├── assets/                       # images, diagrams, logos
├── .gitignore                    # ignore .quarto/, *_files/, render artifacts
└── environment.md                # pinned versions of quarto/datalad/git-annex/asciinema
```

## slides.qmd requirements

- reveal.js format, self-contained, sensible theme, footer with talk title.
- Create **one placeholder slide (or section) per beat below**, in this order,
  with the given titles. Put a one-line `<!-- TODO: content -->` marker and a
  stubbed speaker-notes block (`::: notes` … `:::`) on each. Do **not** write prose.

  1. Title slide — *Where does the data come from? Reproducible data management for big neuroimaging*
  2. Hook — every other module assumes the data is already here
  3. The concrete problem — MR-RATE as anchor (too big to just download)
  4. The idea — DataLad as version control for data (git + git-annex, mental model)
  5. The core loop — `install` → `get` → `run` → `rerun` (this is the heart; leave room for the embedded cast)
  6. Why it matters — provenance, "which data made this figure," multi-site
  7. On-ramp — sets up the notebook exercise (participants `datalad get` the workshop dataset)
  8. Pointers — DataLad handbook, OpenNeuro, datasets.datalad.org

- On slide 5, wire up a placeholder for embedding the asciinema cast (e.g. an
  `<script>`/iframe include or a fallback linked GIF), with a comment explaining
  how to swap in the real cast file.

## demo/demo.sh requirements

- A commented, runnable sequence demonstrating the core loop on a small public
  dataset: `datalad install` (metadata only) → `datalad get` a subset →
  `datalad run` wrapping a trivial analysis → `datalad rerun` to reproduce it.
- Keep it strictly to that loop. **No special remotes, no git-annex internals.**
- `record.sh` should record `demo.sh` to `demo/casts/` via asciinema, with the
  exact command documented in the README.

## example-dataset/make_example_dataset.sh requirements

- Creates a minimal DataLad dataset (a handful of tiny dummy files) to point people
  to after the talk. Guard the whole thing with a `command -v datalad` check that
  prints a friendly message and exits 0 if datalad is absent.

## Reproducibility / hygiene

- `git init`, sensible `.gitignore`, and make **small, logically-scoped commits**
  as you build (not one giant commit).
- README documents the exact build commands for both HTML and PDF, and lists the
  tool versions you actually used (from the environment check).

## What NOT to do

- Do **not** write slide prose or speaker notes content — placeholders only.
- Do **not** run git-annex or datalad live as part of rendering.
- Do **not** install system packages silently — report and instruct instead.
- Do **not** add extra frameworks, build systems, or scope beyond the above.

## When done

Print a short summary: the tree, the exact HTML and PDF build commands, anything
that was missing from the environment, and confirmation that both outputs rendered.
