#!/usr/bin/env bash
set -euo pipefail

if [[ $# -ne 4 ]]; then
  printf 'Usage: %s reviewed-commit https-preview-url checks-file review-file\n' "$0" >&2
  exit 1
fi

head=$(git rev-parse HEAD)
if [[ "$1" != "$head" ]]; then
  printf 'The reviewer must confirm the current commit %s.\n' "$head" >&2
  exit 1
fi

if [[ ! "$2" =~ ^https://[A-Za-z0-9.-]+(:[0-9]+)?([/?\#][^[:space:]\<\>\(\)]*)?$ ]]; then
  printf 'Pass a preview URL beginning with https://.\n' >&2
  exit 1
fi

if [[ ! -f "$3" || ! -s "$3" || ! -f "$4" || ! -s "$4" ]]; then
  printf 'Include a non-empty file for checks and review.\n' >&2
  exit 1
fi

printf '## Preview\n\n[Open the preview](%s) for commit `%s`.\n\n## Checks and browser walkthrough\n\n' "$2" "$head"
cat -- "$3"
printf '\n\n## Independent review\n\n'
cat -- "$4"
printf '\n'
