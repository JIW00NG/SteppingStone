//
//  SteppingStoneApp.swift
//  SteppingStone
//
//  Created by JiwKang on 2022/04/28.
//

import SwiftUI

@main
struct SteppingStoneApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
