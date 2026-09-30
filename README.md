# Project Mosaic

Current release: **v0.1.0 — Session Review** (Mac in-memory demo).
See [brief history](docs/HISTORY.md) and [code audit](docs/AUDIT.md).

Project Mosaic is the codename for a local-first personal screenshot intelligence
system for iPhone, iPad, and Mac.

The project is in the **early implementation stage**. A dependency-free Swift
package implements an in-memory record review and local search foundation.
Development uses synthetic fixtures. The user may manually test individual
authorized images in the Mac demo; agents must not inspect personal contents.
Production data use is not authorized. Vision OCR recognizes image pixels locally.
Persistence is not built yet. The Mac demo supports selected-image loading,
recognition, correction, review, and search.
Each imported image adds a session record. Pending records are listed in a Review
Inbox; search spans all approved records. Nothing persists after closing the app.

Run `swift run MosaicDemo` for the Mac demo. See [docs/TESTING.md](docs/TESTING.md)
for launch options and a manual testing checklist.

Open `Package.swift` in Xcode to work on the package. Run `swift test` to execute
the synthetic core tests. Swift may require permission to write compiler caches.

Read [AGENTS.md](AGENTS.md) for the project boundaries and
[docs/PLAN.md](docs/PLAN.md) for decisions, milestones, verification, and risks.

Task tracking: [GitHub Issues](https://github.com/hash-murali/mosaic/issues).
Next release: [v0.2.0 milestone](https://github.com/hash-murali/mosaic/milestone/1).
Every release ends with tests, an audit, and issue reorganization; see
[release workflow](docs/ROADMAP.md).
