# ADR 003 Recovery and key lifecycle

Status proposed, blocks real-data use. Date 2026-10-02.

Decision direction: random vault key, platform-controlled key access and independently protected recovery mechanism. Choose established authenticated-encryption/container library, suite/version, nonce/key separation, credential delivery and rotation after spike. Biometric unlock is authentication, not key derivation. No universal operator key.

Alternatives: device-only unrecoverable keys risk permanent data loss; cloud key escrow violates owner-only direction unless explicitly revised; weak passphrase ZIP is not accepted by default. Consequences: owner must keep recovery material; loss of all keys is unrecoverable; independent transfer needs explicit UX.

MOS-004 exit: device B without device A Keychain restores authenticated snapshot, source hashes/corrections match; wrong credential/tamper rejected; archive traversal/resource bounds covered; key/recovery policy documented. No actual cryptographic format finalized here. Affects R06 R07 R20.
