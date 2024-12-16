//
//  ProductListService.swift
//  EasyEntry
//
//  Created by Shashi Ranjan on 05/11/24.
//

import SwiftUI


struct ProductListModel: Codable, Hashable {

    var id: Int?
    var title: String?
    var price: Double?
    var description: String?
    var category: String?
    var image: String?
    var rating: Rating?

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case title = "title"
        case price = "price"
        case description = "description"
        case category = "category"
        case image = "image"
        case rating = "rating"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decodeIfPresent(Int.self, forKey: .id)
        self.title = try container.decodeIfPresent(String.self, forKey: .title)
        self.price = try container.decodeIfPresent(Double.self, forKey: .price)
        self.description = try container.decodeIfPresent(String.self, forKey: .description)
        self.category = try container.decodeIfPresent(String.self, forKey: .category)
        self.image = try container.decodeIfPresent(String.self, forKey: .image)
        self.rating = try container.decodeIfPresent(Rating.self, forKey: .rating)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(self.id, forKey: .id)
        try container.encodeIfPresent(self.title, forKey: .title)
        try container.encodeIfPresent(self.price, forKey: .price)
        try container.encodeIfPresent(self.description, forKey: .description)
        try container.encodeIfPresent(self.category, forKey: .category)
        try container.encodeIfPresent(self.image, forKey: .image)
        try container.encodeIfPresent(self.rating, forKey: .rating)
    }

    init(id: Int?, title: String?, price: Double?, description: String?, category: String?, image: String?, rating: Rating?) {
        self.id = id
        self.title = title
        self.price = price
        self.description = description
        self.category = category
        self.image = image
        self.rating = rating
    }

    static let example = ProductListModel(id: 1, title: "Fjallraven - Foldsack No. 1 Backpack, Fits 15 Laptops", price: 109.95, description: "Your perfect pack for everyday use and walks in the forest. Stash your laptop (up to 15 inches) in the padded sleeve, your everyday", category: "men's clothing", image: "https://fakestoreapi.com/img/81fPKd-2AYL._AC_SL1500_.jpg", rating: Rating(rate: 3.9, totalCount: 120))

}


struct Rating: Codable, Hashable {
    var rate: Double?
    var totalCount: Int?

    enum CodingKeys: String, CodingKey {

        case rate = "rate"
        case totalCount = "count"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.rate = try container.decodeIfPresent(Double.self, forKey: .rate)
        self.totalCount = try container.decodeIfPresent(Int.self, forKey: .totalCount)
    }
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(self.rate, forKey: .rate)
        try container.encodeIfPresent(self.totalCount, forKey: .totalCount)
    }

    init(rate: Double?, totalCount: Int?) {
        self.rate = rate
        self.totalCount = totalCount
    }
}

protocol ProductListServiceProtocol {
    
    func requestProductList(completionHandler:@escaping([ProductListModel]?, ErrorResponse?)-> ())
}

class ProductListService: ProductListServiceProtocol {

    private var networkManager: NetworkManagerProtocol

    init(networkManager: NetworkManagerProtocol = URLSessionWrapper()) {
        self.networkManager = networkManager
    }


    func requestProductList(completionHandler:@escaping([ProductListModel]?, ErrorResponse?)-> ()) {

        let url = "https://fakestoreapi.com/products"

        networkManager.getRequest(strUrl: url, params: nil) { result in

            switch result {
            case .success(let data):

                do {
                    let productListModel = try JSONDecoder().decode([ProductListModel].self, from: data)
                    completionHandler(productListModel, nil)
                }catch {
                    do {
                        let errorResponse = try JSONDecoder().decode(ErrorResponse.self, from: data)
                        completionHandler(nil, errorResponse)
                    }
                    catch {
                        let errorResponse = ErrorResponse(error: .init(code: -1, message: "Unknown error occurred"))
                        completionHandler(nil, errorResponse)
                    }
                }
            case .failure(let error):

                let errorResponse = ErrorResponse(error: .init(code: -1, message: error.localizedDescription))
                completionHandler(nil, errorResponse)
            }

        }
    }
}
