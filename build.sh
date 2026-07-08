#!/usr/bin/env bash
# build.sh — Render slides and produce a self-contained HTML with embedded asciinema player
set -euo pipefail

echo "Rendering slides..."
quarto render slides.qmd --to html

echo "Inlining asciinema assets into slides.html..."

# Read the JS and CSS content
JS_CONTENT=$(cat assets/asciinema-player.min.js)
CSS_CONTENT=$(cat assets/asciinema-player.min.css)

# Replace the <script src="..."> with inline <script>...</script>
# and <link rel="stylesheet" href="..."> with inline <style>...</style>
python3 -c "
import re, sys

with open('slides.html', 'r') as f:
    html = f.read()

with open('assets/asciinema-player.min.js', 'r') as f:
    js = f.read()

with open('assets/asciinema-player.min.css', 'r') as f:
    css = f.read()

# Replace script src with inline
html = html.replace(
    '<script src=\"assets/asciinema-player.min.js\"></script>',
    '<script>' + js + '</script>'
)

# Replace link href with inline style
html = html.replace(
    '<link rel=\"stylesheet\" href=\"assets/asciinema-player.min.css\">',
    '<style>' + css + '</style>'
)

with open('slides.html', 'w') as f:
    f.write(html)
"

SIZE=$(wc -c < slides.html)
echo "Done. Self-contained slides.html (${SIZE} bytes)"
