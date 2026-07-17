## GitHub

- Open PRs in draft mode (`--draft`).
- Keep PR title and summary in sync with all commits on the branch.
- Code references: permalink URLs with commit SHA and exact line numbers, fetched via `gh api` or `curl` (never WebFetch — it silently mutates content).
- Before `gh pr create`, `gh pr edit`, or `git commit`: scan the message for `@` and personal names and remove them. Refer to people by role ("the reviewer", "oncall") or omit.
  - Wrong: `Addresses feedback from @alice on auth`
  - Right: `Addresses review feedback on auth`
- `@handle` allowed in PR/issue comments only with explicit per-handle approval in the current conversation.

## Code comments

- Implementation comments are rare and timeless. Prefer clearer code over explanatory prose.
- Add a comment only when it preserves non-obvious rationale, invariants, constraints, or deliberate tradeoffs that the code cannot express.
- Comments describe current constraints, not the work that produced the code. Do not narrate the implementation or record prompts, tasks, internal tickets, pull requests, commits, change history, or superseded implementations. Put that context in the commit, pull request, or tracker.
- Cite an external specification or upstream issue only when it documents a current constraint or removal condition. State the constraint so the comment remains useful without the reference.
- Before finishing a code change, review the final change set for new, modified, or invalidated implementation comments. Remove or rewrite anything that violates these rules.
- Follow repository conventions for API documentation and required tool directives.
