//
//  CoreDataOperation.swift
//  TTKit
//
//  Created by Tian Tong on 7/8/21.
//  Copyright © 2021 TTDP. All rights reserved.
//

import Foundation
import CoreData

class CoreDataOperation {
    
    class func fetchObjects(entityName: String, context: NSManagedObjectContext, filter: NSPredicate?, sorts: [NSSortDescriptor]?, fetchLimit: Int = 0, fetchOffset: Int = 0) -> [Any]? {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        request.predicate = filter
        request.sortDescriptors = sorts
        request.fetchLimit = fetchLimit
        request.fetchOffset = fetchOffset
        
        do {
            return try context.fetch(request)
        } catch {
            NSLog("Core Data Fetch Error: \(error.localizedDescription) #CoreDataOperation")
        }
        
        return nil
    }
    
    class func fetchObject(entityName: String, context: NSManagedObjectContext, attribute: String, value: String) -> NSManagedObject? {
        let predicate = NSPredicate(format: "%K == %@", attribute, value)
        let objects = fetchObjects(entityName: entityName, context: context, filter: predicate, sorts: nil, fetchLimit: 1) as? [NSManagedObject]
        return objects?.first
    }
    
}
