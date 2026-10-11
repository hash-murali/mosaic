# Project Mosaic plan

- [v0.1.1-20261011-rc-71-native](evidence/builds/v0.1.1-20261011-rc-71-native.md): Final candidate audit and native checks. PASS: current unsigned native xcodebuild;two publication probes;four process scenarios;24 development-pack checks and9 logical-schema checks;git diff --check. Commands native as launch68, python3 Tests/RegressionProbes/verify_open_publication.py, .build/debug/MosaicRecoveryCheck, python3 mosaic-development-pack/scripts/validate_pack.py, python3 mosaic-development-pack/database/check_logical_schema.py. Output .verification/rc-final-native-20261011.txt; Debug app-bearing dylib SHA25625d6cbec349aa14848394af47164c3cb5e4b262213e45631acd7b421d7574bab. Scoped FINAL-AUDIT.md complete with source-only review/limits. GitHub deferred issue create403; ticket reorganization BLOCKED, not completed. Owner authorizes commits/publication to move version with deferred checks; candidate label preserves remaining validation risks.

- [v0.1.1-20261011-rc-70-tests](evidence/builds/v0.1.1-20261011-rc-70-tests.md): Release-candidate full verification. PASS: fresh full SwiftPM build3.79 seconds;59 tests (18core,sixpolicy,11storage,11application,13actual-model), zero failures. Output .verification/rc-final-tests-20261011.txt; full local-cache command. Packaging label/version changed to v0.1.1-rc.1; Info build70. Owner explicitly defers consolidated native/fault/device inspection, D025, DEFERRED-VALIDATION checklist. Reminder created, stale foundation-resume automation removed. No skipped test converted to PASS; synthetic-only candidate, not fully validated stable.

- [v0.1.1-20261011-owner-69](evidence/builds/v0.1.1-20261011-owner-69.md): Owner confirms unlock lock and restart persistence. OWNER-REPORTED PASS: authentication/locking hides protected content, and approved content survives restarting. Owner says independent backup/restore has not been tested. Exact signed owner binary identity is unverified; current repository fingerprint is documentation context, not proof of the owner executable. No new application build/tests: not applicable to this report-only checkpoint. Do not infer system/idle/cancel lock, delete, physical storage/peak-memory, clean-user recovery or full signing acceptance from these two statements. Do not repeat passed owner checks without relevant changed behavior. Prior package-launch/keyUnavailable failure remains historical; current report supplies successful native interaction evidence without credential inspection.

- [v0.1.1-20261011-launch-68-native](evidence/builds/v0.1.1-20261011-launch-68-native.md): Native launch-guidance build. PASS: unsigned native xcodebuild succeeds, two publication probes PASS;59-test suite at67. Output .verification/launch-native-20261011.txt. Debug app-bearing dylib SHA256 3a65a8e63187a3cd3769572b092652cf403e32feafb4d0093ae2b158cfc7af84. Owner running MosaicDemo package executable; direct them to existing MosaicNative.xcodeproj scheme MosaicNative/My Mac. Guard prevents package password prompt and explains correct launcher, but does not establish valid signing or actual key availability. Focused signed-native attempt remains pending; no credential/runtime store inspection.

- [v0.1.1-20261011-launch-67-tests](evidence/builds/v0.1.1-20261011-launch-67-tests.md): Package launch guard validation. PASS: full SwiftPM build3.55 seconds;59 tests (18 core,six policy,11 storage,11 application,13 actual-model), zero failures. Output .verification/launch-tests-20261011.txt. Native bundle precondition runs before LAContext/password prompt; package launcher reports Open MosaicNative.xcodeproj, run MosaicNative/My Mac. Pure synthetic URL regression checks rejection/necessary app-bundle case. App-bundle presence is not signing proof, credential access or native acceptance. Previous keyUnavailable root cause remains unknown; no reset/key deletion/fallback.

- [v0.1.1-20261011-launch-66-red](evidence/builds/v0.1.1-20261011-launch-66-red.md): Package launcher clarification regression. Owner clarifies running MosaicDemo, the SwiftPM executable, not MosaicNative app. This does not establish supported native signing/Keychain access; root cause of generic keyUnavailable still not inferred. Source launch configuration confirms MosaicNative scheme exists, no signing credentials inspected. EXPECTED FAIL filtered compile: requireNativeApp/nativeAppRequired missing, zero tests executed. Output .verification/launch-red-20261011.txt. Synthetic nonexistent URLs only; no platform authentication.

- [v0.1.1-20261011-key-65-native](evidence/builds/v0.1.1-20261011-key-65-native.md): Native unlock diagnostic build. PASS: current unsigned native xcodebuild succeeds; two publication probes PASS. Output .verification/key-diagnostic-native-20261011.txt. Current app-bearing Debug dylib SHA256 a7f4875ebdf71876fe92cb897ff44a16289600d0ce27d739a7c7bd55d51bf4e2. Full58-test suite at64. Focused owner recheck required only to obtain new fixed error label after rebuilding signed Xcode app, not to repeat whole manual suite. Native unlock remains OWNER-REPORTED FAIL at63; root cause not established. No keys, queries, signing credentials, user profiles or runtime vaults inspected.

- [v0.1.1-20261011-key-64-tests](evidence/builds/v0.1.1-20261011-key-64-tests.md): Safe Keychain status differentiation. PASS: completed full SwiftPM build3.37 seconds;58 synthetic tests (18 core,six policy,11 storage,10 application,13 actual-model), zero failures. Output .verification/key-diagnostic-tests-20261011.txt. Adapter classifies missing item/signing entitlement/auth/interaction/invalid32-byte material and unknown integer OSStatus, no raw errors/queries/key/account logging. Fixed constants and invented bytes only; no platform custody object instantiated or Keychain calls in test. Root cause of owner unlock failure remains unknown; changed native build pending. No automatic key regeneration/deletion/fallback.

- [v0.1.1-20261011-key-63-red](evidence/builds/v0.1.1-20261011-key-63-red.md): Owner unlock failure diagnostic regression. OWNER-REPORTED FAIL: password prompt completes but protected workspace remains locked with keyUnavailable. Only supplied sanitized app error used; no screenshot OCR/personal content or Keychain inspection. EXPECTED FAIL: filtered SwiftPM diagnostic test compile fails on missing validatedKey and distinct SessionFailure cases; zero tests executed. Output .verification/key-diagnostic-red-20261011.txt. Current adapter hides SecItem result status, so missing item, signing/access denial and invalid key material are indistinguishable; root cause not known. Usual-versus-new local Mac user question pending.

## October 11 — v0.1.2 product planning direction

D-028 records owner approval to make regular and protected/vault locking optional
Settings preferences. Exact modes/defaults and storage/key-custody implications
remain design work; no plaintext or automatic weaker fallback is authorized.
Enabled manual locks still lead to the dedicated lock screen. Documentation-only
follow-up: git diff --check passed; no app build/tests, app tests not applicable.

D-027 adds owner-directed app-lock presentation, immediate scanned-item Library
visibility with contextual verification, reduced incidental metadata and grouped
nested Settings. Proposed v0.1.2 experience scope; source-retention/default
auto-delete behavior and version allocation remain open. Retention requires a
separate storage/backup design; no deletion or application changes performed.
Documentation-only follow-up; git diff --check passed, app tests not applicable.

Owner follow-up selects Visual library as the layout reference (D-026). Colors
remain open for later refinement; user-selectable appearance is an option to
evaluate. Selection does not approve a final spec or all demonstrated features.
Documentation-only follow-up: git diff --check passed; no app build or tests
were run, and app tests are not applicable.

