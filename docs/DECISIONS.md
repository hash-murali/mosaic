# Design decision records

## D-028 — Optional lock preferences

- Target: v0.1.2 planning and subsequent protection design. Status:
  human-approved optional-lock direction; mechanisms and defaults undecided.
- Decision/rationale: make regular app lock and protected/vault lock optional
  user preferences in Settings, recognizing device-level protection. When an
  enabled mode is manually locked, use D-027's dedicated lock screen rather than
  requiring navigation to Settings to unlock. Settings must explain the modes
  in plain language and keep one coherent workspace.
- Proposer/approver: human project owner for optional regular/protected locks;
  Codex recommends retaining encrypted storage independently of the UI gate.
  This recommendation is not a separately approved storage/custody design.
- Approval date/evidence: October 11, 2026 owner says “move the lock mechinsim
  ( regular lock and protected lock(vault lock)) as optional or user prefence
  in settings” because the device itself provides protection.
- Open design: precise distinction between regular and protected modes,
  authentication and key-access behavior, initial default, mode transitions,
  recovery, automatic-lock timing and platform capabilities. Do not infer
  permission for plaintext storage, weaker silent custody fallback or removal
  of existing controls. Optional lock changes require reviewed custody design.
- Scope/related work: supersedes mandatory-lock presentation as a future product
  requirement, not current v0.1.1 implementation. No code, permissions, runtime
  vault or personal content changed; no issue/PR created in this chat.


## D-027 — App lock, immediate library intake and contextual Settings

- Target: v0.1.2 planning; source-retention work may require a later release.
  Status: human-directed experience changes; detailed architecture, retention
  policy and final version allocation remain proposed, not implemented.
- Decision/rationale: present existing vault protection as one app-wide lock.
  Manual Lock in Settings transitions to a dedicated lock screen, where unlock
  returns to the same workspace. Library/search/detail must expose no content
  while locked. Scanned items enter Library immediately with a small accessible
  needs-verification indicator; verification is no longer the visibility gate.
  Preserve separation between source observations, suggestions and user-confirmed
  content internally. Reduce incidental metadata on primary screens and group
  Settings with nested screens for appearance, import, privacy/protection,
  storage/cleanup and backup/recovery.
- Proposer/approver attribution: human project owner for the requested flows and
  cleaner Settings; Codex for proposed grouping and implementation boundaries.
- Approval date/evidence: October 11, 2026 owner requests one lock for everything,
  a lock screen after manual lock, immediate scanned-content library visibility,
  a verification icon, less small text and categorized/nested Settings.
- Retention proposal: owner suggests discarding verified source images or
  scheduling deletion, with 30 days as an example, while retaining extracted
  content that can be cleared on request. Default timing, countdown trigger,
  previews, recovery/backup handling and loss-of-source implications remain
  undecided. No automatic deletion or lock-disable policy is approved here.
  Future cleanup should distinguish Mosaic-owned copies from user originals;
  no Photos scanning, personal import/persistence or external-file deletion is
  authorized by this planning direction.
- Dependencies/limits: all-items Library/search projections change D-022's
  accepted-only behavior; require explicit provenance and verification state.
  Retention affects custody, processing/retry and backup contracts, not just UI.
  Existing v0.1.1 controls remain until a reviewed implementation replaces them.
- Related issue/PR: none created; GitHub remains the task authority.


## D-026 — Visual library is the next-version layout reference

- Target: v0.1.2 experience planning and subsequent refinement. Status:
  human-approved reference direction; no implementation or final spec approval.
- Decision/rationale: use the Visual library concept as the reference for a
  content-first compact grid, contextual detail and coherent workspace. Preserve
  the iOS-first platform order from D-025. The preview palette is not finalized;
  change colors later or evaluate user-selectable appearance preferences.
- Proposer: Codex for the Visual library concept. Approver: human project owner
  for selecting it as the reference; user-selectable colors remain an option,
  not a committed feature requirement.
- Approval date/evidence: October 11, 2026, owner says “change color later or let
  user pick one but i like visual library, use this as reference.” The selected
  concept is the Visual library variant in this chat's Mosaic interface preview.
- Limits: approval concerns the reference layout direction, not every preview
  interaction, mixed-file support, a written architecture/spec, release scope,
  implementation, or publication. Existing privacy/offline controls remain.
- Related issue/PR: none created in this planning chat; GitHub remains the task
  authority.


## D-025 — iOS-first, content-first product direction

