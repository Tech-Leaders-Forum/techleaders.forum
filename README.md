# Tech Leaders' Forum 

A standalone static landing page concept for Tech Leaders' Forum.

Open the project through a local preview server or load `index.html` directly in a browser. The page uses local assets from `assets/` and is styled in `styles.css`.

## Files

- `index.html`: page structure and event copy
- `privacy.html`: GDPR Art. 13 privacy policy, linked from the site footer
- `styles.css`: visual design inspired by the provided flyer
- `assets/fonts/`: self-hosted Inter and Space Grotesk woff2 files (latin + latin-ext subsets)
- `assets/tech-leaders-forum-logo.svg`: primary Tech Leaders' Forum logo
- `assets/crafthub.svg`: logistics partner logo
- `assets/kluster.svg`: venue logo for the next forum session
- `assets/meetup-*.jpg`: meetup photography for the gallery carousel
- `assets/panelist-*.jpg` / `assets/panelist-*.jpeg`: previous panelist photos
- `assets/flyer-reference.png`: original flyer reference

## Design System

The visual direction is intentionally close to the Tech Leaders' Forum flyer: dark, high-contrast, confident, with lime-green accents and real meetup photography. Keep the page calm and editorial rather than playful or overly decorative.

### Palette

Core colors are defined as CSS custom properties in `styles.css`.

| Token | Value | Usage |
| --- | --- | --- |
| `--black` | `#030807` | Main page base, dark card interiors, timeline dots |
| `--charcoal` | `#07100e` | Deep neutral support tone |
| `--green-900` | `#082218` | Dark green foundation |
| `--green-800` | `#083f22` | Background depth |
| `--green-700` | `#128b37` | Supporting green |
| `--green-500` | `#22d14f` | Brighter green accent, used sparingly |
| `--lime` | `#d6ff3f` | Primary accent: section labels, borders, timeline, active states |
| `--lime-hot` | `#b7ff18` | Hotter lime accent for glow/energy |
| `--aqua` | `#35f2a2` | Secondary glow accent, not a dominant UI color |
| `--white` | `#ffffff` | Primary text and white CTAs |
| `--soft-white` | `rgba(255, 255, 255, 0.78)` | Body copy and supporting text |
| `--faint-white` | `rgba(255, 255, 255, 0.12)` | Subtle dividers and inner borders |
| `--line` | `rgba(255, 255, 255, 0.18)` | Low-emphasis line work |
| `--box-bg` | `rgba(3, 8, 7, 0.48)` | Standard translucent box background |
| `--box-border` | `rgba(214, 255, 63, 0.32)` | Standard subtle lime box border |
| `--shadow` | `0 26px 90px rgba(0, 0, 0, 0.42)` | Main elevated shadow |

Avoid introducing new dominant colors unless the brand direction changes. The page should not drift into blue/purple gradients, beige neutrals, or a generic SaaS palette.

### Background

The page uses one continuous fixed background across the whole site:

- black-to-deep-green linear gradient
- subtle lime and aqua radial glows
- fixed texture overlay using faint grid/noise patterns
- slow `backgroundDrift` animation for life without visual noise

Sections should remain transparent unless there is a strong reason to isolate content. Avoid horizontal separators and hard section cuts.

### Typography

Fonts are self-hosted under `assets/fonts/` (woff2, latin + latin-ext subsets) to avoid the IP-transfer issue of loading from the Google Fonts CDN. `@font-face` declarations live at the top of `styles.css`.

- `Inter`: default body/UI font (weights 500, 700, 800, 900)
- `Space Grotesk`: display headings (weights 600, 700)

Type rules:

- Headings are bold, compact, and high-contrast.
- Section labels use uppercase lime text via `.section-label`.
- Supporting copy uses `--soft-white`, heavy weight, and generous line height.
- Keep big display type for major narrative moments only. Cards, panels, and operational text should stay tighter and calmer.
- Do not use negative letter spacing.

### Logo

Use `assets/tech-leaders-forum-logo.svg` for the Tech Leaders' Forum logo. It should remain white and visually prominent in the hero and header.

Hero hierarchy:

1. Logo
2. Lime subtitle
3. Supporting copy
4. CTA buttons and summary panel

