# Operations recovery and support runbooks

Beta is a local app. Operations means safe releases, data recovery, private diagnostics and honest support; no production service fleet exists yet.

## Suspected exposure

Stop affected export/inference feature; retain minimal redacted event IDs/build version; determine whether data actually crossed a boundary; revoke future grants/tokens if applicable; fix and validate with synthetic reproducer; record impact/owner decision and communication obligations appropriate to actual deployment. Do not upload the vault for debugging. Released plaintext copies cannot be recalled by revocation.

## Corrupt vault or failed migration

Stop writes and preserve the encrypted original. Verify last known-good snapshot and usable recovery material without logging it. Restore to a new location, validate and compare, then let owner activate. Never apply experimental repair directly to sole original. Report failed schema/build and stable error code. Do not downgrade database format in place blindly.

## SSD missing

Pause jobs/close handles; show reconnect state. Resolve previously selected volume/vault identity rather than trusting a reused path name. On return validate expected vault and integrity before resuming. Do not create a replacement vault on internal disk or a different external volume silently.

## Key unavailable

Prompt supported authentication/recovery flow. If no keys or recovery material exist, explain data cannot be decrypted; no operator bypass promised. Never disable encryption to recover access. Device authentication failure differs from corrupt backup.

## Bad model revision

Disable affected provider/version using local feature configuration; keep OCR/manual/exact search; preserve previously accepted human data; append revised candidate results after evaluation rather than overwrite. Record model/prompt/schema/corpus versions and error pattern. Retest high-impact suite before re-enabling.

## Support bundle

Owner explicitly creates a bundle containing app/build/OS versions, capability availability, coarse timing, stable error codes and opaque event IDs. Exclude usernames, file paths, titles, OCR, notes, images, raw model prompts, keys/tokens and hashes that could identify content. Show preview. No automatic email/slack sending. User decides destination.

## Maintenance

Periodic bounded orphan sweep, index rebuild checks, audit retention cleanup and backup health reminders. Never delete last good backup automatically. Audit cleanup failures report status without dumping content. Public distribution later needs staffed support policy, incident communication, applicability/privacy review and longer reliability evidence.
