# Project Mosaic plan

## Status and environment

The project is in early implementation. Environment details were initially
supplied by the user; Xcode and Swift versions were independently verified on
September 29, 2026. Other environment details remain user-reported:

- External encrypted APFS drive: `/Volumes/MacSSD`
- Repository: `/Volumes/MacSSD/Developer/Projects/mosaic`
- Xcode: 27.0, build 27A266a
- Swift: 6.4
- Git: 2.54
- iOS 27 simulator available
- DerivedData and Archives configured on MacSSD

No production data is authorized. A limited user-only manual image-testing
exception was authorized September 30, 2026; see AGENTS.md and the entry below.

## Decisions

- Build a local-first system for iPhone, iPad, and Mac with offline runtime
  behavior by default.
- Use synthetic fixtures only during development.
- Treat screenshot text and URLs as untrusted input.
- Keep source observations, model inferences, and user corrections separate.
- Allow other projects to receive only explicit user-authorized exports, with no
  access to the full Mosaic data vault.
- Require explicit approval for dependency installation, permission changes,
  access outside the repository, destructive operations, and publishing.
- Exclude analytics, telemetry, cloud inference, external URL fetching, sync,
  and silent provider fallbacks.

## Milestones

1. Initial governance and planning files — complete.
   Core record review and in-memory search foundation — complete and tested.
2. Next: synthetic manual-import → Vision OCR → reviewed record → local search
   proof of concept.
3. Further milestones and any authorization for real data — not yet defined.

## September 30, 2026 — v0.1.0 release audit

- User reported all multi-record tests passed, including an additional sample,
  retention, reopening, Review Inbox and delayed approval. Manual results are
  user-reported; no personal sample contents were inspected or recorded.
- Named this baseline v0.1.0 “Session Review”; added VERSION and visible UI label.
- Added concise HISTORY.md with version/branch, recorded timestamps, results,
  fixes and decision reasons. Earlier event times remain explicitly unknown.
- Audited all source and synthetic tests; findings and scope are in AUDIT.md.
  No blocker found for this limited demo. Draft loss, memory limits and orientation
  remain next-phase work; production isolation and persistence remain absent.
- GitHub remote is not configured. User authorized publishing to Git or GitHub;
  preserve a local commit and release tag rather than inventing a destination.
- Actual release verification: final version-labelled Mac executable built and
  all seven synthetic Swift Testing tests passed with zero failures using
  `swift test --scratch-path .build --disable-sandbox`. No dependencies installed.
- Completed local publication: main commit dbf1937, annotated tag v0.1.0. Created
  codex/review-reliability for the next phase. GitHub was not published because no
  remote destination is configured. Added NEXT.md acceptance criteria; current
  app remains v0.1.0. Next-phase code changes have not been implemented yet.

## September 30, 2026 — release-cycle and pending-work review

- Confirmed VERSION is 0.1.0, the local v0.1.0 tag exists, and the working tree
  was clean at review start. Current branch is codex/review-reliability with a
  planning commit after the release; next-phase features remain unimplemented.
- Reviewed NEXT.md and AUDIT.md; prepared local ticket backlog in ROADMAP.md.
  Existing next target remains v0.2.0. Proposed release workflow uses milestones
  for preparation/features/stabilization and patches for verified baseline fixes.
- Architecture, storage controls, audit events, and future role permissions are
  planning items, not implemented security features. Their scope and release
  assignments remain undecided.
- GitHub connection and publishing are deferred to the user's later setup step.
  No remote is configured; gh is unavailable. Destination and visibility are
  required. No dependency installation or external publication was performed.
- Verification: documentation-only change; application tests were not rerun.
  `git diff --check` passed; the new ROADMAP.md also passed a separate trailing
  whitespace check.

## Dependencies

- The next milestone depends on Apple development tools, the simulator, and the
  Vision OCR framework; compatibility and availability must be verified before
  implementation.
- Synthetic fixtures, record structure, review behavior, and local search design
  remain to be defined.
- No additional dependencies are installed or approved by this setup work.

## Completed work and implemented controls

- Created `AGENTS.md`, `.gitignore`, `README.md`, and this plan.
- Recorded agent data boundaries, authorization requirements, and runtime policy.
- Added Git ignore rules for Apple build/user output, secrets, SQLite data,
  local data directories, and macOS metadata.

These are repository instructions and ignore rules. They are not implemented
application security or runtime enforcement. Ignore rules do not prevent manual
or forced staging of data, or protect files already tracked by Git.

## Planned controls

- Review Inbox (user requested): list pending records, allow opening their
  source and extracted text, editing, approval, or discard. Pending records stay
  out of general search; approved records enter the searchable library. This is
  implemented for the in-memory session as of the multi-record update below.
- An offline synthetic import and OCR path, review step, and local search.
- Separation of source observations, model inferences, and user corrections in
  the record design.
- Enforcement of the data boundary and explicit export authorization in future
  application behavior.

