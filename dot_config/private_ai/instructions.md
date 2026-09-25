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

- Repository prose should describe the intended post-merge system rather than the work that produced it. Keep prompts, change history, internal tracking, transient review state, and pre-merge workarounds in collaboration artifacts or explicitly historical docs.
- Prefer clear code over explanatory comments. Use comments sparingly for context that is not apparent from the code, such as intent, constraints, or non-obvious tradeoffs, and follow repository conventions for API documentation and tool directives.
- Avoid prose that merely narrates behavior or restates configuration defined elsewhere. Update or remove comments that become misleading or obsolete.
- Before finishing, review changed prose and comments and remove transient or redundant material.
