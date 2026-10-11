# MOS-002 — Preliminary platform capability matrix

October 2, 2026. Source/toolchain evidence from
[repository inventory](repository-inventory.md). This matrix records capability
evidence and unknowns; GitHub Issues owns task status.

Owner direction (October 2, D-008/D-009): v0.1.1 is the protected Mac foundation;
initial OS validation targets are macOS 27 and iOS/iPadOS 27. Actual hardware/RAM
and second-device recovery availability remain unknown. OS 27 is owner-specified,
not independent verification of installed phone/tablet OS or stable release status.
Older OS support follows core-guarantee and optional-capability testing; package
minimum declarations are not acceptance evidence. No deployment minimum changed.

| Capability | Verified locally | Still required |
|---|---|---|
| Mac toolchain | Xcode 27.0 / 27A266a; Swift 6.4; arm64 target | Owner Mac model, RAM and supported OS range |
| Mac application | SwiftPM Mac demo builds; macOS 14 manifest minimum | Signed native target, entitlements, sandbox/SSD access and actual minimum-OS validation |
| iPhone/iPad | iOS 17 package declaration only | Actual models/OS, native targets, simulator/device builds and permission tests |
| Local OCR | Vision adapter; en-US configured; two current test failures | Reverify execution environment; orientation, unreadable/format and language fixtures |
| Manual/exact fallback | Session review and substring search tested | Durable scoped search and complete unavailable-provider UX |
| Text inference | No adapter or dependency | SDK/device availability check; bounded structured output and evaluation |
| Embeddings | No adapter or dependency | Independently select candidate/version/license; no embedding capability inferred from text-model availability |
| Encrypted storage | No adapter or dependency | SQLCipher packaging/version/license spike, actual target build, journal/temp/source protection evidence |
| Recovery | No implementation | Reviewed authenticated format/key lifecycle; second device independent of original Keychain |
| Extension staging | No extension target | Validated staging-only protection or explicit unlock-required fallback |

Do not promise supported models/OS based on compilation declarations. No
dependency versions, signing identifiers or hardware characteristics are invented.
Candidate package/license research and installation are separate steps; installing
anything still requires explicit authorization. No model downloads are necessary
to begin the domain/policy work.
