#if canImport(LocalAuthentication) && canImport(Security)
import Foundation
import LocalAuthentication
import Security

/// Only the app owner invokes this adapter. Automated tests use injected fake
/// custody; agents never read/write the human's Keychain or authentication state.
@MainActor public final class AppleVaultKeyCustody: VaultKeyCustody {
    private final class Context: @unchecked Sendable {
        // LAContext supports invalidation of an outstanding authentication.
        let value = LAContext()
    }
    private var active: Context?
    private var generation = UUID()
    private let service: String
    public init(service: String = "org.mosaic.synthetic.foundation.v1") { self.service = service }

    public func cancel() async {
        generation = UUID()
        active?.value.invalidate()
        active = nil
    }
    private func authenticate() async throws -> (Context, UUID) {
        try Self.requireNativeApp(bundleURL: Bundle.main.bundleURL)
        active?.value.invalidate()
        let context = Context(), ticket = UUID()
        active = context
        generation = ticket
        context.value.touchIDAuthenticationAllowableReuseDuration = 0
        guard context.value.canEvaluatePolicy(.deviceOwnerAuthentication, error: nil) else {
            throw SessionFailure.authenticationUnavailable
        }
        do {
            let success = try await withTaskCancellationHandler {
                try await context.value.evaluatePolicy(.deviceOwnerAuthentication,
                    localizedReason: "Unlock your synthetic Mosaic test vault")
            } onCancel: { context.value.invalidate() }
            guard success, generation == ticket, !Task.isCancelled else { throw SessionFailure.cancelled }
            return (context, ticket)
        } catch {
            context.value.invalidate()
            if generation != ticket || Task.isCancelled { throw SessionFailure.cancelled }
            throw SessionFailure.authenticationDenied
        }
    }
    public func create(vaultID: UUID) async throws -> Data {
        let (context, ticket) = try await authenticate()
        defer {
            context.value.invalidate()
            if generation == ticket { active = nil }
        }
        let service = service
        let key = try await Task.detached {
            var bytes = Data(count: 32)
            guard bytes.withUnsafeMutableBytes({ SecRandomCopyBytes(kSecRandomDefault, 32, $0.baseAddress!) }) == errSecSuccess else {
                throw SessionFailure.keyUnavailable
            }
            guard let access = SecAccessControlCreateWithFlags(nil,
                kSecAttrAccessibleWhenUnlockedThisDeviceOnly, .userPresence, nil) else {
                throw SessionFailure.keyUnavailable
            }
            let query: [String: Any] = [
                kSecClass as String: kSecClassGenericPassword,
                kSecAttrService as String: service,
                kSecAttrAccount as String: vaultID.uuidString,
                kSecAttrAccessControl as String: access,
                kSecAttrSynchronizable as String: false,
                kSecUseDataProtectionKeychain as String: true,
                kSecValueData as String: bytes
            ]
            let result = SecItemAdd(query as CFDictionary, nil)
            if result == errSecDuplicateItem {
                // Resume interrupted setup; never replace an existing vault key.
                return try Self.read(vaultID: vaultID, service: service, context: context)
            }
            return try Self.validatedKey(status: result, data: bytes)
        }.value
        guard generation == ticket, !Task.isCancelled else { throw SessionFailure.cancelled }
        context.value.invalidate()
        active = nil
        return key
    }
    public func unlock(vaultID: UUID) async throws -> Data {
        let (context, ticket) = try await authenticate()
        defer {
            context.value.invalidate()
            if generation == ticket { active = nil }
        }
        let service = service
        let key = try await Task.detached {
            try Self.read(vaultID: vaultID, service: service, context: context)
        }.value
        guard generation == ticket, !Task.isCancelled else { throw SessionFailure.cancelled }
        context.value.invalidate()
        active = nil
        return key
    }
    /// An app bundle is necessary, not proof that signing/entitlements are valid.
    nonisolated static func requireNativeApp(bundleURL: URL) throws {
        guard bundleURL.isFileURL, bundleURL.pathExtension == "app" else { throw SessionFailure.nativeAppRequired }
    }
    /// Fixed codes only: no query, account, key, or raw platform error is logged.
    nonisolated static func validatedKey(status: OSStatus, data: Data?) throws -> Data {
        switch status {
        case errSecSuccess: break
        case errSecItemNotFound: throw SessionFailure.keyNotFound
        case errSecMissingEntitlement: throw SessionFailure.keySigningUnavailable
        case errSecAuthFailed: throw SessionFailure.keyAccessDenied
        case errSecInteractionNotAllowed: throw SessionFailure.keyInteractionUnavailable
        default: throw SessionFailure.keyOperationFailed(status)
        }
        guard let data, data.count == 32 else { throw SessionFailure.invalidKeyMaterial }
        return data
    }
    nonisolated private static func read(vaultID: UUID, service: String, context: Context) throws -> Data {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: service,
            kSecAttrAccount as String: vaultID.uuidString,
            kSecAttrSynchronizable as String: false,
            kSecUseDataProtectionKeychain as String: true,
            kSecUseAuthenticationContext as String: context.value,
            kSecReturnData as String: true,
            kSecMatchLimit as String: kSecMatchLimitOne
        ]
        var result: CFTypeRef?
        let status = SecItemCopyMatching(query as CFDictionary, &result)
        return try validatedKey(status: status, data: result as? Data)
    }
}
#endif
