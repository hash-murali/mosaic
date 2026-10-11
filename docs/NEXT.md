# Next development — v0.1.2

Owner authorizes moving on after v0.1.1-rc.1 scoped audit/publication. Main design:
content first, icons as secondary actions, explicit separate edit task window,
Library side detail when wide and below when narrow. Keep one protected collection;
never reintroduce separate memory/vault apps or weaken authentication/storage.

Carry deferred native/fault/recovery/device inspection forward with the consolidated
checklist and reminder; see evidence/releases/v0.1.1/DEFERRED-VALIDATION.md. This is
planning, not implemented v0.1.2 behavior. GitHub owns task status.

## Historical next-step notes

# Next phase: v0.1.1 protected Mac foundation

Baseline: v0.1.0 “Session Review”, release commit dbf1937. Its immutable release
scope and tag remain unchanged. Human-approved target as of October 2, 2026:
**v0.1.1 protected foundation**, including existing review fixes/design refinement.
Active branch remains codex/v0.1.1-1-review-drafts with uncommitted prior work.

Use the development pack's protected Mac foundation outcome (MOS-001–012) for
v0.1.1: encrypted owned source and database, durable import/jobs, local OCR,
correction/search/delete, vault lock and independent backup/restore. The protected synthetic
main workspace now implements this flow; native/fault/recovery acceptance is
unfinished, and the separate personal-image demo remains memory-only.
See [inventory](evidence/repository-inventory.md),
[capability matrix](evidence/capability-matrix.md) and D-008/D-009 in DECISIONS.md.

Initial validation targets are macOS 27 and iOS/iPadOS 27 by owner direction.
v0.1.1 delivers the Mac slice; native mobile intake and intelligence remain later
pack milestones. Current stable OS first; older OS support is added only with
verified core guarantees and capability-based disabling of optional features.
The package's existing minimums are not verified application support promises.

Sequence: capability inventory and domain/policy contracts, actual encrypted
adapter spike, independent recovery spike, then protected Mac import-to-search.
Retain prior review tests and validate UI/failure states throughout. Do not install
dependencies or broaden private-data authorization without explicit approval.
The existing human-only in-memory image test exception remains narrowly scoped.

[GitHub Issues](https://github.com/hash-murali/mosaic/issues) owns task status,
priorities, dependencies and acceptance criteria. The existing
[v0.2.0 milestone](https://github.com/hash-murali/mosaic/milestone/1) still requires
remote reconciliation; it does not represent the newly approved v0.1.1 scope.
See ROADMAP.md for finalization. No parallel local ticket tracker is maintained.

October11 publication traceability: [candidate PR11](https://github.com/hash-murali/mosaic/pull/11), [deferred validation issue12](https://github.com/hash-murali/mosaic/issues/12), [audit/backlog dispositions on issue10](https://github.com/hash-murali/mosaic/issues/10). API writes failed403; authorized browser publication succeeded. Deferred checks remain unpassed.
