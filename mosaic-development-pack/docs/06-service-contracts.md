# Application service contracts

These are typed interface requirements for implementation, not a running HTTP API. No backend endpoints or public API exist through v0.4.0. Use Swift async throwing functions and Sendable value DTOs; concrete signatures are finalized in MOS-006 against compiler/device targets.

## Request context

Every content operation receives an authorized context carrying principal ID, vault ID, operation, purpose, scope, session ID/epoch and expiration. The policy service issues it after checking lock and grants. Consumers recheck session/epoch at read, inference submission and commit; revocation/lock invalidates in-flight grants. IDs, fields and destination are explicit. OS file capability alone does not grant app content access.

| Service method | Input | Output and guarantees |
|---|---|---|
| VaultService.unlock | User authentication result, vault locator | Short-lived context; no keys returned to UI |
| VaultService.lock | Vault ID | Invalidates sessions, cancels jobs, closes sensitive views/connections |
| CaptureService.import | Input handle, metadata, context, idempotency token | Job/capture ID only after protected durable receipt; exact duplicates reuse existing capture |
| JobService.resume/cancel | Job ID, context | Checkpointed outcome; cancellation does not erase accepted source |
| RecordService.read | Record ID and field scope | Authorized projection plus permitted evidence references |
| RecordService.correct | ID, expected revision, typed changes | New revision; stale revision rejected, correction wins over machine result |
| RecordService.delete | Preview receipt, expected revision, context | Logical deletion plus durable cleanup; shared dependencies explained |
| SearchService.search | Query, filters, cursor, context | Bounded page of authorized results; no unauthorized snippets |
| IntelligenceService.extract | Observation IDs, capability choice, context | Validated candidate revision, not a permission or action |
| AskService.answer | Question and context | Cited assertions or abstention; bounded relevant sources only |
| ReviewService.list | Status/due filters, context | Ranked items with explicit reason and deterministic pagination |
| ActionService.confirmDate | Proposed action, absolute date/time/timezone, revision | Owner-confirmed action; scheduling requires separate consent |
| PortabilityService.previewExport | Selected IDs/fields, destination/purpose, context | Frozen payload plan, omissions and digest |
| PortabilityService.export | Preview receipt/digest, context | Rechecks authorization/revisions then writes approved payload atomically |
| BackupService.snapshot/restore | Destination/source and protected credential handle | Authenticated consistent snapshot/new validated vault; no key in logs/DTOs |
| AuditService.list | Context and bounded cursor | Minimal events, no content text |

## Stable errors

locked, permission_denied, grant_expired, source_unavailable, storage_unavailable, insufficient_space, invalid_input, unsupported_format, stale_revision, model_unavailable, model_output_invalid, insufficient_evidence, cancelled, retryable_failure, corrupt_archive, incompatible_version, recovery_failed.

UI maps these to the error states in docs/11-design-and-ux.md. Logs contain code and stage, not input paths, titles, OCR or exceptions with private payloads. Users may retry only errors designated retryable. Unexpected failures stop the affected job; never downgrade to plaintext storage.

## Contract semantics

Commands are idempotent by vault plus client token; dedupe tokens do not grant authority. Queries use stable cursors bound to filters/revision or reset when underlying projections change. Default search page size 30, maximum 100; Ask initial candidate cap 30 and model context budget defined per provider. Long input truncated/chunked with explicit flags; never silently drop evidence then make a complete-answer claim.

Corrections use optimistic concurrency even on one device to protect against background writes. Export authorization is rechecked after preview; changed content requires a new preview. Backup is an explicit whole-vault owner operation, not a selective integration grant. No model-generated request can initiate either operation.
