# Release roadmap and finalization rules

| Version | Required outcome | Main implementation tasks | Blocking evidence |
|---|---|---|---|
| v0.1.0 | Safe Mac import to searchable record | MOS-001 through MOS-012 | Protection, source/OCR, retry, search/edit/delete, backup/restore |
| v0.2.0 | Native daily capture and review | MOS-013 through MOS-017 | Device matrix, extension staging, discovery, permission denial, accessibility |
| v0.3.0 | Grounded intelligence and rediscovery | MOS-018 through MOS-022 | Extraction/retrieval evaluations, correction precedence, evidence links |
| v0.4.0 | Dependable private beta | MOS-023 through MOS-027 | Selective export, transfer, hardening, dogfood, signed builds and evidence |

All prior gates remain mandatory. v0.1 Mac working layout is stable enough to test; v0.2 establishes adaptive layouts and major navigation; v0.3 validates AI evidence/review interactions; v0.4 freezes terminology and resolves all core design defects.

No live sync, organization login/admin console, external AI or remote research is necessary to pass v0.4.0. Supported devices without a model use manual/OCR workflows; semantic/Ask capabilities must be clearly labeled by capability. v0.4 includes snapshots, not concurrent merge.

Later: v0.5 encrypted live sync; v0.6 scoped interfaces and URL/PDF capture; v0.7 opted-in research and recommendations; v0.8+ deeper graph and organizational editions; v1.0 sustained general-availability support. Each later version requires its own updated PRD and ADRs before implementation.

Estimate 15–24 focused developer weeks through v0.4 based on the preceding plan. Treat as provisional; first re-estimate after the encryption and recovery spikes and v0.1. Device inventory, Swift experience and part-time schedule affect calendar time.

## Finalization

Zero open P0/P1; zero critical/high security finding; relevant R/NF tests pass; migration and recovery evidence exists; documentation is current; owner accepts known limitations. A release candidate admits fixes and evidence work only. Optional scope can be explicitly deferred; privacy and data integrity cannot.

Scope promotion into an earlier release requires a decision record listing effort, dependency and testing impact. Release label alone is never acceptance evidence.
