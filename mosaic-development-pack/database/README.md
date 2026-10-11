# Logical persistence sketch

logical-schema.sql runs in standard SQLite for synthetic invariant checks. It is not encrypted, not a production migration, and must not receive real content. The application must use a validated SQLCipher adapter and reviewed encrypted attachment storage.

Foundation includes vault/capture/source/observation, entities/mentions/claims/actions, jobs, collections, relationships, corrections/user states, insights, grants/audit and FTS projection. JSON columns store logical draft shapes and require typed application/schema validation; they do not enforce authorization or full evidence semantics by themselves. UUID/date/path validation is application-level. Relations and insight evidence need source-reference validation in the service transaction.

Logical deletion cascades source-dependent rows in this draft. Production preview must distinguish adopted user actions, shared entities and independent user state. No SQL trigger itself deletes files or schedules notifications; durable service cleanup owns those side effects. Foreign keys enabled on every connection; FTS projection updated in same transaction as accepted record changes. Byte-hash dedupe applies only within vault and does not collapse near-duplicates.

Run scripts/validate_pack.py for logical integrity/search tests. Actual adapter encryption, key lifecycle, platform concurrency, journaling and migration evidence still required.
