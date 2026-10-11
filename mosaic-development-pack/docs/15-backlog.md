# Prioritized implementation backlog

All items planned. Roles are responsibilities, not assigned staff. IDs are stable and suitable for issues; see templates/issue.md. Implement one vertical outcome at a time. Every release retains prior tests.

| ID | Release | Task | Dependencies | Acceptance |
|---|---|---|---|---|
| MOS-001 | 0.1 | Inventory repository and existing targets | None | Actual path, Git state, toolchain and rules reported; no destructive setup |
| MOS-002 | 0.1 | Platform/model capability matrix | 001 | Actual devices/OS; deployment minimum and fallback; dependency candidate licenses |
| MOS-003 | 0.1 | Encrypted SQL/FTS and source spike | 002 | Actual adapter builds; plaintext/journal inspection; FTS edit/delete; wrong-key failure |
| MOS-004 | 0.1 | Key/recovery/backup spike | 003 | Second device without original Keychain restores; tamper/wrong credential fail |
| MOS-005 | 0.1 risk spike | Extension staging boundary | 002,003 | Staging-only design or unlock fallback validated; no whole-vault key shared |
| MOS-006 | 0.1 | Domain, errors and service contexts | 001 | Typed invariant tests, policy context and documented signatures |
| MOS-007 | 0.1 | Storage adapter and migration runner | 003,004,006 | Transactional persistence; backup-before-upgrade; fault recovery |
| MOS-008 | 0.1 | Owner lock/policy enforcement | 006,007 | T02/T03 negative boundaries including search/jobs |
| MOS-009 | 0.1 | Durable image import and jobs | 007,008 | T06/T07/T08; accepted source receipt protected |
| MOS-010 | 0.1 | Vision OCR adapter and projection | 009 | Source-linked text, unreadable failure and searchable projection |
| MOS-011 | 0.1 | Mac inbox/detail/edit/search/delete | 010 | J01 manual version; T09; all core screen states |
| MOS-012 | 0.1 | Snapshot UX and release evidence | 004,011 | T01/T04/T05/T21/T22; v0.1 gates reviewed |
| MOS-013 | 0.2 | iPhone/iPad application adapters | 012,002 | Explicit native import/review/search/lock parity |
| MOS-014 | 0.2 | Share extension intake/adoption | 005,013 | T11; protected durable staging and visible progress |
| MOS-015 | 0.2 | Photos discovery and resumable scan | 013 | T10; date scope, limited access, dedupe, no silent download |
| MOS-016 | 0.2 | Collections/status/adaptive UX | 013 | R10/R18; T24; user state independent of claims |
| MOS-017 | 0.2 | Confirmed dates and reminders | 016 | T12; absolute date/time/timezone and consent; generic notification |
| MOS-018 | 0.3 | Local provider/extraction validation | 002,010 | Capability fallback; T13/T15; evidence schema and bounded failures |
| MOS-019 | 0.3 | Entities, merge/split and corrections | 018,016 | T16; append revisions, merge preview/undo, human precedence |
| MOS-020 | 0.3 | Connections and review ranking | 019,017 | T17; reasons/sources; no automatic truth or supersession |
| MOS-021 | 0.3 | Local embeddings and hybrid retrieval | 002,019 | Selected licensed adapter; policy-filtered candidates; T14 and retrieval metrics |
| MOS-022 | 0.3 | Grounded Ask and evaluation harness | 018,020,021 | 200-capture/50-question suite; citations/abstention; no fabricated high-impact date |
| MOS-023 | 0.4 | Approved selective export/import | 019,022 | T18/T19; field preview, revisions, encrypted default and safe import |
| MOS-024 | 0.4 | Audit/privacy/diagnostics/help | 008,023 | T20; control inventory; honest limitations |
| MOS-025 | 0.4 | Cross-device snapshot transfer | 012,013,023 | R20; separate instance; restore hash/count comparison |
| MOS-026 | 0.4 | Stress, accessibility and security review | 022,024,025 | T01–T24 applicable; no blockers; published hardware metrics |
| MOS-027 | 0.4 | Dogfood, signing and beta release | 026 | Two-week owner use, observed sessions, signed builds, evidence and sign-off |

## Immediate ready task

MOS-001 outcome is a report only. Inspect actual Mac project; identify whether scaffold exists, whether instructions were installed and which scheme builds. Acceptance: no repository reset, no private-data read, verified toolchain and concrete next task. This pack cannot execute that Mac-only task from the current remote environment.

## Later epics

SYNC encrypted pairing/convergence/conflicts v0.5; INTEROP scoped tokens/interfaces and URL/PDF intake v0.6; RESEARCH opt-in verification/recommendations v0.7; ORG multi-user key/role model later. Do not start those before a separate requirements/architecture review.
