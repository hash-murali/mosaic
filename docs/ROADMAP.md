# Release workflow

Reviewed September 30, 2026. Baseline: v0.1.0 “Session Review”, tag
`v0.1.0`, release commit `dbf1937`. Current branch contains planning only.
GitHub Issues is the task-tracking source of truth. No local ticketing system
is maintained. The v0.2.0 target remains unchanged.

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

## GitHub tracking

[GitHub Issues](https://github.com/hash-murali/mosaic/issues) owns task status,
priorities, dependencies, and acceptance criteria. The local migration tables
and IDs have been removed after all ten issues were created and verified.

Next release: [v0.2.0 — Review Reliability](https://github.com/hash-murali/mosaic/milestone/1).
The milestone contains four reliability issues and the release-finalization
issue. Longer-term design work remains in the GitHub backlog. PLAN.md retains
decisions, milestone summaries, dependencies, completed-work summaries, actual
test results, risks, and limitations required by AGENTS.md; it does not duplicate
individual issue status.

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

## Publication and access

Repository: [hash-murali/mosaic](https://github.com/hash-murali/mosaic) (public).
Origin is configured; main and the annotated v0.1.0 tag were published and
verified against release commit dbf1937. The planning branch is published
separately. Current application code remains v0.1.0.

The connector returned 403 for issue creation; the user signed in to the in-app
browser and migration was completed there. No credentials were inspected or
collected, and no dependencies installed. Connector write access remains
unverified; authenticated browser access is the working route. Only source,
synthetic fixtures, and project documentation may be published.
