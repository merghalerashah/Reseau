//
//  StoryView.swift
//  Reseau
//
//  Created by Merghalera Shah on 2/2/24.
//

import SwiftUI

struct StoryView: View {
    let story: Story
    var gradient = Gradient(colors: [.yellow, .red, .purple, .orange, .pink, .red])
    
    @State private var showingMediaPicker = false
    @State private var selectedMedia: MediaPickerItem?

    var body: some View {
        VStack(spacing: 5) {
            UserImageView(user: story.user, gradient: gradient)

            Button("Add Story") {
                showingMediaPicker = true
            }
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(10)

            if let selectedMedia = selectedMedia {
                Text("Selected Media: \(describe(media: selectedMedia))")
            }
        }
        .sheet(isPresented: $showingMediaPicker) {
            MediaPickerView(selectedMedia: $selectedMedia)
        }
    }

    private func describe(media: MediaPickerItem) -> String {
           switch media {
           case .image:
               return "Image"
           case .video:
               return "Video"
           case .cameraCapture:
               return "Camera Capture"
           case .text(let text):
               return "Text: \(text)"
           }
       }

    private struct UserImageView: View {
        let user: User?
        let gradient: Gradient

        var body: some View {
            if let user = user,
               let userName = user.userName,
               let userImage = user.userImage,
               let uiImage = UIImage(data: userImage) {
                VStack {
                    Image(uiImage: uiImage)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 60, height: 60)
                        .cornerRadius(30)
                        .overlay(
                            Circle()
                                .stroke(
                                    LinearGradient(
                                        gradient: gradient,
                                        startPoint: .bottomLeading,
                                        endPoint: .topTrailing
                                    ),
                                    style: StrokeStyle(lineWidth: 2.5, lineCap: .round)
                                )
                        )
                    Text(userName)
                        .font(.caption2)
                        .lineLimit(1)
                }
            }
        }
    }
}

struct StoryView_Previews: PreviewProvider {
    static var previews: some View {
        StoryView(story: MockData.stories.first!)
    }
}
