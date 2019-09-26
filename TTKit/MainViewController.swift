//
//  MainViewController.swift
//  TTKit
//
//  Created by Tian Tong on 2019/9/4.
//  Copyright © 2019 TTDP. All rights reserved.
//

import UIKit

let BC = UIColor.fromHEX("BCDEFA")
let DE = UIColor.fromHEX("DEFABC")
let FA = UIColor.fromHEX("FABCDE")

class MainViewController: BaseViewController {
    
    let demos = ["Scroll view including View & TableView",
                 "Scroll view including Header & TableView",
                 "UIView animation",
                 "Left Alignment Action Sheet"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "TTKit"
    }
    
    lazy var tableView: UITableView = {
        let table = UITableView()
        table.registerCell(MainTableCell.self)
        table.dataSource = self
        table.delegate = self
        return table
    }()
    
    override func setupViews() {
        view.addSubview(tableView)
        view.addConstraints(format: "H:|[v0]|", views: tableView)
        tableView.topAnchor.constraint(equalTo: naviEdge.bottomAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: bottomEdge.topAnchor).isActive = true
    }
    
}

extension MainViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return demos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(forIndexPath: indexPath) as MainTableCell
        cell.titleLabel.text = demos[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let viewController: UIViewController
        
        switch indexPath.row {
        case 0:
            viewController = ScrollViewController()
        case 1:
            viewController = ScrollHeaderViewController()
        case 2:
            viewController = UIViewAnimationViewController()
        case 3:
            viewController = LeftAlignedActionSheetViewController()
        default:
            viewController = BaseViewController()
        }
        
        navigationController?.pushViewController(viewController, animated: true)
    }
    
}

class MainTableCell: BaseTableCell {
    
    var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.darkGray
        label.textAlignment = .center
        return label
    }()
    
    override func setupViews() {
        addSubview(titleLabel)
        addConstraints(format: "H:|[v0]|", views: titleLabel)
        addConstraints(format: "V:|[v0]|", views: titleLabel)
    }
    
}
