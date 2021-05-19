//
//  TableCellEventViewController.swift
//  TTKit
//
//  Created by Tian Tong on 2021/5/19.
//  Copyright © 2021 TTDP. All rights reserved.
//

import UIKit

class TableViewCellEventViewController: BaseViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nextButton = UIBarButtonItem(title: "Next", style: .done, target: self, action: #selector(nextV))
        navigationItem.rightBarButtonItem = nextButton
    }
    
    override func setupViews() {
        view.backgroundColor = .lightGray
    }
    
    // MARK: - Action
    
    @objc func nextV() {
        navigationController?.pushViewController(NextViewController(), animated: true)
    }
    
}

class NextViewController: BaseViewController {
    
    deinit {
        print("Here we go")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .darkGray
    }
    
}
