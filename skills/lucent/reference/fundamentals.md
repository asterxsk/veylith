# Fundamentals

The rules that make an interface legible before any design system, effect, or direction choice.
Fixing these is almost always a larger improvement than anything else in this skill.

## Hierarchy

- **One focal point per view.** Everything else is subordinate. If two things compete, one is
  decoration and should be removed.
- **Hierarchy from size, weight, and space** — in that order. Colour and capitals are the
  weakest levers and the first ones overused.
- **Three levels of type is usually enough** for a page: display, body, meta. More levels
  flatten rather than enrich.
- **A heading is closer to its own content than to what precedes it.** If it is not, the
  whitespace is misassigned, not the type scale.
- **The first screen must answer "what is this and what do I do."** Not by cramming — by
  ordering.

## Spacing

- **Spacing does the separating.** Reach for space before a rule, a border, a card, or a tint.
- **One rhythm.** Pick a base unit (4px or 8px) and use only its multiples. Arbitrary values
  (13px, 22px, 37px) are how a layout stops looking intentional.
- **Proximity groups.** Related items close, unrelated items further. Do not rely on a divider
  to express a relationship that spacing could express better.
- **Balanced top and bottom.** Compare the *visible* content bounds, not the CSS box. A heading's
  ascent, a footer, a caption, and a sticky header all change perceived space.
- **Guard against top-hugging:** a little space above the content and a large dead area below
  means the composition is mispositioned, not that it needs padding on the title alone.
- **Preserve deliberate asymmetry** when it has an optical reason — with the reason stated.

## Type

- **Body at 16px minimum on mobile; 17–18px is often better for long reading.** 60–75 characters
  per line. Leading 1.5–1.65 for body, tighter for display (1.0–1.15).
- **Line length is a design decision.** A full-width paragraph in a 1440px layout is unreadable
  regardless of font.
- **A real type scale**, not arbitrary sizes. Ratio 1.125–1.25 for dense surfaces, 1.25–1.5 for
  display-led pages.
- **Two families at most.** One text face and one display face, or one face with several weights.
  A third face needs a specific job.
- **Reserve monospace** for code, identifiers, and aligned technical values. Never for labels.
- **Sentence case for headings and labels**, except proper nouns.
- **Small labels are serif italic, sentence case, untracked, one step under body.** One rule,
  every medium — [labels.md](labels.md). Never tracked uppercase mono.
- **Do not apply `text-transform` globally.** Casing belongs in the source where a writer can
  protect `HRTF`, `8D`, `IRQ`, `CPU`, units, and product names.
- **Do not shrink type to fit content.** Cut the content. Compressing the prose is cheaper than
  compressing the reader.
- **Subset and self-host where the medium allows.** System font stacks are a fallback, not a
  design decision, for a page with a designed world.

## Colour

- **One accent.** Everything else is neutral plus a semantic set (success, warning, danger,
  info). A page with five accents has no accent.
- **Semantic tokens, not raw values.** `--surface`, `--surface-raised`, `--text-muted`,
  `--border-subtle` — not `#f5f5f5` scattered across components.
- **Contrast is a requirement, not a target.** WCAG AA: 4.5:1 for body, 3:1 for large text and
  UI boundaries. Check against the *busiest* thing that can appear behind, not the calmest.
- **Text over imagery or effects needs a real backing** — a scrim, a wash, or a solid surface.
  Not hope, and not a text-shadow.
- **Colour is never the only carrier of meaning.** State gets an icon, a label, or a shape too.
- **Dark mode is a token swap**, designed and tested — not `filter: invert()` and not a
  lightened background with unchanged text colours.
- **Use OKLCH where the stack supports it** for perceptually even scales; hex is fine where it
  does not.

## Layout

- **Every container needs a resolved height.** A flex child with no intrinsic height is the
  single most common cause of a blank canvas or a collapsed section.
- **Respect the small viewport.** Use `svh` units on mobile, not `vh` — address bars change the
  real height mid-scroll.
- **Mobile is not a shrink.** It is a different ordering. Decide what drops from the first
  screen.
- **No horizontal overflow.** Test at 320px; a single wide element breaks the whole page.
- **Sticky and fixed elements need their offset accounted for** in scroll targets, anchors, and
  the space above headings.

## States

Every interactive element has all of these designed. A page with only the default state is a
mockup.

| State | Requirement |
|---|---|
| Hover | Visible change. Not the only affordance — it is unavailable on touch |
| Focus | Visible, keyboard-only-obvious ring with sufficient contrast. Never `outline: none` alone |
| Active / pressed | Immediate feedback, faster than the hover transition |
| Disabled | Visibly inert, and with a reason the user can find |
| Loading | A stable layout — no shift when content arrives, no spinner where a skeleton reads better |
| Empty | Explains what goes here and how to fill it |
| Error | Says what went wrong, what to do, and preserves the input |

## Accessibility floor

Non-negotiable, and cheaper to do now than to retrofit:

- Keyboard path exists for every action; focus order follows reading order; focus is trapped in
  modals and restored on close.
- Real elements: `<button>`, `<a href>`, `<label for>`. A clickable `<div>` is not a control.
- Images carry `alt` — descriptive when meaningful, `alt=""` when decorative.
- Form errors are announced, not just coloured.
- Motion respects `prefers-reduced-motion`.
- Nothing conveys meaning by colour alone.
- Contrast passes at AA, including placeholder text, disabled text, and text over effects.

## Content

- **Concrete over abstract.** "Cut render time by 40%" beats "optimise your pipeline."
- **Cut filler.** Eyebrows that repeat the heading, captions that restate the image, and
  conclusions that repeat the introduction.
- **Honest scale and units** on any chart or metric. No invented precision.
- **The best copy is usually shorter.** Rewrite before you restyle.

## The inspector's questions

Ask these on the built artifact, at real size:

1. Is there one clear place for the eye to begin?
2. Does the spacing express the grouping, or is a divider doing it?
3. Is any label shouting?
4. Does the hierarchy survive squinting?
5. Does the top and bottom of every section feel balanced?
6. Are the states designed, or only the default?
7. Does the contrast hold against the busiest background it can meet?
8. Does it still work at 320px, at 200% zoom, with a keyboard, and with reduced motion?
