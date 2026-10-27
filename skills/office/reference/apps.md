# The suite

Thirteen apps, one contract. Each is a native Rust desktop app plus a headless CLI; the CLI's
`mcp` subcommand is the MCP server, and it drives the same command engine the window does.

Two facts shape everything below:

- **Tool names are not uniform.** PhotoCraft, VectorCraft, FilmCraft, EffectCraft and LightCraft
  share a family (`command_list`, `command_run`, `command_batch`, `doc_inspect`,
  `render_preview`). DeckCraft, VectorCraft, DesignCraft, WordCraft and PdfCraft use their own
  names (`add_slide`, `execute`, `page_render`, `run_command`). Discover, never assume.
- **Command ids are the real API.** Every app has a command registry with hundreds of ids
  (`format.bold`, `slide.new`, `cell.set`, `paint.setFill`). Read it before writing commands.

## Apps

### WordCraft — documents

- **Server** `wordcraft` · **CLI** `wordcraft-cli` · **file** `.docx`
- Reads and writes `.docx`, `.doc`, `.pdf`, `.odt`, `.rtf`, `.html`, `.md`, `.tex`, `.txt`, `.json`, `.png`
- Tools: `execute`, `batch`, `new_document`, `open_document`, `save_document`, `inspect_document`,
  `get_text`, `select_text`, `render_page`, `list_commands`, `key`, `type_text`, plus live-UI
  `click`, `screenshot`, `ui_inspect`
- CLI extras worth knowing: `convert` (all the formats above, `--update-fields` refreshes fields
  before saving), `render --page N`, and `zotero` for citations and bibliographies against a
  running Zotero
- Headless file access is confined by `--automation-read-root` / `--automation-write-root`; a root
  left out grants no access in that direction
- Limit: mail merge is real but reads only the data you give it; fonts missing from the machine
  are substituted, so check `inspect_document` for substitutions before promising a pixel-exact
  match

### DeckCraft — presentations

- **Server** `deckcraft` · **CLI** `deckcraft-cli` · **file** `.deckcraft` or `.pptx`
- Tools: `new_presentation` (themes: DeckCraft, Harbor, Ember, Meadow, Nocturne, Paper, Coral
  Reef, Slate), `add_slide` (title, titleAndContent, sectionHeader, twoContent, comparison,
  titleOnly, blank, contentWithCaption, pictureWithCaption), `add_shape`, `add_text_box`,
  `insert_table`, `insert_chart`, `insert_picture`, `set_text`, `select`, `render_slide`,
  `inspect_slide`, `inspect_document`, `export`, `save_presentation`, `run_command`, `batch`,
  `list_commands`, `go_to_slide`
- `export` writes png/jpeg (one slide or `all:true`), `pptx`, `pdf` (slides, notes, handouts), and
  an animated gif of the deck
- CLI: `info`, `render`, `render-transition`, `convert`, `run --cmd 'slide.new={"title":"…"}'`,
  `describe <command>`
- Limit: shape-level tricks from a mature deck editor (morph, complex animation timelines) are
  partial. Inspect before promising a PowerPoint-round-trip-safe file

### GridCraft — spreadsheets

- **Server** `gridcraft` · **CLI** `gridcraft-cli` · **file** `.xlsx`
- Reads and writes `.xlsx`, `.csv`, `.tsv`, `.json`, `.html`
- Formula engine with dynamic arrays and spilling, 500+ functions plus `LET`, `LAMBDA`, `MAP`,
  `REDUCE`, `SCAN`, `BYROW`, `BYCOL`, `MAKEARRAY`; structured table references; conditional
  formatting; sort and AutoFilter; seventeen chart types; PivotTables
- CLI: `info`, `convert`, `eval '=PMT(…)--json`', `cat --range A1:D20 --formulas --csv`,
  `check` (formula oracle plus xlsx round-trip), `run`, `commands`, `functions`, `send`
- Limit: macros (VBA) do not run. Charts and pivots round-trip but exotic workbook features may
  not. Verify with `check` after writing formulas

### PdfCraft — PDF workbench

- **Server** `pdfcraft` · **CLI** `pdfcraft-cli` · **file** `.pdf`
- The largest surface in the suite: 179 tools on this machine
- Document: `doc_open`, `doc_create`, `doc_inspect`, `doc_combine`, `doc_split`, `doc_compare`,
  `doc_save`, `doc_optimize`, `doc_reduce`, `doc_flatten`, `doc_protect`, `doc_watermark`,
  `doc_export_text`, `doc_export_images`, `doc_export_office`, `doc_import_data`, `doc_export_data`
