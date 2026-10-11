Current follow-up [v0.1.1-20261011-publish-74](evidence/builds/v0.1.1-20261011-publish-74.md): Main merge blocked; branch-only candidate release.
BLOCKED: automatic approval review rejects PR11 merge into main because earlier authorization was conditional on stability and native/recovery/fault/memory checks remain deferred. No workaround, command-line merge or main push attempted. Main remains dbf1937503e8446598979a0147b184a24d9f251f; candidate branch cf02e78. Safer branch-only prerelease publication authorized by current user request continues. Explicit approval needed to merge with deferred gates. Documentation-only; no new app tests applicable. API403 history preserved; browser PR11/issue12/audit issue10 succeeded. Reminder/checklist installed; runtime and owner documents preserved/excluded.
Prior checkmarks do not accept changed UI. Native shared-workspace revalidation pending.

Current follow-up [v0.1.1-20261011-publish-73](evidence/builds/v0.1.1-20261011-publish-73.md): GitHub browser publication and reconciliation.
PASS: candidate commits aee0439/e42dc16 pushed; authorized signed-in browser creates PR11 and deferred-validation issue12, then records explicit dispositions for existing issues1-10 on issue10. API403 history preserved; browser succeeds without changing connection permissions. No unsupported closure of partially accepted issues. Documentation-only: no fresh app tests needed; source unchanged from59-test/native candidate70/71. Staged whitespace fixed and pack checksum updated; pack validator PASS24checks. Main merge/tag/release pending.
Prior checkmarks do not accept changed UI. Native shared-workspace revalidation pending.

Current follow-up [v0.1.1-20261011-publish-72](evidence/builds/v0.1.1-20261011-publish-72.md): Candidate commit push and API limitations.
PASS: audited synthetic publication boundary scan184 files, commit aee0439 pushed to origin/codex/v0.1.1-1-review-drafts. GitHub issue/PR creation API403 remains BLOCKED; no PR created. Staged diff check found preexisting trailing whitespace in newly tracked inspection/pack templates; follow-up strips whitespace and updates pack checksum manifest. Documentation-only follow-up, app tests not applicable;59-test/native/probe/process evidence unchanged. No owner private inspection document, runtime data or IDE state committed. Candidate unverified checks remain deferred; stable tag not claimed.
Prior checkmarks do not accept changed UI. Native shared-workspace revalidation pending.

Current follow-up [v0.1.1-20261011-rc-71-native](evidence/builds/v0.1.1-20261011-rc-71-native.md): Final candidate audit and native checks.
PASS: current unsigned native xcodebuild;two publication probes;four process scenarios;24 development-pack checks and9 logical-schema checks;git diff --check. Commands native as launch68, python3 Tests/RegressionProbes/verify_open_publication.py, .build/debug/MosaicRecoveryCheck, python3 mosaic-development-pack/scripts/validate_pack.py, python3 mosaic-development-pack/database/check_logical_schema.py. Output .verification/rc-final-native-20261011.txt; Debug app-bearing dylib SHA25625d6cbec349aa14848394af47164c3cb5e4b262213e45631acd7b421d7574bab. Scoped FINAL-AUDIT.md complete with source-only review/limits. GitHub deferred issue create403; ticket reorganization BLOCKED, not completed. Owner authorizes commits/publication to move version with deferred checks; candidate label preserves remaining validation risks.
Prior checkmarks do not accept changed UI. Native shared-workspace revalidation pending.

Current follow-up [v0.1.1-20261011-rc-70-tests](evidence/builds/v0.1.1-20261011-rc-70-tests.md): Release-candidate full verification.
PASS: fresh full SwiftPM build3.79 seconds;59 tests (18core,sixpolicy,11storage,11application,13actual-model), zero failures. Output .verification/rc-final-tests-20261011.txt; full local-cache command. Packaging label/version changed to v0.1.1-rc.1; Info build70. Owner explicitly defers consolidated native/fault/device inspection, D025, DEFERRED-VALIDATION checklist. Reminder created, stale foundation-resume automation removed. No skipped test converted to PASS; synthetic-only candidate, not fully validated stable.
Prior checkmarks do not accept changed UI. Native shared-workspace revalidation pending.

Current follow-up [v0.1.1-20261011-owner-69](evidence/builds/v0.1.1-20261011-owner-69.md): Owner confirms unlock lock and restart persistence.
OWNER-REPORTED PASS: authentication/locking hides protected content, and approved content survives restarting. Owner says independent backup/restore has not been tested. Exact signed owner binary identity is unverified; current repository fingerprint is documentation context, not proof of the owner executable. No new application build/tests: not applicable to this report-only checkpoint. Do not infer system/idle/cancel lock, delete, physical storage/peak-memory, clean-user recovery or full signing acceptance from these two statements. Do not repeat passed owner checks without relevant changed behavior. Prior package-launch/keyUnavailable failure remains historical; current report supplies successful native interaction evidence without credential inspection.
Prior checkmarks do not accept changed UI. Native shared-workspace revalidation pending.

Current follow-up [v0.1.1-20261011-launch-68-native](evidence/builds/v0.1.1-20261011-launch-68-native.md): Native launch-guidance build.
PASS: unsigned native xcodebuild succeeds, two publication probes PASS;59-test suite at67. Output .verification/launch-native-20261011.txt. Debug app-bearing dylib SHA256 3a65a8e63187a3cd3769572b092652cf403e32feafb4d0093ae2b158cfc7af84. Owner running MosaicDemo package executable; direct them to existing MosaicNative.xcodeproj scheme MosaicNative/My Mac. Guard prevents package password prompt and explains correct launcher, but does not establish valid signing or actual key availability. Focused signed-native attempt remains pending; no credential/runtime store inspection.
Prior checkmarks do not accept changed UI. Native shared-workspace revalidation pending.

Current follow-up [v0.1.1-20261011-launch-67-tests](evidence/builds/v0.1.1-20261011-launch-67-tests.md): Package launch guard validation.
PASS: full SwiftPM build3.55 seconds;59 tests (18 core,six policy,11 storage,11 application,13 actual-model), zero failures. Output .verification/launch-tests-20261011.txt. Native bundle precondition runs before LAContext/password prompt; package launcher reports Open MosaicNative.xcodeproj, run MosaicNative/My Mac. Pure synthetic URL regression checks rejection/necessary app-bundle case. App-bundle presence is not signing proof, credential access or native acceptance. Previous keyUnavailable root cause remains unknown; no reset/key deletion/fallback.
Prior checkmarks do not accept changed UI. Native shared-workspace revalidation pending.

Current follow-up [v0.1.1-20261011-launch-66-red](evidence/builds/v0.1.1-20261011-launch-66-red.md): Package launcher clarification regression.
Owner clarifies running MosaicDemo, the SwiftPM executable, not MosaicNative app. This does not establish supported native signing/Keychain access; root cause of generic keyUnavailable still not inferred. Source launch configuration confirms MosaicNative scheme exists, no signing credentials inspected. EXPECTED FAIL filtered compile: requireNativeApp/nativeAppRequired missing, zero tests executed. Output .verification/launch-red-20261011.txt. Synthetic nonexistent URLs only; no platform authentication.
Prior checkmarks do not accept changed UI. Native shared-workspace revalidation pending.

Current follow-up [v0.1.1-20261011-key-65-native](evidence/builds/v0.1.1-20261011-key-65-native.md): Native unlock diagnostic build.
PASS: current unsigned native xcodebuild succeeds; two publication probes PASS. Output .verification/key-diagnostic-native-20261011.txt. Current app-bearing Debug dylib SHA256 a7f4875ebdf71876fe92cb897ff44a16289600d0ce27d739a7c7bd55d51bf4e2. Full58-test suite at64. Focused owner recheck required only to obtain new fixed error label after rebuilding signed Xcode app, not to repeat whole manual suite. Native unlock remains OWNER-REPORTED FAIL at63; root cause not established. No keys, queries, signing credentials, user profiles or runtime vaults inspected.
Prior checkmarks do not accept changed UI. Native shared-workspace revalidation pending.

Current follow-up [v0.1.1-20261011-key-64-tests](evidence/builds/v0.1.1-20261011-key-64-tests.md): Safe Keychain status differentiation.
PASS: completed full SwiftPM build3.37 seconds;58 synthetic tests (18 core,six policy,11 storage,10 application,13 actual-model), zero failures. Output .verification/key-diagnostic-tests-20261011.txt. Adapter classifies missing item/signing entitlement/auth/interaction/invalid32-byte material and unknown integer OSStatus, no raw errors/queries/key/account logging. Fixed constants and invented bytes only; no platform custody object instantiated or Keychain calls in test. Root cause of owner unlock failure remains unknown; changed native build pending. No automatic key regeneration/deletion/fallback.
Prior checkmarks do not accept changed UI. Native shared-workspace revalidation pending.

