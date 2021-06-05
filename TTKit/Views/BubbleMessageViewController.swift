//
//  BubbleMessageViewController.swift
//  TTKit
//
//  Created by Tian Tong on 6/5/21.
//  Copyright © 2021 TTDP. All rights reserved.
//

import UIKit

class BubbleMessageViewController: BaseViewController {
    
    let text = "Warning once only: Detected a case where constraints ambiguously suggest a height of zero for a table view cell's content view."
    
    let sentImage = Images.BubbleSent
    let receivedImage = Images.BubbleReceived
    
    let bubbleView = UIImageView()
    let contentLabel = UILabel()
    
    override func setupViews() {
        contentLabel.numberOfLines = 0
        contentLabel.font = UIFont.systemFont(ofSize: 18)
        contentLabel.text = text
        contentLabel.textColor = .white
        
        let constraintRect = CGSize(width: 0.66 * view.frame.width, height: .greatestFiniteMagnitude)
        
        let boundingBox = text.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [.font: contentLabel.font!], context: nil)
        contentLabel.frame.size = CGSize(width: ceil(boundingBox.width), height: ceil(boundingBox.height))
        
        let bubbleImageSize = CGSize(width: contentLabel.frame.width + 28, height: contentLabel.frame.height + 20)
        
//        let bubbleView = UIImageView(frame: CGRect(x: view.frame.width - bubbleImageSize.width - 20, y: view.frame.height - bubbleImageSize.height - 86, width: bubbleImageSize.width, height: bubbleImageSize.height))
        
        let bubbleView = UIImageView(frame: CGRect(x: 0,
                                                   y: 100,
                                                   width: bubbleImageSize.width,
                                                   height: bubbleImageSize.height))
        
        let bubbleImage = Images.BubbleSent?
            .resizableImage(withCapInsets: UIEdgeInsets(top: 17, left: 21, bottom: 17, right: 21),
                            resizingMode: .stretch)
            .withRenderingMode(UIImage.RenderingMode.alwaysTemplate)
        
        bubbleView.image = bubbleImage

        let backView = UIView()
        backView.backgroundColor = .black

        view.addSubview(backView)
        view.addSubview(bubbleView)
        view.addSubview(contentLabel)
        
        contentLabel.center = bubbleView.center
        
        view.addConstraints(format: "H:|[v0]|", views: backView)
        backView.topAnchor.constraint(equalTo: bubbleView.topAnchor).isActive = true
        backView.bottomAnchor.constraint(equalTo: bubbleView.bottomAnchor).isActive = true
    }
    
}
