# Contract status and validation

JSON Schema draft 2020-12, logical wire/storage version 1.0.0. Each payload rejects extra fields. These schemas are not full cryptographic file formats, public APIs or a promise that provider structured-output APIs support JSON Schema directly.

extraction.schema.json is model candidate output: evidence, suggestions and date expressions. answer.schema.json is source-linked answer output. export-manifest.schema.json is selective-export logical manifest, private inside the authenticated encrypted envelope.

examples contains synthetic positive fixtures. scripts/validate_pack.py implements only the schema vocabulary used here (type, enum, const, required, properties, additionalProperties, items, min/max bounds, pattern, formats and local refs). It is a restricted offline fixture checker, not a full JSON Schema implementation. Production/tooling should additionally use a standard draft 2020-12 validator and enforce semantic authorization/evidence/archive constraints described in docs/06 and docs/12.

Semantic checks after parsing: all cited observations/captures are in authorized retrieved set; code-point offsets are ordered/in range; exact source quote matches where provided; unique local IDs and reference closure; export field/files match frozen approval; payload revisions unchanged; archive authenticated and bounded. Structural validity cannot establish truth or consent. Export example hashes, sizes and approval digest are illustrative placeholders, not an actual archive or cryptographic approval.
