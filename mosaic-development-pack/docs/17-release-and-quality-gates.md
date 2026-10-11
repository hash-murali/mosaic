# Release and quality gates

Every checkbox is initially incomplete. Attach real evidence; this pack grants no release approval.

## Every release

- [ ] Required R/NF outcomes implemented and traceability updated.
- [ ] Unit/integration/UI/fault tests appropriate to changed behavior passed on declared targets.
- [ ] No P0/P1 defects or critical/high security finding.
- [ ] Protection, negative policy and no-content-egress checks passed.
- [ ] Backup and every supported schema migration/restore path demonstrated.
- [ ] Changes reviewed for private data, secrets, dependency/license and data model impact.
- [ ] Documentation, actual dependency pins and known limitations updated.
- [ ] Build/scheme/signing and test/evaluation versions recorded.
- [ ] Product owner accepts residual limitations.

## Version specific

v0.1: Mac selected import -> source -> OCR -> correction -> search -> delete; protected storage; T01–T09/T21/T22 relevant; independent recovery drill.

v0.2: supported device matrix; native intake/discovery; T10–T12/T24; 100-image interrupted batch no accepted-source loss; limited/denied permission states; no silent SSD fallback.

v0.3: 200 labeled captures and 50 retrieval questions; published accuracy/abstention; valid evidence links; correction precedence; T13–T17; high-impact date guard suite perfect; unavailable-model fallback.

v0.4: selective export/transfer/audit/help; T18–T24; 10,000 metadata and 1,000 image stress; complete source/cache/temp plaintext inventory; two-week owner dogfood and small consenting beta; observed usable core journeys; signed builds, restore guide, no substantive design defect.

## Severity

P0 private exposure, data loss or unsafe destruction: stop/revert affected release and invoke incident runbook. P1 crash/unusable core path: block. P2 secondary defect: workaround, owner and scheduled issue; cannot hide a security/integrity issue under P2. P3 cosmetic: document and prioritize. Security severity tracked separately. Known limitations must name affected capability/device and workaround.

## Evidence structure

docs/evidence/releases/<version>/ contains report, build/device matrix, commands/results, corpus digest, evaluation report, security findings and owner acceptance. Never include private content, raw screenshots, actual keys, tokens or unredacted diagnostics. templates/release-evidence.md provides the initial form.
