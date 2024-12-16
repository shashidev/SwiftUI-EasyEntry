//
//  ProductListViewModel.swift
//  EasyEntry
//
//  Created by Shashi Ranjan on 05/11/24.
//

import Foundation


protocol ProductListViewModelProtocol: ObservableObject {

    var productList: [ProductListModel]? {get}
    var errorResponse: ErrorResponse? { get }

    func requestProductList()
}


class ProductListViewModel : ProductListViewModelProtocol {

    @Published private (set) var productList: [ProductListModel]?
    @Published private (set) var errorResponse: ErrorResponse?
    @Published var isLoading: Bool = false // Add loading State

    private var productService: ProductListServiceProtocol

    init(productService: ProductListServiceProtocol = ProductListService()) {
        self.productService = productService
    }

    func requestProductList() {

        isLoading = true

        productService.requestProductList {  productList, errorResponse in
            //DispatchQueue.main.async {
                self.isLoading = false
                if errorResponse == nil {
                    self.errorResponse = nil
                    self.productList = productList
                }else {
                    self.errorResponse = errorResponse
                    self.productList = nil
                }
            }

        //}
    }
}
