# Start development here

The pack is ready as a planning baseline. Begin development with the existing repository, not by creating another project. It contains no runnable Apple app.

## Product owner responsibilities

Read docs/01-product-requirements.md and docs/03-release-roadmap.md. Check the desired outcomes and scope boundaries. Supply actual devices/OS versions when needed, choose beta audience before distribution, and accept tested release limitations. You do not need to design the encryption algorithm, write SQL or invent an enterprise admin system.

## Lead developer responsibilities

1. Run MOS-001 read-only repository/toolchain inventory on the Mac.
2. Reconcile this pack with existing files; preserve current AGENTS.md/.gitignore and project structure.
3. Complete MOS-002 capability matrix, including local model and embedding availability.
4. Validate MOS-003 encrypted persistence and MOS-004 independent recovery. v0.1 second-device drill may use a second Mac; iPhone/iPad transfer is verified by v0.4.
5. Decide MOS-005 safe extension staging before shipping mobile Share intake.
6. Build the protected Mac import-to-search slice with synthetic data, then meet v0.1 release gates before introducing real owner data.

## What is decided versus pending

Decided direction: private local data, native Apple clients, owned evidence, correction authority, snapshot transfer before live sync, approved subset reuse. Pending mechanisms: SQLCipher packaging/license, recovery cryptographic envelope, extension staging key scheme, embedding adapter, actual supported device matrix and signing identifiers. The pending items have backlog IDs and exit criteria.

## First task brief

“Work on MOS-001 in the existing Mosaic repository. Read applicable instructions, inspect Git/project/toolchain state without changing it, do not inspect private data, and create the inventory report identifying actual targets, rules and next safe implementation task.”

## Verified here

Documentation links, synthetic schema examples/negative cases and in-memory logical SQL constraints passed the pack validator. Apple builds, storage encryption, recovery and AI accuracy are not verified. See docs/evidence/pack-validation.md.