D-025 records the owner's project-wide platform order: iOS, then Mac, then other
platforms, with a content-first single-workspace experience. Two synthetic
interactive concept previews explore visual browsing and reading-oriented
browsing, including contextual detail, multi-file intake and label preferences.
Layouts and additional file support remain proposals; v0.1.2 scope is not yet
approved. Existing v0.1.1 acceptance remains separate. No application code,
build, dependency, or runtime data changed in this planning chat. Documentation
checks only; app tests are not applicable. No GitHub task status was changed.


- [v0.1.1-20261011-review-62](evidence/builds/v0.1.1-20261011-review-62.md): Release gate reconciliation and fault-drill preparation. Documentation-only: git diff --check PASS; no new application build/tests applicable. Current completed baseline57 tests, native build, two probes and four process scenarios at60/61. README/decisions/inspection/PLAN/scoped audit updated; checkpoint54 invalid claim corrected in summaries. Review finds no remaining concrete P1/P2 after recovery fix in examined source. Prepared evidence/releases/v0.1.1/FAULT-DRILL.md for explicit artificial-volume mounting authorization; not executed. Independent-user recovery setup question pending; native/physical/peak-memory and GitHub403 release gates not waived. v0.1.2 design remains deferred until current stable closure.

- [v0.1.1-20261011-recovery-61-native](evidence/builds/v0.1.1-20261011-recovery-61-native.md): Final current native and source review checkpoint. PASS: final unsigned native xcodebuild succeeds; two publication probes and four synthetic independent-process/crash checks PASS. Output .verification/recovery-native-20261011.txt; commands as foundation-58. Current application-bearing Mosaic.debug.dylib SHA-256 70bd567ba2a8323a1159de81583e64865776bf76f47dc63f9cf6580db8e74c84. Launcher hash alone is inadequate debug identity. Full57-test suite PASS at60. Source-only scoped reviewer finds no remaining P1/P2 in current fixes; earlier recovery issue resolved using new custody UUID. Signed native, physical storage/peak-memory, independent native recovery, GitHub ticket writes and stable publication remain unaccepted.

- [v0.1.1-20261011-recovery-60-tests](evidence/builds/v0.1.1-20261011-recovery-60-tests.md): Fresh restored vault custody. PASS: completed full SwiftPM build 6.96 seconds; 57 tests (18 core, six policy, 11 storage, nine application, 13 actual-model), zero failures. Output .verification/recovery-final-20261011.txt. Restore now allocates new destination vault UUID before custody creation and changes encrypted staged identity only, preserving owner, original store and backup. Regression succeeds with custody rejecting the original UUID; new identity opens/searches correctly. Original restore identity equality contract intentionally replaced by fresh identity; actual-model Settings restore passes. Does not substitute for signed native/clean-user recovery.

- [v0.1.1-20261011-recovery-59-red](evidence/builds/v0.1.1-20261011-recovery-59-red.md): Independent restored custody regression. EXPECTED FAIL: two filtered application tests execute; restored-identity inequality fails and unavailable-original-custody test throws keyUnavailable. Output .verification/custody-red-20261011.txt records duration. Scoped source audit found restoration reuses backup vault UUID for destination custody, so Apple duplicate-item path can depend on original Keychain. New restored UUID required; do not overwrite or read original item as recovery fallback. No real credentials accessed.

- [v0.1.1-20261011-foundation-58-native](evidence/builds/v0.1.1-20261011-foundation-58-native.md): Current native and process verification. PASS: current unsigned native build succeeds; two lock-publication probes and four independent synthetic process/crash scenarios pass. Commands: xcodebuild as settings-41, python3 Tests/RegressionProbes/verify_open_publication.py, .build/debug/MosaicRecoveryCheck. Output .verification/foundation-native-20261011.txt. Full suite56 PASS at57. Final source-only re-review of import/location/cancellation finds no remaining important defects in those changes. Native Debug launcher hash is unchanged because current application code is linked in Mosaic.debug.dylib; record its hash in final review, launcher alone is insufficient native build identity. No OS credentials/authentication or physical-volume/clean-user recovery tested.

- [v0.1.1-20261011-foundation-57-tests](evidence/builds/v0.1.1-20261011-foundation-57-tests.md): Complete current synthetic suite. PASS: actual completed full SwiftPM build 7.05 seconds, 56 tests (18 core, six policy, 11 storage, eight application, 13 actual-model), zero failures. Output .verification/foundation-full-20261011.txt; full local-cache command as import-44. Covers selected import/dedup/search/lock, chosen-folder persistence, restore-before-first-unlock success and correct profile destination, corrupt bookmark refusal, read cancellation, immediate lock/reopen and prior custody-close regression. Checkpoint 54 remains explicitly invalid; 55 corrects its premature PASS. Native rebuild/final review pending; native auth/physical faults/independent device recovery not inferred.

- [v0.1.1-20261011-lock-56-filtered](evidence/builds/v0.1.1-20261011-lock-56-filtered.md): Immediate-lock regression checks. PASS: two immediate open/lock/reopen and restore/lock/reopen model tests pass (0.137 seconds); output .verification/lock-cycle-red-20261011.txt. Despite filename red, run was queued until preceding hang terminated and executed after capture-prior-lock fix; no dynamic red proof claimed. Reviewer reasoning identified mutual-await cycle. Directory configuration handling now centralized to preserve existing directories and reject missing parents. Additional cancellation/corrupt-bookmark tests pending validation.

- [v0.1.1-20261011-location-55-correction](evidence/builds/v0.1.1-20261011-location-55-correction.md): Correct failed run and immediate-lock cycle. FAIL/TERMINATED: checkpoint 54 PASS claim was premature and invalid, explicitly corrected in that evidence file. Actual .verification/location-final-tests-20261011.txt shows model failures and controlled-custody hang; only own SwiftPM/test child terminated. Filtered red run was queued behind its scratch-path lock and had not executed. Review proves open/restore read mutable locking task and can mutually await cancelled operation; capture prior closing task before scheduling. Existing default directories must not be recreated with intermediate=false; fixture producer now creates its own parent. Fresh validation pending; no passing claims carried forward.

- [v0.1.1-20261011-location-54-tests](evidence/builds/v0.1.1-20261011-location-54-tests.md): Restore destination fix validation. INVALID PREMATURE PASS CLAIM: actual run failed and hung; see corrected checkpoint54 and follow-up55. The originally reported52-test pass must not be used as evidence. Actual-model backup/restore-before-first-unlock now creates selected-folder active profile and reopens restored accepted correction. Synthetic fake custody only. Source-only re-review identifies new P1 immediate open/lock or restore/lock mutual-await deadlock; not release ready, next regression pending.

- [v0.1.1-20261011-location-53-rootcause](evidence/builds/v0.1.1-20261011-location-53-rootcause.md): Restore destination rejection identified. FAIL: isolated one-test build 2.22 seconds, three assertions fail. Bookmark resolves without staleness; proposed nonexistent directory URL comparison fails because symlink resolution removes the directory trailing-slash representation. Backup succeeds. This pinpoints invalidConfiguration before restore I/O; comparison should use standardized filesystem paths while retaining symlink rejection. Output .verification/location-paths-20261011.txt. No personal runtime artifacts inspected.

- [v0.1.1-20261011-location-52-boundaries](evidence/builds/v0.1.1-20261011-location-52-boundaries.md): Backup-versus-restore boundary diagnosis. FAIL: isolated regression build 5.36 seconds; one test fails with two assertions. Backup success and file existence assertions pass; restore reports sanitized invalidConfiguration, and no active-profile pointer is published. Output .verification/location-boundaries-20261011.txt. Production restore now reports fixed enum codes only, not raw Foundation errors or key/content. Root cause investigation continues.

