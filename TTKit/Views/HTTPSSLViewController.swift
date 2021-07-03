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

        var req = URLRequest(url: URL(string: "https://ag.bizersoft.com/api/users/1000000038")!)
        req.httpMethod = "GET"

        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: nil)
        let dataTask = session.dataTask(with: req) { data, response, error in
            if let data = data {
                let json = try! JSONSerialization.jsonObject(with: data, options: [])
                print(json)
            }
        }
        
        dataTask.resume()
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
