# Creators Toolbox rstack workflow starter

Give a writer agent a separate Git worktree, ask a second agent to review the committed diff, and hand a person a draft pull request with a preview for that commit. The example changes the empty state of a fictional recipe app called Pantry Notes.

## Set up a project

Copy `scripts/start-task.sh` and `scripts/pr-body.sh` into your project. Adapt [the example agent instructions](examples/AGENTS.md) to the repo's existing instructions and test commands. The helpers need Bash and Git. GitHub CLI is used to open the PR, and your existing hosting service needs to build previews from branches.

## Run one task

1. From your project checkout, run `scripts/start-task.sh recipe-empty-state`. It fetches `origin/main` and creates a sibling worktree on `agent/recipe-empty-state`. Pass a different base branch as the second argument when needed. Give the writer agent the path printed by the command and the [example task brief](examples/task.md) as a starting point.
2. Have the writer reproduce the issue, make and commit the change, then capture targeted checks. Give a separate reviewer agent the task brief, base ref, and candidate commit. Ask it to find problems in the diff and return the evidence in the [review handoff format](examples/review.md). If the writer fixes a finding, review the new commit and refresh the checks.
3. Push the candidate branch with `git push -u origin HEAD`. Wait for your preview provider to build that exact commit. Open the preview, try the user path in the brief, and record what happened. If a provider requires a PR before creating a preview, open a draft first and update it in step 5.
4. Put the checked commit and the review notes into a PR body. In your shell, set `reviewed_commit` to the hash returned by the reviewer and `preview_url` to the build URL confirmed by your host. Keep `checks.md`, `review.md`, and `pr.md` outside the checkout. The [sample checks file](examples/checks.md) shows how to record the results. The helper verifies that `HEAD` is the reviewed commit, then renders the evidence and link. Check the output for internal URLs, credentials, or personal data before you publish it.

   ```sh
   scripts/pr-body.sh "$reviewed_commit" "$preview_url" \
     /tmp/checks.md /tmp/review.md > /tmp/pr.md
   ```

5. Open or update your draft with the reviewed evidence. A maintainer can open the preview, read the diff and checks, and decide whether to merge.

   ```sh
   gh pr create --draft --base main --title 'Show an action when the recipe list is empty' \
     --body-file /tmp/pr.md
   # If a draft already exists:
   gh pr edit --body-file /tmp/pr.md
   ```

Use a commit-specific preview or check your host's deployment metadata before pasting a branch URL. Preview aliases can move when a branch is pushed again. The helper can verify the local commit. Your host establishes which commit the preview serves.

Read the [Creators Toolbox guide](https://creatorstoolbox.com/@steven/post/g_rstack-workflow). The workflow was inspired by [@Rasmic's rstack announcement](https://x.com/Rasmic/status/2125404841325293892) and the [original rstack project](https://github.com/michaelshimeles/rstack).