- [v0.1.1-20261011-location-51-diagnose](evidence/builds/v0.1.1-20261011-location-51-diagnose.md): Restore-path failure reproduced. FAIL: isolated model restore regression executes one test, build 2.18 seconds, two assertions fail. Model reports sanitized restore-failed status; opening preserved original collection must not count as recovery success. Output .verification/location-diagnose-20261011.txt. Further boundary diagnosis required; no additional source fix claimed.

- [v0.1.1-20261011-location-50-fail](evidence/builds/v0.1.1-20261011-location-50-fail.md): Restore regression exposes incomplete fix. FAIL: SwiftPM build 7.05 seconds, 52 tests executed; 51 pass, restore-before-first-unlock test fails because selected-folder active-profile pointer is absent. Current restore appears not to have completed; opening existing original content is not sufficient proof of restore. Output .verification/location-review-green-20261011.txt. Diagnosis and green validation pending. No native recovery acceptance inferred.

- [v0.1.1-20261011-location-49-red](evidence/builds/v0.1.1-20261011-location-49-red.md): Restore-location regression. EXPECTED FAIL: filtered SwiftPM compile missing backupSelectedFile/restoreSelectedBackup; zero tests executed. Output .verification/location-restore-red-20261011.txt. New actual-model synthetic backup/restore-before-first-unlock test asserts selected folder receives restored profile and default folder does not. Independent reviewer identified the underlying restore path defect. Fix pending.

- [v0.1.1-20261011-location-48-native](evidence/builds/v0.1.1-20261011-location-48-native.md): Native folder-selection build and review. PASS: unsigned native xcodebuild and both lock-publication probes. Command same local-cache native invocation plus python3 Tests/RegressionProbes/verify_open_publication.py; output .verification/location-native-20261011.txt. Reviewer finds P1 restore-before-unlock ignores persisted location and P2 detached import cancellation/resource-lifetime gaps. These are unresolved findings at this checkpoint; compiled does not mean release-ready.

- [v0.1.1-20261011-location-47-tests](evidence/builds/v0.1.1-20261011-location-47-tests.md): Settings vault-folder integration. PASS: full SwiftPM build 5.42 seconds; 51 tests (17 core, six policy, 11 storage, eight application, nine actual-model), zero failures. Same full local-cache command; output .verification/location-green-20261011.txt. Owner-selected existing directory stored as bounded security-scoped bookmark, resolution disables UI and mounting; stale/unavailable/symlink paths reject, selection requires locked state, no content migration. Synthetic model tests verify remembered correction, default-root absence, and locked/location guards. Native rebuild and review pending; real unplug/disk-full/independent native recovery not accepted.

- [v0.1.1-20261011-location-46-red](evidence/builds/v0.1.1-20261011-location-46-red.md): Vault location regressions. EXPECTED FAIL: filtered SwiftPM test build cannot compile missing useVaultFolder; zero tests executed. Command local-cache swift test --filter chosenVaultFolder|unavailableSelectedFolder|vaultFolderChange. Output .verification/location-red-20261011.txt. Fresh generated directories only; tests require persisted selected collection, no fallback at absent folder, and locked existing-folder selection. No runtime profiles inspected.

- [v0.1.1-20261011-import-45-native](evidence/builds/v0.1.1-20261011-import-45-native.md): Native selected-image import build. PASS: unsigned native xcodebuild succeeds, no authentication or Keychain interaction. Command as settings-41 with CODE_SIGNING_ALLOWED=NO; output .verification/import-native-20261011.txt. Application source matches import-44; subsequent location tests are test-only and not yet compiled. Native file-picker and signed UI acceptance remain pending.

- [v0.1.1-20261011-import-44-tests](evidence/builds/v0.1.1-20261011-import-44-tests.md): Selected synthetic import integration. PASS: full SwiftPM build completes in 5.53 seconds; 48 tests (17 core, six policy, 11 storage, eight application, six actual-model), zero failures. Same local-cache full suite command as settings-40; output .verification/import-green-20261011.txt. Selected invented PNG/JPEG file capability is bounded and decoded off main actor before authenticated receive; no scanning. Tests verify encrypted receipt, processing, accepted correction/search, exact duplicate retention, locked refusal, and invalid bytes adding no record. Native rebuild and picker acceptance pending. GitHub create FORBIDDEN (403).

- [v0.1.1-20261011-import-43-red](evidence/builds/v0.1.1-20261011-import-43-red.md): Selected synthetic import regressions. EXPECTED FAIL: SwiftPM test build fails because importSelectedFile is not implemented; zero tests executed. Command: local-cache swift test --disable-sandbox --skip-update --filter selectedSyntheticFile|invalidSelectedFile, output .verification/import-red-20261011.txt. Two actual-model tests use generated PNG and invalid invented bytes, fake custody and fresh fixture roots. GitHub issue creation again returns FORBIDDEN (403); no issue created. Installed Superpowers and GitHub confirmed; no dependency or permission changes.

- [v0.1.1-20261008-settings-42-review](evidence/builds/v0.1.1-20261008-settings-42-review.md): One-app objective and bounded-review reconciliation. Documentation-only: no new build/tests; git diff --check PASS. D-023 records owner one-app/Settings/badge direction, implemented current flow and Codex five-case review policy. PLAN reconciles each v0.1.1 objective; inspection stores one final batch, old lists historical rather than repeated homework. Current automated baseline 46 tests and two probes; native current application compiled at 41. Optional tags/reminders/intelligence remain explicit deferred TODOs. No manual review requested now; storage/import, native/fault/independent recovery and final release audit remain required.

## October11 — Owner confirms two protected-workflow checks

Owner reports authentication/locking hides content and approved content survives
restart PASS. Independent backup/restore is NOT TESTED. Evidence owner-69 records
owner attribution and unverified exact signed binary identity; no fresh agent build
or test applies. Preserve earlier unlock failure as historical, without claiming
a proven root cause. Do not ask owner to repeat these passing cases unless changed.
Other native/fault/independent recovery/GitHub publication gates remain pending.

## October11 — Candidate checkpoint and explicit deferred validation

Owner requests deferral of local-user recovery/storage-full/disconnection and a
consolidated checklist/reminder; D025 records that sequencing change. Current
candidate v0.1.1-rc.1 remains synthetic-only, not fully validated stable. Final
scoped audit and59 fresh tests/native/probes/process/pack/schema checks PASS at70/71.
Native/hardware/peak-memory acceptance remains in DEFERRED-VALIDATION, not PASS.
Weekly quiet reminder installed; obsolete foundation-resume monitor removed.
GitHub issue creation still403; commit/push and PR publication results to follow.
Next design v0.1.2 is documented; no unimplemented feature enabled by this handoff.

## October11 — Owner confirms package executable launch

Owner says they ran MosaicDemo. Correct protected native target is MosaicNative
in MosaicNative.xcodeproj, destination My Mac, app product Mosaic. Current guard
rejects non-app bundle before LAContext evaluation and gives that instruction.
59 tests/native unsigned build/two probes PASS at67/68; actual supported signed
native unlock remains pending. App-bundle predicate does not verify signing.
This clarifies launch requirements, not a proven repair of missing Keychain key.

## October11 — Native unlock failure remains under diagnosis

Owner reports password prompt followed by keyUnavailable and locked workspace.
This is current native acceptance FAIL, not a completed unlock pass. The adapter
previously discarded SecItem status; fixed enum/integer classification now separates
missing item, missing signing entitlement, denied/interaction access and invalid
key bytes. No credential/key/query logging or automated key replacement introduced.
58 tests and unsigned native build plus two publication probes pass at64/65; tests
make no Keychain calls. These do not fix or accept the native failure by themselves.

