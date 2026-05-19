# Tech Leaders' Forum

A standalone static landing page concept for Tech Leaders' Forum.

Open the project through a local preview server or load `index.html` directly in a browser. The page uses local assets from `assets/` and is styled in `styles.css`.

## Files

- `index.html`: page structure and event copy
- `styles.css`: visual design inspired by the provided flyer
- `assets/tech-leaders-forum-logo.svg`: supplied logo
- `assets/flyer-reference.png`: supplied flyer reference

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

Fonts are loaded from Google Fonts:

- `Inter`: default body/UI font
- `Space Grotesk`: display headings

Type rules:

- Headings are bold, compact, and high-contrast.
- Section labels use uppercase lime text via `.section-label`.
- Supporting copy uses `--soft-white`, heavy weight, and generous line height.
- Keep big display type for major narrative moments only. Cards, panels, and operational text should stay tighter and calmer.
- Do not use negative letter spacing.

### Logo

Use `assets/tech-leaders-forum-logo.svg` for the logo. It should remain white and visually prominent in the hero and header.

Hero hierarchy:

1. Logo
2. Lime subtitle
3. Supporting copy
4. CTA buttons and summary panel

The subtitle should never overpower the logo.

### Boxes And Cards

All standard boxes should use the same visual language:

- background: `var(--box-bg)`
- border: `1px solid var(--box-border)`
- border radius: `8px`
- optional shadow: `var(--shadow)` for larger framed components
- hover lift: subtle upward movement, brighter lime border, slightly darker background

This applies to host cards, value cards, rule cards, panelist placeholders, conference cards, carousel shell, and the hero summary panel. Timeline cards are currently excluded from generic reveal animation because the timeline is planned for rework.

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
- section reveal on scroll, excluding the timeline for now

Respect `prefers-reduced-motion: reduce`; animations and transitions should effectively stop for users who request reduced motion.

### Imagery

Use real meetup photos whenever showing the event experience. Images should communicate:

- moderated panel
- open-room participation
- informal networking
- CraftHub/Kluster venue energy

Avoid abstract stock imagery, generic tech illustrations, decorative blobs, or SVG hero art. The site should feel like a real community, not a generic event template.

### Layout Principles

- Keep sections spacious but not billboard-like.
- Prefer balanced two-column layouts for narrative sections.
- Stack content when hierarchy needs clarity, especially conference/event blocks.
- Avoid nested cards.
- Avoid hard horizontal lines between sections.
- Keep mobile layouts single-column and readable.