Current follow-up [v0.1.1-20261011-key-63-red](evidence/builds/v0.1.1-20261011-key-63-red.md): Owner unlock failure diagnostic regression.
OWNER-REPORTED FAIL: password prompt completes but protected workspace remains locked with keyUnavailable. Only supplied sanitized app error used; no screenshot OCR/personal content or Keychain inspection. EXPECTED FAIL: filtered SwiftPM diagnostic test compile fails on missing validatedKey and distinct SessionFailure cases; zero tests executed. Output .verification/key-diagnostic-red-20261011.txt. Current adapter hides SecItem result status, so missing item, signing/access denial and invalid key material are indistinguishable; root cause not known. Usual-versus-new local Mac user question pending.
Prior checkmarks do not accept changed UI. Native shared-workspace revalidation pending.

Current follow-up [v0.1.1-20261011-review-62](evidence/builds/v0.1.1-20261011-review-62.md): Release gate reconciliation and fault-drill preparation.
Documentation-only: git diff --check PASS; no new application build/tests applicable. Current completed baseline57 tests, native build, two probes and four process scenarios at60/61. README/decisions/inspection/PLAN/scoped audit updated; checkpoint54 invalid claim corrected in summaries. Review finds no remaining concrete P1/P2 after recovery fix in examined source. Prepared evidence/releases/v0.1.1/FAULT-DRILL.md for explicit artificial-volume mounting authorization; not executed. Independent-user recovery setup question pending; native/physical/peak-memory and GitHub403 release gates not waived. v0.1.2 design remains deferred until current stable closure.
Prior checkmarks do not accept changed UI. Native shared-workspace revalidation pending.

Current follow-up [v0.1.1-20261011-recovery-61-native](evidence/builds/v0.1.1-20261011-recovery-61-native.md): Final current native and source review checkpoint.
PASS: final unsigned native xcodebuild succeeds; two publication probes and four synthetic independent-process/crash checks PASS. Output .verification/recovery-native-20261011.txt; commands as foundation-58. Current application-bearing Mosaic.debug.dylib SHA-256 70bd567ba2a8323a1159de81583e64865776bf76f47dc63f9cf6580db8e74c84. Launcher hash alone is inadequate debug identity. Full57-test suite PASS at60. Source-only scoped reviewer finds no remaining P1/P2 in current fixes; earlier recovery issue resolved using new custody UUID. Signed native, physical storage/peak-memory, independent native recovery, GitHub ticket writes and stable publication remain unaccepted.
Prior checkmarks do not accept changed UI. Native shared-workspace revalidation pending.

Current follow-up [v0.1.1-20261011-recovery-60-tests](evidence/builds/v0.1.1-20261011-recovery-60-tests.md): Fresh restored vault custody.
PASS: completed full SwiftPM build 6.96 seconds; 57 tests (18 core, six policy, 11 storage, nine application, 13 actual-model), zero failures. Output .verification/recovery-final-20261011.txt. Restore now allocates new destination vault UUID before custody creation and changes encrypted staged identity only, preserving owner, original store and backup. Regression succeeds with custody rejecting the original UUID; new identity opens/searches correctly. Original restore identity equality contract intentionally replaced by fresh identity; actual-model Settings restore passes. Does not substitute for signed native/clean-user recovery.
Prior checkmarks do not accept changed UI. Native shared-workspace revalidation pending.

Current follow-up [v0.1.1-20261011-recovery-59-red](evidence/builds/v0.1.1-20261011-recovery-59-red.md): Independent restored custody regression.
EXPECTED FAIL: two filtered application tests execute; restored-identity inequality fails and unavailable-original-custody test throws keyUnavailable. Output .verification/custody-red-20261011.txt records duration. Scoped source audit found restoration reuses backup vault UUID for destination custody, so Apple duplicate-item path can depend on original Keychain. New restored UUID required; do not overwrite or read original item as recovery fallback. No real credentials accessed.
Prior checkmarks do not accept changed UI. Native shared-workspace revalidation pending.

Current follow-up [v0.1.1-20261011-foundation-58-native](evidence/builds/v0.1.1-20261011-foundation-58-native.md): Current native and process verification.
PASS: current unsigned native build succeeds; two lock-publication probes and four independent synthetic process/crash scenarios pass. Commands: xcodebuild as settings-41, python3 Tests/RegressionProbes/verify_open_publication.py, .build/debug/MosaicRecoveryCheck. Output .verification/foundation-native-20261011.txt. Full suite56 PASS at57. Final source-only re-review of import/location/cancellation finds no remaining important defects in those changes. Native Debug launcher hash is unchanged because current application code is linked in Mosaic.debug.dylib; record its hash in final review, launcher alone is insufficient native build identity. No OS credentials/authentication or physical-volume/clean-user recovery tested.
Prior checkmarks do not accept changed UI. Native shared-workspace revalidation pending.

Current follow-up [v0.1.1-20261011-foundation-57-tests](evidence/builds/v0.1.1-20261011-foundation-57-tests.md): Complete current synthetic suite.
PASS: actual completed full SwiftPM build 7.05 seconds, 56 tests (18 core, six policy, 11 storage, eight application, 13 actual-model), zero failures. Output .verification/foundation-full-20261011.txt; full local-cache command as import-44. Covers selected import/dedup/search/lock, chosen-folder persistence, restore-before-first-unlock success and correct profile destination, corrupt bookmark refusal, read cancellation, immediate lock/reopen and prior custody-close regression. Checkpoint 54 remains explicitly invalid; 55 corrects its premature PASS. Native rebuild/final review pending; native auth/physical faults/independent device recovery not inferred.
Prior checkmarks do not accept changed UI. Native shared-workspace revalidation pending.

Current follow-up [v0.1.1-20261011-lock-56-filtered](evidence/builds/v0.1.1-20261011-lock-56-filtered.md): Immediate-lock regression checks.
PASS: two immediate open/lock/reopen and restore/lock/reopen model tests pass (0.137 seconds); output .verification/lock-cycle-red-20261011.txt. Despite filename red, run was queued until preceding hang terminated and executed after capture-prior-lock fix; no dynamic red proof claimed. Reviewer reasoning identified mutual-await cycle. Directory configuration handling now centralized to preserve existing directories and reject missing parents. Additional cancellation/corrupt-bookmark tests pending validation.
Prior checkmarks do not accept changed UI. Native shared-workspace revalidation pending.

Current follow-up [v0.1.1-20261011-location-55-correction](evidence/builds/v0.1.1-20261011-location-55-correction.md): Correct failed run and immediate-lock cycle.
FAIL/TERMINATED: checkpoint 54 PASS claim was premature and invalid, explicitly corrected in that evidence file. Actual .verification/location-final-tests-20261011.txt shows model failures and controlled-custody hang; only own SwiftPM/test child terminated. Filtered red run was queued behind its scratch-path lock and had not executed. Review proves open/restore read mutable locking task and can mutually await cancelled operation; capture prior closing task before scheduling. Existing default directories must not be recreated with intermediate=false; fixture producer now creates its own parent. Fresh validation pending; no passing claims carried forward.
Prior checkmarks do not accept changed UI. Native shared-workspace revalidation pending.

Current follow-up [v0.1.1-20261011-location-54-tests](evidence/builds/v0.1.1-20261011-location-54-tests.md): Restore destination fix validation.
INVALID PREMATURE PASS CLAIM: actual run failed and hung; see corrected checkpoint54 and follow-up55. The originally reported52-test pass must not be used as evidence. Actual-model backup/restore-before-first-unlock now creates selected-folder active profile and reopens restored accepted correction. Synthetic fake custody only. Source-only re-review identifies new P1 immediate open/lock or restore/lock mutual-await deadlock; not release ready, next regression pending.
Prior checkmarks do not accept changed UI. Native shared-workspace revalidation pending.

Current follow-up [v0.1.1-20261011-location-53-rootcause](evidence/builds/v0.1.1-20261011-location-53-rootcause.md): Restore destination rejection identified.
FAIL: isolated one-test build 2.22 seconds, three assertions fail. Bookmark resolves without staleness; proposed nonexistent directory URL comparison fails because symlink resolution removes the directory trailing-slash representation. Backup succeeds. This pinpoints invalidConfiguration before restore I/O; comparison should use standardized filesystem paths while retaining symlink rejection. Output .verification/location-paths-20261011.txt. No personal runtime artifacts inspected.
Prior checkmarks do not accept changed UI. Native shared-workspace revalidation pending.

