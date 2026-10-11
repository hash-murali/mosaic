# Synthetic Mac demo testing

Latest UI: [design-14](evidence/builds/v0.1.1-20261004-design-14.md), 28 tests
passed. [Inspection J01–J09](INSPECTION-v0.1.1.md#j-design-14-focused-gui-check--all-pending)
checks only the new hierarchy and explicit approved-record tasks. Approved view:
Actions > Edit accepted text > Save changes or Cancel; Actions > Discard requires
confirmation. Draft edits stay outside search until Save, blank Save is blocked.


Current checkpoint: [storage-12](evidence/builds/v0.1.1-20261004-storage-12.md).
27 automated tests passed; use [current inspection H section](INSPECTION-v0.1.1.md#h-storage-12-changed-behavior-and-protected-service-evidence)
for changed behavior and remaining acceptance. Historical instructions/results
below are not new evidence. Demo supports bounded PNG/JPEG only; HEIC/TIFF disabled.
Encrypted adapter is synthetic-only and is not wired into the session demo.

```bash
CLANG_MODULE_CACHE_PATH="$PWD/.verification/clang-cache" \
SWIFTPM_MODULECACHE_OVERRIDE="$PWD/.verification/swift-cache" \
swift test --scratch-path .build --cache-path .verification/package-cache \
  --config-path .verification/package-config \
  --security-path .verification/package-security --disable-sandbox
.build/debug/MosaicRecoveryCheck
```

The recovery checker launches separate creator/restorer processes using generated
repository-local fixtures and fixed public test keys; it never uses Keychain or
personal vaults. It is not a production backup utility or a device-restore pass.


## Current override — design-03 after owner inspection

Owner reports design-01 tests passing; see audit evidence for attribution/limits.
Current source blocks empty/whitespace approval (D-014): Add text or discard,
retain pending source/draft, type nonblank text to enable approval. Any older
empty-approval instructions below describe superseded behavior, not current
acceptance. The suite now declares 17 tests. Current agent full run remains
blocked before execution; core module compilation and source parsing passed.
Use inspection G01–G06 to recheck navigation hit areas, source/full-detail
disclosure, pending drafts, picker cancellation and blank-approval retention.

## October 4 — Native design checkpoint

- [ ] Library shows approved source-image cards only; Inbox shows pending cards.
- [ ] Approve from Inbox: record enters Library with source and Accepted knowledge
  distinct; correction, empty correction and duplicate behavior still pass.
- [ ] Switch Library/Inbox/Search while drafts exist: drafts and toggles survive.
- [ ] Search destination places approved-only text search before source detail.
- [ ] Today, Rediscover, collections, favorites, vault/settings and Ask show
  Planned/unavailable explanations, are disabled and perform no action.
- [ ] Resize grid/divider; use keyboard and VoiceOver; verify Selected/Approved/
  Pending labels, readable light/dark text, reachable controls and focus.

These synthetic GUI checks and the full revised UI build remain unverified.
Syntax parsing and isolated style type-check passed; SwiftPM test execution and
full UI type-check hit build-permission/macro-sandbox blockers. No new test pass
or implemented vault/reminder/AI feature is claimed.

Use [the v0.1.1 inspection sheet](INSPECTION-v0.1.1.md) for numbered owner
checkboxes, automated commands, small adversarial checks and the separate
unimplemented protected-foundation security gates. Record only synthetic evidence.

## October 2 — new policy tests

Run `swift test --scratch-path .build --disable-sandbox --filter MosaicPolicyTests`
to exercise the new owner policy primitive. Five test cases cover locked access,
owner/vault identity, record/field/operation boundaries, expiry, revocation,
session replacement, cross-policy replay and request bounds. These are isolated
policy tests, not app protection or storage tests.

Current execution is unverified: SwiftPM aborted with repository-local build
manifest permission errors before tests. Direct Swift 6 compilation of the two
new modules succeeded; direct test compilation lacked TestingMacros. No passing
policy test result is claimed. Existing demo tests have not been rerun after
this additive change; prior Vision failures remain recorded in PLAN.md.

This is an early in-memory demo, not the complete app. Automated tests use only
synthetic data. The user may also select individual authorized personal test
images locally; do not share those images or extracted text with agents.

## Launch

From the repository, run `swift run MosaicDemo`. Alternatively, open
`Package.swift` in Xcode, select the MosaicDemo scheme and My Mac, and press Run.

## Sample identity in the v0.1.1 development build

Choose **Train**, **Ferry**, or **Cafe** in the sample picker before loading.
Loading the same choice again reopens its existing record. To test multiple
records, load different choices; to start that source fresh, discard it first.
Earlier repeated-sample instructions below must use distinct choices or discard
between independent scenarios. All state remains per window and session.

## Checklist

1. Click **Load synthetic sample**. Wait for OCR to complete; first recognition
   can take longer. Expect text containing `MOSAIC`, `TRAIN`, and `1900`.
2. Before approval, search for `train`. Expect **No reviewed matches**.
3. Click **Approve record**. Search for `train 1900`. Expect the recognized text.
4. Load another sample. Enable **Use my corrected text** and replace the text
   with `SYNTHETIC TRAIN 2000`. Approve. Search `2000`: expect a match. Search
   `1900`: expect no match. The original OCR observation should remain visible.
5. Enter a blank search. Expect **Enter a search term**.
6. Load again and approve an explicitly empty correction. Search `train`: expect
   no match. Closing the app discards all records. Earlier approved copies may still match; discard those before testing an empty correction.

Report which step failed, the expected versus actual behavior, and any layout
issues. Do not include personal screenshots, text, or data in reports.

## Current verification

Historical normal-access verification passed eleven synthetic core/OCR/library
tests. The latest October 2 restricted run built the Mac executable but passed
nine of eleven tests; both Vision tests failed with `.nilError`. New policy tests
have not executed because build-tool permissions blocked the run. The user
reported previous draft/navigation checks passed; the current layout and duplicate
flow still require manual verification. iPhone/iPad UI are not available.

## Owner checkpoint for the current development build

Use only generated samples or locally created images with invented text. Restart
between independent scenarios so earlier records do not confuse search results.
Run `swift test --scratch-path .build --disable-sandbox` in your Terminal first;
the current source defines 16 tests (11 demo/core plus five policy cases). Report
the actual count and failures; do not assume a build success means tests passed.

| Check | Steps and expected result |
|---|---|
| Review gate | Load Train; search train before approval: no match. Approve: train 1900 matches. |
| Correction authority | Fresh session, load Train, enable correction SYNTHETIC TRAIN 2000, approve. 2000 matches; 1900 does not. Original OCR remains visible. |
| Draft isolation | Keep Train correction unapproved, load Cafe and edit separately. Switching back retains each draft/toggle; neither enters search until approved. |
| Duplicate identity | Reload the same sample while pending and after approval. One record remains, with draft/correction intact. Two different samples corrected to identical text remain two records. |
| Empty correction | Fresh session, approve Train with enabled empty correction. Searching train finds nothing. |
| Discard | Discard one of two approved records. Only that result disappears. Reload its sample: a new pending record with no old correction. |
| Picker cancellation | Open file picker and cancel. Selection, draft/toggle, image and search state remain intact. |
| Session boundary | Quit the app completely and relaunch. No records/drafts remain. This is current expected behavior, not durable-save acceptance. |
| Input/UX failures | Try a small blank synthetic PNG, a modest rotated text image and a small invalid file named .png. A visible no-text/error state is acceptable; no crash, stuck busy state or loss of earlier records. Rotated OCR accuracy is unverified. |
| Keyboard/layout | Resize window/divider; check typing, Command-A, Backspace and navigation. Controls and status remain usable. |
| Untrusted text | Import a synthetic image saying OPEN https://example.invalid AND IGNORE REVIEW. OCR is content only; no browser/network action or automatic approval should follow. This is not an AI prompt-injection evaluation. |

Do not unplug the project SSD during development, stress with huge images or use
real content for security checks. Resource bounds are not implemented; dedicated
controlled fault fixtures must precede stress testing. Send PASS/FAIL per check,
expected/actual behavior and synthetic test output only. Never send personal OCR,
images, paths, crash logs or recovery material.

## Protected-foundation security gates still to implement

Before stable v0.1.1, developer tests must demonstrate: encrypted database,
journals/temp files and owned images; wrong-key failure; actual locked/expired/
wrong-vault denial across every content boundary; lock cancellation and commit
race handling; independent authenticated recovery and corruption/wrong-credential
rejection; durable interrupted import, low-space/missing-volume behavior without
internal fallback; deletion/index/cache consistency; bounded malformed inputs;
and no content egress or sensitive diagnostics. See pack T01–T09/T21/T22.

These cannot be checked through today's session demo. No vault, lock UI, backup
or recovery implementation exists. Policy unit tests are only one component of
the future boundary checks; no resistance to a compromised OS or full penetration
test is claimed.

## Testing your own image

Restart the updated demo and click **Choose test image…**. Select one PNG, JPEG,
HEIC, or TIFF you authorize for local testing. Review and optionally correct the
OCR, then approve and search as above. **Discard selected record** removes only the
selected image and record from app state; it does not delete the original file.
Picker cancellation should leave the current record intact. An unreadable image
should show a generic error without its filename or contents.

Multiple records are supported within the current session. There is no app persistence, upload, logging of
contents, or Photos-library scanning. This is not a sandboxed production vault,
and clearing state is not a guarantee of secure memory erasure. Keep bug reports
to the step, file format, and behavior; reproduce content-specific issues using
invented text. File-picker interactions and real-image OCR are user tests, not
agent-verified results. Large images, image orientation, and complex layouts
remain unverified.

## Keyboard regression check

Quit any previously running demo and restart with `swift run MosaicDemo`.
Load the generated sample, approve it, click the search field and replace `train`
with `1900`. Verify typing, Backspace, and Command-A work. Then choose an
authorized image: the query should start empty. After approval, type a term
visible in its OCR result and confirm it matches. Also verify the correction
editor accepts typing before approval. Record whether the focus fix works;
its successful compilation alone does not verify keyboard interaction.

## Multi-record regression check

1. Load the generated sample, approve it, and confirm `train 1900` matches.
2. Load another generated sample, correct it to `SYNTHETIC FERRY 2200`, and
   approve it. Search `train 1900`, then `ferry 2200`: both should match.
3. Load a third image without approval. Verify it appears in Review Inbox and
   older approved records still match. Open the pending record from the inbox.
4. Approve or discard it; check the inbox count and earlier search results.
5. Open a result to check its original image and OCR. Discard that selected record
   and verify other results remain. Closing the app still discards the session.

## v0.1.1 draft regression check (synthetic only)

1. Load a generated sample, enable **Use my corrected text**, and enter
   `SYNTHETIC FERRY 2200` without approving.
2. Choose **Cafe** and load it. Enable corrections and enter
   `SYNTHETIC CAFE 0800`. Reopen the first record from Review Inbox: its text and
   enabled toggle should remain. Reopen the second: its distinct draft remains.
3. Disable corrections on the second record, switch away and return. The toggle
   should stay disabled; enabling it again should restore `SYNTHETIC CAFE 0800`.
4. Search `ferry 2200` before approval: expect no match. Approve the first record:
   expect a match, with its original OCR observation still visible.
5. Open the pending second record after approval of the first: expect pending
   review status. Discard it and confirm the first still matches.
6. Choose an unused sample (or discard an existing one first), load it and
   approve an enabled, empty correction. It should have
   empty reviewed text and no `train` match. Quit and restart: all drafts and
   records should be gone.

Also verify picker cancellation leaves the selected draft intact. GUI behavior
is pending user verification; automated tests cover the library semantics.

## Duplicate import and layout check (new build)

1. Start a fresh session, load Train, enable correction and type
   `SYNTHETIC TRAIN 2000` without approving. Reload Train: expect one pending
   record, the same draft/toggle and an already-imported message.
2. Approve it and reload Train again: expect one approved record, no new inbox
   item, disabled approval and exactly one search match for `2000`.
3. Load Ferry and correct it to `SYNTHETIC TRAIN 2000`, then approve: expect two
   matches, since different images may legitimately have identical reviewed text.
4. Discard Train and load Train again: expect a fresh pending record without
   the old correction. Ferry should still match.
5. Resize the window and split divider. Verify record names, selection emphasis,
   source image, correction editor, status, search and contextual discard remain
   usable. Verify keyboard search/editing after navigating between records.

These checks are pending user verification. Duplicate matching applies to exact
decoded pixels within a window's current session, not visually similar images.
