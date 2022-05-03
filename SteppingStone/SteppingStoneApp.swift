//
//  SteppingStoneApp.swift
//  SteppingStone
//
//  Created by JiwKang on 2022/04/28.
//

import SwiftUI

@main
struct SteppingStoneApp: App {
    let goalPersistenceController = GoalPersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, goalPersistenceController.container.viewContext)
        }
    }
}