Current follow-up [v0.1.1-20261011-location-52-boundaries](evidence/builds/v0.1.1-20261011-location-52-boundaries.md): Backup-versus-restore boundary diagnosis.
FAIL: isolated regression build 5.36 seconds; one test fails with two assertions. Backup success and file existence assertions pass; restore reports sanitized invalidConfiguration, and no active-profile pointer is published. Output .verification/location-boundaries-20261011.txt. Production restore now reports fixed enum codes only, not raw Foundation errors or key/content. Root cause investigation continues.
Prior checkmarks do not accept changed UI. Native shared-workspace revalidation pending.

Current follow-up [v0.1.1-20261011-location-51-diagnose](evidence/builds/v0.1.1-20261011-location-51-diagnose.md): Restore-path failure reproduced.
FAIL: isolated model restore regression executes one test, build 2.18 seconds, two assertions fail. Model reports sanitized restore-failed status; opening preserved original collection must not count as recovery success. Output .verification/location-diagnose-20261011.txt. Further boundary diagnosis required; no additional source fix claimed.
Prior checkmarks do not accept changed UI. Native shared-workspace revalidation pending.

Current follow-up [v0.1.1-20261011-location-50-fail](evidence/builds/v0.1.1-20261011-location-50-fail.md): Restore regression exposes incomplete fix.
FAIL: SwiftPM build 7.05 seconds, 52 tests executed; 51 pass, restore-before-first-unlock test fails because selected-folder active-profile pointer is absent. Current restore appears not to have completed; opening existing original content is not sufficient proof of restore. Output .verification/location-review-green-20261011.txt. Diagnosis and green validation pending. No native recovery acceptance inferred.
Prior checkmarks do not accept changed UI. Native shared-workspace revalidation pending.

Current follow-up [v0.1.1-20261011-location-49-red](evidence/builds/v0.1.1-20261011-location-49-red.md): Restore-location regression.
EXPECTED FAIL: filtered SwiftPM compile missing backupSelectedFile/restoreSelectedBackup; zero tests executed. Output .verification/location-restore-red-20261011.txt. New actual-model synthetic backup/restore-before-first-unlock test asserts selected folder receives restored profile and default folder does not. Independent reviewer identified the underlying restore path defect. Fix pending.
Prior checkmarks do not accept changed UI. Native shared-workspace revalidation pending.

Current follow-up [v0.1.1-20261011-location-48-native](evidence/builds/v0.1.1-20261011-location-48-native.md): Native folder-selection build and review.
PASS: unsigned native xcodebuild and both lock-publication probes. Command same local-cache native invocation plus python3 Tests/RegressionProbes/verify_open_publication.py; output .verification/location-native-20261011.txt. Reviewer finds P1 restore-before-unlock ignores persisted location and P2 detached import cancellation/resource-lifetime gaps. These are unresolved findings at this checkpoint; compiled does not mean release-ready.
Prior checkmarks do not accept changed UI. Native shared-workspace revalidation pending.

Current follow-up [v0.1.1-20261011-location-47-tests](evidence/builds/v0.1.1-20261011-location-47-tests.md): Settings vault-folder integration.
PASS: full SwiftPM build 5.42 seconds; 51 tests (17 core, six policy, 11 storage, eight application, nine actual-model), zero failures. Same full local-cache command; output .verification/location-green-20261011.txt. Owner-selected existing directory stored as bounded security-scoped bookmark, resolution disables UI and mounting; stale/unavailable/symlink paths reject, selection requires locked state, no content migration. Synthetic model tests verify remembered correction, default-root absence, and locked/location guards. Native rebuild and review pending; real unplug/disk-full/independent native recovery not accepted.
Prior checkmarks do not accept changed UI. Native shared-workspace revalidation pending.

Current follow-up [v0.1.1-20261011-location-46-red](evidence/builds/v0.1.1-20261011-location-46-red.md): Vault location regressions.
EXPECTED FAIL: filtered SwiftPM test build cannot compile missing useVaultFolder; zero tests executed. Command local-cache swift test --filter chosenVaultFolder|unavailableSelectedFolder|vaultFolderChange. Output .verification/location-red-20261011.txt. Fresh generated directories only; tests require persisted selected collection, no fallback at absent folder, and locked existing-folder selection. No runtime profiles inspected.
Prior checkmarks do not accept changed UI. Native shared-workspace revalidation pending.

Current follow-up [v0.1.1-20261011-import-45-native](evidence/builds/v0.1.1-20261011-import-45-native.md): Native selected-image import build.
PASS: unsigned native xcodebuild succeeds, no authentication or Keychain interaction. Command as settings-41 with CODE_SIGNING_ALLOWED=NO; output .verification/import-native-20261011.txt. Application source matches import-44; subsequent location tests are test-only and not yet compiled. Native file-picker and signed UI acceptance remain pending.
Prior checkmarks do not accept changed UI. Native shared-workspace revalidation pending.

Current follow-up [v0.1.1-20261011-import-44-tests](evidence/builds/v0.1.1-20261011-import-44-tests.md): Selected synthetic import integration.
PASS: full SwiftPM build completes in 5.53 seconds; 48 tests (17 core, six policy, 11 storage, eight application, six actual-model), zero failures. Same local-cache full suite command as settings-40; output .verification/import-green-20261011.txt. Selected invented PNG/JPEG file capability is bounded and decoded off main actor before authenticated receive; no scanning. Tests verify encrypted receipt, processing, accepted correction/search, exact duplicate retention, locked refusal, and invalid bytes adding no record. Native rebuild and picker acceptance pending. GitHub create FORBIDDEN (403).
Prior checkmarks do not accept changed UI. Native shared-workspace revalidation pending.

Current follow-up [v0.1.1-20261011-import-43-red](evidence/builds/v0.1.1-20261011-import-43-red.md): Selected synthetic import regressions.
EXPECTED FAIL: SwiftPM test build fails because importSelectedFile is not implemented; zero tests executed. Command: local-cache swift test --disable-sandbox --skip-update --filter selectedSyntheticFile|invalidSelectedFile, output .verification/import-red-20261011.txt. Two actual-model tests use generated PNG and invalid invented bytes, fake custody and fresh fixture roots. GitHub issue creation again returns FORBIDDEN (403); no issue created. Installed Superpowers and GitHub confirmed; no dependency or permission changes.
Prior checkmarks do not accept changed UI. Native shared-workspace revalidation pending.

Current follow-up [v0.1.1-20261008-settings-42-review](evidence/builds/v0.1.1-20261008-settings-42-review.md): One-app objective and bounded-review reconciliation.
Documentation-only: no new build/tests; git diff --check PASS. D-023 records owner one-app/Settings/badge direction, implemented current flow and Codex five-case review policy. PLAN reconciles each v0.1.1 objective; inspection stores one final batch, old lists historical rather than repeated homework. Current automated baseline 46 tests and two probes; native current application compiled at 41. Optional tags/reminders/intelligence remain explicit deferred TODOs. No manual review requested now; storage/import, native/fault/independent recovery and final release audit remain required.
Prior checkmarks do not accept changed UI. Native shared-workspace revalidation pending.

## Focused launcher clarification — launch-68

Owner reports running MosaicDemo. Open MosaicNative.xcodeproj, choose MosaicNative
scheme and My Mac, then run **Mosaic**. Current59-test/unsigned-native build passes;
package launcher now gives this instruction before a password prompt. Native signed
unlock still PENDING; earlier generic error cause not known.

- [ ] One focused supported-native unlock attempt; record only success or fixed
      error word/code, without account details/keys/raw console.

No full checklist repetition, reset, Keychain deletion or signing-team change.

## Focused native failure follow-up — key-65

Owner unlock FAIL at63: password prompt followed by keyUnavailable; runtime build
identity unknown. Current diagnostic source has58 synthetic tests PASS; unsigned
native build/two probes PASS at65. Native unlock remains FAIL/PENDING diagnosis.

- [ ] Owner stop current Xcode run; rebuild/run same MosaicNative target; unlock once.
- [ ] Record only fixed error word/code and usual/new local Mac user (no account
      names, key, password, raw console or runtime content).

This is one focused retry of a failed case, not a new five-case owner batch.
Current root cause unknown. Preserve vault/Keychain; no deletion/reset/fallback.