- Pages: `page_render`, `page_insert_blank`, `page_insert_file`, `page_extract`, `page_rotate`,
  `page_delete`, `page_move`, `page_number`, `page_add_text`, `page_add_image`, `page_transition_set`
- Text: `text_extract`, `text_find`, `text_edit`, `text_lines`, `text_paragraphs`, `text_fonts`
- Security: `redact_mark`, `redact_apply`, `doc_audit_redactions`, `sign_document`, `sign_trust`,
  `doc_hidden_info`, `doc_remove_hidden`, `doc_audit_space`
- Forms: `form_add_field`, `form_detect_fields`, `form_fill`, `form_merge_data`, `form_set_script`
- Accessibility: `accessibility_check`, `accessibility_autotag_apply`, `accessibility_set_alt`,
  `accessibility_report`, `pdfa_convert`, `pdfa_verify`
- OCR: `ocr_recognize`, `ocr_recognize_files`, `ocr_status`
- CLI: `info`, `render`, `text`, `edit`, `combine`, `extract`, `split`, `check`, `audit`
  (finds faux redactions and fails when it finds them), `batch`, `tools`, `run`
- **Redaction is the one place you must verify twice.** A black rectangle is not a redaction.
  Use `redact_apply`, then `doc_audit_redactions`, then extract the text of the page and confirm
  the secret is gone. `doc_flatten` and `doc_remove_hidden` before handing a file to anyone else

### PhotoCraft — image editing

- **Server** `photocraft` · **CLI** `photocraft-cli` · **file** `.pcraft`, `.psd`
- Tools: `doc_new`, `doc_open`, `doc_save`, `doc_inspect`, `doc_render_preview`, `doc_place`,
  `doc_select`, `doc_replace_smart_object`, `doc_import_data_sets`, `doc_export`, `doc_export_layers`,
  `command_run`, `command_batch`, `command_list`, `render_preview`, plus live UI in bridge mode
- CLI: `convert`, `info --compact` (includes missing-font warnings), `run`, `batch`, `droplet`
- Limit: real PSD read/write, not total PSD fidelity. Soundness beats round-trip: check the layer
  tree after opening someone else's PSD

### VectorCraft — vector illustration

- **Server** `vectorcraft` · **CLI** `vectorcraft-cli` · **file** `.vectorcraft`, `.ai`, `.svg`
- Tools: `draw_shape`, `draw_path`, `add_text`, `text_wrap`, `set_paint`, `apply_effect`,
  `pathfinder`, `transform`, `create_graph`, `open_file`, `save_file`, `export`, `render_preview`,
  `doc_inspect`, `inspect_document`, `command_run`, `command_batch`, `select_tool`, `pointer_gesture`
- CLI: `run`, `convert IN OUT --scale --artboard --range --outline-text`, `info`, `commands`
- **Mode warning:** bare `mcp` tries `127.0.0.1:7979` and silently falls back to headless. Always
  pass `--headless` or `--connect ADDR` so you know which document you are editing

### FilmCraft — video

- **Server** `filmcraft` · **CLI** `filmcraft-cli` · **file** `.fcproj`
- Tools: `project_inspect`, `sequence_inspect`, `media_import`, `render_frame`, `render_preview`,
  `command_run`, `command_batch`, `command_list`, `doc_inspect`; bridge mode adds `ui_*`
- CLI: `exec`, `run` (JSONL), `commands`, `describe`, `inspect`, `import`, `export`, `probe`
- Export: h264, hevc, prores, dnxhr, apv, mjpeg, mxf, png/tiff/bmp sequences, gif, wav, aiff, aac
- **Offline media trap:** an export can write a file *and* exit 1 because clips were offline. Do not
  retry blindly and do not call success on file existence. Check the export log
- Security: the desktop control listener is loopback-only and unauthenticated; headless MCP has no
  read/write root flags. Keep everything on the local machine

### EffectCraft — motion graphics and VFX

- **Server** `effectcraft` · **CLI** `effectcraft-cli` · **file** `.ecproj`
- Tools: `get_project`, `get_comp`, `get_layer`, `get_property`, `set_property`, `add_keyframe`,
  `add_effect`, `list_effects`, `list_fonts`, `render_frame`, `render_preview`, `execute_command`,
  `batch`, `describe_command`, `run_script`, `open_project`, `save_project`, `history`, `undo`, `redo`
- CLI: `props`, `get`, `set`, `render-frame`, `render` (h264, hevc, av1, prores, webm, png, jpeg,
  tiff, exr, gif, wav, aiff), `bench --gpu`
- **Two clocks, one bug source:** `set` keyframe times use *layer* time; `get_property` and
  `render_frame` use *comp* time. Pass `timeBase: "comp"` when the layer is offset or stretched
