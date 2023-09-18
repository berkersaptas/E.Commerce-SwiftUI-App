//
//  AppStorageManager.swift
//  FluxStore
//
//  Created by Berker Saptas on 16.09.2023.
//

import SwiftUI


enum StorageKeys: String {
    case introIsSeen = "introIsSeen"
}

class AppStorageManager: ObservableObject {
    
    @AppStorage(StorageKeys.introIsSeen.rawValue) var intro : Bool = false
    // Diğer @AppStorage özelliklerini burada tanımlanacak
    
    func saveAppStorage(storageKey: StorageKeys, value: Bool) {
        switch storageKey {
        case .introIsSeen:
            intro = value
            // Diğer anahtarlar için gerekli işlemleri burada yapabilirsiniz
        }
    }
    
    func readAppStorage(storageKey: StorageKeys) -> Bool {
        switch storageKey {
        case .introIsSeen:
            return intro
            // Diğer anahtarlar için gerekli işlemleri burada yapabilirsiniz
        }
    }
}
