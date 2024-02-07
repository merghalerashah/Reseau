//
//  ReseauApp.swift
//  Reseau
//
//  Created by Merghalera Shah on 2/2/24.
//

import SwiftUI

@main
struct ReseauApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            RootContainerView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
