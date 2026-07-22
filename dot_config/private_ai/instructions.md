## GitHub

- Open PRs in draft mode (`--draft`).
- Keep PR title and summary in sync with all commits on the branch.
- Code references: permalink URLs with commit SHA and exact line numbers, fetched via `gh api` or `curl` (never WebFetch — it silently mutates content).
- Before `gh pr create`, `gh pr edit`, or `git commit`: scan the message for `@` and personal names and remove them. Refer to people by role ("the reviewer", "oncall") or omit.
  - Wrong: `Addresses feedback from @alice on auth`
  - Right: `Addresses review feedback on auth`
- `@handle` allowed in PR/issue comments only with explicit per-handle approval in the current conversation.

## Repository prose and code comments

- Repository prose describes the intended post-merge system, not the work that produced it. Keep prompts, task and change history, internal tracking, transient review state, and pre-merge workarounds in commits, pull requests, trackers, or explicitly historical docs—not in comments, names, configuration descriptions, tests, or ordinary documentation.
- If text stops mattering when the current change is complete, remove it rather than relocating it elsewhere in the repository.
- Do not add or expand implementation comments unless the user explicitly requests one or repository conventions require API documentation or a tool directive. When an affected existing comment is inaccurate or obsolete, delete it or make the smallest correction necessary; do not broaden it.
- Do not restate behavior, orchestration, schedules, or configuration defined elsewhere. API and configuration descriptions document only their own contract, not a caller's current use or rationale.
- Cite an external specification or upstream issue only when it documents an ongoing constraint or removal condition. State the constraint so the comment remains useful without the reference.
- Before finishing, inspect the final diff and remove every added or expanded implementation comment not covered by the exception above. Remove or rewrite other repository prose that violates these rules. Apply the result before committing; do not merely report the review.
