//
//  PostView.swift
//  Reseau
//
//  Created by Merghalera Shah on 2/2/24.
//

import SwiftUI

struct PostView: View {
    let post: Post
    let screenWidth: CGFloat
    @State private var selectedImage: UIImage? = nil
    @State private var isImagePickerPresented: Bool = false

    var body: some View {
        VStack {
            // Post info.
            HStack {
                if let userData = post.user?.userImage, let userImage = UIImage(data: userData) {
                    Image(uiImage: userImage)
                        .resizable()
                        .cornerRadius(12.5)
                        .frame(width: 25, height: 25)
                        .padding(.leading, 10)
                }

                Text(post.user?.userName ?? "Unknown User")
                    .font(Font.system(size: 14, weight: .semibold))

                Spacer()
                Image("menu") // Assuming "menu" is a local image
                    .resizable()
                    .frame(width: 25, height: 25)
                    .padding(.trailing, 10)
            }
            .frame(height: 25)
            
            // Image.
            if let imageData = post.postImage, let postImage = UIImage(data: imageData) {
                Image(uiImage: postImage)
                    .resizable()
                    .scaledToFill()
                    .frame(width: screenWidth, height: screenWidth * 1.1)
                    .clipped()
            }
            
            // Operations menu.
            HStack {
                Image(systemName: "heart")
                    .resizable()
                    .frame(width: 15, height: 15)
                    .padding(5)
                    .padding(.leading, 10)
                Image(systemName: "bubble.right")
                    .resizable()
                    .frame(width: 15, height: 15)
                    .padding(5)
                Image(systemName: "paperplane")
                    .resizable()
                    .frame(width: 15, height: 15)
                    .padding(5)
                Spacer()
                Image(systemName: "bookmark")
                    .resizable()
                    .frame(width: 15, height: 18)
                    .padding(5)
                    .padding(.trailing, 10)
            }
            .frame(height: 20)

            VStack(alignment: .leading, spacing: 0){
                Group {
                    Text(post.user?.userName ?? "Unknown User")
                        .font(Font.system(size: 14, weight: .semibold))
                        + Text(" ")
                        + Text(post.caption ?? "")
                        .font(Font.system(size: 14))
                }
                .padding(.horizontal, 15)
            }
            .frame(maxWidth: screenWidth, maxHeight: 60, alignment: .leading)

            Text(post.likes ?? "0 likes")
                .font(Font.system(size: 14, weight: .semibold))
                .padding(.horizontal, 15)
                .padding(.vertical, 6)
                .frame(width: screenWidth, height: 15, alignment: .leading)
        }
    }
}

struct PostView_Previews: PreviewProvider {
    static var previews: some View {
        GeometryReader { geometry in
        }
    }
}

