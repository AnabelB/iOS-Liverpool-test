//
//  MockProductService.swift
//  iOS-Liverpool-Test
//
//  Created by Ana Bernal on 31/08/25.
//

import Foundation
@testable import iOS_Liverpool_Test

class MockProductService: ProductServiceProtocol {
    
    var productsToReturn: [Product] = []
    
    func fetchProducts(searchTerm: String, page: Int, itemsPerPage: Int) async -> [Product] {
        return productsToReturn
    }
}
