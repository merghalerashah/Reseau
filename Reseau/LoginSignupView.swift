//
//  LoginSignupView.swift
//  Reseau
//
//  Created by Merghalera Shah on 2/4/24.
//

import SwiftUI

struct LoginSignupView: View {
    @ObservedObject var authViewModel = AuthViewModel()
    
    var body: some View {
        VStack {
            TextField("Username", text: $authViewModel.username)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            TextField("Email", text: $authViewModel.email)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            SecureField("Password", text: $authViewModel.password)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            if !authViewModel.loggedIn {
                Text(authViewModel.errorMessage)
                    .foregroundColor(.red)
                    .padding()
            }
            
            Button("Login", action: {
                authViewModel.login()
            })
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(5)
            
            Button("Sign Up", action: {
                authViewModel.signup()
            })
            .padding()
            .background(Color.green)
            .foregroundColor(.white)
            .cornerRadius(5)
        }
        .padding()
    }
}

struct LoginSignupView_Previews: PreviewProvider {
    static var previews: some View {
        LoginSignupView()
    }
}

