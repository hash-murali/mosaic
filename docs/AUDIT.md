# Mosaic audit evidence

## Development checkpoints

- [v0.1.1-20261011-publish-75](evidence/builds/v0.1.1-20261011-publish-75.md): Immutable candidate prerelease published. PASS: annotated v0.1.1-rc.1 tag pushed and GitHub prerelease published from commit0ad4b1f1fe5e93c58fa024376c3d876cdaceb892; browser verifies Pre-release label, existing-tag commit and explicit deferred validation notes. Release URL https://github.com/hash-murali/mosaic/releases/tag/v0.1.1-rc.1. PR11 remains OPEN, main merge automatically rejected and not bypassed. Issue12 checklist/reminder and issue10 dispositions complete; stable v0.1.0 remains unchanged/latest. Source-only publication; no binaries/runtime/owner documents. Documentation-only: app tests not applicable,59-test current candidate evidence70/71 preserved. Screenshot proof saved outside Git. Next v0.1.2 handoff ready; main merge needs explicit deferred-risk approval.

- [v0.1.1-20261011-publish-74](evidence/builds/v0.1.1-20261011-publish-74.md): Main merge blocked; branch-only candidate release. BLOCKED: automatic approval review rejects PR11 merge into main because earlier authorization was conditional on stability and native/recovery/fault/memory checks remain deferred. No workaround, command-line merge or main push attempted. Main remains dbf1937503e8446598979a0147b184a24d9f251f; candidate branch cf02e78. Safer branch-only prerelease publication authorized by current user request continues. Explicit approval needed to merge with deferred gates. Documentation-only; no new app tests applicable. API403 history preserved; browser PR11/issue12/audit issue10 succeeded. Reminder/checklist installed; runtime and owner documents preserved/excluded.

- [v0.1.1-20261011-publish-73](evidence/builds/v0.1.1-20261011-publish-73.md): GitHub browser publication and reconciliation. PASS: candidate commits aee0439/e42dc16 pushed; authorized signed-in browser creates PR11 and deferred-validation issue12, then records explicit dispositions for existing issues1-10 on issue10. API403 history preserved; browser succeeds without changing connection permissions. No unsupported closure of partially accepted issues. Documentation-only: no fresh app tests needed; source unchanged from59-test/native candidate70/71. Staged whitespace fixed and pack checksum updated; pack validator PASS24checks. Main merge/tag/release pending.

- [v0.1.1-20261011-publish-72](evidence/builds/v0.1.1-20261011-publish-72.md): Candidate commit push and API limitations. PASS: audited synthetic publication boundary scan184 files, commit aee0439 pushed to origin/codex/v0.1.1-1-review-drafts. GitHub issue/PR creation API403 remains BLOCKED; no PR created. Staged diff check found preexisting trailing whitespace in newly tracked inspection/pack templates; follow-up strips whitespace and updates pack checksum manifest. Documentation-only follow-up, app tests not applicable;59-test/native/probe/process evidence unchanged. No owner private inspection document, runtime data or IDE state committed. Candidate unverified checks remain deferred; stable tag not claimed.

- [v0.1.1-20261011-rc-71-native](evidence/builds/v0.1.1-20261011-rc-71-native.md): Final candidate audit and native checks. PASS: current unsigned native xcodebuild;two publication probes;four process scenarios;24 development-pack checks and9 logical-schema checks;git diff --check. Commands native as launch68, python3 Tests/RegressionProbes/verify_open_publication.py, .build/debug/MosaicRecoveryCheck, python3 mosaic-development-pack/scripts/validate_pack.py, python3 mosaic-development-pack/database/check_logical_schema.py. Output .verification/rc-final-native-20261011.txt; Debug app-bearing dylib SHA25625d6cbec349aa14848394af47164c3cb5e4b262213e45631acd7b421d7574bab. Scoped FINAL-AUDIT.md complete with source-only review/limits. GitHub deferred issue create403; ticket reorganization BLOCKED, not completed. Owner authorizes commits/publication to move version with deferred checks; candidate label preserves remaining validation risks.

- [v0.1.1-20261011-rc-70-tests](evidence/builds/v0.1.1-20261011-rc-70-tests.md): Release-candidate full verification. PASS: fresh full SwiftPM build3.79 seconds;59 tests (18core,sixpolicy,11storage,11application,13actual-model), zero failures. Output .verification/rc-final-tests-20261011.txt; full local-cache command. Packaging label/version changed to v0.1.1-rc.1; Info build70. Owner explicitly defers consolidated native/fault/device inspection, D025, DEFERRED-VALIDATION checklist. Reminder created, stale foundation-resume automation removed. No skipped test converted to PASS; synthetic-only candidate, not fully validated stable.

