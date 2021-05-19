//
//  LifeCircleViewController.swift
//  TTKit
//
//  Created by Tian Tong on 2021/5/10.
//  Copyright © 2021 TTDP. All rights reserved.
//

import UIKit

class LifeCircleViewController: BaseViewController, UITableViewDataSource, UITableViewDelegate {
    
    lazy var tableView: BaseTableView = {
        let tableView = BaseTableView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.registerCell(BaseTableCell.self)
        return tableView
    }()
    
    override func setupViews() {
        view.backgroundColor = .magenta
        
        view.addSubview(tableView)
        view.addConstraints(format: "H:|[v0]|", views: tableView)
        view.addConstraints(format: "V:|[v0]|", views: tableView)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(#function)
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(forIndexPath: indexPath) as BaseTableCell
        cell.backgroundColor = .lightGray
        return cell
    }
    
}
