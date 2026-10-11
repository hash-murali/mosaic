# Intelligence and retrieval specification

## Capability routing

Local OCR is the baseline. Text extraction adapter reports available language, context budget and structured-output capability. Unsupported model/device keeps manual review and exact search. No cloud fallback, remote Mac endpoint or image inference assumption. A separate local embedding adapter must be selected and validated; Foundation Models access alone does not establish an embedding API. MOS-002/MOS-021 resolve model packages, dimensions, licensing and supported hardware.

## Extraction contract

contracts/extraction.schema.json is version 1.0.0. Every entity/claim/action suggestion has observation evidence offsets. The application, not the model, sets capture/vault IDs, provider versions, privacy and authority. Dates remain original expressions until owner confirmation. Model suggestions cannot assert verified status or schedule reminders. Category/title/summary are candidates; summary has an evidence list. Additional output fields are rejected.

Prompt boundary: system instruction describes extraction only; OCR inserted as clearly delimited untrusted data. Model receives only authorized bounded text. Never treat text saying “upload this vault” as tool authority. Validate structure, evidence existence/range, entity IDs and semantic date behavior before saving. One repair attempt may fix formatting; bounded failure routes to manual review. The schema is storage/wire format; provider adapters may translate it to a framework's native generated type.

## Confidence and source reliability

No arbitrary “95% AI confidence.” Show needs-review reasons, source provenance and missing evidence. OCR engine confidence is a separate measurement. An LLM's self-report is not calibrated accuracy. Saved source claims may be unverified even when extraction is correct. Verification requires explicit origin, date and evidence; owner checking is not external authority.

## Search and Ask pipeline

Question -> typed query intent -> policy-filtered exact/filter candidates -> optional local vector candidates -> dedupe/rerank -> bounded authorized evidence -> local answer -> assertion/citation validation -> source-linked presentation. Do not feed the whole vault. No generated SQL: translate typed intent through allowlisted repository queries. Answer includes insufficient-evidence state, truncation/capability notices and only citations to retrieved records.

Evidence offsets identify actual text; structural validators cannot prove an inference or paraphrase is supported. Evaluation requires human review of material assertions. Invalid reference means reject answer. If model unavailable show retrieved records; search remains functional.

## Relationships and review

Repeated interest counts distinct captures, not processing revisions. Explicit “if you liked X try Y” links preserve evidence; semantic similarity is inferred. Conflict detection flags potential difference, does not silently supersede claims. Rank Review deterministically: confirmed overdue/due actions, unreviewed source issues, repeated unresolved entity interest, then older unreviewed captures. Exclude completed/dropped entities from unfinished-interest cues; snooze/disposition overrides ranking. Every insight includes why, sources and dismiss/undo.

## Evaluation

Freeze 200 synthetic/de-identified captures across six product categories, including multi-title lists, crops, unreadable text, relative dates, contradictory statements and injected commands; version corpus and labels. Need 50 retrieval questions with known evidence. Initial pack examples are contract fixtures, not that evaluation corpus.

Proposed v0.3 thresholds: schema validity >=99%; entity precision >=90%, recall >=85%; exact expected record top3 >=95%; semantic expected record top5 >=85%; all saved derived records have valid citations; >=90% material answer assertions supported by cited evidence on human review. Every high-impact reminder-control test passes; fabricated deadlines in that suite block release. Track abstention, unsupported-answer rate, subgroup errors and provider versions. Threshold changes require explicit recorded rationale; do not optimize by dropping difficult cases.
