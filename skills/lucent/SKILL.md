---
name: lucent
description: Use for any visual interface work - websites, landing pages, web apps, dashboards, component libraries, redesigns, or polish passes - to move from a vague brief to a finished, legible interface. Covers direction, design-system choice, layout, type, colour, states, motion, and the final audit, preferring what the project already ships over anything new.
---

# Lucent

Clarity and visual precision. This skill turns a vague requirement into an interface that is
easy to understand, pleasant to use, and built from the least it can be built from.

It is a **full design skill**: it owns direction, the substrate, the fundamentals, any effect
that earns a place, and the audit. It does not require another design skill to work.

It has one governing bias, and everything below follows from it: **maximise what is already
there rather than add what is not.** A dependency is a liability. A library the project already
uses is free. A platform feature is cheaper than a package that wraps it.

## The loop

Five steps, then a handoff. Each step can be skipped with a stated reason; none can be skipped
silently.

```
1  Read the brief             → direction.md
2  Choose the substrate       → design-systems.md
3  Settle the fundamentals    → fundamentals.md
4  Add an effect, or not      → usage-map.md
5  Audit once                 → audit.md
6  Hand off, if out of scope  → handoffs.md
```

**Before step 1, read `package.json`, `components.json`, and the stylesheet.** What the project
already has decides most of what follows. Recommending Tailwind to a project on CSS modules,
or Mantine to a project on shadcn, is the failure this skill exists to prevent.

## Step 1 — Direction

Three dials, set once, that bound every later decision. Full method and the refusal list in
[reference/direction.md](reference/direction.md).

| Dial | Range | Ask |
|---|---|---|
| **Variance** | 1–10 | How far from a conventional layout? Baseline 8 |
| **Motion** | 1–10 | How much movement is claimed? Baseline 6 |
| **Density** | 1–10 | How much on screen at once? Baseline 4 |

Also settle **mode**, because it bounds the effect budget:

| Mode | Visitor… | Effect budget |
|---|---|---|
| **Persuade** | decides and acts | High — one focal moment, fully authored |
| **Experience** | is inside the work | Highest — the artifact leads, interface recedes |
| **Read** | understands something | Near zero behind text |
| **Operate** | completes a task | None behind content — feedback and state only |

Direction is not a brainstorm. If the user gave a brand, a reference, or a constraint, that is
the direction. The dials exist to make an unstated direction explicit, not to override one.

## Step 2 — The substrate

One design system per project. Detect it before choosing it; never introduce a second.
Full matrix in [reference/design-systems.md](reference/design-systems.md).

| Already in `package.json` | Use it |
|---|---|
| `@heroui/*` | HeroUI — do not add shadcn |
| `components.json` + `cva` | shadcn/ui — add components via its CLI |
| `@mantine/*` | Mantine — use its modules, not a second kit |
| `@radix-ui/*` or `@base-ui/react` with no styled kit | Author on the primitives; keep it headless |
| `react-aria-components` | React Aria Components |
| `daisyui` | daisyUI — no JS layer, so behave |
| nothing | Pick by stack: see the decision tree |

The rule that matters: **a design system is a substrate, not a direction.** It supplies tokens,
components, and accessibility. It never supplies the design, and it is never shipped on its
stock theme.

## Step 3 — Fundamentals

Hierarchy, spacing, type, colour, states. These are not negotiable and no effect compensates
for them. See [reference/fundamentals.md](reference/fundamentals.md).

The short form:

- **One focal point per surface.** Remove what competes with it.
- **Spacing does the separating.** Not rules, not cards, not borders, not pills.
- **Hierarchy from size, weight, and space.** Not from capitals, tracking, or colour.
- **Small labels are serif italic, sentence case, untracked.** One rule, every medium —
  [reference/labels.md](reference/labels.md).
- **Every interactive thing has hover, focus, active, disabled, loading, empty, and error.**
- **Dark mode is a token swap, defined and tested.** Not an inversion filter.

## Step 4 — The effect layer

Read [reference/usage-map.md](reference/usage-map.md) first: it says which surfaces take an
effect and, more usefully, which do not.

Then the unconditional rule, before any effect:

> **Name its job in one sentence.** "The hero carries a scroll-driven product that resolves into
> the feature section." An effect with no sentence is decoration, and the answer is no.

