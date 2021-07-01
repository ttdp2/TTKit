//
//  CoreDataManager.swift
//  TTKit
//
//  Created by Tian Tong on 2021/7/2.
//  Copyright © 2021 TTDP. All rights reserved.
//

import Foundation
import CoreData

class CoreDataManager {
    
    static let shared = CoreDataManager()
    
    // MARK: - Core Data Stack
    
    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
         */
        let container = NSPersistentContainer(name: "TTKit")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // MARK: - Core Data View Context
    
    lazy var viewContext: NSManagedObjectContext = {
        return self.persistentContainer.viewContext
    }()
    
    // MARK: - Core Data Background Context
    
    lazy var backContext: NSManagedObjectContext = {
        return self.persistentContainer.newBackgroundContext()
    }()
    
    // MARK: - Core Data Saving Support
    
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    func saveBackContext() {
        backContext.perform {
            if self.backContext.hasChanges {
                do {
                    try self.backContext.save()
                    print("Cached Objects Saved")
                } catch {
                    NSLog("Core Data SaveCacheContext Error: \(error.localizedDescription) #CoreDataManager")
                }
            }
        }
    }
    
    // MARK: - Delete Persistent Store
    
    func deleteStore() {
        let datamodelName = "TTKit"
        let storeType = "sqlite"
        
        let persistentContainer = NSPersistentContainer(name: datamodelName)
        
        let url: URL = {
            let url = FileManager.default.urls(for: .applicationSupportDirectory, in: .userDomainMask)[0].appendingPathComponent("\(datamodelName).\(storeType)")
            assert(FileManager.default.fileExists(atPath: url.path))
            return url
        }()
        
        try? persistentContainer.persistentStoreCoordinator.destroyPersistentStore(at: url, ofType: storeType, options: nil)
    }
    
}
