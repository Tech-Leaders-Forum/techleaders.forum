#!/usr/bin/env bash
# Regenerate PNG variants of the favicon and OG image from their sources.
# Requires Google Chrome installed on macOS at the default path.

set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
CHROME="/Applications/Google Chrome.app/Contents/MacOS/Google Chrome"

if [[ ! -x "$CHROME" ]]; then
  echo "Chrome not found at $CHROME — install it or update this script." >&2
  exit 1
fi

render() {
  local input="$1"
  local output="$2"
  local size="$3"
  local tmp
  tmp="$(mktemp -d)"
  "$CHROME" \
    --headless=new \
    --disable-gpu \
    --hide-scrollbars \
    --no-sandbox \
    --window-size="$size" \
    --default-background-color=00000000 \
    --user-data-dir="$tmp" \
    --screenshot="$output" \
    "file://$input" >/dev/null 2>&1
  rm -rf "$tmp"
  echo "  -> $output"
}

echo "Rendering favicon PNGs..."
render "$ROOT/assets/favicon.svg" "$ROOT/assets/favicon-32.png"  "32,32"
render "$ROOT/assets/favicon.svg" "$ROOT/assets/favicon-180.png" "180,180"

echo "Rendering OG image..."
render "$ROOT/assets/og-image.html" "$ROOT/assets/og-image.png" "1200,630"

echo "Done."
