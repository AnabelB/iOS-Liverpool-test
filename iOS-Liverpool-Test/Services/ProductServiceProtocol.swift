//
//  ProductServiceProtocol.swift
//  iOS-Liverpool-Test
//
//  Created by Ana Bernal on 31/08/25.
//

import Foundation

protocol ProductServiceProtocol {
    func fetchProducts(searchTerm: String, page: Int, itemsPerPage: Int) async -> [Product]
}
