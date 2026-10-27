---
name: office
description: "Do creative and document work in the ArtCraft app suite - WordCraft documents, DeckCraft presentations, GridCraft spreadsheets, PdfCraft PDFs, PhotoCraft images, VectorCraft vectors, FilmCraft video, EffectCraft motion graphics, SoundCraft audio, CADCraft, DesignCraft, FigCraft, LightCraft, and the ArtCraft studio. Use for making, editing, converting, rendering, or exporting real files (.docx, .pptx, .xlsx, .pdf, .psd, .ai, .mp4, .svg, .wav). Drives every app through one code-mode call and asks before installing an app or an MCP server that is missing. Not for code, websites, or interface implementation."
---

# Office

The ArtCraft suite is thirteen native Rust apps with the same contract: every ribbon button,
dialog and tool is a command, and every app speaks MCP. This skill drives all of them through
one door, picks the right app for the artifact, and installs nothing without asking.

## One door: code mode

Every Craft app exposes its own MCP server. Seven of them together are more than 300 tools — PdfCraft
alone has 179. Loading that into context to write one document is wasteful, and the schemas are the
least interesting part of the job.

Code mode is a single MCP server that takes one `exec` call containing JavaScript, discovers the
upstream tools inside that call, and returns only what you asked for. One call can search three
apps, build a deck, render a slide, and hand back the image. The model never holds 300 schemas.

Some harnesses ship this natively. Claude Code does not, so on this machine it is installed as one
stdio MCP server — `@tmustier/code-mode-mcp` — and every Craft app is registered as one of its
upstreams instead of as a top-level MCP server of its own. That is the better arrangement, not a
workaround: the suite costs one tool in context rather than several dozen, and the app schemas stay
out of the way until a call needs them.

**Say it plainly when you install it.** The user is entitled to know: "I'm adding code-mode, one
MCP server that composes every Craft app. It is more efficient than loading all of their tool
schemas — one call instead of dozens, and only the result comes back." Then install it, once.

Read [reference/codemode.md](reference/codemode.md) for the `exec` runtime and the call patterns.
Read [reference/setup.md](reference/setup.md) before installing or registering anything.

## The suite

| App | Makes | Native file |
|---|---|---|
| **WordCraft** | Documents, letters, reports, mail merge, citations | `.docx` |
| **DeckCraft** | Presentations and slide decks | `.deckcraft`, `.pptx` |
| **GridCraft** | Spreadsheets, formulas, charts, pivot tables | `.xlsx` |
| **PdfCraft** | PDF reading, combining, splitting, forms, redaction, OCR, signing | `.pdf` |
| **PhotoCraft** | Image editing: layers, masks, type, smart objects | `.pcraft`, `.psd` |
| **VectorCraft** | Vector illustration and logos | `.ai`, `.svg` |
| **FilmCraft** | Video editing, sequences, colour, export | project + `.mp4` and friends |
| **EffectCraft** | Motion graphics, effects, keyframes, expressions | `.ecproj` |
| **SoundCraft** | Audio recording, editing, mixing | `.scraft` |
| **DesignCraft** | Page layout and publishing, print-ready | `.designcraft` |
| **FigCraft** | Interface design and prototyping | `.figcraft` |
| **CADCraft** | CAD and technical drafting | `.cadcraft` |
| **LightCraft** | Photo library and raw development | raw + library folder |
| **ArtCraft** | AI image and video studio | — |

Full matrix — MCP server name, CLI, tool groups, export formats, and honest limits — is in
[reference/apps.md](reference/apps.md). Read the row for the app you intend to drive before you
drive it.

These are early releases (PhotoCraft, PdfCraft and FigCraft are alpha; the rest are in
development). They are good enough to do real work, and not good enough to trust blindly.

## The loop

```
1  Locate     which app owns this artifact, and is it here?
2  Ask        install only what is missing, only with permission
3  Build      one exec call, native format, commands in order
4  Look       render or inspect the result before you claim success
5  Deliver    the file, plus what was verified and what was not
```

### 1 — Locate

Pick the app by the artifact, not by what is already running. A deck is DeckCraft even if
PhotoCraft is open. One artifact, one app. Do not assemble a document out of screenshots, and do
not do layout work in the word processor because it is warmer.

Check that the app is actually there before planning around it: the CLI on `PATH` or in its
install root, and its server in the code-mode upstream list (`ALL_SERVERS` inside `exec`). Paths
and detection commands are in [reference/setup.md](reference/setup.md).

### 2 — Ask before installing

Two different installs, two different questions, both asked before anything runs:

- **The app is missing.** Ask for the app, name the command, say what it costs and whether a
  restart is needed. Then wait for a yes.
- **The app is installed but not registered in code-mode.** That is not an install of software —
  it is one entry in the code-mode config file. Say you are adding it, add it, verify the config
  parses, and note that the server picks it up on the next session.

