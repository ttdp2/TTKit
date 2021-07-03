//
//  HTTPSSLViewController.swift
//  TTKit
//
//  Created by Tian Tong on 2021/7/3.
//  Copyright © 2021 TTDP. All rights reserved.
//

import UIKit
import Alamofire

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
        
        AF.request("https://ag.bizersoft.com/api/users/1000000038").response { response in
            if let data = response.data {
                let _ = try! JSONSerialization.jsonObject(with: data, options: [])
            }
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
        
        let http = HTTP(base: "https://ag.bizersoft.com")
        http.get("/static/avatar/100/000/00/1000000038.jpg") { response in
            DispatchQueue.main.async {
                if let data = response.data {
                    self.imageView.image = UIImage(data: data)
                }
            }
        }
        
        let task = http.fileRequest(downloadPath: "/static/avatar/100/000/00/1000000038.jpg") { url, error in
            
        }
        
        task.go()
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
