//
//  NetworkManager.swift
//  EasyEntry
//
//  Created by Shashi Ranjan on 04/11/24.
//

import Foundation


enum HTTPMethod: String {
    case POST = "POST"
    case GET = "GET"
    case DELETE = "DELETE"
    case PUT = "PUT"
}

// Error handling
enum NetworkError: Error {
    case invalidURL
    case invalidResponse
    case noData
}

protocol NetworkManagerProtocol {
    func getRequest(strUrl: String, params:[String: String]?, completionHandler: @escaping (Result<Data, Error>) -> Void)
}

class URLSessionWrapper: NetworkManagerProtocol {

    private var session: URLSession

    init(configuration: URLSessionConfiguration = .default) {
        self.session = URLSession(configuration: configuration)
    }

    func getRequest(strUrl: String, params:[String: String]? = nil, completionHandler: @escaping (Result<Data, Error>) -> Void) {

        guard var urlComponent = URLComponents(string: strUrl) else {
            return completionHandler(.failure(NetworkError.invalidURL))
        }

        if let params = params {
            urlComponent.queryItems = params.map({URLQueryItem(name: $0.key, value: $0.value)})
        }

        guard let url = urlComponent.url else {
            return completionHandler(.failure(NetworkError.invalidURL))
        }

        var urlRequest = URLRequest(url: url)

        urlRequest.httpMethod = HTTPMethod.GET.rawValue

        DispatchQueue.global(qos: .background).async {

            let task = self.session.dataTask(with: url) { data, response, error in

                DispatchQueue.main.async {
                    if let error = error {
                        return completionHandler(.failure(error))
                    }

                    // Check if response is valid and has data
                    guard let httpResponse = response as? HTTPURLResponse, 200..<300 ~= httpResponse.statusCode else {
                        return completionHandler(.failure(NetworkError.invalidResponse))
                    }

                    guard let data = data else {
                        return completionHandler(.failure(NetworkError.noData))
                    }

                    // Return data in completion handler
                    completionHandler(.success(data))
                }

            }
            task.resume()
        }
    }


}
