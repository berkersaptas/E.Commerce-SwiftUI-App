//
//  LoginModel.swift
//  FluxStore
//
//  Created by Berker Saptas on 17.09.2023.
//

import Foundation

// MARK: - LoginModel
struct LoginModel: Codable {
    let status: Int?
    let message: String?
    let data: DataClass?
}

// MARK: - DataClass
struct DataClass: Codable {
    let data: String?
}
