# Faux product UI

A product shot is a miniature interface that reads as a real product: recognizable at a glance,
simplified to the one thing the viewer must see, framed with intent, and — when it moves — with
every motion caused. Use it for a hero illustration of an app, a feature card, a bento tile, a
docs figure, a comparison of two products, or a short demo animation with a cursor.

It is authored markup, not a screenshot: the screen is built so the story can be staged, the crop
chosen, and the type sized for the slot it lands in. A screenshot scaled into a card is the thing
this reference exists to prevent.

## The five failures

| Failure | What it looks like | Fix |
|---|---|---|
| **Too much** | Real text in every row, numbers everywhere, nothing left out | A word budget; bars for the rest |
| **Wireframe** | Two gray blobs and a button; built too small, stripped of what made it recognizable | Keep the product's chrome, signature content, and real words on the subject |
| **Boxed** | A whole window shrunk into a card with even margins | Crop it; see below |
| **Flat** | Every object the same weight in the same bordered card | One hero, one or two satellites, depth from shadow and z-order |
| **Bland** | A gray window with a cursor, whatever the brief asked for | Build the brief's look and energy; simplify the words, not the context |

## The ground and the crop

The framing decides whether it reads as a product shot or a screenshot in a box. Decide it before
building the screen: a crop needs nothing past the crop, and it sets how big the type must be.

- **One hero object, at most one or two satellites** (a receipt, a phone, a detail card) carrying
  the point. Two satellites are two kinds, not a pile of two cards on one edge.
- **The page is the ground.** On a white or dark page there is no plate behind the window and no
  panel behind the device. A whole window centered with air on four sides floats; that is the
  fault, not a neutral default.
- **Bleed it.** The hero fills at least two thirds of the stage and runs off at least one edge,
  cropped 10 to 40%. A card or tile: inset at the top and sides, 15 to 35% past the bottom.
- **One gutter,** measured in the final crop after any wrapper, and every other edge distance
  matches it. Either a full gutter or well past the edge; crossing by under 24px or stopping a few
  pixels short is a mistake.
- **Crop only filler.** The payoff, the action, what the cursor touches, and every real word stay
  whole. A list, diff or terminal may run one line off a bled edge. A button, chip, or shadow
  sliced by the stage edge is the usual fault; remove a placeholder action rather than slice it.
- **Mask at the stage** (`overflow: hidden`), one rounded corner per edge. Fades are for one crop
  — a window fading out at its foot over filler — never a side and never the focal content.
- **Satellites straddle the hero's edge,** about half outside; where they land on the hero, put
  them over its chrome or margin, never over content. A satellite arrives at the beat it pays off,
  or is present from the first frame in a reserved column.
- **What the story opens stays in frame,** a gutter from every edge on every frame.
- **No dead corners,** at rest or anywhere in the loop. Fix crop or layout first.
- **Start flat and frontal.** Earn a tilt by comparing with the straight version at final size;
  depth from shadow, z-order, scale, and opacity. Perspective only when asked.
- **`compact` is a second design, not a squeeze.** Below the host width where the wide scene stops
  fitting, crop closer, drop or stack a satellite, keep action and payoff whole. A 400px card
  holds a third of a dashboard at full size, not all of it at a third.

## Restraint

- **Count the real strings:** title, the thing acted on, what is typed, the result — usually 3 to
  7. The rest is a placeholder bar.
- **A word budget is not an element budget.** A calendar needs a populated week, a search a
  collection, a list enough rows. Never an empty pane with a void under it.
- **Bars are filler; the subject is words.** Bars where the eye lands read unfinished. In a
  still, the subject is real words and values; a sidebar of bars beside it is fine.
- **Fill the panes.** Rows at their own pitch (12px padding, 8px dense), never spread to hide a
  void, never a one-line row three times taller than its words.
- **Label and value match:** both words or both bars. A blank pill beside a real control is dead.
- **Keep the domain's signature content** — album art, thumbnails, avatars, real chrome. Swapped
  for the feature's signal it becomes a generic list.
- **Named avatars take their own color;** gray discs are filler only.
- **One number gets to be big;** the rest are lines. A stat's unit never wraps to its own line.
- **Say it once.** One clear signal for the feature, not the same idea in header, satellite, and
  every row.
- **No masthead for a fictional name.** A wordmark, logo, sidebar and nav in every crop is
  furniture; crop around the story.
- **Compose objects, not an inventory of cards.** Hierarchy from proportion, space, material, and
  ground, not more boxes. The heaviest marks sit on what the story is about.
- **A specimen still describes one plausible app:** title, toolbar, navigation, and body agree.

## Type, spacing, colour

- **Real sizes, then scale:** 11 to 15px UI text, scaled by the stage. Never 7px type; nothing
  under 10px on a phone. Line height at least 1.3 for small text.
- **One family:** the product's, or the system stack. Monospace only for code, identifiers and
  aligned numbers.
- **Sentence case** unless the real product has caps. Hierarchy from spacing and one weight step,
  not capitals, tracking, or colour.
- **No real headings.** A faux app's title is a `div`, never `h1`–`h6`; the demo lives inside
  someone's page outline.
- **Words keep a 12px inset** from any window, card, panel, or hovered-row edge. Bars may bleed;
  words do not. Carry the inset round the bottom.
- **Text never touches a neighboring box:** a fixed 8 to 12px gap, never leftover `space-between`.
  No near-tangents: 1 to 3px apart reads as an accident.
- **Dots, badges, halos and focus rings** sit fully inside the content edge, 6px clear, in the
  gutter or on the avatar — never on the words.
