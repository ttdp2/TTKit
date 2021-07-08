//
//  HTTPSSLViewController.swift
//  TTKit
//
//  Created by Tian Tong on 2021/7/3.
//  Copyright © 2021 TTDP. All rights reserved.
//

import UIKit

class HTTPSSLViewController: BaseViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let context = CoreDataManager.shared.viewContext

        let book1 = BookEntity(context: context)
        book1.title = "Hello"

        let book2 = BookEntity(context: context)
        book2.title = "World"

        let book3 = BookEntity(context: context)
        book3.title = "Swift"
//
//        let person = PersonEntity(context: context)
//        person.username = "matt"
//        person.books = NSOrderedSet(array: [book1, book2, book3])
//
//        CoreDataManager.shared.saveContext()
        
        if let entity = CoreDataOperation.fetchObject(entityName: "PersonEntity", context: context, attribute: "username", value: "matt") as? PersonEntity {
            if let books = entity.books?.array as? [BookEntity] {
                books.forEach { book in
                    print(book.title)
                }
            }
            print(entity.username, entity.books)
//            entity.addToBooks(NSOrderedSet(array: [book1, book2, book3]))
//
//            CoreDataManager.shared.saveContext()
        }
    }
    
    let imageView = UIImageView()
    
    override func setupViews() {
        imageView.backgroundColor = .lightGray
        imageView.contentMode = .scaleAspectFit
        
        view.addSubview(imageView)
        view.addConstraints(format: "H:[v0(200)]", views: imageView)
        view.addConstraints(format: "V:[v0(200)]", views: imageView)
        imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
}
























//        req = URLRequest(url: URL(string: "https://ag.bizersoft.com/api/auth/login")!)
//        req.httpMethod = "POST"
//        let params: [String: Any] = ["username": "timo", "password": "password", "loginType": 0]
//        let bodyData = try! JSONSerialization.data(withJSONObject: params, options: [])
//        req.httpBody = bodyData
//        req.setValue("application/json", forHTTPHeaderField: "Content-Type")
//
//        let postTask = URLSession.shared.dataTask(with: req) { data, response, error in
//            if let data = data {
//                if let json = try? JSONSerialization.jsonObject(with: data, options: []) {
//                    print(json)
//                }
//            }
//        }
//
//        postTask.resume()
