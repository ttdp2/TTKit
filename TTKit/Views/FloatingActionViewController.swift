//
//  FloatingActionViewController.swift
//  TTKit
//
//  Created by Tian Tong on 2021/4/23.
//  Copyright © 2021 TTDP. All rights reserved.
//

import UIKit

class FloatButton: UIButton {
    
    var alphaBefore: CGFloat = 1
    
    override func beginTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        alphaBefore = alpha
        
        UIView.animate(withDuration: 0.3) {
            self.alpha = 0.4
            
            if self.transform == .identity {
                self.transform = CGAffineTransform(rotationAngle: 45 * (.pi / 180))
            } else {
                self.transform = .identity
            }
        }
        
        return true
    }
    
    override func endTracking(_ touch: UITouch?, with event: UIEvent?) {
        UIView.animate(withDuration: 0.35) {
            self.alpha = self.alphaBefore
        }
    }
    
}

class FloatingActionViewController: BaseViewController {
    
    // MARK: - View
    
    lazy var floatButton: UIButton = {
        let button = FloatButton()
        button.backgroundColor = .lightGray
        button.setTitle("Action", for: .normal)
//        button.addAnimation()
        return button
    }()
    
    override func setupViews() {
        view.addSubview(floatButton)
        view.addConstraints(format: "H:[v0(100)]", views: floatButton)
        view.addConstraints(format: "V:[v0(100)]", views: floatButton)
        floatButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        floatButton.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    // MARK: - Action
    
    @objc func toggleButton() {
        
    }
    
}
