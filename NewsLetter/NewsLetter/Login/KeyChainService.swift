//
//  KeyChainService.swift
//  NewsLetter
//
//  Created by 유지은 on 2021/02/03.
//

import Foundation
import Security

// Constant Identifiers
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

    public func saveToken(token: String) {
        let key = "LOGIN_TOKEN" //이후에 const group으로 빼기
        KeychainService.shared.save(key, token)
    }

    public func loadToken() -> String? {
        let token = KeychainService.shared.load("LOGIN_TOKEN")
        return token
    }
    
    public func isTokenValidate() -> Bool {
        if let token = KeychainService.shared.load("LOGIN_TOKEN") {
            return true
        }
        else {
            return false
        }
    }
    
    public func deleteToken() {
        KeychainService.shared.delete("LOGIN_TOKEN")
    }

    public func save(_ key: String, _ value: String) {
        var keychainQuery = self.getKeychainQuery(key)

        self.delete(key)

        keychainQuery[kSecValueDataValue] = NSKeyedArchiver.archivedData(withRootObject: value)

        let status: OSStatus = SecItemAdd(keychainQuery as CFDictionary, nil)

        if status != errSecSuccess {
            print("write failed: \(status)")
        }
        else {
            print("write success")
        }
    }

    public func load(_ key: String) -> String? {
        var keychainQuery = self.getKeychainQuery(key)

        keychainQuery[kSecReturnDataValue] = kCFBooleanTrue //CFData의 형태로 리턴해라
        keychainQuery[kSecMatchLimitValue] = kSecMatchLimitOne //중복인 경우 하나의 값만 가져와라

        var result: AnyObject?
        let status: OSStatus = SecItemCopyMatching(keychainQuery as CFDictionary, &result)

        guard status == errSecSuccess else { print("Nothing was retrieved from the keychain. Status code \(status)"); return nil }
        guard let resultData = result as? Data else { print("Load failed: \(status)"); return nil }
        guard let value = NSKeyedUnarchiver.unarchiveObject(with: resultData) as? String else { return nil }

        return value
    }

    public func delete(_ key: String) {
        let keychainQuery = self.getKeychainQuery(key)

        let status = SecItemDelete(keychainQuery as CFDictionary)
        if status != errSecSuccess {
            print("Delete failed: \(status)")
        }
        else {
            print("Successfully Delete data")
        }
    }

    public func getKeychainQuery(_ key: String) -> [String: Any] {
        var keychainQuery: [String: Any] = [
            kSecClassValue: kSecClassGenericPassword,
            kSecAttrServiceValue: key,
            kSecAttrAccountValue: key,
            kSecAttrAccessibleValue: kSecAttrAccessibleAfterFirstUnlock
            //장치가 다시 시작된 후 잠금이 해제되었을 때 한번만 엑세스 가능.
            //백그라운드 앱에서 엑세스가 요구되는 항목에 대해 권장.
        ]

        return keychainQuery
    }
}
