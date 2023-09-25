//
//  GbbulManager.swift
//  Gbbul
//
//  Created by 요시킴 on 2023/09/25.
//

import CoreData

class GbbulManager {
    init() {}
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "GbbulCoreData")
        container.loadPersistentStores { description, error in
            if let error = error {
                fatalError("Unable to load persistent stores: \(error)")
            }
        }
        return container
    }()
    var mainContext: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
}
