//
//  ErrorModel.swift
//  FluxStore
//
//  Created by Berker Saptas on 22.09.2023.
//

import Foundation

// MARK: - ErrorModel
struct ErrorModel: Codable {
    let statusCode: Int?
    let statusType: String?
    let message: String?

    enum CodingKeys: String, CodingKey {
        case statusCode = "status_code"
        case statusType = "status_type"
        case message
    }
}
