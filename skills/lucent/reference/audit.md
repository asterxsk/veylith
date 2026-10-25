# Audit

One batched pass at the end, then stop. The point is to catch what a screenshot cannot show, not
to iterate until the diff is empty.

## How to run it

1. Inspect the **real artifact** at real size — a rendered page at desktop and a narrow mobile
   width, fonts and assets loaded. Not a hero screenshot, not a component preview.
2. Collect every finding in one round. Fix them in one batch.
3. Confirm once. Stop.

Screenshotting the hero and declaring it verified is the failure mode. Cleanup that improves the
hero and makes the rest denser has not solved the problem.

## The checklist

### Content and hierarchy

- [ ] One clear place for the eye to begin, at every section.
- [ ] Headings are closer to their own content than to what precedes them.
- [ ] The first screen answers "what is this and what do I do."
- [ ] Copy is concrete — no filler eyebrows, no captions restating the image, no inflated claims.
- [ ] Real content or obvious placeholders. No invented metrics, testimonials, or logos.
- [ ] Nothing truncated by a fixed height at any breakpoint.

### Structure

- [ ] Spacing expresses grouping; dividers are not doing the work.
- [ ] No repeated horizontal rules, boxed sections, or label pills that only announce a block.
- [ ] Top and bottom of every section look balanced, judged by visible bounds.
- [ ] No horizontal overflow at 320px.
- [ ] No layout shift when fonts load, images arrive, or content fills.
- [ ] Sticky and fixed offsets accounted for in anchors and in space above headings.

### Type

- [ ] Body at 16px minimum, 60–75 characters per line, leading 1.5+.
- [ ] One type scale; no arbitrary sizes.
- [ ] Labels are serif italic, sentence case, untracked — no `text-transform: uppercase`, no
      `letter-spacing` on a label ([labels.md](labels.md)).
- [ ] Acronyms and identifiers survive verbatim (`HRTF`, `8D`, `IRQ`, `CPU`, units).
- [ ] Sentence case for headings.
- [ ] A real italic cut is shipped; no synthesised slant.

### Colour and contrast

- [ ] AA contrast on body (4.5:1) and large text / UI boundaries (3:1), including placeholders,
      disabled text, and text over effects.
- [ ] Contrast checked against the *busiest* thing that can appear behind.
- [ ] One accent; semantic tokens, not scattered hex.
- [ ] No meaning carried by colour alone.
- [ ] Dark mode defined, token-swapped, and tested — not an inversion.

### Interaction and states

- [ ] Hover, focus, active, disabled, loading, empty, and error all designed.
- [ ] Focus ring visible, sufficient contrast, keyboard-only-obvious.
- [ ] Keyboard reaches every action; focus order follows reading order.
- [ ] Focus trapped in modals and restored on close.
- [ ] Real elements (`button`, `a href`, `label for`), not clickable divs.
- [ ] Targets are comfortable on touch (44px minimum is a floor, not a goal).
- [ ] Removing chrome removed no affordance.

### Effects and motion

- [ ] Every effect has a one-sentence job.
- [ ] One authored moment per surface.
- [ ] Page works with the canvas absent.
- [ ] `prefers-reduced-motion` yields a static, composed frame.
- [ ] One scroll owner.
- [ ] One WebGL context per page; DPR capped; loops pause off-screen and on hidden tabs.
- [ ] Disposed on unmount — check a route change, not just a reload.
- [ ] Text over an effect has a real scrim or backing.
- [ ] Nothing interactive lives only inside a canvas.

### Performance

- [ ] Critical path free of three, animation libraries, and shader packages — all lazy-loaded.
- [ ] One animation engine (`motion` **or** `framer-motion`, never both).
- [ ] One design system.
- [ ] Images sized and formatted; no oversized hero payload.
- [ ] No `filter` animation in a scroll-linked transform.

### Accessibility

- [ ] `alt` present and correct; decorative images `alt=""`.
- [ ] Form labels associated; errors announced, not just coloured.
- [ ] Semantic landmarks; headings in order.
- [ ] Works at 200% zoom.
- [ ] Motion preference respected; no autoplaying audio.

## Verification by medium

**Web.** Rendered page, loaded fonts, desktop and narrow mobile, full page and first viewport.
Exercise keyboard navigation, activation, and dismissal — a visible focus ring does not prove
the control works.

**Video / deck (via the owning skill).** Inspect a composed still first, then entrances,
transitions, settled frames, and exits. Check the final export at normal playback: dimensions,
duration, captions, audio, safe areas. A balanced hero frame does not prove moving content stays
clear of a caption band.

**PDF / print.** Inspect the export, not the source: font rendering, line breaks, clipped glyphs,
missing symbols, margins, page breaks, contrast at 300 dpi.

**Static asset.** Check at the size it will be seen, not at 100% zoom.

## What not to do

- Do not invent an "AI score" or promise a style is undetectable.
- Do not report problems you have not seen in the artifact.
- Do not loop. One batched pass, one fix round, one confirmation.
- Do not refuse to say what could not be verified. Name the limit — "preview unavailable, so the
  rendered output was not checked" — rather than implying validation happened.
