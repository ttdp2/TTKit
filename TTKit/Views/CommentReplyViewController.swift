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
        cell.indexPath = indexPath
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

protocol CommentDelegate: AnyObject {
    func reply(to indexPath: IndexPath)
}

class CommentCell: BaseTableCell {
    
    // MARK: - Property
    
    weak var delegate: CommentDelegate?
    
    var indexPath: IndexPath!
    var isTapped = false
    
    // MARK: - View
    
    var commentViewTrailingConstraint: NSLayoutConstraint!
    
    let commentView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
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
    
    lazy var replyButton: UIButton = {
        let button = UIButton()
        button.setImage(Images.Reply, for: .normal)
        button.addTarget(self, action: #selector(handleReply), for: .touchUpInside)
        return button
    }()
    
    override func setupViews() {
        backgroundColor = UIColor.fromHEX("#F8F8F8")
        
        addSubview(commentView)
        addConstraints(format: "H:[v0(\(UIScreen.main.bounds.width))]", views: commentView)
        addConstraints(format: "V:|[v0]|", views: commentView)
        commentViewTrailingConstraint = commentView.trailingAnchor.constraint(equalTo: trailingAnchor)
        commentViewTrailingConstraint.isActive = true
        
        addSubview(replyButton)
        addConstraints(format: "H:[v0(56)]", views: replyButton)
        addConstraints(format: "V:|[v0]|", views: replyButton)
        replyButton.leadingAnchor.constraint(equalTo: commentView.trailingAnchor).isActive = true
        
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
    
    // MARK: - Method
    
    private var isReady = false
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        guard isReady else { isReady = true; return }
        
        commentViewTrailingConstraint.constant = selected ? -56 : 0
        if isTapped && selected {
            commentViewTrailingConstraint.constant = 0
            isTapped = false
        } else {
            isTapped = selected
        }
        
        UIView.animate(withDuration: 0.2) {
            self.layoutIfNeeded()
        }
    }
    
    // MARK: - Action
    
    @objc func handleReply() {
        delegate?.reply(to: indexPath)
    }
    
}

class ReplyCell: BaseTableCell {
    
}
