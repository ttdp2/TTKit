//
//  BaseViewController.swift
//  TTKit
//
//  Created by Tian Tong on 2019/9/4.
//  Copyright © 2019 TTDP. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        view.addSubview(naviEdge)
        view.addConstraints(format: "H:|[v0]|", views: naviEdge)
        view.addConstraints(format: "V:|-\(naviGap)-[v0(1)]", views: naviEdge)
        
        view.addSubview(bottomEdge)
        view.addConstraints(format: "H:|[v0]|", views: naviEdge)
        view.addConstraints(format: "V:[v0(1)]-\(bottomGap)-|", views: bottomEdge)
        
        setupViews()
    }
    
    let naviEdge: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    let bottomEdge: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    // Override by subclass
    func setupViews() {
        
    }
    
}
