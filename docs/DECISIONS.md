# Design decision records

Keep design rationale and approval evidence here; GitHub Issues owns task status.
Use one dated record per decision. Link a separate design document when needed.
Do not replace old decisions silently: mark them superseded and link the successor.

Required fields: ID/title, target version, status, decision and rationale,
proposer, approver attribution, approval date/evidence, related issue/PR, and
implemented versus planned scope. Approval date is the date of the evidence,
not a guessed implementation date. Record pending approval explicitly.

## D-001 — GitHub owns task tracking

- Target: v0.2.0 planning onward.
- Status: approved; migration implemented.
- Decision/rationale: use GitHub Issues and milestones for growing-project
  traceability; remove duplicated local task lists. PLAN.md retains required
  decision, test, and risk records.
- Proposer and approver: human project owner in this chat. Repository account:
  hash-murali; attribution is a handle, not a claim about legal identity.
- Approval date/evidence: September 30, 2026; user requested GitHub ticketing
  and removal of local ticketing resources, then supplied the repository URL.
- Related work: https://github.com/hash-murali/mosaic/issues and milestone/1.
- Implemented: ten issues, one milestone, local list removal. Connector issue
  writes failed; authenticated browser operations succeeded.

## D-002 — Audit and reorganize tickets at every release

- Target: every stable version after v0.1.0, starting with v0.2.0.
- Status: approved process; future execution required per release.
- Decision/rationale: finalization includes actual verification, scoped audit,
  findings tickets, completion evidence, and disposition of unfinished work.
- Proposer and approver: human project owner in this chat (hash-murali).
- Approval date/evidence: September 30, 2026; user stated every version should
  end with audit and ticket reorganization.
- Related issue: https://github.com/hash-murali/mosaic/issues/10.
- Implemented: workflow documented and issue in milestone. Automated gates and
  production security certification are not implemented.

## D-003 — Stable release, chat, and design approval traceability

- Target: v0.2.0 planning onward; separate release publication also applies to
  the existing v0.1.0 baseline.
- Status: user requirements approved; concrete workflow conventions adopted
  under the user's request to implement these planning ideas.
- Decision/rationale: separate GitHub Release per stable tag; version/topic chat
  titles; named approvers with evidence for every design decision; focused
  branches and issue/PR links for scalable traceability. Tags preserve history
  without requiring a permanent branch for every version.
- Proposer: human project owner for requirements; Codex for naming conventions
  and decision-record format.
- Approver: human project owner in this chat (hash-murali) for requirements;
  Codex for routine documentation conventions under the authorized planning
  scope. Do not imply the human individually reviewed those conventions.
- Approval date/evidence: September 30, 2026; user requested separate stable
  publications, versioned chat titles, approver attribution, and branches as
  needed for traceability and scaling.
- Related work: release workflow in ROADMAP.md; issue #10 for finalization.
- Implemented: active chat renamed; instructions and documentation updated.
  Release publication results are recorded in PLAN.md. Other chats were not
  renamed; branch protection and automated approval enforcement are absent.

## Legacy decisions

Earlier architecture and data-boundary decisions remain recorded in PLAN.md
and AGENTS.md. Their individual approvers/evidence were not consistently recorded;
do not retroactively claim named approval. Preserve those records and create a
dated decision record when a legacy choice is revisited or reaffirmed. Existing
data restrictions remain in force regardless of this documentation gap.
