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
   tagging/publishing. Publish a separate GitHub Release for each stable version
   using its immutable annotated tag. Link its audit and milestone, list actual
   tests and known limitations, and close the milestone once every issue has an
   explicit disposition. Keep older releases available; do not overwrite them.

This applies to patch and minor releases. It is a required process going forward,
not automated enforcement or a claim that GitHub cleanup was done for v0.1.0.

## Chat, decision, and branch traceability

Project chat titles use `<target version> — <topic>`, for example
`v0.2.0 — Review reliability` or `v0.3.0 — Storage design`. Maintenance chats
use the affected release. Rename a chat when its intended version changes; use
`version TBD — <topic>` when a version is genuinely undecided. The active chat
is `v0.2.0 — Release planning and governance`. Other chats have not been renamed.

Every design decision records its proposer and approver, approval date, evidence,
target version, rationale, and status in DECISIONS.md. A GitHub handle is adequate
attribution; no legal name is required. Agent recommendations remain proposals
unless approved by the human or explicitly covered by delegated authority.
Routine implementation choices may use that existing authority with its source
recorded; this does not require asking again for every reversible edit. Legacy
approval without evidence stays unknown. Significant decisions also link to an
issue and PR, whose discussion records the approval at work level.

Use focused branches for independent issue work, preferably
`codex/v0.2.0-1-review-drafts`. Small related changes can share a branch; do not
create branches simply to increase their count. Main is the integration branch;
each stable release is pinned by its tag and GitHub Release. Create a release
branch for stabilization when next-version development overlaps, or a maintenance
branch when supporting an older release. Existing `codex/review-reliability`
remains the current branch; historical names and release tags are preserved.
Branches and policy are traceability tools, not enforced branch protection.

## Publication and access

Repository: [hash-murali/mosaic](https://github.com/hash-murali/mosaic) (public).
Origin is configured; main and the annotated v0.1.0 tag were published and
verified against release commit dbf1937. The planning branch is published
separately. Current application code remains v0.1.0. Its separate
[GitHub Release](https://github.com/hash-murali/mosaic/releases/tag/v0.1.0)
was published with scoped notes, actual verification, and audit links.

The connector returned 403 for issue creation; the user signed in to the in-app
browser and migration was completed there. No credentials were inspected or
collected, and no dependencies installed. Connector write access remains
unverified; authenticated browser access is the working route. Only source,
synthetic fixtures, and project documentation may be published.
