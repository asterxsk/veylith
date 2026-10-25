# UI registries

Four shadcn registries that ship copy-paste versions of the surface treatments and motion
moments in this skill. They are the "do not hand-roll it" escape hatch — and they arrive with
their own animation loop, dependencies, and opinion about reduced motion, none of which satisfy
the contract until you check.

All four are **shadcn registry** libraries: they install into a project that already has shadcn
configured (`components.json`, Tailwind, a `cn()` helper) by writing source files into the
project. The component is yours to edit afterwards — which is the point, and also why nothing is
versioned for you.

| Registry | Reach for it for | Cost | Install |
|---|---|---|---|
| [Cult UI](https://www.cult-ui.com) | The closest overlap with this skill: distorted glass, liquid metal, shader blur, animated gradient and texture backgrounds | MIT; Pro blocks paid and excluded | `npx shadcn@latest add @cult-ui/<name>` |
| [Kokonut UI](https://kokonutui.com) | Small self-contained animated details rather than whole compositions: `particle-button`, `shimmer-text`, `liquid-glass-card`, `ai-prompt` | Free; Kokonut Pro paid and excluded | `npx shadcn@latest add @kokonutui/<name>` |
| [Skiper UI](https://skiper-ui.com) | One unusual interaction: dynamic island, token swap, View-Transition theme toggle, scroll marquee | Free tier **requires attribution**; Pro paid and excluded | `npx shadcn add @skiper-ui/skiperN` |
| [Watermelon UI](https://ui.watermelon.sh) | Breadth — the ordinary product surface around the one effect: 260+ components, blocks, dashboards | MIT, free | `npx shadcn@latest add "https://registry.watermelon.sh/r/<name>.json"` |

## Component map

| Need | Component | Skip building it when |
|---|---|---|
| Liquid glass | Cult `distorted-glass`; Kokonut `liquid-glass-card` | React + shadcn; a fixed panel is enough; no live DOM behind it |
| Liquid metal | Cult `hero-liquid-metal`, `metal-button` | The moment is a styled brand accent, not a bespoke shader on the user's logo |
| Shader blur / refraction | Cult `shader-lens-blur`, `morph-surface` | The blur is decorative; the effect does not track app state |
| Animated background | Cult `bg-animated-gradient`, `bg-animated-fractal-dot-grid`, `canvas-fractal-grid` | The background is not the page's one focal moment |
| Particles, shimmer, small details | Kokonut `particle-button`, `shimmer-text`, `ai-prompt` | The detail is a piece of a composition, not the composition |
| Scroll-reactive marquee or section | Skiper scroll components; Motion directly | Nothing else on the page owns scroll |
| Chrome and shell | Cult `dock`, `floating-panel`, `dynamic-island`, `side-panel` | The project's own design system already has these |

## Paid tiers are out of scope

Document free components only, and never trip a paywall.

- **Skiper Pro** needs a Polar membership, `SKIPER_LICENSE_KEY`, and an `Authorization` header in
  the registry config. Do not configure it, do not ask for a key, and do not use components
  marked premium. **The free tier requires attribution to Skiper UI** — surface that to the user
  rather than absorbing it.
- **Cult Pro** (`pro.cult-ui.com`) and **Kokonut Pro** (`kokonutui.pro`) are separate paid
  products. The open registries are MIT and free.
- If a user owns a licence and asks for a paid component, that is their call with their own key.
  It is not permission to enable one quietly.

## Stack fit

Cult and Kokonut are both React + Tailwind + **Motion**, so a project using both ships one
animation engine. Skiper leans on Motion *and* GSAP and is heavier. Watermelon is React 19 /
Tailwind v4 / Radix / Framer Motion.

Match what the project already has: `motion` and `framer-motion` are the same project under two
package names, and installing both ships it twice. Components targeting Tailwind v3 will need
reconciling on a v4 project.

Cult and Kokonut both expose an MCP path that is better than guessing component names:

```bash
npx shadcn@latest mcp init --client claude
```

## The contract still applies

A registry component is third-party source. Verify it rather than assuming:

- **Page works without it.** Usually fine; check anything full-bleed or viewport-taking.
- **GPU cost bounded.** `shader-lens-blur`, `canvas-fractal-grid`, `three-d-carousel` and
  friends allocate WebGL contexts and run their own loops. Check the DPR cap, whether the loop
  pauses off-screen, and the context count.
- **Reduced motion.** The weakest point of every one of these libraries — they animate by default
  and rarely check `prefers-reduced-motion`. For Motion-based components a single root
  `<MotionConfig reducedMotion="user">` covers them, partially, and never covers scroll-linked
  work. For the rest, wire it yourself.
- **Disposed on unmount.** Canvas, GSAP, and three components are the leaks. Motion handles its
  own listeners and is the safer half.
- **Scroll owner.** Cult and Kokonut only *read* scroll and compose fine with Lenis. Skiper's
  GSAP scroll components bind their own listeners and will fight a smooth-scroll library. Decide
  the owner first.
- **Legibility and focus.** Check what the component renders over its own effect, and check focus
  order in `dock`, `floating-panel`, and `dynamic-island`.

## Which to reach for

- An effect Cult already ships — **Cult**, do not hand-build it.
- One animated detail inside a larger composition — **Kokonut**. Same stack, so they mix.
- One distinctive interaction the brief names — **Skiper**, and check whether it is free.
- A whole product surface that needs to look finished around the effect — **Watermelon**.
- **Build it yourself** when the effect must react to app state, the project is not React with
  shadcn, nothing ships the specific thing, or bending a component costs more than writing it.
- Genuine 3D, real scroll physics, a designer-authored scene — **none of these**. See
  [three-d.md](three-d.md) and [motion.md](motion.md).

## Check terms before shipping

Tiers change, licences change, components get renamed or gated. Confirm three things on the
component you are actually installing: its licence, whether it is free or paid, and whether
attribution is required. If the answer is unclear, say so and offer an alternative rather than
shipping an assumption.