The subtitle should never overpower the logo.

Partner and venue logos:

- `assets/crafthub.svg` appears in the hosts/logistics section and should be centered within its box while the "Logistics by" label stays top-left.
- `assets/kluster.svg` appears beside the next session date and should read as metadata, not as a dominant brand element.

### Boxes And Cards

All standard boxes should use the same visual language:

- background: `var(--box-bg)`
- border: `1px solid var(--box-border)`
- border radius: `8px`
- optional shadow: `var(--shadow)` for larger framed components
- hover lift: subtle upward movement, brighter lime border, slightly darker background

This applies to the hero summary panel, host cards, logistics card, value cards, rule cards, panelist cards, timeline cards, conference cards, carousel shell, and contact CTA area.

Conference timeline cards use a slightly lighter translucent background than normal forum-session cards so conference collaborations are visually distinct without introducing a new component family.

Badges:

- `Forum Session`: normal TLF sessions
- `Conference Collaboration`: TLF activity inside a partner conference

Badges should stay compact, uppercase, lime-accented, and secondary to the event title.

### Buttons

Primary CTAs:

- white pill background
- black text
- uppercase, heavy weight
- hover changes background to lime
- slight hover lift and press-down on click

Ghost CTAs:

- translucent dark background
- lime/dark border language
- used only as secondary actions

Keep CTA labels short and action-oriented.

### Motion

Motion should be subtle and functional:

- hero entrance on load
- slow background drift
- carousel auto-advance every 5.5 seconds
- carousel pauses on hover/focus
- card hover lift
- button hover/press micro-interactions
- section reveal on scroll
- timeline dots and cards may animate subtly, but the layout should remain robust on mobile

Respect `prefers-reduced-motion: reduce`; animations and transitions should effectively stop for users who request reduced motion.

### Imagery

Use real meetup photos whenever showing the event experience. Images should communicate:

- moderated panel
- open-room participation
- informal networking
- CraftHub/Kluster venue energy

Avoid abstract stock imagery, generic tech illustrations, decorative blobs, or SVG hero art. The site should feel like a real community, not a generic event template.

People photos:

- Host photos use large circular crops, centered in their cells.
- Previous panelist photos use the same circular treatment at a smaller scale.
- Use `object-position` per image when needed so heads are not cropped.
- If a panelist photo is unavailable, keep a quiet placeholder circle rather than changing the grid structure.

Gallery:

- The meetup gallery sits after the "What happens here" section.
- It uses five local meetup photos in a single carousel.
- Controls should be visible and keyboard-accessible.
- Autoplay should pause on hover and focus.

### Timeline

The sessions area uses a centered vertical timeline on desktop and a left-rail timeline on mobile.

Current content groups:

- Upcoming: October 2026 Compass AI & Tech Summit collaboration, August 2026 forum session, June 2026 Craft Conference collaboration
- Previous sessions: April 2026 Managing Remote Teams, February 2026 AI use for Engineering Managers

Timeline rules:

- Alternate event cards left and right on desktop.
- Keep timeline dots aligned to the vertical rail.
- Use short horizontal connectors from each card to its dot only when they remain pixel-aligned and responsive.
- Stack to one side on mobile with the rail on the left.
- Normal forum sessions use darker cards; conference collaborations use slightly lighter cards.
- CTAs inside timeline cards should use the existing ghost button style.

### Layout Principles

- Keep sections spacious but not billboard-like.
- Prefer balanced two-column layouts for narrative sections.
- Stack content when hierarchy needs clarity, especially conference/event blocks.
- Avoid nested cards.
- Avoid hard horizontal lines between sections.
- Keep mobile layouts single-column and readable.

## Brand assets

The favicon and Open Graph share image are generated from source files:

- `assets/favicon.svg` — TLF monogram (vector source)
- `assets/og-image.html` — 1200×630 HTML template for the social share card

To regenerate the PNG variants after editing either source, run:

```bash
./scripts/render-assets.sh
```

Requires `rsvg-convert` (`brew install librsvg`) and Google Chrome installed at the default macOS path. The script writes:

- `assets/favicon-32.png`
- `assets/favicon-180.png`
- `assets/og-image.png`

Commit the regenerated PNGs alongside the source change.
