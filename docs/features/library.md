# Feature — "Mi Biblioteca" (Library)

_Last updated: 2026-09-27_ · Phases 1–3

The home screen. Three tabs, a searchable/filterable header, a view toggle, and a
floating import button.

## Screen layout

```
┌───────────────────────────────────────────────┐
│  Mi Biblioteca            🔍   ⚙(filtro)  ▦/≣   │  ← header
│  [ Biblioteca ] [ Recientes ] [ Favoritos ]     │  ← tabs
├───────────────────────────────────────────────┤
│                                                 │
│   ┌──────┐   ┌──────┐   ┌──────┐                │
│   │cover │   │cover │   │cover │   ...           │  ← grid (mosaico, default)
│   │ [PDF]│   │[EPUB]│   │ [CBZ]│                 │     format tag on cover
│   └──────┘   └──────┘   └──────┘                │
│   Título     Título     Título                  │
│   Autor·123p Autor·88p  Autor·42p               │
│   ▁▁▃▃▃ (progreso)                              │
│                                                 │
│                                   ( + Importar )│  ← floating action button
└───────────────────────────────────────────────┘
```

## Header

- **Title:** "Mi Biblioteca".
- **Search icon (🔍):** expands an input that filters by title, author, format,
  etc. See `search-and-filters.md`.
- **Filter icon:** opens a bottom sheet ("Ordenar por…"). See
  `search-and-filters.md`.
- **View toggle:** switches between **grid (mosaico, default)** and **list**.
  The choice is persisted (`shared_preferences`).

## Tabs

1. **Biblioteca** — all imported documents, ordered by the active sort option.
2. **Recientes** — a stack ordered by `lastOpenedAt` descending: the most recently
   opened document is always first. Only documents that have been opened appear.
3. **Favoritos** — documents where `isFavorite = true`, ordered by the active sort.

All three tabs reuse the same card widgets and respond to search + sort + view mode.

## Document card

### Grid (mosaico) — default
- Prominent **cover** image (extracted per format; placeholder if none).
- **Format tag** overlaid on the cover (e.g. `PDF`, `EPUB`, `CBZ`).
- Below the cover: **filename/title**, then **author** and **page count** if
  available.
- A **discreet progress bar** at the bottom of the card showing reading progress.

### List
- **Smaller cover** on the leading side.
- **Title**, the **progress**, and the **format** at the end (trailing).
- Denser rows for scanning large libraries.

## Interactions

- **Tap** a card/row (the whole item is a single button) → opens the document in the
  Reader (`reader.md`) and updates `lastOpenedAt`.
- **Long-press** a card/row → opens the item action sheet (`item-actions.md`).

## Floating action button

- Label/icon: **"Importar"**, placed in a corner (FAB).
- Opens the import flow (`import.md`).

## Empty states

- No documents yet → friendly empty state prompting the user to import.
- Recientes/Favoritos empty → their own contextual empty messages.

## Data sources

Backed by `DocumentRepository` queries described in `../ARCHITECTURE.md` §3.
Library state (active tab, search text, sort option, view mode) lives in Riverpod
providers under `features/library/providers/`.
