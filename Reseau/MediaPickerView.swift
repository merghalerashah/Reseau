//
//  MediaPickerView.swift
//  Reseau
//
//  Created by Merghalera Shah on 2/4/24.
//

import SwiftUI
import PhotosUI

struct MediaPickerView: View {
    @Binding var selectedMedia: MediaPickerItem?
    @State private var showingImagePicker = false
    @State private var showingCamera = false
    @State private var textInput = ""
    @State private var assets: [UIImage] = []

    var body: some View {
        VStack {
            Button("Choose from Library") {
                showingImagePicker = true
            }
            .padding()
            .sheet(isPresented: $showingImagePicker) {
                ImagePicker(sourceType: .photoLibrary) { image in
                    if let selectedImage = image {
                        selectedMedia = .image(selectedImage)
                    }
                }
            }

            Button("Capture from Camera") {
                showingCamera = true
            }
            .padding()
            .fullScreenCover(isPresented: $showingCamera) {
                CameraCaptureView { capturedImage in
                    selectedMedia = .cameraCapture(capturedImage)
                }
            }

            TextField("Enter Text", text: $textInput)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            Button("Add Text Story") {
                if !textInput.isEmpty {
                    selectedMedia = .text(textInput)
                }
            }
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(10)

            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 100))]) {
                    ForEach(assets, id: \.self) { image in
                        MediaGridItemView(image: image) { selectedImage in
                            if let selectedImage = selectedImage {
                                selectedMedia = .image(selectedImage)
                            }
                        }
                    }
                }
            }
        }
        .onAppear {
            // Load assets if needed
        }
    }
}

struct MediaGridItemView: View {
    let image: UIImage
    var onImageSelected: (UIImage?) -> Void

    var body: some View {
        Button(action: {
            onImageSelected(image)
        }) {
            Image(uiImage: image)
                .resizable()
                .scaledToFill()
                .frame(width: 100, height: 100)
        }
        .buttonStyle(PlainButtonStyle())
    }
}
