---
name: blueprint
description: "Turn an idea into an agreed brief, user-chosen prototypes, and an implementation. Use for collaborative discovery, brainstorming with probing questions, comparing design directions, and refining a chosen prototype before building. Ask through the harness's native question tool and begin implementation when the user says to proceed. Not needed for a direct fix or a polish pass with settled requirements."
---

# Blueprint

Understand the intent, question the assumptions, make the alternatives tangible, and build the
chosen result. Combine collaborative brainstorming, a dependency-aware interview, and runnable
prototypes in one continuous workflow. The user controls how many directions to explore, how
long to refine them, and when implementation begins.

This skill is self-contained. It does not require the `brainstorming`, `grilling`, or `prototype`
skills to be installed or invoked.

## Keep the work in a file

Use the project's established markdown plan file. If there is none, create
`docs/plans/<topic>-blueprint.md`. Keep the current brief, settled decisions, material open
questions and their dependencies, prototype count and links, selected revision, and next step
there. Separate user decisions, verified facts, proposals, and assumptions. Update the file as
answers arrive; do not overwrite unrelated plans.

Plans, specifications, and other long documents belong in files. Deliver a document with just
its path in chat; use the native question tool for the question about it. Do not paste the
document or restate its contents in chat. Short progress updates and prototype links are fine.

On resuming, read this record and the latest user messages. Continue from the earliest
unresolved decision rather than restarting the interview or discarding an accepted design.

## Ask through the harness

Inspect the tools actually exposed by the current harness and use its native question/input
tool whenever it is available **and permitted in the current mode**. For example, some harnesses
expose `AskUserQuestion`, `request_user_input`, or `request_user_input_async`, possibly behind a
namespace. Names and schemas vary: use the available tool's documented arguments and limits.
Do not call a guessed tool name or change modes merely to enable a question tool.

- Prefer one focused question when its answer determines what to ask next. Batch a small set
  of independent questions when the tool supports it; never put a prerequisite and its dependent
  decision in the same batch.
- Offer concise, meaningful choices and a recommendation where useful. Preserve free-text
  answers and custom counts; do not constrain the user to the suggested choices.
- A tool returning is not necessarily an answer. For asynchronous tools, keep the question
  pending until an actual user reply arrives. Continue independent research or artifact work,
  then yield if the next step depends on the reply. Do not duplicate pending questions or treat
  a timeout, a preselected option, or unrelated input as the user's decision.
- Retain unanswered parts of a batch. A newer explicit decision supersedes an older answer;
  reconcile delayed replies against the current brief before acting on them.
- If no usable native question tool exists, ask a short question in chat and wait. Explain the
  tool limitation once. The fallback must preserve the same decision boundaries.

## 1. Understand and challenge

Read the request, supplied references, relevant project instructions, existing artifacts, and
enough of the project to ground the discussion. Discover facts from the environment yourself;
use bounded research or exploration agents when useful. Ask the user for their goals and
decisions, not facts you can look up. Preserve explicit requirements and earlier answers.

Build a working decision tree. Ask only the questions whose prerequisites are settled, then
recompute that frontier after each answer. Prioritize decisions that would change the product,
scope, prototype, or implementation. Probe contradictions and consequential assumptions with
concrete examples and trade-offs; explain why the answer matters. Be candid without making the
interview adversarial.

Establish, to the depth this project needs:

- Who it serves, the problem or outcome, and what success looks like.
- The main user journey, required capabilities, and explicit non-goals.
- Platform, existing stack, constraints, available data, and real versus simulated behavior.
- Visual references, desired feeling, and elements that must be preserved.
- Important states, edge cases, and unresolved risks that could change the design.

Do not turn this into an exhaustive questionnaire. Reuse what is already settled, offer a
reasoned recommendation when the user is unsure, and record delegated choices as such. For a
large request, settle a useful first slice before refining distant subsystems.

Write the brief in the plan file and use the native tool to invite confirmation or correction.
Incorporate corrections before treating it as shared understanding. Existing explicit agreement
counts; do not demand another approval of the same brief. Discovery is ready when both parties
can recognize the intended outcome, scope, and constraints, and remaining unknowns will not
make the first prototypes answer the wrong question.

## 2. Ask how many prototypes

Once the brief is understood, ask through the native tool: **How many distinct prototypes would
you like to compare?** Suggested choices such as 1, 2, or 3 may explain the exploration effort,
but the user's count wins. Do not silently default to three or impose a fixed maximum. If a
large count needs batching, discuss that delivery trade-off without changing the count.

Honor a count already supplied; do not ask it again. Accept later changes and update the plan.
The count means initial alternative directions, not the number of screens or subsequent tweak
rounds. If the intended unit is ambiguous enough to change the work, clarify it.

