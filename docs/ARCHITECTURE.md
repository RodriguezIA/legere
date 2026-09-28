# legere — Architecture

_Last updated: 2026-09-27_

## 1. Tech stack (all open-source)

| Concern | Choice | Notes |
|---------|--------|-------|
| UI | Flutter + Material 3 | Android/iOS now; desktop later |
| State management | **Riverpod** (`flutter_riverpod`) | Providers/Notifiers per feature |
| Navigation | **go_router** | Declarative routes, deep-link ready |
| Local database | **Drift** (`drift`, `drift_flutter`) | Typed SQL, good for sort/search |
| File picking | `file_picker` | System file manager for import |
| Paths | `path_provider`, `path` | App documents / cache dirs |
| IDs | `uuid` | Stable per-document id |
| PDF | `pdfx` | Renders pages + page count (pdfium) |
| EPUB | `epubx` (+ renderer) | Parse, cover, chapters |
| Comics (cbz) | `archive` + `photo_view` | Unzip images, zoomable viewer |
| Comics (cbr) | TBD — Phase 6 spike | No reliable free RAR lib (risk) |
| MOBI | TBD — Phase 6 spike | No mature Flutter lib (risk) |
| Prefs | `shared_preferences` | View mode, chosen sort |

> Exact package versions are pinned in `pubspec.yaml` at implementation time.
> Any addition must satisfy Rule 4 (open-source only) in `../CLAUDE.md`.

## 2. Folder structure (feature-first)

```
lib/
  main.dart                 # bootstrap (ProviderScope) + runApp
  app.dart                  # MaterialApp.router, theme wiring
  core/
    theme/                  # ThemeData, colors, text styles
    router/                 # go_router configuration + route names
    constants/              # enums, format tables, magic values
    utils/                  # formatters, extensions
    l10n/                   # user-facing Spanish strings (centralized)
  data/
    db/                     # Drift database, tables, DAOs
    models/                 # Document, DocumentFormat, SortOption, ViewMode
    repositories/           # DocumentRepository (single source of truth for data)
  services/
    import/                 # file picking + copy into app storage
    metadata/              # per-format metadata + cover extraction
    readers/                # per-format reading engines (page count, render, locate)
  features/
    library/
      presentation/         # LibraryScreen, tabs, grid/list, cards, search,
                            #   filter sheet, item long-press menu, info/delete
      providers/            # library state (query, sort, view mode, tab data)
    reader/
      presentation/         # ReaderScreen + format-specific viewers + controls
      providers/            # reader state (current page/locator, chrome visibility)
```

## 3. Data model

### `Document` (Drift table `documents`)

| Field | Type | Notes |
|-------|------|-------|
| `id` | TEXT (PK) | uuid |
| `title` | TEXT | from metadata, fallback to filename |
| `author` | TEXT? | nullable |
| `format` | TEXT (enum) | epub / pdf / cbz / cbr / mobi / txt |
| `filePath` | TEXT | absolute path of the app-owned copy |
| `coverPath` | TEXT? | cached cover image path, nullable |
| `totalPages` | INTEGER? | pages/screens if known |
| `currentPage` | INTEGER | default 0 (page-based formats) |
| `readingPosition` | TEXT? | epub CFI/locator or format-specific position |
| `progress` | REAL | 0.0–1.0, for the discreet progress bar |
| `isFavorite` | BOOLEAN | default false |
| `fileSize` | INTEGER | bytes |
| `importedAt` | DATETIME | set on import |
| `lastOpenedAt` | DATETIME? | null until first opened |

### Derived queries

- **Biblioteca:** all documents, ordered by the active `SortOption`.
- **Recientes:** `WHERE lastOpenedAt IS NOT NULL ORDER BY lastOpenedAt DESC`
  (a stack: last opened first).
- **Favoritos:** `WHERE isFavorite = 1`, ordered by active `SortOption`.
- **Search:** `title LIKE ? OR author LIKE ? OR format LIKE ?` combined with the
  active tab + sort.

### Enums

- `DocumentFormat { epub, pdf, cbz, cbr, mobi, txt }`
- `SortOption { titleAsc, titleDesc, importedNewest, importedOldest, lastReadNewest, favoritesFirst }`
- `ViewMode { grid, list }` (grid = mosaico, default)

## 4. Storage strategy

- Imported files are **copied** into `getApplicationDocumentsDirectory()/library/`
  as `<uuid>.<ext>`. The library owns its copy; deleting the source has no effect.
- Covers are cached in `getApplicationSupportDirectory()/covers/` as `<uuid>.png`.
- Deleting a document removes both the copied file and the cached cover, then the
  DB row (delete file first, DB row last, so a failed file delete doesn't orphan).

## 5. Reading engines (`services/readers/`)

Each format implements a common contract so the reader UI stays format-agnostic:

- report `totalPages` (or logical units),
- render/return the content for a given page/locator,
- map between a page index and a persisted position,
- expose cover extraction (shared with `services/metadata/`).

The `ReaderScreen` renders the shared chrome (header, bottom controls, tap-to-hide)
and delegates the content area to the format-specific viewer.

## 6. State management notes

- One Riverpod provider family per feature area; UI watches selectors, not raw DB.
- `DocumentRepository` is the only thing that touches Drift; providers call it.
- Progress writes are debounced/throttled to avoid excessive DB writes while reading.