One focused recheck: owner rebuilds/runs the same Xcode target and tries unlock once,
reports only sanitized error word/code and usual-versus-new local Mac login. This
is necessary diagnosis of the failed native case, not repeated full manual review.
Do not delete keys, reset the vault or create a fallback while diagnosing.

## October 11 — Remaining integration built; release acceptance still open

Selected invented PNG/JPEG import and supported remembered vault-folder selection
are implemented (D-024). Main Inbox/Library/Search keep one protected collection.
Restore-before-unlock respects that folder; new restored vault identity removes
original-custody dependency. Lock cancels imports, balances folder access after
closure and serializes immediate reopen without a wait cycle.

Agent-verified current results:57 synthetic tests, unsigned native build, two
publication probes and four process crash/recovery scenarios PASS at60/61. Scoped
source review found no remaining important defect in reviewed changes after fixes;
this is not independent native/device acceptance. All failed attempts preserved;
54's premature PASS is explicitly invalid and corrected at55.

Remaining stable gates: signed final native acceptance; physical volume/OS ENOSPC
and peak-memory evidence; clean-user/device recovery with no original custody;
GitHub issue/milestone reconciliation (create remains403), then authorized stable
commit/push/merge, immutable annotated tag and GitHub Release. No release or main
merge yet. Broader content-first/icon/separate-edit-window design remains v0.1.2;
planned optional features retain TODOs and are not enabled by this patch.

One final owner batch remains capped at five cases. Routine builds are automated.
Environment setup is a dependency, not repeated manual homework. A separate macOS
user can supply independent recovery evidence without buying/using a second Mac;
owner availability is pending. Do not collect keys/accounts/content.

## October 8 — One-window product correction and manual review budget

D-023 implements owner's one-app brief: single main window; Settings unlock/lock
and inline recovery; small vault badges; old separate memory/recovery workflow
removed. Existing synthetic protected profiles remain at the same location; no
personal migration. 46 tests plus two publication probes PASS, native unsigned
build PASS. Actual-model tests caught and fixed lock/reopen overlap by awaiting
old handle/custody closure. Evidence settings-36 through settings-41 preserves
failed attempts and passes. Current signed native acceptance still pending.

Owner manual policy: one final release-candidate batch of five checks, delivered
in chat when ready. Routine builds use tests/probes/model automation and append
inspection/evidence; no repeated owner checklists. Retest only a failed affected
native case with a reason. Missing hardware/clean-user-device evidence remains
unaccepted; review cap is not a waiver. No final batch requested now.

### v0.1.1 objective reconciliation

| Objective | Current evidence | Remaining |
|---|---|---|
| One protected Mac workspace | Implemented; shared tabs, Settings/badges, native compile | Final signed one-window interaction acceptance |
| Owned capture/local OCR/review/edit/search/delete | Synthetic pipeline/model/service tests PASS | Implemented at60/61; final native picker/bookmark acceptance pending |
| Lock/key custody | Device-only user-presence adapter, policy and actual model regressions | Native auth/cancel/system/idle/visibility checks not fully accepted |
| Durable processing/migration/fault safety | Retry/abrupt exit/schema/SQLite-full/identity-loss tests | Physical volume/OS ENOSPC/peak-memory acceptance |
| Independent backup/restore | Synthetic independent custody PASS; owner same-Mac retry PASS | Native clean-user/device recovery without original custody |
| Stable finalization | Scoped pre-release inventory; immutable v0.1.0 preserved | Final audit, native gates, GitHub issue/write access, commit/push/merge/tag/release |

v0.1.1 remains unfinished. Broader content-first styling stays v0.1.2. The owner
conditionally authorizes stable publication/merge; no tag, merge or push before
mandatory gates pass. GitHub issue creation returned 403, not permission success.


- [v0.1.1-20261008-settings-41-native](evidence/builds/v0.1.1-20261008-settings-41-native.md): One window with Settings vault controls. PASS: current unsigned native app build succeeds; two publication probes PASS; full suite 46 tests PASS at settings-40-tests. Single Window scene, shared protected Inbox/Library/Search plus Settings, vault source badges, no old memory/recovery windows. Default product still uses platform custody; actual-model tests use injected fake custody and generated roots only. Native signing/UI and remaining release gates not accepted. Command as workspace-33-native; AppIntents metadata skip warning only.

- [v0.1.1-20261008-settings-40-tests](evidence/builds/v0.1.1-20261008-settings-40-tests.md): Single-window actual-model automated suite. PASS: full build (1.76 s), 46 tests (17 core/six policy/11 storage/eight application/four actual app-model), zero failures. Model tests run fake custody and generated AppKit images, no native window or Keychain interaction. Save/search/preview/lock/reopen, recovery/draft clearing and controlled delayed closure verified. One window + Settings/vault badges implemented; old memory/recovery scenes and legacy demo UI removed. Current native build pending.

- [v0.1.1-20261008-settings-39-lock](evidence/builds/v0.1.1-20261008-settings-39-lock.md): Serialize lock completion before reopening. PASS: isolated actual-model regression now passes (one test, build 5.12 s) after waiting for previous storage/custody closure before open. Earlier deterministic failure preserved at 37/38. Single-window main Settings/protection/recovery implementation and actual model test injection use default platform custody in product; fake custody in tests only. Full suite and native compilation pending.

- [v0.1.1-20261008-settings-38-diagnose](evidence/builds/v0.1.1-20261008-settings-38-diagnose.md): Isolated model reopen diagnosis. FAIL: isolated model test reproduces reopen with sanitized invalidKeyOrCorruptStore; build 4.80 s, one test fails with two assertions. Actual model locks UI immediately but launches database/custody closure asynchronously; next open currently does not await closure. Hypothesis: overlapping encrypted handles during immediate reopen. No personal artifacts or raw Keychain data inspected.

- [v0.1.1-20261008-settings-37-fail](evidence/builds/v0.1.1-20261008-settings-37-fail.md): Actual model tests expose reopen failure. FAIL: build succeeds (3.87 s), 45 tests executed; 44 pass and one actual-model reopen test fails with two expectations. Storage/policy/core/application suites pass; opening after immediate lock leaves model locked. Injected fake custody/generated root only, no native Keychain. New automation catches a model issue not covered by prior service tests. No current UI acceptance or stable claim.

- [v0.1.1-20261008-settings-36-red](evidence/builds/v0.1.1-20261008-settings-36-red.md): Single-workspace Settings model regressions. EXPECTED FAIL before implementation: injectable model initialization and Settings tab missing; zero executed tests. Added a model test target dependent on current app executable, no new external dependency. Regressions will exercise actual model save/search/preview/lock/reopen with fake custody and generated samples. User explicitly requested one app, vault badge and Settings protection. Command local-cache SwiftPM --filter mainModel|settingsIs. No native window/Keychain opened.

- [v0.1.1-20261008-review-35](evidence/builds/v0.1.1-20261008-review-35.md): Pre-release integration review and handoff. Documentation-only review: no new app build/test; git diff --check PASS. Updated D-022, README/NEXT/ROADMAP/policy contract and pre-release artifact/data-flow/dependency review. Current automated baseline remains recovery-34 (42 tests); current application native bundle from workspace-33, SHA-256 recorded separately. Main workspace now protected; signed owner revalidation requested. Remaining software includes supported vault location/selected synthetic import and final audit; hardware/native/independent recovery gates unaccepted. GitHub create returned 403; no issue or stable publication claimed.

