---
name: blueprint
description: "Use when the user wants an agent to interview them about an idea, build the agreed result, and iterate with fresh independent critics until it meets their chosen match percentage."
---

# Blueprint

## Ask what to build

When invoked on its own, start by asking “What would you like to build, who is it for, and what would a good result let them do?” When the user supplies an idea, read their request, references and relevant project context first. Tailor the opening questions to the decisions still theirs to make.

Group independent questions into a short intake using the harness's native question tool when permitted. Otherwise ask in chat. Cover the intended outcome, must-haves, scope boundaries, and what the critic should inspect. A concrete example of success often settles several questions at once. Ask for the target percentage in the intake once the goal is clear. Suggest **85%** as a starting point, accept any user-selected percentage from 0 to 100, and use 85% if they leave the choice to you. If they give a range, use its lower bound as the stopping threshold unless they specify otherwise.

Wait for actual answers. Follow up only when an unresolved choice could materially change the build. Record the agreed outcome, observable acceptance criteria, must-haves, references, target, and material assumptions in the project's markdown plan file, or `docs/plans/<topic>-blueprint.md`. Deliver plans by path only. On resuming, read this record and the latest user feedback.

## Build the agreed result

Start implementation as soon as the answers settle the brief. Ask for confirmation only if your interpretation still needs a decision. Honor a request to pause, plan only, or explore prototypes first. For requested alternatives, agree on the count, show comparable runnable or viewable versions, and carry the chosen revision into the build when implementation is in scope.

Build the full agreed scope in the project's normal environment. For large separable changes, use local feature worktrees when appropriate and integrate their changes before scoring. For code changes, use a review subagent and a fixer for actionable findings when delegation is available and permitted. Otherwise review and fix locally. Run the relevant checks and exercise the result through its normal entry point. Capture evidence of the **current revision** that a critic can inspect, such as a rendered export, screens at the requested size, or repeatable behavior with observed results.

## Get a fresh verdict and act on it

For every scoring pass, start a **new independent critic** in a clean session with conversation inheritance disabled. Give it the agreed brief and acceptance criteria, original references, and access to the current artifact or its evidence. Keep the target, plan history, builder rationale, previous scores, and fix list out of the handoff. With no external reference, judge against the agreed brief.

Use this assignment for the critic:

> Inspect the deliverable as a user. For each agreed criterion, identify what matches and what falls short, citing the screen, region, output, or reproducible behavior you inspected. Mark each must-have as met, unmet, or unverified. Give one overall match percentage from 0 to 100 and explain how the evidence supports it. Rank the remaining gaps by their effect on the agreed outcome.

Record the revision, score, evidence, and highest-impact gaps in the plan file. Apply the following decision to that revision:

- **Target reached and all must-haves verified:** Stop immediately and deliver the checked revision. A target of 85% is satisfied by an 85% score. Include the target, final score, and any material remaining gap in the handoff.
- **Below target or a must-have is missing:** Fix the highest-impact in-scope gaps, preserve what already works, rerun affected checks, and give the revised artifact to another fresh critic. Continue without asking the user between passes. Any subsequent change affecting the verdict needs a fresh pass.
- **Evidence missing:** Obtain the missing view or behavioral check and submit a fresh pass. An unsupported score cannot end the loop.
- **Progress blocked:** Similar scores alone do not end the loop. Try another concrete fix while one is available. If a dependency, conflicting requirements, or lack of independent review makes the target unverifiable or unreachable, report the specific blocker, last supported score if any, and the smallest decision or input needed. Label self-review explicitly and leave independent verification pending.

The user can change the brief or target, accept a shortfall, or stop at any point. Record that decision and apply it to subsequent work. Keep delivery local unless the user authorizes publication.
