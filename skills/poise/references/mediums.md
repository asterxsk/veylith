# Inspect the medium the audience receives

Read the section relevant to the artifact. Use available specialist skills and the project's existing workflow for authoring and rendering. This reference supplies design checks, not tool installation instructions.

## Websites and interfaces

- Inspect the real page with loaded fonts and assets at desktop and narrow mobile sizes. Check the full page as well as the initial viewport. Cleanup that improves the hero but makes the rest denser has not solved the problem.
- Check spacing around fixed headers, viewport-height sections, cards with unequal content, wrapped headings, and footers. Equal CSS padding can still produce unequal visible breathing room.
- Consolidate repeated label, border, and spacing styles through the existing tokens or component system where practical. Avoid a pile of one-off overrides that breaks sibling views.
- Use SVGs with a sensible viewBox and consistent visual weight. Check small-size legibility. Meaningful icons need a text equivalent; purely decorative ones should not add screen-reader noise. Maintain labels for ambiguous controls.
- Verify keyboard focus, hover and pressed states, meaningful boundaries, contrast, and usable targets after removing chrome. When controls change, exercise keyboard navigation, activation, and dismissal; visible focus alone does not prove they work. Do not turn links into indistinguishable body text or inputs into unexplained blank space.
- Review motion in use, including its settled state and any reduced-motion alternative. Follow the effect owner's performance and accessibility contract. No new effect is necessary to make a page feel finished.

## PDFs, posters, and decks

- Establish the page or slide size and intended reading distance. Check the whole composition, normal reading scale, and fine detail separately. A beautiful zoomed-in crop can conceal an unreadable poster.
- Inspect the final export. Check actual font rendering, line breaks, clipped glyphs, missing symbols, margins, page breaks, and graphic placement. Source coordinates and automated overlap checks alone are insufficient.
- Balance the visible top and bottom content bounds. Account for running headers, sources, footnotes, page numbers, and any required print margins. Keep sources readable and attached to the relevant claims.
- Let one main visual explain the central idea. Supporting comparisons should remain subordinate. Enlarge or simplify dense diagrams rather than reducing all labels until the figure fits.
- Prune code to the essential idea only when rewriting is authorized. A short, readable conceptual example often teaches more than a tiny hardware-specific listing; label the simplification and preserve the underlying sequence.
- Use editable vector forms for icons and diagrams when the workflow supports them. Check contrast and strokes in the actual export; delicate hairlines and pale labels can disappear on paper.
- For multi-page documents and decks, inspect changed pages and adjacent transitions for rhythm and content flow. Do not standardize every page into identical cards if the argument calls for variety.

## Video and motion graphics, including HyperFrames

- Identify the viewing aspect ratio, expected screen size, duration, captions, and audio. Judge the opening, explanation, payoff, and ending as a sequence.
- Inspect a composed still before embellishing it. Then inspect entrances, transitions, settled frames, and exits. A balanced hero frame does not prove that moving content stays clear of captions or safe areas.
- Use motion to explain relationships and control attention: a request follows the path, a selected element changes state, a mechanism resolves. Avoid adding motion to every decorative part just because it can move.
- Hold meaningful text long enough to read at normal playback speed. Estimate reading time if useful, then watch it. Do not assume one fixed hold duration suits every caption, diagram, or audience.
- Give the viewer pauses. Prevent overlapping entrances, competing loops, premature exits, and constant camera drift from making a simple idea feel frantic.
- Use clean, legible shapes. Remove unnecessary tiny ticks, serial numbers, fake readouts, and chart decorations. Preserve legitimate labels, quantities, and narrative context.
- Check upper and lower breathing room with captions present. Avoid content that hugs the top while the lower half is empty, or moves into a caption band during a transition.
- If audio exists, check that voice remains intelligible and cues support the picture. Do not add music or sound merely to fill a quiet beat. Recheck sync when timing changes.
- For HyperFrames, use its available authoring/render workflow and determinism contract. Keep animation tied to the composition's timeline; do not introduce wall-clock randomness or live browser-only behavior while polishing.
- Review a representative preview before an expensive render, then verify the requested final export's dimensions, duration, completeness, and playback. Frame snapshots alone do not establish readable timing or clean audio. A request for a finished video requires the finished video, not just a source edit.

## Other visual artifacts

Apply the same hierarchy, spacing, typography, and clarity checks using the artifact's native workflow. Preserve its constraints and the user's reference. If the medium is unfamiliar, identify the tooling or verification limit rather than assuming web CSS or a static screenshot proves the result.
