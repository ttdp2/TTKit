//
//  ScrollHeaderViewController.swift
//  TTKit
//
//  Created by Tian Tong on 2019/9/5.
//  Copyright © 2019 TTDP. All rights reserved.
//

import UIKit

class ScrollHeaderViewController: BaseViewController {
    
    lazy var tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.dataSource = self
        table.delegate = self
        table.registerCell(BaseTableCell.self)
        return table
    }()
    
    override func setupViews() {
        view.addSubview(tableView)
        view.addConstraints(format: "H:|[v0]|", views: tableView)
        view.addConstraints(format: "V:|[v0]|", views: tableView)
    }
    
}

extension ScrollHeaderViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = BC
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return nil
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 26
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let letters = "A B C D E F G H I J K L M N O P Q R S T U V W X Y Z".split(separator: " ")
        let cell = tableView.dequeueReusableCell(forIndexPath: indexPath) as BaseTableCell
        cell.textLabel?.text = String(letters[indexPath.row])
        return cell
    }
    
}