- Target: v0.1.2 planning and subsequent versions. Status: human-directed
  product priorities; exact layouts and release feature scope remain proposals.
- Decision/rationale: prioritize iOS, then Mac, then other platforms throughout
  the project. Center the experience on browsing and understanding library
  content in one coherent interface. Move detailed provenance/review information
  into contextual screens rather than making it dominate the library. Prefer
  compact icons with accessible names and discoverable labels; provide a
  Settings preference for words/icons. Hover is supplemental on Mac; iOS must
  remain usable without it.
- Proposer/approver: human project owner for platform order and content-first
  direction; Codex for the alternative visual and reading-library mockups.
- Approval date/evidence: October 11, 2026, owner describes the current UI as a
  tool, requests content-first presentation and multi-file intake, and explicitly
  sets “IOS, then MAC, then other platform (keep this for entire project).”
- Scope limits: multi-image import, additional image formats, documents/PDFs and
  possible video intake are requested ambitions, not implemented capabilities or
  an approved v0.1.2 feature list. External services remain undecided and require
  explicit authorization. Mockups use invented content only and do not import
  files. No personal-data boundary or offline runtime policy is broadened.
- Related issue/PR: none created in this planning chat. GitHub remains the task
  authority. Existing v0.1.1 Mac foundation work remains its own release scope.


## D-025 — Advance with explicitly deferred validation

- Target: v0.1.1-rc.1 integration; v0.1.2 design; consolidated validation by v0.4.
- Status: owner-directed deferral recorded; no passing checks invented.
- Decision/rationale: owner asks to defer local-user recovery and storage-full/
  disconnection tests, batch similar missing checks and send a later reminder,
  finish audits/commits and move development. Preserve their unresolved risks;
  checkpoint current foundation as a release candidate instead of claiming stable
  security/device validation. No personal-data authorization or weakened crypto.
- Proposer/approver: owner for deferral, checklist/reminder and publication;
  Codex for rc.1 labeling and batch mechanics under that direction.
- Approval date/evidence: October11,2026 current user instruction explicitly says
  to leave those tests later and complete audits/GitHub commits to move version.
- Traceability: DEFERRED-VALIDATION.md; final audit; GitHub mapping pending actual
  write result. Historical mandatory gates remain documented with this explicit
  owner change of sequencing, not silently replaced by PASS.

## D-024 — Finish import, remembered location and independent restored custody

- Target: v0.1.1. Status: implemented; automated and unsigned native checks pass;
  required native/fault/recovery acceptance remains pending.
- Decision/rationale: finish the existing one-workspace requirements with one-file
  invented PNG/JPEG import, bounded reads/decode with propagated cancellation,
  Settings folder selection while locked, bounded security-scoped bookmark resolved
  without UI or mounting, and no missing-location fallback. Existing stores are
  opened in place; selection performs no migration or replacement. Restore resolves
  the remembered folder even before first unlock and receives a fresh vault UUID
  and new custody; only the encrypted staged copy is rebound, owner retained.
- Proposer/approver attribution: Codex for routine implementation/fixes under the
  owner's instruction to finish current v0.1.1; no separate human approval of the
  bookmark algorithm or fresh-UUID mechanism claimed.
- Approval date/evidence: October 11, 2026 owner invokes Superpowers and asks to
  build/test/close current version before the planned next version; October 8
  one-app/Settings brief remains the binding product direction.
- Verification: evidence import-43 through recovery-61. Final57 tests, unsigned
  native build, two publication probes and four process scenarios pass. Review
  caught restore-path/cancellation/wait-cycle/original-custody defects; corrected.
  Checkpoint54 contains an explicitly invalid premature PASS, corrected at55.
- Related work: existing GitHub #6/#10; dedicated issue creation still403. GitHub
  remains ticket authority; no external closure or released tag claimed.
- Limits: synthetic-only selection; native bookmarks/authentication and physical
  SSD/full-disk/peak-memory acceptance plus clean-user recovery remain required.
  No personal persistence/migration, per-record authentication, or broad redesign.

## D-023 — One workspace, Settings protection, bounded owner review

- Target: v0.1.1. Status: human-directed product change implemented; automated
  verification passes, final native acceptance pending. Supersedes the separate
  memory/vault/recovery screens of D-021/D-022; no personal data migration.
