---
name: blueprint
description: "Turn an idea into an agreed brief, user-chosen prototypes, and an implementation. Use for collaborative discovery, brainstorming with probing questions in one batched intake, comparing design directions, and refining a chosen prototype before building. Ask through the harness's native question tool, work independently once intent is confirmed, and use fresh zero-context critics to score the result against the original reference until it reaches the closeness target the user chose (50-90%). Not needed for a direct fix or a polish pass with settled requirements."
---

# Blueprint

Understand the intent, question the assumptions in one batched intake, make the alternatives
tangible, and build the chosen result. Combine collaborative brainstorming, a dependency-aware
interview, and runnable prototypes in one continuous workflow. The user controls how many
directions to explore, how close to their reference the result must become, how long to refine,
and when implementation begins. Ask the whole question set up front, then work independently
until the result clears the chosen closeness target.

This skill is self-contained. It does not require the `brainstorming`, `grilling`, or `prototype`
skills to be installed or invoked.

## Keep the work in a file

Use the project's established markdown plan file. If there is none, create
`docs/plans/<topic>-blueprint.md`. Keep the current brief, settled decisions, material open
questions and their dependencies, prototype count and links, selected revision, the closeness
target with each critic pass's score and gaps, and next step there. Separate user decisions,
verified facts, proposals, and assumptions. Update the file as answers arrive; do not overwrite
unrelated plans.

Plans, specifications, and other long documents belong in files. Deliver a document with just
its path in chat; use the native question tool for the question about it. Do not paste the
document or restate its contents in chat. Short progress updates, prototype links, and critic
scores are fine.

On resuming, read this record and the latest user messages. Continue from the earliest
unresolved decision, the current critic score against the target, or the last accepted design,
rather than restarting the intake or discarding an accepted design.

## Ask through the harness

Inspect the tools actually exposed by the current harness and use its native question/input
tool whenever it is available **and permitted in the current mode**. For example, some harnesses
expose `AskUserQuestion`, `request_user_input`, or `request_user_input_async`, possibly behind a
namespace. Names and schemas vary: use the available tool's documented arguments and limits.
Do not call a guessed tool name or change modes merely to enable a question tool.

- **Batch the whole intake, not one question at a time.** Once the environment is read, ask every
  question the request needs in as few calls as the tool allows: fill its documented maximum per
  call with independent questions and chain further calls in the same turn rather than waiting
  for an answer between each one. Never drip a decision that could have been part of the first
  pass.
- A prerequisite and the decisions that depend on it may share a pass when the dependent question
  is phrased so either answer is usable ("if X, then..."). When a dependency truly cannot be
  expressed that way, take the recommended answer as a recorded assumption and continue, rather
  than holding the rest of the pass.
- After the intake, work independently. Re-enter the tool only at a decision that is genuinely
  the user's: the brief's confirmation, prototype selection, the closeness target if still
  unset, and permission to implement or push. Do not ask mid-build questions the brief already
  answers, and do not re-ask a decision the user has made.
- Offer concise, meaningful choices and a recommendation where useful. Preserve free-text
  answers, custom counts, and any percentage the user types; do not constrain the user to the
  suggested choices.
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

Build the decision tree first, privately, then ask it all at once: enumerate every question the
request raises, group the independent ones, and put them to the user in one batched intake using
the tool's maximum per call. Prioritize decisions that would change the product, scope,
prototype, or implementation. Probe contradictions and consequential assumptions with concrete
examples and trade-offs; explain why the answer matters. Be candid without making the interview
adversarial.

Recurse only where it pays: after the batch, ask a follow-up solely when an unanswered point
genuinely blocks the next step, or when a contradiction in the answers needs resolving. Take
recommendations as recorded assumptions everywhere else, and prefer an assumption the user can
correct over another round of questions.

Establish, to the depth this project needs:

- Who it serves, the problem or outcome, and what success looks like.
- The main user journey, required capabilities, and explicit non-goals.
- Platform, existing stack, constraints, available data, and real versus simulated behavior.
- Visual references, desired feeling, and elements that must be preserved.
- Important states, edge cases, and unresolved risks that could change the design.
- How many prototypes to compare, when they want any.
- How close to the reference the finished result must be (see stage 5), when a reference exists.

