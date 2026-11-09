---
name: autopilot
description: "Run an entire task to completion with no user input. Invoking this skill means the user is already gone — treat every moment after invocation as unattended: decide, implement, verify, and record every decision and assumption in decisions.md, then report when the work is done. Use when the user says they are leaving, will not answer, or wants the agent to handle everything by itself."
---

# Autopilot

Do the work alone. The moment this skill is invoked the user is gone — not about to leave, not
reachable for one last question. Ask nothing, then carry the task to a finished, verified state.
Every choice made in their absence is written down, and the record is what they read when they
come back.

## The one rule

From the instant autopilot starts until the work is complete, **the user is unavailable**. Do not
ask a question, request an approval, offer a choice, wait for a reply, or end a turn in the hope
of input. There is nobody there to answer, and a question asked now strands the work.

Invocation is the signal. Do not open with a clarifying round, a check-in, or a "let me know if
you want something different" — that would assume a user who is not there. If the request is
ambiguous, resolve it from the evidence and record the resolution as a decision.

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

## 1. Read the ground first

Start by reading the request, the supplied references, the project instructions, and enough of the
repository to answer your own questions. Research the environment instead of asking about it.

Then ask yourself what a careful user would have settled before leaving: scope, boundaries,
permissions, anything costly to reverse, anything genuinely ambiguous, any preference only they
hold. Do not put those to them. Settle each one yourself using the rules in step 4, and write it
into `decisions.md` as a decision — with the alternative you rejected and what would change your
mind. Where you truly cannot decide from evidence, record it as an assumption with what would
confirm it, and build the reversible version.

Nothing goes to the harness's question tool. Nothing goes into chat as a question. The interview
that would have happened up front is replaced by the decisions file.

## 2. Take the helm

Announce the work once, briefly — what you read the request as, what you are about to build,
roughly how you will work, and that every decision made in their absence is in `decisions.md`.
Then begin. No ceremony, no repeating it later, no invitation to redirect you.

That message is the only thing the user reads before they return, so it must be accurate. Do not
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

1. **Follow the evidence already in front of you** — the brief, project conventions, existing
   patterns, surrounding code, the skill's own guidance.
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

The user is back or still away — either way their next message is the only question that matters.
Read `decisions.md` and the working tree before doing anything. Treat recorded decisions as
settled unless they say otherwise; treat blockers as the resume list; and, if they have not
returned, continue under the one rule without asking.