- Decision/rationale: expose one application window and one protected collection.
  Inbox/Library/Search show content with a small vault badge. Settings is the
  first protection surface, with general authenticated unlock/lock and inline
  backup/recovery. Remove legacy second-workspace UI so future features extend
  one composition. Per-record unlock is not added; general unlock was one of the
  alternatives explicitly allowed by the owner.
- Proposer/approver attribution: human project owner for one app, badge, Settings
  and fewer reviews; Codex for single Window scene, reuse of custody/session and
  five-check final review batch under that explicit request. No separate owner
  approval of the exact five cases or signing/security mechanism invented.
- Approval date/evidence: October 8, 2026 owner says “dont do seperate,” asks for
  Settings with protection first, plugins/design reconsideration and a fixed small
  manual set with direct chat delivery and inspection/audit recording.
- Verification: settings-36 expected compile failure; 37/38 actual-model reopen
  failure; 39 isolated fix pass; 40 full 46-test suite; 41 native compile. Model
  injection preserves default platform authentication and adds no weak fallback.
- Manual-review policy: one planned final owner batch, five cases maximum. Routine
  builds are checked automatically, with inspection evidence updated but no owner
  homework. Failed native cases may need focused retest only, with stated reason.
  A review cap never converts missing required native/hardware evidence to PASS.
- Related work: #5/#6/#10; GitHub creation/write access remains FORBIDDEN (403).
- Deferred capabilities remain disabled/TODO: tags/collections/favorites (MOS-016),
  reminders/Today (MOS-017), semantic/Ask (MOS-018/021/022), rediscovery (MOS-020),
  selective export/help/preferences (MOS-023/024). They are not silently completed
  or removed from the roadmap when removing the legacy demo UI.
- Limits: synthetic samples only; chosen vault location/import, physical storage,
  independent recovery, current signing/UI and final audit still unfinished.


## D-022 — Shared protected main workspace for v0.1.1

- Target: v0.1.1. Status: human-approved design, implemented; automated verification
  passes, changed native UI acceptance pending.
- Decision/rationale: main Inbox, Library and Search use one authenticated protected
  collection so approved corrections, search and restored records are consistent.
  Pending content stays in Inbox; accepted content appears in Library/Search.
  One shared model/service locks all protected windows. Keep the prior personal-
  image memory-only demo in an explicitly separate window; do not migrate it.
- Proposer: Codex under owner's request to finish current version before release.
  Approver: human project owner.
- Approval date/evidence: October 8, 2026 async reply “Yes, connect the main screens
  this way.” User also authorizes commit/push/merge when stable; not a waiver of
  acceptance or authorization to persist personal images.
- Verification: workspace-31 expected red compile, workspace-32 41 tests,
  workspace-33 native unsigned build, recovery-34 42 tests. New projection tests
  exercise review/accepted/search/delete separation and hiding when locked.
- Related issues: #1/#5/#6/#10; dedicated foundation issue creation failed with
  GitHub FORBIDDEN (403); no new issue or external status update claimed.
- Limits: generated samples only, 100 capture service bound, repository-local vault,
  owner signed UI and hardware/clean-user-device recovery pending. Broader visual
  redesign remains v0.1.2. No stable release conclusion.


## D-020 — Prioritize foundation; content-first redesign in v0.1.2

- Target: v0.1.1 foundation / v0.1.2 experience refinement. Status: human-approved
  priority/direction; redesign deferred, not implemented or visually approved.
- Decision/rationale: finish protection integration first. Next version presents
  content as the primary surface; icon actions are secondary and modifications
  open a separate task window rather than an overlay or management dashboard.
- Proposer/approver: human project owner for direction/priorities; Codex for
  interpreting v0.1.2 as the deferred design target under the request.
- Approval date/evidence: October 4, 2026 owner requested substantial integration
  now and said design should go to the next version if it blocks important
  unfinished work. Later explicitly requested stop and tomorrow resumption.
- Related work: existing issue #1 review context; GitHub mapping/reconciliation
  pending. Current integration evidence 15–20. No external issue status changed.
- Limits: no core protection acceptance gate moved to a later version or waived.
  Native signing/credential/device testing and final release audit remain required.

## D-021 — Authenticated synthetic application composition

- Target: v0.1.1. Status: implementation adopted under authorized foundation work;
  synthetic verification complete for recorded cases, native acceptance pending.
- Decision/rationale: bind platform key release to device-owner authentication,
  device-only user-presence Keychain, one scoped storage authority, bounded identity
  catalog, durable retry metadata, explicit backup scope and independent recovery
  key. Separate synthetic test window avoids persisting personal session images.
