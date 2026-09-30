# Next phase: review reliability

Baseline: v0.1.0 “Session Review”, commit dbf1937 on main.
Working branch: codex/review-reliability. Target: v0.2.0 after implementation
and user testing; current app remains v0.1.0 until those changes are built.

1. Retain unapproved correction drafts per record when navigating, loading another
   image, or reopening from the inbox. Drafts stay excluded from search. Approval
   commits the correction; discard removes the draft. Drafts remain memory-only.
2. Make selected-record status reflect that record, including pending/reviewed.
3. Add image decoding and session budgets using synthetic fixtures; preserve prior
   records on failed import. Choose limits based on measured memory, not guesswork.
4. Verify explicit orientation using generated rotated/EXIF fixtures. Add tests
   before claiming rotated image support.

Acceptance: existing seven automated tests continue passing; new synthetic tests
cover draft isolation and search gating. User verifies switching between two
pending records preserves distinct edits before approval, and existing approved
records remain searchable. Resource and orientation work has separate checks.

No persistence, production vault access, Photos integration, cloud processing or
personal-data test fixtures are added in this phase. Decide storage boundaries
before implementing saved libraries. Retain the current runtime-only manual
image-testing exception.