## October11 owner acceptance follow-up — owner-69

- [x] OWNER-REPORTED PASS: authentication and locking hide protected content.
- [x] OWNER-REPORTED PASS: approved content survives restart.
- [ ] Independent backup/restore: owner explicitly has not tested it.

Exact signed binary identity not supplied; do not assign the unsigned build hash
to owner results. These passes do not establish system/idle/cancel behavior,
confirmed delete, fault/peak-memory acceptance or clean-user recovery. Avoid
repeating passed checks unless affected source behavior changes. Broader remaining
release gates stay explicit; no stable tag/merge/release inferred.

# Current v0.1.1 owner review policy — one final batch

Current application: **recovery-61-native**, source identity in linked evidence.
Current automated suite: **57 tests PASS** at recovery-60-tests; current unsigned
native build, two publication probes and four process scenarios PASS. Source-only
review has no remaining important finding in reviewed fixes. Real authentication,
physical storage/peak-memory and independent native recovery remain unaccepted.

**Do not repeat historical checklists after each build.** The agent updates this
sheet/evidence automatically. One final candidate review will be requested directly
in chat when ready, with these five cases. No final review requested at this stage.
Previous checkmarks remain historical, not current native acceptance.

| Final case | Small owner check | Status |
|---|---|---|
| RC1 | One window: locked Settings folder choice/unlock; vault badges; cancel unlock stays hidden | PENDING |
| RC2 | Invented PNG/JPEG import → approve → Library/Search; edit/search updated text; duplicate retains correction | PENDING |
| RC3 | Manual/system/idle lock hides text/images/drafts; rapid reopen works; unavailable storage creates no fallback | PENDING |
| RC4 | Restart preserves approved records; confirmed delete removes record and search result | PENDING |
| RC5 | Settings backup/restore preserves correction in fresh profile; required independent-custody environment/evidence arranged before final acceptance | PENDING |

Record candidate/build identity, date, PASS/FAIL and owner attribution; never paste
keys, account details or content. A failed native case may require that case only
again after a fix, with explicit rationale. Routine tests are automatic. Required
hardware/recovery setup is a release dependency; unavailable evidence stays blocked,
not waived or silently counted as a pass because the batch has a five-case cap.

## Historical build and inspection evidence (preserved)

Current follow-up [v0.1.1-20261008-settings-41-native](evidence/builds/v0.1.1-20261008-settings-41-native.md): One window with Settings vault controls.
PASS: current unsigned native app build succeeds; two publication probes PASS; full suite 46 tests PASS at settings-40-tests. Single Window scene, shared protected Inbox/Library/Search plus Settings, vault source badges, no old memory/recovery windows. Default product still uses platform custody; actual-model tests use injected fake custody and generated roots only. Native signing/UI and remaining release gates not accepted. Command as workspace-33-native; AppIntents metadata skip warning only.
Prior checkmarks do not accept changed UI. Native shared-workspace revalidation pending.

Current follow-up [v0.1.1-20261008-settings-40-tests](evidence/builds/v0.1.1-20261008-settings-40-tests.md): Single-window actual-model automated suite.
PASS: full build (1.76 s), 46 tests (17 core/six policy/11 storage/eight application/four actual app-model), zero failures. Model tests run fake custody and generated AppKit images, no native window or Keychain interaction. Save/search/preview/lock/reopen, recovery/draft clearing and controlled delayed closure verified. One window + Settings/vault badges implemented; old memory/recovery scenes and legacy demo UI removed. Current native build pending.
Prior checkmarks do not accept changed UI. Native shared-workspace revalidation pending.

Current follow-up [v0.1.1-20261008-settings-39-lock](evidence/builds/v0.1.1-20261008-settings-39-lock.md): Serialize lock completion before reopening.
PASS: isolated actual-model regression now passes (one test, build 5.12 s) after waiting for previous storage/custody closure before open. Earlier deterministic failure preserved at 37/38. Single-window main Settings/protection/recovery implementation and actual model test injection use default platform custody in product; fake custody in tests only. Full suite and native compilation pending.
Prior checkmarks do not accept changed UI. Native shared-workspace revalidation pending.

Current follow-up [v0.1.1-20261008-settings-38-diagnose](evidence/builds/v0.1.1-20261008-settings-38-diagnose.md): Isolated model reopen diagnosis.
FAIL: isolated model test reproduces reopen with sanitized invalidKeyOrCorruptStore; build 4.80 s, one test fails with two assertions. Actual model locks UI immediately but launches database/custody closure asynchronously; next open currently does not await closure. Hypothesis: overlapping encrypted handles during immediate reopen. No personal artifacts or raw Keychain data inspected.
Prior checkmarks do not accept changed UI. Native shared-workspace revalidation pending.

Current follow-up [v0.1.1-20261008-settings-37-fail](evidence/builds/v0.1.1-20261008-settings-37-fail.md): Actual model tests expose reopen failure.
FAIL: build succeeds (3.87 s), 45 tests executed; 44 pass and one actual-model reopen test fails with two expectations. Storage/policy/core/application suites pass; opening after immediate lock leaves model locked. Injected fake custody/generated root only, no native Keychain. New automation catches a model issue not covered by prior service tests. No current UI acceptance or stable claim.
Prior checkmarks do not accept changed UI. Native shared-workspace revalidation pending.

Current follow-up [v0.1.1-20261008-settings-36-red](evidence/builds/v0.1.1-20261008-settings-36-red.md): Single-workspace Settings model regressions.
EXPECTED FAIL before implementation: injectable model initialization and Settings tab missing; zero executed tests. Added a model test target dependent on current app executable, no new external dependency. Regressions will exercise actual model save/search/preview/lock/reopen with fake custody and generated samples. User explicitly requested one app, vault badge and Settings protection. Command local-cache SwiftPM --filter mainModel|settingsIs. No native window/Keychain opened.
Prior checkmarks do not accept changed UI. Native shared-workspace revalidation pending.

## Shared main workspace — current owner revalidation

Current application: workspace-33-native; current suite: recovery-34, 42 tests PASS.
Use Xcode MosaicNative/My Mac to rebuild with the owner's signing setup. Only
generated samples. Earlier separate-harness passes do not validate these changes.

- [ ] M01 Unlock main Mosaic window; add generated sample and resume processing.
- [ ] M02 Approve in Inbox; record leaves Inbox and appears in Library.
- [ ] M03 Search its accepted text in main Search; pending text stays excluded.
- [ ] M04 Edit accepted text explicitly, save, search new text; old correction no longer matches.
- [ ] M05 Click lock icon before unlocking again; content/images/edit/search/recovery material hidden in every protected window.
- [ ] M06 Quit/relaunch/unlock; Library/search use saved or restored collection consistently.

Separate Memory-only image demo remains temporary and independent; no migration
or personal-image persistence. Record owner date/build/results without image text,
keys, screenshots or account information. This is acceptance evidence, not ticket status.

Current follow-up [v0.1.1-20261008-review-35](evidence/builds/v0.1.1-20261008-review-35.md): Pre-release integration review and handoff.
Documentation-only review: no new app build/test; git diff --check PASS. Updated D-022, README/NEXT/ROADMAP/policy contract and pre-release artifact/data-flow/dependency review. Current automated baseline remains recovery-34 (42 tests); current application native bundle from workspace-33, SHA-256 recorded separately. Main workspace now protected; signed owner revalidation requested. Remaining software includes supported vault location/selected synthetic import and final audit; hardware/native/independent recovery gates unaccepted. GitHub create returned 403; no issue or stable publication claimed.
Prior checkmarks do not accept changed UI. Native shared-workspace revalidation pending.

Current follow-up [v0.1.1-20261008-recovery-34](evidence/builds/v0.1.1-20261008-recovery-34.md): Recovery fault checks after integration.
PASS: full build (2.27 s), 42 tests (17 core/six policy/11 storage/eight application), zero failures. Added meaningful existing-behavior checks: varied synthetic recovery bytes, authentication denial and snapshot tampering publish no destination and preserve original backup/source. Application source unchanged from workspace-33 native build; tests changed only. Command same full SwiftPM local-cache invocation. Native owner revalidation requested; prior owner passes not applied to changed workspace.
Prior checkmarks do not accept changed UI. Native shared-workspace revalidation pending.

