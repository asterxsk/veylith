# Direction

Settle direction before building. It is three dials, a mode, and a short list of refusals —
not a mood board, and not a second brainstorming phase.

## Read the brief, do not interview

Extract what is already decided: the audience, the job the surface does, the brand or
references named, the constraints (stack, accessibility target, deadline, existing tokens).
Everything the brief states is direction. Everything it omits falls to a dial.

Ask at most one question, and only when the answer changes what gets built. Turning an ordinary
build into a questionnaire is its own failure.

## The three dials

Set each 1–10, state it, and let it bound the rest of the work.

| Dial | Baseline | Low (1–3) | High (7–10) |
|---|---|---|---|
| **Variance** | 8 | Conventional, aligned, expected | Asymmetric, expressive, surprising structure |
| **Motion** | 6 | Static, transitions only | Movement carries the voice |
| **Density** | 4 | Generous, one idea per screen | Packed, many decisions per screen |

**Variance** governs layout. High variance means a grid that is deliberately broken — offset
columns, a hero with no centred headline, sections at different widths. Low variance means a
clean aligned system. Both are valid; a 3/3/3 luxury page and a 9/3/3 editorial page are
different products, not different quality levels.

**Motion** is the effect budget. It is the dial that decides whether the effect layer is in
play at all:

- Below 5, a scroll-driven 3D hero, a liquid logo, a smooth-scroll rewrite, and a shader
  background are all over budget. The answer is no.
- Above 5, "motion claimed, motion shown" — a page declaring high motion must actually move,
  and every animation must justify itself in one sentence (hierarchy, storytelling, feedback,
  or state transition).

**Density** governs how much earns screen space. High density is right for Operate surfaces and
data products; it is wrong for a Persuade page, where it reads as noise.

Density is not a reason to shrink type below 16px body on mobile or to compress leading.

## Mode

Mode names what success looks like for the visitor. It bounds what an effect may do.

| Mode | Visitor… | Effect budget | What wins |
|---|---|---|---|
| **Persuade** | decides and acts | High — one focal moment, fully authored | The argument and the call to action |
| **Experience** | is inside the work | Highest — the artifact leads, interface recedes | The work itself |
| **Read** | understands something | Near zero behind text | Structure and typographic rhythm |
| **Operate** | completes a task | None behind content | Speed, clarity, state feedback |

A page can hold two modes but not in the same viewport. A marketing hero over a product demo is
Persuade above and Operate below; the boundary is the point where the effect stops.

## The refusals

These are not style preferences. Each one is a pattern that reliably reads as generic,
unanchored, or actively harmful. Refuse them, and if one is genuinely required, say what
justification overrides it.

**Layout and chrome**

- **Glass and blur as decoration.** Legitimate when the chrome floats over content the user is
  looking at (a nav over a hero, a control cluster over a canvas, a modal over a live page).
  Decoration when a plain surface would read better. Test: name what is behind it and why the
  user benefits from seeing it.
- **Gradient text.** A gradient *behind* a heading is fine. Clipping the gradient to the glyphs
  is refused; emphasis comes from weight or size.
- **Repeated dividers, boxed sections, and label pills** that only announce "another block
  starts here." Use space and alignment.
- **Cards as the default container.** A card is for one repeated unit in a collection. A page
  built entirely from cards is a template.
- **Fake screenshots.** A browser mockup rendered from divs is not evidence of the product.
  Use a real screenshot or do not show it.

**Type**

- **Tracked uppercase monospace for labels** — eyebrows, kickers, table headers, captions,
  footers. This is the strongest single tell of generated design. See [labels.md](labels.md).
- **Custom mouse cursors**, unless the cursor genuinely carries information (a drawing tool, a
  viewport drag). A magnetic or trailing cursor is decoration with a performance cost.
- **Marquees and auto-scrolling tickers** more than once per page, and never for content the
  user has to read.

**Motion**

- **Autoplaying loops that never settle** — drifting blobs, perpetual float, infinite shimmer.
  Motion should arrive somewhere.
- **Habitual stagger on every word and element** on every page.
- **Decorative counters, glitches, and scroll-jacking.** A number that counts up proves nothing
  the number itself does not.
- **Layer multiple competing extraordinary moments.** One authored moment per surface; excess
  creates noise.

**Content**

- **Invented precision.** No fake metrics, fake testimonials, fake logo clouds, or made-up
  pricing.
- **Placeholder copy shipped as final.** Real content, or obvious placeholders the user replaces.

## What is never refused

The refusals above are about *patterns*, not about taste. These stay:

- **An expressive effect that explains the subject or carries the intended feeling.** A liquid
  metal mark on a brand page is not decoration if the brand is the point.
- **Dense, complex, technical surfaces** where the audience needs the detail — documented,
  legible, and structured.
- **Asymmetry, tension, and odd numbers** when they have an optical reason.
- **Deliberate roughness and imperfection** when the brief asks for warmth, craft, or character.

A cleanup request is not permission to flatten every lively design into a quiet template.

## Direction is not decoration

If direction and fundamentals conflict, fundamentals win and the direction is re-expressed.
A bold layout with broken hierarchy is not bold; it is unreadable.

The floor, always: readable body text, sufficient contrast, reachable controls, honest content.
No effect, palette, or reference purchase those back.