- Proposer/approver: Codex for routine implementation under owner's explicit
  request for substantial integration; no specific human crypto/signing approval
  claimed. Owner reports no Developer account; signing path not yet validated.
- Approval date/evidence: October 4, 2026 integration request and account-status
  reply. Native APIs compiled only; tests inject synthetic key custody.
- Related work: MOS-003/004/006/008/012; GitHub reconciliation pending.
- Limits: 100 foreground captures, bounded PNG/JPEG, schema-v2 migration only;
  production use, true SSD fault matrix, native Keychain and clean-user/device
  recovery acceptance remain incomplete. No fallback key files or cloud escrow.


## D-017 — Concise browsing with explicit approved-record tasks

- Target: v0.1.1. Status: human-approved interaction direction; implementation
  and automated verification complete, native visual/interaction acceptance pending.
- Decision/rationale: remove repeated approval/text/status, place Library search
  above records, use header count and whole-row evidence expansion. Side detail
  on wide windows, below grid on narrow. Approved correction/discard remain
  available through explicit Actions selection within that tab; separate draft
  editing with Save/Cancel avoids visible disabled review controls and autosave.
- Proposer: human owner for annotations and continued approved task availability;
  Codex for responsive recommendation, Actions menu, draft isolation/confirmation.
- Approver: human owner for side/below layout and explicit approved tasks; Codex
  for routine implementation details under ongoing authorized design work.
- Approval date/evidence: October 4, 2026 async choice “Side pane when space
  allows; below on narrow windows”; subsequent request to retain correction,
  discard and other approved-record tasks behind explicit selection in that tab.
  No final appearance approval inferred from these directions.
- Related work: issue #1 review context, MOS-011 corrections; GitHub mapping
  pending. Evidence: owner-review-02, design-13, design-14; inspection J01–J09.
- Limits: session-only editing, no persistence/auth integration or new smart
  categorization. Pending source review and accepted text remain distinct.
  Future controls stay disabled/Planned/TODO; broad retention/AI work unimplemented.


## D-015 — Official encrypted-storage dependency

- Target: v0.1.1. Status: human-approved dependency download; spike implemented.
- Decision/rationale: use official SQLCipher.swift Community Edition 4.19.0,
  exact version pin, instead of inventing encryption. Include license attribution.
- Proposer: Codex. Approver: human project owner for repository-local dependency.
- Approval date/evidence: October 4, 2026 async reply: “Approve repository-local
  SQLCipher dependency” to the explicit official 4.19.0 package request.
- Related work: protected encrypted-storage/recovery requirements; GitHub issue
  mapping pending. Package.resolved revision and evidence in storage-12.
- Limits: approval authorizes download/use in this repository, not production data,
  global installation, cloud services, final architecture or release approval.

## D-016 — Atomic synthetic storage and scoped service composition

- Target: v0.1.1. Status: Codex implementation choice under authorized foundation
  work; synthetic verification complete for listed cases, production review pending.
- Decision/rationale: store originals as encrypted SQLCipher blobs with metadata
  and FTS to avoid a split receipt transaction; confine database and synchronous
  policy state to the same actor for immediate validation/commit ordering. Apply
  explicit record scopes before SQL retrieval and guard duplicate-ID disclosure.
  Snapshot uses SQLCipher backup with an independent key; no custom cipher format.
- Proposer/approver: Codex for routine implementation under the owner's request
  to complete remaining v0.1.1 work. No specific human architectural approval claimed.
- Approval date/evidence: October 4, 2026; owner requested full version completion
  and separately approved the dependency (D-015). No scope reduction authorized.
- Related work: MOS-002/004/006 recovery/storage foundation; GitHub reconciliation
  pending. Evidence: storage-12, ProtectedVault/EncryptedVault synthetic tests.
- Limits: not authenticated UI composition. Blob-volume performance, full fault/
  migration/cancellation evidence and recovery credential/device UX remain pending.
  A process drill does not replace independent-device acceptance. No production
  memory-erasure/physical secure-delete claim.


## D-014 — Inspection follow-up and explicit blank-approval rule

- Target: v0.1.1. Status: implementation adopted; new validation pending.
- Decision/rationale: make navigation/card areas clickable and use expandable
  evidence for concise approved detail while pending evidence starts expanded.
  Block empty/whitespace approval, keep source/draft until explicit discard and
  allow nonblank manual correction. No automatic deletion or source-text fallback.
