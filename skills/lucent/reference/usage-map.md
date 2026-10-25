# Where each effect belongs

Pick by **job**, then confirm against **mode**. The mode comes from [direction.md](direction.md)
and governs how much effect a surface can carry.

| Mode | Effect budget |
|---|---|
| **Persuade** | High. Effects may carry the voice. One focal moment, fully authored |
| **Experience** | Highest. The artifact leads; the interface recedes |
| **Read** | Near zero behind text. Structure first |
| **Operate** | None behind content. Feedback, state, and continuity only |

## Placement

| Effect | Best placement | Also works | Wrong here |
|---|---|---|---|
| **react-three-fiber** | Hero 3D product or scene that continues into the page; scroll-driven storytelling; configurators | Section focal object, data-driven 3D, particle field | Behind body copy, inside cards, Operate screens, more than once per page |
| **Spline** | Hero 3D when a designer authored the scene | 3D section accent, interactive explainer | Dense-text pages, dashboards, 3D that must react to app state |
| **Motion** | Scroll-linked reveals, parallax, sticky-pinned sequences, layout and exit animation | Any React surface needing one scroll-driven moment; the safe pairing with Lenis | Simple hover and focus states (CSS), a project already on GSAP |
| **Lenis** | Whole-page scroll feel on Persuade/Experience surfaces | Portfolio, campaign microsites, pinned sequences | Operate dashboards, docs, long tables, search results, mobile-first sites |
| **ShaderGradient** | Hero background behind a headline; one feature band | Card header backdrop, empty state, 404, auth screens | Full-page behind scrolling text, repeated per section, behind data tables, more than one instance |
| **Liquid glass** | Floating chrome: header over content, control cluster over a canvas, modal or filter panel | Toast, tooltip chrome, media overlay controls | Static cards on static backgrounds, anything needing a contrast guarantee, glass on glass |
| **Liquid logo** | Intro reveal at load; footer wordmark; brand/About hero | Section divider wordmark, loading state | Nav bar, favicon, small sizes, any place the logo must stay legible |

## Settle the section before the effect

A hero, navbar, CTA, footer, or pricing page has a shape that exists independently of any effect.
Decide that shape first, or the effect is decorating an undecided container.
[design-galleries.md](design-galleries.md) is where to calibrate it — before choosing the effect,
not after.

## Check the pre-built version first

When the project is React with shadcn configured, several of these already exist as free
copy-paste components. See [ui-registries.md](ui-registries.md). A maintained component is
smaller than a scene you hand-build, and easier for the team to edit later.

That is not a substitute for the decision. A registry component still has to name its job, and it
is still subject to the contract — none of these libraries reliably honours `prefers-reduced-motion`
on its own, several allocate a WebGL context, and several bind scroll listeners that will fight a
smooth-scroll library.

## Glass, honestly

Before adding liquid glass, answer in one sentence: **what is behind it, and why does the user
benefit from seeing it?**

- Good: a nav over a hero image the user is looking at; a control cluster over a 3D viewport the
  user is manipulating; a filter panel over a product grid the user is browsing. The glass says
  "you are on top of this content, and the content is still there."
- Bad: "it looks modern"; "the card needed something"; "the reference site did it."

Bad answer → use a solid surface, a border, or a real shadow.

## Scroll, honestly

Lenis replaces native scrolling with a smoothed one. That trade is worth it only when the page is
*about* its scroll — a story in sequence, a pinned scene, a horizontal gallery. On a page where
the user is scanning to find something and leave, smoothing makes it feel slower and breaks
expectations. **When in doubt, do not smooth.** `prefers-reduced-motion` always wins.

Motion is not in that trade at all — it reads scroll rather than replacing it. See
[motion.md](motion.md).

## Choosing between the two 3D paths

Author-supplied scene → Spline. Code-driven, data-driven, or no scene at all → react-three-fiber.
Full table in [three-d.md](three-d.md).

## Where a gradient goes

ShaderGradient replaces one background. It does not become the page.

- **Persuade:** hero. Compose the gradient so the headline's area stays dark or light enough, and
  still add a scrim. One instance.
- **Read / Operate:** no. If a surface needs atmosphere, use a static surface from the palette.
- **Experience:** a single band behind the artifact, never competing with the work.

## The one-moment rule

One authored moment per surface. Not several effects stacked because several were available.
Focus creates impact; excess creates noise.

If a page already has a hero 3D scene, that is the moment. A liquid logo, an animated gradient,
and a glass nav on the same page are four claims competing for one attention span.

## The budget is a ceiling, not a target

A page at Motion 6 does not need six things moving. The dial says how much movement is
permissible; the answer to "should this animate" is still often no.