If the user explicitly wants to skip prototypes and implement, follow that instruction using
the settled brief. Resolve only missing information that materially blocks implementation.

## 3. Build comparable prototypes

Prototype code is authorized by choosing to explore prototypes. Production implementation is a
separate stage. Build actual viewable or runnable artifacts, not just descriptions of options.
Use the smallest surface that answers the design question, with consistent representative
content and realistic density so the alternatives can be compared fairly.

For **visual designs**, make the requested number of meaningfully different directions: vary
layout, hierarchy, navigation, or interaction, rather than recoloring the same composition.
Respect supplied references and fixed requirements across every direction. One requested
prototype is a valid starting point; do not generate extra alternatives by habit.

For **logic or interaction questions**, make the relevant state visible, provide free play and
repeatable guided scenarios, and include the awkward transitions the interview uncovered. A
self-contained HTML demo is useful when it avoids setup. Choose the project's native format
when that is necessary to judge the behavior accurately.

Keep prototypes easy to run and clearly marked. In an existing app, prefer an isolated preview
in its real surrounding context, following its routing conventions. A development-only
`?variant=` switcher can make options directly addressable. Preserve normal app behavior outside
the preview. In a new project, use a small scratch prototype rather than scaffolding the full
product to explore a layout. Reuse existing tools; do not install a new stack merely to show
alternatives.

Use local fixtures and in-memory state for exploratory mutations. Label simulated behavior;
do not connect buttons to live writes or external services just to make a prototype feel real.
Give each direction a stable name, link, and revision. Put comparison notes and meaningful
trade-offs in the plan file or comparison artifact, keeping them separate from the product UI.

Open or render each prototype using the environment's supported preview tools. Check that it
runs, its comparison controls work, and the key interaction or layout can be judged at the
intended size. Fix observed problems before presenting it. Report a preview limitation
accurately if one exists; do not claim to have inspected an artifact you could not open.

## 4. Select and refine

Show accessible prototype links or the comparison surface. Use the native question tool to ask
which direction to pursue, what to combine, or what needs changing. A user may choose a whole
direction, combine named parts, reject every option, or ask for more exploration.

Record the selection precisely, including any combination and revision. Apply requested tweaks,
preview the result, and invite the next decision. Preserve accepted choices unless the user's
feedback changes them; investigate newly exposed assumptions through the same interview loop.
There is no fixed number of refinement rounds and no requirement to use every offered round.
The user can stop tweaking or request implementation at any point.

Treat a selected design as the working candidate until the user's next instruction establishes
whether to refine it or build it. Selecting a direction does not by itself request production
implementation:

| User reply | Next action |
|---|---|
| "B" or "use the second one" | Record that candidate; ask about refinements or proceeding. |
| "B's layout with A's header" | Build and preview the combined prototype. |
| "Make the navigation smaller" | Revise the current prototype and show the result. |
| "This is final, implement it" | Implement the selected revision now. |
| "B, then build it with the smaller header" | Carry that final tweak into implementation; no extra approval round. |
| "Skip prototypes; build from the brief" | Implement from the agreed brief. |

Read short replies in the context of the question actually asked. "Yes" in response to "Start
implementation?" is authorization; "looks good" in response to a visual check is design
feedback. When the referent of "build it" is unclear, resolve that ambiguity rather than
guessing which candidate or scope the user meant.

If the user selects a candidate but gives no next step, ask through the native tool whether
they want tweaks, more exploration, or implementation. Wait for the answer. Do not start after
a timeout, and do not ask again once the user has already said to proceed.

## 5. Continue into implementation

When the user says to proceed, honor it in the same workflow. Do not end with an offer to build,
require a special phrase, wait for an arbitrary number of rounds, or add a separate approval
ladder. An early implementation request can bypass prototypes; establish only the brief and
choices necessary to carry it out. A request to pause or remain prototype-only controls instead.

Update the plan with the selected design or brief, final adjustments, acceptance criteria,
material assumptions, implementation steps, and the scope of the user's proceed instruction.
Then implement using the repository's normal conventions. Use available, relevant execution
skills: `lucent` can guide interface work and `poise` a finishing pass. Locate them through the
skill catalog; neither is required, and this workflow does not authorize installing skills.

Treat the prototype as evidence of the chosen design, not as production-ready code. Replace
shortcuts with the necessary data handling, accessibility, error states, and integration for
the authorized scope. Preserve a UI-only or local-only boundary when that is the brief.
Verify the real implementation against the selected revision and acceptance criteria, including
appropriate functional checks and visual inspection when applicable.

Retire prototype switches and unused exploratory code from the shipped path. Preserve useful
design evidence in the plan or an existing archive convention; do not automatically create
branches, commits, issues, deployments, or external projects. Report the implemented artifact
and verification concisely, respecting the user's file-only delivery preference for documents.
