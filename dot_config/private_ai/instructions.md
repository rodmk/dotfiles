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
- Implementation comments are rare and timeless. Prefer clearer code; comment only for non-obvious rationale, invariants, constraints, or deliberate tradeoffs that the code cannot express and that are expected to outlive the current change.
- Cite an external specification or upstream issue only when it documents an ongoing constraint or removal condition. State the constraint so the comment remains useful without the reference.
- Before finishing a code change, review the final change set for new, modified, or invalidated repository prose. Remove or rewrite anything that violates these rules.
- Follow repository conventions for API documentation and required tool directives.
