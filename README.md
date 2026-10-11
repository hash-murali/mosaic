# Project Mosaic

Current release: **v0.1.0 — Session Review** (Mac in-memory demo).
See [brief history](docs/HISTORY.md) and [code audit](docs/AUDIT.md).

Project Mosaic is the codename for a local-first personal screenshot intelligence
system for iPhone, iPad, and Mac.

Published foundation candidate: [v0.1.1-rc.1 — Protected Mac Foundation](https://github.com/hash-murali/mosaic/releases/tag/v0.1.1-rc.1),
for synthetic testing only. Remaining validation is explicitly deferred in
[the consolidated inspection checklist](docs/evidence/releases/v0.1.1/DEFERRED-VALIDATION.md).
Next development is v0.1.2; this candidate is not a fully validated stable release.
There is one app window and one protected collection. Inbox, Library and Search
share approval, corrections, search and restored content. Saved records show a
vault shield. Settings provides Mac-authenticated general unlock/lock and inline
backup/recovery. The old separate memory/vault/recovery screens are removed.

This development build accepts generated samples and explicitly selected invented
PNG/JPEG fixtures only. Settings can remember an existing vault folder; unavailable
storage does not open a fallback collection. Personal-image
persistence or migration is not authorized. Historical memory-demo testing remains
part of older evidence; it is not a second workspace in this build.

Protected storage uses the exact SQLCipher.swift Community Edition 4.19.0 pin;
see [license attribution](docs/SQLCIPHER-LICENSE.md). Platform custody requires
supported native signing; automated tests use fake custody. Vision OCR is local.

Open `MosaicNative.xcodeproj` in Xcode, choose MosaicNative/My Mac, and follow
[signing setup](docs/SIGNING-v0.1.1.md). `swift run MosaicDemo` compiles the package
executable; it now explains the required native launch before authentication.
It does not establish signed protected Keychain acceptance. Use
`swift test` for the synthetic suite and [inspection](docs/INSPECTION-v0.1.1.md)
for current-build checks. Compiler caches may require permitted tool access.

Read [AGENTS.md](AGENTS.md) for the project boundaries and
[docs/PLAN.md](docs/PLAN.md) for decisions, milestones, verification, and risks.

The [development pack](mosaic-development-pack/START_HERE.md) supplies the proposed
protected-vault roadmap. See the [repository reconciliation](docs/evidence/repository-inventory.md)
for actual implementation gaps and validation. Its protected Mac foundation is now targeted at v0.1.1 (D-008); v0.1.0 remains
the released session demo. Initial OS validation targets are macOS/iOS/iPadOS 27;
older-version compatibility requires capability checks and actual testing.

Task tracking: [GitHub Issues](https://github.com/hash-murali/mosaic/issues).
Active development: **v0.1.1 — Protected Mac Foundation**, including design
refinement and existing review fixes.
Existing backlog: [v0.2.0 milestone](https://github.com/hash-murali/mosaic/milestone/1),
awaiting scope reconciliation. The UI marks the working build as in development.
Every release ends with tests, an audit, and issue reorganization; see
[release workflow](docs/ROADMAP.md).
