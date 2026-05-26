# Favicon & OG Image Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Add a TLF-monogram favicon and a "hero-echo" Open Graph share image to the Tech Leaders' Forum site, both generated from source-controlled SVG/HTML so they can be regenerated without external tools.

**Architecture:** Two source files (`assets/favicon.svg`, `assets/og-image.html`) are hand-authored. A single shell script (`scripts/render-assets.sh`) uses macOS Chrome in headless mode to generate the PNG variants (`favicon-32.png`, `favicon-180.png`, `og-image.png`). The site references all assets via `<link>` and `<meta>` tags in `index.html`.

**Tech Stack:** Plain HTML/CSS/SVG. macOS Chrome headless for PNG rendering. No build pipeline, no npm dependencies.

---

## File Structure

**Create:**
- `assets/favicon.svg` — vector source for the TLF monogram (32×32 viewBox)
- `assets/favicon-32.png` — generated PNG fallback
- `assets/favicon-180.png` — generated apple-touch-icon
- `assets/og-image.html` — 1200×630 standalone HTML template for the OG image
- `assets/og-image.png` — generated OG image
- `scripts/render-assets.sh` — one-shot render script (Chrome headless → PNGs)

**Modify:**
- `index.html` — add favicon `<link>` tags and OG/Twitter `<meta>` tags in `<head>`
- `README.md` — add a short "Generating brand assets" section pointing at the script

Each file has one job: SVG = vector source; HTML template = OG layout; render script = SVG/HTML → PNG; index.html head = wiring. They're small enough to keep separate without overhead.

---

## Task 1: Favicon SVG source

**Files:**
- Create: `assets/favicon.svg`

- [ ] **Step 1: Write the SVG file**

Create `assets/favicon.svg` with the exact contents:

```xml
<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 32 32" width="32" height="32">
  <rect width="32" height="32" rx="6" fill="#030807"/>
  <text x="16" y="22" text-anchor="middle"
        font-family="'Space Grotesk', 'Helvetica Neue', Arial, sans-serif"
        font-weight="700" font-size="14" fill="#d6ff3f"
        letter-spacing="-0.3">TLF</text>
</svg>
```

Notes:
- `font-size="14"` (not 16) so the three letters sit comfortably inside the 32px square at 16×16 rendering.
- `letter-spacing="-0.3"` tightens the monogram so all three letters read clearly at tab size.
- The `font-family` fallback chain matters: SVG rendering in browsers will fall back to system fonts if Space Grotesk isn't installed. The lowercase-uppercase mix in the chain keeps fallback shapes consistent.

- [ ] **Step 2: Verify in browser**

Run: `open -a "Google Chrome" /Users/eszpee/projects/tlf/techleaders.forum/assets/favicon.svg`

Expected: lime "TLF" on black rounded square fills the viewport. All three letters visible and distinct.

If letters look cramped: increase viewBox/letter-spacing or drop to "T▶" — but check with the user first since the chosen concept (B) was the TLF monogram.

- [ ] **Step 3: Commit**

```bash
git add assets/favicon.svg
git commit -m "Add favicon SVG (TLF monogram)"
```

---

## Task 2: OG image HTML template

**Files:**
- Create: `assets/og-image.html`

- [ ] **Step 1: Write the HTML template**

Create `assets/og-image.html` with the exact contents:

```html
<!doctype html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <title>OG Image</title>
  <link rel="preconnect" href="https://fonts.googleapis.com" />
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
  <link
    href="https://fonts.googleapis.com/css2?family=Inter:wght@600;700&family=Space+Grotesk:wght@600;700&display=swap"
    rel="stylesheet"
  />
  <style>
    * { box-sizing: border-box; margin: 0; padding: 0; }
    html, body { width: 1200px; height: 630px; overflow: hidden; }
    body {
      font-family: 'Inter', -apple-system, system-ui, sans-serif;
      color: #fff;
      background:
        radial-gradient(120% 90% at 20% 10%, #083f22 0%, transparent 55%),
        radial-gradient(80% 70% at 90% 90%, #128b37 0%, transparent 55%),
        linear-gradient(180deg, #030807 0%, #07100e 100%);
      position: relative;
    }
    body::after {
      content: '';
      position: absolute; inset: 0; pointer-events: none;
      background-image:
        repeating-linear-gradient(0deg, rgba(255,255,255,.025) 0 1px, transparent 1px 48px),
        repeating-linear-gradient(90deg, rgba(255,255,255,.025) 0 1px, transparent 1px 48px);
    }
    .inner {
      position: absolute; inset: 88px 120px;
      display: flex; flex-direction: column; justify-content: center;
      gap: 44px;
      z-index: 1;
    }
    .label {
      font-size: 22px; font-weight: 700;
      letter-spacing: 0.22em; text-transform: uppercase;
      color: #d6ff3f;
    }
    .wordmark {
      font-family: 'Space Grotesk', sans-serif;
      font-weight: 700;
      font-size: 112px;
      line-height: 0.92;
      letter-spacing: -0.01em;
      white-space: nowrap;
      color: #fff;
    }
    .wordmark .play { color: #d6ff3f; }
    .tagline {
      font-family: 'Space Grotesk', sans-serif;
      font-weight: 600;
      font-size: 44px;
      line-height: 1.2;
      color: rgba(255,255,255,0.85);
      max-width: 920px;
    }
  </style>
</head>
<body>
  <div class="inner">
    <div class="label">English-language meetup · Budapest, Hungary</div>
    <div class="wordmark">Tech<br>Leaders'Forum<span class="play">&#9654;</span></div>
    <div class="tagline">Conversations on leadership challenges.</div>
  </div>
</body>
</html>
```

