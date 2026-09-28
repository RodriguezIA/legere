# Feature — Search & Filters

_Last updated: 2026-09-27_ · Phase 3

Two header controls on "Mi Biblioteca": search and sort.

## Search

- A **search icon (🔍)** in the header toggles a text input.
- Filters the current tab's list **live** as the user types.
- Matches against **title, author, and format** (extendable to more fields later).
- Implemented as `title LIKE ? OR author LIKE ? OR format LIKE ?`, combined with the
  active tab and sort option.
- Clearing/closing the search returns to the full list.

## Sort / filter bottom sheet

- A **filter icon** opens a **modal bottom sheet** that slides up from the bottom.
- Header: **"Ordenar por"**.
- Options (single selection, `SortOption` enum):
  1. **Título A–Z** (`titleAsc`)
  2. **Título Z–A** (`titleDesc`)
  3. **Más recientes** (by `importedAt` desc → `importedNewest`)
  4. **Más antiguos** (by `importedAt` asc → `importedOldest`)
  5. **Últimos leídos** (by `lastOpenedAt` desc → `lastReadNewest`)
  6. **Favoritos primero** (`isFavorite` desc, then a secondary order → `favoritesFirst`)
- Selecting an option re-sorts the current tab and closes the sheet.
- The chosen sort is **persisted** (`shared_preferences`) and applies across tabs
  (Recientes keeps its intrinsic last-opened ordering; see note).

## View toggle

- Separate from sort: a header control switches **grid (mosaico, default) ↔ list**.
- Persisted alongside the sort option. Layout details in `library.md`.

## Notes & interactions

- **Recientes** tab has an intrinsic ordering (last opened first). The sort sheet
  primarily affects **Biblioteca** and **Favoritos**; document how Recientes reacts
  when implementing (default: Recientes ignores sort and stays last-opened-first).
- Search + sort compose: search narrows, sort orders the narrowed set.

## Code locations

- State (search text, sort option, view mode): `features/library/providers/`.
- Query building: `data/repositories/DocumentRepository`.
- UI: `features/library/presentation/` (search field, filter sheet, view toggle).