- [v0.1.1-20261011-owner-69](evidence/builds/v0.1.1-20261011-owner-69.md): Owner confirms unlock lock and restart persistence. OWNER-REPORTED PASS: authentication/locking hides protected content, and approved content survives restarting. Owner says independent backup/restore has not been tested. Exact signed owner binary identity is unverified; current repository fingerprint is documentation context, not proof of the owner executable. No new application build/tests: not applicable to this report-only checkpoint. Do not infer system/idle/cancel lock, delete, physical storage/peak-memory, clean-user recovery or full signing acceptance from these two statements. Do not repeat passed owner checks without relevant changed behavior. Prior package-launch/keyUnavailable failure remains historical; current report supplies successful native interaction evidence without credential inspection.

- [v0.1.1-20261011-launch-68-native](evidence/builds/v0.1.1-20261011-launch-68-native.md): Native launch-guidance build. PASS: unsigned native xcodebuild succeeds, two publication probes PASS;59-test suite at67. Output .verification/launch-native-20261011.txt. Debug app-bearing dylib SHA256 3a65a8e63187a3cd3769572b092652cf403e32feafb4d0093ae2b158cfc7af84. Owner running MosaicDemo package executable; direct them to existing MosaicNative.xcodeproj scheme MosaicNative/My Mac. Guard prevents package password prompt and explains correct launcher, but does not establish valid signing or actual key availability. Focused signed-native attempt remains pending; no credential/runtime store inspection.

- [v0.1.1-20261011-launch-67-tests](evidence/builds/v0.1.1-20261011-launch-67-tests.md): Package launch guard validation. PASS: full SwiftPM build3.55 seconds;59 tests (18 core,six policy,11 storage,11 application,13 actual-model), zero failures. Output .verification/launch-tests-20261011.txt. Native bundle precondition runs before LAContext/password prompt; package launcher reports Open MosaicNative.xcodeproj, run MosaicNative/My Mac. Pure synthetic URL regression checks rejection/necessary app-bundle case. App-bundle presence is not signing proof, credential access or native acceptance. Previous keyUnavailable root cause remains unknown; no reset/key deletion/fallback.

- [v0.1.1-20261011-launch-66-red](evidence/builds/v0.1.1-20261011-launch-66-red.md): Package launcher clarification regression. Owner clarifies running MosaicDemo, the SwiftPM executable, not MosaicNative app. This does not establish supported native signing/Keychain access; root cause of generic keyUnavailable still not inferred. Source launch configuration confirms MosaicNative scheme exists, no signing credentials inspected. EXPECTED FAIL filtered compile: requireNativeApp/nativeAppRequired missing, zero tests executed. Output .verification/launch-red-20261011.txt. Synthetic nonexistent URLs only; no platform authentication.

- [v0.1.1-20261011-key-65-native](evidence/builds/v0.1.1-20261011-key-65-native.md): Native unlock diagnostic build. PASS: current unsigned native xcodebuild succeeds; two publication probes PASS. Output .verification/key-diagnostic-native-20261011.txt. Current app-bearing Debug dylib SHA256 a7f4875ebdf71876fe92cb897ff44a16289600d0ce27d739a7c7bd55d51bf4e2. Full58-test suite at64. Focused owner recheck required only to obtain new fixed error label after rebuilding signed Xcode app, not to repeat whole manual suite. Native unlock remains OWNER-REPORTED FAIL at63; root cause not established. No keys, queries, signing credentials, user profiles or runtime vaults inspected.

- [v0.1.1-20261011-key-64-tests](evidence/builds/v0.1.1-20261011-key-64-tests.md): Safe Keychain status differentiation. PASS: completed full SwiftPM build3.37 seconds;58 synthetic tests (18 core,six policy,11 storage,10 application,13 actual-model), zero failures. Output .verification/key-diagnostic-tests-20261011.txt. Adapter classifies missing item/signing entitlement/auth/interaction/invalid32-byte material and unknown integer OSStatus, no raw errors/queries/key/account logging. Fixed constants and invented bytes only; no platform custody object instantiated or Keychain calls in test. Root cause of owner unlock failure remains unknown; changed native build pending. No automatic key regeneration/deletion/fallback.

