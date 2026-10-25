# Calibration: an interrupt poster, v4 to v5

This example records a user-preferred improvement to a computer-architecture poster. It teaches decisions, not a mandatory style. The source exports are `v4/COA-Unit2-Interrupts-v4` and `v5/COA-Interrupts-v5` in the original poster project; no local files or fonts from that project are required to use this skill.

## The stronger main visual

V4 gave prominent space to an illustrative speedup headline and a logarithmic bar chart comparing input-related timings. Those timings were not measurements from a common documented benchmark. The composition asked the viewer to decode latency comparisons before seeing the mechanism.

V5 used recognizable vector objects in a clear path:

**Keyboard or mouse input → I/O interface → IRQ controller → processor.**

A second strip showed the execution sequence:

**Program → save → ISR → restore → resume.**

Labels and short explanations sat near the relevant objects. A consistent blue accent identified the important elements. The execution strip was explicitly conceptual and not to scale. The user preferred this visual explanation to the earlier bars.

The transferable decision is to choose a graphic that answers the artifact's central question. Here, the question was how input becomes an interrupt service and how the program continues. Recognizable objects and a connected sequence made that story easier to see.

This was a change in explanatory purpose, not a data-preserving restyle of the old chart. Do not infer that diagrams are always better than bars. A request to present measured latency still needs the measurements, units, scale, source, and relevant uncertainty.

## The technical detail became easier to read

V4's method used a six-line, small monospace hardware-oriented code example. V5 used three larger lines of explicitly conceptual pseudocode: capture and queue the input, clear or acknowledge as required, and return. Supporting prose explained deferred work and state preservation.

The useful rule is **shorten the explanation before shrinking its type**. Keep the essential sequence, give it enough room, and move lower-level detail only when the task permits. Do not silently change working code or rewrite source-faithful academic material.

The current v4 export already uses serif italic editorial labels, and v5 still contains uppercase monospace metadata and diagram labels. This comparison does not establish that v5 removed monospace overall or narrowed its letterforms. The user's stated preference is to prune excessive mono styling; carry that forward as a deliberate constraint, not an invented description of these files.

## Hierarchy carries the explanation

V5 has a large two-line headline, a short explanatory subtitle, a dominant process visual, a contained execution strip, then supporting comparison and concept sections. Shape, size, spacing, and placement establish the reading order.

Borrow the clarity of that order, readable labels, coherent icon weight, aligned captions, and restraint in the palette. Do not copy its colors, typefaces, numbering, tinted panel, uppercase labels, or separator count into every project. V5 still uses rules and small technical labels; a new artifact may benefit from fewer of them.

The blue emphasis works because it points to related parts of the explanation. Color changes without semantic purpose would add noise. The diagrams work because each arrow connects a meaningful stage; random technical ornament would not provide the same improvement.

## Precision also affects the feeling

V5 removed the unsupported speedup framing and made important boundaries explicit: the sequence is conceptual, polling and interrupts suit different workloads, and interrupt latency is not the full input-to-screen delay. These clarifications made the explanation more credible without relying on impressive-looking numbers.

Treat this as a reminder to preserve evidence and qualifications while polishing. Identify a claim's support and the authorized editing scope before changing it. Visual cleanup alone is not permission to remove valid findings or technical caveats.

## How to transfer the lesson

- **Website:** replace ornamental technical clutter with one understandable product interaction; keep measured proof where it belongs.
- **Poster or PDF:** give the central mechanism room, label its stages, and shorten authorized supporting text before reducing type size.
- **Video:** reveal the same mechanism in a purposeful sequence, then hold the composed result long enough to understand it.
- **Any medium:** retain what makes the idea memorable; prune the detail that makes understanding feel like work.
