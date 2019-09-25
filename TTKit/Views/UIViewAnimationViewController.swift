//
//  UIViewAnimationViewController.swift
//  TTKit
//
//  Created by Tian Tong on 2019/9/25.
//  Copyright © 2019 TTDP. All rights reserved.
//

import UIKit

class UIViewAnimationViewController: BaseViewController {
    
    var blueWidthConstraint: NSLayoutConstraint!
    var blueHeightConstraint: NSLayoutConstraint!
    
    lazy var blueView: UIView = {
        let view = BaseView()
        view.backgroundColor = BC
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleBlue))
        view.addGestureRecognizer(tap)
        return view
    }()
    
    var greenTopConstraint: NSLayoutConstraint!
    var greenWidthConstraint: NSLayoutConstraint!
    var greenHeightConstraint: NSLayoutConstraint!
    
    lazy var greenView: UIView = {
        let view = BaseView()
        view.backgroundColor = DE
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleGreen))
        view.addGestureRecognizer(tap)
        return view
    }()
    
    override func setupViews() {
        view.addSubview(blueView)
        view.addConstraints(format: "H:[v0]", views: blueView)
        view.addConstraints(format: "V:[v0]", views: blueView)
        blueView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        blueView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -100).isActive = true
        blueWidthConstraint = blueView.widthAnchor.constraint(equalToConstant: 100)
        blueWidthConstraint.isActive = true
        blueHeightConstraint = blueView.heightAnchor.constraint(equalToConstant: 100)
        blueHeightConstraint.isActive = true
        
        view.addSubview(greenView)
        view.addConstraints(format: "H:[v0]", views: greenView)
        view.addConstraints(format: "V:[v0]", views: greenView)
        greenView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        greenTopConstraint = greenView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 100)
        greenTopConstraint.isActive = true
        greenWidthConstraint = greenView.widthAnchor.constraint(equalToConstant: 100)
        greenWidthConstraint.isActive = true
        greenHeightConstraint = greenView.heightAnchor.constraint(equalToConstant: 100)
        greenHeightConstraint.isActive = true
    }
    
    // MARK: - Action
    
    @objc func handleBlue() {
        blueWidthConstraint.constant = 200
        blueHeightConstraint.constant = 200
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }
    
    @objc func handleGreen() {
        greenWidthConstraint.constant = 200
        greenHeightConstraint.constant = 200
        UIView.animate(withDuration: 0.4) {
            self.view.layoutIfNeeded()
        }
        
        greenTopConstraint.constant = -100
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.35, initialSpringVelocity: 0, options: [], animations: {
            self.view.layoutIfNeeded()
        })
    }
    
}