- Proposer: Codex for blank-approval choice and UI implementation; owner for
  readability/hit-area findings. Approver: human owner for blank-approval policy;
  Codex for routine UI fixes under ongoing authorized design work.
- Approval date/evidence: October 4, 2026 owner inspection feedback and async reply
  “Block approval; keep image until explicit discard”. Supersedes empty-approval
  behavior described in older demo tests/checklists; no retention redesign approved.
- Related work: R04/MOS-011, existing issue #1 context; GitHub reconciliation pending.
- Implemented: UI hit areas/disclosure, session-level blank guard, synthetic test
  changes and current inspection/evidence records. Planned only: similarity hints,
  preferences, source-retention cleanup and LLM evaluation. No near-duplicate merge,
  original deletion, calendar access or persistent setting implemented.

## D-013 — Inspection and sanitized audit evidence after every build

- Target: v0.1.1 onward. Status: human-approved process; documentation implemented.
- Decision/rationale: update current inspection coverage after every build/attempt,
  retain uniquely identified source/build and actual-result evidence, link audits
  and development summaries. Preserve history and distinguish agent verification,
  owner reports and planned controls; avoid stale passing claims after code changes.
- Proposer/approver: human project owner in this chat (hash-murali) for requirement;
  Codex for evidence-record format under authorized implementation.
- Approval date/evidence: October 4, 2026; user requested current inspection update,
  maintenance after every new build and results in development logs/audits for
  traceability. This authorizes sanitized development evidence, not private/runtime
  content logging or telemetry.
- Related work: GitHub issue #10 release evidence; no external update performed.
- Implemented: AGENTS.md/ROADMAP.md workflow, current inspection refresh, dated
  build evidence, AUDIT.md index and PLAN.md summary. Automated enforcement absent;
  future builds and owner test reports must follow the process.

## D-012 — Native Library/Inbox design with disabled planned capabilities

- Target: v0.1.1. Status: implementation adopted; native validation pending.
- Decision/rationale: translate D-011's approved aesthetic into adaptive sage
  surfaces, readable secondary text, native serif headings and actual-source
  cards. Library contains approved records; Inbox contains pending records.
  Preserve review/draft/dedupe semantics. Search remains approved-only exact text.
  Future controls are disabled, labeled Planned and explain unavailability.
- Proposer: Codex for native translation. Approver: human for implementing the
  design direction and explicitly disabling undeveloped features; Codex for
  routine component/layout choices under that authorization.
- Approval date/evidence: October 4, 2026, active chat request to check new design
  documentation, start work and leave undeveloped features disabled with TODO
  or other tags. No approval of final native pixels or Today flow claimed.
- Related work: docs/design guides; MOS-011/016/017/020/022/024. GitHub mapping
  remains pending, no issue/PR publication performed.
- Implemented: session Library/Inbox cards, navigation, design tokens, accepted
  knowledge section, disabled Today/Rediscover/collections/favorites/settings/Ask.
  Code TODO(MOS-...) references identify dependent planning requirements; GitHub
  remains the delivery-status authority. Dark appearance uses native semantic
  colors until a custom dark palette is validated.
- Limits: Mac session-only demo. No reminders/calendar access, vault protection,
  storage, AI or durable organization added. Full UI build and interaction QA
  blocked/unverified; no existing app window or personal content inspected.

## D-011 — Adopt Mosaic POC visual direction; design an action station

- Target: v0.1.1 visual refinement through v0.4.0 private beta; confirmed
  reminders align with the proposed v0.2.0 daily-use outcome.
- Status: human-approved aesthetic/Library direction; handoff documented;
  exact Today navigation and Calendar/Reminders integration remain proposals.
- Decision/rationale: use the POC's sage palette, calm editorial hierarchy,
  visual library and minimalist philosophy as native design inspiration; connect
  gathered information to explicitly confirmed actions rather than collection alone.
- Proposer: Codex for POC and handoff; human owner for reminder/calendar need.
- Approver: human project owner for aesthetic and Library direction only.
- Approval date/evidence: October 4, 2026, this chat: “i liked the colors,
  estatics, and design ( minimalist philosphy)” and “i liked the library”.
  The user also requested a reminder station or calendar/reminder integration;
  that approves exploration, not personal calendar access or exact sync behavior.
