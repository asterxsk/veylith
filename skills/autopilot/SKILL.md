---
name: autopilot
description: "Run an entire task to completion with no further user input. Collect every blocking question up front through the harness's native question tool, then work unattended: decide, implement, verify, and record every decision and assumption in decisions.md, and report it when the work is done. Use when the user says they are leaving, will not answer, or wants the agent to handle everything by itself."
---

# Autopilot

Do the work alone. Ask everything that could block progress before the user leaves, then stop
asking entirely and carry the task to a finished, verified state. Every choice made without the
user is written down, and the record is what they read when they come back.

## The one rule

From the moment autopilot starts until the work is complete, **the user is unavailable**. Do not
ask a question, request an approval, offer a choice, wait for a reply, or end a turn in the hope
of input. There is nobody there to answer, and a question asked now strands the work.

The only exceptions are the actions below, which are never taken unattended. Record each as a
blocker instead of doing it:

- Irreversible or destructive operations with no clean undo — force-pushes, history rewrites,
  deleting branches with unpushed commits, dropping data, bulk overwrites of files the session
  did not create.
- Outward-facing actions — pushing, publishing, deploying, sending mail or messages, creating
  issues, PRs, releases, or remote repositories.
- Installing or registering software, MCP servers, or other skills.
- Spending money, or using an account, credential, or secret the user has not already provided.
- Settings, permissions, or scope changes that go beyond what the request authorised.

If one of those is genuinely required to finish, stop at the last safe point, record the exact
command or action that would unblock it, and leave the work in a clean, running state.

## 1. Preflight: ask everything now

Before going quiet, read the request, the supplied references, the project instructions, and
enough of the repository to answer your own questions. Research the environment instead of asking
about it. Then build the complete list of decisions that would change the work, and settle the
ones you have to ask in a single pass.

Use the harness's native question tool when one is available and permitted — `AskUserQuestion`,
`request_user_input`, or a namespaced equivalent. Batch independent questions into one call, up to
the tool's limit; the user is about to leave, so a second round is expensive.

Ask only for decisions that are:

- **Unauthorised** — scope, boundaries, or permissions the request does not settle.
- **Costly to reverse** — a schema, file layout, public API, or data shape that later work will
  build on.
- **Genuinely ambiguous** — two readings of the request that lead to different products.
- **Consequential and unknowable** — a preference only the user holds.

Everything else is yours to decide. Do not ask about anything you can determine from the code,
the conventions, or a sensible default; do not ask a question you could answer by reading the
project; do not conduct a general interview. Keep it short, and lead with a recommendation the
user can accept in one tap.

If nothing needs asking, skip this step, say so, and start.

## 2. Take the helm

Once the last question is answered — or immediately, if there were none — write the first
`decisions.md` entry and tell the user, once, in a short message, that they can go: what you are
about to build, roughly how you will work, and that every decision made in their absence will be
in `decisions.md`. Then begin. Say it plainly; no ceremony, no repeating it later.

That message is the last thing the user reads before they are gone, so it must be accurate. Do not
promise what you cannot verify, and do not call the work finished in it.

## 3. Keep the decisions file

Maintain `<current working directory>/decisions.md` from the start of the work, not as a
retrospective. Append each entry when the decision is made, so an interrupted run still leaves a
truthful record. Create it if absent; if one exists from earlier work, append a new dated section
rather than overwriting unrelated records.

Use one block per decision:

```markdown
### D7 — SQLite for local history
- **Because:** the proxy is single-user and already ships no server; a database file keeps
  `rtk gain` working offline.
- **Alternatives:** JSONL (poor at filtered queries), Postgres (needs a service to install).
- **Reversibility:** cheap — the store sits behind `HistoryStore`.
- **Risk if wrong:** query-heavy use feels slow later.
```

Also record **assumptions** separately from decisions — anything believed true but not verified,
with what would confirm it — and **blockers** — anything left undone under the rule above, with
the exact action or command that would resume it.

The file is a record, not a diary: decisions, assumptions, blockers, and the final state. No
tool-by-tool narrative. Keep entries in the order they were made, and end it with a close-out
section (step 6).

## 4. Decide like the user would

When a choice appears and nobody is there to make it:

1. **Follow the evidence already in front of you** — the brief, earlier answers, project
   conventions, existing patterns, surrounding code.
2. **Prefer the smaller scope.** Do the part that was asked, and leave the adjacent improvement
   written down rather than done.
3. **Prefer the reversible move.** A choice that can be undone by editing one file beats one that
   cannot.
4. **Prefer the platform and what is installed** over a new dependency. A dependency is a
   liability, and installing one is not authorised while the user is away.
5. **State the cost** — of the option chosen and of what was skipped.

Never use "the user wasn't here" as a reason to skip verification, guess silently, or leave the
work half-finished. Make the decision, write it down, and continue. Never silently widen scope to
fill the silence.

## 5. Work to done

Treat the task as a scheduled job that must finish cleanly: plan, implement, verify, and leave the
result consumable with no further input.

- **Plan quietly.** Keep working state in the plan file or `decisions.md`; do not emit a plan and
  pause for approval.
- **Implement fully** for the authorised scope, including the states, errors, and edge cases the
  brief implies. Use the collection's other skills when they fit — `lucent` for interface work,
  `poise` for a finishing pass, `office` for real documents and media — without installing
  anything new.
- **Review your own work** with a review subagent when the harness supports it, then fix what it
  finds. Where delegation is unavailable, do the review pass directly and say so in the record.
- **Verify.** Run the project's tests, type checks, lint, or build, and check behaviour where it
  can be run. Run the checks that gate the project's own workflow; skip only what genuinely
  cannot run unattended, and say what was skipped.
- **Recover instead of asking.** If a check fails, fix it. If a tool is missing or unavailable,
  take the narrowest fallback that needs no new install, record the limitation, and keep going.
- **Commit locally.** Local commits on a working branch are fine and expected. Pushing, opening a
  PR, and anything else outward-facing stays undone and becomes a blocker entry.

Do not stop because the work is long, because a choice was hard, or because a turn ended. Resume
from `decisions.md` and the working tree and continue.

## 6. Close out

When the work is done, update `decisions.md` with a close-out section and then report it in chat:

- **What shipped** — the outcome, in the user's terms, with the paths, branches, and commits.
- **Decisions and assumptions to review** — the entries that carry the most consequence, or the
  most guesswork, so the user can overturn them first.
- **What is blocked** — anything left undone under the one rule, with the exact action needed.
- **Verification** — the checks run and their results, and anything not run and why.
- **What to do next** — the smallest set of steps that finishes the job.

Be honest about partial results. A verified partial implementation reported plainly is worth more
than an unverified "done". Do not claim a check passed that did not run, and do not present a
decision as settled that the user never made.

## If the work is later resumed

Read `decisions.md` and the working tree before doing anything. Treat recorded decisions as
settled unless the user says otherwise; treat blockers as the resume list; and, if the user is
still away, continue under the one rule without asking.
