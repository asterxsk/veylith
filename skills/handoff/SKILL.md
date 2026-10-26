---
name: handoff
description: "Write a concise HANDOFF.md in the current working directory so another session can resume the current conversation's work. Summarize every user message, work completed, changed files, verification, and remaining steps; replace the previous handoff instead of appending."
---

# Handoff

Write `<current working directory>/HANDOFF.md` so a fresh agent can continue from the
immediately preceding turn. Use that one stable filename, never a dated copy. Replace its
entire contents on every invocation; do not append. Resolve the working directory before
writing, rather than substituting the skill's directory or a repository root.

## Recover the current state

Use the current conversation through the turn before this invocation, including relevant
delegated work. If arguments specify the next session's focus, record that direction too.
Use available current-thread history tools when needed. If history is unavailable or
compacted, state the coverage gap; never invent missing messages or completed work. Do not
search unrelated conversations. An older handoff can supply continuity, but reconcile its
claims with current evidence before carrying them forward.

Identify changed files from the work actually performed, including committed edits,
uncommitted edits, new or generated files, deletions, and renames. In a Git workspace,
inspect status and staged/unstaged name-status diffs; compare a known session-start revision
to HEAD when available to catch committed work. Use conversation and tool evidence for
files outside the repository or when Git is absent. Do not initialize Git or attribute every
dirty file to this session. Mark pre-existing, collaborator-owned, or uncertain changes
separately when relevant. If the change list cannot be exhaustive, say why.

## Write the document

Use short bullets and these compact sections. Omit empty optional details; retain explicit
`None` or `Not run` where their absence would be ambiguous.

- **Context:** working directory, active objective, current result or stopping point, and
  branch/revision if applicable. Add only the environment details needed to resume.
- **User messages:** one numbered, concise summary per user-authored message, in original
  order, through the previous turn. Cover every message, including corrections, constraints,
  decisions, and reversals; identify superseded directions. These are summaries, not a
  verbatim transcript, unless the user requests one. Preserve exact paths, commands, and
  wording when they affect correctness. Exclude this handoff invocation and automated
  harness/tool notifications; put any new focus supplied with the invocation under Resume.
- **Work completed:** concrete outcomes, decisions, and meaningful research findings. Link
  existing plans, reports, artifacts, commits, or PRs instead of copying their contents.
  Distinguish finished work from attempts, proposals, and pending delegated tasks.
- **Files changed:** every session-changed path and a few words explaining its change.
  Label added, modified, deleted, renamed (`old -> new`), or generated files. Group only
  files with the same purpose, listing each path. Include changes outside the working
  directory with their full paths. State `None` if no files changed.
- **Verification:** checks actually run and their results; essential failures, unverified
  behavior, and blockers. Include commit/push status when relevant. Do not rerun expensive
  checks merely to write the handoff, or report an unrun check as passing.
- **Resume:** the next concrete action and remaining steps in priority order, unresolved
  decisions, and any command or prerequisite necessary to continue. Mention suggested
  skills only when they help this particular continuation. Do not grant new permissions
  or resume implementation just to prepare this record.

Keep this extremely concise: one line per message or changed path where practical, no
tool-by-tool narrative, repeated background, or pasted logs. Preserve coverage before
enforcing brevity; many messages or files may require a longer document. Never write
credentials or secret values; redact them in any quoted or summarized material.

Write the complete replacement, then read it back to confirm the saved file covers the
available messages and changed files, reflects the latest state, and contains no stale
appended handoff. Return only the file's path in chat.
