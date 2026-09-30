# Synthetic Mac demo testing

This is an early in-memory demo, not the complete app. Automated tests use only
synthetic data. The user may also select individual authorized personal test
images locally; do not share those images or extracted text with agents.

## Launch

From the repository, run `swift run MosaicDemo`. Alternatively, open
`Package.swift` in Xcode, select the MosaicDemo scheme and My Mac, and press Run.

## Checklist

1. Click **Load synthetic sample**. Wait for OCR to complete; first recognition
   can take longer. Expect text containing `MOSAIC`, `TRAIN`, and `1900`.
2. Before approval, search for `train`. Expect **No reviewed matches**.
3. Click **Approve record**. Search for `train 1900`. Expect the recognized text.
4. Load another sample. Enable **Use my corrected text** and replace the text
   with `SYNTHETIC TRAIN 2000`. Approve. Search `2000`: expect a match. Search
   `1900`: expect no match. The original OCR observation should remain visible.
5. Enter a blank search. Expect **Enter a search term**.
6. Load again and approve an explicitly empty correction. Search `train`: expect
   no match. Closing the app discards all records. Earlier approved copies may still match; discard those before testing an empty correction.

Report which step failed, the expected versus actual behavior, and any layout
issues. Do not include personal screenshots, text, or data in reports.

## Current verification

The executable compiled on macOS with Xcode 27.0 / Swift 6.4. All seven synthetic
core/OCR/library tests passed. GUI launch, layout, and interactive behavior have not yet
been manually verified. iPhone and iPad UI are not available.

## Testing your own image

Restart the updated demo and click **Choose test image…**. Select one PNG, JPEG,
HEIC, or TIFF you authorize for local testing. Review and optionally correct the
OCR, then approve and search as above. **Discard selected record** removes only the
selected image and record from app state; it does not delete the original file.
Picker cancellation should leave the current record intact. An unreadable image
should show a generic error without its filename or contents.

Multiple records are supported within the current session. There is no app persistence, upload, logging of
contents, or Photos-library scanning. This is not a sandboxed production vault,
and clearing state is not a guarantee of secure memory erasure. Keep bug reports
to the step, file format, and behavior; reproduce content-specific issues using
invented text. File-picker interactions and real-image OCR are user tests, not
agent-verified results. Large images, image orientation, and complex layouts
remain unverified.

## Keyboard regression check

Quit any previously running demo and restart with `swift run MosaicDemo`.
Load the generated sample, approve it, click the search field and replace `train`
with `1900`. Verify typing, Backspace, and Command-A work. Then choose an
authorized image: the query should start empty. After approval, type a term
visible in its OCR result and confirm it matches. Also verify the correction
editor accepts typing before approval. Record whether the focus fix works;
its successful compilation alone does not verify keyboard interaction.

## Multi-record regression check

1. Load the generated sample, approve it, and confirm `train 1900` matches.
2. Load another generated sample, correct it to `SYNTHETIC FERRY 2200`, and
   approve it. Search `train 1900`, then `ferry 2200`: both should match.
3. Load a third image without approval. Verify it appears in Review Inbox and
   older approved records still match. Open the pending record from the inbox.
4. Approve or discard it; check the inbox count and earlier search results.
5. Open a result to check its original image and OCR. Discard that selected record
   and verify other results remain. Closing the app still discards the session.

Approve corrections before switching records; unsaved editor drafts are not
retained when navigating away. Multi-record GUI behavior awaits user verification.