- Related work: MOS-016 design and MOS-017 confirmed reminders in the development
  pack; GitHub issue mapping/reconciliation pending. No issue/PR write claimed.
- Delivered: private synthetic hosted POC and docs/design handoff. Planned:
  native token/component adoption, protected Library, durable actions, optional
  explicit integrations, accessibility/device verification. No native code changed.
- Limits: POC behavior is mocked/page-memory only; browser visual QA was blocked.
  Hosted branding does not establish encryption, local AI or vault controls.
  See [product direction](design/PRODUCT-DIRECTION.md),
  [visual system](design/VISUAL-SYSTEM.md), and [Today](design/TODAY-STATION.md).

## D-010 — Isolated owner policy primitive for the protected foundation

- Target: v0.1.1. Status: implementation choice adopted; integration pending.
- Decision/rationale: add Foundation-only MosaicDomain and an owner-only
  MosaicPolicy actor before storage. Bind process-local contexts to an issuing
  policy instance, session, vault, operation, purpose and explicit record/field
  scope; invalidate contexts on session replacement/lock. Use bounded issuance
  (five-minute maximum lifetime, 1024 retained contexts) and deterministic tests.
- Proposer/approver: Codex for routine implementation under the human's approved
  foundation scope and October 2, 2026 request “lets start the work”. No separate
  human approval of API signatures or limits is claimed.
- Approval date/evidence: October 2, 2026 delegated implementation request above.
- Related work: MOS-006, R06/NF02, policy portions of T02/T03; GitHub linkage
  pending remote reconciliation. Contract details: POLICY-CONTRACTS.md.
- Implemented: typed requests and process-local owner context lifecycle.
  Planned: authentication, encrypted repositories, coordinated lock/commit,
  cancellation, UI/cache clearing and delegated/portability grants. Policy unit
  tests cannot establish those controls or full MOS-006 completion.

## D-008 — Protected foundation is the v0.1.1 scope

- Target: v0.1.1. Status: human-approved scope; implementation pending.
- Decision/rationale: assign the pack's protected Mac foundation to v0.1.1,
  retaining existing review fixes and iterative design. Preserve released v0.1.0
  as Session Review. Mobile daily capture and intelligence remain later outcomes.
  Supersedes D-007's proposed v0.2.0 foundation mapping and D-005's narrower scope.
- Proposer/approver: human project owner in this chat (hash-murali).
- Approval date/evidence: October 2, 2026; “Make protected foundation the v0.1.1
  scope”. This scope approval does not approve a dependency installation,
  cryptographic mechanism, publication or broader private-data access.
- Related work: MOS-001–012; existing GitHub milestone/1 and issue #10 need
  reconciliation. No remote updates claimed.
- Implemented: local scope/plan alignment. Planned: encrypted database/source,
  durable jobs, lock/policy, Mac correction/search/delete and independent recovery.
  Relevant pack foundation gates remain mandatory regardless of patch numbering.

## D-009 — Current stable OS first, capability-based compatibility

- Target: v0.1.1 Mac foundation and later Apple clients.
- Status: human-approved policy; device validation pending.
- Decision/rationale: initially develop/test against macOS 27 and iOS/iPadOS 27
  as owner-specified targets. Prefer current stable Apple OS for the development
  baseline; future baseline changes are deliberate, recorded and tested. Retrofit
  older releases after the core slice works. If a core guarantee cannot be met,
  exclude that OS from the supported minimum. If an optional feature cannot run,
  automatically disable it and retain the core workflow with visible capability
  information. No cloud/provider fallback.
- Proposer/approver: human project owner in this chat (hash-murali).
- Approval date/evidence: October 2, 2026; user specified Mac/iOS 27, latest stable
  development, exclusion for unavailable core features and automatic disabling
  for unavailable optional features on older systems.
- Related work: MOS-002/018/021 and R03/R06/R07/R18; GitHub mapping pending.
- Implemented: documented policy only. Existing package minimums remain macOS 14
  and iOS 17, without verified app support claims. Planned: SDK availability guards
  plus runtime checks for hardware, model assets, permissions and language;
  supported minimum-OS tests and unavailable-capability tests. Version checks
  alone cannot establish local model availability.
- Core: protected source/storage, recovery, manual correction and local exact
  retrieval; optional: local semantic extraction, embeddings and Ask. Vision is
  the baseline OCR adapter; any reduced OCR support requires an explicit product
  decision rather than silently reclassifying a required foundation outcome.

