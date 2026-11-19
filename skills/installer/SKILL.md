---
name: installer
description: "Build a custom, beautiful one-click Windows installer (plus portable zip and auto-update) instead of a wizard-style Inno Setup/MSI. One release script, an animated in-brand splash generated in code, brand tokens driving icon, type and color, seamless loop, path scrubbing, delta updates. Use when someone wants a polished installer, a custom install screen, or to replace Setup.exe/NSIS/Inno."
---

# Installer

A custom installer is one shell binary, one script, and one brand-matched animated surface. No
wizard, no options page, no Next/Next/Finish: the app installs itself and opens. Build it as a
release pipeline, not as an installer project — the installer is an output of shipping, and every
run of the script must produce the same result on a clean machine.

## The shape

Three artifacts from one script, every time:

| Artifact | Purpose |
|---|---|
| `App-win-Setup.exe` | The one-click installer users download. Branded splash, progress line, no wizard. |
| `App-win-Portable.zip` | For people who will not run a setup binary. Same payload, no install. |
| Update packages + manifest | What the running app polls. Silent, delta-backed, no second installer UI. |

Pick **Velopack** for the shell. It gives a borderless splash image, its own progress line, delta
updates, and rent-native install/uninstall, without a wizard — that is the whole reason to prefer
it over Inno Setup, NSIS, or WiX. Keep the app's own updater pointed at the Velopack manifest.

## Build the release script

One PowerShell script at `installer/release.ps1`, parameterized by `-Version`, `-Clean`,
`-Publish`. It runs the whole chain in order and throws on every failure:

1. **Build the app payload** into a folder outside the repo, self-contained and single-arch.
   Third-party build tools break on paths with spaces or apostrophes; a temp dir avoids it.
2. **Scrub local identity.** Set `--remap-path-prefix` / `PathMap` so source paths embedded in
   panic strings, PDBs, or debug info do not ship as `C:\Users\<name>\…`.
3. **Render the splash** from the brand tokens (next section). The script must fail if this
   fails: a missing splash is visible to every user.
4. **Pack** with the shell:
   ```
   vpk pack --packId App --packVersion $Version --packDir $pub --mainExe App.exe \
       --packTitle App --packAuthors App \
       --icon assets/App.ico \
       --splashImage installer/splash.gif --splashProgressColor "#FFFFFF" \
       --shortcuts StartMenuRoot --outputDir dist/releases
   ```
5. **Publish.** Fetch the previous release first so a delta exists, then upload exactly the files
   the updater reads. Use the platform CLI (e.g. `gh release create`) rather than the packer's
   own uploader, which has a history of hanging mid-upload.
6. **Print the output sizes.** A release script that does not show the final MB is hiding weight.

Signing is the one deferred thing: leave `--signParams` / `--azureTrustedSignFile` as a
commented flag with a note. Unsigned builds are fine for now and SmartScreen will warn.

## The splash

The splash is the installer's entire design surface, so it must be the product's own visual
language, animated — never a logo on a gradient, never a stock "installing" spinner.

**Design language**

- **Two values plus one accent, no more.** Ink on paper, or paper on ink. Gray is the third voice
  for the status line only. Anything past that reads as a template.
- **The product's own typeface**, loaded from the shipped variable font. One mark line, one
  caption line, both small, both anchored to the top-left and bottom-left of a padding grid. No
  centered headline, no subtitle stack, no version number.
- **Status text is a verb in present tense** ("Installing"), lowercase or sentence case, never
  "Please wait…", never an ellipsis count.
- **The shell owns the progress.** Splash background color equals `--splashProgressColor`, so the
  bar's track disappears into the artwork. Never draw your own progress bar.
- **Motion is one idle loop, seamless.** Every frequency is an integer multiple of the loop
  length, so frame 60 meets frame 0 with no seam and no ping-pong. One breath, one orbit set, one
  ripple — three ideas at most.

**Renderer recipe** (Python + Pillow writes the GIF at build time; never hand-author frames)

