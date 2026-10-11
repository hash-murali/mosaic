"""Restricted offline fixture checker, not a general JSON Schema validator.

No application, encryption, platform, authorization or model-accuracy proof.
"""
from pathlib import Path, PurePosixPath
import copy
import datetime as dt
import importlib.util
import json
import re
import uuid

ROOT = Path(__file__).resolve().parents[1]


def require(condition, message):
    if not condition:
        raise ValueError(message)


def schema_check(value, schema, root=None, path="$"):
    root = root or schema
    if "$ref" in schema:
        target = root
        require(schema["$ref"].startswith("#/"), "Only local refs supported")
        for part in schema["$ref"][2:].split("/"):
            target = target[part]
        return schema_check(value, target, root, path)
    types = {
        "object": lambda v: isinstance(v, dict),
        "array": lambda v: isinstance(v, list),
        "string": lambda v: isinstance(v, str),
        "integer": lambda v: isinstance(v, int) and not isinstance(v, bool),
        "boolean": lambda v: isinstance(v, bool),
        "null": lambda v: v is None,
    }
    if "type" in schema:
        choices = schema["type"] if isinstance(schema["type"], list) else [schema["type"]]
        require(any(types[t](value) for t in choices), f"{path}: wrong type")
    if "const" in schema:
        require(value == schema["const"], f"{path}: wrong constant")
    if "enum" in schema:
        require(value in schema["enum"], f"{path}: not in enum")
    if isinstance(value, dict):
        require(all(k in value for k in schema.get("required", [])), f"{path}: required field absent")
        props = schema.get("properties", {})
        if schema.get("additionalProperties") is False:
            require(set(value) <= set(props), f"{path}: unknown field")
        for key, item in value.items():
            if key in props:
                schema_check(item, props[key], root, f"{path}.{key}")
    if isinstance(value, list):
        require(len(value) >= schema.get("minItems", 0), f"{path}: too few items")
        require(len(value) <= schema.get("maxItems", float("inf")), f"{path}: too many items")
        for i, item in enumerate(value):
            schema_check(item, schema.get("items", {}), root, f"{path}[{i}]")
    if isinstance(value, str):
        require(len(value) >= schema.get("minLength", 0), f"{path}: too short")
        require(len(value) <= schema.get("maxLength", float("inf")), f"{path}: too long")
        if "pattern" in schema:
            require(re.search(schema["pattern"], value) is not None, f"{path}: pattern failed")
        if schema.get("format") == "uuid":
            require(str(uuid.UUID(value)) == value, f"{path}: noncanonical UUID")
        if schema.get("format") == "date-time":
            parsed = dt.datetime.fromisoformat(value.replace("Z", "+00:00"))
            require(parsed.tzinfo is not None and "T" in value, f"{path}: timestamp needs timezone")
    if isinstance(value, (int, float)) and not isinstance(value, bool):
        require(value >= schema.get("minimum", -float("inf")), f"{path}: too small")
        require(value <= schema.get("maximum", float("inf")), f"{path}: too large")


def evidence_check(evidence, observations):
    oid = evidence["observation_id"]
    require(oid in observations, "Unknown or unauthorized evidence")
    source = observations[oid]
    start, end = evidence["start"], evidence["end"]
    require(0 <= start < end <= len(source["text"]), "Evidence range invalid")
    if "quote" in evidence:
        require(source["text"][start:end] == evidence["quote"], "Quote differs from evidence")
    if "capture_id" in evidence:
        require(source["capture_id"] == evidence["capture_id"], "Capture mismatch")


def extraction_check(payload, observations):
    seen = set()
    require(not payload["summary"] or payload["summary_evidence"], "Summary requires evidence")
    for evidence in payload["summary_evidence"]:
        evidence_check(evidence, observations)
    for group in ("entities", "claims", "actions"):
        for item in payload[group]:
            if "local_id" in item:
                require(item["local_id"] not in seen, "Duplicate local ID")
                seen.add(item["local_id"])
            for evidence in item["evidence"]:
                evidence_check(evidence, observations)


def answer_check(payload, observations):
    if payload["status"] != "answered":
        require(not payload["assertions"], "Abstention cannot contain asserted facts")
    else:
        require(bool(payload["assertions"]), "Answered state requires assertions")
    for assertion in payload["assertions"]:
        for citation in assertion["citations"]:
            evidence_check(citation, observations)


def export_check(payload):
    seen_records, seen_paths = set(), set()
    for record in payload["records"]:
        key = (record["type"], record["id"])
        require(key not in seen_records, "Duplicate export record")
        seen_records.add(key)
        require(len(record["fields"]) == len(set(record["fields"])), "Duplicate exported field")
    for entry in payload["files"]:
        raw = entry["path"]
        p = PurePosixPath(raw)
        require(not p.is_absolute() and ".." not in p.parts, "Unsafe archive path")
        require(str(p) == raw and "\\" not in raw, "Noncanonical archive path")
        require(raw not in seen_paths, "Duplicate archive path")
        seen_paths.add(raw)
    # Actual authorization, byte hashes and cryptographic authentication need app tests.


