//
//  KeyChainService.swift
//  NewsLetter
//
//  Created by 유지은 on 2021/02/03.
//

import Foundation
import Security

// Constant Identifiers
let userAccount = "AuthenticatedUser"
let accessGroup = "SecuritySerivice"

let kSecClassValue = String(kSecClass)
let kSecAttrAccountValue = String(kSecAttrAccount)
let kSecValueDataValue = String(kSecValueData)
let kSecClassGenericPasswordValue = String(kSecClassGenericPassword)
let kSecAttrServiceValue = String(kSecAttrService)
let kSecMatchLimitValue = String(kSecMatchLimit)
let kSecReturnDataValue = String(kSecReturnData)
let kSecMatchLimitOneValue = String(kSecMatchLimitOne)
let kSecAttrAccessibleValue = String(kSecAttrAccessible)
let kSecAttrAccessGroupValue = String(kSecAttrAccessGroup)
let kSecReturnAttributesValue = String(kSecReturnAttributes)

public class KeychainService {
    public static let shared = KeychainService()
    private init() {}

    /**
     * Internal methods for querying the keychain.
     */
    public func save(_ key: String, _ value: String, _ group: String? = nil) {
        var keychainQuery = self.getKeychainQuery(key, group)

        self.delete(key, group)

        keychainQuery[kSecValueDataValue] = NSKeyedArchiver.archivedData(withRootObject: value)

        let status: OSStatus = SecItemAdd(keychainQuery as CFDictionary, nil)

        if status != errSecSuccess {
            print("write failed: \(status)")
        }
        else {
//            print("KeychainManager: Successfully write data")
        }
    }

    public func load(_ key: String, _ group: String? = nil) -> String? {
        var keychainQuery = self.getKeychainQuery(key, group)

        keychainQuery[kSecReturnDataValue] = kCFBooleanTrue
        keychainQuery[kSecMatchLimitValue] = kSecMatchLimitOne

        var result: AnyObject?
        let status: OSStatus = SecItemCopyMatching(keychainQuery as CFDictionary, &result)

        guard status == errSecSuccess else { print("Nothing was retrieved from the keychain. Status code \(status)"); return nil }
        guard let resultData = result as? Data else { print("Load failed: \(status)"); return nil }
        guard let value = NSKeyedUnarchiver.unarchiveObject(with: resultData) as? String else { return nil }

//        print("Load key: \(key), value : \(value)")
        return value
    }

    // MARK: -- unuse
    public func update(_ key: String, _ value: String, _ group: String? = nil) {
        guard let valueData = value.data(using: .utf8, allowLossyConversion: false) else {
            print("Update failed")
            return
        }

        let updateQuery: [String: Any] = [
            kSecClassValue: kSecClassGenericPassword,
            kSecAttrAccountValue: key
        ]

        let updateAttributes: [String: Any] = [
            kSecValueDataValue: valueData
        ]

        if SecItemCopyMatching(updateQuery as CFDictionary, nil) == noErr {
            let status = SecItemUpdate(updateQuery as CFDictionary, updateAttributes as CFDictionary)
            if status != errSecSuccess {
                print("Update failed: \(status)")
            }
            else {
//                print("KeychainManager: Successfully updated data")
            }
        }
    }

    public func delete(_ key: String, _ group: String? = nil) {
        let keychainQuery = self.getKeychainQuery(key, group)

        let status = SecItemDelete(keychainQuery as CFDictionary)
        if status != errSecSuccess {
            print("Delete failed: \(status)")
        }
        else {
//            print("KeychainManager: Successfully Delete data")
        }
    }

    public func getKeychainQuery(_ key: String, _ group: String? = nil) -> [String: Any] {
        var keychainQuery: [String: Any] = [
            kSecClassValue: kSecClassGenericPassword,
            kSecAttrServiceValue: key,
            kSecAttrAccountValue: key,
            kSecAttrAccessibleValue: kSecAttrAccessibleAfterFirstUnlock
        ]

        if let group = group {
            keychainQuery[kSecAttrAccessGroupValue] = self.getFullAppleIdentifier(group)
        }

        return keychainQuery
    }

    public func getFullAppleIdentifier(_ bundleIdentifier: String) -> String {
        let bundleSeedIdentifier = self.getBundleSeedIdentifier()
        let bundleIdentifier = "\(bundleSeedIdentifier).\(bundleIdentifier)"
        return bundleIdentifier
    }

    public func getBundleSeedIdentifier() -> String {
        let query: [String: Any] = [
            kSecClassValue: kSecClassGenericPassword,
            kSecAttrAccountValue: "bundleSeedID",
            kSecAttrServiceValue: "",
            kSecReturnAttributesValue: kCFBooleanTrue as Any
        ]

        var result: AnyObject?
        var status: OSStatus = SecItemCopyMatching(query as CFDictionary, &result)

        if status == errSecItemNotFound {
            status = SecItemAdd(query as CFDictionary, &result)
        }

        var bundleSeedID: String = ""
        if status == errSecSuccess {
            guard let resultDic = result as? [String: Any] else { return "" }
            guard let accessGroup = resultDic[kSecAttrAccessGroupValue] as? String else { return "" }
            let components = accessGroup.components(separatedBy: ".")

            for str in components {
                bundleSeedID += str
            }
        }

        return bundleSeedID
    }

}
