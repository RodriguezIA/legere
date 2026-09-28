# Feature — Reader

_Last updated: 2026-09-27_ · Phases 1 & 5

Full-screen reading experience, shared across formats, with persisted progress.

## Screen layout

```
┌───────────────────────────────────────────────┐
│  ←  Título del documento              12 / 340  │  ← header: back, title, page
├───────────────────────────────────────────────┤
│                                                 │
│                                                 │
│                 DOCUMENT CONTENT                │  ← format-specific viewer
│                                                 │
│                                                 │
├───────────────────────────────────────────────┤
│  ▁▁▁▃▃▃▃▃▃▃▃▃▃▃▃▃▃▃ (barra de progreso)         │
│        ◀    12 / 340    ▶                        │  ← small prev/next + indicator
└───────────────────────────────────────────────┘
```

## Header (top chrome)

- **Back button** (←) returns to "Mi Biblioteca".
- **Title** of the document (centered/leading).
- **Current page** shown at the opposite end (e.g. `12 / 340`).

## Bottom chrome

- A **progress bar** spanning the width.
- Small **prev/next** buttons with the **current page / total pages** indicator
  centered between them.

## Immersive mode

- **Tap** on the page content **hides the chrome** (header + bottom bar) to show only
  the document. Tapping again brings the chrome back.
- Optionally use system immersive/full-screen while chrome is hidden.

## Gestures (Phase 5)

- **Swipe / tap-zones** to turn pages (left/right).
- **Pinch-to-zoom** for pdf and comics (cbz/cbr); pan while zoomed.
- Keep gestures from conflicting with the tap-to-hide-chrome behavior (e.g. tap in
  the center toggles chrome; tap zones near edges turn pages, configurable).

## Progress persistence

- Progress is **saved per document**, including **PDF**.
- Position model per format (`../ARCHITECTURE.md` §5):
  - **pdf / cbz / cbr / txt:** page index (`currentPage`) + `progress`.
  - **epub:** a locator/CFI string (`readingPosition`) + `progress`.
- Reopening a document **resumes at the saved position**.
- Writes are throttled/debounced and also flushed on page change and on leaving the
  screen. Opening also updates `lastOpenedAt` (drives the Recientes tab).

## Format-specific viewers

The shared chrome stays constant; the content area is delegated to a per-format
viewer under `features/reader/presentation/`, driven by the reading engines in
`services/readers/`:

- **pdf:** `pdfx` page view.
- **epub:** reflowable renderer (`epubx`-based).
- **cbz / cbr:** image-per-page viewer (`photo_view`) from the archive.
- **txt:** custom paginator over the text.
- **mobi:** Phase 6 spike (may be limited/unsupported — see `PLAN.md`).

## Code locations

- `features/reader/presentation/` — `ReaderScreen`, viewers, controls.
- `features/reader/providers/` — current position, chrome visibility, progress save.
- `services/readers/` — per-format engines.
