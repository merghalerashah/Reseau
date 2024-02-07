//
//  AuthViewModel.swift
//  Reseau
//
//  Created by Merghalera Shah on 2/4/24.
//

import SwiftUI

class AuthViewModel: ObservableObject {
    @Published var username = ""
    @Published var email = ""
    @Published var password = ""
    @Published var loggedIn = false
    @Published var errorMessage = ""
    
    private let networkManager = NetworkManager.shared
    
    func login() {
        networkManager.login(username: username, password: password) { result in
            switch result {
            case .success(_):
                // Handle successful login, e.g., store token or update UI
                self.loggedIn = true
                self.errorMessage = ""
            case .failure(let error):
                // Handle login error, e.g., display an error message
                self.loggedIn = false
                self.errorMessage = error.localizedDescription
            }
        }
    }
    
    func signup() {
        networkManager.signUp(username: username, email: email, password: password) { result in
            switch result {
            case .success:
                // Handle successful signup, e.g., navigate to the login screen
                self.errorMessage = ""
            case .failure(let error):
                // Handle signup error, e.g., display an error message
                self.errorMessage = error.localizedDescription
            }
        }
    }
}
