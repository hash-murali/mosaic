# Product requirements

Owner Murali. Planning revision 1.0. Scope private local Apple application through v0.4.0. All requirements below are planned, not implemented.

## Problem and target user

The user screenshots entertainment, reading recommendations, college/immigration information, technology and interesting ideas, then forgets to revisit them. Mosaic must preserve the existing capture habit while making saved information actionable and retrievable. The beta serves an individual owner on iPhone, iPad and Mac; organization administration is a future deployment concern.

## Product boundary

Core use is offline. The app owns encrypted copies of imported sources, keeps evidence and interpretations separate, gives the user correction control, and produces approved portable subsets. A captured claim is not verified real-world advice. No automatic deletion of Photos originals, automated applications/payments, unsupervised legal advice, autonomous research, multi-user collaboration or live sync is included through v0.4.0.

| Requirement | Outcome and acceptance | First release |
|---|---|---|
| R01 Capture | Selected image import requires no title/category entry; accepted input gets a durable job ID | v0.1.0 |
| R02 Source retention | Encrypted owned original and hash survive deletion of Photos source | v0.1.0 |
| R03 OCR | Local OCR yields source-linked text and a recoverable failure for unreadable input | v0.1.0 |
| R04 Review | User can edit title/category; reprocessing never silently overwrites correction | v0.1.0 |
| R05 Search | Exact search and category/status filters return records with sources | v0.1.0 |
| R06 Vault protection | Lock blocks reading/search/processing; encrypted artifacts and keys are separately protected | v0.1.0 |
| R07 Recovery | Encrypted backup restores records and source hashes using independent recovery credential | v0.1.0 |
| R08 Native intake | All Apple clients support explicit import; mobile Share intake stages safely | v0.2.0 |
| R09 Discovery | Optional screenshot scan with date scope, dedupe and visible progress | v0.2.0 |
| R10 Organization | Collections and watch/read/action states belong to user, not source assertions | v0.2.0 |
| R11 Reminders | Only confirmed absolute date/time/timezone and consent can schedule; denial keeps in-app item | v0.2.0 |
| R12 Extraction | A capture can yield multiple entities/claims; typed results link to OCR evidence | v0.3.0 |
| R13 Connections | Repeated mentions, explicit relations and potential conflicts show supporting records | v0.3.0 |
| R14 Rediscovery | On-demand review surfaces unresolved saved interests and confirmed due items with reasons | v0.3.0 |
| R15 Ask | Local retrieval/synthesis cites material assertions or reports insufficient evidence | v0.3.0 |
| R16 Selective reuse | Preview and authorize specific records/fields for a destination; no automatic export of whole vault | v0.4.0 |
| R17 Privacy visibility | Privacy settings, audit viewer and optional redacted diagnostics explain data flows | v0.4.0 |
| R18 Accessible stable UX | Supported layouts and core journeys work with assistive and keyboard interaction | v0.2.0 then v0.4.0 |
| R19 Robust storage | Restart, low space, absent SSD and index rebuild do not corrupt committed records | v0.1.0 then v0.4.0 |
| R20 Portable transfer | Restore encrypted snapshot as separate local vault on second device; no concurrent merge | v0.4.0 |

## Nonfunctional requirements

NF01 no private content egress by default; NF02 deny by default across all content interfaces; NF03 transactionally preserve committed data; NF04 every derived claim/insight is traceable; NF05 user corrections take precedence; NF06 bounded import/model workload; NF07 readable and accessible states; NF08 migration and recovery tested; NF09 diagnostics contain no content/keys; NF10 reproducible documented evidence per release.

Proposed v0.4 budgets: cached first screen p95 <2 seconds; exact search p95 <300 ms at 10,000 synthetic records; typical OCR p95 <5 seconds on declared baseline hardware. Image corpus size, cold/warm conditions and measurement tool must be published with results. AI time is device/model-specific. These are targets pending measurement.

## Decisions the product owner supplies

Confirm what matters when trade-offs arise: live sync is deferred; local processing is default; optional cloud use needs separate future approval; sources are copied at a storage cost; an unrecoverable lost key means unrecoverable data. Choose supported devices from the actual inventory and review beta limitations. Architect/lead developer owns mechanism selection and testing.

## Change control

Scope change records affected R/NF IDs, release, data/privacy consequences, dependencies and revised gates. New feature requests default to later backlog until the current release outcome is secure. A change is not approved merely because it appeared in an AI suggestion.
