# Workflows

Recipes for one app and for chains across apps. Each ends with the check that proves the artifact.

## Document

WordCraft, `.docx` source, `.pdf` deliverable.

```js
// 1 — create and write.
// Templates ship placeholder text; select all and replace it, or start blank.
await tools.mcp__wordcraft__new_document({ template: 'letter' });
await tools.mcp__wordcraft__execute({ command: 'select.all' });
await tools.mcp__wordcraft__execute({ command: 'text.insert',
  params: { text: 'Quarterly report\n\nRevenue grew 12% year over year.' } });
await tools.mcp__wordcraft__execute({ command: 'file.exportPdf', params: { path: 'D:/work/report.pdf' } });
await tools.mcp__wordcraft__save_document({ path: 'D:/work/report.docx' });

// 2 — look at page 1 before claiming it is right
const page = await tools.mcp__wordcraft__render_page({ page: 1 });
return image(page.content?.find(b => b.type === 'image'));
```

`new_document({ template: 'letter' })` opens a real letter template — complete with "Your Name"
placeholders — and `text.insert` inserts at the caret, inside that text. `select.all` first, or
start from `blank`, or target with `text.select` and `edit.replace`. The same trap exists in every
app with starter content: check what you opened before writing into it.

Discover unknown command ids with `list_commands` filtered by keyword. Headings, styles, tables,
comments, tracked changes, headers and footers are all commands.

Check: `inspect_document` for page count, style names and font substitutions; `get_text` to confirm
nothing was dropped. Then convert with the CLI (`wordcraft-cli convert report.docx report.pdf`) if
the in-session export is unavailable.

## Deck

DeckCraft. Nine slides is nine `add_slide` calls in one exec, then one batch render.

```js
await tools.mcp__deckcraft__new_presentation({ theme: 'Nocturne' });
const outline = [
  { layout: 'title',            title: 'Q3 in review', body: 'October 2026' },
  { layout: 'sectionHeader',    title: 'Where we are' },
  { layout: 'titleAndContent',  title: 'Revenue',       body: 'Up 12% year over year\nEnterprise led growth' },
  { layout: 'titleAndContent',  title: 'Margin',        body: 'Gross margin +2.1 points\nCosts flat' },
  { layout: 'sectionHeader',    title: 'What next' },
  { layout: 'titleAndContent',  title: 'Plan',          body: 'Hire two in support\nShip the billing rewrite' },
];
for (const s of outline) await tools.mcp__deckcraft__add_slide(s);

// a chart on the last slide, from real numbers
await tools.mcp__deckcraft__add_slide({ layout: 'titleOnly', title: 'Revenue by quarter' });
await tools.mcp__deckcraft__go_to_slide({ index: outline.length });
await tools.mcp__deckcraft__insert_chart({
  type: 'column', categories: ['Q1','Q2','Q3'], series: [{ name: 'Revenue', values: [2.1, 2.6, 2.9] }]
});

await tools.mcp__deckcraft__save_presentation({ path: 'D:/work/q3.deckcraft' });
const shot = await tools.mcp__deckcraft__render_slide({ slide: 3 });
return image(shot.content?.find(b => b.type === 'image'));
```

Check: `inspect_document` for slide count and titles, then `render_slide` on every slide that
carries text — overflow and overlap do not show up in the command result. Export `pptx` and `pdf`
with `export`.

Text that overflows the placeholder is the most common defect. Shorten the body or split the slide;
do not shrink the font below the theme's body size.

## Spreadsheet

GridCraft, `.xlsx`.

```bash
gridcraft-cli run --in budget.xlsx \
  --cmd 'cell.set={"cell":"B12","formula":"=SUM(B2:B11)"}' \
  --cmd 'cell.set={"cell":"B13","formula":"=B12*0.2"}' \
  --print used --out budget.xlsx
gridcraft-cli cat budget.xlsx --range A1:J13
```

Or through MCP: open, run `commands` filtered for `cell.`, `formula.` or `table.`. Read values, not
formulas, when reporting a number — a formula string is not a result.

Check: `gridcraft-cli check budget.xlsx` compares cached results against the formula oracle and
round-trips the file. `cat --range … --csv` shows what a reader would actually see.

## PDF

PdfCraft. The dangerous work is redaction and the fiddly work is page surgery.

```js
await tools.mcp__pdfcraft__doc_open({ path: 'D:/work/contract.pdf' });
const info = await tools.mcp__pdfcraft__doc_info({});
await tools.mcp__pdfcraft__redact_mark({ find: 'ACME-INTERNAL-4471' });
await tools.mcp__pdfcraft__redact_apply({});
await tools.mcp__pdfcraft__doc_flatten({ fields: true, comments: true });
await tools.mcp__pdfcraft__doc_save({ path: 'D:/work/contract-redacted.pdf' });

// prove it is gone
await tools.mcp__pdfcraft__doc_open({ path: 'D:/work/contract-redacted.pdf' });
const found = await tools.mcp__pdfcraft__text_find({ query: 'ACME-INTERNAL-4471' });
const audit = await tools.mcp__pdfcraft__doc_audit_redactions({});
return { found, audit };
```

Page surgery — split, extract, rotate, reorder, insert, number — is `page_*` and `doc_split` /
`doc_combine`. Forms are `form_*`; fill, then `form_fields` to confirm the values landed where the
field really is. Accessibility and PDF/A are `accessibility_*` and `pdfa_convert` / `pdfa_verify`.

Check: reopen the saved file, `page_render` the changed pages, and for a redaction run
`doc_audit_redactions` **and** `text_find` for the original string. Both, every time.

## Image

PhotoCraft.

