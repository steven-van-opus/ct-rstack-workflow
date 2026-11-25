# Agent workflow for Pantry Notes

The task brief defines the user behavior and the evidence to collect. The coordinator supplies an assigned worktree, a base ref, and a writer or reviewer role.

## Writer

- Read the project instructions in the assigned worktree and confirm the branch with `git branch --show-current`.
- Describe the failing user path or add a targeted regression check. Run the project checks that cover the behavior after the edit. Record commands, outcomes, and anything that needs a browser or test account to verify.
- Commit the candidate and return its full SHA, the relevant checks, and the route the maintainer should open on the preview. Keep worktree files such as local environment settings out of the commit.
- Address review findings in the assigned worktree. Send each new candidate SHA back for review.

## Reviewer

- Compare the candidate against the supplied base using `git diff <base-ref>...<commit>`. Trace the changed user path and check whether the tests cover the acceptance criteria.
- Review without editing the writer's worktree. Use a separate checkout of the candidate if you need to run checks.
- Return a full commit SHA, findings with file and line references, and any verification gaps.

## Coordinator

Attach a preview that serves the reviewed commit and a short browser walkthrough to the draft PR. Keep the draft open for the maintainer's decision.
