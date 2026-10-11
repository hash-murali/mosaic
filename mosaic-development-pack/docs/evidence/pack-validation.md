# Documentation pack validation

Executed 2026-10-02T21:26:00.388343+00:00 in a Linux workspace.

Command python3 scripts/validate_pack.py.

24 checks passed.

- positive contract: extraction
- positive contract: answer
- positive contract: export-manifest
- negative rejection: model command field
- negative rejection: out of range evidence
- negative rejection: invented source quote
- negative rejection: duplicate entity ID
- negative rejection: uncited assertion
- negative rejection: wrong capture reference
- negative rejection: facts in abstention state
- negative rejection: archive traversal
- negative rejection: duplicate export record
- negative rejection: duplicate archive path
- logical SQL: private unreviewed defaults
- logical SQL: exact-source dedupe
- logical SQL: cross-vault reference
- logical SQL: evidence capture mismatch
- logical SQL: reversed evidence offsets
- logical SQL: unconfirmed reminder
- logical SQL: confirmed date lacks datetime/timezone
- logical SQL: FTS edit consistency
- logical SQL: source-delete cascade retains entity and clears FTS
- local Markdown links: 10 valid
- 20 requirements and 27 backlog IDs present

## Scope and limits

Restricted fixture validation, semantic evidence checks, standard SQLite in-memory constraints/FTS and Markdown links only. No Apple build, SQLCipher encryption, Keychain, recovery, authorization implementation or model accuracy test was executed. Tests in the application catalogue remain planned. Illustrative export hashes are placeholders.
