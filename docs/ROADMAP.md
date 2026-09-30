# Release workflow and GitHub migration

Reviewed September 30, 2026. Baseline: v0.1.0 “Session Review”, tag
`v0.1.0`, release commit `dbf1937`. Current branch contains planning only.
GitHub Issues is the chosen task-tracking system. The backlog below is temporary
migration material, not a parallel local ticketing system. No GitHub issues have
been created yet. The existing v0.2.0 target in NEXT.md remains unchanged.

## Proposed release cycle

Use a milestone for each intended minor release, with preparation, implementation,
and stabilization work inside it. Resolve architecture, data boundaries, and
acceptance criteria before implementing features that depend on them. Address
usability throughout the cycle. Scope security controls to actual capabilities:
decide storage protections before persistence, and identity/role enforcement
before shared access. User/admin/team roles are future design work; they are not
implemented controls in this single-user, memory-only demo.

Keep patch releases for verified fixes and compatible refinements to a released
baseline. For example, v0.3.1–v0.3.5 can improve v0.3.0 while preparation and
feature development for v0.4.0 take place on a working branch. Do not require
five patches when fewer suffice. Use v0.4.0-alpha.1 or v0.4.0-beta.1 for functional
previews of the upcoming release; publish v0.4.0 after its acceptance checks.
The proposed five-patch limit is a POC planning cap, not a reason to release
unfinished work or defer necessary fixes.

## Immediate tickets: review reliability (existing v0.2.0 target)

| Local ID | Priority | Issue | Acceptance / dependency |
| --- | --- | --- | --- |
| MR-01 | P2 | Preserve per-record unapproved correction drafts | Two pending records retain distinct edits across navigation/import; drafts stay out of search; approval commits and discard removes a draft. Synthetic regression tests plus user GUI check. |
| MR-02 | P3 | Show status for the selected record | Switching pending/reviewed records never shows stale status from another record. Depends on review-state handling in MR-01. |
| MR-03 | P2 | Bound image decoding and session memory | Measure with synthetic images, choose documented limits, handle rejection without losing prior records, and verify UI responsiveness and failure paths. |
| MR-04 | P2 | Validate image orientation | Generated rotated/EXIF fixtures verify decode-to-OCR behavior; document supported orientations and remaining limits. |
| MR-05 | P3 | Decide multi-window behavior | Choose isolated sessions, shared session, or one-window restriction; document and manually verify the chosen behavior. Scope decision needed before treating this as a defect. |

MR-01 through MR-04 are the existing NEXT.md scope. MR-05 is an additional audit
follow-up and is not yet committed to that release. Existing seven synthetic
tests must keep passing; add meaningful tests for changed behavior. Release
verification also needs user GUI checks because core tests do not verify the UI.

## Subsequent planning tickets (no release assigned)

| Local ID | Issue | Required outcome |
| --- | --- | --- |
| MP-01 | Decide persistent storage architecture and threat model | Define vault boundaries, retention/deletion, source/correction provenance, migrations, recovery, encryption/key handling, and authorized data scope before building saved libraries. |
| MP-02 | Define content-free audit events | Decide which actions need auditing, allowed metadata, retention and access. Personal content must never enter development logs or tickets. No audit logger is implemented yet. |
| MP-03 | Decide identity and access scope | Describe which future sharing/team capabilities require identities and user/admin/management permissions, with a resource/action permission matrix. Implementation depends on an approved sharing scope. |
| MP-04 | Plan iPhone/iPad delivery | Define app targets, import flow, platform checks, and accessibility requirements. Package deployment floors are not verified device compatibility. |
| MP-05 | Define repeatable release checks | Record synthetic tests, applicable GUI/platform checks, known limits, version updates, release notes, and tag verification for each release. |

## Required finalization for every version

1. Run relevant synthetic tests and applicable user GUI/platform checks. Record
   actual results and untested limits.
2. Audit the release changes and applicable architecture, data boundaries,
   security controls, usability, and documentation. Record scope and findings in
   AUDIT.md; a source audit is not production security certification.
3. Reorganize GitHub issues: close verified completed work with PR/test evidence,
   create tickets for audit findings, merge or close duplicates with references,
   revise priorities/dependencies, and move unfinished work to the next milestone
   or backlog with a reason. Blocking findings prevent release finalization.
4. Reconcile version, release notes, audit evidence, and milestone scope before
   tagging/publishing. Link the release to its audit and milestone; close the
   milestone once every issue has an explicit disposition.

This applies to patch and minor releases. It is a required process going forward,
not automated enforcement or a claim that GitHub cleanup was done for v0.1.0.

## GitHub setup and migration

Repository: [hash-murali/mosaic](https://github.com/hash-murali/mosaic) (public).
The Git remote is configured and main plus the existing annotated v0.1.0 tag
were published and verified against release commit dbf1937 on September 30, 2026.
The planning branch is published separately; main remains the exact baseline.

GitHub connector authentication is available, but issue creation returned 403
“Resource not accessible by integration.” No issues were created. The in-app
browser is signed out. Migration requires connector Issues write access or a
user-authenticated browser session; no credentials were inspected or collected.
The temporary backlog remains until transfer can be verified.

Use release milestones and labels for type/priority/area, and link changes to
issues. Keep PLAN.md for decisions and actual verification; GitHub Issues owns
individual task status and acceptance criteria. Only source, synthetic fixtures,
and project documentation may be published.

After migration is verified, remove the temporary ticket tables and local IDs
from this file and replace NEXT.md task details with the GitHub milestone link
and a brief release objective. Do not discard acceptance criteria before they
are transferred. Maintain PLAN.md for decisions, milestones, dependencies,
completed-work summaries, actual tests, risks, and limitations as AGENTS.md
requires; GitHub owns individual task status. No local ticket database or
tracking application will be built.