- [v0.1.1-20261011-key-63-red](evidence/builds/v0.1.1-20261011-key-63-red.md): Owner unlock failure diagnostic regression. OWNER-REPORTED FAIL: password prompt completes but protected workspace remains locked with keyUnavailable. Only supplied sanitized app error used; no screenshot OCR/personal content or Keychain inspection. EXPECTED FAIL: filtered SwiftPM diagnostic test compile fails on missing validatedKey and distinct SessionFailure cases; zero tests executed. Output .verification/key-diagnostic-red-20261011.txt. Current adapter hides SecItem result status, so missing item, signing/access denial and invalid key material are indistinguishable; root cause not known. Usual-versus-new local Mac user question pending.

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

- [owner-restore-30](evidence/builds/v0.1.1-20261008-owner-restore-30.md): owner confirms same-Mac restore retry retains correction, owner-reported PASS. Earlier failure preserved; independent-custody/full recovery acceptance pending.

- [recovery-29](evidence/builds/v0.1.1-20261008-recovery-29.md): owner native restore FAIL before authentication; matching material confirmed. One generated-fixture restore regression PASS; native root cause unresolved.

- [owner-vault-28](evidence/builds/v0.1.1-20261008-owner-vault-28.md): owner clarifies persistence passes; main search/import use separate session demo. Immediate Lock visibility untested; main-interface protected integration unfinished.

- [owner-vault-27](evidence/builds/v0.1.1-20261008-owner-vault-27.md): owner reports unlock, synthetic OCR and approval persistence PASS; lock visibility needs clarification. Tested signed binary unknown; no agent native acceptance.

- [lock-26-native](evidence/builds/v0.1.1-20261008-lock-26-native.md): current unsigned native build passes after lock fix; links 39 passing tests and red/green regression evidence. Native signing/GUI still pending.

- [lock-25-tests](evidence/builds/v0.1.1-20261008-lock-25-tests.md): current build/39 tests pass after opening guard fix; native rebuild pending.

- [lock-24-green](evidence/builds/v0.1.1-20261008-lock-24-green.md): bounded opening guard fixed; two isolated regression scenarios pass, broader current build/tests pending.

- [lock-23-red](evidence/builds/v0.1.1-20261008-lock-23-red.md): deterministic actual-code-block probe reproduces stale publication after lock (expected FAIL before fix).

- [review-22](evidence/builds/v0.1.1-20261008-review-22.md): documentation/source/packaging review; static checks pass, signing unavailable, potential open-flow stale publication identified and awaiting bounded fix approval. No new build/test.

- [resume-21](evidence/builds/v0.1.1-20261008-resume-21.md): unchanged source, 39 tests and four process recovery/crash scenarios pass; current unsigned native build passes. Signing/native and hardware acceptance pending.

- [integration-20](evidence/builds/v0.1.1-20261004-integration-20.md): paused current checkpoint, 39 tests pass; new crash drill/current native rebuild not run after stop request.

- [fault-19](evidence/builds/v0.1.1-20261004-fault-19.md): 36 tests pass; file/volume identity loss fails closed, actual SQLite-full rollback preserves prior receipt.

- [native-18](evidence/builds/v0.1.1-20261004-native-18.md): unsigned native Mac .app build passes; native signing/Keychain acceptance not verified.

- [integration-17](evidence/builds/v0.1.1-20261004-integration-17.md): 35 tests pass; separate synthetic recovery window and cancellation/context cleanup compiled; signed native acceptance pending.

- [integration-16](evidence/builds/v0.1.1-20261004-integration-16.md): 35 tests pass; durable retry, scoped snapshot/rebuild, independent restore and schema migration; native recovery UI still ongoing.

- [integration-15](evidence/builds/v0.1.1-20261004-integration-15.md): 31 tests pass; authenticated composition and separate synthetic protected window compiled; native Keychain/UI acceptance pending.

- [design-14](evidence/builds/v0.1.1-20261004-design-14.md): current adaptive UI,
  explicit approved edit/confirmed discard; 28 tests pass; GUI J checks pending.
- [design-13](evidence/builds/v0.1.1-20261004-design-13.md): initial concise
  Library hierarchy; 27 tests pass; predates approved-actions follow-up.
- [owner-review-02](evidence/builds/v0.1.1-20261004-owner-review-02.md): prior
  G/H completion and annotated hierarchy feedback; exact binary unavailable.


- [storage-12](evidence/builds/v0.1.1-20261004-storage-12.md): current source/binary
  identity; 27 tests and 24 pack checks pass; separate-process independent-key
  recovery pass. Synthetic integration review only; authenticated app and release
  acceptance incomplete.