- **Center on the visible ink.** A label centered on its line box reads low; center a money amount
  on its digits with the currency sign hanging outside the centering box.
- **Columns line up:** one grid template with fixed tracks; optional content keeps its track empty.
- **Five inks and one accent** to start; status colours mean status. One neutral family for
  window, sidebar, and cards. No redundant tonal borders — try the fill alone.
- **The hero is not outlined to point at it.** An accent ring with a halo reads as a focus state
  nobody gave it. Lift it the way the product would: its surface, its shadow, a label in the
  accent.
- **On dark, depth comes from a lighter surface,** not shadow. **Nothing translucent overlaps;**
  stacked cards and chips take opaque fills.
- **A light pass does not prove dark.** Render every look the brief names.

## Icons, logos, chrome

- **Icons come from a set, never from your hand.** The product's own pack first (its dependencies,
  icons folder, sprite, or `Icon` component); otherwise one set chosen on purpose — Phosphor,
  Iconoir, Radix, Tabler, Heroicons, Lucide deliberately rather than reflexively. One family, one
  stroke weight, one size (14 to 16px) per scene. At 14px and under, use filled.
- **No hand-drawn marks** — pin, cursor, badge, ringed dot, chip, contactless arcs — unless they
  come from the product's own assets.
- **Emoji are content, never icons.** A playful look rounds the icons; it does not swap them.
- **No invented logo.** A letter or glyph in a coloured square is not a mark. Use the real mark in
  its own proportions and colours, or a plain text wordmark.
- **AI features get no sparkle, wand, or star, and no purple as the AI colour.** Show what the AI
  does. The product's own icon is fine even when it is a sparkle; a sparkle as generic AI
  decoration is not.
- **Never draw platform chrome from memory.** Open the real app or a screenshot first. Browser
  chrome only when the browser is part of the picture; a desktop app gets its real chrome.
- **A status bar, home indicator, keyboard, or window frame comes from the host platform's
  geometry,** not from a hand-built approximation. A cropped phone loses its status bar and nav
  bar together, and nothing sits under the Dynamic Island.
- **Phones may straddle a window but never cover the amount the story explains.**

## Motion

- **Three to five beats building to a payoff,** 10 to 16 seconds. One gesture and its response can
  be enough; add a beat only when it clarifies. Film six seconds of filler and it is a long hold.
- **A hero loop resets with a visible cause** — an undo with its keycaps, a close, an exit around
  an anchor — or resets while hidden. **Data never rewinds in view.** No dead air at the seam:
  within about a second of the exit ending, the next action has begun.
- **Set the poster first.** Most people see one frame: a thumbnail, reduced motion, a screenshot.
  Choose the beat that tells the story on its own, never one caught mid-change, and leave the
  result on screen rather than tidying it away.
- **Nothing pops.** Everything has an entrance and stays mounted until its exit finishes; a solid
  thing arrives by moving, opaque, not fading up half-transparent. Content arrives after its
  container.
- **Change only what changed.** A resizing surface moves size, position, and content as one
  transition and never stretches its text. Numbers roll digit-first, unchanged digits still.
- **Unhurried, on two curves:** travel `cubic-bezier(0.45, 0, 0.1, 1)`; arrival from nowhere
  `cubic-bezier(0.25, 0.8, 0.25, 1)` over 0.8–1s. Overlap related responses; stagger groups in
  reading order 40 to 80ms apart. UI feedback stays as quick as the real product — only
  storytelling motion slows.
- **The cursor has a kind, set by the element** (`ibeam`, `hand`, `open`, `crosshair`, resize on
  an edge or corner), and it changes mid-path as it crosses the edge, never after arriving. The
  arrow stays for native buttons; `wait` only where nothing implies it.
- **No cursor means no stand-in.** Never walk a focus ring or spotlight between controls.
- **The cursor never covers the words it clicks.** Aim inside the target but off its text; rest on
  empty surface between beats, near its next move, never on an unused control.
- **A pointer drag is one motion;** a finger's flick is a short drag then a throw, and it reads as
  two motions under an arrow. **A text selection stays under the I-beam every frame.**
- **The camera needs a reason.** Push in only when the payoff would be too small to read at the
  shown size, once per story, in and back out. The wide shot must already be a good still.
- **A comparison pair shows a different demo** from the one above it.

## Verify

Look at frames, not at the code. Fix the largest visible fault first — framing, then hierarchy,
then motion, then polish — and re-shoot.

- Frame it at both widths the page will show, and beside the best comparable product shot: is
  yours the emptier, flatter, or more boxed one? That is the first fix.
- Is anything cut by the crop that has words on it, or that the eye needs whole?
- Is a corner empty for no reason, a pane void under its content, rows spread to hide it?
- Does the eye land on the result first? Is there one window or device clearly leading?
- Dark and light both rendered? Real words on the subject, bars beside it only?
- Step through the loop at 40 to 80ms: every press, menu, morph, exit, and the seam. Anything
  appear without an entrance, or stay without an exit?

## The full kit

These rules are the durable part and work by hand. The authored kit — `Stage`, `Window`, `Phone`,
`Thread`, `Cursor`, `Collapse`, `Roll`, `Fly`, `Count`, and the gold examples — belongs to
**`stageshow`** and is an optional install, not a dependency:

```bash
npx skills add benjitaylor/skills --skill stageshow -g
```

It is MIT licensed (Benji Taylor), React plus plain CSS. Copy `kit/` into the project and import
from `kit/index.ts`; copy the closest example rather than rewriting one from a glance. Ask before
installing, per [handoffs.md](handoffs.md). If it is not installed, build the markup directly and
keep these rules — the framing and restraint discipline is what the result depends on.