If code-mode itself is missing, that is a third question: it is the server that makes every other
app reachable in one call. Ask once, install it once, use it for everything after.

Never install an app the task does not need. Never install a bundle of apps. Never install
silently because the answer felt obvious.

### 3 — Build

One `exec` call per stage, not one tool call per sentence. Inside it:

- `search()` and `describe()` to find a tool you have not used in this session; `ALL_TOOLS` when
  search misses.
- `tools.mcp__<server>__<tool>({...})` to call. Names are `mcp__deckcraft__add_slide`,
  `mcp__wordcraft__execute`, and so on.
- `Promise.all` only for calls that do not touch the same document. Two writers on one deck is a
  race, not parallelism.
- Reduce and filter inside the program. Return the fields you need, not the whole result.

Prefer commands over pixels. Every app has a command path (`run_command`, `execute`, `command_run`,
`run`), which is deterministic, undoable, and keeps the file editable. Pointer and keystroke tools
(`pointer`, `click`, `type_text`, `key`) exist for what commands do not cover; they are slower,
they depend on window state, and they are the last resort.

Read commands before guessing their parameters — `list_commands`, `describe_command`,
`command_list`, or the app's `commands` CLI — rather than inventing an id.

Keep every file inside the working folder. Automation roots (`--automation-read-root`,
`--automation-write-root`) exist so an agent is not handed the whole home directory; point them at
the project, not at `${USERPROFILE}`.

### 4 — Look at it

A tool returning `ok` is not the artifact being right. Before reporting done:

| Artifact | Prove it with |
|---|---|
| Document | `render_page` or `inspect_document` — text, styles, page count |
| Deck | `render_slide` per slide, and `inspect_document` for what each slide holds |
| Spreadsheet | the recalculated values, not the formulas you wrote |
| PDF | `page_render` on the pages you changed, and `doc_info` |
| Image | `render_preview` at full size |
| Vector | `render_preview`, then check strokes at 100% and 400% |
| Video | `render_frame` at the in, middle and out, plus the exported file's duration |
| Motion graphic | `render_frame` at the keyframes you set |

Then open the saved file with the app's own `info` / `inspect` command — the file on disk is the
deliverable, not the session state. Export is a second step and a second verification.

Fix what you find and look again. Stop when the visible problem is gone.

### 5 — Deliver

Name the file, its format, and what was verified. If something could not be verified — an export
that failed, a page that would not render — say that instead of describing the intent. Do not
report a deck as finished because all the commands succeeded.

## Working rules

**The native format is the source of truth.** Save `.docx`, `.pptx`, `.xlsx`, `.psd`, `.ai` and
keep them. PDF, PNG and MP4 are deliverables, not working files. Never edit a flattened export
and call it done while the source is stale.

**One app per artifact, one artifact per answer.** If the request needs a document *and* a deck,
that is two artifacts and two app choices — say so and do both, rather than one file pretending
to be both.

**Commands are the API.** Ids and parameters come from the app, not from memory. When a command
fails, read the error and `describe_command` its schema.

**Convert with the app, not with a script.** Every suite app converts: WordCraft to pdf/md/odt/rtf,
PdfCraft to images and Office, VectorCraft to most raster and vector formats, PhotoCraft between
image formats, DeckCraft to pptx/pdf/gif. A hand-rolled converter loses the layout.

**Batch, then reduce.** Ten slides is ten `add_slide` calls inside one `exec`, then one render of
the slides that changed. Not ten round trips.

**Respect the file.** Do not overwrite a user's source without a new name or a stated reason.
Write next to it, name the version in the filename.

## Handoffs

Office makes the artifact. These skills make it good, or take the part Office does not own:

| The work is | The skill |
|---|---|
| A polished deck, poster or document layout | `poise` |
| Interface or website design, not the document | `lucent` |
| A chart that has to be honest and readable | `dataviz` |
| An illustration as clean SVG, outside a vector app | `hairline-create` |
| A video built from HTML, or a live slideshow | `hyperframes`, `slideshow` |
| Music, SFX, voiceover, stock media | `media-use` |

Use the suite for the artifact, and the skill for the judgement about it. Cross-app chains —
a report from a spreadsheet, a deck from a document, a video from a deck — are in
[reference/workflows.md](reference/workflows.md).

## References

| File | Holds |
|---|---|
| [reference/apps.md](reference/apps.md) | Every app: MCP server, CLI, tool groups, formats, limits |
| [reference/setup.md](reference/setup.md) | Detection, the consent question, installation, code-mode registration |
| [reference/codemode.md](reference/codemode.md) | The `exec` runtime, call patterns, images and errors |
| [reference/workflows.md](reference/workflows.md) | Multi-app recipes and per-medium checklists |
