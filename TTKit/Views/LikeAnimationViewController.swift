//
//  LikeAnimationViewController.swift
//  TTKit
//
//  Created by Tian Tong on 2021/4/26.
//  Copyright © 2021 TTDP. All rights reserved.
//

import UIKit

class LikeAnimationViewController: BaseViewController {
    
    var isLiked = false
    
    // MARK: - View
    
    lazy var likeButton: LikeButton = {
        let button = LikeButton()
        button.addTarget(self, action: #selector(toggleLike), for: .touchUpInside)
        return button
    }()
    
    let likeImage = UIImage(named: "heart_color")
    let unlikeImage = UIImage(named: "heart")
    
    override func setupViews() {
        view.addSubview(likeButton)
        view.addConstraints(format: "H:[v0(32)]", views: likeButton)
        view.addConstraints(format: "V:[v0(32)]", views: likeButton)
        likeButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        likeButton.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        likeButton.isLiked = true
    }
    
    // MARK: - Action
    
    @objc func toggleLike() {
        likeButton.toggle()
    }
    
}

class LikeButton: UIButton {
    
    var isLiked = false {
        didSet {
            let image = isLiked ? likeImage : unlikeImage
            setImage(image, for: .normal)
        }
    }
    
    private let likeImage = UIImage(named: "heart_color")
    private let unlikeImage = UIImage(named: "heart")
    
    private let likeScale: CGFloat = 1.2
    private let unlikeScale: CGFloat = 0.8
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setImage(unlikeImage, for: .normal)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func toggle() {
        isLiked.toggle()
        animate()
    }
    
    private func animate() {
        UIView.animate(withDuration: 0.1) {
            let newImage = self.isLiked ? self.likeImage : self.unlikeImage
            let newScale = self.isLiked ? self.likeScale : self.unlikeScale
            self.transform = CGAffineTransform(scaleX: newScale, y: newScale)
            self.setImage(newImage, for: .normal)
        } completion: { _ in
            UIView.animate(withDuration: 0.1) {
                self.transform = .identity
            }
        }
    }
    
}
