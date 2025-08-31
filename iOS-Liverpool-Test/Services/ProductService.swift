//
//  ProductService.swift
//  iOS-Liverpool-Test
//
//  Created by Ana Bernal on 31/08/25.
//

import Foundation

class ProductService: ProductServiceProtocol {
    
    func fetchProducts(searchTerm: String = "", page: Int = 1, itemsPerPage: Int = 40) async -> [Product] {
        let searchQuery = searchTerm.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        let urlString = "https://shoppapp.liverpool.com.mx/appclienteservices/services/v8/plp/sf?page-number=\(page)&search-string=\(searchQuery)&force-plp=false&number-of-items-per-page=\(itemsPerPage)&cleanProductName=false"
        
        guard let url = URL(string: urlString) else { return [] }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let decoded = try JSONDecoder().decode(LiverpoolResponse.self, from: data)
            
            return decoded.productListResult.records.map { productList in
                Product(
                    productId: productList.productId,
                    productDisplayName: productList.productDisplayName,
                    listPrice: productList.listPrice,
                    longDescription: productList.longDescription ?? "",
                    lgImage: productList.lgImage,
                    promoPrice: productList.promoPrice
                )
            }
        } catch {
            print("Error to obtain data:", error)
            return []
        }
    }
}

