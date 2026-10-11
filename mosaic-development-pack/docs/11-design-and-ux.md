# Design and interaction specification

Stable design means predictable navigation, clear meaning, accessible actions and complete failure states. It does not require identical layouts across platforms. This specification precedes high-fidelity screens; pixel-level mockups require actual target sizing and usability feedback.

## Information architecture

| Destination | Purpose | Primary actions |
|---|---|---|
| Inbox | New captures and candidates | Confirm, edit, retry, archive |
| Library | Entities/captures by collection/status | Filter, open, change user status |
| Review | Forgotten interest and confirmed due items | Keep, later, dismiss, open evidence |
| Search | Exact results and optional Ask | Query, filter, inspect citations |
| Settings | Vault, privacy, recovery and storage | Lock, backup, export, permissions |

Phone uses five compact destinations; iPad/Mac sidebar with detail and keyboard focus. Source detail is an evidence panel reachable from every derived record. Ask is within Search, not a competing top-level chatbot. No graph visualization is required for beta; evidence cards and related lists are more useful initially.

## Initial token direction

Use native system typography and semantic colors; spacing steps 4/8/12/16/24/32 points. Reuse named tokens, not scattered constants. Follow platform accessibility contrast/focus conventions; labels never rely on color alone. Mobile actions aim for at least 44x44-point targets. Adapt to Dynamic Type rather than clip. Final token values are validated on real device layouts in MOS-016.

Capture card: title or neutral fallback, category candidate, processing/review state, received time and source preview. Record detail: user state, accepted knowledge, suggestions separately labeled, source evidence, history and related records. No invented confidence percentage. Users can correct category/title without filling a form. Common review/status action at most two interactions after opening record.

## Screen state matrix

| State | Required message/behavior |
|---|---|
| Empty | Explain one concrete next action, such as import |
| Receiving | Progress; not yet called saved |
| Saved/processing | Durable source retained, processing cancellable |
| Model unavailable | OCR/manual/search options remain; no cloud prompt by default |
| Permission denied/limited | Explain scope; offer explicit import/settings route |
| Locked | Conceal sources/snippets; offer unlock |
| SSD unavailable | Stop writes; reconnect/select existing vault; no automatic new vault |
| Low storage | Explain required cleanup/retry; preserve existing data |
| Failed OCR/extraction | Source intact; review manually or retry |
| Insufficient evidence | Show available records and absence of supported answer |
| Export | Fields/records/destination, omissions, irreversible-copy explanation |
| Restore | Verify first; choose new destination; no implicit replacement |

## Destructive and uncertain actions

Delete preview distinguishes capture evidence, shared entities, adopted actions and historical backups. Undo only where actually supported; do not display fake undo for destroyed original data. Merge shows impacted mentions and undo lineage. Candidate date asks for missing year/time/timezone. Notifications show generic “A saved item needs review” by default; lock-screen leakage is otherwise possible.

## Accessibility and validation

VoiceOver meaningful order and labels; Dynamic Type supported ranges; visible keyboard focus and Mac commands; contrast review; reduced-motion behavior; no mandatory swipe-only actions; alternatives to hover. Test offline/empty/error states alongside success screens. Observe J01–J08; record intervention and confusion. v0.4 core tasks pass without coaching in at least four of five observed sessions, with documented sample limits.
