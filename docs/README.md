# legere — Documentation

`legere` is a Flutter document reader (epub, pdf, cbz, cbr, mobi, txt) with an
on-device library. Users import files; the app copies them locally so the library
survives deletion of the originals.

## How to use these docs

Per the project rules in [`../CLAUDE.md`](../CLAUDE.md), **read the relevant doc
before implementing any feature**. Start with the plan, then the specific feature.

## Index

- **[PLAN.md](PLAN.md)** — vision, scope, and the phased roadmap.
- **[ARCHITECTURE.md](ARCHITECTURE.md)** — tech stack, folder structure, data
  model, storage strategy, navigation, state management.
- **[DECISIONS.md](DECISIONS.md)** — decision log and rationale.
- **Feature specs** (`features/`):
  - [library.md](features/library.md) — "Mi Biblioteca", tabs, grid/list, cards.
  - [reader.md](features/reader.md) — reading screen, controls, gestures, progress.
  - [import.md](features/import.md) — importing files into the library.
  - [search-and-filters.md](features/search-and-filters.md) — search + sort/filter.
  - [item-actions.md](features/item-actions.md) — long-press menu, info, delete.

## Status

See the phase checklist in [PLAN.md](PLAN.md). Current: **Phase 0 (Foundations)
done** — empty "Mi Biblioteca" with its three tabs runs on device. **Phase 1
(Library MVP)** is next: grid cards, view toggle, import, and a basic reader.
