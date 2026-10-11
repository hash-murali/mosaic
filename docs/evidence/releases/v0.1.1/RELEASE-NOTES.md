# v0.1.1-rc.1 — Protected Mac Foundation

Synthetic-only release candidate. Native recovery, storage-fault, peak-memory and
remaining device acceptance are deferred by the owner, NOT PASSED. This release
does not authorize personal-image persistence or claim fully validated stability.

One protected Mac app now shares Inbox, Library, Search and Settings, with vault
badges, explicit invented PNG/JPEG import, SQLCipher encrypted storage, scoped
content access, persistent corrections/search, immediate locking, remembered vault
folder and independent fresh-identity backup restore. Package launch guidance and
safe Keychain error codes support native testing without exposing key material.

Validation:59 synthetic tests, unsigned native build, two lock-publication probes,
four independent-process/crash scenarios,24 development-pack checks andnine SQL
checks pass. Owner reports native manual authentication/lock and restart persistence
pass; exact owner binary identity unknown. Scoped final audit records limitations.

Deferred inspection: [issue12](https://github.com/hash-murali/mosaic/issues/12),
consolidated by v0.4 or earlier when ready; quiet reminder configured. Backlog
reconciliation on [issue10](https://github.com/hash-murali/mosaic/issues/10).
Candidate [PR11](https://github.com/hash-murali/mosaic/pull/11) remains open: automatic
approval review blocked main merge pending explicit acceptance of deferred gates.
Next planned design is v0.1.2 content-first UI/icon actions/separate edit task window.

Source release only. No unsigned app binary, runtime vault, backup, key, personal
image or per-user IDE state included. Existing v0.1.0 tag/release remains immutable.

## October11 follow-up — explicit deferred-risk approval and completed merge

Owner explicitly approved merging PR11 despite deferred recovery/storage/memory/
native-device validation. Original rejection is preserved as history; approval
resolves its authorization condition, not the validation gaps. Main fast-forward
90fad52 pushed normally,59 merged-source tests PASS atmain76; GitHub PR11 Merged.
Immutable rc.1 tag stays0ad4b1f; stable v0.1.0 unchanged. Deferred issue12/reminder
remain open. Next development v0.1.2 content-first workspace can start from main.
