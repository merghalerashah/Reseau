//
//  ReelInfoView.swift
//  Reseau
//
//  Created by Merghalera Shah on 2/2/24.
//


import SwiftUI
import AVFoundation

struct ReelInfoView: View {
    let video: Video

    var body: some View {
        VStack {
            Spacer()
            HStack {
                VStack(alignment: .leading, spacing: 0) {
                    HStack {
                        if let user = video.user, let imageData = user.userImage, let uiImage = UIImage(data: imageData) {
                            Image(uiImage: uiImage)
                                .resizable()
                                .frame(width: 40, height: 40)
                                .cornerRadius(20)
                        }
                        Text(video.user?.userName ?? "Unknown User")
                            .font(Font.system(size: 18, weight: .semibold))
                            .foregroundColor(.white)
                    }
                    .padding(.vertical)

                    Text(video.caption ?? "No Caption")
                        .font(Font.system(size: 12, weight: .semibold))
                        .lineLimit(2)
                        .padding(.bottom)
                        .foregroundColor(.white)
                }
                .padding(.bottom, -100)
                .padding([.horizontal, .top])

                Spacer()

                VStack(spacing: 10) {
                    // Like Button
                    Button(action: {
                        // Like button action
                    }) {
                        VStack(spacing: 8) {
                            Image(systemName: "heart")
                                .font(.title)
                                .foregroundColor(.white)
                            Text(video.likes ?? "100")
                                .foregroundColor(.white)
                        }
                    }

                    // Comment Button
                    Button(action: {
                        // Comment button action
                    }) {
                        VStack(spacing: 8) {
                            Image(systemName: "message")
                                .font(.title)
                                .foregroundColor(.white)
                            Text(video.comments ?? "0")
                                .foregroundColor(.white)
                        }
                    }

                    // Share Button
                    Button(action: {
                        // Share button action
                    }) {
                        VStack(spacing: 8) {
                            Image(systemName: "paperplane")
                                .font(.title)
                                .foregroundColor(.white)
                        }
                    }

                    // More Options Button
                    Button(action: {
                        // More options button action
                    }) {
                        Image(systemName: "ellipsis")
                            .renderingMode(.template)
                            .resizable()
                            .foregroundColor(.white)
                            .frame(width: 25, height: 25)
                    }
                }
                .padding(.bottom, 60)
                .padding(.trailing)
            }
        }
        .padding(.top, safeAreaTopPadding)
        .padding(.bottom, safeAreaBottomPadding + 5)
    }

    private var safeAreaTopPadding: CGFloat {
        UIApplication.shared.windows.first?.safeAreaInsets.top ?? 0
    }

    private var safeAreaBottomPadding: CGFloat {
        UIApplication.shared.windows.first?.safeAreaInsets.bottom ?? 0
    }
}
