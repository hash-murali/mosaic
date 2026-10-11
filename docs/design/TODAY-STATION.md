# Today — turn saved information into useful action

October 4, 2026. Proposed design for the v0.2.0 daily-use outcome; automated
local action suggestions belong to the v0.3.0 intelligence outcome. Optional
Calendar/Reminders integration scope and scheduling ownership remain undecided.
The human requested the reminder-station direction; this exact flow is proposed.

## A place for commitments

Library answers “What did I keep?” Today answers “What do I want to act on?”
Rediscover answers “What might be worth another look?” Keep these meanings
distinct. Saving a screenshot does not imply an action, deadline or notification.

Proposed station sections:

| Section | Meaning | Available actions |
|---|---|---|
| Today / overdue | Explicitly confirmed actions due now or overdue | Complete, later, open evidence |
| Coming up | Confirmed future dates | Reschedule, open evidence |
| Someday | Explicit user intention without a date | Set date, keep unscheduled, drop |
| Completed | History of actual user completion | Inspect; reopen if supported |

Example using fictional content: open “A very good bowl of noodles” →
“Plan to cook” → choose Saturday at 18:00 and a timezone → confirm → Today
shows “Cook sesame noodles,” linked to that source. A fictional event flyer
instead offers an event candidate; a reading quote need not become a task.
Use a quieter row layout and the same sage surfaces, serif section heading,
system body text and generous spacing as Library.

## Confirmation and evidence

Source date expressions stay observations. Suggested interpretations remain
unconfirmed. User confirms title, absolute date, time when needed, timezone,
all-day semantics, notification preference and destination. Yearless, relative
or conflicting dates require resolution; never schedule from screenshot OCR
alone. The action links to its source and retains interpretation/correction
separation. Permit a manually created action without local AI.

Do not infer that a saved claim or deadline is correct in the real world. A
high-impact claim requires especially clear evidence and unresolved-date states.
Generic lock-screen notification copy: “A saved item needs review.” Showing
source titles/snippets on the lock screen requires a separate user preference.

## Integration proposal

Start with durable in-app actions and explicitly enabled local notifications.
Then offer per-action “Add to Calendar” for time-bound events and “Add to
Reminders” for tasks. Do not require external integration to use Today.

Apple supports native event/reminder creation through EventKit. Calendar offers
write-only access and, on supported platforms, user-presented EventKitUI paths;
Reminders uses full-access authorization. Choose the narrowest suitable platform
path after capability testing. No permission has been requested or granted by
this design document.

Primary references:
[Accessing the event store](https://developer.apple.com/documentation/eventkit/accessing-the-event-store),
[Calendar and EventKitUI](https://developer.apple.com/documentation/eventkit/accessing-calendar-using-eventkit-and-eventkitui),
[Reminder authorization](https://developer.apple.com/documentation/eventkit/ekeventstore/requestfullaccesstoreminders(completion:)).

External insertion is an explicit export: preview the exact title, date and notes
being copied and destination list/calendar. Include minimal text; omit screenshot,
OCR and sensitive snippets by default. The destination account may sync through
its provider, so “local-first Mosaic” cannot imply this exported copy stays local.
This optional export revises no vault-sync policy. Do not scan existing calendars
or reminder contents simply to populate Mosaic. Selected exports need their own
authorization and integration boundaries.

One-way handoff is the initial recommendation, not bidirectional synchronization.
An exported item should read “Added to Calendar/Reminders,” never “Synced” without
working reconciliation. External completion is not known from export alone.
Decide whether Mosaic or the destination owns notifications so the same action
does not produce duplicate alerts. Edit/delete in one location must not silently
alter the other. Explain independent-copy behavior and explicitly offer future
update operations only when implemented.

## Domain and service additions needed

Action identity, source/record links, user title, candidate/confirmed date,
timezone/all-day semantics, due/unscheduled/completed/dropped state, notification
consent and scheduling ownership. Separate action state from OCR review state.
Store integration destination/reference and last attempted/succeeded export
state without treating that reference as reliable sync evidence.

Use scoped authorized services for create/update/complete/schedule/export;
the view must not access EventKit or vault storage directly. Calendar authorization
does not grant Mosaic vault access, and vice versa. Scheduling, lock-state cache
behavior, notification cancellation and export retry semantics require separate
implementation contracts. Protected persistence is a dependency for reliable
reminders; a page-memory demo cannot supply them.

## Required adverse states and acceptance

- Notifications denied: Today remains useful; never claim an alert is scheduled.
- Calendar/Reminders denied or revoked: preserve the internal action, show the
  export failure, offer manual alternatives without repeated permission prompts.
- Ambiguous date/timezone or daylight-saving transition: require a concrete
  valid interpretation before scheduling.
- Double click/retry: no duplicate action/export; uncertain external completion
  requires reconciliation before retry rather than blind insertion.
- Locked/unavailable vault: conceal content and avoid scheduling from stale data;
  define existing generic-notification behavior before implementation.
- Restore: imported action candidates stay unscheduled until owner confirmation.
- Completed, dropped or rescheduled action: cancel obsolete Mosaic alerts when
  implemented; external copies follow the explicit integration contract.

Validate with synthetic data: create → confirm → Today → later → complete;
unconfirmed date never schedules; timezone/all-day behavior; denial/revocation;
generic notification content; duplicate prevention; restart/restore consistency;
lock state; manual flow without a model. No scheduling tests have run: this is
a design specification, not an implemented reminder station.
