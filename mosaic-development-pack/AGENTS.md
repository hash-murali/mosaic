# Mosaic development instructions

## Purpose and scope

Build Mosaic using README.md, docs/01-product-requirements.md and the current release backlog. Code and synthetic fixtures only belong in this repository. The owner may override project guidance explicitly; record material product/architecture changes in the relevant documents.

## Before changing code

Read relevant nested AGENTS.md files, inspect actual repository status and targets, then identify the requirement, service contract and acceptance tests affected. Do not assume this documentation pack is an existing compiled app. Preserve unrelated changes. Use an ADR for storage, key, identity, permission, sync or public contract changes.

## Privacy boundaries

Never search for, read, upload, copy or log real screenshots, OCR, embeddings, vaults, keys or recovery material outside the code workspace without an explicit task authorizing that precise use. An authorized import into the app does not authorize a coding agent to inspect the content. No cloud inference or hidden external requests. Fixtures must be synthetic. Do not weaken security to make a test pass. AGENTS.md and gitignore are guidance, not OS access controls.

## Implementation rules

UI depends on application services; domain has no UI/database/model imports. Require vault-scoped authorization at all content boundaries. Use typed validated model results; never execute model-generated SQL, tools or arbitrary instructions. User corrections outrank extraction. No real data before encryption and restore gates pass. Do not write custom cryptography; document and validate established library integration. No silent internal-disk fallback if the configured Mac vault SSD is absent.

## Working and verification

Complete small vertical tasks, update related docs, and run meaningful tests for touched behavior. Do not claim platform builds were run in a non-Apple environment. If blocked, record the concrete blocker and continue independent work. Release checkboxes require evidence paths/build IDs. Do not spawn extra agents unless the active user request or applicable instructions explicitly authorize delegation.

## Delivery

Report what changed, validation and remaining limits. Do not commit, push, publish, change access, or contact people unless covered by the active task's authorization. Never mark beta security controls implemented based only on documentation or logical schema tests.