Current follow-up [v0.1.1-20261008-workspace-33-native](evidence/builds/v0.1.1-20261008-workspace-33-native.md): Native shared workspace build.
PASS: current unsigned native build succeeds; two opening-publication regression scenarios pass. Full suite 41 tests PASS at workspace-32-green. Native command as lock-26-native; AppIntents metadata skipped warning only. Exact signed owner build not verified; new main tabs/lock/recovery need owner revalidation. Existing current personal-image memory demo is separate and never migrated.
Prior checkmarks do not accept changed UI. Native shared-workspace revalidation pending.

Current follow-up [v0.1.1-20261008-workspace-32-green](evidence/builds/v0.1.1-20261008-workspace-32-green.md): Shared protected main screens.
PASS: full build (4.45 s), 41 tests (17 core/six policy/11 storage/seven application), zero failures. New workspace tests cover pending/accepted/search/delete consistency and locked projections. Main WindowGroup now shares ProtectedDemoModel across Inbox/Library/Search; personal-image memory demo moved to separate explicit window. Existing APIs/custody/backup remain unchanged. Current native/owner UI acceptance pending. Command same local-cache full SwiftPM invocation as lock-25-tests.
Prior checkmarks do not accept changed UI. Native shared-workspace revalidation pending.

Current follow-up [v0.1.1-20261008-workspace-31-red](evidence/builds/v0.1.1-20261008-workspace-31-red.md): Main workspace test-first checkpoint.
EXPECTED FAIL: new workspace tests do not compile because VaultWorkspace/Tab do not exist; zero executed tests. Command: same local-cache SwiftPM invocation as recovery-29, --filter protectedWorkspace. Owner approved shared protected Inbox/Library/Search design; no production UI implemented yet. GitHub issue creation returned FORBIDDEN (403); no ticket created.
Prior checkmarks do not accept changed UI. Native shared-workspace revalidation pending.

Owner restore retry **[owner-restore-30](evidence/builds/v0.1.1-20261008-owner-restore-30.md)**:
owner confirms saved correction after unlocking the restored profile. Same-Mac
synthetic restore retry: owner-reported PASS. Preserve earlier recovery-29 FAIL;
its cause is unresolved. K06 partial evidence only: independent-custody/device
and remaining recovery cases PENDING. K03 immediate-lock visibility PENDING.
Exact owner-tested binary unknown; no new agent build or tests in this follow-up.

Recovery-29 follow-up: owner did not notice backup-success status. Confirm fresh
backup completion before repeating restore; no cause inferred yet.

Recovery follow-up **[recovery-29](evidence/builds/v0.1.1-20261008-recovery-29.md)**:
K06 owner-reported FAIL: matching generated backup/key restore fails before Mac
authentication. Cause unresolved; not an owner-copying error assumption. One current
synthetic fake-custody restore test PASS, which does not pass native K06. Immediate
manual Lock visibility remains PENDING. Preserve older evidence below.

Owner clarification **[owner-vault-28](evidence/builds/v0.1.1-20261008-owner-vault-28.md)**:
corrected generated protected record survives restart/unlock (owner-reported PASS).
Main search/import operates in an independent memory-only demo. Main-interface
protected integration remains unfinished. Immediate Lock visibility was not tested;
K03 remains PENDING, with no confirmed visibility failure from this report.
No new binary or automated tests in this documentation-only follow-up.

Owner follow-up **[owner-vault-27](evidence/builds/v0.1.1-20261008-owner-vault-27.md)**:
owner reports protected unlock, generated-sample OCR and approval persistence PASS.
Exact tested Xcode binary unknown. Lock visibility PENDING clarification; do not
mark K03 passing yet. Protected harness and ordinary memory demo are separate.
Compiled source baseline and historical evidence follow.

Current compiled checkpoint **[lock-26-native](evidence/builds/v0.1.1-20261008-lock-26-native.md)**:
October 8, 2026. Opening publication guard fixed with owner approval. Current suite
39 tests PASS at lock-25-tests; two isolated actual-code regression scenarios PASS
at lock-24-green after an observed failure at lock-23-red. Current unsigned native
build PASS. Signed Keychain/GUI/recovery and hardware acceptance remain PENDING.
No immediate owner testing required for the automated fix. When signing becomes
available, K03 must verify that locking while opening/loading keeps content hidden.
Probe behavior does not pass that native checkbox. Preserve historical results below.

## Historical checkpoint updates (dated evidence retained)

Lock-25-tests: current source build/39 tests PASS; two isolated publication
regressions PASS at checkpoint 24. Current native rebuild and K acceptance pending.

Lock-24-green: opening guard fixed; two isolated regression scenarios PASS.
Current full suite/native build pending; K03 still needs signed native acceptance.

Lock-23-red: isolated actual opening-code probe reproduced stale publication
after lock (expected FAIL before fix); native acceptance and fix verification pending.

Documentation/source follow-up **[review-22](evidence/builds/v0.1.1-20261008-review-22.md)**:
no new binary or app tests. Signing unavailable per owner. K03 additionally needs
lock-during-open validation; a potential stale-publication ordering concern was
identified, not reproduced/fixed. [Signing handoff](SIGNING-v0.1.1.md) is available.
The compiled checkpoint and historical owner results below retain their dates.

Current checkpoint **[resume-21](evidence/builds/v0.1.1-20261008-resume-21.md)**
(October 8, 2026): agent verified 39 automated tests PASS (17 core, six policy,
11 storage, five application), four synthetic process recovery/crash scenarios
PASS, current native unsigned build PASS. Source unchanged from integration-20.
Native signing/Keychain/UI and clean-user/device recovery remain PENDING.
Prior owner checkmarks below are historical; they do not accept the protected
window or current native build. Personal data remains unauthorized in persistent mode.

# v0.1.1 development inspection sheet

Fault checkpoint 19: 36 tests passed; storage identity-loss/SQLite-full guards tested, native behavior pending.

Native checkpoint 18 built an unsigned .app; no Keychain/signing acceptance.

Integration checkpoint 17: 35 automated tests passed; durable retry/migration/restore service tested; dedicated recovery window compiled; signing/native verification pending; separate Protected synthetic vault window now available. Real Keychain/native UI not tested; do not reuse old UI passes. Integration work continues.

Updated October 4, 2026. Target: protected Mac foundation. Current checkpoint:
**[design-14](evidence/builds/v0.1.1-20261004-design-14.md)** — adaptive Library
layout, top search, concise accepted view and explicitly selected approved-edit
and discard tasks. Agent verified **28 tests passed** (15 core, five policy,
eight storage); source and binary digests are in that evidence record.

Owner completed G01–G06/H10–H14 on the earlier UI and supplied annotated layout
feedback. [Owner-review-02](evidence/builds/v0.1.1-20261004-owner-review-02.md)
preserves those observations; exact tested binary was not supplied. Earlier
checkmarks below do not validate changed design-14 UI. Only new J01–J09 need
focused GUI revalidation now. B11's picker-cancellation check is duplicated by
completed G04; no repeat solely for the unchecked historical row.

The demo remains session-only. Encrypted storage/scoped service and process
recovery are synthetic integration evidence, not authenticated vault UI.
Authentication/key custody, app lock/durable workflow, recovery UX and fault/
migration acceptance still block stable v0.1.1. GitHub Issues owns task status.

## How to record results

Check a box only after observing the expected result. An unchecked box means
pending, not passing. Record PASS, FAIL, BLOCKED or NOT IMPLEMENTED beside it.
Use only generated samples or small images with invented text. Restart between
independent scenarios; old approved records can otherwise confuse results.

- Inspection date/time: ____1.34 pm sunday Oct 4 2026______
- Evidence/build checkpoint ID: __________
- Source fingerprint (from build evidence), or exact tested build identity: ___v0.1.1-20261004-design-01_______
- Result attribution: agent-verified / owner-reported: ____owner______
- Mac model/RAM: ___m3 base model _______
- macOS version: ___MacOS 27_______
- Branch/commit (`git branch --show-current`, `git rev-parse --short HEAD`): __________
- Uncommitted source present (`git status --short`): __________
- Test summary/count: __________

A commit alone does not identify this build while uncommitted changes exist.
Do not send personal screenshots/OCR, private filenames, raw crash logs, keys or
credentials. Report an invented-text reproducer and expected/actual behavior.

## A. Automated checkpoint — owner can run now

Run from Terminal in the repository:

```bash
cd /Volumes/MacSSD/Developer/Projects/mosaic
swift test --scratch-path .build --disable-sandbox --filter MosaicPolicyTests
swift test --scratch-path .build --disable-sandbox
python3 -B mosaic-development-pack/scripts/validate_pack.py
```

