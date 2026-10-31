# Mediums

Read this first. It answers the question that precedes every other one: **what is being made?**

The medium decides which references are relevant and which obligations apply. A page lives
indefinitely and costs per-frame GPU work while a visitor watches; a video is a fixed grid of
frames rendered once. **A technology moving between mediums does not carry its contract with it.**

## Routing table

| Medium | Stack | Primary reference | Defer to |
|---|---|---|---|
| **Website or web UI** | Next/Remix/Astro/Vite + React | [design-systems.md](design-systems.md) → [fundamentals.md](fundamentals.md) → [usage-map.md](usage-map.md) | — |
| **Web, non-React** | Plain HTML/CSS/JS, Vue, Svelte, Rails | Same; daisyUI or authored CSS; vanilla paths in [motion.md](motion.md) and [surfaces.md](surfaces.md) | — |
| **3D scene** | react-three-fiber or Spline | [three-d.md](three-d.md) | — |
| **Video or motion graphic** | HTML → MP4 | — | `hyperframes` — see [handoffs.md](handoffs.md) |
| **Slide deck** | Presentation | — | `slideshow` (HyperFrames) — see [handoffs.md](handoffs.md) |
| **Chart, graph, dashboard metric** | Any | — | `dataviz` — see [handoffs.md](handoffs.md) |
| **PDF, poster, print** | Vector or raster | [fundamentals.md](fundamentals.md), [labels.md](labels.md) | `poise` for the cleanup pass, as a subagent |
| **Android app screen** | Jetpack Compose, Material 3 | — | `android-native-dev`, `mobile-android-design` |
| **iOS app screen** | SwiftUI, HIG | — | No skill assumed. Say the platform guidance is not covered rather than improvising |
| **A polish pass after the design is done** | Any | — | `poise` (this repository) — delegate it to a subagent, see [handoffs.md](handoffs.md#finishing-pass-with-poise) |

## Stand down when out of scope

Lucent owns the interface. If the request is a slide deck's argument, an Android app's
information architecture, an iOS onboarding flow, or a rendered video, the work belongs to
another skill — say so and hand off rather than stretching an interface rule to cover it.

**A broad trigger is not a broad claim.** Being wrong about what this skill can do is worse than
not being invoked.

## What carries across every medium

Two things, and only two:

- The **label rule** — [labels.md](labels.md): serif italic, sentence case, untracked. Web, deck,
  PDF, video caption, SVG.
- The **fundamentals** — hierarchy, spacing, type, contrast, states. Different tools, same
  obligations.

Everything else is medium-specific: a video contract is determinism, render cost, codec, audio
levels, captions, and asset licensing; a web contract is per-frame cost, reduced motion,
scroll ownership, and disposal. Do not mix them. Carrying "pause off-screen" into a composition
is cargo-culting; carrying "renders identically every pass" back onto a page is meaningless.

## How the mediums actually differ

| | Web | Video / deck |
|---|---|---|
| **Lifetime** | Infinite; a page can run for hours | Fixed; a known frame count, rendered once |
| **Cost driver** | Per-frame GPU work, while a visitor watches | Total render time, before anyone watches |
| **Motion source** | Often the visitor — scroll, pointer, hover | Always authored; nobody scrolls a video |
| **Failure mode** | Jank, leaked contexts, scroll fights | Non-determinism, missing encoder, unreadable text |
| **Accessibility** | Contrast, focus, keyboard, reduced motion | Captions, hold duration, audio description |
| **Reduced motion** | A real requirement — a static composed frame | Not applicable in the same way |

## Static brand assets

A logo, a poster frame, an OG image, a one-page SVG. Treated as **print**: the fundamentals and
the label rule apply, effects only if the artifact is animated (SVG/CSS) — and then the web
contract's reduced-motion obligation applies too.

Surface treatments for a static mark are in [surfaces.md](surfaces.md), but a still asset has no
fallback problem and no scroll owner, so only the asset rules matter.
