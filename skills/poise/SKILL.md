---
name: poise
description: "Composure and control. Make the output look confident without trying too hard to look sophisticated - remove generic AI-looking visual habits and polish how websites, interfaces, PDFs, posters, decks, and videos feel. Use for design cleanup, excessive dividers or uppercase monospace, uneven spacing, cluttered graphics, and overworked motion. Works alone or alongside ouu-shiit. Not for filesystem cleanup or AI-authorship detection."
---

# Poise

Composure and control: the output should look confident without trying too hard to look sophisticated. Make the artifact feel considered. Give the eye somewhere to land, the content room to breathe, and the important moment enough space to be remembered. Treat the feeling it leaves behind as a design requirement: ease, confidence, curiosity, warmth, energy, or whatever the brief calls for.

"AI-looking" is shorthand for repetitive design habits, not a claim about who made something. Diagnose what is visibly weak. Preserve the user's references, brand, expressive character, and meaningful complexity.

## Work with what is there

Inspect the actual artifact before changing it. Identify its medium, audience, intended viewing size, main message, and existing visual direction. Infer the desired feeling from the brief and references; do not turn an ordinary polish request into a questionnaire.

Use the editable source and the appropriate medium's tools. A screenshot can reveal problems but cannot establish that the source or final export has been fixed. Preserve required wording, data, citations, functionality, and the user's scope. If only a flattened artifact is available, state the editing limit and use the available editing workflow; do not silently reconstruct or paraphrase important content.

For medium-specific inspection and verification, read the relevant section of [references/mediums.md](references/mediums.md). For the concrete poster comparison behind this skill, read [references/poster-calibration.md](references/poster-calibration.md) when choosing a main graphic or pruning technical density. These references are self-contained; the original poster files are not required.

## Pairing with ouu-shiit

Use this division of responsibility when both skills are active:

- The brief, brand, and chosen design direction establish the character.
- `poise` settles hierarchy, spacing, typography, visual explanation, and the amount of competing detail.
- `ouu-shiit` implements effects and motion that have a clear job, using its medium-specific contracts.
- `poise` checks the composed result, including what the effects do to legibility, pace, and attention.

Apply the fundamentals before adding effects, then make a finishing pass after integration. Preserve an expressive effect that helps the intended feeling or explains the subject. Simplify effects that compete with the message; do not flatten every lively design into a quiet template.

Locate `ouu-shiit` through the available skill catalog when it is invoked; do not assume a machine-specific path. If it is unavailable, this skill still works on its own. Do not install dependencies or pull in effect libraries just to perform cleanup.

When paired, use `ouu-shiit`'s editorial-label convention as a default: sentence case, untracked, serif italic. Reconcile it with the established visual direction and the medium's readability needs; these take precedence over a blanket label treatment. Do not retrofit serif italics into suitable interface controls, moving labels, or video captions merely for consistency. Keep acronyms and identifiers correctly cased. Its optional short rule is permission, not a requirement to add another divider. When working alone, use quiet labels that fit the established type system. Explicit user and brand requirements take precedence throughout.

## Make the changes that matter

Work from composition to detail. Find the strongest focal point and remove what competes with it. Fix the highest-impact issues in a coherent pass, then inspect the result at its real size. A cleanup request normally calls for edits, not just a list of criticisms; honor an explicit audit-only request.

### Let spacing do the separating

Remove repeated horizontal rules, boxed sections, nested panels, label pills, and borders whose only job is to announce another block. Group related material through proximity, alignment, heading weight, and whitespace. Keep boundaries that explain something: table grouping, input affordances, diagram connections, or a deliberate major section break.

Do not replace every deleted line with a shadow or tinted card. Removing a divider also changes the perceived grouping; adjust the surrounding space so the structure remains obvious.

### Balance the top and bottom

Start with matching top and bottom padding for comparable containers and balanced outer margins for pages, posters, and frames. Inspect the visible content bounds, not just the CSS box or text anchor. A heading's ascent, a footer, a caption, an icon's viewBox, and a sticky header all affect the space the viewer perceives.

Fix accidental top-hugging: tight space above the content paired with a large dead area below it. Reposition or redistribute the composition as a whole; do not pad the title alone and push the footer off the page. Preserve deliberate asymmetry when it supports the direction, with a visible optical reason for unequal margins.

Use a small, consistent spacing rhythm. Keep a heading closer to its own paragraph than to the previous section. Give diagrams, captions, controls, and text enough clearance. Judge balance again after fonts load, text wraps, or captions appear.

