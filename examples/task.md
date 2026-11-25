# Task brief for Pantry Notes

An empty recipe list currently shows an empty grid. Give first-time users a `Create recipe` button that opens the existing recipe form.

## Acceptance criteria

- With zero recipes, the list page shows a short empty state and the `Create recipe` button.
- The button opens the existing form and focuses its recipe name field.
- With at least one recipe, the list still renders the recipe cards and the empty state is absent.

## Proof to include in the PR

- Record the failing empty-list behavior before the fix and capture the corresponding passing check after it.
- On the preview, start from an empty test account, open the recipe form with the keyboard, save a recipe, and return to the populated list.
- Report what you observed in each of those states. If an account or a browser check is unavailable, name the check a maintainer needs to perform.
