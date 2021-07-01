//
//  AppDelegate.swift
//  TTKit
//
//  Created by Tian Tong on 2019/9/4.
//  Copyright © 2019 TTDP. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow()
        window?.rootViewController = UINavigationController(rootViewController: MainViewController())
        window?.makeKeyAndVisible()
        
        let context = CoreDataManager.shared.viewContext
        
        let book1 = BookEntity(context: context)
        book1.title = "Hello"
        
        let book2 = BookEntity(context: context)
        book2.title = "World"
        
        let book3 = BookEntity(context: context)
        book3.title = "World"
        
        let person = PersonEntity(context: context)
        person.username = "matt"
        person.books = NSOrderedSet(array: [book1, book2, book3])
        
        return true
    }
    
}

struct Book {
    let title: String
    let uuid: UUID
}
