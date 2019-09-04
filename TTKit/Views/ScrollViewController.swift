//
//  ScrollViewController.swift
//  TTKit
//
//  Created by Tian Tong on 2019/9/4.
//  Copyright © 2019 TTDP. All rights reserved.
//

import UIKit

class ScrollViewController: BaseViewController {
    
    let scrollView: UIScrollView = {
        let view = UIScrollView()
        view.backgroundColor = BC
        return view
    }()
    
    let contentView: UIView = {
        let view = BaseView()
        view.frame = CGRect(x: 0, y: 0, width: ScreenUtility.width, height: ScreenUtility.height + 200)
        return view
    }()
    
    let topView: UIView = {
        let view = BaseView()
        view.backgroundColor = DE
        return view
    }()
    
    lazy var tableView: UITableView = {
        let view = UITableView()
        view.registerCell(BaseTableCell.self)
        view.dataSource = self
        return view
    }()
    
    override func setupViews() {
        view.addSubview(scrollView)
        view.addConstraints(format: "H:|[v0]|", views: scrollView)
        scrollView.topAnchor.constraint(equalTo: naviEdge.topAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: bottomEdge.bottomAnchor).isActive = true
        
        scrollView.delegate = self
        scrollView.addSubview(contentView)
        scrollView.contentSize = contentView.frame.size
        
        contentView.addSubview(topView)
        contentView.addConstraints(format: "H:|[v0]|", views: topView)
        contentView.addConstraints(format: "V:|[v0(200)]", views: topView)

        contentView.addSubview(tableView)
        contentView.addConstraints(format: "H:|[v0]|", views: tableView)
        contentView.addConstraints(format: "V:[v0]|", views: tableView)
        tableView.topAnchor.constraint(equalTo: topView.bottomAnchor).isActive = true
    }
    
}

extension ScrollViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 17
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let letters = "A B C D E F G H I J K L M N O P Q".split(separator: " ")
        let cell = tableView.dequeueReusableCell(forIndexPath: indexPath) as BaseTableCell
        cell.textLabel?.text = String(letters[indexPath.row])
        return cell
    }
    
}

extension ScrollViewController: UIScrollViewDelegate {
    
}
