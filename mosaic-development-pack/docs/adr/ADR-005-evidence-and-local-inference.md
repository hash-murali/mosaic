# ADR 005 Evidence and local inference

Status accepted direction; provider selection proposed. Date 2026-10-02.

Decision: OCR-first source-linked structured extraction, capability-tested local provider, manual/exact fallback. All model data is untrusted until schema and evidence validation. No tool/SQL/permission execution by model. Local embeddings chosen independently of text model API. Human corrections win.

Alternatives: cloud-first screenshot processing violates default private direction; vectors alone lose precise filters/evidence; treating extraction as truth hides source uncertainty. Consequences: bounded context, typed adapters, evaluation corpus and abstention UX. MOS-018/021/022 exit: actual device capabilities, schemas, privacy tests and published extraction/retrieval/grounding metrics. Affects R03 R04 R12–R15.