def negative(check, payload, label):
    try:
        check(payload)
    except (ValueError, KeyError):
        return f"negative rejection: {label}"
    raise AssertionError(f"Expected rejection: {label}")


def check_links():
    count = 0
    for md in ROOT.rglob("*.md"):
        for target in re.findall(r"(?<!!)\[[^\]]*\]\(([^)]+)\)", md.read_text()):
            if "://" in target or target.startswith("#"):
                continue
            require((md.parent / target.split("#")[0]).exists(), f"Missing link {md}: {target}")
            count += 1
    return f"local Markdown links: {count} valid"


def main():
    examples = ROOT / "contracts/examples"
    observations = json.loads((examples / "observations.json").read_text())
    checks, validators, payloads = [], {}, {}
    for name, semantic in (("extraction", extraction_check), ("answer", answer_check), ("export-manifest", export_check)):
        schema = json.loads((ROOT / f"contracts/{name}.schema.json").read_text())
        payload = json.loads((examples / f"{name}.json").read_text())
        def validate(p, s=schema, sem=semantic, n=name):
            schema_check(p, s)
            sem(p) if n == "export-manifest" else sem(p, observations)
        validate(payload)
        validators[name], payloads[name] = validate, payload
        checks.append(f"positive contract: {name}")
    bad = copy.deepcopy(payloads["extraction"]); bad["execute_sql"] = "DELETE"
    checks.append(negative(validators["extraction"], bad, "model command field"))
    bad = copy.deepcopy(payloads["extraction"]); bad["entities"][0]["evidence"][0]["end"] = 999
    checks.append(negative(validators["extraction"], bad, "out of range evidence"))
    bad = copy.deepcopy(payloads["extraction"]); bad["entities"][0]["evidence"][0]["quote"] = "Invented"
    checks.append(negative(validators["extraction"], bad, "invented source quote"))
    bad = copy.deepcopy(payloads["extraction"]); bad["entities"][1]["local_id"] = "e1"
    checks.append(negative(validators["extraction"], bad, "duplicate entity ID"))
    bad = copy.deepcopy(payloads["answer"]); bad["assertions"][0]["citations"] = []
    checks.append(negative(validators["answer"], bad, "uncited assertion"))
    bad = copy.deepcopy(payloads["answer"]); bad["assertions"][0]["citations"][0]["capture_id"] = "99999999-9999-4999-8999-999999999999"
    checks.append(negative(validators["answer"], bad, "wrong capture reference"))
    bad = copy.deepcopy(payloads["answer"]); bad["status"] = "insufficient_evidence"
    checks.append(negative(validators["answer"], bad, "facts in abstention state"))
    bad = copy.deepcopy(payloads["export-manifest"]); bad["files"][0]["path"] = "../escape.json"
    checks.append(negative(validators["export-manifest"], bad, "archive traversal"))
    bad = copy.deepcopy(payloads["export-manifest"]); bad["records"].append(copy.deepcopy(bad["records"][0]))
    checks.append(negative(validators["export-manifest"], bad, "duplicate export record"))
    bad = copy.deepcopy(payloads["export-manifest"]); bad["files"].append(copy.deepcopy(bad["files"][0]))
    checks.append(negative(validators["export-manifest"], bad, "duplicate archive path"))
    spec = importlib.util.spec_from_file_location("logical_schema_checks", ROOT / "database/check_logical_schema.py")
    module = importlib.util.module_from_spec(spec); spec.loader.exec_module(module)
    checks.extend(f"logical SQL: {x}" for x in module.check_schema())
    checks.append(check_links())
    prd = (ROOT / "docs/01-product-requirements.md").read_text()
    trace = (ROOT / "docs/19-traceability.md").read_text()
    backlog = (ROOT / "docs/15-backlog.md").read_text()
    for i in range(1, 21):
        require(f"R{i:02d}" in prd and f"R{i:02d}" in trace, "Missing requirement mapping")
    for i in range(1, 28):
        require(f"MOS-{i:03d}" in backlog, "Missing backlog ID")
    checks.append("20 requirements and 27 backlog IDs present")
    for check in checks:
        print("PASS", check)
    print(f"{len(checks)} checks passed. App/platform/encryption evidence remains pending.")
    return {"status": "passed", "checks": checks, "limitations": "Restricted fixture checks only; no app, encryption or platform verification."}


if __name__ == "__main__":
    main()