- [v0.1.1-20261008-recovery-34](evidence/builds/v0.1.1-20261008-recovery-34.md): Recovery fault checks after integration. PASS: full build (2.27 s), 42 tests (17 core/six policy/11 storage/eight application), zero failures. Added meaningful existing-behavior checks: varied synthetic recovery bytes, authentication denial and snapshot tampering publish no destination and preserve original backup/source. Application source unchanged from workspace-33 native build; tests changed only. Command same full SwiftPM local-cache invocation. Native owner revalidation requested; prior owner passes not applied to changed workspace.

- [v0.1.1-20261008-workspace-33-native](evidence/builds/v0.1.1-20261008-workspace-33-native.md): Native shared workspace build. PASS: current unsigned native build succeeds; two opening-publication regression scenarios pass. Full suite 41 tests PASS at workspace-32-green. Native command as lock-26-native; AppIntents metadata skipped warning only. Exact signed owner build not verified; new main tabs/lock/recovery need owner revalidation. Existing current personal-image memory demo is separate and never migrated.

- [v0.1.1-20261008-workspace-32-green](evidence/builds/v0.1.1-20261008-workspace-32-green.md): Shared protected main screens. PASS: full build (4.45 s), 41 tests (17 core/six policy/11 storage/seven application), zero failures. New workspace tests cover pending/accepted/search/delete consistency and locked projections. Main WindowGroup now shares ProtectedDemoModel across Inbox/Library/Search; personal-image memory demo moved to separate explicit window. Existing APIs/custody/backup remain unchanged. Current native/owner UI acceptance pending. Command same local-cache full SwiftPM invocation as lock-25-tests.

- [v0.1.1-20261008-workspace-31-red](evidence/builds/v0.1.1-20261008-workspace-31-red.md): Main workspace test-first checkpoint. EXPECTED FAIL: new workspace tests do not compile because VaultWorkspace/Tab do not exist; zero executed tests. Command: same local-cache SwiftPM invocation as recovery-29, --filter protectedWorkspace. Owner approved shared protected Inbox/Library/Search design; no production UI implemented yet. GitHub issue creation returned FORBIDDEN (403); no ticket created.

## October 8 — Owner confirms restore retry 30

Owner confirms saved correction after unlocking a restored profile: same-Mac
synthetic recovery retry owner-reported PASS. Preserve earlier recovery-29 FAIL;
cause of that attempt not determined. No recovery source fix or new agent tests.
K06 has partial passing evidence; independent clean-user/device recovery and
remaining fault/cancellation cases still pending. K03 immediate lock visibility
and main-interface protected integration remain unfinished. Exact owner binary
unknown. Evidence owner-restore-30; no stable release claimed.

## October 8 — Native recovery failure investigation 29

Owner reports matching backup/key restore FAIL before authentication (first-page
SQLCipher validation). Current filtered generated-fixture restore test PASS: one
test, 0.65 s build, unchanged source. Not a native acceptance pass. Backup-opening
stage implicated; exact cause unknown. Save-panel/lock skip path is a read-only
hypothesis; owner did not observe backup-success status; controlled fresh-file check requested. K06 FAIL for this
attempt, K03 separately pending. Preserve owner backup/key; no agent inspection
or weak fallback. Evidence recovery-29; stable release still blocked.

## October 8 — Owner clarification 28: protected/main interface separation

Owner confirms corrected synthetic record survives quit/relaunch/unlock. Main
search does not query that protected store; ordinary import/review is independent.
This matches current harness separation, not a completed protected main interface.
Immediate manual-lock visibility remains untested. Main Library/Inbox/Search
authenticated integration remains required foundation work; cosmetic v0.1.2 deferral
does not waive it. No personal-image persistence/migration authorized. Evidence
owner-vault-28; documentation-only, no new builds/tests.

## October 8 — Owner protected-vault observations 27

Owner reports unlock, generated-sample OCR and approved-record persistence PASS.
Exact Xcode build identity unknown; signing and full native acceptance not inferred.
Lock visibility remains PENDING clarification (saved content after unlock versus
visible content while locked versus separate ordinary demo). Separate harness
edits/import restrictions are current behavior; main-interface protected integration
still unfinished. Evidence owner-vault-27; no new build or agent app tests.

## October 8 — Current lock fix/native checkpoint 26

Owner-approved opening guard fixed: an old opening result cannot publish in the
isolated regression after lock. Two probe scenarios PASS after observed red;
current full suite 39 tests PASS, current native unsigned build PASS. All attempts
recorded at lock-23-red through lock-26-native. No immediate owner test needed for
the automated fix; signed native acceptance still needed when setup is possible.
Contract/signing handoff refreshed. No protection gate waived or release claimed.

## October 8 — Lock fix full-suite checkpoint 25

Current build and 39 tests PASS (6.37 s build), plus two isolated publication
regression scenarios at checkpoint 24. Current native rebuild pending; signing
and actual UI/recovery/hardware acceptance remain unaccepted.

## October 8 — Opening publication fix checkpoint 24

Owner-approved fix checks cancellation/session before publishing loaded content.
Two isolated actual-code regression scenarios PASS after lock-23-red; current
full tests/native compilation pending. GUI/Keychain acceptance remains pending.

## October 8 — Lock regression red checkpoint 23

Owner approved bounded fix. Actual opening-code probe reproduces stale publication
after lock (expected FAIL); normal-open check not reached. Fix/green validation
pending; native scheduler not reproduced. Evidence lock-23-red.

## October 8, 2026 — Integration contract/signing review 22

Documentation-only review: policy contract refreshed to actual composition and
limitations; signing handoff added. Static dependency/pin, privacy declaration,
bundle identity/embedding and named network API checks PASS; no fresh app tests.
Owner cannot configure signing yet, so native acceptance remains pending. Source
review found potential stale publication in the UI opening path; bounded fix
proposed, not implemented or reproduced. See [review-22](evidence/builds/v0.1.1-20261008-review-22.md).
No stable closure, weak fallback or security-gate waiver.

## October 8, 2026 — Resumed verification checkpoint 21

Original SSD path available. Unchanged integration-20 source revalidated: 39
synthetic tests PASS, four separate-process recovery/crash scenarios PASS, current
unsigned native app build PASS. See [v0.1.1-20261008-resume-21](evidence/builds/v0.1.1-20261008-resume-21.md).
Native signing/Keychain/UI and clean-user/device recovery remain PENDING, together
with physical-volume/ENOSPC/peak-memory matrix and final audit/GitHub closure.
Owner account setup needed for native signing acceptance; Personal Team capability
for this exact Mac target remains unverified. No paid-membership requirement
assumed, credentials inspected, protection weakened or stable release claimed.
Content-first design remains v0.1.2. Earlier pause/results preserved below.

## October 4, 2026 — Owner-requested pause and SSD unmount preparation

Stopped at explicit owner request. Latest SwiftPM build/39 tests passed; source
saved and checkpoint integration-20 recorded. New abrupt-process drill and current
native rebuild not executed after stop request. Resume only when original SSD
and repository path are available; do not create a fallback root or mount volumes
automatically. Next: unfinished verification, supported native signing setup,
Keychain/UI/recovery acceptance, remaining fault evidence and release audit.
Broader content-first/icon/separate-window redesign is assigned v0.1.2 (D-020),
so it does not delay current foundation. No stable release/closure claimed.

## October 4, 2026 — Storage fault checkpoint 19

Build/36 tests passed. Fresh file/volume identity check closes unavailable handle
without fallback. Real SQLITE_FULL via bounded page budget preserves previous
receipt across reopen; generated-directory disappearance and relocation tested.
Physical SSD/ENOSPC/peak-memory matrix and signing still pending; fault-19 evidence.

