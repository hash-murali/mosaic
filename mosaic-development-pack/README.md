# Mosaic development documentation pack

Baseline 2026-10-02. Document revision 1.0. Proposed engineering specification for v0.1.0 through v0.4.0. No application, encryption implementation, Apple build, or production control has been verified by this pack.

Mosaic turns screenshots into private, source-linked knowledge that can be reviewed, searched, connected and selectively reused. This pack converts the product roadmap into engineering inputs. Read this file first; the product owner does not need to author every technical document.

## Who supplies what

| Responsibility | Accountable role | Prepared input |
|---|---|---|
| User problem, priorities, scope, acceptance of trade-offs | Product owner | Product requirements, journeys, roadmap |
| Architecture, contracts, data and security decisions | Architect or lead developer | Architecture, ADRs, model, pipeline, security |
| Implementation order, quality gates, release evidence | Lead developer | Backlog, test strategy, developer guide, release checklist |
| Interaction and accessibility | Product designer with product owner | UX specification and screen states |
| Independent assessment of implementation | Reviewer or QA | Test cases, control matrix and evidence templates |

One person may fill several roles now. Separate the decisions even when the person is the same. No staff, reviewer, certification, or approval is implied by listing a role.

## Read in this order

1. [Product requirements](docs/01-product-requirements.md) and [user journeys](docs/02-user-journeys.md).
2. [Release roadmap](docs/03-release-roadmap.md) and [architecture](docs/04-architecture.md).
3. [Domain model](docs/05-domain-model.md), [service contracts](docs/06-service-contracts.md), [security](docs/07-security-and-access.md).
4. [Developer guide](docs/14-developer-guide.md), [backlog](docs/15-backlog.md), and [decisions and risks](docs/16-decisions-and-risks.md).
5. Relevant pipeline, AI, design, portability and test specs before implementing a feature.

## Document map

| File or directory | Purpose |
|---|---|
| docs/baseline-product-plan.md | Frozen copy of the preceding product plan for context |
| docs/01 through docs/03 | Requirements, scenarios and release boundaries |
| docs/04 through docs/06 | Architecture, data and service boundaries |
| docs/07 and docs/08 | Threats, authorization, privacy, retention and controls |
| docs/09 through docs/11 | Capture pipeline, AI/retrieval and interface behavior |
| docs/12 | Backup, restore and selective export specifications |
| docs/13 | Validation strategy and acceptance test catalogue |
| docs/14 through docs/16 | Development workflow, ordered tasks, unresolved risks |
| docs/17 and docs/18 | Release criteria, incident and support procedures |
| docs/19 | Traceability between requirements and verification |
| docs/20 | Definitions and official technical references |
| docs/adr | Versioned architecture decisions and spike exit criteria |
| contracts | JSON Schema contracts and synthetic payload examples |
| database | Logical SQL schema sketch and consistency test |
| templates | Reusable issue, ADR, change review and release evidence forms |
| AGENTS.md | Instructions for coding agents working in the repository |
| .gitignore | Defense against accidental data/build commits |
| scripts/validate_pack.py | Offline contract, SQL and link checks |

## Status and precedence

Latest explicit owner decision takes priority, then updated PRD and accepted ADRs, then the roadmap and service contracts. The copied baseline is historical context; it does not silently override a later recorded decision. Update traceability and dependent documents in the same change when a contract or release scope changes.

Accepted direction means a chosen plan. Proposed means validation is outstanding. Evidence pending means the implementation has not demonstrated the gate. All backlog items currently have status planned. No release is approved or complete.

## Start safely

Do not extract this ZIP over an existing repository. Extract beside it, compare root files, and merge documentation deliberately. In particular, preserve existing AGENTS.md and .gitignore rules. The original Mac repository has not been inspected here.

Start MOS-001 repository inventory and MOS-002 technical capability matrix. Synthetic feature work may begin immediately. MOS-003 through MOS-005 block real-data use until encryption and recovery are demonstrated. Do not initialize or replace an existing Xcode project from this pack.

## Validate the pack

Requires Python 3 with standard SQLite FTS5 support. No additional packages are needed for the restricted offline fixture checks:

```bash
python3 scripts/validate_pack.py
```

The validator exercises the schema vocabulary used in these fixtures, semantic evidence checks, SQL foreign keys/FTS/deletion behavior and local Markdown links. It is not a general JSON Schema implementation; also use a standard draft 2020-12 validator when dependencies are established. SQL runs only in an in-memory standard SQLite database. This proves logical consistency, not SQLCipher security, Apple platform behavior, cryptographic correctness, or the release gates.

## First development checkpoint

Produce an inventory report, pin SDK/package candidates, run the five risk spikes in the backlog, then implement the Mac import-to-search vertical slice. Never mark a risk resolved solely because a document describes its solution.
