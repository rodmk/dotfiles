## GitHub

- Open PRs in draft mode (`--draft`).
- Keep PR title and summary in sync with all commits on the branch.
- Code references: permalink URLs with commit SHA and exact line numbers, fetched via `gh api` or `curl` (never WebFetch — it silently mutates content).
- Before `gh pr create`, `gh pr edit`, or `git commit`: scan the message for `@` and personal names and remove them. Refer to people by role ("the reviewer", "oncall") or omit.
  - Wrong: `Addresses feedback from @alice on auth`
  - Right: `Addresses review feedback on auth`
- `@handle` allowed in PR/issue comments only with explicit per-handle approval in the current conversation.

## Code comments

Implementation comments are rare and timeless. Prefer clearer code over explanatory prose. Add a comment only when it conveys non-obvious rationale, invariants, constraints, or deliberate tradeoffs that the code cannot express. Do not narrate the implementation or record change history, prior behavior, prompts, tasks, or tickets. Make comments self-contained; external references may supplement, but never replace, the explanation. Follow repository conventions for API documentation and required tool directives.