## October 4, 2026 — Native app packaging checkpoint 18

Native Mac target built unsigned, embeds pinned SQLCipher framework; no native
authentication or signing-key access. Owner reports no Developer account; signing/
entitlement acceptance unresolved. Two non-fatal packaging warnings recorded.
Fault/volume hardening continues; native-18 identifies binary, not later source.

## October 4, 2026 — Recovery-window checkpoint 17

Built dedicated synthetic recovery window, explicit key/destination workflow,
new-profile restore and immediate lock clearing/cancellation. Build/35 tests pass.
Mac data-protection Keychain requires signed app entitlements; packaging/signing
work continues, native key access not tested. Evidence integration-17.

## October 4, 2026 — Durable recovery checkpoint 16

Build and 35 tests passed: persistent bounded retries, schema-v1 migration with
encrypted rollback snapshot, bounded catalog grant tests, scoped backup/rebuild
and read-only independent-key restore into new destination. Native recovery UI,
Keychain/signing and full fault/device acceptance remain pending. Evidence integration-16.

## October 4, 2026 — Foundation integration checkpoint 15

Implemented application/custody/OCR composition, bounded identity-catalog authority,
protected synthetic window and lock epoch guards. Build and 31 tests pass; actual
Keychain/native authentication not exercised by agent. Evidence integration-15.
Further hardening/recovery/fault acceptance ongoing; not stable.

## October 4, 2026 — Owner inspection and explicit approved tasks

- Owner reports inspection completed: G01–G06/H10–H14 checked, with annotated
  Library design feedback. Preserve owner-review-02 attribution; exact binary
  unknown. B11 duplicated by completed G04; D01–D07 covered by automated policy
  suite, not additional owner homework. E/H protection gaps still require work.
- Adopted D-017: top Library search, header count, restrained thumbnails, one
  accepted-text view, whole-row evidence expansion; grid/detail side by side on
  wide windows and stacked on narrow. Shared hierarchy applied to Inbox/Search.
- Owner then explicitly requested continued correction/discard for approved
  records through separately selected tasks in the same tab. Added Actions menu,
  isolated approved-edit drafts, Save/Cancel/blank guards, explicit source-text
  restoration and confirmed discard; ordinary approved view stays read-only.
- Build design-13 passed 27 tests; subsequent design-14 passed **28 tests**
  (15 core/five policy/eight storage). Both binaries built; source/binary digests
  and source review limits recorded. Current native GUI not inspected by agent;
  only new J01–J09 revalidation requested. Prior owner results not carried forward
  as passes for changed UI. No screenshot OCR/content saved as fixtures/evidence.
- Stable release still requires OS key custody/authentication and app lock,
  persistent durable workflow/retry/cancellation, recovery UX and independent
  credential/device drill, storage fault/migration evidence, final scoped audit,
  GitHub reconciliation and immutable release publication. No date/percentage
  or stable closure claimed. Future capabilities remain disabled/TODO-marked.


## October 4, 2026 — Encrypted storage and recovery integration

- User approved repository-local official SQLCipher.swift Community Edition
  4.19.0 dependency download (D-015); exact pin and license attribution recorded.
  Normal-access tool execution resolved earlier compiler sandbox restrictions;
  no permission changes. Fixed actual mutating-test-macro/header compilation errors.
- Implemented synthetic-only encrypted source/metadata/FTS adapter, durable receipt
  stage, correction/delete transactions, revision guards, bound untrusted text,
  independent-key snapshots and integrity checks. ProtectedVault coordinates
  synchronous scope validation/SQLite operations and lock on one actor; encrypted
  identity binding, scoped search and dedupe disclosure guards tested (D-016).
- Added bounded PNG/JPEG intake and EXIF normalization, encoded/dimension/session
  limits; HEIC/TIFF intentionally disabled/TODO. Actual orientation/peak-memory/
  fault/cancellation evidence still pending.
- Current [storage-12](evidence/builds/v0.1.1-20261004-storage-12.md): 27 tests PASS
  (14 core, five policy, eight storage), 24 pack checks PASS, independent creator/
  restorer process drill PASS without Keychain. Source/binary/pin digests recorded.
  Earlier attempts 05–11 preserve failures/counts; intermediate fingerprints were
  not captured and are explicitly limited. Inspection and audit updated.
- Owner has no second Mac; iPhone SE 2020 may be available but no iOS restore
  target exists. Process recovery is useful evidence, not a separate-device/clean-
  user acceptance pass or approved waiver.
- Demo still session-only; OS authentication/key custody, application persistence/
  lock/cache clearing, durable workflow UI/retry, scoped enumeration/backup,
  recovery UX and volume/fault/migration evidence remain incomplete. No stable
  closure/tag/release claimed. GUI G/H acceptance, scoped final audit and GitHub
  reconciliation remain pending. Tags/similarity/preferences remain proposals.


## October 4, 2026 — Automated recheck and release closure assessment

- At owner's request reran applicable automated checks on unchanged design-03
  source. Pack validator passed all 24 checks; direct Swift 6 Core/Domain/Policy
  modules compiled; isolated style type-check, syntax and whitespace checks passed.
- Full SwiftPM suite again blocked by XCBuild manifest write permission error,
  before any tests executed. No current 17-case test pass claimed; latest GUI and
  independent recovery need manual/platform verification when available.
- Linked verification-04 evidence and refreshed inspection/audit index. Closure
  still requires major protected-storage, integrated authorization/lock, durable
  import, recovery and fault/migration work plus actual acceptance evidence and
  final GitHub/release disposition. Tags/preferences remain deferred proposals.
- No source behavior, dependency, permissions, private data or external state changed.

## October 4, 2026 — Owner inspection follow-up and policy change

- Reviewed completed inspection. Owner reports policy/full/pack suites passing on
  M3 base/macOS 27; expected 5/16/24 counts checked but no final console summary
  or exact binary fingerprint supplied. Preserve as owner-reported design-01
  evidence, separate from agent-side permission blockers. B11 untested; keyboard/
  accessibility/offline observations partly tentative, not certification.
- Addressed navigation hit area and concise approved-detail disclosure; pending
  evidence starts expanded. Owner then approved blank-approval blocking with source
  retained until explicit discard (D-014); applied UI and session-boundary guard.
- Added synthetic empty-OCR/whitespace/manual-correction coverage; updated existing
  draft case. Suite now declares 17 tests. Core Swift 6 module compile, demo/test
  syntax and scoped whitespace/link checks passed; full SwiftPM tests aborted
  before execution on the manifest permission blocker. GUI recheck pending.
- Recorded owner, design-02 and design-03 evidence separately in AUDIT.md.
  Refreshed inspection with G01–G06; older checked behavior is historical.
- Case-study image provenance was not established as synthetic. Source-description
  excerpts removed from development report; retain behavior-only notes and do not
  reuse images/text in fixtures/prompts/issues. No image/app window inspected.
- Responded to similarity, retention/evidence, preferences, testing/feasibility,
  cross-chat consistency and release readiness in design/INSPECTION-FEEDBACK.md.
  Those mechanisms remain proposals. No automatic merging/deletion, persistent
  settings, external messages/issues or publication performed. Foundation storage,
  recovery and app-wide access/durability gates still block v0.1.1 closure.

## October 4, 2026 — Per-build inspection and audit traceability

- User requested inspection-sheet updates after each new build and traceable
  development/audit results. Added persistent AGENTS.md and ROADMAP.md requirements
  covering successful and failed build attempts, sanitized evidence, source/build
  identity, dated attribution and preservation of historical results (D-013).
