//
//  CoreDataManager.swift
//  SteppingStone
//
//  Created by JiwKang on 2023/04/30.
//

import CoreData

class CoreDataManager {
    private var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: K.coreDataName)
        container.loadPersistentStores(completionHandler: { _, error in
            if let error = error as NSError? {
                fatalError(error.localizedDescription)
            }
        })
        
        return container
    }()
    
    var context: NSManagedObjectContext {
        persistentContainer.viewContext
    }
    
    // MARK: - Core Data Saving support
    
    func saveContext() {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                fatalError("\(error)")
            }
        }
    }
}