Ask these in the opening batch, not one per visit. Do not turn this into an exhaustive
questionnaire either: a question the code, the references, or the environment can answer is not
a question for the user. Reuse what is already settled, offer a reasoned recommendation when the
user is unsure, and record delegated choices as such. For a large request, settle a useful first
slice in the brief rather than interrogating every distant subsystem.

Write the brief in the plan file and use the native tool to invite confirmation or correction.
Incorporate corrections before treating it as shared understanding. Existing explicit agreement
counts; do not demand another approval of the same brief. Discovery is ready when both parties
can recognize the intended outcome, scope, and constraints, and remaining unknowns will not
make the first prototypes answer the wrong question.

## 2. Ask how many prototypes

Once the brief is understood, ask through the native tool: **How many distinct prototypes would
you like to compare?** It belongs in the opening intake when the brief already makes the question
answerable; ask it here only when it was not. Suggested choices such as 1, 2, or 3 may explain the
exploration effort, but the user's count wins. Do not silently default to three or impose a fixed
maximum. If a large count needs batching, discuss that delivery trade-off without changing the
count.

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

## 5. Score against the reference until the target is met

The user's target is how close the result must come to the reference they gave: their original
prompt, images, URLs, videos, or an existing product — anywhere from **50% to 90%**. Ask for it in
the opening intake; if it was not answerable then, ask it once the reference is settled. Offer
presets such as 50 / 70 / 85 / 90 with a recommendation, and accept any number in range the user
types; never push them above 90 or quietly raise it. Default to 80% only when they delegate the
choice, and record that as delegated. When the work has no reference material, compare against the
confirmed brief and acceptance criteria instead, and say so: the percentage then means fidelity to
the brief, not resemblance to a reference.

Run a pass whenever a coherent chunk of features works — after the first slice of prototypes or
implementation, and again after each substantial chunk — not only at the very end.

Each pass goes to a **fresh critic with zero context from the build**:

- Give it only the reference material, the confirmed brief with acceptance criteria, and the
  current artifact as a user would experience it: the running app, screenshots at the intended
  size and the same viewport, an exported file, or a recording for motion.
- Withhold the plan file's proposals, the builder's rationale, earlier critic reports, the
  current score, and this conversation. The critic judges from the reference alone; anything
  leaked from the build anchors it and inflates the number.
- Require structure: per-dimension closeness (composition and layout, type, color and surface,
  imagery, motion, interaction and states, content fidelity), one overall percentage, and gaps
  ranked most-visible first, each with evidence naming a region, screen, element, or behavior.
- Reject inflation. A dimension that is visibly different does not score high, and a gap without
  a location is not evidence. If a report arrives with no evidence, re-run the pass with a new
  critic rather than trusting the number.

Then compare against the target:

- **At or above target** — record the score and stop looping. Move on to selection or to reviews,
  tests, and verification.
- **Below target** — fix the highest-ranked gaps first, then start a **new** pass with a different
  fresh critic. Never hand the next critic the previous report or tell it what was fixed.
- **Plateau** — if two consecutive passes score within a few points of each other, stop and say
  so. Report the score, the stubborn gaps, and what would be needed to close them, instead of
  grinding through passes that no longer move the number.
- **Ceiling** — stop also when the remaining gaps are deliberate (a target below 100% means some
  things are intentionally not matched), out of scope, or blocked by the brief.

Cap the loop at a handful of passes per chunk and state in the report how many ran. The user can
lower the target, accept the current score, or stop the loop at any point; honoring that ends the
loop even below target. Reference agreement is not a substitute for the user's own judgment — if
they look at the result and disagree with the critic, they win.

Record in the plan: the target, the score and top gaps from each pass, the fixes applied, and any
accepted shortfall. Below 100%, say plainly which aspects were deliberately left different.

