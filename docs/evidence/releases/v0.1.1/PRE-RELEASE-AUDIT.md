# v0.1.1 pre-release scoped review — October 8, 2026

NOT a final release audit, independent security review or stable recommendation.
Scope: application/policy/storage integration, main-window wiring, dependency pin,
privacy/data-flow declarations, generated-fixture tests and release-evidence accuracy.
Current automated baseline recovery-34: 42 tests PASS. Native workspace-33 compiled
unsigned; executable SHA-256 `c0fb8e34c525852974dac589fe840a4fd7d5d56ec6ab4fdf580942ca2c89ea28`. Test-only change at 34; no application
source changed after that native compilation. Exact owner signed binary unknown.

## Actual artifact/data inventory

| Artifact | Implemented handling | Verification/limits |
|---|---|---|
| Sources/OCR/corrections/retry/FTS/vault identity | SQLCipher encrypted tables; owned source BLOB with transactional receipt | Synthetic DB/WAL plaintext-marker and wrong-key tests; no production store inspected |
| SQLite WAL/journal | SQLCipher database connection; WAL/FULL writes | Process abrupt-exit scenarios pass; no physical disconnect/OS-disk-full proof |
| SQLite temporary data | temp_store MEMORY, cipher_memory_security enabled | Managed/OS memory zeroization and swap protection not claimed |
| Vault UUID/owner UUID/setup/profile pointer | Plain repository-local metadata, no OCR/key | Code review; path selection/portable production root unfinished |
| UI images/content/drafts | Ephemeral model, shared protected workspace, clear on lock | Publication probe/policy/workspace tests; current signed native lock UI pending |
| Recovery material | Random 32-byte key displayed only on owner action; backup explicitly selected | Owner same-Mac retry PASS, failed attempt retained; never collected by agent |
| Backup/migration staging | Encrypted staged SQLite in selected parent; verified/closed before move; no overwrite | Synthetic restore/migration tests; final physical-space/fault acceptance pending |
| Personal-image memory demo | Independent temporary session; not persisted/migrated | Manual-only narrow exception; no agent inspection |

## Dependency and runtime review

Exact official SQLCipher.swift 4.19.0, revision
39f212458aeb88e33bdac2200a793a3f0d55d32b, root/native locks previously compared.
License attribution exists. No new dependency. No named URLSession/NWConnection/
WKWebView references in reviewed Swift source; no runtime network trace or vendor
binary vulnerability audit performed. Privacy manifest declares no tracking/data
collection; required-reason API inventory still needs final assessment.

## Implemented checks versus remaining release gates

Implemented synthetic tests cover unauthorized/replayed/expired/locked scopes,
accepted-only FTS, revision/delete behavior, durable retries, schema-v1 migration
and future rejection, source/index encryption checks, wrong keys/tamper, bounded
encoded PNG/JPEG/orientation, logical SQLite-full rollback and lost file identity.
They do not pass real Keychain/signing/native UI or clean-user/device recovery.

Release blockers still include current main-workspace native acceptance, immediate
manual/system/idle lock acceptance, independent recovery without original custody,
physical volume/OS full-disk and peak-memory evidence, supported vault location /
selected synthetic import requirements, final dependency/privacy/data-flow audit
and issue reconciliation. No P0/P1 closure or absence of critical/high findings
inferred from these partial checks. Original restore failure cause is unresolved;
successful retry is separate evidence, not an implemented repair.

GitHub issue read succeeded, create returned FORBIDDEN (403). User conditionally
authorizes stable commit/push/merge; no push/merge/tag/release performed prematurely.
Do not repurpose a passing test or next-version visual deferral to waive foundation
protection/data-integrity requirements. GitHub remains ticket status authority.

## October 8 follow-up — One-window Settings composition

Current application checkpoint settings-41-native; settings-40-tests records 46
tests, including four actual app-model regressions with fake custody. The old
memory/recovery scenes and legacy demo view are removed; one Window uses one model,
Settings unlock/lock/backup/restore and vault badges. No personal migration. Prior
inventory rows describing the memory demo are historical and no longer describe
the current app surface. General unlock is implemented; per-record unlock is not.

Actual-model tests reproduced immediate-lock/reopen failure; serialized prior
closure fixes that regression (39/40). Earlier owner restore failure remains a
separate unresolved historical attempt; no causal link to this bug inferred.
Current native compile is unsigned and not native authentication acceptance.
Owner review policy is one final five-case batch, not homework after every build.
Hardware/independent recovery and remaining software gates are not waived.

## October 11 — Current integration/source audit follow-up

Authoritative current application evidence: recovery-61-native;57 tests at60.
Selected invented PNG/JPEG import and remembered existing-directory selection are
implemented. Old inventory's default-root/import limitations are historical.
Location bookmarks are bounded and resolved without UI/mounting; unavailable/stale
selection rejects. Actual model restore-before-unlock exercises selected folder.
Restored profiles use fresh vault identity/custody; encrypted staged copy alone is
rebound. Original source, backup and custody are preserved.

Source-only reviewer examined current application/custody/storage/policy/main
composition. Concrete restore-location, cancellation, mutual-await and original-
custody issues were fixed; no remaining critical/high finding identified in that
scope. No malicious-process penetration test, credentials/runtime/user-data
inspection, vendor binary vulnerability review, physical SSD/disk-full/peak-memory
acceptance or independent signed recovery was performed. Keep these limits explicit.

Static dependency/resource inventory: exact SQLCipher4.19.0/revision39f212... pin
retained; license attribution present. Built SQLCipher framework carries its vendor
privacy manifest (DiskSpace E174.1; FileTimestamp C617.1/3B52.1; no tracking/collection).
Root manifest declares no tracking/collection. Named URLSession/NWConnection/
WKWebView/UserDefaults/systemUptime/statfs/attributesOfItem search found no app-source
references; recovery CLI Process is a synthetic test harness. This is static
inventory, not a runtime egress or whole-binary required-reason attestation. See
[Apple required-reason guidance](https://developer.apple.com/documentation/bundleresources/describing-use-of-required-reason-api).

Current Debug launcher retains earlier hash; actual application code resides in
Mosaic.debug.dylib, SHA25670bd567ba2a8323a1159de81583e64865776bf76f47dc63f9cf6580db8e74c84.
Earlier launcher-only hashes do not uniquely identify changed Debug app code.
Checkpoint54's premature PASS is explicitly invalid;55 records actual failed/hung
run and correction. Use completed60/61, not54, as current passing evidence.

Stable closure remains blocked on native/fault/independent-recovery acceptance and
GitHub write/ticket reconciliation. No tag, release, push or main merge performed.

## Native unlock failure follow-up — October11 key-63 through65

Owner reports keyUnavailable after password prompt; native unlock gate FAIL.
Current58-test/unsigned-native results support only safe diagnostic code changes,
not successful real key release. Fixed SecItem result classification makes the next
focused native attempt actionable without logging credentials, queries or material.
[Apple missing-entitlement reference](https://developer.apple.com/documentation/security/errsecmissingentitlement)
and [item-not-found reference](https://developer.apple.com/documentation/security/errsecitemnotfound)
support distinct statuses; neither establishes which occurred in the owner build.
No root cause claimed, no user Keychain accessed or protective fallback introduced.
