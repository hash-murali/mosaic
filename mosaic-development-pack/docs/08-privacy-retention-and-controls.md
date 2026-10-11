# Privacy retention and control register

Local-first means Mosaic does not intentionally transmit private content. It does not undo existing Photos/iCloud settings or control owner-approved exported copies. The app must explain that distinction in onboarding.

## Data handling defaults

| Data | Location/default | Retention/deletion |
|---|---|---|
| Sources, OCR, claims, corrections and user notes | Encrypted owner vault | Until owner deletes; explain shared dependencies |
| Thumbnails and search/vector indexes | Encrypted or ephemeral local derived store | Delete with source or rebuild; not authoritative |
| Intake staging | Protected local staging only | Clear after successful adoption or owner discards; failed items visible for recovery |
| Processing outputs | Encrypted candidate revisions | Keep accepted lineage; maintenance policy configurable later |
| Audit events | Encrypted local log | Proposed 90-day rolling default; owner can export/delete under policy |
| Backups | Explicit owner destination, encrypted | Owner-controlled expiry; never delete last known-good backup automatically |
| Diagnostic bundle | Explicit creation, content-free allowlist | App removes temporary bundle after handoff; destination copy outside app control |
| Model assets | Local model/cache location | Remove through settings; no model training on vault by default |

These are proposed product defaults, not legal retention periods. Implement a bounded cleanup job and clear storage accounting. No analytics enabled by default. Data inventory tracks fields, purpose, storage, access principals, lifespan and egress.

## Control matrix

| Control | Owner role | Evidence | Release |
|---|---|---|---|
| C01 Data inventory | Architect | docs/05 and actual artifact inventory | v0.1 |
| C02 Least privilege | Lead developer | Policy-negative test results | v0.1 |
| C03 Encryption and keys | Security reviewer/lead | Actual SQLCipher/file/key tests | v0.1 |
| C04 Recovery | Lead developer | Second-device recovery drill | v0.1 then v0.4 |
| C05 Consent and scope | Product owner/lead | Permission/export preview test | v0.2 then v0.4 |
| C06 Retention/deletion | Lead developer | Deletion/index/cache tests | v0.1 then v0.4 |
| C07 Supply chain | Lead developer | Package versions, licenses and SBOM | Each release |
| C08 Change/release governance | Lead/product owner | Reviewed change and release evidence | Each release |
| C09 Diagnostics/audit | Lead developer | Redaction tests and event samples | v0.4 |
| C10 Incident handling | Lead/product owner | Recovery tabletop and runbook | v0.4 |

No role is staffed or control proven yet. Legal/privacy policy review depends on actual distribution, users, jurisdictions and processing. Do not claim SOC 2, GDPR or other compliance from this matrix. Consent to capture is not consent to external research or training.

## Export revocation

Revocation blocks future use through Mosaic interfaces. Files already handed to another project cannot be recalled. Record this in the grant UI and portability guide. Default exports encrypted; plaintext is an explicit owner action after a warning. Sensitive category guessing must never relax privacy.