Notes:
- Sizes are exactly 2× the preview values the user approved (preview was 600×315, output is 1200×630).
- `&#9654;` is the play-triangle character that matches the existing logo.
- `font-display: swap` is implied by the Google Fonts URL — the render script handles waiting.

- [ ] **Step 2: Verify layout in browser**

Run: `open -a "Google Chrome" /Users/eszpee/projects/tlf/techleaders.forum/assets/og-image.html`

Expected: the page shows the lime "ENGLISH-LANGUAGE MEETUP · BUDAPEST, HUNGARY" label up top, big white "Tech / Leaders'Forum▶" wordmark with the triangle inline at the end of the second line, and "Conversations on leadership challenges." in lighter white below. All three vertically centered. No scrollbars.

The browser window may not be exactly 1200×630, but the body is locked to that size — content outside the window is clipped by `overflow: hidden`, which is fine; the render script will set the viewport correctly.

- [ ] **Step 3: Commit**

```bash
git add assets/og-image.html
git commit -m "Add OG image HTML template (hero-echo layout)"
```

---

## Task 3: Asset render script

**Files:**
- Create: `scripts/render-assets.sh`

- [ ] **Step 1: Write the render script**

Create `scripts/render-assets.sh` with the exact contents:

```bash
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
    --virtual-time-budget=10000 \
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
```

Notes:
- `--headless=new` is the modern flag for Chrome ≥112.
- `--virtual-time-budget=10000` gives Chrome 10s of virtual time to load fonts before screenshotting — important for the OG image.
- A fresh `--user-data-dir` per invocation avoids "Chrome is already running" errors if a normal Chrome window is open.
- The script intentionally has no flag to render only one asset — if a source changes, regenerate all three (cheap, ~5 seconds total).

- [ ] **Step 2: Make the script executable**

Run: `chmod +x /Users/eszpee/projects/tlf/techleaders.forum/scripts/render-assets.sh`

- [ ] **Step 3: Run the script**

Run: `/Users/eszpee/projects/tlf/techleaders.forum/scripts/render-assets.sh`

Expected output:
```
Rendering favicon PNGs...
  -> /Users/eszpee/projects/tlf/techleaders.forum/assets/favicon-32.png
  -> /Users/eszpee/projects/tlf/techleaders.forum/assets/favicon-180.png
Rendering OG image...
  -> /Users/eszpee/projects/tlf/techleaders.forum/assets/og-image.png
Done.
```

- [ ] **Step 4: Verify the generated PNGs**

Run each, separately:

```bash
file /Users/eszpee/projects/tlf/techleaders.forum/assets/favicon-32.png
file /Users/eszpee/projects/tlf/techleaders.forum/assets/favicon-180.png
file /Users/eszpee/projects/tlf/techleaders.forum/assets/og-image.png
```

Expected: each line should report PNG with the correct dimensions:
- `favicon-32.png … PNG image data, 32 x 32, …`
- `favicon-180.png … PNG image data, 180 x 180, …`
- `og-image.png … PNG image data, 1200 x 630, …`

Then visually open the OG image:

```bash
open /Users/eszpee/projects/tlf/techleaders.forum/assets/og-image.png
```

Expected: matches the v3 mockup the user approved — lime label up top, white "Tech / Leaders'Forum▶" wordmark with lime triangle inline at end of second line, "Conversations on leadership challenges." tagline below, dark gradient background with faint grid. **Critical check:** the wordmark must use Space Grotesk (geometric, not Arial-looking). If the wordmark fell back to a system font, increase `--virtual-time-budget` to 20000 and re-render.

- [ ] **Step 5: Commit script and generated PNGs**

```bash
git add scripts/render-assets.sh assets/favicon-32.png assets/favicon-180.png assets/og-image.png
git commit -m "Add render script and generated brand asset PNGs"
```

---

## Task 4: Wire up favicon link tags

**Files:**
- Modify: `index.html` (in `<head>`, near the existing `<meta>` tags around line 7-11)

