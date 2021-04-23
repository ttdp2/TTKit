//
//  FloatingActionViewController.swift
//  TTKit
//
//  Created by Tian Tong on 2021/4/23.
//  Copyright © 2021 TTDP. All rights reserved.
//

import UIKit

class FloatingActionViewController: BaseViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        closeMenu()
        closeMenu2()
        closeMenu3()
    }
    
    // MARK: - View
    
    let buttonDiameter: CGFloat = 66
    let circleDiameter: CGFloat = 275
    
    lazy var actionView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hex: "#FF931E", alpha: 0.7)
        view.layer.cornerRadius = circleDiameter / 2
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
        button.backgroundColor = UIColor(hex: "#FF931E")
        button.addTarget(self, action: #selector(toggleButton), for: .touchUpInside)
        button.layer.cornerRadius = buttonDiameter / 2
        button.setImage(UIImage(named: "discover_plus"), for: .normal)
        button.alpha = 1
        return button
    }()
    
    
    lazy var actionView2: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hex: "#29ABE2", alpha: 0.7)
        view.layer.cornerRadius = 150
        return view
    }()
    
    lazy var watchButton2: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "discover_vision"), for: .normal)
        return button
    }()
    
    lazy var commentButton2: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "discover_comment"), for: .normal)
        return button
    }()
    
    lazy var likeButton2: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "discover_like"), for: .normal)
        return button
    }()
    
    lazy var actionButton2: UIButton = {
        let button = FloatButton()
        button.backgroundColor = UIColor(hex: "#29ABE2")
        button.addTarget(self, action: #selector(toggleButton2), for: .touchUpInside)
        button.layer.cornerRadius = 30
        button.setImage(UIImage(named: "discover_plus2"), for: .normal)
        button.alpha = 0.8
        return button
    }()
    
    lazy var actionView3: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hex: "#5CC37A", alpha: 0.6)
        view.layer.cornerRadius = circleDiameter / 2
        return view
    }()
    
    lazy var watchButton3: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "discover_vision"), for: .normal)
        return button
    }()
    
    lazy var commentButton3: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "discover_comment"), for: .normal)
        return button
    }()
    
    lazy var likeButton3: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "discover_like"), for: .normal)
        return button
    }()
    
    lazy var actionButton3: UIButton = {
        let button = FloatButton()
        button.backgroundColor = UIColor(hex: "#5CC37A")
        button.addTarget(self, action: #selector(toggleButton3), for: .touchUpInside)
        button.layer.cornerRadius = buttonDiameter / 2
        button.setImage(UIImage(named: "discover_plus"), for: .normal)
        button.alpha = 0.9
        return button
    }()
    
    
    override func setupViews() {
        view.addSubview(actionView)
        view.addSubview(actionButton)
        view.addConstraints(format: "H:[v0(\(buttonDiameter))]-20-|", views: actionButton)
        view.addConstraints(format: "V:[v0(\(buttonDiameter))]", views: actionButton)
        actionButton.bottomAnchor.constraint(equalTo: bottomEdge.topAnchor, constant: -300).isActive = true
        
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
        
        view.addSubview(actionView2)
        view.addSubview(actionButton2)
        view.addConstraints(format: "H:[v0(60)]-15-|", views: actionButton2)
        view.addConstraints(format: "V:[v0(60)]", views: actionButton2)
        actionButton2.bottomAnchor.constraint(equalTo: bottomEdge.topAnchor, constant: -15).isActive = true
        
        view.addConstraints(format: "H:[v0(300)]", views: actionView2)
        view.addConstraints(format: "V:[v0(300)]", views: actionView2)
        actionView2.centerXAnchor.constraint(equalTo: actionButton2.centerXAnchor).isActive = true
        actionView2.centerYAnchor.constraint(equalTo: actionButton2.centerYAnchor).isActive = true
        
        actionView2.addSubview(commentButton2)
        actionView2.addConstraints(format: "V:[v0(44)]", views: commentButton2)
        actionView2.addConstraints(format: "H:[v0(44)]", views: commentButton2)
        commentButton2.centerXAnchor.constraint(equalTo: actionView2.centerXAnchor, constant: 10).isActive = true
        commentButton2.centerYAnchor.constraint(equalTo: actionView2.centerYAnchor, constant: -90).isActive = true
        
        actionView2.addSubview(watchButton2)
        actionView2.addConstraints(format: "V:[v0(44)]", views: watchButton2)
        actionView2.addConstraints(format: "H:[v0(44)]", views: watchButton2)
        watchButton2.centerXAnchor.constraint(equalTo: actionView2.centerXAnchor, constant: -67).isActive = true
        watchButton2.centerYAnchor.constraint(equalTo: actionView2.centerYAnchor, constant: -66).isActive = true
        
        actionView2.addSubview(likeButton2)
        actionView2.addConstraints(format: "V:[v0(44)]", views: likeButton2)
        actionView2.addConstraints(format: "H:[v0(44)]", views: likeButton2)
        likeButton2.centerXAnchor.constraint(equalTo: actionView2.centerXAnchor, constant: -88).isActive = true
        likeButton2.centerYAnchor.constraint(equalTo: actionView2.centerYAnchor, constant: 6).isActive = true
        
        view.addSubview(actionView3)
        view.addSubview(actionButton3)
        view.addConstraints(format: "H:[v0(\(buttonDiameter))]-20-|", views: actionButton3)
        view.addConstraints(format: "V:[v0(\(buttonDiameter))]", views: actionButton3)
        actionButton3.bottomAnchor.constraint(equalTo: bottomEdge.topAnchor, constant: -600).isActive = true
        
        view.addConstraints(format: "H:[v0(\(circleDiameter))]", views: actionView3)
        view.addConstraints(format: "V:[v0(\(circleDiameter))]", views: actionView3)
        actionView3.centerXAnchor.constraint(equalTo: actionButton3.centerXAnchor).isActive = true
        actionView3.centerYAnchor.constraint(equalTo: actionButton3.centerYAnchor).isActive = true
        
        actionView3.addSubview(commentButton3)
        actionView3.addConstraints(format: "V:[v0(44)]", views: commentButton3)
        actionView3.addConstraints(format: "H:[v0(44)]", views: commentButton3)
        commentButton3.centerXAnchor.constraint(equalTo: actionView3.centerXAnchor, constant: 15).isActive = true
        commentButton3.centerYAnchor.constraint(equalTo: actionView3.centerYAnchor, constant: -80).isActive = true
        
        actionView3.addSubview(watchButton3)
        actionView3.addConstraints(format: "V:[v0(44)]", views: watchButton3)
        actionView3.addConstraints(format: "H:[v0(44)]", views: watchButton3)
        watchButton3.centerXAnchor.constraint(equalTo: actionView3.centerXAnchor, constant: -60).isActive = true
        watchButton3.centerYAnchor.constraint(equalTo: actionView3.centerYAnchor, constant: -55).isActive = true
        
        actionView3.addSubview(likeButton3)
        actionView3.addConstraints(format: "V:[v0(44)]", views: likeButton3)
        actionView3.addConstraints(format: "H:[v0(44)]", views: likeButton3)
        likeButton3.centerXAnchor.constraint(equalTo: actionView3.centerXAnchor, constant: -80).isActive = true
        likeButton3.centerYAnchor.constraint(equalTo: actionView3.centerYAnchor, constant: 15).isActive = true
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
   
    @objc func toggleButton2() {
        UIView.animate(withDuration: 0.3) {
            if self.actionView2.transform == .identity {
                self.closeMenu2()
            } else {
                self.actionView2.transform = .identity
                self.commentButton2.alpha = 1
                self.watchButton2.alpha = 1
                self.likeButton2.alpha = 1
            }
        }
    }
    
    @objc func toggleButton3() {
        UIView.animate(withDuration: 0.3) {
            if self.actionView3.transform == .identity {
                self.closeMenu3()
            } else {
                self.actionView3.transform = .identity
            }
        }
    }
    
    // MARK: - Method
    
    func closeMenu() {
        actionView.transform = CGAffineTransform(scaleX: 0.24, y: 0.24)
    }
    
    func closeMenu2() {
        actionView2.transform = CGAffineTransform(scaleX: 0.2, y: 0.2)
        commentButton2.alpha = 0
        watchButton2.alpha = 0
        likeButton2.alpha = 0
    }
    
    func closeMenu3() {
        actionView3.transform = CGAffineTransform(scaleX: 0.24, y: 0.24)
    }
    
}

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
