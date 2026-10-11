# Security and access control specification

Status proposed controls. No assertion of implemented security, immutable audit, certification or resistance to a compromised OS. Real-data use blocked until MOS-003, MOS-004 and MOS-005 protection evidence passes.

## Role and authority model

| Principal | Operational authority | Content authority |
|---|---|---|
| Owner | Vault settings, key/recovery setup, delete, grants | Own unlocked vault |
| Delegated reader/editor later | Granted operations | Granted records and fields only |
| Workspace administrator later | Membership and workspace policies | No automatic content access |
| Super admin/operator later | Availability, deployment and incident response | No universal decryption capability |
| Developer/QA | Code and synthetic tests | No production vault access by default |
| Support | Redacted diagnostics | User-shared scope only |
| Compliance/security reviewer | Control evidence and sanitized audit | No screenshot content by default |
| Integration later | Bound purpose/destination | Expiring narrow grant only |

Beta has one owner and test principals for negative testing. No invented admin signup UI or infrastructure. Future service roles need server enforcement, authentication/session design, tenant isolation and key distribution before activation.

## Authorization decisions

Allow only if authenticated principal matches valid grant/owner authority; vault unlocked; requested operation within scope; all record/field IDs belong to vault; session active; destination/purpose allowed; expiration not passed; privacy policy permits; no revocation. Missing inputs deny. Checks apply to content, search snippet, thumbnail, embedding retrieval, model prompt, export, backup and diagnostic creation. Lock changes session epoch so queued work cannot commit through stale authority.

## Threat register

| Threat | Prevent/detect/respond | Verification |
|---|---|---|
| Lost device or stolen SSD | Encrypted DB/files, gated key access, lock | T01 T02 T03 |
| Keys lost or device replaced | Independent recovery setup and verified restore | T04 T05 |
| Untrusted image/parser input | Type/size bounds, safe decoding, no arbitrary paths | T08 T23 |
| Prompt injection in OCR | Treat as data, allow no commands/tool execution | T13 |
| Accidental external sharing | Preview, explicit scope/destination, encrypted default | T18 T19 |
| Unauthorized search or AI disclosure | Policy before content retrieval and inference | T02 T14 |
| Hidden plaintext caches/journals | Encrypted/ephemeral cache inventory and inspection | T01 T22 |
| Coding-agent access | Separate data root/account, no real fixtures/keys in Git | T22 and developer review |
| Dependency compromise | Pin versions, inventory, license/vulnerability review | Release checklist |
| Migration or SSD interruption | Consistent backup, transactions and safe failure | T06 T07 T21 |
| Private diagnostics leak | Allowlist diagnostic fields and redaction tests | T20 |

## Vault and keys

Use random vault data key protected by platform Keychain access controls; select accessibility/user-presence policy in spike based on app lock requirements. Biometric authentication is a gate, not a source of encryption entropy. Separate database/attachment/staging/backup keys or use a reviewed key-derivation scheme with domain separation. Never create cryptographic protocols ad hoc.

SQLCipher is the candidate DB adapter; verify encryption of main DB and associated pages/journals/temp behavior for the actual build. Attachments use authenticated encryption through established library APIs. Record suite/version/key identifiers and bind file context through authenticated metadata. Random nonce per encryption under a key; do not reuse. Large-source chunking and key rotation require separate reviewed design before support; baseline imports bounded to whole-file operations for a successful spike.

Application lock cancels processing, closes DB handles, invalidates sessions and clears content caches/loaded keys where practical. Do not claim perfect memory erasure in managed Swift or protection from malware running as the owner. While locked, share intake must either use a validated staging-only envelope or ask user to unlock; no weakening vault key restrictions.

Recovery mechanism is provisional: independently protected high-entropy recovery material and authenticated portable backup. MOS-004 must establish format/library, credential lifecycle and second-device restore. Passphrase-based recovery is not approved until a reviewed KDF/parameters and recovery UX exist. Store no recovery plaintext in repository or diagnostic bundle.

## Audit and privileged operations

Events capture actor, decision, operation, opaque IDs, time and build; bounded retention defaults in docs/08. Add failures for export/grant/key/restore actions. Owner can inspect. Local logs cannot provide tamper-proof evidence against the machine owner. Administrative service changes later can stop access but never silently grant a decryption key. Consent and role membership are not interchangeable.

## Security review outputs

Threat model update, key/data-flow inventory, negative policy tests, network observation, plaintext artifact inspection, dependency report, restore drill, outstanding findings and release recommendation. Critical/high findings block beta; obtain independent review before broad public distribution.