## D-007 — Reconcile development-pack releases with the existing baseline

- Target: v0.1.1 planning and subsequent protected-foundation release.
- Status: original proposal superseded by D-008; retained for history.
- Decision/rationale: preserve immutable v0.1.0 Session Review history. Proposed
  mapping keeps v0.1.1 review/design reliability, places the pack's protected Mac
  foundation in v0.2.0 and shifts later outcome milestones forward. Pack versions
  cannot retroactively expand the released demo's verified scope.
- Proposer: Codex. Approver: pending; no human approval claimed.
- Approval date/evidence: none. October 2, 2026 user requested analysis of the
  development pack and starting work to align development with the plan; that
  authorizes inventory and reconciliation, not this specific release mapping.
- Related work: existing GitHub milestone/1 and issue #10; MOS-001/002 planning
  references. No new issue or remote milestone change performed.
- Implemented: repository inventory and preliminary capability evidence under
  authorized analysis. Release mapping, issue migration, dependency selection,
  cryptographic mechanisms and protected-vault implementation remain pending.

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

## D-004 — Session-only review drafts for v0.1.1

- Target: v0.1.1 development.
- Status: implementation choice adopted under authorized development; patch
  initial narrow scope superseded by D-005.
- Decision/rationale: store draft text and correction toggle per pending record
  in SessionLibrary. Bind the editor directly to that draft so navigation and
  imports cannot reset it. Approval commits only the enabled correction;
  approval/discard removes draft state. Drafts do not enter search.
- Proposer: Codex. Approver: Codex for the routine implementation under the
  human's request to start v0.1.1; no human approval of this specific scope claimed.
- Approval date/evidence: September 30, 2026; user said “lets start working on
  v0.1.1”. Codex selected the known baseline draft-loss defect while the scope
  clarification remained unanswered.
- Related issue: https://github.com/hash-murali/mosaic/issues/1 (currently assigned
  to v0.2.0; GitHub scope/milestone reconciliation remains pending).
- Implemented: memory-only draft state, editor bindings, selection status and
  synthetic regression tests. GUI verification and release finalization pending.

## Legacy decisions

Earlier architecture and data-boundary decisions remain recorded in PLAN.md
and AGENTS.md. Their individual approvers/evidence were not consistently recorded;
do not retroactively claim named approval. Preserve those records and create a
dated decision record when a legacy choice is revisited or reaffirmed. Existing
data restrictions remain in force regardless of this documentation gap.

## D-005 — Refine design alongside behavior in v0.1.1

- Target: v0.1.1. Status: human-approved direction; iterative implementation.
- Decision/rationale: refine design together with bugs and pending work at each
  stage to keep the product consistent and avoid deferring design until the end.
  The current design is an early iteration, not a final specification.
- Proposer/approver: human project owner in this chat (hash-murali).
- Approval date/evidence: September 30, 2026; the user explicitly clarified this
  version's aim as design changes together with bug fixes and pending work.
- Related issue: #1 for draft reliability; broader GitHub scope reconciliation
  pending. No new issue or milestone publication claimed.
- Implemented: first resizable list/workspace layout and contextual record
  actions, under delegated implementation authority. Human has not reviewed
  this particular layout yet. Further visual/interaction refinement is planned.

## D-006 — Reopen exact duplicate image imports

- Target: v0.1.1. Status: implementation adopted; GUI verification pending.
- Decision/rationale: identify exact decoded-pixel sources per session rather
  than merging OCR text. A repeated image reopens its existing record and keeps
  corrections/review state; distinct sources with matching text remain distinct.
- Proposer: Codex for pixel identity and reopen interaction; human for reporting
  repeat image approval/results as a bug.
- Approver: Codex for routine implementation under the human's bug-fixing and
  design request; no separate human approval of the exact algorithm claimed.
- Approval date/evidence: September 30, 2026; duplicate-import bug reported in
  this chat alongside authorization for v0.1.1 bug fixes/design refinement.
- Related issue: new bug ticket pending authorized GitHub reconciliation; #1
  supplies linked draft-retention acceptance context.
- Implemented: memory-only SHA-256 of decoded sRGB pixels/dimensions, worker
  hashing before OCR, pending/approved reopening, discard cleanup and tests.
- Limits: no similarity detection; recompressed, cropped or resized inputs can
  differ. No cross-window/persistent matching. Fingerprints are derived data,
  never logged, uploaded or saved. Canonical rendering needs temporary memory.
