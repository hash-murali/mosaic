# User journeys and acceptance scenarios

All examples are synthetic. They specify observable behavior, not a promise of perfect extraction.

## J01 Recommendation list

Given a readable image saying “Read later: Sky Archive; River Pilgrim”, when imported, Mosaic retains the source, extracts both candidate titles and offers review. The owner corrects one title, adds both to Reading and sets Interested. Reprocessing preserves the correction. A duplicate import returns the existing capture; a different crop remains a separate source unless the owner chooses otherwise. R01 R02 R04 R10 R12.

## J02 College announcement

Given a source saying “Registration opens October 12” with no year, Mosaic stores a claim and a candidate date. It must not create a reminder. The owner selects year, time, timezone and confirms. Notification permission denial keeps the confirmed item visible in Review. The source's capture date does not supply the missing year silently. R11 R12.

## J03 Immigration claim

Given two synthetic posts making conflicting reporting statements, each is stored as an unverified captured claim. A possible conflict may be surfaced with both sources and the explanation “These saved claims may differ.” Mosaic does not choose a current legal rule or equate repeated posts with reliable evidence. Ask reports the saved statements and their unverified status. R13 R15.

## J04 Forgotten interest

Given several distinct saved sources mentioning Sky Archive and no Completed state, Review explains the repeated interest and offers Keep, Later or Dismiss. Completed entities are excluded from unresolved-interest prompts. Snooze is reversible and dismissal does not delete source evidence. R10 R13 R14.

## J05 Ask saved memory

Given a question “Which reading titles have I saved repeatedly?”, retrieval filters the unlocked vault and counts confirmed mentions. The answer links to evidence. With no matches or unavailable model, show results/insufficient evidence rather than invent titles. R05 R13 R15.

## J06 Reuse in another project

The owner selects two Reading entities and approves title/type/user status for a named destination. Preview excludes claim text, private notes and source images unless selected. The encrypted export contains a versioned manifest and minimal provenance identifiers. Revoking a future grant does not recall already exported bytes. R16 R17.

## J07 Recovery and transfer

Given a backup and the recovery credential, restore verifies authentication, hashes, schema compatibility and references in a new location before activation. Existing destination data is never overwritten implicitly. Imported snapshot becomes a separate local vault instance; edits do not sync back. Wrong credential or corruption leaves existing data unchanged. R07 R20.

## J08 Failure and privacy

When the Mac vault SSD disconnects during import, writes stop, accepted jobs remain discoverable after reconnection and no internal fallback vault is created. Lock closes sensitive screens and pauses jobs; in-app caches are cleared and reminders display generic text by default. R06 R19.

## Review sessions

Observe owner plus consenting beta testers complete J01–J08 using synthetic fixtures first. Record completion, intervention, errors and misunderstanding. Four of five independently observed sessions should complete core journeys without developer coaching before beta approval; do not extrapolate that sample into a universal usability guarantee.
