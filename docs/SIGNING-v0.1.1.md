## October11 launcher clarification

Open **MosaicNative.xcodeproj** (the Xcode project), select **MosaicNative** next
to Run/Stop and **My Mac**, then build/run. The app product is **Mosaic**.
**MosaicDemo** is the SwiftPM package executable and is not the supported protected
Keychain launch. Current guard reports this before asking for authentication.
Native bundle presence is necessary, not proof of valid signing/entitlements.

59 synthetic tests and unsigned native build/probes pass at launch-67/68. Owner
unlock failure while running MosaicDemo does not establish a successful native
attempt. One focused native unlock check remains; report only fixed error word.
No vault reset, Keychain deletion, team change or protective fallback is instructed.

# v0.1.1 synthetic native signing handoff

October 8, 2026. Owner reports signing cannot be configured yet. Native protected
Keychain acceptance remains PENDING; an unsigned build is compile evidence only.
No account, certificate, profile or real Keychain item was inspected by the agent.

When ready, the owner can perform these steps locally:

1. Open MosaicNative.xcodeproj in Xcode. Use the MosaicNative scheme and Mac target.
2. Add the owner's Apple Account under Xcode Settings → Accounts. Select an
   available team under target Signing & Capabilities, using automatic signing.
3. Let Xcode check signing/provisioning for the existing application-identifier
   and keychain-access-groups entitlements. Do not remove protection requirements
   to obtain a successful build. No cloud/sync capability is required.
4. Build and run the signed native app. Use only the main workspace's generated sample, not personal images or databases. Use the one final RC1–RC5 batch in the inspection sheet when the
   release candidate is ready; historical K checks are not repeat-build homework. Record the signed build identity and observed results.
5. If signing is blocked, report only a sanitized Xcode diagnostic code/message
   with account/team identifiers removed. Do not share keys, passwords, profiles,
   certificate exports or screenshots containing account details.

Apple documents [Personal Teams for non-members](https://help.apple.com/xcode/mac/current/en.lproj/dev60b6fbbc7.html)
and [provisioning authorization for protected Mac Keychain entitlements](https://developer.apple.com/documentation/technotes/tn3137-on-mac-keychains).
The exact Mac target's Personal Team capability still needs verification; paid
membership is not assumed required. Account setup is an owner action and does not
itself pass authentication, cancellation, lock or recovery acceptance.

The agent must not run security find-identity, enumerate the owner's Keychain,
export profiles, install certificates, sign with private keys or enable automatic
provisioning updates without specific authorization. Existing offline synthetic
checks can continue independently. No stable tag/release is authorized by signing
setup or by this handoff document.
