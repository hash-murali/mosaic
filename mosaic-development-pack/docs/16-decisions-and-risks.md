# Decisions assumptions and risks

## Open decisions

| ID | Decision and default | Owner role | When required | Work can proceed meanwhile |
|---|---|---|---|---|
| D01 | Actual iPhone/iPad models and OS unknown; no invented support promise | Product owner/lead | MOS-002 before device commitments | Mac domain/docs work |
| D02 | Actual repository/project uninspected | Lead | MOS-001 before project edits | Documentation and synthetic contracts |
| D03 | SQLCipher candidate/library/license unverified | Architect | MOS-003 before persistent real data | Domain and bounded logical SQL tests |
| D04 | Recovery suite/credential/envelope proposed | Security/lead | MOS-004 before real-data backup | UX/spec and synthetic prototypes |
| D05 | Extension locked capture protection proposed | Architect | MOS-005 before extension shipping | Main-app import |
| D06 | Local model/embedding language/device matrix pending | Lead | MOS-002 then MOS-018/021 | OCR/manual/exact search |
| D07 | Signing team/bundle identifiers unspecified | Owner/lead | Before installing signed targets | Non-signing code/spec work |
| D08 | Beta audience and distribution channel unspecified | Product owner | Before MOS-027 | Owner dogfood and local tests |
| D09 | Audit retention 90 days proposed | Product owner/security | Before MOS-024 | Event allowlist design |
| D10 | Resource/performance bounds provisional | Lead | Device spikes before corresponding release | Bounded conservative test fixtures |

## Fixed planning direction

Owner local vault, no automatic cloud processing, owned encrypted sources, native Apple clients, evidence-linked data, no silent correction overwrite, live sync after v0.4, narrow approved reuse. Owner may revise these explicitly; record scope/testing consequences.

## Risk register

| Risk | Likelihood/impact estimate | Response | Trigger |
|---|---|---|---|
| Local model unsupported/poor extraction | Medium/high | Manual fallback, corpus evaluation; no cloud fallback | MOS-002/018 failure |
| Encryption packaging/FTS incompatibility | Medium/high | Early actual adapter spike; evaluate alternative one-source-of-truth adapter | MOS-003 |
| Recovery keys lost | Medium/critical | Independent credential UX and restore drill | MOS-004 |
| Extension gains overbroad key access | Medium/high | Staging-only key or unlock-required fallback | MOS-005 |
| SSD disconnect | High/high in daily external use | Storage lease checks, durable jobs, no internal fallback | T07 |
| AI produces plausible false claim/date | High/high | Evidence, uncertainty, no auto reminders, evaluation | T12/T17 |
| Scope delays personal usefulness | High/medium | Vertical Mac slice and deferred sync/org work | Release re-estimate |
| Owned images consume SSD | Medium/medium | Storage accounting, safe cleanup, bounded imports | Low-space tests |
| Apparent compliance without evidence | Medium/high | Control status/evidence separate from design | Release review |

Estimates are judgment, not measured probabilities. Review at each release. Unresolved high-impact risks cannot be accepted silently by a coding agent.
