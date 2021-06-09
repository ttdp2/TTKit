//
//  PopUpInputViewController.swift
//  TTKit
//
//  Created by Tian Tong on 6/9/21.
//  Copyright © 2021 TTDP. All rights reserved.
//

import UIKit

class PopUpInputViewController: BaseViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let replyButton = UIBarButtonItem(title: "Reply", style: .done, target: self, action: #selector(input))
        navigationItem.rightBarButtonItem = replyButton
    }
    
    let textView = UITextView(frame: CGRect.zero)
    
    override func setupViews() {
        view.backgroundColor = UIColor(hex: "#EEEEEE")  // #F0F0F0 -> 238 Alert view background color   #EEEEEE -> 235
        view.backgroundColor = .white
        
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 100)
        label.text = "WWDC"
        view.addSubview(label)
        view.addConstraints(format: "V:[v0]", views: label)
        label.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        label.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true

        let dimView = UIView()
        dimView.backgroundColor = .black
        dimView.alpha = 0.2

        view.addSubview(dimView)
        view.addConstraints(format: "H:|[v0]|", views: dimView)
        view.addConstraints(format: "V:|[v0]|", views: dimView)
        
        let alertView = UIView()
        alertView.backgroundColor = UIColor(hex: "#F0F0F0")
        view.addSubview(alertView)
        view.addConstraints(format: "H:|-20-[v0]-20-|", views: alertView)
        view.addConstraints(format: "V:[v0(100)]-20-|", views: alertView)
    }
    
    @objc func input() {
        let alert = UIAlertController(title: "WWDC 2021", message: "Hello Swift", preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in }))
        alert.addAction(UIAlertAction(title: "Sure", style: .default, handler: { _ in }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { _ in }))
        present(alert, animated: true)
    }
    
}
