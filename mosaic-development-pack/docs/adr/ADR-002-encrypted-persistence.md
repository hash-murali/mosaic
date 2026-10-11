# ADR 002 Single authority encrypted persistence

Status proposed mechanism; one-authority direction accepted. Date 2026-10-02.

Context: exact search, provenance, portable data and private storage. Decision candidate: SQLite repository adapter, SQLCipher DB encryption, encrypted owned attachments; FTS/vector indexes rebuildable. No SwiftData/SQLite dual authority.

Alternatives: SwiftData only if encryption/search/migration needs demonstrated; plaintext SQLite excluded for real data. Consequences: dependency packaging/license review, journal/temp inspection, key handling and controlled migrations. SQL sketch alone is not a security implementation.

MOS-003 exit: real target builds, DB/source wrong-key tests, no plaintext in actual artifact inventory, FTS edit/delete behavior, license decision and documented adapter version. If not met, choose another validated one-authority adapter and update specs before real data. Affects R02 R05 R06 R19.
