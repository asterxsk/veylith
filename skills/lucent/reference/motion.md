# Motion and scroll

Two tools, one decision: **does anything need to own the scroll position?** Almost always no.

| Need | Use | Package |
|---|---|---|
| Anything that animates as a result of scroll — reveals, parallax, pinned sequences | **Motion** | `motion` |
| The page's *feel* while scrolling must be smoothed | **Lenis** | `lenis` |
| A hover, focus, fade, or state change | **CSS transitions** | none |

Both are MIT. Read this file before installing either; the answer is often "neither."

## Motion

[motion.dev](https://motion.dev) — the library formerly called Framer Motion. Import from
`motion/react` in React, `motion` for the vanilla `animate()` / `scroll()` API.

**Motion reads scroll; it never owns it.** `useScroll()` returns `scrollX`, `scrollY`,
`scrollXProgress`, `scrollYProgress`. Where supported it runs on the native `ScrollTimeline`;
`whileInView` uses a pooled `IntersectionObserver`. Nothing intercepts the wheel.

That single fact is why Motion is the default: it composes with Lenis, with `position: sticky`,
and with native scrolling, with no adapter.

The four entry points, because picking one is the difference between a small dependency and a
large one:

| Import | Use |
|---|---|
| `motion/react` | React. The normal import |
| `motion/react-m` | The lightweight `m` component, with `LazyMotion` |
| `motion` | Vanilla, non-React |
| `motion/mini` | Minimal core |

### Rules

- **Start visible, not hidden.** Server-render elements at their final state and let Motion set
  the initial state. An `opacity: 0` in the HTML that depends on JS to reveal it is an invisible
  page if the JS fails.
- **`reducedMotion="user"` on a root `<MotionConfig>`, explicitly.** The documented default has
  been `"never"`; do not depend on which default your version ships.
- **It does not do what its name suggests.** With reduced motion on, Motion disables *transform
  and layout* animations; `opacity` and `backgroundColor` keep running. Scroll-linked work is
  not covered at all — gate it with `useReducedMotion()` by hand.
- **No `filter` in a scroll transform.** `blur()` and friends repaint every frame over whatever
  they cover. This is in the docs' own examples and it is the fastest route to a janky page.
- **`whileInView` needs `once: true`** unless re-entry is genuinely the design.
- **Mutate refs, not state, per frame.** `useSpring` and scroll values evaluate every frame;
  spend that on a few elements.
- **`LazyMotion` + `m` before dropping the library or accepting its full weight.**
- **One engine.** `motion` and `framer-motion` are the same project under old and new names.
  Installing both ships the animation engine twice. Match whatever the project already has —
  several component registries still document `framer-motion`.

### When not to use it

A hover state, a fade, or a focus ring is a CSS transition. A page already committed to GSAP
with a team that knows it should not gain a second mental model.

## Lenis

[darkroomengineering/lenis](https://github.com/darkroomengineering/lenis) — interpolates the
native scroll position so the page eases instead of snapping. `position: sticky`, anchors,
find-in-page, and screen readers keep working, which is why it is the safe choice over the older
scroll-hijacking libraries.

```bash
npm i lenis
```

```js
import Lenis from 'lenis'
import 'lenis/dist/lenis.css'
const lenis = new Lenis({ autoRaf: true })
```

React: `ReactLenis root` from `lenis/react`, wrapping the document. `/lenis` has `root` mode;
nested containers only when one genuinely needs its own smoothing.

### Rules

- **One owner.** Native, Lenis, or drei `ScrollControls` — never two. Lenis plus
  `ScrollControls`, or Lenis plus StringTune's smooth mode, produces judder and doubled easing.
- **`respectReducedMotion` defaults to `true` and is correct.** Smoothing is disabled, `lerp`
  is forced to 1, programmatic scrolls jump. Leave it on.
- **Always `destroy()` on unmount.** Under React StrictMode effects run twice in development; a
  missing destroy leaves two RAF loops fighting.
- **`autoRaf: true` OR your own `requestAnimationFrame(raf)`.** Never both.
- **Nested scroll containers opt out:** `data-lenis-prevent` on modals, drawers, code blocks,
  horizontal galleries.
- **Drop CSS `scroll-behavior: smooth`** while Lenis is active.
- **Use `lenis.scrollTo()`, not `scrollIntoView()`** — the native call fights the smooth position.
- **`lerp` below ~0.08 feels unresponsive**, which is worse than no smoothing. Start at defaults.
- **`syncTouch: true` overrides native mobile momentum** and users notice. Leave it off.
- **Pairing with Motion is free** — `useScroll` reads window scroll, which Lenis drives. **Pairing
  with GSAP** needs the documented ticker wiring (`lenis.on('scroll', ScrollTrigger.update)`,
  `time * 1000`).

### When not to use it

Operate dashboards, documentation, long tables, search results, and mobile-first sites where
native momentum is already good. If the page's only scroll interaction is "read to the bottom,"
there is nothing to smooth. **When in doubt, do not smooth.**

## Scroll ownership

The rule that breaks pages most often. Exactly one thing may own scroll position:

| Owner | Use when |
|---|---|
| **Native** | Default. Most pages. |
| **Lenis** | The page needs smoothed scroll and nothing else owns it (`root` mode) |
| **drei `ScrollControls`** | A react-three-fiber scene *is* the page and needs a timeline. No Lenis there |

**Reads are not ownership.** Motion, CSS `position: sticky`, `IntersectionObserver`, and
`ScrollTimeline` read the position and compose with any owner. When two things seem to fight,
one of them is an owner you forgot about.

Never stack: Lenis + `ScrollControls`, or Lenis + StringTune's smooth mode.

## Cost

Motion's transform and opacity animations are compositor-friendly. Filters and scroll-linked
values evaluate per frame. Lenis costs one RAF loop plus whatever your listeners do — keep those
passive and cheap, and read values in a frame callback rather than in React state.

If the only requirement is a page that scrolls nicely, Lenis alone is smaller than Motion.
If the only requirement is a reveal on entry, CSS `@starting-style` or a transition is smaller
than both.
