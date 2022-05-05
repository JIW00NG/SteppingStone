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
    
    init() {
        DBHelper.shared.createGoalTable()
        DBHelper.shared.createSubGoalTable()
    }

    var body: some Scene {
        WindowGroup {
            MainView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