- Earlier incremental attempts (intermediate fingerprints unavailable):
  [05 compile failure](evidence/builds/v0.1.1-20261004-storage-05.md),
  [06 header failure](evidence/builds/v0.1.1-20261004-storage-06.md),
  [07 22 tests](evidence/builds/v0.1.1-20261004-storage-07.md),
  [08 four storage tests](evidence/builds/v0.1.1-20261004-storage-08.md),
  [09 25 tests](evidence/builds/v0.1.1-20261004-storage-09.md),
  [10 25 tests](evidence/builds/v0.1.1-20261004-storage-10.md),
  [11 26 tests](evidence/builds/v0.1.1-20261004-storage-11.md).


- [verification-04](evidence/builds/v0.1.1-20261004-verification-04.md): same
  design-03 source; 24 pack checks and direct module/style/syntax checks pass;
  full suite blocked before execution; manual current-build checks pending.

- [Owner design-01 inspection](evidence/builds/v0.1.1-20261004-owner-review-01.md):
  owner-reported passes, untested cancellation and provisional accessibility;
  no exact binary fingerprint/terminal transcript. Preserved separately.
- [design-02](evidence/builds/v0.1.1-20261004-design-02.md): hit areas/progressive
  detail; syntax/style pass, full build/tests blocked, GUI recheck pending.
- [design-03](evidence/builds/v0.1.1-20261004-design-03.md): approved blank-text
  policy; core compilation/syntax pass, 17-case suite and new UI unverified.

- [v0.1.1-20261004-design-01](evidence/builds/v0.1.1-20261004-design-01.md): native
  design source review and verification record. Build/tests blocked; syntax and
  isolated style checks passed; owner GUI checks pending. Not release approval.

Every build/attempt adds evidence here and refreshes the current inspection
sheet and PLAN.md. Preserve older records and distinguish historical, agent and
owner-reported results. GitHub owns defects; sanitized synthetic evidence only.

## v0.1.0 — Session Review audit (historical)

Recorded September 30, 2026, 01:23 EDT. Scope: all current Swift source, package
manifest, synthetic tests, Git ignore rules and project documentation. Manual
source review, not an independent security assessment or production certification.

## Conclusion

Suitable as the user-tested in-memory Mac demo baseline. No release-blocking
defect found within that scope. OCR, explicit review gating, corrected search,
multiple-record retention, inbox navigation and reopening were user-tested.
Agents did not inspect personal samples. This conclusion does not authorize
production/private-data storage or establish an enforced vault boundary.

## Findings and next work

| Priority | Finding | Current behavior / follow-up |
| --- | --- | --- |
| P2 | Pending editor drafts are lost on navigation or import | Known limitation; retain drafts per record next. Approval correctly preserves corrections. |
| P2 | Full-resolution image retention has no session limit | Large images or many imports can exhaust memory; add decode and session budgets before broader use. Image decoding currently runs on the UI thread. |
| P2 | Selected-image orientation is not explicitly validated | NSImage decoding feeds upright CGImage OCR; rotated/EXIF fixtures need dedicated tests. |
| P3 | Opening another record can leave an old status message | Improve record-specific review status alongside draft handling. |
| P3 | Multiple demo windows hold separate session libraries | Current per-window state; use one shared session or restrict windows if cross-window behavior is needed. |

## Verified controls and limits

- Search uses reviewed text only, excludes pending records and inference labels,
  and retains original observations separately from corrections.
- Library appends successful OCR records; cancellation does not erase records.
  Discard removes one record and its image reference, not the original file.
- No network calls, providers, telemetry, app persistence or content logging in
  the reviewed source. Vision handles recognition locally; OS behavior is outside
  this source audit. Discard is not secure memory erasure.
- Git ignore rules cover common data/secrets patterns but are not an access
  boundary. Only explicitly named source/documentation files are staged.
- UI corrections become immutable after approval. Re-review of approved records,
  persistent storage, vault isolation, iOS UI and image understanding are absent.
- Automated tests cover core workflow and simple synthetic English OCR, not GUI
  focus, real-image accuracy, resource exhaustion or platform-wide compatibility.

## Release identification

Final release verification: Mac executable compiled; all seven synthetic Swift
Testing tests passed with zero failures. No personal data fixtures were used.

Version file: `VERSION`. Release tag: `v0.1.0`. Branch: `main`.
Use `git rev-parse v0.1.0` to resolve the immutable release commit after tagging.
No GitHub publishing is performed without a configured and confirmed destination.
