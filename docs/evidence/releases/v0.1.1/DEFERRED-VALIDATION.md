# Consolidated deferred validation — v0.1.1 onward

October11,2026. Owner explicitly asks to defer local-user and storage-full/
disconnection testing, collect missed tests and remind them later when similar
checks can run together. These are NOT PASSED. Target consolidated review: v0.4,
or earlier when at least five compatible pending cases have a testable build.
GitHub owns ticket status; this document is inspection/acceptance evidence only.

- [ ] DV1 Independent recovery: synthetic backup/key restores under a different
      local macOS user with no original Mosaic Keychain. Verify correction/search.
- [ ] DV2 Full storage: real OSENOSPC on a disposable generated volume; writes fail
      safely, durable records survive and processing resumes after space returns.
- [ ] DV3 Storage disappearance: dedicated synthetic vault, remove/reconnect test
      volume; hide content, stop work, no fallback store, recover committed state.
- [ ] DV4 Peak memory: largest supported synthetic PNG/JPEG import, OCR, preview,
      backup; record process/total memory and responsiveness against chosen budget.
- [ ] DV5 Native cancellation/system/idle lock: cancel authentication stays locked;
      system-session and five-minute idle lock clear source/text/drafts reliably.
- [ ] DV6 Native folder/picker/restore lifecycle: selected invented images only,
      remembered folder and restore before first unlock, duplicate corrected record.
- [ ] DV7 Native confirmed delete: remove record and search result, persist restart.
- [ ] DV8 Apple-device compatibility: existing Mac, primary iPhone, SE2020 and iPad
      when targets exist; record exact supported OS/capability combinations.

Owner-reported authentication/manual lock and restart persistence passed at owner69;
do not repeat unchanged passes. DV4-DV8 are remaining analogous acceptance cases
batched under the owner's instruction, not claims of individually waived risks.

One synthetic-only session; do not send passwords, keys, content, private logs or
account details. Attach build identity/date, owner/agent attribution and actual
PASS/FAIL/BLOCKED to evidence, update inspection/audit and relevant GitHub issue.
Version changes do not automatically pass a deferred check. No personal-data
persistence authorization; no stable recovery/fault guarantee until verified.

Reminder automation: mosaic-deferred-validation-review, Mondays10:00 local time,
quiet until v0.4 or a ready batch; notify once for newly actionable state.
Artificial-disk mounting still needs its specific approval (FAULT-DRILL.md).
