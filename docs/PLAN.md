# legere — Master Plan

_Last updated: 2026-09-27_

## 1. Vision

A clean, fast, offline-first **document reader** for Android and iOS (macOS and
Windows later). Users import documents into a personal on-device library and read
them with progress tracking and gesture navigation. Because files are **copied into
the app**, deleting the original from the device does not lose the book.

Supported formats (target): **epub, pdf, cbz, cbr, mobi, txt**.

## 2. Guiding principles

- **Offline-first, local only.** No accounts, no cloud (for now).
- **Open-source only** dependencies (see `DECISIONS.md`).
- **Phased delivery.** Every phase ends in a runnable app.
- **Docs-first.** Specs in `docs/` are the source of truth (see `../CLAUDE.md`).

## 3. Feature summary

The full UX is captured per-feature under `docs/features/`. High level:

- **Mi Biblioteca** — main screen with three tabs: **Biblioteca**, **Recientes**,
  **Favoritos**. Items show cover, a format tag, title, author, page count, and a
  discreet progress bar. Floating **"Importar"** button. Grid (mosaico, default)
  and list view toggle. → `features/library.md`
- **Search & filters** — search icon in the header (by title, author, format…),
  and a filter icon opening a bottom sheet with **"Ordenar por"** options.
  → `features/search-and-filters.md`
- **Import** — FAB opens the system file picker; selected files are copied into the
  app's library and indexed (metadata + cover). → `features/import.md`
- **Item actions** — long-press opens a bottom sheet (cover, title, author +
  actions: Abrir, Añadir a favoritos, Información, Eliminar). Info popup + delete
  confirm. → `features/item-actions.md`
- **Reader** — full-screen reader with back button + title + current page in the
  header, progress bar and prev/next + page indicator at the bottom; tap toggles
  chrome (immersive); gestures; **progress is persisted per document (incl. PDF).**
  → `features/reader.md`

## 4. Format support strategy

| Format | Parsing / rendering (open-source) | Difficulty | Phase |
|--------|-----------------------------------|-----------|-------|
| **txt**  | Dart `dart:io` + custom paginator | Easy | 1 |
| **pdf**  | `pdfx` (pdfium)                   | Medium | 1 |
| **epub** | `epubx` (parse/cover) + renderer  | Medium | 1 |
| **cbz**  | `archive` (unzip) + image viewer  | Easy–Med | 1 |
| **cbr**  | RAR extraction — **no reliable free Dart lib** | **High / risk** | 6 |
| **mobi** | MOBI parsing — **no mature Flutter lib** | **High / risk** | 6 |

> ⚠️ **cbr & mobi risk.** With the open-source-only constraint, RAR (cbr) and MOBI
> have no dependable Flutter package. They are deliberately scheduled last
> (Phase 6) as a spike. Possible outcomes: a native platform-channel solution,
> partial support, or documenting them as unsupported. This is called out so the
> earlier, solid formats are not blocked. See `DECISIONS.md`.

## 5. Phased roadmap

Legend: `[ ]` not started · `[~]` in progress · `[x]` done.

### Phase 0 — Foundations `[x]`
- Add dependencies; set up theme, `go_router`, Riverpod, Drift database.
- Establish feature-first folder structure (see `ARCHITECTURE.md`).
- Define `Document` model + Drift table + repository.
- Replace the default counter app with an empty "Mi Biblioteca" scaffold.
- **Exit:** app builds and runs showing an empty library with the three tabs.

### Phase 1 — Library MVP `[ ]`
- Grid (mosaico) view with document cards: cover, format tag, title, author,
  pages, progress bar.
- List/grid view toggle (grid default).
- Import flow for **pdf, epub, cbz, txt**: pick → copy → extract metadata + cover
  → insert. (`features/import.md`)
- Open a document → basic reader with page navigation + progress save for those
  four formats. (`features/reader.md`)
- **Exit:** import a pdf/epub/cbz/txt, see it in the grid, open it, read, reopen
  and resume at the saved position.

### Phase 2 — Tabs & organization `[ ]`
- **Recientes** tab: stack ordered by `lastOpenedAt` (last opened first).
- **Favoritos** tab + favorite toggle.
- **Exit:** opening a doc bumps it to the top of Recientes; favoriting shows it in
  Favoritos.

### Phase 3 — Search & filters `[ ]`
- Header search (title, author, format…).
- Filter bottom sheet "Ordenar por": Título A–Z, Z–A, Más recientes, Más antiguos,
  Últimos leídos, Favoritos primero. (`features/search-and-filters.md`)
- Persist the chosen sort and view mode.
- **Exit:** search narrows results live; each sort option reorders correctly.

### Phase 4 — Item actions `[ ]`
- Long-press bottom sheet: cover, title, author + Abrir, Añadir a favoritos,
  Información, Eliminar.
- Información popup (import date, pages, author, format, last read, progress, size).
- Eliminar confirmation dialog → remove file + row. (`features/item-actions.md`)
- **Exit:** all four actions work from grid and list.

### Phase 5 — Reader polish & gestures `[ ]`
- Tap toggles chrome (immersive full-screen).
- Gestures: swipe/tap-zone page turns, pinch-zoom for pdf/comics.
- Robust progress model per format (page index for pdf/cbz/txt, locator/CFI for
  epub) with reliable save/restore.
- **Exit:** smooth gesture reading; progress survives app restart for every Phase-1
  format.

### Phase 6 — Hard formats (spike) `[ ]`
- Investigate open-source **cbr** (RAR) and **mobi** support.
- Deliver support, partial support, or a documented limitation.
- **Exit:** decision recorded in `DECISIONS.md`; whatever is feasible is shipped.

### Phase 7 — Polish & robustness `[ ]`
- Empty/error/loading states, large-library performance, cover thumbnail caching,
  import of multiple files, basic tests.
- (Optional, later) add macOS + Windows via `flutter create --platforms=...`.

## 6. Open questions / to confirm later

- Reader layout mode per format (paginated vs continuous scroll) — default
  paginated; revisit for epub reflow in Phase 5.
- Whether to allow a native (still open-source) library for cbr/mobi in Phase 6.
- Theming: light/dark + reader-specific themes (sepia, night) — candidate for
  Phase 7.
