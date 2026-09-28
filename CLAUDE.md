# CLAUDE.md — Project rules for `legere`

`legere` is a cross-platform **document reader** built with Flutter (Android + iOS
now; macOS + Windows later). It reads epub, pdf, cbz, cbr, mobi and txt files that
the user imports into an on-device library.

This file is the operating contract for any AI/code assistant working in this repo.
Read it fully before making changes.

---

## Rule 1 — Documentation-first workflow (MANDATORY)

**Before writing or modifying code that touches a feature, read the feature's
documentation first.**

Concretely, for every task:

1. Open `docs/PLAN.md` to locate the current phase and scope.
2. Open the relevant spec in `docs/features/` (e.g. `library.md`, `reader.md`,
   `import.md`, `search-and-filters.md`, `item-actions.md`).
3. Open `docs/ARCHITECTURE.md` if the change touches data model, storage,
   navigation, state management, or folder layout.
4. Only then implement, following what the docs describe.

If the code and the docs disagree, **stop and reconcile** — either the docs are
outdated (update them) or the request contradicts the spec (flag it to the user).
Never silently diverge from the documented design.

## Rule 2 — Keep documentation in sync

When a change alters documented behavior, data model, dependencies, or a screen's
spec, **update the corresponding doc in the same change**. Docs and code ship
together. A feature is not "done" until its doc reflects reality.

## Rule 3 — Respect the phase plan

Build in the order defined by `docs/PLAN.md`. Do not pull work from a later phase
into an earlier one unless the user explicitly asks. Each phase should end in a
runnable app.

## Rule 4 — Open-source only

Rendering, parsing, storage and all runtime dependencies must be free and
open-source. No packages that require a paid or registered license key
(e.g. Syncfusion). If a format cannot be supported open-source, document the
limitation instead of pulling in a restricted dependency.

## Rule 5 — Conventions

- **Language:** documentation and code comments in **English**; identifiers in
  English (standard). User-facing UI strings are in **Spanish** (the app's
  audience), centralized so they can be localized later.
- **State management:** Riverpod. **Navigation:** go_router.
  **Local database:** Drift (SQLite). See `docs/ARCHITECTURE.md`.
- **Structure:** feature-first (`lib/features/<feature>/...`). See ARCHITECTURE.
- Run `flutter analyze` before considering a change complete; keep it clean.
- Prefer small, composable widgets; keep business logic out of widgets.

---

## Quick pointers

| Topic | File |
|-------|------|
| Roadmap & phases | `docs/PLAN.md` |
| Tech stack, data model, folders | `docs/ARCHITECTURE.md` |
| Decision log (why these choices) | `docs/DECISIONS.md` |
| "Mi Biblioteca" screen | `docs/features/library.md` |
| Reader screen | `docs/features/reader.md` |
| Import flow | `docs/features/import.md` |
| Search & sort/filter | `docs/features/search-and-filters.md` |
| Long-press menu, info, delete | `docs/features/item-actions.md` |

## Dev environment notes

- Browser for Flutter web is Helium (set via `CHROME_EXECUTABLE` in `~/.zshrc`).
- CocoaPods installed via Homebrew.
- Primary test device so far: physical Pixel 7 Pro (`flutter run -d <id>`).