- Draw at **2× supersampling**, then `resize(..., Image.LANCZOS)` down. Cheap anti-aliasing that
  holds up at 380×300.
- **Blur, then threshold.** Gaussian-blur the shape layer, then threshold it at ~50% with a gentle
  slope (~12 levels). Shapes melt into each other with a crisp, organic edge — the goo look. A
  hard threshold gives a jagged edge; no threshold gives fog.
- **Lava-lamp satellites**: orbit radii and phases driven by `sin` at the loop frequency, with
  integer turn counts per loop (`k = 1, 2, -1`) so orbits close.
- **One ripple per loop**, radius growing linearly, line width thinning as `(1-u)^1.3` until it
  evaporates below a sub-pixel threshold.
- **Palette-quantize** to ~32 colors, `duration = 1000/FPS`, `loop=0`, `disposal=1`. 25 fps over
  ~2.4 s is 60 frames: small file, no visible step.
- Take the font path and output path as CLI args. Read size, FPS, loop length, and the three
  colors from a small constants block at the top so the palette can be retargeted in one edit.

```python
import math, sys
from PIL import Image, ImageDraw, ImageFilter, ImageFont

W, H, SS = 380, 300, 2          # canvas, supersample factor
FPS, LOOP = 25, 2.4             # frames = FPS * LOOP, integer
INK, PAPER, MUTED = 255, 0, 138 # palette: two values + one gray

def stage(t):
    m = Image.new("L", (W * SS, H * SS), 0)
    d = ImageDraw.Draw(m)
    w = 2 * math.pi / LOOP                        # one loop = one breath
    breath = 1 + 0.25 * (0.5 - 0.5 * math.cos(w * t))
    d.ellipse(_box(W/2, 132, 12 * 1.7 * breath), fill=255)
    for i, k in enumerate((1, 2, -1)):            # whole turns per loop
        a = w * k * t + i * 2.1
        rr = (20 + 9 * math.sin(w * t + i)) * 1.7
        d.ellipse(_box(W/2 + math.cos(a) * rr, 132 + math.sin(a) * rr, (4.5 + i) * 1.7), fill=255)
    u = (t % LOOP) / LOOP                         # one ripple, thinning out
    lw = 9 * 1.7 * (1 - u) ** 1.3
    if lw > 0.2:
        r = (16 + u * 70) * 1.7
        d.ellipse(_box(W/2, 132, r), outline=255, width=max(1, int(lw * SS)))
    m = m.filter(ImageFilter.GaussianBlur(5.6 * 1.7 * SS))
    return m.point(lambda v: max(0, min(255, int((v / 255 * 12 - 5.5) * 255))))
```

Then compose each frame as ink-on-paper with the mark and the status caption, and save the frame
list. Keep the whole renderer under ~80 lines: it is build tooling, not a project.

## Icon and assets

Generate the icon and tile set from one vector or one script, never from three hand-drawn PNGs.
Keep `.ico`, tray icon, and tile sizes in a single `assets/` folder plus the generator, so a
palette change is one re-run. Same rule for the tray icon: it is the mark, not a screenshot.

## Rules

- **One script, no manual steps.** If the release needs a second command typed by hand, it is not
  done; put it in the script with a comment explaining why.
- **Never ship a wizard.** No license page, no path chooser, no component checkboxes. If an option
  is genuinely needed, put it in the app's settings, not in setup.
- **The splash must loop seamlessly and be under a megabyte.** Seams and jank are the two things
  people notice on an install screen.
- **Match the app.** Same font, same mark, same two values and accent, same motion curve as the
  product's first idle state. An installer that looks like a different product costs more trust
  than it buys polish.
- **Say the cost.** One line in the report: installer size, portable size, delta size, and what
  the splash costs in KB.
- **Defer signing deliberately.** Note it in the script header and in the README download section
  ("SmartScreen will warn: More info → Run anyway"); do not pretend it is signed.
