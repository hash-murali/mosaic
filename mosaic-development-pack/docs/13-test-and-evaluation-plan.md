# Test and evaluation plan

Test catalogue defines future implementation evidence. Pack validator is a much narrower check and does not pass these application gates. Use synthetic data in CI; real owner content stays out of repository, hosted runners and agent sessions.

| Test | Requirement | Behavior under test | Earliest gate |
|---|---|---|---|
| T01 | R02 R06 NF01 | Inspect DB, journals, files, thumbnails and temp paths for plaintext; wrong key unreadable | v0.1 |
| T02 | R06 NF02 | Locked, expired, wrong-vault and ungranted contexts denied on all content interfaces | v0.1 |
| T03 | R06 | Lock invalidates queued/in-flight work, conceals UI, clears caches and closes handles | v0.1 |
| T04 | R07 | Correct credential restores counts, source hashes and corrections | v0.1 |
| T05 | R07 R20 | Wrong credential, corrupt snapshot, unsupported schema and missing Keychain item fail safely | v0.1 then v0.4 |
| T06 | R01 R19 | Kill at every import stage; durable receipts resume without duplicates/loss | v0.1 |
| T07 | R19 | SSD removed/space exhausted stops writes without internal fallback/corruption | v0.1 |
| T08 | R01 R03 | Bounded malformed/unreadable image rejects safely, retains accepted source where applicable | v0.1 |
| T09 | R04 R05 | Edit/correction searchable atomically; stale revision rejected; delete clears index/cache | v0.1 |
| T10 | R08 R09 | Denied/limited/revoked Photos and optional discovery preserve explicit import | v0.2 |
| T11 | R08 | Extension protected receipt, adoption idempotency and staging boundary tested | v0.2 |
| T12 | R11 | Yearless/relative dates stay candidate; confirmation and notification consent required | v0.2 |
| T13 | R12 NF01 | Injected instructions cannot execute tools/network/change privacy | v0.3 |
| T14 | R05 R15 NF02 | Unauthorized evidence never enters snippets, vector result or inference prompt | v0.3 |
| T15 | R12 | Multi-entity extraction/evidence validation with measured precision/recall | v0.3 |
| T16 | R04 R13 | Reprocess respects corrections; merge/split lineage; conflicts remain potential | v0.3 |
| T17 | R14 R15 | Review excludes completed/snoozed items; Ask citations support assertions/abstention | v0.3 |
| T18 | R16 | Export preview matches actual fields/files; grant/revision rechecked; unauthorized dependencies omitted | v0.4 |
| T19 | R16 R20 | Export/transfer round trip, archive bounds/traversal and separate instance behavior | v0.4 |
| T20 | R17 NF09 | Diagnostic/audit allowlist excludes OCR, titles, paths, secrets and raw errors | v0.4 |
| T21 | R19 NF08 | Every prior schema fixture migrates; failure recovers prior vault; indexes rebuild | Each release |
| T22 | NF01 NF09 | Offline core journeys; network observation and repository/private-artifact scan | Each release |
| T23 | R19 NF06 | 10k metadata benchmark, 1k mixed-image stress, memory/space bounds and cancellation | v0.4 |
| T24 | R18 NF07 | Keyboard, VoiceOver, Dynamic Type, supported layouts and error/empty states | v0.2 then v0.4 |

## Test layers

Unit tests cover meaningful domain invariants, policy decisions and date confirmation. Integration tests cover storage transactions, file saga, migrations, extension staging and provider output validation. UI journeys cover user-visible behavior and recovery. Fault injection controls stage crashes/volume absence. Evaluate actual model outputs separately from deterministic contract tests.

## Corpus and metrics

200 labeled images and 50 search questions minimum for v0.3; stratify category and difficulty. Track schema validity, extraction precision/recall, expected-source rank, supported-assertion rate and abstention. Human evidence review required. Pack's synthetic JSON examples are not model accuracy tests.

Publish baseline device, OS/SDK, build, provider/model/prompt/schema versions, corpus digest, count, timing definition and failures. Search p95 <300 ms at 10k, first screen p95 <2 s, typical OCR p95 <5 s are proposed budgets. AI latency measured separately. Privacy-safe crash-free-session target 99.5% requires reporting sample size and collection method; small beta is not an established reliability guarantee.

## CI and release

Any runner: docs/contracts/SQL checks. Mac runner: Swift unit/integration and app build. Simulator and real devices: permissions/Keychain/extension behavior and UX. Encrypted external-vault tests require controlled Mac setup. No fabricated passing status if hardware unavailable. Build gating and test evidence templates in templates/release-evidence.md.
