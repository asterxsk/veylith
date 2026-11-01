---
name: decision-review
description: "Review every decision and assumption recorded in decisions.md against what was actually built, and ask the user, one at a time, whether to keep each one or change it. Applies the changes they approve, updates the record, and reports the result. Use when returning to work an agent finished unattended, or whenever decisions.md needs sign-off."
---

# Decision Review

Autopilot leaves a list of choices made without the user. This skill turns that list into a
conversation: it checks what each choice actually became, asks the user to keep or change it, and
applies the answers.

Review only. This skill does not reopen the whole task, redesign the work it describes, or act on
anything the user has not answered.

## 1. Find the record

Read `decisions.md` in the current working directory. If a path was supplied with the invocation,
use that. If it is not at the top level, check the plan directory and the repository root before
concluding it is missing.

Parse it into three lists — **decisions**, **assumptions**, and **blockers** — in the order they
were recorded, keeping each entry's rationale, alternatives, reversibility, and recorded risk.

If the file does not exist, or contains no decisions and no assumptions:

> There were no decisions to review.

Say exactly that — one line, no substitute questions, no invented trade-offs. Blockers alone are
not decisions: mention them only if the file holds nothing else, and then stop. Do not manufacture
a review from a clean, opinion-free result.

## 2. Check the record against the work

Do not take the file at its word. For each entry, look at the implementation and establish what is
actually there:

- **Applied** — the decision is in the code or artifact as recorded.
- **Drifted** — something close was built, but not what the entry describes. Work out what and why.
- **Not applied** — the decision was recorded but never implemented, or was reverted.
- **Unverifiable** — the evidence is gone, or verifying costs more than the decision is worth.
  Say so; do not guess.

Also look for changes the work made that are **not in the record at all** — a dependency added, a
file reorganised, a public shape changed, a scope quietly widened. Those are the most important
items, because nobody has seen them before. Add them as review items with the decision number they
should have had.

Quote the concrete evidence for any Drifted or Not applied finding — a path, a symbol, a diff, a
line. A claim without evidence is not a finding.

## 3. Ask, one entry at a time

Use the harness's native question tool when one is available and permitted — `AskUserQuestion`,
`request_user_input`, or a namespaced equivalent. Otherwise ask in chat, keeping the same
boundaries.

Ask per entry, not per file. For each, state in one or two lines what was decided, what was built,
and what changing it would involve. Then offer:

- **Keep as is** — the decision stands and the entry is closed. Recommended when it is applied,
  verified, and reversible; say why in the option description.
- **Change it** — the user supplies the new intent. Ask a focused follow-up for what they want
  instead, then implement it in step 4.
- **Revert it** — where a clean undo exists, return to the prior state instead of choosing again.
  Include this only when it is genuinely available.

Order by consequence: decisions that are hard to reverse, public, or unrecorded-but-changed first;
the cheap, internal, clearly correct ones last. Keep assumptions as their own items — the question
is whether the user confirms the belief, not whether to keep a decision — and surface each
assumption with what would confirm it.

Batch up to the tool's limit, and no more than four at a time; the user reads carefully, so a wall
of questions gets tapped through without thought. Never put an entry and its contingency in the
same batch. If there are many entries, run several rounds, and say how many rounds remain.

Do not prescribe an answer, pre-select anything, or treat silence, a timeout, or an unrelated
message as "keep". A reply is an answer only when it addresses the question.

## 4. Apply the answers

Make the approved changes in the working tree, following the project's conventions and the same
care the original work got. Keep each change inside the scope the user agreed to — a decision
about storage does not authorise a redesign of the interface around it.

Then:

1. Re-run the checks that cover the changes — the project's tests, type checks, lint, or build —
   and the specific verification the original work used.
2. Fix what fails. If a fix needs a decision the user has not made, ask about that one entry
   rather than guessing.
3. Confirm the result matches what they asked for, not just that the commands exited zero.

If the user keeps everything, change nothing and run no tests beyond what confirms the review's
findings were accurate. Say so plainly: a review that changes nothing is a normal, successful
outcome.

Leave anything irreversible or outward-facing — pushes, publishes, deploys, installs, deletions
without a clean undo — undone, and tell the user the exact action that would finish it.

## 5. Update the record

Append a review section to `decisions.md`; do not rewrite or delete the original entries. Note the
date, then for each entry: the verdict (kept, changed, reverted, confirmed, rejected), the user's
reason when they gave one, and the resulting change with paths. Mark assumption entries as
confirmed or disproved so the next session can tell belief from fact.

Keep the file truthful as a record of what happened, not a tidy story of what was wanted.

## 6. Report

Close with a short chat summary, not the file's contents:

- How many entries were reviewed, and the outcome for each in one line.
- What changed, with paths, and what was verified.
- What remains open, including any entry the user deferred and any blocker still standing.

If there were no decisions to begin with, that one line from step 1 is the whole report.
