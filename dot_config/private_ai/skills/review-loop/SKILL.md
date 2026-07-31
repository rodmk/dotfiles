---
name: review-loop
description: Iteratively review and improve a target using independent subagents and optional focus instructions.
---

Review the requested target, defaulting to current changes, and follow any additional instructions. Use a fresh subagent for each pass. Focus on repository prose guidelines, keeping things DRY through worthwhile refactoring, and avoiding complexity for unlikely edge cases. Fix actionable findings and repeat until none remain.
