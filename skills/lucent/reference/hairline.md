# Hairline illustrations and diagrams

Use Hairline when a website needs an SVG illustration, an empty-state object, a feature visual,
or a conceptual diagram and its isometric line style fits the brief. Lucent owns the placement,
hierarchy, caption, and integration; Hairline supplies the figure.

Start with the [live catalogue](https://hairline.lucasmarkes.com) and
[upstream documentation](https://github.com/lucasmarkes/hairline#readme). The creation workflow
lives in [`hairline-create`](https://github.com/lucasmarkes/hairline/blob/main/skills/hairline-create/SKILL.md).
Read the installed skill when using it; this reference does not replace its rules.

## Choose the output

| The page needs | Use |
|---|---|
| A still illustration or diagram | A composed pose saved as standalone SVG; ship no figure runtime |
| A visual already in the catalogue | Reuse the premade figure, or adapt a suitable example, before creating from scratch |
| A new object or explanatory metaphor | `hairline-create`, then use its figure as a still or an interactive component |
| Pointer interaction that explains something | The package's DOM or React entry for premade figures; the validated HTML for a custom figure |

Choose by meaning. `exploded` can show layers; `hub` or `relay` can show connections;
`rebuild` can suggest dependencies. Confirm the actual figure in the catalogue rather than
choosing it for its name. The skill also includes `examples/terrain.js` and
`examples/riffle.js` as starting points. Preserve upstream MIT notices when reusing source.

Hairline suits diagrams expressed through objects and physical metaphors. Use existing diagram
tooling for precise labelled flowcharts or technical schematics. A chart or metric still follows
the [data visualisation handoff](handoffs.md#data-visualisation). Keep essential diagram labels,
relationships, and explanations in accessible page content. Keep the existing icon system for
ordinary controls.

## Create or adapt a figure

Check availability through the [handoff protocol](handoffs.md#hairline-illustrations-and-diagrams).
Give `hairline-create` the object's meaning, intended placement and size, and whether the site
needs a still or interaction. Follow its concept selection and validation workflow. Edit the
figure file; leave its fixed `kernel.js` and `bench.html` unchanged.

Hairline's visual rules include rounded solids, restrained strokes, and a composed rest pose.
Labels belong outside the drawing. Follow the installed skill's build, validator, and visual
checks, and disclose anything that could not be verified.

## Produce a static SVG

The creation skill's documented output is `hairline-<name>.html`. Producing a standalone `.svg`
is a Lucent integration step after authoring and checking the figure:

1. Render the figure in its intended theme and size, with autoplay off. Let the rest pose settle,
   or deliberately choose and settle an explanatory pose. In the generated bench, a separate
   extraction script can clone `#stage > svg`; leave the bench unchanged. The unexecuted HTML
   does not contain the finished drawing.
2. Make the SVG self-contained. Preserve its `viewBox`, namespace, geometry, definitions, and
   references. Inline the resolved fills, strokes, widths, line caps, joins, opacity, and other
   appearance it inherits from page CSS. Classes or custom properties alone will lose their
   styling in an external image. Preserve plate fills: they hide geometry behind them.
3. Remove script, event handlers, animation, and bench controls. Keep the editable figure source
   separately. Save the SVG in the project's asset directory; no Hairline production dependency
   is needed for this output.
4. Open the SVG independently and in the actual page at mobile and desktop sizes. Check clipping,
   stroke legibility, background matching, and every supported theme. Set intrinsic dimensions
   or an aspect ratio. Use useful alt text for meaning, or empty alt text for decoration.

Hairline's HTML validator checks the source figure page; inspect the exported SVG separately.
For repeated inline SVGs, make definition IDs unique. An external `<img>` cannot inherit the
page's CSS variables; use resolved colours or separate theme assets. This export procedure is
integration guidance, not a claimed Hairline export command.

## Keep interaction only when it helps

Premade figures are available through `@lucasmarkes/hairline` and
`@lucasmarkes/hairline/react`; use the project's existing stack. The generated HTML is a
standalone figure bench, not a ready-made React component. If embedding it, keep it scoped and
avoid shipping its authoring controls as website UI.

Follow Lucent's [web rules](../SKILL.md#the-six-web-rules): provide the static SVG before mount
and for reduced motion, keep meaning available without interaction, and clean up on unmount
(`destroy()` for the DOM API). Set the plate colour to the actual background. Report the runtime
and maintenance cost when interaction is retained.
