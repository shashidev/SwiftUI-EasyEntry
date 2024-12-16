//
//  ContentView.swift
//  EasyEntry
//
//  Created by Shashi Ranjan on 19/10/24.
//

import SwiftUI

struct ContentView: View {

    @StateObject private var viewModel = UserLoginViewModel()
    @State private var userName: String = ""
    @State private var password: String = ""
    @Binding var isLoggedIn: Bool

    @State var showAlert: Bool = false
    @State var alertMessage: String = ""

    var body: some View {
        
        NavigationView {
            Form {
                VStack (spacing: 16) {

                    Text("User Login")
                        .font(.largeTitle)
                        .padding()

                    Divider()

                    TextField("User Name", text: $userName)
                        .customTextField()

                    SecureField("Password", text: $password)
                        .customTextField()

                    Button("Login") {
                        //isLoggedIn = true
                        viewModel.userLogin(userName: userName, password: password)
                    }
                    .defaultCustomButton(isEnable: isValidCredential(userName: userName, password: password))
                    .disabled(!isValidCredential(userName: userName, password: password))
                }

                if let loginResponse = viewModel.loginResponse {
                    Text("Login successful! Token: \(loginResponse.token)")
                        .foregroundColor(.green)
                }
                if let errorResponse = viewModel.errorResponse {
                    Text("Login failed!: \(errorResponse.error.message)")
                        .foregroundColor(.red)
                }

            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Skip") {
                        isLoggedIn = true
                    }
                    .font(.headline)
                }
            }
            .navigationTitle("")
            .navigationBarTitleDisplayMode(.inline)
        }

        .alert(isPresented: $showAlert) {
            Alert(title: Text("Alert"), message: Text(alertMessage), dismissButton: .default(Text("OK"),action: {
                showAlert = false
            }))
        }

        .onChange(of: viewModel.errorResponse?.error.message) { newValue in

            if let error = newValue {
                alertMessage = error
                showAlert = true
            }

        }
    }

    private func isValidCredential(userName: String, password: String)-> Bool {

        return !userName.isEmpty && !password.isEmpty
    }
}

#Preview {
    ContentView(isLoggedIn: .constant(false))
}


struct TextFieldStyleModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding()
            .textFieldStyle(.plain)
            .overlay(
                RoundedRectangle(cornerRadius: 6)
                    .stroke(Color.blue, lineWidth: 1)
            )
            .padding(.top, 10)
    }
}

struct ButtonModifier: ViewModifier {

    var isEnable: Bool = false

    func body(content: Content) -> some View {
        content
            .frame(maxWidth: .infinity, minHeight: 54)
            .font(.headline)
            .background(isEnable ? .blue : .gray)
            .foregroundColor(isEnable ? .white : .secondary)
            .cornerRadius(6)
            .padding(.top, 10)
            .opacity(isEnable ? 1.0 : 0.5)


    }
}

extension View {
    func customTextField()-> some View {
         self.modifier(TextFieldStyleModifier())
    }

    func defaultCustomButton(isEnable: Bool)-> some View {

        self.modifier(ButtonModifier(isEnable: isEnable))
    }
}