- After Effects effect names work as ids where the app maps them (`Gaussian Blur`), and native ids
  look like `ec.blur.gaussian`. `list_effects` before guessing

### SoundCraft — audio

- **Server** `soundcraft` · **CLI** `soundcraft-cli` · **file** `.scraft`
- Tools: `new_session`, `open_session`, `save_session`, `inspect_session`, `import_audio`,
  `bounce_mix`, `execute`, `batch`, `list_commands`
- Imports WAV, AIFF, FLAC, MP3, OGG, AAC, M4A, ALAC, CAF; bounces WAV, AIFF, FLAC with loudness
  measures
- Headless runs the mix engine without an audio device: you can mix and bounce, but not record
- `save_session` refuses to replace an unrelated existing file unless `replace:true`; make that
  explicit rather than silent

### DesignCraft — page layout and publishing

- **Server** `designcraft` · **CLI** `designcraft-cli` · **file** `.designcraft`
- Tools: `new_document`, `open_document`, `save_document`, `inspect_document`, `get_story`,
  `set_story_text`, `place_image`, `render_page`, `export_png`, `execute`, `batch`, `list_commands`
- Coordinates are points (1/72 inch), y down, in spread space; page indices are 0-based
- **Text offsets are UTF-8 bytes**, not characters. Do not compute them from `String.length`
- Limit: PDF export and IDML interchange are still maturing; validate the PDF you produce

### FigCraft — interface design and prototyping

- **Server** `figcraft` · **CLI** `figcraft-cli` · **file** `.figcraft`
- Same command/`execute`/`batch` pattern; for web and app interface design specifically
- For building the interface itself in code, this is not the tool — that is `lucent` and the
  project's own stack. FigCraft is for design files and prototypes

### CADCraft — CAD and drafting

- **Server** `cadcraft` · **CLI** `cadcraft-cli` · **file** `.cadcraft`
- CLI: `info`, `convert`, `run`, `commands`, `perf`, `sample`
- `--connect` fails on error rather than falling back to headless, so a wrong port is loud
- For technical drawings, floor plans, mechanical parts, and dimensioned output

### LightCraft — photo library and raw

- **Server** `lightcraft` · **CLI** `lightcraft-cli` · **file** raw + library directory
- Tools: `import`, `query_photos`, `select_photos`, `list_controls`, `get_develop`,
  `set_develop`, `apply_preset`, `crop`, `render_photo`, `export`
- CLI: `run --import`, `render IN -o OUT --set light.exposure=0.5`, `snapshot`,
  `merge hdr|panorama|hdr-panorama`
- **Library lock:** one process at a time. Headless MCP cannot open a library the desktop app holds;
  use `--connect` instead
- `import` with `mode:move` moves and removes originals after verification. Ask before using it

### ArtCraft — AI image and video studio

- The studio app, not an editor. Use it when the brief asks for generated stills or video and no
  photograph or render exists. Not an MCP-driven editing surface in the way the others are

## Choosing an app

| The deliverable is | App |
|---|---|
| A letter, report, contract, manuscript, mail merge | WordCraft |
| A slide deck, pitch, or presentation | DeckCraft |
| A budget, model, data table, pivot | GridCraft |
| Anything that leaves as a fixed-layout document, or anything coming in as one | PdfCraft |
| A retouched or composited image | PhotoCraft |
| A logo, icon set, illustration as paths | VectorCraft |
| A cut video, a sequence with colour and sound | FilmCraft |
| Animated titles, effects, a rendered motion piece | EffectCraft |
| A mixed or bounced audio track | SoundCraft |
| A printed page, brochure, or layout with spreads | DesignCraft |
| A UI design file or clickable prototype | FigCraft |
| A technical or mechanical drawing | CADCraft |
| A catalog of photos, raw development, HDR merge | LightCraft |

Two artifacts in one request means two apps. Say so and do both.

## Formats the suite converts

| From | To |
|---|---|
| docx | pdf, odt, rtf, html, md, tex, txt, json, png, flat OPC XML |
| pptx / deckcraft | pdf, png, jpeg, gif |
| xlsx | csv, tsv, json, html |
| pdf | images, Office, text, flattened PDF, PDF/A |
| psd / pcraft | png, jpg, tif, webp, exr |
| ai / vectorcraft | svg, pdf, raster formats, multi-artboard |
| video project | h264, hevc, prores, dnxhr, webm, image sequences, gif |
| audio | wav, aiff, flac, mp3 |

Convert inside the suite rather than reaching for an external tool. What leaves the suite loses
layout.
