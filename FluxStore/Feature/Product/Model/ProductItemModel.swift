//
//  ProductItemModel.swift
//  FluxStore
//
//  Created by Berker Saptas on 12.11.2023.
//

import Foundation

// MARK: - ProductItemModel
struct ProductItemModel: Codable, Identifiable  {
    
    let id: Int
    let title: String
    let price: Double
    let description, category: String
    let image: String
    let rating: Rating
}

// MARK: - Rating
struct Rating: Codable {
    let rate: Double
    let count: Int
}


