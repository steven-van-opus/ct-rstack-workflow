#!/usr/bin/env bash
set -euo pipefail

if [[ $# -lt 1 || $# -gt 2 || ! ${1:-} =~ ^[a-z0-9]+(-[a-z0-9]+)*$ ]]; then
  printf 'Usage: %s task-slug [base-branch]\n' "$0" >&2
  exit 1
fi

task=$1
base=${2:-main}
repo=$(git rev-parse --show-toplevel)
branch="agent/$task"
task_path="$(dirname "$repo")/$(basename "$repo")-agent-$task"
base_ref="refs/remotes/origin/$base"

git check-ref-format "refs/heads/$base"
if [[ -e "$task_path" || -L "$task_path" ]] || git show-ref --verify --quiet "refs/heads/$branch"; then
  printf 'Task path or branch already exists: %s (%s)\n' "$task_path" "$branch" >&2
  exit 1
fi

git fetch origin "refs/heads/$base:$base_ref"
git worktree add --no-track -b "$branch" "$task_path" "$base_ref" >&2
printf '%s\n' "$task_path"
