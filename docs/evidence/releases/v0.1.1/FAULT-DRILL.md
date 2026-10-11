# v0.1.1 remaining fault verification — proposed bounded drill

October11,2026. Prepared for review; NOT EXECUTED, no passing gate claimed.

## Agent-executable portion after explicit boundary authorization

Create one uniquely named64MiB disposable HFS+ disk-image file beneath repository
`.verification/os-faults/`, mount only that image at a fresh UUID child of
`.verification/recovery-process/`. Do not enumerate or mount existing disks, touch
owner vault profiles, change permissions, or use personal files. No forced detach.

1. Run existing fixed-key synthetic recovery creator on the generated volume.
2. Fill only that volume with a generated filler file until OS reports ENOSPC28.
3. Run a fresh synthetic receipt attempt and record bounded sanitized failure;
   no successful receipt may be claimed. Capture current memory metric for this
   small fault process only, not maximum app/OCR/preview memory.
4. Remove only this drill's filler, verify prior generated backup/source content
   with existing fixed-key verifier, and record recovery outcome.
5. Close all drill processes; detach only the generated image. If detach fails,
   leave artifacts identified rather than force-detaching or touching real SSD.

This provides real OSENOSPC on an artificial volume, not physical SSD unplug proof
or APFS-specific production acceptance. A separate generated largest-supported
PNG/JPEG receipt/OCR/preview measurement is still needed for peak-memory acceptance;
no numeric acceptance threshold or global memory-bound proof is invented here.

## Human/environment portion

Physical SSD disappearance while vault is open must hide content and fail without
fallback, then recover durable state after reattachment. Run only after closing
unrelated work, with invented fixtures and a dedicated test directory. Agent must
not unmount the owner's actualSSD. Capture sanitized status, not images/text/keys.

Signed authentication/system/idle-lock and clean-macOS-user recovery remain the
five-case final native review in INSPECTION-v0.1.1.md. Original Keychain must be
absent from independent recovery environment; synthetic fake custody/processes
are supporting evidence, not a substitute.

## Authorization boundary

Actual image mounting creates OS device/mount state outside repository files.
AGENTS.md requires explicit approval for access outside this repository. The
existing instruction not to mount theSSD remains in force. Request authorization
for this specific artificial-volume drill before running it; keep physicalSSD
and credentials outside agent access.
