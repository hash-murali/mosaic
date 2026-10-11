# Mosaic product direction and POC handoff

Design baseline: October 4, 2026. Target: v0.1.1 visual refinement through the
v0.4.0 private-beta product. This is a design guide, not implementation evidence
or a duplicate task tracker. GitHub Issues owns delivery status and priorities.

Reference: [hosted Mosaic concept](https://mosaic-product-concept.muralikrishnasunkara.chatgpt.site).
Decision: [D-011](../DECISIONS.md). Related guides:
[visual system](VISUAL-SYSTEM.md), [Today station](TODAY-STATION.md).

## What the human approved

The owner liked the POC's colors, aesthetics, minimalist philosophy and Library
on October 4, 2026. Treat that as approval of the visual direction and Library
concept, not every pixel, navigation label, feature, or permission flow.
The owner requested reminders/calendar integration to make gathered information
useful in daily life. The exact Today station and integration policy below are
Codex proposals awaiting review; no integration was implemented or authorized
to access personal calendars by this design discussion.

## Product intent

Help someone move from “I wanted to remember this” to “I found it when I needed
it” and, when appropriate, “I did something with it.” The Library stores useful
possibilities. Inbox resolves new captures and uncertainty. Today supports
explicit commitments. Rediscover resurfaces interests without turning every
saved idea into a task. Search connects all of these to source evidence.

Preserve the POC's calm editorial character: warm light surfaces, sage accents,
restrained metadata, generous spacing, visual captures and plain actions.
Minimalism means clear priorities and progressive detail; it does not mean
hiding review state, uncertainty, permission failures or recovery controls.

## Handoff I would request from the POC developer

| Deliverable | Required contents | Where this handoff stands |
|---|---|---|
| Product brief | Primary jobs, principles, approved feedback, exclusions | This document |
| Visual system | Color roles, typography, spacing, component anatomy, interaction states | VISUAL-SYSTEM.md; native validation pending |
| Screen and navigation specification | Library, Inbox, Today, Rediscover, Search, Settings; desktop and phone layouts | Baseline below; Today proposed |
| Journey and state specification | Happy paths, review, uncertainty, empty/loading/error/locked states | This guide and TODAY-STATION.md |
| Source/asset package | Exact versioned HTML/CSS/JS, licensed assets, synthetic fixtures | Private Sites saved version; repository source archive not yet preserved |
| Platform translation map | SwiftUI components, domain dependencies, implementation boundaries | Compatibility table below |
| Accessibility evidence | Contrast, focus, screen reader, larger type, reduced motion | Requirements here; actual browser/native evidence pending |
| Validation report | What runs, what is mocked, what was tested and unresolved findings | POC evidence below |

Before a native implementation handoff, preserve the exact hosted source version
and capture synthetic desktop/tablet/phone screenshots with annotations. A URL
alone is not an immutable specification. Screenshot capture remains pending
because browser security policy prevented POC visual verification.

Hosted baseline identifiers (copy exactly when retrieving the source):

- Site: `appgprj_6ac2818607c48191b189d2f5d453c3f3`.
- Saved version: `appgprj_6ac2818607c48191b189d2f5d453c3f3~appgver_324b54b41830819187d18861cb52c285`.
- Source commit: `649808692fb51be61ea6f0c57bb65241132cc05b`.

## Navigation and screen contracts

| Destination | Job | Content and primary action |
|---|---|---|
| Library | Browse what is already accepted | Visual records, collection/category filters, local search; open source detail |
| Inbox | Resolve newly received material | Processing state, observations, corrections and suggestions; approve or discard |
| Today (proposed) | Act on accepted intentions | Due, upcoming and unscheduled confirmed actions; complete, later, open evidence |
| Rediscover | Revisit non-urgent interests | Explain why each item appears; keep, later, dismiss |
| Search | Find and inspect evidence | Exact search first; optional semantic search/Ask when supported |
| Settings | Control the local product | Vault, permissions, storage, backup/recovery and explicit exports |

Favorites is a Library filter in the proposed mature navigation. Collections
are subordinate to Library. Avoid adding every secondary feature as a phone
tab. Phone proposal: Library, Inbox, Today, Rediscover; Search reachable from
Library and Settings from the workspace control. This revises the pack's earlier
five-destination sketch and needs usability review before adoption.

Mac/iPad: adaptive sidebar, library grid or accessible list, selected-record
detail pane. Phone: compact navigation, two-column grid when readable, single
column at larger type, full-screen detail. A web modal is inspiration for the
detail hierarchy, not a requirement to reproduce a modal on Mac.

Native record detail retains distinct sections for original observation,
inferences, user correction and accepted knowledge. Show the actual screenshot
as evidence. The POC CSS illustrations are fictional inspiration cards, not the
future evidence representation. Never substitute a generated image for a source.

## Main journeys and required states

1. Import an explicitly selected image → processing → Inbox → inspect source
   and correct → approve → Library/exact search. No compulsory classification.
2. Library → query or collection → record → source detail → favorite or assign
   intent. Favorites/statuses require a model and storage before durable use.
3. Record → create action → confirm date/time/timezone → Today → complete/later.
   Optional Calendar/Reminders handoff is specified separately.
4. Rediscover → inspect reason and source → keep/later/dismiss. A resurfaced
   interest is not silently converted into a commitment.

Each screen needs empty, loading, offline, unavailable-model, failure and locked
states. Include no OCR text, failed import, denied/revoked permission, low
storage, unavailable SSD, insufficient evidence and backup/restore outcomes.
Do not fabricate a successful save, notification, export or calendar insertion.
Locked states conceal thumbnails, titles, snippets and inferred interests.

## Compatibility and delivery sequence

The native Swift app remains the product. The hosted POC is a design reference;
its DOM/CSS/JavaScript is not a replacement for protected native services.

| POC surface | Current code as inspected October 4 | Translation / planned milestone |
|---|---|---|
| Sage palette, editorial heading, spacing | Existing SwiftUI split workspace | Adopt tokens and component styling incrementally in v0.1.1 |
| Visual Library grid | In-memory approved-record list; images held by demo UI | SwiftUI lazy grid/list and per-record thumbnail DTO; protected source access required for durable version |
| Inbox and detail | Pending records, original OCR, correction drafts, approval/discard | Strong conceptual fit; retain current correction and duplicate behavior |
| Search | Approved-only case/diacritic-insensitive substring search | Keep exact search honest in v0.1.1; semantic retrieval/Ask remains v0.3 plan |
| Categories and collections | No durable classification/collection model | Add typed user/candidate fields and repository support; v0.2 collections plan |
| Favorites | No field/service | Add explicit user state; durable schema and scoped service needed |
| Today and notifications | No action/scheduler integration | v0.2 confirmed-reminder baseline; exact station/Calendar scope proposed |
| Rediscover | POC selects older fixture IDs, with no ranking | v0.3 reasoned local review; deterministic fallback remains useful |
| Local-first footer | Demo is in memory; isolated policy primitive not wired to demo | Encrypted storage, recovery and integration remain v0.1.1 gates; branding is not evidence |
| Responsive web view | Mac demo only; package platform declarations | Native mobile targets/device accessibility and permission testing remain planned |

Important behavior mismatch: the POC searches pending and accepted fictional
cards; current native search intentionally excludes pending records. Preserve
that native boundary. If search within Inbox is offered later, label it as an
Inbox search rather than mixing unaccepted content into approved results.

Sequence: establish native design tokens/components using synthetic fixtures;
apply Library/Inbox/detail without regressing review semantics; complete protected
foundation; extend collections and confirmed actions in the daily-use slice;
add supported local intelligence and rediscovery; validate full private-beta
journeys. These are outcome dependencies, not delivery-date commitments.
Per D-008, the pack's protected-foundation baseline originally called v0.1.0
is assigned to v0.1.1 here. Existing GitHub milestone mapping still needs reconciliation.
Calendar integration does not imply Mosaic live sync; live vault sync is deferred
past v0.4.0 in the existing baseline.

## Evidence and acceptance

POC: private Sites deployment succeeded October 4. JavaScript syntax check and
mock-DOM assertions passed for initial library, multiword search, Inbox,
Favorites, category filtering, empty results, sample addition and detail.
These are smoke checks, not browser interaction or accessibility certification.
The initial search assertion expected four matches; the fixture actually had
three. Corrected the expectation and reran successfully; no product bug inferred.
Browser visual verification was blocked by an unavailable admin-policy check.
No personal screenshot, calendar, reminder or vault was accessed.

Native design acceptance must include real synthetic screenshots, larger type,
screen reader and keyboard journeys, focus restoration, reduced motion,
contrast, small screens and failure states. Preserve draft isolation, approved
search gating and exact duplicate reopening. No future capability may appear
active without a working service or explicit preview labeling.

Open design questions: Today naming and prominence; calendar integration scope;
one-way export versus completion reconciliation; dark palette; thumbnail crops;
final accessibility-adjusted token values. The owner has approved the aesthetic
direction, not these details. No release, GitHub issue edits or native changes
are part of this documentation handoff.
