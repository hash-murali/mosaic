# v0.1.1 owner policy and authenticated storage contract

Current source reviewed October 8, 2026; evidence review-22. This document describes
implemented mechanisms separately from native acceptance. It does not authorize
personal data or claim stable release readiness. GitHub Issues owns task status.

## Composition and trust

MosaicDomain contains Foundation values; MosaicPolicy issues process-local
capabilities. ProtectedVault owns OwnerPolicyState and EncryptedDatabase on one
actor and validates authority immediately before synchronous SQLite operations.
VaultSession composes custody, bounded intake, OCR, storage and scoped operations.
The main protected Inbox/Library/Search calls VaultSession through one shared
ProtectedDemoModel (D-023). One window exposes Settings unlock/lock/recovery and
vault badges; the old personal-image memory UI is removed, with no migration.

AppleVaultKeyCustody requests deviceOwnerAuthentication, zero configured Touch ID
reuse, userPresence access control, WhenUnlockedThisDeviceOnly accessibility,
non-synchronizable data-protection Keychain items and a synthetic-only namespace.
This adapter is compiled but signed native behavior remains PENDING. Automated
application tests use fake custody; matching an owner UUID is not authentication.
No file-key/plaintext or silent provider fallback is implemented.

Policy and low-level EncryptedVault are process-local primitives, not isolation
against arbitrary code running in the app process. The low-level adapter is used
by synthetic tests and controlled restore; it does not enforce the policy layer.
Trusted entry points must use authenticated composition. No external plugin or
other project is authorized to open the vault.

## Authority lifecycle and explicit scope

The policy starts locked. Beginning an owner session invalidates old grants.
Content grants bind owner, vault, session, operation, purpose, record IDs and
fields. Requests require nonempty explicit record/field sets; validation permits
only the original or narrower scope. Tokens cannot be constructed by clients.
Revocation, session invalidation, expiry or another policy instance deny replay.
Expiry is at most five minutes; the service requests 60-second grants. Content
and catalog grants share a cap of 1024. Date-based clock discontinuity hardening
is not implemented.

Catalog grants expose bounded capture identities, not a content wildcard:
1–100 identities per page. VaultSession requests record-specific grants after
catalog enumeration. Search uses an explicit record-ID SQL filter and accepted
text only; duplicate receipt cannot disclose an existing out-of-scope identity.
The initial persistent surface is capped at 100 captures.

Snapshot uses ownerBackup purpose and source/observation/correction/processing
fields. Snapshot and index rebuild require an explicit complete capture scope,
validated before consulting the catalog; partial snapshot requests fail before
creating the destination. This does not implement general export/destination
consent or other-project access.

## Durable workflow and lock

Source bytes and receipt metadata commit together in encrypted SQLCipher blobs.
PNG/JPEG, byte/dimension and single-frame limits precede receipt. Observations and
accepted corrections are separate. Processing resumes durable received-stage
records; three persisted failure attempts require explicit retry thereafter.
Cancellation and lock preserve the receipt and do not consume failure attempts.
Approval/delete use expected revisions and update accepted-only FTS transactionally.

VaultSession changes its epoch on lock, cancels its worker, closes storage and
invalidates custody context. ProtectedVault lock invalidates capabilities and
closes its database. A commit already executing finishes before lock can run;
a later queued commit is rejected. Detached decode/Vision cancellation is
cooperative and does not promise instantaneous OS work interruption or memory
zeroization.

The UI immediately clears previews, records, edit/search drafts and recovery-key
strings on lock; those native events need current-build manual acceptance. Opening
awaits previous storage/custody closure before reauthentication: actual-model tests
reproduced a concurrent reopen failure and now verify serialization. Tests inject
fake custody and generated roots; default product composition remains platform
custody. Native general unlock and Settings/badges are not per-record encryption.
Review-22 identified an open-flow ordering defect, reproduced by an isolated
actual-code regression probe (lock-23-red). Owner-approved fix checks cancellation
and the UI epoch before publishing loaded records; two probe scenarios pass at
lock-24-green. This verifies publication logic, not full native scheduling or
signed GUI lock acceptance. Service-level tests do not prove every UI path.

## Encryption, recovery and bounded storage

SQLCipher.swift Community Edition is pinned exactly to 4.19.0. Database identity,
source, observations, corrections, retry state and FTS live inside encryption.
Generated vault/owner UUIDs and profile selection metadata are outside the database.
WAL uses FULL synchronization; temporary SQLite storage is in memory. Integrity
and source hashes are checked; unavailable/replaced file identity closes the
handle without a fallback root. Logical deletion removes records/FTS; physical
secure erasure of every WAL/free-page copy is not claimed.

Independent random 32-byte recovery keys encrypt snapshots staged in the selected
parent, integrity checked and published without overwriting an existing file.
Restore opens the selected synthetic backup read-only, verifies sources, requests
destination custody and writes a fresh profile. Same-device custody may resume an
existing vault-ID key; independent-custody tests use a different key. A same-Mac
restore does not establish clean-user/device recovery. Credential UX and signed
native recovery remain PENDING.

Limits include 25 MiB encoded image, 30 million pixels and a database page cap.
The memory-only demo also checks 256 MiB retained image bytes and 32 records.
These bounds do not prove peak-memory or total database/WAL/staging space limits.
HEIC/TIFF remain disabled with TODO references. The protected surface uses a
repository-local synthetic root; configurable physical-volume selection and
hardware disappearance/full-disk acceptance remain unfinished.

## Evidence and acceptance

Resume-21 records 39 tests, four process recovery/crash scenarios and unsigned
native compilation. Those historical results cover fake custody and generated
fixtures, not OS authentication, UI/VoiceOver, hardware fault tolerance or a final
security audit. Native checklist K in INSPECTION-v0.1.1.md remains unaccepted.
See SIGNING-v0.1.1.md for owner setup, and AUDIT.md for preserved checkpoints.
