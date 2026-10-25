# Surface treatments

Three effects that change what a surface *looks like* rather than what moves on it. They share
one contract and one failure mode: all three cost a GPU pass, all three destroy contrast, and
all three are decoration unless the brief says otherwise.

Check [ui-registries.md](ui-registries.md) first — all three ship as free copy-paste components.

## Liquid glass

A refractive panel: what sits behind it is bent, tinted, and given an edge highlight. Usually
chrome floating over content — a nav bar, a control cluster over a canvas, a modal.

| Repo | Package | Stack | Reach for it when |
|---|---|---|---|
| `rdev/liquid-glass-react` | `liquid-glass-react` | React | React site. **Chromium only** for refraction |
| `ybouane/liquidglass` | `@ybouane/liquidglass` | Vanilla TS | Non-React, or refraction that must work everywhere |
| `naughtyduk/liquidGL` | `liquid-gl` | Vanilla | Live video behind the glass; WebGPU→WebGL→CSS chain |
| `shuding/liquid-glass` | none, copy-paste | Vanilla | A one-off snippet, no build step |

`liquid-glass-react` generates a displacement map and applies it through
`backdrop-filter: url(#filter)`, which is **effectively Chromium-only**. Safari and Firefox
silently drop the refraction and render a flat blur. If refraction must appear everywhere, use a
WebGL implementation.

### Rules

- **Earn it.** Answer in one sentence: what is behind it, and why does the user benefit from
  seeing it? Good: a nav over a hero image the user is looking at; a control cluster over a 3D
  viewport; a filter panel over a product grid. Bad: "it looks modern"; "the card needed
  something"; "the reference did it." Use a solid surface, a border, or a real shadow instead.
- **One layer.** Glass on glass compounds cost and usually looks wrong.
- **Stacking contexts break it silently.** `filter`, `transform`, `opacity < 1`, and
  `will-change` each create one; an ancestor filter can isolate the backdrop so the glass samples
  nothing. When it renders as plain blur or nothing, check the ancestor chain first.
- **Contrast is not guaranteed.** Put a scrim between the glass and any text, and check against
  the *busiest* thing that can pass behind it. Keep body copy off the glass; glass carries
  chrome, labels, and controls.
- **One or two per page.** Every glass element forces a backdrop repaint on scroll.
- **Animate the wrapper, not the filter** — regenerating a displacement map per frame is
  expensive.
- **`overLight`** (light-background tint inversion) is the prop people miss; without it the glass
  disappears on a light surface.
- **Cursor-tracking glass is refused** as decoration (see [direction.md](direction.md)); if it
  tracks, it must stop under reduced motion and be disabled on touch.
- **Cleanup:** `destroy()` on unmount. WebGL implementations hold a context.
- **SSR:** client-only load; the server output is the solid fallback.

## Liquid logo

A logo rendered as liquid metal — flowing metallic stripes, chromatic fringing, a soft bevel. It
is a rendering of the mark, not a filter on it.

The practical path is `@paper-design/shaders-react`'s `<LiquidMetal>`; the
`paper-design/liquid-logo` repo is a Next.js app, not a library. Vanilla has no published
package — vendor the shader from the app or use `collidingScopes/liquid-logo`.

### Rules

- **The asset decides whether it works.** SVG or transparent PNG, with explicit `width` and
  `height` (an SVG without intrinsic dimensions reports `naturalWidth = 0`). The mark must work
  as a **mask**: white and transparent are outside, everything else is inside. Two-colour marks
  work; photographs and gradient-heavy marks degrade badly. **Ask for the logo file; do not
  substitute a placeholder.**
- **Cross-origin logos need CORS** (`crossOrigin = 'anonymous'` plus the header), or
  `getImageData` throws and kills the entire effect.
- **Processing takes hundreds of milliseconds** — mask, boundary detection, Poisson solve. Never
  on the critical path.
- **Freeze it for reduced motion:** `speed = 0`. The tool has no reduced-motion branch and its
  RAF loop always runs.
- **Pause off-screen.** The tool has no `IntersectionObserver` and no `visibilitychange` pause.
  Add both.
- **Cap DPR at 1.5–2** via `minPixelRatio` / `maxPixelCount`; its native canvas is square at
  1000×DPR, which is heavy on a 3× phone.
- **Large only.** Hero, footer wordmark, brand page, intro reveal. Never nav, never favicon — the
  stripes and dispersion destroy small-size legibility.
- **One per page.** Two liquid marks dilute both and the second reads as a gimmick.
- **No mouse interaction** in the paper-design shader — animation is time and speed only. Do not
  promise hover displacement with it.
- **Fallback:** the plain logo as an `<img alt="…">` in the server HTML; the canvas renders over
  it. That covers first paint, screen readers, and no-WebGL at once.

## Animated gradient background

`@shadergradient/react` — one canvas, three colours, a light, a camera. Replaces **one**
background; it does not become the page.

The playground URL *is* the handoff artifact: design it at shadergradient.co and pass the
customize URL with `control="query"`, or hand-transcribe its parameters. There is no "copy JSX"
button. There is no vanilla build and no official iframe embed — on plain HTML, port the shader
or do not use it.

### Rules

- **One instance per page, and not on every section.** Two gradients means two contexts, two
  render loops, and a background nobody looks at twice.
- **`pointerEvents="none"`** on a decorative background. The React package leaves it undefined,
  so the canvas swallows touch scroll otherwise.
- **`lazyLoad` is on by default — keep it.** It mounts near the viewport and disposes off-screen.
- **`grain='off'` unless the halftone is the look.** It is on by default and mounts a full
  post-processing pass every frame.
- **`lightType='3d'` unless you need the HDR.** `env` loads an HDRI plus PMREM cost.
- **Parameter asymmetry:** `brightness` only affects `lightType='3d'`; `reflection` and
  `envPreset` only affect `env`; `cDistance` is plane/waterPlane only; `cameraZoom` is sphere
  only. Tuning the wrong one looks like a broken prop.
- **It renders continuously** — there is no `frameloop="demand"`. `animate='off'` freezes the
  shader's motion but the R3F loop still runs; unmount to truly idle.
- **Reduced motion is not handled** in the React package. `animate={reducedMotion ? 'off' : 'on'}`.
- **Fallback:** a static CSS gradient using the same three colours in the server HTML, canvas
  mounted over it. That is what a visitor sees when WebGL is slow or blocked.
- **Text contrast:** compose the gradient so the headline's region stays dark or light enough,
  and **still add a scrim**. Never put body copy over a full-bleed animated gradient and hope.
- **Natural home:** one hero, one section band. Not behind data tables, not per section, not on
  Read or Operate surfaces.

## Shared contract

All three obey the six web rules in the SKILL. The ones that bite hardest here:

- **Fallback ships in the server HTML** — a solid surface with a real border and shadow for
  glass, the plain `<img>` for a logo, a static CSS gradient for a gradient.
- **Resolved height.** A glass panel with auto height around absolute children collapses; a
  canvas in a flex child with no height is 0×0.
- **DPR capped, off-screen paused, hidden-tab paused.** None of these libraries do all three.
- **Contrast checked against the busiest background**, with a scrim between the effect and the
  text.
- **Disposed on unmount.** Each holds a context, a texture, or a canvas.

## When to skip all three

The cheapest surface is usually the right one. If the brief does not name a moment, and the
page's job is to be read or to be operated, a flat surface with a good palette beats a GPU pass
every time.
