//
//  SetUserModel.swift
//  FluxStore
//
//  Created by Berker Saptas on 16.09.2023.
//

import Foundation

// MARK: - SetUserModel
struct SetUserModel: Codable {
    let status: Int?
    let message: String?
    let data: SetUserModelData?
}

// MARK: - SetUserModelData
struct SetUserModelData: Codable {
    let data: DataData?
}

// MARK: - DataData
struct DataData: Codable {
    let insertedID: String?

    enum CodingKeys: String, CodingKey {
        case insertedID = "InsertedID"
    }
}
