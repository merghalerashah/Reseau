//
//  Persistence.swift
//  Reseau
//
//  Created by Merghalera Shah on 2/2/24.
//

import CoreData

struct PersistenceController {
    static let shared = PersistenceController()

    static var preview: PersistenceController = {
        let result = PersistenceController(inMemory: true)
        let viewContext = result.container.viewContext

        // Create sample Video entity
        for _ in 0..<7 {
            let newVideo = Video(context: viewContext)
            newVideo.id = UUID()
            newVideo.videoURL = "https://example.com/samplevideo.mp4" // Sample video URL
            newVideo.likes = "100" // Sample likes
            newVideo.caption = "Sample Video Caption" // Sample caption
            // Add other attributes as necessary
        }

        do {
            try viewContext.save()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
        return result
    }()

    let container: NSPersistentContainer

    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "Reseau")
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        container.viewContext.automaticallyMergesChangesFromParent = true
    }
}
