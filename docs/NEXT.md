# Next phase: review reliability

Baseline: v0.1.0 “Session Review”, release commit dbf1937 on main.
Working branch: codex/review-reliability. Target: v0.2.0 after implementation,
verification, user testing, release audit, and GitHub issue reorganization.
Current application code remains v0.1.0.

Objective: improve the reliability of the in-memory Mac review workflow.
Task scope, dependencies, and acceptance criteria live in the
[v0.2.0 GitHub milestone](https://github.com/hash-murali/mosaic/milestone/1).
Use [GitHub Issues](https://github.com/hash-murali/mosaic/issues) for the backlog;
no parallel local ticket list is maintained. See ROADMAP.md for release policy.

No persistence, production vault access, Photos integration, cloud processing or
personal-data test fixtures are added in this phase. Decide storage boundaries
before implementing saved libraries. Retain the current runtime-only manual
image-testing exception.
