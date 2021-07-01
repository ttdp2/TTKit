//
//  PersonEntity+CoreDataProperties.swift
//  TTKit
//
//  Created by Tian Tong on 2021/7/2.
//  Copyright © 2021 TTDP. All rights reserved.
//
//

import Foundation
import CoreData


extension PersonEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<PersonEntity> {
        return NSFetchRequest<PersonEntity>(entityName: "PersonEntity")
    }

    @NSManaged public var username: String?
    @NSManaged public var books: NSOrderedSet?

}

// MARK: Generated accessors for books
extension PersonEntity {

    @objc(insertObject:inBooksAtIndex:)
    @NSManaged public func insertIntoBooks(_ value: BookEntity, at idx: Int)

    @objc(removeObjectFromBooksAtIndex:)
    @NSManaged public func removeFromBooks(at idx: Int)

    @objc(insertBooks:atIndexes:)
    @NSManaged public func insertIntoBooks(_ values: [BookEntity], at indexes: NSIndexSet)

    @objc(removeBooksAtIndexes:)
    @NSManaged public func removeFromBooks(at indexes: NSIndexSet)

    @objc(replaceObjectInBooksAtIndex:withObject:)
    @NSManaged public func replaceBooks(at idx: Int, with value: BookEntity)

    @objc(replaceBooksAtIndexes:withBooks:)
    @NSManaged public func replaceBooks(at indexes: NSIndexSet, with values: [BookEntity])

    @objc(addBooksObject:)
    @NSManaged public func addToBooks(_ value: BookEntity)

    @objc(removeBooksObject:)
    @NSManaged public func removeFromBooks(_ value: BookEntity)

    @objc(addBooks:)
    @NSManaged public func addToBooks(_ values: NSOrderedSet)

    @objc(removeBooks:)
    @NSManaged public func removeFromBooks(_ values: NSOrderedSet)

}
