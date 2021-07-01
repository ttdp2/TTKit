//
//  BookEntity+CoreDataProperties.swift
//  TTKit
//
//  Created by Tian Tong on 2021/7/2.
//  Copyright © 2021 TTDP. All rights reserved.
//
//

import Foundation
import CoreData


extension BookEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<BookEntity> {
        return NSFetchRequest<BookEntity>(entityName: "BookEntity")
    }

    @NSManaged public var title: String
    @NSManaged public var person: PersonEntity?

}
