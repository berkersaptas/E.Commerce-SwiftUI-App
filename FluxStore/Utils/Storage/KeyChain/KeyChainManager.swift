//
//  KeyChainManager.swift
//  FluxStore
//
//  Created by Berker Saptas on 17.09.2023.
//

import SwiftUI
import Security



protocol KeyChainStorageProtocol {
    var attributes : [String: Any]? {get}
    var query : [String: Any]? {get}
    func setData() -> Bool
    func getData() -> String?
}

enum KeyChainStorageName: String {
    case userName = "FluxStoreUserName"
    case password = "FluxStorePassword"
}

enum KeyChainStorage {
    case setUserName(userName : String)
    case getUserName
    case setPassword(password : String)
    case getPassword
}


extension KeyChainStorage : KeyChainStorageProtocol{
    
    var attributes: [String : Any]? {
        
        if case .setUserName(let username) = self {
            return [
                kSecClass as String: kSecClassGenericPassword,
                kSecAttrService as String: KeyChainStorageName.userName.rawValue,
                kSecAttrAccount as String: KeyChainStorageName.userName.rawValue,
                kSecValueData as String: Data(username.utf8)
            ]
        }
        
        if case .setPassword(let password) = self {
            return [
                kSecClass as String: kSecClassGenericPassword,
                kSecAttrService as String: KeyChainStorageName.password.rawValue,
                kSecAttrAccount as String: KeyChainStorageName.password.rawValue,
                kSecValueData as String: Data(password.utf8)
            ]
        }
        
        else {
            return nil
        }
    }
    
    var query: [String : Any]? {
        
        if case .setUserName(_) = self {
            return [
                kSecClass as String: kSecClassGenericPassword,
                kSecAttrService as String: KeyChainStorageName.userName.rawValue
            ]
        }
        
        if  case .getUserName = self {
            return [
                kSecClass as String: kSecClassGenericPassword,
                kSecAttrService as String: KeyChainStorageName.userName.rawValue,
                kSecReturnData as String: true,
                kSecMatchLimit as String: kSecMatchLimitOne
            ]
        }
        
        if case .setPassword(_) = self {
            return [
                kSecClass as String: kSecClassGenericPassword,
                kSecAttrService as String: KeyChainStorageName.password.rawValue
            ]
        }
        
        if  case .getPassword = self {
            return [
                kSecClass as String: kSecClassGenericPassword,
                kSecAttrService as String: KeyChainStorageName.password.rawValue,
                kSecReturnData as String: true,
                kSecMatchLimit as String: kSecMatchLimitOne
            ]
        }
        return nil
    }
    
    func setData() -> Bool {
        
        SecItemDelete(query! as CFDictionary)
                
        let status = SecItemAdd(attributes! as CFDictionary, nil)
               
        if status == errSecSuccess {
            return true
        } else {
            return false
        }
        
    }
    
    func getData() -> String? {
        
        var data: AnyObject?
        let status = SecItemCopyMatching(query! as CFDictionary, &data)
        
        if status == errSecSuccess {
            if let data = data as? Data,
               let result = String(data: data, encoding: .utf8) {
                return result
            }
        }
        return nil
        
    }
    
}

