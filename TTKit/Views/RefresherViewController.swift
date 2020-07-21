//
//  RefresherViewController.swift
//  TTKit
//
//  Created by Tian Tong on 2019/11/27.
//  Copyright © 2019 TTDP. All rights reserved.
//

import UIKit

class RefresherViewController: BaseViewController, UITableViewDataSource {
    
    // MARK: - View
    
    var refresher: UIRefreshControl!
    
    let tableView = UITableView()
    
    override func setupViews() {
        view.addSubview(tableView)
        view.addConstraints(format: "H:|[v0]|", views: tableView)
        view.addConstraints(format: "V:|[v0]|", views: tableView)
        
        tableView.backgroundColor = .white
        tableView.registerCell(RefresherTableCell.self)
        tableView.dataSource = self
        
        setupRefresher()
    }
    
    func setupRefresher() {
        refresher = UIRefreshControl()
        refresher.addTarget(self, action: #selector(handleRefresh), for: .valueChanged)
        tableView.addSubview(refresher)
    }
    
    @objc func handleRefresh() {
        DispatchQueue.global().async {
            sleep(1)
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
                self.refresher.endRefreshing()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(forIndexPath: indexPath) as RefresherTableCell
        return cell
    }
    
}

class RefresherTableCell: BaseTableCell {
    override func setupViews() {
        backgroundColor = Colors.BC
    }
}
