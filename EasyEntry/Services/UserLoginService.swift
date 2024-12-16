//
//  UserLoginService.swift
//  EasyEntry
//
//  Created by Shashi Ranjan on 04/11/24.
//

import Foundation


struct ErrorResponse: Codable, Error {
    let error: ErrorDetail

    struct ErrorDetail: Codable {
        let code: Int
        let message: String
    }
}

struct UserLoginResponseModel: Codable {

    let token: String

    enum CodingKeys: String, CodingKey {
        case token = "token"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.token = try container.decode(String.self, forKey: .token)
    }

}

protocol UserLoginServiceProtocol {

    func requestUserLogin(with params: [String: String], completionHandler: @escaping(UserLoginResponseModel?, ErrorResponse?)->())
}

class UserLoginService: UserLoginServiceProtocol {

    private var networkManager: NetworkManagerProtocol

    init(networkManager: NetworkManagerProtocol = URLSessionWrapper()) {
        self.networkManager = networkManager
    }

    func requestUserLogin(with params: [String: String], completionHandler: @escaping(UserLoginResponseModel?, ErrorResponse?)->()) {

        let url = "https://reqres.in/api/login"

        networkManager.getRequest(strUrl: url, params: params) { result in
            switch result {
            case .success(let data):
                do {
                    let loginResponseModel = try JSONDecoder().decode(UserLoginResponseModel.self, from: data)
                    completionHandler(loginResponseModel, nil)
                }
                catch {
                    do {
                        let errorResponse = try JSONDecoder().decode(ErrorResponse.self, from: data)
                        completionHandler(nil, errorResponse)
                    }
                    catch {
                        let unknownError = ErrorResponse(error: .init(code: -1, message: "Unknown error occurred"))
                        completionHandler(nil, unknownError)
                    }
                }

            case .failure(let error):
                let networkError = ErrorResponse(error: .init(code: -1, message: error.localizedDescription))
                completionHandler(nil, networkError)
            }
        }
    }
}
