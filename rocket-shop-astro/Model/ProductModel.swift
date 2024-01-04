//
//  ProductModel.swift
//  rocket-shop-astro
//
//  Created by Hansel Matthew on 04/01/24.
//

import Foundation

// MARK: - ProductModel
struct ProductModel: Codable {
    let id: Int
    let title: String
    let price: Double
    let description, category: String
    let image: String
    let rating: RatingModel
}

// MARK: - Rating
struct RatingModel: Codable {
    let rate: Double
    let count: Int
}

typealias ProductsList = [ProductModel]
