//
//  ForgetPasswordModel.swift
//  FluxStore
//
//  Created by Berker Saptas on 17.09.2023.
//

import Foundation

// MARK: - ForgetPasswordModel
struct ForgetPasswordModel: Codable {
    let status: Int?
    let message: String?
    let data: ForgetPasswordModelData?
}

// MARK: - ForgetPasswordModelData
struct ForgetPasswordModelData: Codable {
    let data: DataData2?
}

// MARK: - DataData2
struct DataData2: Codable {
    let id : String?
    let email: String?
}
