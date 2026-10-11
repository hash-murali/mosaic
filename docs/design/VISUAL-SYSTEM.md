# Mosaic visual system — POC-derived baseline

October 4, 2026. Target v0.1.1 onward. Human-approved visual direction;
exact tokens/native adaptation proposed. Reference: [product direction](PRODUCT-DIRECTION.md).

## Color roles

Extracted from the delivered POC stylesheet, not a rendered screenshot.

| Role | POC value | Native use |
|---|---|---|
| Canvas | `#F8F9F5` | Main quiet background |
| Sidebar | `#F0F2EB` | Secondary navigation surface |
| Card | `#FFFFFF` | Source cards and detail surface |
| Main ink | `#2E4333` | Primary text |
| Muted | `#84907C` | Secondary text candidate; contrast validation required |
| Separator | `#E3E7DC` | Decorative borders; not sole interactive boundary |
| Primary green | `#365A42` | Primary action / selected accent |
| Selected navigation | `#E0E8D9` | Selected surface paired with explicit selection label/state |
| Rediscovery surface | `#EDF1E5` | Gentle contextual feature surface |
| Focus | `#AA8247` | POC outline candidate; native focus behavior preferred |
| Collection dots | `#8BA17B`, `#D4AA85`, `#97AFB9`, `#B49AAC` | Decorative category cues paired with names |

Do not copy the POC's faint metadata as an accessibility standard. Validate
normal text at 4.5:1, large text at 3:1, meaningful nontext controls at 3:1;
darken semantic secondary text as needed while keeping surface colors.
Disabled, destructive, warning and error tokens need semantic definitions.
Dark mode is not designed yet; use explicit native semantic variants rather
than inverting the light values.

## Typography and spacing

- Editorial headings: Georgia in POC; native system serif is a candidate.
  POC main heading 44px desktop / 35px phone, regular weight. Use native
  scalable text styles, not a fixed-size reproduction.
- Functional UI: system sans-serif; normal weight body, medium selection/title.
  POC body/card text is visually small (roughly 10–14px). Native text must remain
  readable and support larger sizes; preserve hierarchy rather than small pixels.
- Eyebrows: sparing uppercase orientation labels; never the only meaningful label.
- Shared spacing ladder: 4, 8, 12, 16, 24, 32, 48 points. POC uses several
  intermediate values; consolidate in native named tokens.
- POC card radius 9px, search 9px, banner 10px, primary button 6px,
  detail dialog 15px. Native baseline: 8 / 12 / 16-point radius families.
- Borders: thin, quiet. Shadow: optional subtle elevation for hover/detail;
  do not require shadow to identify a card. Avoid gradients on application chrome.

## Component contracts

| Component | Anatomy | Required states |
|---|---|---|
| Capture card | Actual source preview, title/fallback, category state, received time, review status, optional favorite | Selected, focus, pending, processing, failed, image unavailable, locked |
| Search field | Search label, query, clear action, optional keyboard shortcut | Empty, typing, results, no matches, exact-only/model unavailable |
| Navigation item | Symbol, readable name, optional count, selected indication | Selected, focus; hide unavailable destinations or label preview |
| Collection row | Name, decorative color, optional count | Empty, selected, editable when implemented |
| Source detail | Evidence, accepted content, suggestions, correction, history when supported | Pending, approved, editing, failed extraction, locked |
| Action row | User-confirmed title/date, provenance link, completion/later | Due, upcoming, unscheduled, completed, external-export state |
| Rediscovery card | Source, reason, keep/later/dismiss | No candidates, snoozed, unavailable-model fallback |
| Primary action | One main action per task section | Enabled, busy, disabled with reason, failed, completed |

The favorite control must be a separate button from opening the card, with
its own accessible name and pressed state. Never nest interactive controls.
State labels must survive color blindness and low-contrast displays.

## Responsive and interaction translation

POC grid: four columns at wide desktop, three below 1180px, two below 900px;
sidebar becomes a top navigation below 650px. Native layout should select
columns by usable card width and text size, not copy browser breakpoints.
On Mac use navigation/detail surfaces and keyboard selection. On phone use
touch targets at least 44 points and let large type collapse to a readable list.

Retain the feel: generous margins, clear title, immediately reachable search,
one restrained discovery banner, content-led cards. Shorten the POC's greeting
heading after first use if it competes with work. Today should use compact rows
for commitments instead of a decorative grid of deadlines.

Motion: subtle hover in POC; no essential hover-only controls. Honor reduced
motion. Keyboard: search shortcut, logical traversal, visible focus, Escape
for dismissible detail, focus return to the opener. Native symbols replace
POC Unicode icon approximations; screen-reader labels describe the action.

## Design QA required before native acceptance

Check light and later dark tokens; VoiceOver reading order; Dynamic Type;
keyboard-only Library → detail → correction → approval → search; touch sizing;
long titles/categories; empty OCR; no source preview; unavailable SSD; locked
vault; failed save; denied notifications; no model. Capture only synthetic
fixtures in design screenshots and bugs. Current POC has no verified contrast,
screen-reader, native-device or responsive-render evidence.