Implemented package behavior: pending records are excluded from search; explicit
corrections replace searchable text while preserving observations and inferences.
Inferences are not searched. Search requires all whitespace-separated query terms,
ignores case and accents, and preserves input record order. Empty queries return
no results. The package contains no network, persistence, or provider integrations.
Vision OCR accepts caller-supplied pixels locally. A synthetic-only Mac UI now
connects OCR, correction, review, and search. File import, vault isolation, and
export enforcement remain unimplemented.

## September 30, 2026 — initial user testing feedback

- User reported that loading the generated sample recognized its text correctly.
- User confirmed searching for `train` showed the original text only after
  explicit approval. This is user-reported manual verification of that path,
  not verification of all GUI interactions or layout.
- User requested testing additional sample images to explore usability and bugs.
  Synthetic versus personal image scope is awaiting clarification; no external
  sample files have been accessed and no file import implementation is claimed.
- No application code changed in this feedback update; application tests were
  not rerun because this update only records feedback and planned work.

## September 30, 2026 — user-selected image testing

- User authorized personal or pre-approved images for manual testing. Recorded
  a narrow exception in AGENTS.md: user-selected local images only; agents must
  not inspect their contents. Synthetic-only automated tests and reports remain.
- Implemented a single-image picker for PNG/JPEG/HEIC/TIFF, in-memory decoding,
  local OCR, and a clear-state button. No image/text saving or content logging
  was added; original files are not modified. Photos scanning is not implemented.
- Actual result: updated Mac demo built successfully and all six synthetic tests
  passed using `swift test --scratch-path .build --disable-sandbox`.
- File picker interactions and personal-image accuracy are not agent-tested.
  No personal image was opened or inspected by the agent.
- This is not a sandboxed vault or secure memory erasure implementation. Large
  images, orientation and complex layouts remain unverified. Review Inbox is
  still planned; only one record is supported. Added manual checks to TESTING.md.

## September 30, 2026 — keyboard input fix

- User reported successful selected-image recognition and approval, but could
  not type into or clear the search field. No personal sample was inspected.
- Suspected cause: Swift-package executable app activation prevented keyboard
  input. Added a regular NSApplication activation policy and foreground activation
  on launch. Added explicit search focus after approval.
- Selected-image loading now starts with an empty query; the generated sample
  retains its `train` query. Canceling image selection still preserves state.
- Actual result: Mac executable compiled and all six synthetic tests passed with
  `swift test --scratch-path .build --disable-sandbox`.
- Keyboard behavior requires user retesting; automated core/OCR tests do not
  verify GUI focus. The suspected root cause is not yet confirmed by that retest.

## September 30, 2026 — multi-record session and Review Inbox

- User confirmed the keyboard fix and corrected-text search work. User reported
  earlier results disappearing on new imports; the single-record implementation
  was replacing them by design. Replaced it with an in-memory session library.
- Each successful recognition appends a record and retains its image in memory.
  A new Review Inbox lists pending records for opening, correction, approval or
  discard. Approved records remain in a separate list and searchable across
  subsequent loads. Search results can reopen the corresponding source image.
- Discard removes only the selected record/image; original files are untouched.
  Closing the demo still discards the session; persistence is not implemented.
- Actual verification: executable built; all seven synthetic tests passed using
  `swift test --scratch-path .build --disable-sandbox`. Added a regression scenario
  for consecutive imports, pending exclusion, approval with correction, source
  preservation and discard without losing previous search results.
- GUI navigation and multi-record behavior require user retesting. Unapproved
  editor drafts are not retained when switching records; approve edits before
  switching. Full-resolution images remain in memory, so large sessions may use
  substantial memory. No personal contents were inspected.

## September 29, 2026 — Mac demo ready for initial user testing

- Added a SwiftUI executable with a fixed generated image, background OCR,
  explicit correction toggle, review approval, and local search. Reloading resets
  the single in-memory record. No file picker or Photos integration is included.
- Actual result: executable compiled successfully with
  `swift test --scratch-path .build --disable-sandbox`; all six synthetic tests
  passed with zero failures. No additional dependencies were installed.
- Added `docs/TESTING.md` with launch instructions and expected manual results.
- GUI launch, layout, accessibility, and interactions have not been manually
  verified. Initial user testing is limited to this synthetic Mac demo.
- Next milestones: address user testing findings, then multiple-record workflow,
  import design and storage design. iPhone/iPad app targets remain to be built.

## September 29, 2026 — synthetic Vision OCR

- Added an Apple Vision adapter taking a CGImage and explicit orientation,
  returning recognized text as a source observation. Recognition uses accurate
  English OCR with language correction disabled. Errors propagate to the caller.
- Added macOS tests that draw synthetic text and blank images in memory with
  AppKit. No real screenshots, Photos, or input files were accessed.
- Actual result: `swift test --scratch-path .build --disable-sandbox` built
  successfully; all six Swift Testing tests passed with zero failures. OCR tests
  completed in about 34 seconds on this Mac.
