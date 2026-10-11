# MOS-001 — Repository inventory and development-pack reconciliation

Verified October 2, 2026 against local source and synthetic fixtures. This is
engineering evidence, not a replacement for GitHub Issues or release approval.

## Actual repository

- Workspace: `/Volumes/MacSSD/Developer/Projects/mosaic`.
- Branch: `codex/v0.1.1-1-review-drafts`; HEAD `18b836b`.
- Remote: `https://github.com/hash-murali/mosaic.git`.
- Existing stable baseline: v0.1.0 Session Review, release commit `dbf1937`.
- Existing work was dirty before this review: draft retention, decoded-image
  fingerprints, UI refinement and related documentation. The development pack
  was untracked. All existing edits were preserved.
- Root AGENTS.md remains authoritative across the repository; the pack's nested
  AGENTS.md additionally governs that directory. Neither file was replaced.
- Swift package targets: MosaicCore library, MosaicDemo executable and
  MosaicCoreTests. No Xcode project/workspace was found in the source inventory.
- Manifest minimums: macOS 14 and iOS 17; Swift tools 6.4. These declarations
  do not establish iPhone/iPad app support: MosaicDemo's UI requires macOS.
- Selected Xcode: `/Volumes/MacSSD/applications/Xcode.app/Contents/Developer`;
  Xcode 27.0, build 27A266a. Swift 6.4, arm64 macOS target.
- No package dependencies are declared. No dependencies were installed, app
  windows opened, private data inspected, permissions changed or work published.

## Implementation compared with the pack

Reviewed the pack's product/architecture plan, requirements and journeys,
numbered engineering specifications, six ADRs, logical schema, contract status
and validator, alongside current source and existing project records.

| Area | Current evidence | Gap against planned outcome |
|---|---|---|
| Capture/source, R01/R02/R19 | Selected images and generated samples enter session memory | No durable receipt, owned encrypted original, resumable job or storage fault handling |
| OCR, R03 | Vision adapter yields immutable source text locally | No evidence IDs/bounds/engine revision; unreadable result and orientation need explicit handling |
| Review, R04 | Observation/inference/correction separated; per-record drafts and approval | No title/category editing, revision concurrency, reprocessing or persistent history |
| Search, R05 | Approved text searched with all-term case/diacritic-insensitive substring matching | No FTS, filters, pagination, policy scope or durable index |
| Dedupe | SHA-256 of decoded sRGB pixels/dimensions, session-only | Pack uses original-byte identity; preserve source hash separately from optional pixel identity |
| Protection/recovery, R06/R07 | No vault storage exists | Encryption, Keychain, lock/session epochs, authenticated backup and independent restore absent |
| Native intake, R08/R09 | Mac file picker | No mobile app targets, Share extension or Photos discovery |
| Intelligence/review, R10–R15 | ModelInference value type only | No provider, extraction, embeddings, entity graph, reminders, rediscovery or Ask |
| Portability/privacy, R16/R17/R20 | Offline demo and documented boundaries | No selective export, transfer, audit viewer or implemented retention controls |
| Accessibility/resources, R18/NF06 | Native SwiftUI and some focus/accessibility identifiers | No full accessibility evidence, decode/session budget or cooperative cancellation |

No complete pack release gate is satisfied by this demo. Existing tested
behaviors are useful components to retain, not evidence of protected storage.

## Reconciliation findings

1. **Version collision:** the pack assigns protected foundation to v0.1.0,
   already released with narrower session-only scope. Never relabel or move the
   released tag. D-007 proposes a future version mapping, pending owner response.
2. **Tracking collision:** pack MOS IDs are planning references; its statement
   that all work is planned describes the supplied baseline. Existing GitHub
   issues own actual status. Map MOS/R/T IDs onto existing issues before creating
   duplicates. Live GitHub issue inspection did not succeed in this review:
   connector calls failed argument/schema validation. No remote status asserted
   and no external writes performed.
3. **Approval attribution:** pack ADRs marked accepted direction lack named
   proposer/approver and approval evidence required by root instructions. Retain
   them as supplied planning inputs; do not infer human acceptance of mechanisms.
4. **Manual-test exception:** root policy permits human-selected in-memory images;
   pack policy blocks real vault data until protection gates. Preserve the narrow
   exception without extending it to persistence, Photos or agent inspection.
5. **Intake mismatch:** current picker allows HEIC/TIFF without explicit pack
   capability evidence, loads through NSImage on the UI thread and has no byte,
   decoded-pixel or retained-session bound. Future bounded intake should validate
   before allocation; do not copy the current decoder into durable capture.
6. **Architecture seam:** MosaicCore combines domain values, session logic and
   Vision. Future domain/policy targets should depend inward; migrate incrementally
   with existing behavior tests rather than create a duplicate app scaffold.
7. **Deletion/schema seam:** the logical sketch cascades claim actions, while
   the product requires preview/detachment for independently adopted actions.
   The pack acknowledges this; the sketch cannot ship as a complete migration.
8. **Evidence limits:** fixture checks cannot establish encryption, permission
   enforcement, model accuracy, archive authentication or actual export consent.
   The pack appropriately labels these limitations; keep them visible.

## Actual validation

`python3 -B mosaic-development-pack/scripts/validate_pack.py`: **24 checks
passed**, covering synthetic contracts/negative cases, in-memory SQLite/FTS,
local links and requirement/backlog ID presence. No app security gate passed.

```
CLANG_MODULE_CACHE_PATH="$PWD/.build/clang-module-cache" \
SWIFTPM_MODULECACHE_OVERRIDE="$PWD/.build/swift-module-cache" \
swift test --scratch-path .build --disable-sandbox
```

Mac package/executable built. **11 Swift Testing tests executed: nine passed,
two failed**. Both Vision tests (`syntheticOCRRequiresReviewBeforeSearch` and
`blankSyntheticImageHasNoRecognizedText`) threw `.nilError`. Cache/dependency
graph permission warnings were also emitted. Root cause is unverified; prior
normal-access passes in PLAN.md do not turn this run into a pass. No permission
escalation or test weakening was performed. GUI/device/recovery/encryption and
performance tests were not run.

## Next safe implementation

MOS-001's local inventory evidence is now available. Start MOS-002 using the
[capability matrix](capability-matrix.md) and owner device information. In
parallel with unresolved device/storage choices, MOS-006 can introduce isolated
domain/policy contracts with synthetic denial, expiry, wrong-vault and stale
session tests. Such tests demonstrate contract logic only; UI/storage integration
must later enforce the boundary before a vault control is called implemented.

Before persistence: select and validate the actual encrypted adapter, then
independent recovery (MOS-003/004). No plaintext saved library, dependency
installation, custom cryptographic scheme or real-data storage is authorized.
Continue the current v0.1.1 GUI/reliability work without claiming the protected
foundation complete. Release mapping and GitHub reconciliation remain pending.