- [x] A01 Policy suite: all five current cases execute and pass, not merely build.
- [x] A02 Full suite: historical owner checkmark for design-01 only. Current design-14 agent run: 28 tests passed (15 core, five policy, eight storage).
- [x] A03 Pack validator: 24 fixture checks pass.
- [x] A04 Record actual errors/failures and counts, including Vision OCR failures. - O- > their is not errors while testing so no show

Current agent evidence: design-14 built MosaicDemo; all 28 Swift Testing tests
executed and passed, including both Vision cases. Policy tests cover D01–D07;
these require no additional owner manual testing. Earlier blocked/error evidence
remains historical. Current GUI J01–J09 still pending; compile/tests do not verify
native focus, layout, hit targets or appearance.

If a command fails, mark BLOCKED/FAIL and retain synthetic command output. Do not
use sudo, chmod, delete build directories or reinstall tools to work around it.
A test framework displaying zero XCTest tests is not itself a failure when Swift
Testing subsequently reports the real count; require the final Swift Testing
summary. Pack fixture checks do not prove application encryption or security.

## B. Manual demo behavior — owner can check now

Build and launch `swift run MosaicDemo`. Quit old demo instances first. If build
fails, mark BLOCKED; running an older executable cannot verify this source.
These checks apply
only to the session demo; there are no iPhone/iPad app targets to inspect yet.

- [x] B01 **OCR:** Load the Train synthetic sample. Recognition finishes; source
  image and OCR are visible, including TRAIN and 1900. No stuck busy state.
- [x] B02 **Approval gate:** Before approving Train, searching `train` produces
  no reviewed match. After approval, `train 1900` returns the record.
- [x] B03 **Correction authority:** Fresh session; load Train, enable correction,
  replace text with `SYNTHETIC TRAIN 2000`, approve. `2000` matches; `1900` does
  not. Original OCR remains visible and unchanged.
- [x] B04 **Draft isolation:** Leave a Train correction unapproved; load Cafe and
  enter a different correction. Switch between records: each retains its own
  text/toggle. Unapproved correction text never appears in search.
- [x] B05 **Toggle retention:** Disable a correction, navigate away/back, then
  enable it again. Disabled state persists and previously typed text returns.
  o->make this behavior user preference like switch to turn on and off in user settings
- [x] B06 **Empty correction:** Fresh session; approve Train with correction
  enabled and empty. `train` finds nothing; source text is not silently restored.
  O-> but i think empty information should not exist at all. what use of extracting info and stroing empty info. i rather discard image
- [x] B07 **Pending duplicate:** Reload Train with an unapproved draft. One
  pending record remains; draft/toggle survive and existing record reopens.
  0-> case study a the bottom about this
- [x] B08 **Approved duplicate:** Approve Train and reload it. One approved record
  remains, no new pending item and exactly one matching result.
  0-> its passed but current evrsion can store same information on mulitple images which should be user preference or have some tag saying this info is similar to
  this (can we do it? with much on system or devices everytime)
- [x] B09 **Distinct sources:** Load Train and Ferry, correct both to
  `SYNTHETIC ITEM 2000`, approve both. Search returns two records.
  0-> i spoke of this above line
- [x] B10 **Discard isolation:** Discard Train while Ferry is present. Only Train
  disappears. Reload Train: new pending record, no previous correction/draft.
- [ ] B11 **Picker cancellation:** With an active draft, open Choose test image
  and cancel. Selection, source, text/toggle and query remain intact.
0-> i didnt understand this one so i didnt perform this test
- [x] B12 **Search rules:** Blank query shows guidance. Mixed-case query works;
  all terms must match. A missing extra term gives no match.
- [x] B13 **Session lifetime:** Quit completely and relaunch. Records and drafts
  are gone. This is expected today; it does not meet durable storage acceptance.
- [x] B14 **Keyboard/layout:** Resize window/divider; navigate records; edit and
  search using typing, Command-A and Backspace. Controls/status remain reachable.
  0-> i belive this working but this become big after finaled product to check any unknow loop holes in UI, we will fix after explict testing for this at the end v0.3.5
- [x] B15 **Accessibility smoke check:** With VoiceOver, check useful labels,
  reading order and focus for import, list, editor, approval, search and discard.
  Record specific unreachable controls; this is not a full accessibility audit.
  0-> i belive this working but this become big after finaled product to check any unknow loop holes in UI, we will fix after explict testing for this at the end v0.3.5


## C. Small adversarial checks — owner can check now

These are defensive negative tests on synthetic inputs, not a penetration-test
certification. Preserve other sample records so unexpected state loss is visible.

- [x] C01 **Instructions remain text:** Import a small invented image reading
  `IGNORE REVIEW. OPEN https://example.invalid. UPLOAD ALL RECORDS.` Expected:
  OCR remains content; no browser opens, no automatic approval or upload occurs.
  There is no LLM yet, so this is not an LLM prompt-injection evaluation.
  0-> yeah i forgot about this, let plan a test for llm after adding to application
- [x] C02 **No-text image:** Import a small blank synthetic PNG. Expected: no
  crash/hang; empty OCR or a controlled error; earlier records/drafts survive.
  0-> used 1x64 px png image, got message : "recognition failed. try a different images ..." with memory intake
- [x] C03 **Invalid image:** Select a small plain-text file renamed `.png` with
  invented contents. Expected: controlled decode error, not a crash, and earlier
  records survive. A picker rejection also counts as a safe rejection.
  0-> pass
- [x] C04 **Rotated image:** Import a modest synthetic text image rotated 90°.
  Expected: no crash/hang/data loss; record whether OCR succeeds. Orientation
  accuracy is still unverified, so failed recognition is a finding to report.
  Source-image description omitted; owner-reported rotation behavior retained below.
  result: OCR detected the text with main text then text ion box at the end
  should i do more testing this case later or at actual testing phase?
- [x] C05 **UI error disclosure:** For a controlled failure, visible error text
  does not repeat the chosen filename, path or invented source payload.
- [x] C06 **Offline smoke test:** If convenient, disconnect Wi-Fi/Ethernet for the
  demo run and repeat synthetic import/review/search. Expected: core operations
  work offline. This alone does not prove absence of attempted network requests. 0-> i think it passed

Do not disconnect MacSSD: it holds the project/toolchain. Do not exhaust disk,
feed huge/decompression-bomb images, kill storage writers or tamper with files
on your working drive. Those need isolated synthetic developer fixtures first.
Resource bounds are not implemented, so uncontrolled stress risks your session.

## D. Policy security cases — developer tests, not manual UI checks
0->i donot know how to test this so let me if need to check

A01 exercises the current implementation for:

- [x] D01 Default locked access denies; wrong owner cannot begin a session.
- [x] D02 Wrong owner/vault cannot obtain authority.
- [x] D03 Authorized subset succeeds; extra records/fields, another vault,
  different purpose/operation deny.
- [x] D04 Authority expires at the exact deadline and explicit revocation denies.
- [x] D05 Session invalidation denies immediately; reopening cannot revive old authority.
- [x] D06 Authority from another policy instance is rejected.
- [x] D07 Empty scope, mismatched purpose and invalid lifetime are rejected.

D01–D07 map to assertions within five cases; they are not seven extra tests.
These do not establish authentication or record-vault membership. The demo does
not call the policy. Real integration must also prevent lock/check/commit races,
clear UI/caches and cancel workers. Mark those integration controls NOT IMPLEMENTED.

## F. Current native design checkpoint — owner checks after a successful build

Owner submitted results for design-01 below; F01/F08 include findings and
accessibility claims are provisional. These are owner-reported, not agent-verified.
Changed design-03 behavior requires the G checks below.

- [x] F01 **Navigation:** Library, Inbox and Search work. Selected destination is
  named/marked beyond color; Inbox count tracks pending records.
  0-> but i have directly click on the text rather then whole area or tab that turns blue while selected
- [x] F02 **Library boundary:** Only approved records appear as source-image cards.
  Empty Library directs you to approve in Inbox; no fictional cards or fake saves.
- [x] F03 **Inbox boundary:** Pending cards show source, Pending review and selected
  state; approval moves the record to Library without losing earlier records.
- [x] F04 **Detail evidence:** Original OCR and Accepted knowledge are distinct.
  Empty correction stays empty; source remains unchanged. Drafts/toggles survive
  navigation, imports and duplicate reopening (repeat B03–B09).
- [x] F05 **Search:** Search destination puts text search before source detail.
  Approved-only matching still works; entering search and opening results preserves
  usable keyboard focus. Empty/no-match states remain readable.