- Updated inspection sheet for Library/Inbox/Search, source cards, Planned controls,
  appearance/accessibility and session honesty; all new GUI checks remain pending.
- Recorded [v0.1.1-20261004-design-01](evidence/builds/v0.1.1-20261004-design-01.md)
  with the current dirty-source fingerprint and prior design-turn actual checks.
  Linked AUDIT.md; preserved the v0.1.0 historical audit. No binary/test pass invented.
- Documentation-only work: whitespace/local-link checks passed; application tests
  not rerun, not applicable to these edits. Build/test blockers remain outstanding.
  No runtime logging, private logs/data, dependency, permission or external changes.

## October 4, 2026 — First native design implementation

- Reviewed docs/design PRODUCT-DIRECTION, VISUAL-SYSTEM and TODAY-STATION.
  Implemented D-012's session Library/Inbox/Search navigation, responsive source
  cards, approved/pending and selected labels, sage light surfaces, serif headings
  and readable secondary ink. Dark appearance uses system semantic surfaces/text.
- Preserved existing synthetic import, draft bindings, approval, source/correction
  separation, duplicate reopening and approved-only search. Approved content is
  now explicitly labeled Accepted knowledge; approval reveals Library.
- Disabled future capabilities with Planned labels/reasons: Today, Rediscover,
  collections, favorites, vault/settings and Ask/semantic search. Source TODO
  references map to pack MOS requirements, not a duplicate local status tracker.
  No EventKit/Photos access, network, persistence or AI behavior introduced.
- Actual verification: scoped whitespace and Swift syntax parsing passed.
  DesignSystem.swift directly type-checked in Swift 6; MosaicCore module emitted.
  Full swift test aborted before tests due XCBuild manifest permission error.
  Direct full-UI type-check was blocked by SwiftUI State macro plugin sandbox
  failure, so new UI build/behavior is unverified. No passing test run claimed.
- Visual QA, VoiceOver, keyboard focus and resized layout remain owner checks
  with synthetic fixtures. No app window inspected. Existing uncommitted work
  preserved; no install, permission change or publication performed.

## October 4, 2026 — Hosted product concept and native design handoff

- Human approved the synthetic POC's colors, aesthetics, minimalist philosophy
  and Library direction, and requested a reminder/calendar station plus design
  handoff and compatibility analysis. D-011 separates those approvals from
  proposed Today navigation/integration details.
- Added docs/design/PRODUCT-DIRECTION.md, VISUAL-SYSTEM.md and TODAY-STATION.md:
  POC provenance, design tokens, component/state requirements, native translation,
  current-versus-planned compatibility and confirmed-action/export proposals.
  Protected persistence precedes reliable reminders. Optional Calendar/Reminders
  handoff is not Mosaic vault sync; destination data may sync independently.
- Actual POC verification: Sites private deployment succeeded; JS syntax and
  mock-DOM smoke assertions passed. Browser visual QA blocked because admin
  security policy could not be verified. No native/Calendar/notification tests
  run for this documentation-only change. Scoped git diff whitespace checks
  passed; all three new guides passed local-link and whitespace checks.
  No personal data inspected or permissions requested.
- Source audit of the drive incident found no eject/unmount/disk/permission or
  destructive commands. Failed repository access does not establish causation;
  earlier “disconnected” wording was too certain. Hosted POC source preparation
  used temporary storage under explicit user direction, independent of the SSD.
- Stable version scope unchanged; no release, issue edits or native code changes.
  GitHub owns delivery tracking; MOS-016/017 remote mapping remains pending.

## October 2, 2026 — Owner inspection sheet

- Added INSPECTION-v0.1.1.md at the user's request: executable test commands,
  numbered manual review/draft/duplicate/search checks, small synthetic adverse
  inputs, accessibility/offline smoke checks and result-report format.
- Separated owner-demo checks, isolated policy assertions and pending foundation
  encryption/recovery/durability/security gates. No penetration-test certification
  or app-level policy enforcement claimed; destructive stress is deferred to
  controlled developer fixtures. GitHub remains the defect/status authority.
- Documentation-only change; application tests not rerun. Scoped whitespace and
  local links verified. Current build/test blockers remain recorded above.

## October 2, 2026 — Owner test checkpoint clarified

- Added a current-build synthetic manual checklist and separated future v0.1.1
  protection/security gates in TESTING.md. Corrected its current-verification
  paragraph to distinguish the historical eleven-test pass from the latest
  nine-pass/two-Vision-failure run and unexecuted new policy tests.
- Current source has 16 tests; owner Terminal run and GUI checkpoint are pending.
  No new test execution or security evidence claimed. Documentation-only change;
  scoped whitespace checks passed. No app/private data inspected.

## October 2, 2026 — MOS-006 owner policy implementation starts

- Added separate MosaicDomain and MosaicPolicy SwiftPM targets without new
  dependencies. Domain requests carry typed vault/principal/record identities,
  operation, purpose and explicit record/field scope. Policy starts locked,
  issues bounded process-local owner contexts and supports expiry, revocation,
  scope narrowing and session invalidation. D-010 records the implementation.
- Added five synthetic Swift Testing tests covering denied locked/wrong-owner/
  wrong-vault access, scope expansion, exact expiry, revocation, session replacement,
  cross-policy replay and invalid request/lifetime bounds. Tests are written,
  **not verified passing** in this environment.
- Actual validation: SwiftPM filtered run aborted before tests because XCBuild
  could not write its repository-local manifest (permission error). Fresh scratch
  directory also failed; native build-system attempt failed output-file-map I/O.
  Direct Swift 6 compilation successfully emitted both new modules/libraries.
  Direct test compilation could not resolve the TestingMacros plugin; no test
  executable produced or tests run. No permission changes/escalation, dependency
  installation or weakening of assertions performed. Scoped whitespace/link
  checks passed. Existing Vision failure evidence remains unresolved.
- Scoped source audit: domain imports Foundation only; policy imports domain and
  Foundation only. No UI, SQL, Vision, model, networking, source content, keys,
  persistence or diagnostics added. Existing demo code was preserved.
- Limits: this is partial MOS-006, not complete T02/T03 or a production control.
  Demo is not wired to policy. Authentication, vault membership checks, atomic
  lock/commit coordination, cache clearing, job cancellation and protected storage
  remain required. See POLICY-CONTRACTS.md for the current service signatures.
- Next: resolve build/test execution, then authenticated service/repository
  composition alongside encrypted-storage and independent-recovery spikes.
  GitHub MOS-to-issue mapping remains pending; no external publication performed.

## October 2, 2026 — Foundation scope and OS policy approved

- Human selected protected foundation as v0.1.1 scope (D-008), superseding
  D-007's proposal to put it in v0.2.0. Keep v0.1.0's immutable session-demo
  release; apply the pack's Mac foundation gates to v0.1.1. Existing review fixes
  and iterative UX remain in scope; mobile intake and AI remain later milestones.
- Human specified macOS/iOS 27 and current stable Apple OS as initial development
  targets. D-009 records retrofit policy: unsupported core guarantees exclude an
  OS, unsupported optional features disable automatically with clear capability
  information. Actual hardware, installed mobile OS and restore device availability
  remain unverified. Existing package minimums were not changed.
- Updated NEXT.md, README and capability evidence. No code/dependency/security
  implementation change. Documentation whitespace/link checks passed; application
  tests not rerun for these documentation-only edits. Earlier nine-pass/two-fail
  test result remains the current run evidence. GitHub reconciliation still pending.

## October 2, 2026 — Development pack alignment begins

