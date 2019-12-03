//
//  CommentReplyViewController.swift
//  TTKit
//
//  Created by Tian Tong on 2019/12/3.
//  Copyright © 2019 TTDP. All rights reserved.
//

import UIKit

class CommentReplyViewController: BaseViewController {
    
    let items: [(name: String, comment: String)] = [("Tian Tong", "I like Swift language!"),
                                                    ("Matt Tian", "My name is Matt, you can call me Matt or Matt Tian, it would be fine."),
                                                    ("Bruce Lee", "He is a famous Chinese actor, born at San Francisco, worked at Hollywood! He is good at GongFu movies."),
                                                    ("Tong Tian", "I am an iOS developer.")]
    
    // MARK: - View
    
    lazy var tableView: BaseTableView = {
        let tableView = BaseTableView(frame: .zero, style: .grouped)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.registerCell(CommentCell.self)
        tableView.registerCell(ReplyCell.self)
        return tableView
    }()
    
    override func setupViews() {
        view.addSubview(tableView)
        view.addConstraints(format: "H:|[v0]|", views: tableView)
        view.addConstraints(format: "V:|[v0]|", views: tableView)
    }
    
}

extension CommentReplyViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(forIndexPath: indexPath) as CommentCell
        let item = items[indexPath.row]
        cell.fullname.text = item.name
        cell.comment.text = item.comment
        return cell
    }
    
}

extension CommentReplyViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
}

class CommentCell: BaseTableCell {
    
    // MARK: - View
    
    var commentViewTrailingConstraint: NSLayoutConstraint!
    
    let commentView: UIView = {
        let view = UIView()
        return view
    }()
    
    let avatar: UIImageView = {
        let view = UIImageView()
        view.clipsToBounds = true
        view.layer.cornerRadius = 16
        view.image = Images.Avatar
        return view
    }()
    
    let fullname: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 17)
        label.textColor = .darkGray
        return label
    }()
    
    let comment: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.numberOfLines = 0
        return label
    }()
    
    override func setupViews() {
        addSubview(commentView)
        addConstraints(format: "H:[v0(\(UIScreen.main.bounds.width))]", views: commentView)
        addConstraints(format: "V:|[v0]|", views: commentView)
        commentViewTrailingConstraint = commentView.trailingAnchor.constraint(equalTo: trailingAnchor)
        commentViewTrailingConstraint.isActive = true
        
        let topLine = UIView()
        topLine.backgroundColor = Colors.DC
        
        addSubview(topLine)
        addConstraints(format: "H:|[v0]|", views: topLine)
        addConstraints(format: "V:|[v0(0.5)]", views: topLine)
        
        commentView.addSubview(avatar)
        commentView.addConstraints(format: "H:|-15-[v0(44)]", views: avatar)
        commentView.addConstraints(format: "V:|-15-[v0(44)]", views: avatar)
        
        commentView.addSubview(fullname)
        commentView.addConstraints(format: "H:|-71-[v0]-15-|", views: fullname)
        commentView.addConstraints(format: "V:|-15-[v0]", views: fullname)
        
        commentView.addSubview(comment)
        commentView.addConstraints(format: "H:|-71-[v0]-15-|", views: comment)
        commentView.addConstraints(format: "V:|-40-[v0]-15-|", views: comment)
    }
    
}

class ReplyCell: BaseTableCell {
    
}
