## Collaboration artifacts

- Before creating, updating, or publishing commits, pull requests, issues, tickets, descriptions, or comments in any collaboration system (including GitHub, Linear, and Jira): scan the user-visible text you are creating or modifying for `@` mentions and personal names and remove them. Refer to people by a role known from context ("the reviewer", "oncall"); otherwise, omit the reference. Do not infer a role.
  - Wrong: `Addresses feedback from @alice on auth`
  - Right: `Addresses review feedback on auth`
- An `@handle` mention is allowed in a pull request, issue, or ticket comment only with explicit approval for that handle in the current conversation.

## GitHub

- Open PRs in draft mode (`--draft`).
- Keep PR title and summary in sync with all commits on the branch.
- Code references: permalink URLs with commit SHA and exact line numbers, fetched via `gh api` or `curl` (never WebFetch — it silently mutates content).

## Repository prose and code comments

- Repository prose describes the intended post-merge system, not the work that produced it. Keep prompts, task and change history, internal tracking, transient review state, and pre-merge workarounds in commits, pull requests, trackers, or explicitly historical docs—not in comments, names, configuration descriptions, tests, or ordinary documentation.
- If text stops mattering when the current change is complete, remove it rather than relocating it elsewhere in the repository.
- Do not add or expand implementation comments unless the user explicitly requests one or repository conventions require API documentation or a tool directive. When an affected existing comment is inaccurate or obsolete, delete it or make the smallest correction necessary; do not broaden it.
- Do not restate behavior, orchestration, schedules, or configuration defined elsewhere. API and configuration descriptions document only their own contract, not a caller's current use or rationale.
- Cite an external specification or upstream issue only when it documents an ongoing constraint or removal condition. State the constraint so the comment remains useful without the reference.
- Before finishing, inspect the final diff and remove every added or expanded implementation comment not covered by the exception above. Remove or rewrite other repository prose that violates these rules. Apply the result before committing; do not merely report the review.