Three technologies, each a rule sheet rather than a tutorial:

| Need | File |
|---|---|
| Motion, scroll-linked reveals, parallax, layout animation, smooth-scroll feel | [reference/motion.md](reference/motion.md) |
| Code-authored 3D, or a designer-supplied Spline scene | [reference/three-d.md](reference/three-d.md) |
| A surface treatment: glass, liquid mark, animated gradient background | [reference/surfaces.md](reference/surfaces.md) |

Check [reference/ui-registries.md](reference/ui-registries.md) before hand-building one —
several of these ship free as copy-paste components. Check
[reference/design-galleries.md](reference/design-galleries.md) when the section's shape is not
yet settled.

**Nothing beyond this is bundled.** Video, decks, print, and native mobile are handoffs — see
**Step 6**.

## The six web rules

Every browser effect obeys these. They are invariants, not suggestions.

1. **The page works without it.** Content, copy, controls, and navigation function with the
   canvas absent. Build and verify the static version first.
2. **GPU cost is bounded and measured.** Cap DPR at 1.5–2. Pause off-screen and on hidden tabs.
   Lazy-mount near the viewport. Below ~50fps on a mid-range phone, cut resolution, then
   counts, then the effect.
3. **Motion respects `prefers-reduced-motion`** with a static, composed frame — not a paused
   canvas showing nothing, not a continuing animation.
4. **Everything is unmounted and disposed.** A leaked renderer exhausts the browser's WebGL
   context limit and kills every canvas on the page.
5. **It is legible and keyboard-reachable.** Text over an effect gets a real contrast guarantee
   — a scrim, a wash, or a solid backing. Decorative canvas is `aria-hidden="true"`.
   Nothing interactive lives only inside a canvas.
6. **Scroll has exactly one owner.** Native, Lenis, or drei `ScrollControls` — one. Readers
   (Motion, `position: sticky`, `IntersectionObserver`, `ScrollTimeline`) are not owners and
   compose with anything.

## Step 5 — Audit

One batched pass, then stop. Full checklist in [reference/audit.md](reference/audit.md).

Verify in the real artifact at real size — a rendered page at desktop and mobile widths, not a
screenshot of a hero. Fix everything the pass finds in one round; do not loop until the diff is
empty. Then report what was built, what it cost, how it degrades, and what the user must supply.

## Step 6 — Hand off

Lucent covers the interface. When the brief is outside it, say so and name the skill that owns
it. Full protocol and command lines in [reference/handoffs.md](reference/handoffs.md).

| The brief is | Ask about |
|---|---|
| A video, motion graphic, or slide deck | `hyperframes` (decks: `slideshow`) |
| Music, SFX, voiceover, stock media | `media-use` |
| A chart, graph, dashboard metric, or data visualisation | `dataviz` |
| Android or iOS native screens | `android-native-dev`, `mobile-android-design` |
| A polish pass on any finished artifact | `poise` (this repo) |

The protocol, in one line: **detect, ask once with the exact command, install only on approval,
install one skill not a pack, and say if a restart is needed.** Never install silently.

## Resource discipline

The rules that make this skill the opposite of a bundle.

- **Detect before recommending.** `package.json` first, always.
- **Prefer the platform.** CSS transitions over animation libraries. Native scroll over smooth
  scroll. `prefers-reduced-motion` over a JS media query. `scroll-timeline` where it is
  supported. `view-transition` over a page-transition library.
- **One animation engine.** Motion **or** GSAP, never both. `motion` and `framer-motion` are
  the same project under old and new names — installing both ships it twice.
- **One design system.** Two kits means two token systems, two focus rings, two button APIs.
- **One scroll owner.** Two produces judder and a page that will not settle.
- **One 3D context per page.** Browsers cap live WebGL contexts at roughly 8–16.
- **Never install to satisfy a section.** If a whole library exists for one decorative element,
  the element is the problem.
- **Say the cost.** Bundle weight, render cost, or maintenance burden — in the report, in one
  line. A dependency that cannot state its cost has not earned itself.

## Report

State what was built, where, and what it cost. Name the design system and why it is the one
already present or the one chosen. Name each effect's job in the same sentence as the effect.
Say how it degrades and what the user must supply. If the surface carries labels, confirm they
follow [reference/labels.md](reference/labels.md) — serif italic, sentence case, untracked, not
tracked caps.
