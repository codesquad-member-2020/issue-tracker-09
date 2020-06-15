//
//  KeyChainItem.swift
//  IssueTracker
//
//  Created by 임승혁 on 2020/06/10.
//  Copyright © 2020 Cloud. All rights reserved.
//

import Foundation

enum KeychainError: Error {
    case noPassword
    case unexpectedPasswordData
    case unexpectedItemData
    case unhandledError
}

struct KeychainItem {
    
    // MARK: - Properties
    static var currentUserIdentifier: String {
        do {
            let storedIdentifier = try KeychainItem(service: KeychainItem.service,
                                                    account: KeychainItem.account).readItem()
            
            return storedIdentifier
        } catch {
            return ""
        }
    }
    static let service: String = "cLoud.IssueTracker.codesquad"
    static let account: String = "userIdentifier"
    private let service: String
    private let accessGroup: String?
    private var account: String
    
    // MARK: - LifeCycle
    init(service: String, account: String, accessGroup: String? = nil) {
        self.service = service
        self.account = account
        self.accessGroup = accessGroup
    }
    
    // MARK: - Methods
    static func deleteUserIdentifierFromKeychain() throws {
        try KeychainItem(service: KeychainItem.service,
                         account: KeychainItem.account).deleteItem()
    }
    
    private static func keychainQuery(withService service: String, account: String? = nil, accessGroup: String? = nil) -> [String: AnyObject] {
        var query = [String: AnyObject]()
        query[kSecClass as String] = kSecClassGenericPassword
        query[kSecAttrService as String] = service as AnyObject?
        if let account = account {
            query[kSecAttrAccount as String] = account as AnyObject?
        }
        if let accessGroup = accessGroup {
            query[kSecAttrAccessGroup as String] = accessGroup as AnyObject?
        }
        
        return query
    }
    
    func readItem() throws -> String {
        var query = KeychainItem.keychainQuery(withService: service,
                                               account: account,
                                               accessGroup: accessGroup)
        query[kSecMatchLimit as String] = kSecMatchLimitOne
        query[kSecReturnAttributes as String] = kCFBooleanTrue
        query[kSecReturnData as String] = kCFBooleanTrue
        var queryResult: AnyObject?
        let status = withUnsafeMutablePointer(to: &queryResult) {
            SecItemCopyMatching(query as CFDictionary,
                                UnsafeMutablePointer($0))
        }
        guard status != errSecItemNotFound else { throw KeychainError.noPassword }
        guard status == noErr else { throw KeychainError.unhandledError }
        guard let existingItem = queryResult as? [String: AnyObject],
            let passwordData = existingItem[kSecValueData as String] as? Data,
            let password = String(data: passwordData,
                                  encoding: String.Encoding.utf8)
            else { throw KeychainError.unexpectedPasswordData }
        
        return password
    }
    
    func saveItem(_ password: String) throws {
        guard let encodedPassword = password.data(using: .utf8) else { throw KeychainError.unexpectedPasswordData }
        do {
            try _ = readItem()
            var attributesToUpdate = [String: AnyObject]()
            attributesToUpdate[kSecValueData as String] = encodedPassword as AnyObject?
            let query = KeychainItem.keychainQuery(withService: service,
                                                   account: account,
                                                   accessGroup: accessGroup)
            let status = SecItemUpdate(query as CFDictionary, attributesToUpdate as CFDictionary)
            guard status == noErr else { throw KeychainError.unhandledError }
        } catch KeychainError.noPassword {
            var newItem = KeychainItem.keychainQuery(withService: service,
                                                     account: account,
                                                     accessGroup: accessGroup)
            newItem[kSecValueData as String] = encodedPassword as AnyObject?
            let status = SecItemAdd(newItem as CFDictionary, nil)
            guard status == noErr else { throw KeychainError.unhandledError }
        }
    }
    
    func deleteItem() throws {
        let query = KeychainItem.keychainQuery(withService: service,
                                               account: account,
                                               accessGroup: accessGroup)
        let status = SecItemDelete(query as CFDictionary)
        guard status == noErr || status == errSecItemNotFound else { throw KeychainError.unhandledError }
    }
}
