//
//  HTTPSSLViewController.swift
//  TTKit
//
//  Created by Tian Tong on 2021/7/3.
//  Copyright © 2021 TTDP. All rights reserved.
//

import UIKit

class HTTPSSLViewController: BaseViewController {
    
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
