//
//  CoreDataManager.swift
//  PhotoGallary
//
//  Created by Dipesh Patel on 17/10/25.
//

import CoreData

class CoreDataManager {
    
    static let shared = CoreDataManager()
    
    let container: NSPersistentContainer
    
    private init() {
        container = NSPersistentContainer(name: "Gallary")
        container.loadPersistentStores { dsec, error in
            if let error {
                debugPrint(error)
            }
        }
    }
    
    var context: NSManagedObjectContext {
        container.viewContext
    }
    
    func saveContext() {
        if context.hasChanges {
            try? context.save()
        }
    }
}
