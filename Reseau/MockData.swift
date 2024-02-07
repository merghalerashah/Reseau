//
//  MockData.swift
//  Reseau
//
//  Created by Merghalera Shah on 2/2/24.
//


import Foundation
import CoreData
import UIKit

struct MockData {
    
    static var context: NSManagedObjectContext {
        return PersistenceController.preview.container.viewContext
    }

    // MARK: - User Creation
    static func makeUser(id: Int) -> User {
        let user = User(context: context)
        user.id = UUID()
        user.userName = "User \(id)"
        if let image = UIImage(named: "user_\(id)"), let imageData = image.jpegData(compressionQuality: 1.0) {
            user.userImage = imageData
        }
        return user
    }

    // MARK: - Post Creation
    static func makePost(id: Int, user: User) -> Post {
        let post = Post(context: context)
        post.id = UUID()
        post.caption = "Post \(id)"
        post.likes = "\(Int.random(in: 1...1000)) likes"
        post.postImage = UIImage(named: "post_\(id)")?.jpegData(compressionQuality: 1.0)
        post.timestamp = Date()
        post.user = user
        return post
    }

    // MARK: - Activity Creation
    static func makeActivity(for post: Post) -> Activity {
        let activity = Activity(context: context)
        activity.id = UUID()
        activity.activity = "liked"
        activity.comment = "Loved this!"
        activity.duration = "1h"
        activity.post = post
        activity.usersInContext = NSSet(object: post.user!)
        return activity
    }
    
    // MARK: - Story Creation
    static func makeStory(id: Int, user: User) -> Story {
        let story = Story(context: context)
        story.id = UUID()
        story.hasSeen = false
        story.isMyStory = false
        story.user = user
        return story
    }

    // MARK: - Video Creation
    static func makeVideo(id: Int, user: User) -> Video {
        let video = Video(context: context)
        video.id = UUID()
        video.caption = "Video \(id)"
        video.likes = "\(Int.random(in: 1...500)) likes"
        video.comments = "\(Int.random(in: 1...100)) comments"
        video.videoURL = "https://example.com/video\(id).mp4" // Sample URL
        video.user = user
        return video
    }
    
    // MARK: - Message Creation
    static func makeMessage(id: Int, sender: User, receiver: User) -> Message {
        let message = Message(context: context)
        message.id = UUID()
        message.content = "Message content \(id)"
        message.timestamp = Date()
        message.hasRead = Bool.random()
        message.isCurrentUser = Bool.random() // Or set based on logic
        message.sender = sender
        message.receiver = receiver
        return message
    }

    // MARK: - Static Properties
    static var users: [User] {
        (1...20).map { makeUser(id: $0) }
    }

    static var posts: [Post] {
        users.enumerated().map { makePost(id: $0.offset + 1, user: $0.element) }
    }

    static var activities: [Activity] {
        posts.map { makeActivity(for: $0) }
    }

    static var stories: [Story] {
        users.map { makeStory(id: Int($0.id?.uuidString ?? "0") ?? 0, user: $0) }
    }

    static var videos: [Video] {
        users.map { makeVideo(id: Int($0.id?.uuidString ?? "0") ?? 0, user: $0) }
    }
    
    // MARK: - Messages Static Property
       static var messages: [Message] {
           var generatedMessages = [Message]()
           let users = self.users // Use the users array from MockData
           for i in 1...50 { // Generate 50 messages for example
               let senderIndex = Int.random(in: 0..<users.count)
               let receiverIndex = (senderIndex + 1) % users.count // Ensure sender and receiver are not the same
               let message = makeMessage(id: i, sender: users[senderIndex], receiver: users[receiverIndex])
               generatedMessages.append(message)
           }
           return generatedMessages
       }


// MARK: - Update Data Generation
static func generate() {
    _ = users
    _ = posts
    _ = activities
    _ = stories
    _ = videos
    _ = messages // Add this line to generate messages
    try? context.save()
}
}
