import SQLCipher

/// No production vault is opened by this capability probe.
public enum StorageCapability {
    public static var sqliteVersion: String { String(cString: sqlite3_libversion()) }
}
