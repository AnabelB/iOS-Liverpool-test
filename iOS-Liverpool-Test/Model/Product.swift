//
//  Product.swift
//  iOS-Project
//
//  Created by Ana Bernal on 30/08/25.
//


import Foundation

struct Product: Codable {
    let productId: String
    let productDisplayName: String
    let listPrice: Double
    let longDescription: String
    let lgImage: String
    let promoPrice: Double
}
