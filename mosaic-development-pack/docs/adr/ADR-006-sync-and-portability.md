# ADR 006 Snapshot portability before live sync

Status accepted planning direction. Date 2026-10-02.

Decision: all clients maintain independent local vault instances through v0.4.0; snapshot restore is explicit separate instance, no concurrent merge. Approved subset export includes documented schema/provenance. Live encrypted sync starts v0.5 with separate key/pairing/conflict/deletion design.

Alternatives: immediate automatic sync adds risk and delays recoverable local beta. Consequences: owner manually chooses transfer, diverged devices cannot combine histories automatically; onboarding states this limitation. MOS-023/025 exit: preview/payload consistency, second-device restore, explicit no-sync UX. Affects R16 R20.
