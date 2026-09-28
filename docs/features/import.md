# Feature — Import

_Last updated: 2026-09-27_ · Phase 1 (cbr/mobi in Phase 6)

Brings external files into the app's owned library.

## Trigger

The **"Importar"** floating action button on "Mi Biblioteca" (`library.md`).

## Flow

1. **Pick** — open the system file manager via `file_picker`, filtered to supported
   extensions (`epub, pdf, cbz, cbr, mobi, txt`). Allow selecting multiple files.
2. **Copy** — for each picked file, copy it into
   `getApplicationDocumentsDirectory()/library/<uuid>.<ext>`. The app now owns a
   copy; deleting the original does **not** remove it from the library (user
   requirement, see `../DECISIONS.md` D7).
3. **Extract metadata** — via `services/metadata/`:
   - `title` (fallback to filename without extension),
   - `author` (if the format exposes it),
   - `totalPages` (if determinable at import time),
   - `fileSize`.
4. **Extract cover** — per format:
   - **pdf:** render the first page to an image (`pdfx`).
   - **epub:** pull the cover from metadata (`epubx`).
   - **cbz/cbr:** first image entry in the archive.
   - **txt/mobi (no embeddable cover):** `coverPath` stays `null`; the library
     card renders a generated placeholder (icon + title) at display time
     instead of writing a cover file.
   When a cover is extracted, store it under
   `getApplicationSupportDirectory()/covers/<uuid>.png`.
5. **Index** — insert a `Document` row (`../ARCHITECTURE.md` §3) with
   `importedAt = now`, `currentPage = 0`, `progress = 0`, `isFavorite = false`,
   `lastOpenedAt = null`.
6. **Feedback** — show progress while importing (esp. multiple files) and a
   confirmation (snackbar). New items appear in **Biblioteca** immediately.

## Edge cases

- **Unsupported / corrupt file:** skip with a clear error; continue the batch.
- **Duplicate import:** allowed for now (each import is a distinct copy); dedupe is a
  possible later enhancement.
- **Large files:** copy/extraction runs off the UI thread; show progress.
- **Permission denied / cancelled:** no-op, return to the library quietly.

## Deletion counterpart

Removing a document (see `item-actions.md`) deletes the copied file and cached cover,
then the DB row.

## Code locations

- Picking + copy: `services/import/`.
- Metadata + cover extraction: `services/metadata/`.
- Row creation: `data/repositories/DocumentRepository`.
