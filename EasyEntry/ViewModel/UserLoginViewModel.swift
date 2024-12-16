//
//  UserLoginViewModel.swift
//  EasyEntry
//
//  Created by Shashi Ranjan on 04/11/24.
//

import Foundation

protocol UserLoginViewModelProtocol: ObservableObject {
    var loginResponse: UserLoginResponseModel? { get }
    var errorResponse: ErrorResponse? { get }
    func userLogin(userName: String, password: String)
}
class UserLoginViewModel: UserLoginViewModelProtocol {

    @Published private (set) var loginResponse: UserLoginResponseModel?
    @Published private (set) var errorResponse: ErrorResponse?

    private var loginService: UserLoginServiceProtocol

    init(loginService: UserLoginServiceProtocol = UserLoginService()) {
        self.loginService = loginService
    }

    func userLogin(userName: String, password: String) {

        let params = ["email": userName, "password": password]

        self.loginService.requestUserLogin(with: params) { [weak self] loginResponse, errorResponse in

            DispatchQueue.main.async {
                if let error = errorResponse {
                    self?.errorResponse = error
                    self?.loginResponse = nil // Clear previous login response on error
                } else {
                    self?.loginResponse = loginResponse
                    self?.errorResponse = nil // Clear previous error on success
                }
            }
        }

    }
}