### Give type a purpose

Prune decorative uppercase monospace, wide tracking, faux terminal labels, tiny metadata, and repeated eyebrows. Use a clear hierarchy with ordinary sentence-case headings and labels where the content allows. Remove redundant labels instead of restyling all of them.

Reserve monospace for code, identifiers, aligned technical values, or a specifically justified brand treatment. A small useful mono accent can stay. Do not lowercase `CPU`, `IRQ`, `ISR`, `USB`, units, commands, product names, or identifiers to satisfy a casing rule. Edit display strings deliberately; avoid global case transforms across content.

Reduce technical prose and code density before shrinking the font or artificially condensing it. Keep the operation or idea the audience needs. Preserve the semantics of real code; identify conceptual pseudocode as such. Required verbatim content gets a better layout, not an unauthorized rewrite.

Watch line endings, awkward wraps, body leading, weak contrast, and captions that only work when zoomed in. Quiet text must remain readable. A decorative font switch is not a substitute for hierarchy.

### Choose the graphic by the question

Decide what the viewer needs to understand before choosing the visual:

| The content asks | Prefer |
| --- | --- |
| What is this object or action? | A clear SVG icon or simple illustration with a useful label |
| How does it move or work? | A small set of recognizable objects connected by meaningful arrows |
| What happens next? | Ordered stages, a flow, or a clearly labeled conceptual timeline |
| How much, how often, or which is larger? | A readable chart with supported values, units, and honest scales |
| How do alternatives differ? | A concise comparison or table with aligned entries |

Replace ornamental micrographs, fake waveforms, and dense technical tangles with the simplest visual that still explains the point. For conceptual subjects, prefer recognizable SVG forms with consistent stroke, optical weight, and detail over an unreadable miniature schematic. Use the existing icon family when it fits. Do not put an icon beside every sentence or rely on an unfamiliar icon without a label.

For a real data chart, simplify or enlarge the chart while retaining its evidence. Preserve values, units, uncertainty, sources, and the comparison the audience needs. A conceptual diagram is not an equivalent replacement for measured results. If a claim is unsupported, identify the issue and stay within the authorized content scope before removing or revising it. Never invent cleaner numbers or imply that equal-length stages represent equal durations. Label conceptual graphics when scale or timing could be misunderstood.

Give the main graphic enough area to be understood without decoding tiny annotations. Align labels with their objects; keep arrow endpoints unambiguous. Color should direct attention or encode a consistent meaning. Detail should reward looking closer without being necessary to understand the first read.

### Polish what the audience feels

Check the order of attention: first the main idea, then its explanation, then the supporting detail. Move implementation trivia out of prominent positions when the viewer gains nothing from it. Preserve qualifications near the claims they limit.

Use concrete copy and natural phrasing. Prune redundant kickers, inflated claims, filler captions, and repeated conclusions when rewriting is authorized. Keep useful specificity and the author's voice.

Attend to small things that create confidence: aligned baselines, consistent icon strokes, punctuation, neat wraps, predictable controls, comfortable targets, and transitions that settle without a twitch. Keep hover, focus, loading, empty, and error states understandable where they exist. Never remove affordances or accessible labels to make a screen look cleaner.

For motion, let the viewer arrive, understand, and absorb before the next beat. Remove habitual stagger on every word, perpetual drifting, decorative counters, gratuitous glitches, and transitions that restart the viewer's attention without helping the story. Preserve purposeful spectacle. A still moment can be the most effective part of a sequence.

## Verify the feeling in the actual output

Compare before and after at the same size. Check both the whole composition and the details that changed. Test the artifact in the medium the audience receives: rendered page, exported PDF, poster at intended reading scale, or video at normal playback speed.

Ask:

- Is the message easier to grasp, with one clear place to begin?
- Do the top and bottom feel balanced, and do groups breathe?
- Are dividers, labels, mono text, and effects doing useful work?
- Can the graphic be understood at normal size without losing evidence?
- Does the result still have the intended character and feeling?
- Have content, navigation, accessibility, and important qualifications survived?

Fix observed problems and recheck the affected output. Stop when the visible issues are resolved; do not invent more work to reach a decorative ideal. If preview or export verification is unavailable, state the specific limit instead of claiming visual validation.

Deliver the requested artifact with a brief note of the meaningful changes and what was verified, following the user's reporting preferences. For an audit, tie each finding to a visible location and a concrete correction. Avoid an invented "AI score" or promises of undetectable authorship.
