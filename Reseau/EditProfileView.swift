//
//  EditProfileView.swift
//  Reseau
//
//  Created by Merghalera Shah on 2/4/24.
//

import SwiftUI

struct EditProfileView: View {
    @State private var userName = ""
    @State private var userBio = ""
    @State private var email = ""
    @State private var password = ""
    @State private var website = ""
    @State private var characterCount = 0
    @State private var isImagePickerPresented = false
    @State private var selectedImage: UIImage?
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        NavigationView {
            VStack {
                Button(action: {
                    isImagePickerPresented.toggle()
                }) {
                    if let image = selectedImage {
                        Image(uiImage: image)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100, height: 100)
                            .clipShape(Circle())
                    } else {
                        Image(systemName: "person.circle.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100, height: 100)
                            .foregroundColor(.blue)
                    }
                }
                .sheet(isPresented: $isImagePickerPresented) {
                    ImagePicker(sourceType: .photoLibrary, onImagePicked: { image in
                        self.selectedImage = image
                        isImagePickerPresented = false
                    })
                }
                .padding()

                TextField("Name", text: $userName)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                    .autocapitalization(.words)
                    .onChange(of: userName, perform: { value in
                        characterCount = value.count
                    })

                TextField("Email", text: $email)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                    .keyboardType(.emailAddress)
                    .autocapitalization(.none)

                SecureField("Password", text: $password)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()

                TextField("Website", text: $website)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                    .keyboardType(.URL)

                Text("Character Count: \(characterCount)")
                    .foregroundColor(.secondary)
                    .padding(.horizontal)

                TextEditor(text: $userBio)
                    .frame(minHeight: 100)
                    .padding()
                    .multilineTextAlignment(.leading)
                    .onChange(of: userBio, perform: { value in
                        characterCount = value.count
                    })

                Button(action: {
                    // Implement save logic here, e.g., update user profile data
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Text("Save Changes")
                        .font(.headline)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
                .padding(.horizontal)

                Spacer()
            }
            .padding()
            .navigationBarTitle("Edit Profile", displayMode: .inline)
            .onAppear {
                // Load user's profile data and set the initial values for userName, email, website, and userBio
                userName = "John Doe"
                email = "johndoe@example.com"
                website = "www.example.com"
                userBio = "iOS Developer | SwiftUI Enthusiast"
                characterCount = userBio.count
            }
        }
    }
}