Use the harness's supported subagent/delegation mechanism to create each fresh critic, and keep its
prompt free of build context. If none is available or permitted, say so and run the pass yourself
from a bare statement of the reference and acceptance criteria, judging the artifact as if you had
not built it; disclose that limitation along with the score, since a self-review cannot be treated
as independent evidence.

## 6. Continue into implementation

When the user says to proceed, honor it in the same workflow. Do not end with an offer to build,
require a special phrase, wait for an arbitrary number of rounds, or add a separate approval
ladder. An early implementation request can bypass prototypes; establish only the brief and
choices necessary to carry it out. A request to pause or remain prototype-only controls instead.

Update the plan with the selected design or brief, final adjustments, acceptance criteria,
material assumptions, implementation steps, and the scope of the user's proceed instruction.

### Local Git and worktrees

Before changing implementation files, determine whether the project is a Git repository. If it
is, use its local Git checkout and conventions; do not create or use a GitHub remote merely to
organize the work. If it is not a Git repository, ask the user through the native question tool
whether to initialize local Git, and wait for an affirmative answer before using branches or
worktrees. If they decline, continue without worktrees and disclose that limitation.

For a sufficiently large or risky implementation, split the authorized scope into at most one
or two coherent, independently reviewable features. Delegate each selected feature to a
subagent in its own local Git worktree, with a clear boundary, acceptance criteria, and
instructions not to modify the main checkout. Do not force worktrees onto a small or tightly
coupled change. Inspect each worktree's changes, resolve conflicts or disagreements, and merge
the completed feature branches into the main repository locally before treating implementation
as complete. Keep all branches, commits, reviews, fixes, merges, and verification local until
the final merged tree is ready.

Then implement using the repository's normal conventions. Use available, relevant execution
skills: `lucent` can guide interface work and `poise` a finishing pass. Locate them through the
skill catalog; neither is required, and this workflow does not authorize installing skills.

Treat the prototype as evidence of the chosen design, not as production-ready code. Replace
shortcuts with the necessary data handling, accessibility, error states, and integration for
the authorized scope. Preserve a UI-only or local-only boundary when that is the brief.
After implementation, defer time-consuming tests and test writing until the review and fix
sequence is complete:

1. Delegate a code review to a review subagent for each worktree or feature boundary, or for the
   main checkout when no worktree was warranted. Give it the implementation scope and acceptance
   criteria, and ask it to report actionable issues with evidence.
2. Once the reviews return, delegate fixer subagents in the affected worktrees to address the
   surfaced issues within the authorized scope. Provide the review findings and implementation
   context. Inspect their changes and resolve any remaining issues or disagreements.
3. Run one confirmation pass through stage 5 at the same target, since review fixes can change
   what the build looks like. Keep looping there while the score is below target, as stage 5
   describes, including its plateau and ceiling stops.
4. Write the tests appropriate to the completed changes and run the required checks. Verify the
   implementation against the selected revision and acceptance criteria, including functional
   checks and visual inspection when applicable. Report any checks not performed.
5. After reviews, fixes, critic passes, tests, and verification pass, merge the finished local
   branches into the main repository. Recheck the merged tree and do not ask about pushing until
   this local merge is complete and the merged result is clean.
6. Only then ask the user, through the native question tool, whether they want the full merged
   tree pushed to GitHub. Never push, publish, or create a GitHub remote without that explicit
   approval. If the user declines, leave the verified merged tree local.

Use the harness's supported delegation mechanism when available and permitted. If delegation is
unavailable or prohibited, perform the review and fixes directly, disclose the limitation, and
then proceed to the critic pass and tests. Do not skip required verification or claim that a
review guarantees all issues were found. This sequence does not replace the prototype preview
checks or the critic passes above.

Retire prototype switches and unused exploratory code from the shipped path. Preserve useful
design evidence in the plan or an existing archive convention. Do not create issues, deployments,
or external projects as part of this workflow. Local branches, worktrees, commits, reviews, and
merges are expected when the local Git policy above calls for them. Report the implemented
artifact and verification concisely, respecting the user's file-only delivery preference for
documents.
