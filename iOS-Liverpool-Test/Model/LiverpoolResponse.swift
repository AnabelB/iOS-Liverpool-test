//
//  LiverpoolResponse.swift
//  iOS-Liverpool-Test
//
//  Created by Ana Bernal on 31/08/25.
//

import Foundation

struct LiverpoolResponse: Codable {
    let productListResult: ProductListResults
}

struct ProductListResults: Codable {
    let records: [ProductRecord]
}

struct ProductRecord: Codable {
    let productId: String
    let productDisplayName: String
    let listPrice: Double
    let longDescription: String?
    let lgImage: String
    let promoPrice: Double
}