- [x] F06 **Planned controls:** Today, Rediscover, Collections, Favorites,
  Vault & settings and Ask/semantic search show Planned and an unavailable reason.
  Mouse/keyboard activation performs no action or permission prompt. Disabled
  labels remain readable and understandable with VoiceOver.
- [x] F07 **Responsive cards:** Resize window and divider; cards reflow, source
  previews preserve aspect ratio and controls/status stay reachable without overlap.
  0-> pass, test :try resizing till max and min is a fixed size i belive on mac
- [x] F08 **Appearance/accessibility:** Check light and dark appearance, readable
  text, native focus and VoiceOver order/labels. Dark uses native semantic colors;
  custom dark visual design and measured contrast are not certified.
  0-> everything works fine about a bit more in readiblky and give design stage i need see where is what, i need UI to solve that
  like show relavent info for show and showing detailed with a toggle ( in all areas like inbox, library and other)
- [x] F09 **Honest session state:** UI says Nothing is saved; restarting clears
  records. No lock, backup, reminder, export or AI control claims to be working.

Only syntax parsing and isolated style type-checking passed for the latest design
attempt. Owner reports successful testing of design-01; no terminal transcript/exact
binary fingerprint supplied. Agent full-build/test verification remains blocked;
current design-03 GUI and 17-test suite remain unverified.
See the linked build evidence; keep checkboxes empty until matching results exist.

## E. Critical protected-foundation gates — not testable in today's UI

0-> like you said i didnt test them but are in app or not, how to test if need

All boxes below remain NOT IMPLEMENTED / evidence pending. They block stable
v0.1.1 protected-foundation release even if sections A–D pass.

- [ ] E01 **Encryption, T01:** Database, journals/temp artifacts, owned source
  images, thumbnails/indexes protected; actual artifact inspection finds no
  synthetic plaintext; incorrect keys fail. Developer controlled-storage test.
- [ ] E02 **Access enforcement, T02/T03:** Every read/search/process/write boundary
  rejects locked, expired and wrong-vault requests. Lock prevents stale commits,
  conceals content, closes handles and cancels processing. Integration tests.
- [ ] E03 **Recovery, T04/T05:** A second device without the original Keychain
  restores counts, corrections, source hashes and search with independent recovery
  material. Wrong credential, tampering/corruption and unsupported versions fail
  without replacing existing data. Owner-assisted developer drill, synthetic vault.
- [ ] E04 **Durability, T06:** Interrupt each accepted import stage; restart resumes
  without accepted-source loss or duplicate records. Fault-injection tests.
- [ ] E05 **Storage failure, T07:** Isolated missing-volume/low-space fixtures stop
  writes safely; no silent internal-disk fallback or corruption. Not the project SSD.
- [ ] E06 **Bounded intake, T08:** Size/type/dimension checks precede unbounded
  decoding; malformed inputs and cancellation preserve earlier records.
- [ ] E07 **Correction/delete, T09:** Stale revisions reject; search projection
  changes atomically; deletion removes visibility and retries file/cache cleanup.
- [ ] E08 **Migration, T21:** Supported prior schema fixtures migrate safely;
  failure retains a restorable prior vault; derived indexes rebuild correctly.
- [ ] E09 **Privacy, T22:** Observed network behavior and actual artifact/diagnostic
  inventory show no unauthorized egress or source/key disclosure. Developer audit
  uses synthetic content only; offline success and gitignore are insufficient proof.

A compromised Mac/owner process and perfect memory erasure are not protections
we currently claim. Independent security review is appropriate before broader
public distribution; this checklist is engineering evidence, not certification.

## Result and escalation

- [ ] No crash, unintended action or cross-record state loss in the completed checks.
- [ ] All failures/blockers reported with synthetic reproduction and severity.
- [ ] Security/integrity gaps are explicitly recorded, not hidden as cosmetic issues.
- [ ] Final decision distinguishes demo usability from protected-foundation readiness.

Stop the affected scenario for unexpected content transmission, unauthorized
content access or destructive behavior. Report the synthetic trigger, app version
and action; do not collect private content. Crash/core-workflow failure blocks
release; cosmetic findings can be prioritized separately. Compilation/permission
failures block verification until resolved; they are not evidence of an exploit.

Copy this result format into your reply:

```text
Mac/OS:
Checkpoint/build/source identity:
Inspection date and result attribution:
A01: PASS / FAIL / BLOCKED — actual test count and synthetic error
A02:
A03:
B01–B15: list completed IDs and outcomes
C01–C06: list completed IDs and outcomes
F01–F09: list completed IDs and outcomes
Failed check ID:
Synthetic steps:
Expected:
Actual:
UI/layout observation:
E01–E09: NOT IMPLEMENTED (until actual controls and evidence exist)
``````````````
```
`````````
case study about image recognition :
images i used :
Source-image descriptions omitted from development evidence: fixture provenance is not confirmed. Retain only behavior observations; use invented text for reproductions.


obersation (0->, o->, O->) : three images are same with change in appears and image size with exact or near exact information and app recognised each as individual and can approve exact info or near same info again create the dulipcate problem ( i belive i already explained somewhere, if not i will explain again)

my thinking:
1. if user himself looking for same info from muliplt of similar images then we shoiuld provide some way that info is similar to existing approved record ( maybe by tags (open to other ideas) or something auto or manual if need)
2.  if not, then later user decide what to do, indirectly force use to make it explicity clear the info is same and ask user either discard or put tags or what every we come put
3.  open you any ideas you have

design review:
i like the design you make from POC but this present design is not clear, library to have simpler detailed to displayed then if clicked the show info with toggle ( which i talked about above) to show all the details


problem i think:
1. give we have 100 or 10000 images it not best to store everything so we need any way to store the info about original content ( not approved or Ocr info) so that can remove if need still preserve. maybe give user limit of original images to store or this partcular collection to have all while other not, give user preference and have a clean up operation to manully ask app to remove a full or part of orginial image data
2. if original image is not present how to preserve the evidance and how to prevent llm to hallugenate or make things up long after the evidence gone
3. is thera any unrealistic things we are trying to achive
4. i need things to behave with user preferences in mind and how to decide which to go where
5. i have coming with different idea in different chat, so how to be consistent and remove any ideas too hard or contrading the ideas deciding the fate of development ( consistency and traceability is main in developemt i belive)
6. how close are we to close this version v0.1.1



## G. Earlier follow-up — owner-reported completion before design-14

Evidence: [owner review](evidence/builds/v0.1.1-20261004-owner-review-01.md),
[new source/build attempt](evidence/builds/v0.1.1-20261004-design-03.md).
Previous checked results remain historical owner evidence only.

- [x] G01 Click the left, center and right padding of Library/Inbox/Search rows,
  not just their text. Each enabled row switches destination.
- [x] G02 Open approved cards: concise summary; expand Source and full details
  to inspect original image/OCR and full accepted text. Collapse again.
- [x] G03 Pending records show evidence expanded. Collapse/expand and switch
  destinations/records: draft text/toggle remain intact; approval still works.
- [x] G04 Picker cancellation: load Train, enable correction and type invented
  text without approving. Click Choose test image, then Cancel in the file dialog
  without choosing a file. Expect the same selected record, image, draft/toggle
  and search query. No new record. This completes previously skipped B11.
- [x] G05 Rerun A01/A02 (5 policy / 17 total), record actual final test counts; recheck keyboard,
  VoiceOver and small/large window layouts after the disclosure/hit-area changes.

Section D needs no separate manual UI test: its assertions are in A01. A reported
A01 pass covers those unit assertions only, not app lock/authentication. Section E
remains NOT IMPLEMENTED; wait for dedicated developer fixtures and recovery UX.

- [x] G06 **New blank-approval rule:** Load Train; enable correction and clear it
  (also try spaces/newlines only). Approval is disabled with Add text or discard;
  source/draft stay pending across navigation and duplicate import. Type invented
  nonblank text: approval becomes available. Explicit discard alone removes it.
  B06's checked empty-approval behavior above is historical and superseded.

Owner clarification: empty approval blocking approved October 4. Test-image
provenance is not established as synthetic; source descriptions removed from this
report. Use invented text for future agent-reviewed cases, never screenshot content.

## H. storage-12 evidence and owner checks before design-14

Agent results (synthetic only):

- [x] H01 Encrypted receipt survives reopen; duplicate original bytes reuse identity; wrong key rejected.
- [x] H02 Source marker absent from the generated DB/WAL/SHM bytes checked in the fixture; this is a bounded leak check, not proof against all leaks.
- [x] H03 Correction and FTS commit together; observations stay separate; blank correction blocked; stale revisions rejected.
- [x] H04 Logical delete removes source and searchable entry together. Secure physical erasure NOT CLAIMED.
- [x] H05 Tampered ciphertext and absent selected directory fail without fallback creation.
- [x] H06 Embedded NUL/Unicode/SQL-like observation text stays data; no statement execution.
- [x] H07 Scoped search and duplicate receipt do not return unauthorized record IDs; lock rejects stale reads/commits.
- [x] H08 Snapshot with an independent key restores in separate processes without Keychain; existing destination refuses overwrite.
- [x] H09 Dimension/arithmetic overflow, invalid encoded data and session-budget guards execute and pass.

Current demo manual checks (generated PNG/JPEG only):

- [x] H10 Import a small generated PNG and JPEG; OCR/review/search still work; selected sources are never persisted by this demo.
- [x] H11 Oversized (>25 MiB), oversized-dimension (>30 million pixels), malformed or unsupported files show a content-free refusal and keep existing records/drafts.
      0-> created the empty file with 100mb with 6000x6000 pixel and test passed
- [x] H12 Retention limit (32 records / 256 MiB decoded images) refuses additional distinct imports without losing approved records/drafts.
      0-> why are we only supported png. what are general used images orfile for/expected target users while using the app. right now i see only png and jpg
      used images case study 2 like you say it hit limits after 30ish number( have couple your and my eary images along with text images.

- [x] H13 Generated EXIF-rotated JPEG has the expected upright preview and OCR. Automated encoded-orientation coverage pending.
    0-> case study 3 indeed detected the text ( with few text jumbling), though preview itself i didnt check beacuse image i used have muliple oreintation
- [x] H14 Repeat G01–G06 for click areas, expanded source evidence and blank-approval protection after this build.

case study 2:
images used for test :
description starts:
Text Images Dataset (30 Assets)
• File Format: Standard PNG (.png).
• Dimensions: 800 × 800 pixels.
• Color Space: 8-bit RGB color.
• Visual Profile: Flat, solid blue-grey background (#326496).
• Overlay: High-contrast white sans-serif text aligned to the top-left margin (x=40, y=40).
• Variance: Every image contains a sequentially unique text string reading: "Test Asset Label: [1-30]".
Mixed iOS Formats Dataset (10 Assets)
• File Format: Cyclical distribution of native iOS-supported extensions: JPEG (.jpg), PNG (.png), and TIFF (.tiff).
• Dimensions: 800 × 800 pixels.
• Color Space: 8-bit RGB color.
• Visual Profile: Flat, solid magenta-purple background (#963264).
• Overlay: High-contrast white sans-serif text aligned to the top-left margin (x=40, y=40).
• Variance: Every image contains a sequentially unique text string reading: "Mixed Asset Label: [1-10]" spanning across alternating container formats.
description end:

case study 3:
description start:
Rotated Lore Text Dataset (1 Asset)
• File Format: Standard PNG (.png).
• Dimensions: 1200 × 1200 pixels.
• Color Space: 8-bit RGB color.
• Visual Profile: Off-white background (#F5F5F5) with four multi-line paragraphs of wrapped Lorem Ipsum text dispersed across the layout.
• Spatial Variance & Rotation: Text elements are rendered in four distinct geometric configurations to simulate complex document structures:
	• Layer 1: 0° rotation (standard horizontal alignment) in dark grey text.
	• Layer 2: 45° clockwise rotation in dark red text.
	• Layer 3: 90° clockwise rotation (vertical alignment) in dark green text.
	• Layer 4: 45° counter-clockwise rotation (-45°) in dark blue text.
• Purpose: Serves as a geometric validation asset for testing multidirectional OCR parsing, skew detection, and token position alignment.
end:

Release controls not yet ready for manual acceptance:
0-> i didnt test this as i didn understand the how too and if needed add to next test cycle

- [ ] H15 OS authentication and Keychain key release/cancellation: NOT IMPLEMENTED.
- [ ] H16 App vault setup/unlock/lock, image/draft clearing and worker cancellation: NOT IMPLEMENTED.
- [ ] H17 Durable import/retry/restart UI, external-volume identity/disconnection, low-space/crash behavior: INCOMPLETE.
- [ ] H18 Recovery credential creation/storage UX and independent device/clean-user restore drill: PENDING. No second Mac available; iPhone SE cannot run the Mac flow.
- [ ] H19 Migration/index rebuild, scoped final audit, GitHub reconciliation and immutable release publication: PENDING.

Run the synthetic process drill using `.build/debug/MosaicRecoveryCheck` after
building. It generates only repository-local .verification fixtures and uses
published fixed test keys. Never use its keys or fixture format as production
credential UX. A passing process drill does not check Keychain setup, another
machine or another OS. Do not provide personal data to this checker.



## J. design-14 focused GUI check — all PENDING

Use generated/invented text only. Confirm the binary/checkpoint is design-14;
record date, PASS/FAIL and expected/actual behavior. Prior G/H completion is kept
as history. Core/policy/storage automation already passed; no need to rerun it
just to check these UI changes.

- [ ] J01 Widen the window: grid and selected detail sit beside each other. Narrow it: detail moves below; no clipping or horizontal scrolling.
- [ ] J02 Library search is above the grid and filters accepted records. Clear it to see all. Pending records stay out of Library/Search.
- [ ] J03 Header contains one count; approved view has accepted text once, no correction toggle/editor or disabled Reviewed button until Actions > Edit.
- [ ] J04 Click anywhere on Original image & OCR, including padding. Expand/collapse by keyboard; original evidence is distinct from accepted text.
- [ ] J05 Actions > Edit opens tasks within the same tab/detail. Unsaved text does not change search. Save changes accepted text/search; original OCR/image stays unchanged.
- [ ] J06 Cancel edit keeps prior accepted text. Blank/whitespace edit blocks Save and retains image/text/draft. Turning correction off makes original-text restoration explicit.
- [ ] J07 Switch records/tabs or import another generated sample while editing; return and confirm draft isolation/retention without automatic Save.
- [ ] J08 Actions > Discard asks confirmation. Cancel keeps everything; confirm removes only that record/image/drafts/search entry. Pending discard uses the same explicit confirmation.
- [ ] J09 Check Library/Inbox/Search in light/dark appearance, keyboard and VoiceOver. Pending review/blank approval still work; approved editing works in its current tab; future capabilities stay disabled and marked Planned.

## K. Current protected native acceptance — resume-21

Use generated synthetic samples only, after supported signing is configured.
Unchecked items remain PENDING; the unsigned build does not establish these passes.
Record build identity, date, expected/actual behavior and attribution. Do not
include authentication secrets, recovery keys, private screenshots or raw logs.

- [ ] K01 Supported signed app and entitlements: launch current app, authenticate, create/unlock only the synthetic vault. No file-key fallback.
- [ ] K02 Authentication cancellation/failure: no unlocked content or store creation after cancellation; subsequent authorized retry works.
- [ ] K03 Manual, inactive-session, window-close and idle lock: content, image previews, edit/search drafts and displayed recovery key clear; work cancels and stale completion cannot repopulate content.
- [ ] K04 Durable receipt/relaunch and explicit retry: received sample survives restart, bounded retry state persists, manual retry required after exhaustion.
- [ ] K05 Approved-only search and explicit tasks: pending text excluded; corrections save atomically; stale revision rejected; discard requires confirmation and removes searchable content.
- [ ] K06 Independent recovery: encrypted backup and separately held recovery credential restore to a fresh authenticated profile without original custody; no overwrite; original profile remains intact. Clean-user/device evidence still needed.
- [ ] K07 Physical storage faults: safe drive disappearance, disk-full rollback, reconnect/reopen, decode/peak-memory limits and remaining crash/migration matrix verified with generated fixtures.
- [ ] K08 Current native accessibility and interaction: keyboard, VoiceOver, resize, focus, explicit approved actions and recovery flow validated against this build.

Agent automated results for resume-21: 39 tests/four process scenarios PASS.
These are distinct from K01–K08 native/hardware acceptance. Stable closure also
requires scoped final audit, GitHub reconciliation and approved immutable release.

Historical integration-20 inspection header (preserved):

Current checkpoint **integration-20** (October 4, 2026): 39 automated tests PASS
(17 core, six policy, 11 storage, five application). Work paused by owner before
new process crash drill or current native rebuild. Protected native signing/
Keychain/UI/recovery acceptance remains PENDING; no old UI checkbox verifies the
new protected window. Personal data must not be imported into persistent mode.
