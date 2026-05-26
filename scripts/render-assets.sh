#!/usr/bin/env bash
# Regenerate PNG variants of the favicon and OG image from their sources.
# Requires:
#   - rsvg-convert (brew install librsvg)
#   - Google Chrome at the default macOS path (for the HTML-based OG image)

set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
CHROME="/Applications/Google Chrome.app/Contents/MacOS/Google Chrome"

require() {
  command -v "$1" >/dev/null 2>&1 || { echo "Missing dependency: $1" >&2; exit 1; }
}
require rsvg-convert

if [[ ! -x "$CHROME" ]]; then
  echo "Chrome not found at $CHROME — install it or update this script." >&2
  exit 1
fi

echo "Rendering favicon PNGs..."
rsvg-convert -w 32  -h 32  "$ROOT/assets/favicon.svg" -o "$ROOT/assets/favicon-32.png"
echo "  -> $ROOT/assets/favicon-32.png"
rsvg-convert -w 180 -h 180 "$ROOT/assets/favicon.svg" -o "$ROOT/assets/favicon-180.png"
echo "  -> $ROOT/assets/favicon-180.png"

echo "Rendering OG image..."
profile="$(mktemp -d)"
og_out="$ROOT/assets/og-image.png"
rm -f "$og_out"

cleanup() {
  if [[ -n "${chrome_pid:-}" ]]; then
    kill -TERM "$chrome_pid" 2>/dev/null || true
    for _ in $(seq 1 10); do
      kill -0 "$chrome_pid" 2>/dev/null || break
      sleep 0.2
    done
    kill -KILL "$chrome_pid" 2>/dev/null || true
    wait "$chrome_pid" 2>/dev/null || true
  fi
  rm -rf "$profile"
}
trap cleanup EXIT

# --virtual-time-budget waits for the page (incl. web fonts) to settle before
# capturing, so the screenshot is deterministic regardless of network speed.
# Chrome occasionally hangs on shutdown after writing the screenshot, so we
# background it and let the EXIT trap terminate it.
"$CHROME" \
  --headless=new \
  --disable-gpu \
  --hide-scrollbars \
  --no-sandbox \
  --no-first-run \
  --no-default-browser-check \
  --window-size=1200,630 \
  --default-background-color=00000000 \
  --virtual-time-budget=10000 \
  --user-data-dir="$profile" \
  --screenshot="$og_out" \
  "file://$ROOT/assets/og-image.html" >/dev/null 2>&1 &
chrome_pid=$!

# Wait up to 30s for the screenshot to land.
for _ in $(seq 1 60); do
  if [[ -s "$og_out" ]]; then
    sleep 0.5  # let Chrome finish writing
    break
  fi
  sleep 0.5
done

if [[ ! -s "$og_out" ]]; then
  echo "OG image render failed — Chrome never wrote $og_out" >&2
  exit 1
fi
echo "  -> $og_out"

echo "Done."