- Confirmed the synthetic image → OCR → pending record → review → local search
  path, plus blank-image behavior. No network or external dependencies were added.
- Limitations: synchronous OCR must run away from the UI thread in a future app;
  English only; no confidence or bounding-box preservation yet. Rotated images,
  complex layouts, OCR error paths, and iOS builds have not been tested. This is
  not a vault boundary or a complete manual-import application.
- Next: a synthetic-only interface for recognition, correction, review, and search.

## September 29, 2026 — core foundation

- Added a dependency-free Swift 6.4 package targeting macOS 14 and iOS 17 or later.
  These are initial deployment floors, not verified device compatibility claims.
- Kept immutable source observations and model inferences separate from optional
  user corrections, with an explicit pending/reviewed state.
- Added four synthetic tests covering the review gate, provenance preservation,
  correction precedence, exclusion of inference labels, all-term matching,
  whitespace, accent/case handling, and empty corrections.
- Actual result: `swift test --scratch-path .build --disable-sandbox` built
  successfully and Swift Testing passed all four tests with zero failures.
  The initial sandboxed run failed on compiler cache permissions; the approved
  rerun used standard compiler caches. No dependencies were installed.
- Next implementation slice: synthetic image fixture, Vision OCR adapter, then a
  small manual-import and review interface. No real Photos access is authorized.

## Actual verification results

- Passed: all four governance files exist and are nonempty.
- Passed: `git check-ignore` excludes 24 representative build, secret, database,
  local-data, and metadata paths; the four governance files are not ignored.
- Passed: `git diff --check`. Because these files are untracked, this command
  does not validate their contents; a separate whitespace check also passed.
- Initial governance-only setup had no applicable application tests. See the
  dated core foundation results above for current package verification.

## Risks and limitations

- Drive encryption and environment details other than Xcode/Swift are unverified.
- Repository policy depends on contributors following the instructions.
- Ignore rules cover named patterns, not every possible personal-data filename.
- Core search and simple synthetic OCR have been tested on macOS. Broader OCR
  quality, review usability, storage design, and iOS compatibility are unverified.
- If personal data becomes visible, work must stop without quoting it and the
  boundary problem must be reported.

## September 30, 2026 — GitHub tracking and release finalization decision

- User selected GitHub Issues as the task-tracking system and required every
  version to end with an audit and ticket reorganization. Added the required
  release checklist to ROADMAP.md; it is a process requirement, not automated
  enforcement.
- GitHub connector authentication verified for hash-murali. Local Git still has
  no remote; destination is awaiting user input. No issues or releases published.
- Local backlog tables are temporary migration material. Remove duplicated task
  details after GitHub transfer is verified; retain PLAN.md decision/test/risk
  records required by AGENTS.md. No local ticketing application is needed.
- Documentation-only update: application tests not rerun. Whitespace checks
  passed for tracked changes and ROADMAP.md.

## September 30, 2026 — GitHub baseline publication

- User selected https://github.com/hash-murali/mosaic.git. Verified it was public,
  empty, and the authenticated account had push/admin repository access.
- Configured origin and published main plus the existing annotated v0.1.0 tag.
  Remote main and the peeled tag both resolve to
  dbf1937503e8446598979a0147b184a24d9f251f. Stable source/version was unchanged.
- Prepared the planning branch for separate publication; no feature changes.
- GitHub issue creation returned integration permission error 403; none created.
  Browser fallback is signed out. User asked to provide connector Issues write
  access or sign in. Retain temporary backlog until verified migration; no
  duplicate local ticketing application added. Milestone setup is also pending.
- Actual verification: initial sandbox attempt failed compiler-cache access;
  repository-local cache retry passed five core tests but both Vision OCR tests
  failed with nilError. Normal-access rerun of swift test --scratch-path .build
  --disable-sandbox built the executable and passed all seven synthetic tests
  with zero failures. No personal samples or dependencies were accessed.
- Documentation whitespace checks passed. GUI tests were not rerun. Existing
  v0.1.0 audit remains applicable; required GitHub ticket reorganization remains
  pending because no tickets could be created.

## September 30, 2026 — GitHub backlog migration completed

- User signed into the in-app browser after connector issue writes returned 403.
  Created and verified ten GitHub issues with acceptance criteria and synthetic
  data boundaries. No issue content contains personal test data.
- Created milestone #1, v0.2.0 — Review Reliability, and verified its five issues:
  the four reliability tasks and release-finalization task. Five later design
  items remain unassigned in the backlog. No deadline invented.
- Removed temporary local ticket tables/IDs and replaced NEXT.md task details
  with the GitHub milestone link and objective. PLAN.md remains the required
  decision/verification record, not a second issue-status tracker.
- Planning branch publication succeeded. No application code changed; prior
  seven-test normal-access pass remains applicable. Documentation whitespace
  checks passed. GitHub connector write permission remains unverified, while
  authenticated browser issue/milestone operations succeeded.
