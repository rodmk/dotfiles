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
- Default to no new implementation comment. Keep one only if removing it would conceal a non-obvious invariant or constraint a maintainer could violate, or why an apparently simpler implementation is incorrect, and clearer code, names, types, tests, or tooling cannot make that evident or enforce it.
- Do not restate behavior, orchestration, schedules, or configuration defined elsewhere. API and configuration descriptions document only their own contract, not a caller's current use or rationale.
- Cite an external specification or upstream issue only when it documents an ongoing constraint or removal condition. State the constraint so the comment remains useful without the reference.
- Before finishing, inspect every prose addition or edit and any prose invalidated by the change. Delete it unless repository conventions require it as API documentation or a tool directive, or it passes the implementation-comment test above. Accuracy, helpfulness, readability, and consistency with nearby prose are not sufficient reasons to keep it. Apply the result; do not merely report the review.
- Follow repository conventions for API documentation and required tool directives.
