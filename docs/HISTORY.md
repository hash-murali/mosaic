# Mosaic brief history

One row per meaningful test, fix, or decision. Never include personal images,
OCR contents, filenames, or paths. Times use America/New_York. Legacy timestamps
are unknown unless explicitly recorded; entry time is not test-execution time.
Git branches have names; release tags identify exact commits.

| Recorded time | Version / branch | Test or change | Result / decision |
| --- | --- | --- | --- |
| 2026-09-30 01:23 EDT (retrospective) | pre-version / main | Initial user OCR and approval/search test | User passed; retain explicit approval gate. |
| 2026-09-30 01:23 EDT (retrospective) | pre-version / main | Search typing blocked | Added regular Mac app activation and search focus; user confirmed fixed, including correction search. |
| 2026-09-30 01:23 EDT (retrospective) | pre-version / main | New import replaced earlier record | Added session library, Review Inbox, reopen and per-record discard. |
| 2026-09-30 01:23 EDT | 0.1.0 / main | User tested multiple images and delayed review | User reported all tests passed: retention, search, open source image, pending inbox and later review. |
| 2026-09-30 01:23 EDT | 0.1.0 / main | Code audit and release baseline | Local release “Session Review”; no remote configured. Known gaps recorded in AUDIT.md. |

Future updates use four brief labels: Retained, Changed, Known issues, Test next.
Record the release version, branch, actual result and reason for meaningful changes.
