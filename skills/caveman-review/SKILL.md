---
name: caveman-review
description: Ultra-compressed code review. Two scopes in one pass — CORRECTNESS (bugs, risks, nits) AND OVER-ENGINEERING (what to delete: reinvented stdlib, needless deps, speculative abstractions). One line per finding — location, problem, fix. Use when user says "review this PR", "code review", "review the diff", "what can we delete", "is this over-engineered", "/review", "revisa este PR", "revisa el código", or invokes /caveman-review.
metadata:
  origin: opencode
  effort: low
  version: 2.0
---

# Caveman Review

Write code review comments terse and actionable. One line per finding: location, problem, fix. No throat-clearing. Reply in user's language (ES/EN).

Two scopes in the same pass: **correctness** (does it work?) and **over-engineering** (is it too much?). The diff's best outcome is getting shorter.

## Rules

**Format:** `L<line>: <problem>. <fix>.` — or `<file>:L<line>: ...` for multi-file diffs.

**Severity prefix (when mixed):**
- `🔴 bug:` — broken behavior, will cause incident
- `🟡 risk:` — works but fragile (race, missing null check, swallowed error)
- `🔵 nit:` — style, naming, micro-optim. Author can ignore
- `❓ q:` — genuine question, not a suggestion

**Drop:**
- "I noticed that...", "It seems like...", "You might want to consider..."
- "This is just a suggestion but..." — use `nit:` instead
- "Great work!", "Looks good overall but..." — say it once at top, not per comment
- Restating what the line does — reviewer can read the diff
- Hedging ("perhaps", "maybe", "I think") — if unsure use `q:`

**Keep:**
- Exact line numbers
- Exact symbol/function/variable names in backticks
- Concrete fix, not "consider refactoring this"
- The *why* if fix isn't obvious from the problem statement

## Examples

❌ "I noticed that on line 42 you're not checking if the user object is null before accessing the email property. This could cause a crash."

✅ `L42: 🔴 bug: user can be null after .find(). Add guard before .email.`

❌ "It looks like this function is doing a lot and might benefit from being broken up."

✅ `L88-140: 🔵 nit: 50-line fn does 4 things. Extract validate/normalize/persist.`

❌ "Have you considered what happens if the API returns a 429?"

✅ `L23: 🟡 risk: no retry on 429. Wrap in withBackoff(3).`

## Over-engineering scope

Hunt complexity too. Tags for "what to cut":

- `🗑️ delete:` dead code, unused flexibility, speculative feature. Replacement: nothing.
- `📦 stdlib:` hand-rolled thing the standard library ships. Name the function.
- `🌐 native:` dependency or code doing what the platform already does. Name the feature.
- `✂️ yagni:` abstraction with one implementation, config nobody sets, layer with one caller.
- `📉 shrink:` same logic, fewer lines. Show the shorter form.

Examples:

✅ `L12-38: 📦 stdlib: 27-line email validator class. "@" check is 1 line; real validation is the confirmation mail.`

✅ `L4: 🌐 native: moment.js for one format call. Intl.DateTimeFormat, 0 deps.`

✅ `repo.py:L88: ✂️ yagni: AbstractRepository with one impl. Inline until a second exists.`

✅ `L30-44: 📉 shrink: manual loop builds dict. dict(zip(keys, values)), 1 line.`

End the over-engineering scope with the only metric that matters: `net: -<N> lines possible.` If nothing to cut: `Lean already. Ship.` Never flag the caveman-minimum smoke test / assert self-check for deletion — that's the floor, not bloat.

## Auto-Clarity

Drop terse mode for: security findings (CVE-class bugs need full explanation + reference), architectural disagreements (need rationale, not a one-liner), onboarding contexts where author is new and needs the "why". Write a normal paragraph there, then resume terse.

## Boundaries

Review only — don't write the code fix, don't approve/request-changes, don't run linters. Output comment(s) ready to paste into the PR. "stop caveman" or "normal mode": revert to verbose review.
