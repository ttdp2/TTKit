//
//  ScrollViewController.swift
//  TTKit
//
//  Created by Tian Tong on 2019/9/4.
//  Copyright © 2019 TTDP. All rights reserved.
//

import UIKit

class ScrollViewController: BaseViewController {
    
    lazy var scrollView: UIScrollView = {
        let view = UIScrollView()
        view.backgroundColor = Colors.BC
        view.delegate = self
        view.bounces = false
        return view
    }()
    
    let scrollViewContentHeight = ScreenUtility.height + 200
    let contentView: UIView = {
        let view = BaseView()
        view.frame = CGRect(x: 0, y: 0, width: ScreenUtility.width, height: ScreenUtility.height + 200)
        return view
    }()
    
    let topView: UIView = {
        let view = BaseView()
        view.backgroundColor = Colors.DE
        return view
    }()
    
    lazy var tableView: UITableView = {
        let view = UITableView()
        view.registerCell(BaseTableCell.self)
        view.dataSource = self
        view.delegate = self
        view.isScrollEnabled = false
        return view
    }()
    
    override func setupViews() {
        view.addSubview(scrollView)
        view.addConstraints(format: "H:|[v0]|", views: scrollView)
        scrollView.topAnchor.constraint(equalTo: naviEdge.topAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: bottomEdge.bottomAnchor).isActive = true

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

extension ScrollViewController: UITableViewDataSource, UITableViewDelegate {
    
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

extension ScrollViewController: UIScrollViewDelegate {

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView == self.scrollView {
            tableView.isScrollEnabled = (self.scrollView.contentOffset.y >= 200)
        }
        
        if scrollView == self.tableView {
            self.tableView.isScrollEnabled = (tableView.contentOffset.y > 0)
        }

    }
    
}
