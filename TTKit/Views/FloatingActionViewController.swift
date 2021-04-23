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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        closeMenu()
    }
    
    // MARK: - View
    
    let buttonDiameter = 66
    let circleDiameter = 275
    
    lazy var actionView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hex: "#29ABE2", alpha: 0.7)
        view.layer.cornerRadius = 137.5
        return view
    }()
    
    lazy var watchButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "discover_vision"), for: .normal)
        return button
    }()
    
    lazy var commentButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "discover_comment"), for: .normal)
        return button
    }()
    
    lazy var likeButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "discover_like"), for: .normal)
        return button
    }()
    
    lazy var actionButton: UIButton = {
        let button = FloatButton()
        button.backgroundColor = UIColor(hex: "#29ABE2")
        button.addTarget(self, action: #selector(toggleButton), for: .touchUpInside)
        button.layer.cornerRadius = 33
        button.setImage(UIImage(named: "discover_plus"), for: .normal)
        return button
    }()
    
    override func setupViews() {
        view.addSubview(actionView)
        view.addSubview(actionButton)
        view.addConstraints(format: "H:[v0(\(buttonDiameter))]-20-|", views: actionButton)
        view.addConstraints(format: "V:[v0(\(buttonDiameter))]", views: actionButton)
        actionButton.bottomAnchor.constraint(equalTo: bottomEdge.topAnchor, constant: -20).isActive = true
        
        view.addConstraints(format: "H:[v0(\(circleDiameter))]", views: actionView)
        view.addConstraints(format: "V:[v0(\(circleDiameter))]", views: actionView)
        actionView.centerXAnchor.constraint(equalTo: actionButton.centerXAnchor).isActive = true
        actionView.centerYAnchor.constraint(equalTo: actionButton.centerYAnchor).isActive = true
        
        actionView.addSubview(commentButton)
        actionView.addConstraints(format: "V:[v0(44)]", views: commentButton)
        actionView.addConstraints(format: "H:[v0(44)]", views: commentButton)
        commentButton.centerXAnchor.constraint(equalTo: actionView.centerXAnchor, constant: 15).isActive = true
        commentButton.centerYAnchor.constraint(equalTo: actionView.centerYAnchor, constant: -80).isActive = true
        
        actionView.addSubview(watchButton)
        actionView.addConstraints(format: "V:[v0(44)]", views: watchButton)
        actionView.addConstraints(format: "H:[v0(44)]", views: watchButton)
        watchButton.centerXAnchor.constraint(equalTo: actionView.centerXAnchor, constant: -60).isActive = true
        watchButton.centerYAnchor.constraint(equalTo: actionView.centerYAnchor, constant: -55).isActive = true
        
        actionView.addSubview(likeButton)
        actionView.addConstraints(format: "V:[v0(44)]", views: likeButton)
        actionView.addConstraints(format: "H:[v0(44)]", views: likeButton)
        likeButton.centerXAnchor.constraint(equalTo: actionView.centerXAnchor, constant: -80).isActive = true
        likeButton.centerYAnchor.constraint(equalTo: actionView.centerYAnchor, constant: 15).isActive = true
    }
    
    // MARK: - Action
    
    @objc func toggleButton() {
        UIView.animate(withDuration: 0.3) {
            if self.actionView.transform == .identity {
                self.closeMenu()
            } else {
                self.actionView.transform = .identity
            }
        }
    }
    
    // MARK: - Method
    
    func closeMenu() {
        actionView.transform = CGAffineTransform(scaleX: 0.24, y: 0.24)
    }
    
}
