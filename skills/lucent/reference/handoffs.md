# Handoffs

Lucent ships nothing but itself. When a brief needs a capability outside the interface layer,
name the skill that owns it, ask once, and install only on approval.

Nothing in this repository installs another skill. This is the protocol that replaces that.

## The protocol

1. **Detect.** Check whether the skill is already available — the agent's own skill catalog, or
   `npx skills list`.
2. **Ask once**, with the exact command and what it adds. Never install silently, and never
   install "to be helpful."
3. **On approval**, install that one skill:
   ```bash
   npx skills add <owner>/<repo> --skill <name> -g
   ```
   One skill, not a pack. Several of these repos publish a dozen skills; naming `--skill` is what
   keeps a scripted run off the interactive picker and off the whole catalog.
4. **Say if a restart is needed.** A skill installed mid-session is usually not invocable until
   the agent reloads. Offer the upstream docs URL as the interim path.
5. **If install is impossible** — no Node, offline, no approval — state the limit and continue
   with the narrowest fallback that needs no new dependency. Do not improvise the missing
   discipline.

Node 22.20+ is required by the skills CLI. If `npx` is missing or old, that is the first thing to
say, not a reason to skip the handoff silently.

## Hairline illustrations and diagrams

**`hairline-create`** — custom isometric line figures for website illustrations, SVG assets,
empty states, and conceptual diagrams. Premade figures are also available in the
[Hairline catalogue](https://hairline.lucasmarkes.com). Reuse one when it already says what the
page needs; create a new figure when the metaphor is specific to the brief.

Use an available skill directly. If it is missing and needed, follow the protocol above with:

```bash
npx skills add lucasmarkes/hairline --skill hairline-create -g
```

The [upstream skill](https://github.com/lucasmarkes/hairline/blob/main/skills/hairline-create/SKILL.md)
produces a self-contained HTML figure. For static SVG output, premade reuse, and website
integration, read [hairline.md](hairline.md). A static SVG adds no Hairline runtime to the site;
installing the authoring skill is separate from adding `@lucasmarkes/hairline` to a project.

**Why not bundled:** this is an optional illustration style and authoring workflow. Lucent
continues to own the website, handing over only the figure.

## The ArtCraft suite (office)

**`office`** — same repository. One app per artifact, all driven through one code-mode `exec`
call. This is the route for the actual office file and for creative media that is not an
interface.

```bash
npx skills add asterxsk/veylith --skill office -g
```

| The artifact | App |
|---|---|
| Document, letter, report, mail merge, citations | **WordCraft** |
| Spreadsheet, formulas, charts, pivot tables | **GridCraft** |
| Presentation deck | **DeckCraft** — see the deck question below |
| PDF reading, combining, splitting, forms, redaction, OCR, signing | **PdfCraft** |
| Photo editing: layers, masks, type, smart objects | **PhotoCraft**; raw files and photo library → **LightCraft** |
| Logo or illustration as a real vector file | **VectorCraft** |
| Audio recording, editing, mixing | **SoundCraft** |
| Video editing, sequences, colour, export | **FilmCraft** |
| Motion graphics, effects, keyframes, expressions | **EffectCraft** |
| AI image and video generation | **ArtCraft** |

**Excluded on purpose: FigCraft and DesignCraft.** Neither is used much here, and Figma or
Pen.dev do the same job better. Do not route an interface or page-layout brief to them.

**Ask before choosing the video tool.** When the brief is video — editing existing footage,
building a motion graphic, or creating a video from scratch — ask once: **`hyperframes`** for
HTML/CSS/JS rendered to MP4, or **FilmCraft/EffectCraft** for timeline editing and keyframes.
The answer changes the whole workflow, so it is the user's call, not an inference from file types.

**Ask before choosing the deck tool.** **DeckCraft** produces an editable `.pptx`. **`slideshow`**
(HyperFrames) produces a live, branching, or rendered deck. A deck the user will open in
PowerPoint is DeckCraft; a deck that presents itself is HyperFrames.

**Illustrations split by form.** **VectorCraft** when the deliverable is a vector file — a logo,
an `.ai`/`.svg` asset, something the user will keep editing. **`hairline-create`** when the job
is a website figure in that isometric line style. Lucent still owns placement, sizing, and the
surrounding layout.

**What Lucent still contributes:** the fundamentals and the label rule apply to a slide, a
document page, a poster, and a rendered frame exactly as they do to a page. **What it hands
over:** the artifact contract — native format, command API, export, and render verification.
That lives in `office`'s own loop; do not infer it from the web rules.

**Why not bundled:** the suite is thirteen native apps and an MCP server with system
dependencies. It is irrelevant to interface work and maintains its own skill.

## Video, motion graphics, and decks

**`hyperframes`** — HTML/CSS/JS → deterministic MP4. It is the router for the whole video
toolchain, and it owns its own authoring detail. When the user picked HyperFrames over
FilmCraft/EffectCraft (or the brief is code-authored motion), this is the skill.

```bash
npx skills add heygen-com/hyperframes --skill hyperframes -g
```

Prerequisites are hard requirements, not suggestions: **Node ≥ 22** and **FFmpeg on `PATH`**. A
missing FFmpeg fails at encode time, after the work is done. Run `npx hyperframes doctor` first.

| The brief | Skill |
|---|---|
| A video, motion graphic, or rendered explainer | `hyperframes` |
| A slide deck, presenter mode, fragment reveals | `slideshow` (HyperFrames) |
| A named transition, overlay, title, chart, or map block | `hyperframes-registry` — ~450 editable blocks |
| Music, SFX, voiceover, stock images, transcripts, colour grades | `media-use` |
| Scaffolding, previewing, rendering, publishing | `hyperframes-cli` |

What Lucent still contributes on a video brief: the **fundamentals** and the **label rule** apply
to a frame exactly as they do to a page. What it does not contribute is the video contract —
determinism, seekable animation, render cost, codec, LUFS audio levels, captions, and asset
licensing. That contract lives with HyperFrames; do not infer it from the web rules.

Two traps worth stating once:

- **HyperFrames is not `hyperframe`.** Singular `hyperframe` on PyPI is a Python HTTP/2 library.
  There is also a steel-framing company and a closed SaaS under the same name. Confirm
  `heygen-com/hyperframes`.
- **A rendered video is a published artifact.** Every track, font, and image must be licensed or
  original. Generated is not the same as cleared.

**Why not bundled:** it is a whole toolchain with system dependencies, irrelevant to interface
work, and it maintains its own skills.

## Data visualisation

**`dataviz`** — any chart, graph, plot, dashboard metric, stat tile, sparkline, or heatmap, in any
output medium.

| | |
|---|---|
| Install | Published through the standard skills catalog; install by its skill name |
| When | The brief involves a chart, a KPI row, a dashboard layout, or choosing chart colours |
| Why not bundled | It is a real discipline with its own palette method and validator, not a rule Lucent can restate in a paragraph |

What Lucent keeps: the chart's *container* — placement, hierarchy, and the surrounding layout.
What it hands over: the visualisation grammar itself — mark choice, scales, colour encoding, and
legend behaviour.

## Native mobile

| Platform | Skill | Note |
|---|---|---|
| **Android** | `android-native-dev`, `mobile-android-design` | Compose, Material 3. `android-cli` for tooling |
| **iOS** | none assumed | Use Lucent for direction and say that platform guidance is not covered here. Do not improvise HIG rules |

Lucent has no native-mobile effect layer. Compose motion, SwiftUI animation, and platform haptics
are different tools; Lucent's only contribution is shared timing vocabulary and the design
fundamentals.

## Finishing pass with poise

**`poise`** — same repository. When the design is done and the audit has passed, run `poise`
**as a subagent** before reporting the artifact finished. It is the final composure pass:
hierarchy, spacing, type, visual explanation, and the amount of competing detail.

```bash
npx skills add asterxsk/veylith --skill poise -g
```

Delegate it explicitly. The subagent needs, in the brief:

- **The artifact** — source path or preview URL, plus how to render it at real size.
- **The direction** — the three dials, mode, design system, and the feeling the brief asked for.
- **The scope** — a cleanup pass on the composed result, not a new direction, and not a rewrite
  of settled layout or copy.
- **The output** — the concrete edits plus a short list of what it changed and what it left alone.

Then review its changes, apply what holds the direction, and stop. One pass. Do not spawn a
second poise run to chase the first, and do not inline the pass in Lucent's own context — the
separation is what keeps the finishing pass from re-litigating decisions the audit already
settled.

**Why not bundled:** it is a separate discipline with its own medium references. It installs
alone, works alone, and Lucent still works without it; if it is missing, say so rather than
improvising a substitute.

## The optional design companions

Lucent is self-contained, and these are **not** required. Each is a genuine alternative or
addition for a specific case, and each installs on its own.

| Skill | Install | Use it when | Why Lucent does not bundle it |
|---|---|---|---|
| **poise** | `npx skills add asterxsk/veylith --skill poise -g` | The finishing pass after any design is done — run it as a subagent [above](#finishing-pass-with-poise) | Same repository, genuinely complementary. Separate install so each stands alone |
| **impeccable** | `npx skills add pbakaus/impeccable --skill impeccable -g` | The user wants a deeper art direction or a critique mode | Lucent's direction is deliberately light; a real art director is a different job |
| **design-taste-frontend** | `npx skills add Leonxlnx/taste-skill --skill design-taste-frontend -g` | Greenfield marketing page or portfolio, no committed world | Lucent carries the three dials and the refusals that matter; the rest is its arena |
| **web-design-guidelines** | `npx skills add vercel-labs/agent-skills --skill web-design-guidelines -g` | A formal interface audit of an existing codebase | Lucent's [audit.md](audit.md) carries the checklist; this fetches the current upstream version |

When one is installed and relevant, read it — do not paraphrase it from memory. When it is not,
[design-references.md](design-references.md) describes what each covers.

## When to hand off versus when to continue

Hand off when the **deliverable** is not an interface. Continue when the interface is the
deliverable and only a piece of it needs another discipline — a hero with a chart in it is still
an interface, with the chart handed over.

The test: **could Lucent finish the artifact without the other skill?** If yes, continue and hand
over the component. If no, hand over the artifact.

## What has no skill

Some things are genuinely uncovered. Say so plainly rather than stretching this skill to cover
them:

- iOS Human Interface Guidelines specifics
- Native Android effect and haptics work
- Audio mastering beyond what SoundCraft's mix and effects cover
- Print production beyond layout — bleeds, spot colours, imposed proofs
- Video work when neither `office` (FilmCraft/EffectCraft) nor `hyperframes` is installed

An agent that says "this is outside what I have" is more useful than one that improvises.