- Reviewed the supplied development pack against source and existing decisions;
  completed local MOS-001 inventory evidence in
  [repository-inventory.md](evidence/repository-inventory.md) and started the
  [MOS-002 capability matrix](evidence/capability-matrix.md).
- Current target remains v0.1.1. Pack v0.1.0 protected-foundation requirements
  conflict with the immutable released session demo. D-007 proposes a future
  mapping; owner response and GitHub reconciliation remain pending.
- Preserved all existing uncommitted work and repository instructions. No app
  window/private data inspection, dependency installation, permission change,
  commit, push, issue write or release publication performed.
- Actual checks: pack validator passed 24 checks. Swift Mac executable built;
  nine of eleven synthetic tests passed; both Vision OCR tests failed with
  `.nilError` in restricted execution, with cache permission warnings. Cause
  unverified. Prior normal-access passes remain historical evidence only.
- Scoped reconciliation found missing durable storage/jobs, policy enforcement,
  recovery, resource bounds, mobile targets and intelligence. Pack SQL/contracts
  remain logical proposals, not production migrations or security evidence.
- Next: obtain device/release mapping inputs for MOS-002 and prepare MOS-006
  domain/policy contracts using synthetic negative tests. Encrypted adapter and
  independent recovery evidence must precede durable private-data use. GitHub
  issue read attempts failed connector argument/schema validation; remote task
  status was not verified. No duplicate local ticket tracker created.

## October 1, 2026 — local closing checklist

- Added user-requested `CLEANUP.md` for saving work, quitting relevant development
  apps, releasing terminal working directories, safe MacSSD ejection, and optional
  cleaning. The root file is excluded in `.gitignore`; it is an operations
  checklist, not a duplicate project ticket tracker.
- Existing uncommitted work was preserved. No applications were closed, SSD
  ejection attempted, personal data inspected, or destructive cleanup performed.
- Verification: `git check-ignore` confirmed the local checklist exclusion;
  scoped whitespace validation passed. Application tests are not applicable to
  this documentation-only change. Running applications remain unverified.
- At the user's request, designated the active chat `v0.1.1 — End-of-day
  operations` and extended the ignored checklist with a scoped Git checkpoint,
  next-session follow-up, and source-only handoff template. No commit or push
  was requested or performed as part of this chat setup.

## Status and environment

Active development target: **v0.1.1**, starting with the draft-loss baseline
defect in [GitHub issue #1](https://github.com/hash-murali/mosaic/issues/1).
The human clarified that this version combines ongoing design refinement, bug
fixes and pending work; the design is iterative, not final.
The existing v0.2.0 milestone remains unchanged until reconciled on GitHub.
Stable VERSION remains v0.1.0 until finalization; the active UI now explicitly
labels v0.1.1 as in development.

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

## September 30, 2026 — version and approval traceability

- Approver for the new requirements: human project owner in this chat, attributed
  by repository handle hash-murali. Evidence: user requested separate stable
  publications, versioned chat titles, named design approvers and branches as
  needed. D-003 in DECISIONS.md records requirements separately from Codex's
  routine workflow conventions adopted under the authorized planning scope.
- Added persistent instructions to AGENTS.md and conventions to ROADMAP.md.
  Added DECISIONS.md with proposer/approver/date/evidence/status fields, links
  and explicit unknown legacy approvals. No production role/approval enforcement
  or branch protection was added.
- Renamed the active chat to v0.2.0 — Release planning and governance. Policy
  applies to future project chats; other existing chats were not inspected or
  renamed. Application version remains 0.1.0; next target remains v0.2.0.
- Published a separate GitHub Release, v0.1.0 — Session Review, against the
  existing v0.1.0 tag at dbf1937. Browser verified the public release title, tag,
  commit, scoped notes, audit link and known limits. No binaries attached; GitHub
  supplies source archives. Existing source/tag was not changed.
- Updated GitHub issue #10 with additional release/approval/chat/branch
  acceptance requirements and approval attribution. Issue remains open for
  v0.2.0 finalization.
- Documentation-only changes: application tests not rerun; prior normal-access
  seven-test pass remains applicable. git diff --check and separate new-file
  whitespace validation passed. No dependencies installed or personal samples
  accessed.

## September 30, 2026 — v0.1.1 draft preservation development

- User requested starting v0.1.1. Renamed this chat and created focused branch
  `codex/v0.1.1-1-review-drafts` from the clean planning branch. GitHub issue #1
  was read and its acceptance criteria match the patch; it remains open under
  the existing v0.2.0 milestone. No external publication or issue edits performed.
- Added per-record draft text/toggle state separate from observations and
  approved corrections. Editor bindings retain it across navigation/import.
  Approval commits only enabled correction text; approval/discard clears the
  draft. Opening a record now refreshes its review status. See D-004.
- Actual verification: initial sandbox run failed on compiler-cache access.
  Normal-access `swift test --scratch-path .build --disable-sandbox` built the
  Mac executable and passed all nine synthetic Swift Testing tests, zero failures.
  Two new tests cover draft isolation, search gating, original-text preservation,
  enabled/disabled and empty corrections, approval and discard cleanup.
- Scoped source audit: reviewed all changed Swift code and regression tests.
  No network, persistence, content logging, dependencies or personal fixtures
  added. Existing image memory/orientation and per-window session limits remain.
  Drafts increase session memory usage; no memory budgets are implemented.
- New GUI bindings/navigation and picker cancellation remain unverified; added
  synthetic manual checks to TESTING.md. No app window or personal image inspected.
  Stable v0.1.1 is not finalized: human GUI check, GitHub scope/finalization
  reconciliation, version/release notes and authorized publication remain.

## September 30, 2026 — design scope, manual results and duplicate import fix

- Human clarified v0.1.1 includes design refinement alongside bug fixes and
  pending work at each stage, to maintain consistency as functionality develops.
  This supersedes the initial narrow patch-scope assumption. See D-005.
- User reported the basic review/search, multi-record, discard and all six
  draft-regression checks passed. Selected-image OCR feedback is retained only
  as a user-reported behavior result; no personal samples or extracted text were
  inspected or recorded. The reported empty-correction baseline check searched
  an empty query; that alone does not prove source-text exclusion. The later
  draft check and automated empty-correction test cover the exclusion behavior.
- User reported repeat import/approval of the same source yielding duplicate
  results. Added SHA-256 identity over decoded sRGB pixels and dimensions, held
  only in session memory. Reimport opens the existing pending/approved record
  without repeating OCR, changing its draft or approval, or adding a result.
  Discard clears identity so the source can be imported anew. Matching OCR
  alone does not merge distinct sources. See D-006.
- Started design refinement: resizable record-list/workspace split, explicit
  review state, selected-record emphasis, contextual discard, empty selection
  guidance and a development version label. Three synthetic sample choices
  preserve multi-record test coverage after identical-source detection.
- Actual verification: Mac executable built and all eleven synthetic tests
  passed with zero failures using the normal-access Swift test command.
  New coverage verifies pending/approved duplicate identity, draft preservation,
  distinct-source retention, discard/reimport and stable pixel fingerprints.
- Scoped audit reviewed identity lifecycle, worker-thread hashing/OCR, draft
  isolation and UI wiring. No network, saving, content logging or dependencies
  added. Fingerprints are sensitive derived data and are never exported/logged.
  Exact decoded-pixel matching is session/window-local; near duplicates, memory
  budgets, orientation improvements and shared windows remain unresolved.
- New layout and duplicate-import GUI checks are pending; no UI was inspected
  because an existing demo could contain personal test images. Prior user passes
  apply to the earlier build. GitHub reconciliation/publication remains pending;
  no external writes, release tag or stable v0.1.1 publication performed.
