//
//  LeftAlignedActionSheetViewController.swift
//  TTKit
//
//  Created by Tian Tong on 2019/9/26.
//  Copyright © 2019 TTDP. All rights reserved.
//

import UIKit

class LeftAlignedActionSheetViewController: BaseViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let actionButton = UIBarButtonItem(title: "Action", style: .done, target: self, action: #selector(handleAction))
        navigationItem.rightBarButtonItem = actionButton
    }
    
    override func setupViews() {
        view.backgroundColor = Colors.BC
    }
    
    // MARK: - Action
    
    @objc func handleAction() {
        let alertController = UIAlertController(title: "Action Sheet", message: nil, preferredStyle: .actionSheet)
        let rankOne = UIAlertAction(title: "Rank #1: This is number one, hello world swift, go go go!", style: .default)
        rankOne.setValue(CATextLayerAlignmentMode.left, forKey: "titleTextAlignment")
        alertController.addAction(rankOne)
        
        let rankTwo = UIAlertAction(title: "Rank #2: This is number two!", style: .default)
        rankTwo.setValue(CATextLayerAlignmentMode.left, forKey: "titleTextAlignment")
        alertController.addAction(rankTwo)
        
        let rankThree = UIAlertAction(title: "Rank #3: This is number three, hello world swift! And this text has many lines. Go Go Go Go Go!", style: .default)
        rankThree.setValue(CATextLayerAlignmentMode.left, forKey: "titleTextAlignment")
        alertController.addAction(rankThree)
        
        UILabel.appearance(whenContainedInInstancesOf: [UIAlertController.self]).numberOfLines = 2
        
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel))

        present(alertController, animated: true)
    }
    
}