- [ ] **Step 1: Add favicon link tags**

In `index.html`, find this block:

```html
    <title>Tech Leaders' Forum</title>
    <meta
      name="description"
      content="An English-language, in-person forum in Budapest for engineering and tech leaders."
    />
```

Insert immediately after the `<meta name="description" …/>` tag:

```html
    <link rel="icon" type="image/svg+xml" href="assets/favicon.svg" />
    <link rel="icon" type="image/png" sizes="32x32" href="assets/favicon-32.png" />
    <link rel="apple-touch-icon" sizes="180x180" href="assets/favicon-180.png" />
```

- [ ] **Step 2: Verify in browser**

Run: `open -a "Google Chrome" /Users/eszpee/projects/tlf/techleaders.forum/index.html`

Expected: the browser tab now shows the lime TLF monogram instead of the default page icon. (If the tab is too small to see clearly, the same icon should also show on bookmarks.)

If the favicon doesn't appear, hard-refresh (`Cmd+Shift+R`) — Chrome caches favicons aggressively.

- [ ] **Step 3: Commit**

```bash
git add index.html
git commit -m "Wire up favicon link tags in index.html"
```

---

## Task 5: Wire up Open Graph and Twitter meta tags

**Files:**
- Modify: `index.html` (in `<head>`, immediately after the favicon links from Task 4)

- [ ] **Step 1: Add OG/Twitter meta tags**

In `index.html`, immediately after the three favicon `<link>` tags added in Task 4, insert:

```html
    <meta property="og:title" content="Tech Leaders' Forum" />
    <meta property="og:description" content="An English-language, in-person forum in Budapest for engineering and tech leaders." />
    <meta property="og:image" content="https://techleaders.forum/assets/og-image.png" />
    <meta property="og:url" content="https://techleaders.forum/" />
    <meta property="og:type" content="website" />
    <meta name="twitter:card" content="summary_large_image" />
    <meta name="twitter:image" content="https://techleaders.forum/assets/og-image.png" />
```

Note: the absolute `https://techleaders.forum/` URLs are required — relative paths break LinkedIn/Slack previews.

- [ ] **Step 2: Verify meta tags in source**

Run: `grep -E 'og:|twitter:' /Users/eszpee/projects/tlf/techleaders.forum/index.html`

Expected: prints the seven lines added in Step 1.

- [ ] **Step 3: Verify share preview (after deploying)**

This step happens once the site is deployed to `techleaders.forum`. Until then, the OG image is referenced by an absolute URL that won't resolve from a local file. Two ways to verify post-deploy:

- Paste `https://techleaders.forum/` into LinkedIn's post composer (don't submit) — preview should show the hero-echo card.
- Use `https://www.opengraph.xyz/url/https%3A%2F%2Ftechleaders.forum%2F` to inspect tags + preview.

If the OG image doesn't appear in the preview, common causes:
- Cache: LinkedIn caches OG previews — use the LinkedIn Post Inspector to refresh.
- HTTPS: the `og:image` URL must be HTTPS; mixed-content will be silently dropped.
- Path: confirm the deployed site actually serves `/assets/og-image.png`.

- [ ] **Step 4: Commit**

```bash
git add index.html
git commit -m "Add Open Graph and Twitter meta tags"
```

---

## Task 6: Document the render workflow

**Files:**
- Modify: `README.md` (add a new subsection under "Files" or at the end)

- [ ] **Step 1: Add a "Brand assets" section to the README**

Append to `README.md`:

```markdown

## Brand assets

The favicon and Open Graph share image are generated from source files:

- `assets/favicon.svg` — TLF monogram (vector source)
- `assets/og-image.html` — 1200×630 HTML template for the social share card

To regenerate the PNG variants after editing either source, run:

```bash
./scripts/render-assets.sh
```

Requires Google Chrome installed at the default macOS path. The script writes:

- `assets/favicon-32.png`
- `assets/favicon-180.png`
- `assets/og-image.png`

Commit the regenerated PNGs alongside the source change.
```

- [ ] **Step 2: Commit**

```bash
git add README.md
git commit -m "Document brand asset regeneration workflow"
```

---

## Final verification

- [ ] **Open `index.html` in Chrome.** Tab shows the lime TLF monogram. View source and confirm all seven OG/Twitter meta tags are present.
- [ ] **Open `assets/og-image.png`.** Matches the v3 mockup (label, wordmark with triangle inline, tagline; Space Grotesk loaded, not Arial).
- [ ] **Run `./scripts/render-assets.sh` once more from clean.** Output PNGs unchanged (byte-identical or visually identical — fonts may anti-alias slightly differently between runs, that's acceptable).
- [ ] **Git log shows ~6 small commits**, one per task, each with a focused message.

If all checks pass, the work is done. Deploy verification (LinkedIn / Slack share previews) happens after the next site deploy and isn't blocking for merge.
