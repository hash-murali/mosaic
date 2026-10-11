# Backup export and recovery specification

This document defines behavior and logical contents, not a finalized cryptographic container. ADR-003 remains proposed until MOS-004 establishes library/suite, authenticated envelope and independent recovery on two devices. Do not use a password-protected ZIP as a substitute without that review.

## Separate operations

Backup is an explicit whole-vault owner snapshot for recovery. Selective export is approved subset reuse with field/source controls. Snapshot transfer restores as a separate local instance. None is live sync or a merge protocol. An integration scoped to Reading must not invoke whole-vault backup.

## Backup consistency

Pause relevant writes or use adapter-supported consistent snapshot transaction; include canonical data, corrections, source files and metadata versions. SQLite WAL is not safely backed up by blindly copying only the main DB file. Indexes are optional because rebuildable. Generate authenticated manifest and source hashes. Validate newly written backup before calling success. Use independent credential setup and restore test; keys never stored plaintext next to archive.

## Selective export flow

Choose destination/purpose -> select entities/records and fields -> compute dependency closure -> preview every included field/source and omitted dependency -> explicitly approve -> recheck grant and record revisions -> serialize bounded schema -> encrypt with reviewed envelope -> atomic write -> audit. Changing a selected record between preview/write forces new preview. Default excludes source images, raw OCR, private notes and unselected related claims.

contracts/export-manifest.schema.json describes the logical payload manifest. Manifest contains allowlisted field inventory, minimal provenance metadata and selected file entries. Metadata itself is private and belongs inside encrypted envelope. A self-declared hash is not authentication. Production exporter must verify filenames, fields and actual payloads against approval; the contract alone does not guarantee authorized content.

## Dependency policy

An entity can be exported with source capture ID/evidence metadata but no OCR/image. Export UI explains reduced independent verifiability. Full evidence inclusion is optional and must be separately approved. No hidden inclusion of full capture because one title was selected. A later consumer may fetch more only through a valid explicit grant; no API exists yet.

## Import/restore algorithm

1. Validate container size/version/suite before parsing; authenticate before trusting contents.
2. Reject path traversal, absolute paths, symbolic links, duplicate paths, expansion bombs and excessive entry counts.
3. Check schema compatibility and expected hashes, reference closure and field inventory.
4. Build in a new staging vault; validate relational integrity and source existence; rebuild derived indexes.
5. Activate only after complete success and owner destination confirmation; preserve existing vault.
6. Clean staging on failure without deleting last good snapshot; report stable error code.

Draft archive bounds: 100,000 entries, no individual file beyond supported import cap unless a reviewed chunking format exists; total extracted size bounded by available space and declared budget. Never allocate solely from untrusted manifest length. Snapshot restore starts new instance ID; imported suggested reminders stay unscheduled until owner confirms on the device. Duplicate instance histories do not silently merge.

## Recovery drill

Device A creates snapshot; device B lacks A's Keychain item. Restore with independently protected recovery material. Compare record counts, corrections, source hashes and query results; wrong credential/corrupted source/tampered manifest fail safely. Report exact build, suite, schema, devices and test cases. Deleting a current record does not remove old backups/exports; owner controls those copies.
