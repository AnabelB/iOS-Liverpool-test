//
//  iOS_Liverpool_TestTests.swift
//  iOS-Liverpool-TestTests
//
//  Created by Ana Bernal on 31/08/25.
//

import XCTest

@testable import iOS_Liverpool_Test

@MainActor
final class iOS_Liverpool_TestTests: XCTestCase {

    var viewModel: ProductViewModel!
    var mockService: MockProductService!

    override func setUp() {
        super.setUp()
        // Crear instancia del mock
        mockService = MockProductService()
        // Inyectar el mock en el ViewModel
        viewModel = ProductViewModel(service: mockService)
    }

    func testFetchProducts() async {
        // Preparar productos simulados
        let product = Product(
            productId: "1",
            productDisplayName: "Test Product",
            listPrice: 100,
            longDescription: "Description",
            lgImage: "",
            promoPrice: 80
        )
        mockService.productsToReturn = [product]

        // Ejecutar fetch
        await viewModel.fetchProducts()

        // Comprobar resultados
        XCTAssertEqual(viewModel.products.count, 1)
        XCTAssertEqual(viewModel.products.first?.productDisplayName, "Test Product")
    }

    func testLoadMore() async {
        // Primer fetch
        mockService.productsToReturn = [
            Product(productId: "1", productDisplayName: "Product 1", listPrice: 100, longDescription: "", lgImage: "", promoPrice: 90)
        ]
        await viewModel.fetchProducts()
        XCTAssertEqual(viewModel.products.count, 1)

        // Segundo fetch (paginación)
        mockService.productsToReturn = [
            Product(productId: "2", productDisplayName: "Product 2", listPrice: 200, longDescription: "", lgImage: "", promoPrice: 180)
        ]
        await viewModel.loadMore()
        XCTAssertEqual(viewModel.products.count, 2)
        XCTAssertEqual(viewModel.products[1].productDisplayName, "Product 2")
    }
}
