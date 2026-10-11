# Glossary and technical references

Capture is an intake event/source record. Artifact is the retained original. Observation is extracted source text/layout. Entity is a canonical item. Claim is an assertion found in a source, not verified truth. Action is a suggested or owner-confirmed task. Insight is a derived finding with evidence. Vault is a content/key boundary. Grant is scoped authority. Snapshot is recovery/transfer, not live sync. ADR is a recorded architecture decision. PRD is product requirements. Gate is evidence required for release.

## Primary technical references

Platform facts should be verified against selected SDK and implementation. These references informed architecture constraints; they do not prove the planned app works.

- [Apple Foundation Models tasks and availability](https://developer.apple.com/documentation/foundationmodels/generating-content-and-performing-tasks-with-foundation-models)
- [Apple on-device text model](https://developer.apple.com/documentation/foundationmodels/systemlanguagemodel)
- [Apple background strategies](https://developer.apple.com/documentation/backgroundtasks/choosing-background-strategies-for-your-app)
- [Apple Photos cloud/local identifier mapping](https://developer.apple.com/documentation/photos/phcloudidentifier)
- [Apple Keychain services](https://developer.apple.com/documentation/security/keychain-services)
- [Apple storing CryptoKit keys](https://developer.apple.com/documentation/cryptokit/storing-cryptokit-keys-in-the-keychain)
- [Apple app groups](https://developer.apple.com/documentation/xcode/configuring-app-groups)
- [Apple macOS sandbox file access](https://developer.apple.com/documentation/security/accessing-files-from-the-macos-app-sandbox)
- [SQLCipher official overview](https://www.zetetic.net/sqlcipher/)
- [SQLite FTS5](https://www.sqlite.org/fts5.html)
- [SQLite foreign keys](https://www.sqlite.org/foreignkeys.html)

Source review date 2026-10-02. Availability, packaging and entitlements depend on actual platform versions. Record exact dependency versions/license in MOS-002/003 before shipping. Documentation is a design input, not a security audit.
