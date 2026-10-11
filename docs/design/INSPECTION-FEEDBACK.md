# October 4 inspection feedback — response and product boundaries

Target v0.1.1; owner observations recorded in the linked
[review evidence](../evidence/builds/v0.1.1-20261004-owner-review-01.md).
These are design dispositions, not a second task tracker. GitHub owns delivery.

## Immediate UI findings

Whole navigation-row/card click areas now explicit. Library cards show short
summaries; selected approved record has expandable original/full evidence.
Pending records show evidence expanded and retain visible editing/approval.
This addresses the owner's readability direction without hiding required review.
Retest G01–G05; compilation and interaction remain unverified for the new source.

## Empty information and preferences

Recommend blocking blank-text approval with Add text or discard, preserving the
source until explicit discard. Do not automatically delete an unreadable source:
the owner may correct it manually. Owner approved this rule October 4; core and UI now block blank/whitespace
approval and retain the source/draft. New synthetic coverage awaits execution. Image-only records are an alternative,
requiring explicit meaning/search rules. Historical empty-correction acceptance is superseded; inspect G06.

Preferences should control conveniences (default correction mode, detail density,
similarity hints), not disable evidence separation, authorization or date consent.
Draft preservation remains a safety default; switching correction off should not
silently erase typed text. Persistent preferences await protected storage/services.
No new settings preference claimed implemented today.

## Similar information in different sources

Exact decoded-pixel duplicate detection is current behavior; crops/re-encoding
can be distinct sources. Recommend deterministic normalized-text equality hints
first: Similar text in an existing record, with source comparison. It is cheaper
than image/model similarity, can run on import/approval and need not scan every
image repeatedly. Measure bounds on declared hardware; no performance promise yet.
Near-text similarity follows evaluation; optional embeddings are later capabilities.
User correction changes must update any similarity projection.

Never merge/delete merely because OCR matches. Multiple sources may corroborate,
contradict or capture different context. Offer keep both, link related records or
explicit discard after comparison. A warning may request a decision, but should
not force tagging for every similar record. Preserve distinct-source test B09.
No similarity adapter or preference is implemented; TODO(MOS-019/020) direction.

## Original storage and evidence after deletion

Current protected-foundation plan retains encrypted owned originals; no silent
cleanup or retention-limit deletion is approved. Storage accounting, thumbnails,
collection-level retention and explicit cleanup previews are possible later choices.
Bound import/processing memory separately from total durable library capacity.
Do not store 10,000 full-resolution images in the UI's in-memory session model.

If an owner deliberately removes an original later, keep clear provenance/status
and accepted correction/text only under an approved retention contract. Label
source unavailable and text-only evidence. A source hash cannot reconstruct an
image or prove OCR accuracy. No thumbnail/summary/hash replaces the original.
Ask must cite retained observations, disclose missing visual evidence and abstain
when support is insufficient; it cannot claim to verify an image that no longer
exists. Old generated answers/insights need invalidation or revalidation when
supporting evidence is removed. This reduces verifiability and needs an ADR,
delete preview and export/recovery consequences before code changes.

## Remaining testing and feasibility

Picker cancellation needs only choosing Cancel without selecting a file (G04).
Section D is automated policy coverage, not a manual hacking exercise. Section E
protections are absent and will get dedicated developer tests after implementation.
Orientation needs synthetic rotation/EXIF/mixed-layout fixtures before OCR/intake
acceptance; one owner example is encouraging but does not establish all formats.
LLM injection/evidence tests belong to MOS-018/T13 before any model ships, including
no tool/network execution, invalid citations, malicious OCR and capability fallback.

A broad final UI/accessibility review around the owner's suggested v0.3.5 checkpoint
can complement ongoing checks. Core keyboard access, evidence readability, privacy
and destructive-action clarity cannot wait until then; release gates still apply.
The v0.3.5 checkpoint is a requested review point, not a finalized new release scope.

Protected local capture/recovery is realistic. Perfect OCR, automatic semantic
identity, zero hallucinations with missing evidence and unbounded inexpensive
processing are not guarantees. Keep local bounded workflows, manual correction,
optional model capability and source-based abstention.

v0.1.1 is not near release closure: session review and first design have owner
feedback, but encryption, durable import/jobs, app-wide lock/policy, independent
recovery, storage faults and integrated foundation tests remain major work.
No reliable calendar estimate until storage/recovery spikes validate mechanisms.

## Consistency across chats

DECISIONS.md records owner approval, proposals and supersession; design guides
and PLAN summarize the currently adopted scope; GitHub links own acceptance/status.
New ideas must name affected requirement/release, privacy/storage impact and
conflicts with existing decisions. Keep useful proposals deferred without implying
approval. Do not silently merge contradictory policies or rewrite historic evidence.
No messaging of other chats or external ticket publication is authorized here.
