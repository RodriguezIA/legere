# legere — Decision Log

Chronological record of the choices that shape the project and why. Newest first.

---

## 2026-09-27 — Initial planning decisions

Captured from the planning conversation with the user.

### D1. Supported formats: epub, pdf, cbz, cbr, mobi, txt
- **Decision:** target all common reader formats.
- **Consequence:** cbr (RAR) and mobi have no dependable open-source Flutter
  library, so they are scheduled last (Phase 6) as a spike and flagged as risk.
  epub/pdf/cbz/txt ship first.

### D2. Rendering: open-source only
- **Decision:** use only free/open-source packages; no Syncfusion or any
  license-keyed dependency.
- **Consequence:** pdf via `pdfx`, epub via `epubx`, cbz via `archive`. Raises the
  difficulty of cbr/mobi (see D1). Encoded as Rule 4 in `../CLAUDE.md`.

### D3. Delivery: phased (MVP first)
- **Decision:** build in phases; each phase ends runnable. MVP = library + import +
  basic reader with progress.
- **Consequence:** roadmap in `PLAN.md`; no pulling later-phase work forward without
  the user's ok (Rule 3).

### D4. Documentation & comments in English; UI strings in Spanish
- **Decision:** docs and code comments in English; identifiers in English;
  user-facing UI text in Spanish, centralized for future localization.

### D5. Docs-first workflow
- **Decision:** before implementing/altering a feature, read its doc; keep docs in
  sync with code.
- **Consequence:** Rules 1 & 2 in `../CLAUDE.md`.

### D6. Core stack (assistant-recommended, not separately asked)
- **Decision:** Riverpod (state), go_router (navigation), Drift/SQLite (local DB),
  file_picker (import), path_provider (storage), feature-first structure.
- **Rationale:** Drift's typed SQL fits the heavy sorting/searching requirements;
  Riverpod + go_router are current, well-maintained, open-source defaults.
- **Revisit if:** the user prefers a different stack — say so and this can change
  before Phase 0 code lands.

### D7bis. `drift_flutter` instead of `sqlite3_flutter_libs`
- **Decision (Phase 0 implementation):** use `drift_flutter` to open the Drift
  database, not `sqlite3_flutter_libs`.
- **Rationale:** `sqlite3_flutter_libs` is end-of-life as of `sqlite3` v3 (its
  pub.dev listing ships version `0.6.0+eol` and does nothing) — `sqlite3` v3
  bundles native libs itself, and `drift_flutter` is the current official helper
  for wiring that up in Flutter. Still shows up as a transitive dependency (empty
  stub) pulled in by `drift_flutter` itself; harmless.

### D7. Imported files are copied into app storage
- **Decision:** copy picked files into the app's documents dir; the library owns its
  copy.
- **Rationale:** user requirement — deleting the original must not lose the book.
