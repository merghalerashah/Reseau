//
//  ActivityView.swift
//  Reseau
//
//  Created by Merghalera Shah on 2/2/24.
//

import SwiftUI

struct ActivityView: View {
    let activity: Activity

    var body: some View {
        HStack {
            // Display user image
            if let user = activity.usersInContext?.allObjects.first as? User, let imageData = user.userImage, let uiImage = UIImage(data: imageData) {
                Image(uiImage: uiImage)
                    .resizable()
                    .cornerRadius(20)
                    .frame(width: 40, height: 40, alignment: .center)
                    .clipped()
            } else {
                Image(systemName: "person.fill")
                    .resizable()
                    .cornerRadius(20)
                    .frame(width: 40, height: 40, alignment: .center)
                    .clipped()
            }

            // Handling different activity types
            VStack(alignment: .leading) {
                switch activity.activity {
                case "liked":
                    likedActivityView()
                case "comment":
                    commentActivityView()
                case "suggestFollower":
                    suggestFollowerActivityView()
                case "newFollower":
                    newFollowerActivityView()
                default:
                    Text("Unknown activity")
                }
            }

            Spacer()

            // Additional UI elements based on activity type
            additionalUIBasedOnActivityType()
        }
        .padding(.horizontal, 15)
        .padding(.vertical, 5)
        .frame(width: UIScreen.main.bounds.width, alignment: .leading)
    }

    private func likedActivityView() -> some View {
        Group {
            if let user = activity.usersInContext?.allObjects.first as? User {
                Text(user.userName ?? "Someone")
                    .font(Font.system(size: 12, weight: .semibold)) +
                Text(" liked your post. ")
                    .font(Font.system(size: 12, weight: .medium)) +
                Text(activity.duration ?? "Recently")
                    .font(Font.system(size: 10, weight: .light))
            } else {
                Text("Someone liked your post.")
            }
        }
    }

    private func commentActivityView() -> some View {
        Group {
            if let user = activity.usersInContext?.allObjects.first as? User {
                Text(user.userName ?? "Someone")
                    .font(Font.system(size: 12, weight: .semibold)) +
                Text(" mentioned you in a comment: ")
                    .font(Font.system(size: 12, weight: .medium)) +
                Text(activity.comment ?? "")
                    .font(Font.system(size: 12, weight: .semibold)) +
                Text(" " + (activity.duration ?? "Recently"))
                    .font(Font.system(size: 10, weight: .light))
            } else {
                Text("Someone mentioned you in a comment.")
            }
        }
    }

    private func suggestFollowerActivityView() -> some View {
        Group {
            if let user = activity.usersInContext?.allObjects.first as? User {
                Text(user.userName ?? "Someone")
                    .font(Font.system(size: 12, weight: .semibold)) +
                Text(" who you might know, is on Instagram. ")
                    .font(Font.system(size: 12, weight: .medium)) +
                Text(activity.duration ?? "Recently")
                    .font(Font.system(size: 10, weight: .light))
            } else {
                Text("Someone who you might know, is on Instagram.")
            }
        }
    }

    private func newFollowerActivityView() -> some View {
        Group {
            if let user = activity.usersInContext?.allObjects.first as? User {
                Text(user.userName ?? "Someone")
                    .font(Font.system(size: 12, weight: .semibold)) +
                Text(" started following you. ")
                    .font(Font.system(size: 12, weight: .medium)) +
                Text(activity.duration ?? "Recently")
                    .font(Font.system(size: 10, weight: .light))
            } else {
                Text("Someone started following you.")
            }
        }
    }

    private func additionalUIBasedOnActivityType() -> some View {
        Group {
            if activity.activity == "liked" || activity.activity == "comment" {
                Button(action: {
                    // Action for liking or commenting
                }) {
                    Image(systemName: "heart")
                }
            } else if activity.activity == "newFollower" {
                Button(action: {
                    // Action for following back
                }) {
                    Text("Follow Back")
                        .padding(5)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(5)
                }
            }
            // No additional UI elements for "suggestFollower"
        }
    }
}

// Include your PreviewProvider structs here as well