```js
await tools.mcp__photocraft__doc_open({ path: 'D:/work/hero.psd' });
const tree = await tools.mcp__photocraft__doc_inspect({});
await tools.mcp__photocraft__command_run({ id: 'image.adjustments.invert', wait: true });
const preview = await tools.mcp__photocraft__doc_render_preview({});
await tools.mcp__photocraft__doc_save({ path: 'D:/work/hero-edited.psd' });
return { layers: tree, preview: preview.content?.find(b => b.type === 'image') };
```

Command ids come from `command_list`, not memory. `command_batch` is **not atomic** — earlier steps
stay applied after a later failure, so save a copy before a high-impact batch.

Check: `render_preview` at full size, and `doc_inspect` for the layer tree and missing fonts.
Export a flattened copy for delivery and keep the layered file as the source.

## Vector

VectorCraft.

```js
await tools.mcp__vectorcraft__open_file({ path: 'D:/work/mark.ai' });
await tools.mcp__vectorcraft__set_paint({ fill: '#ff6b1a' });
await tools.mcp__vectorcraft__export({ path: 'D:/work/mark.svg' });
const preview = await tools.mcp__vectorcraft__render_preview({});
return image(preview.content?.find(b => b.type === 'image'));
```

Check the render at 100% and at 400%: stroke weights and hairline alignment only show at scale.
`command_batch` with `atomic: true` groups the edits into one undo step.

## Video

FilmCraft. Build the sequence, then export and verify the export.

```js
await tools.mcp__filmcraft__media_import({ paths: ['D:/work/a.mp4', 'D:/work/b.mp4'] });
const seq = await tools.mcp__filmcraft__sequence_inspect({});
const frame = await tools.mcp__filmcraft__render_frame({ seconds: 2.5 });
const job = await tools.mcp__filmcraft__command_run({
  id: 'file.exportMedia',
  params: { path: 'D:/work/cut.mp4', format: 'h264', wait: true }
});
return { seq: seq.structuredContent ?? seq, job, frame: frame.content?.find(b => b.type === 'image') };
```

**Offline media writes a file and still fails.** An export can exit non-zero after producing an
apparently valid mp4 because some clips were offline and were replaced with placeholders. Read the
log; do not accept the file on existence, and do not auto-retry.

Check: render the in, middle and out frames, then probe the exported file's duration and codec
before calling it done.

## Motion graphics

EffectCraft. Layers, properties, keyframes, render.

```js
await tools.mcp__effectcraft__open_project({ path: 'D:/work/title.ecproj' });
const layer = await tools.mcp__effectcraft__get_layer({ comp: 'Main', layer: 1 });
await tools.mcp__effectcraft__set_property({
  comp: 'Main', layer: 1, path: 'transform/opacity', value: 0, time: 0, timeBase: 'comp'
});
await tools.mcp__effectcraft__add_keyframe({
  layer: 1, path: 'transform/opacity',
  keys: [{ time: 0, value: 0 }, { time: 0.8, value: 100 }],
  interpolation: 'easyEase'
});
const frame = await tools.mcp__effectcraft__render_frame({ comp: 'Main', time: 0.4 });
return { layer, frame: frame.content?.find(b => b.type === 'image') };
```

`get_layer` returns the property paths — use those exact strings as `path`. Native effect ids look
like `ec.blur.gaussian`; After Effects names also work. `list_effects` first.

Check: render at each keyframe time and at the midpoint of every eased move.

## Audio

SoundCraft.

```bash
soundcraft-cli run --demo \
  --cmd 'mix.volume={"track":"Kick","db":-6}' \
  --cmd 'mix.insert={"track":"Bass","plugin":"eq_7band"}' \
  --bounce mix.wav
```

Through MCP: `new_session` or `open_session`, `import_audio`, `execute` mix commands,
`bounce_mix`, then `inspect_session` for the bounce's loudness measures.

Check: the bounce's measured level and duration. Headless has no audio device — nothing is
monitored by ear, so the numbers are the check.

## Layout and print

DesignCraft. Points, spreads, and byte offsets.

```js
await tools.mcp__designcraft__new_document({ preset: 'A4', pages: 4, facingPages: true, margins: [18,18,18,18] });
await tools.mcp__designcraft__execute({ command: 'frame.create', params: { rect: [40, 40, 515, 300], content: 'text' } });
await tools.mcp__designcraft__set_story_text({ story: 0, text: 'Heading\n\nBody copy.' });
const page = await tools.mcp__designcraft__render_page({ page: 0 });
return image(page.content?.find(b => b.type === 'image'));
```

Text ranges are UTF-8 byte offsets. Do not compute them from JavaScript string length.

Check: `inspect_document` for overset stories (text that did not fit), then `render_page` per page,
then export PDF and validate it with `designcraft-cli validate-pdf`.

## Chains across apps

**Spreadsheet → deck.** Read the numbers from GridCraft (`cat --range --csv`), then feed them to
DeckCraft's `insert_chart` as real series. Never re-type the numbers.

**Document → deck.** WordCraft's outline becomes DeckCraft section headers and bullets. Keep the
document as the source of prose and the deck as the summary.

**Deck → video.** Export the deck as PNGs (`export all: true`), import the sequence into FilmCraft,
set durations per slide, add the soundtrack, export. This is the path to a narrated deck video.

**Any → PDF.** WordCraft, DeckCraft, PdfCraft itself and DesignCraft all export PDF. Choose the app
that owns the layout, then export from it; do not build the PDF page by page in PdfCraft when the
content is a document.

**Images → deck or document.** Export at the size the destination needs (slide images ~1920px wide,
print images 300 dpi at final size), and place them with `insert_picture` / `page_add_image`. Do not
upscale a screenshot into print.

When a chain crosses into judgement rather than production — how the deck should look, whether the
chart is honest, whether the page has poise — hand off to `poise`, `dataviz` or `lucent` rather than
doing it inside the app.
