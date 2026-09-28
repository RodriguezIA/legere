# Feature — Item Actions (long-press menu)

_Last updated: 2026-09-27_ · Phase 4

Context actions for a single document, available from both grid and list.

## Trigger

**Long-press** a document card (grid) or row (list) on "Mi Biblioteca".

## Action bottom sheet

Opens a modal bottom sheet (same style as the sort sheet) showing:

- The document's **cover**, **title**, and **author** at the top.
- Actions:
  1. **Abrir** — open in the Reader (`reader.md`), same as tapping the item.
  2. **Añadir a favoritos** — toggles `isFavorite`. Label reflects current state
     (e.g. "Quitar de favoritos" when already a favorite).
  3. **Información** — opens the info popup (below).
  4. **Eliminar** — opens the delete confirmation (below).

## Información popup

A dialog showing the document's details:

- Title
- Author
- Format
- **Import date** (`importedAt`)
- **Pages** (`totalPages`)
- **Last reading** (`lastOpenedAt`)
- **Progress** (`progress` as %)
- File size
- (Any other useful metadata available.)

Read-only; a close button dismisses it.

## Eliminar (delete) confirmation

- A confirmation **modal/dialog** asking the user to confirm deletion (destructive
  styling; cancel + confirm).
- On confirm: delete the copied file and cached cover, then the DB row
  (`../ARCHITECTURE.md` §4). The item disappears from all tabs.
- On cancel: no change.

## Code locations

- Sheet + info dialog + delete dialog: `features/library/presentation/`.
- Favorite toggle + delete: `data/repositories/DocumentRepository`.
