//
//  ProductViewModel.swift
//  iOS-Project
//
//  Created by Ana Bernal on 30/08/25.
//

import Foundation

@MainActor
class ProductViewModel {
    
    private(set) var products: [Product] = []
    private var currentPage = 1
    private var searchTerm = ""
    var isFetching = false
    
    private let service: ProductServiceProtocol
    
    init(service: ProductServiceProtocol = ProductService()) {
        self.service = service
    }
    
    func fetchProducts(searchTerm: String = "") async {
        self.searchTerm = searchTerm
        self.currentPage = 1
        isFetching = true
        products = await service.fetchProducts(searchTerm: searchTerm, page: currentPage, itemsPerPage: 40)
        isFetching = false
    }
    
    func loadMore() async {
        guard !isFetching else { return }
        isFetching = true
        currentPage += 1
        
        let moreProducts = await service.fetchProducts(searchTerm: searchTerm, page: currentPage, itemsPerPage: 40)
        products.append(contentsOf: moreProducts)
        isFetching = false
    }
}
