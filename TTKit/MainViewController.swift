//
//  MainViewController.swift
//  TTKit
//
//  Created by Tian Tong on 2019/9/4.
//  Copyright © 2019 TTDP. All rights reserved.
//

import UIKit

class MainViewController: BaseViewController {
    
    let demos = ["Pop Up Input Alert",
                 "Scroll view including Header & TableView",
                 "UIView Animation",
                 "Left Alignment Action Sheet",
                 "Image Gallery",
                 "Image Zooming",
                 "Dynamic Table headerView",
                 "Toggle Table Section",
                 "Refresher TableView",
                 "Comment Reply TableView",
                 "Floating Action Button",
                 "Like Button Animation",
                 "Life Circle",
                 "Collection Background Line",
                 "TableView Cell Event",
                 "Bubble Message",
                 "Scroll view including View & TableView"]
    
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
            viewController = PopUpInputViewController()
        case 1:
            viewController = ScrollHeaderViewController()
        case 2:
            viewController = UIViewAnimationViewController()
        case 3:
            viewController = LeftAlignedActionSheetViewController()
        case 4:
            viewController = ImageGalleryViewController()
        case 5:
            viewController = ImageZoomViewController()
        case 6:
            viewController = DynamicTableHeaderViewController()
        case 7:
            viewController = ToggleTableSectionViewController()
        case 8:
            viewController = RefresherViewController()
        case 9:
            viewController = CommentReplyViewController()
        case 10:
            viewController = FloatingActionViewController()
        case 11:
            viewController = LikeAnimationViewController()
        case 12:
            viewController = LifeCircleViewController()
        case 13:
            viewController = CollectionLineViewController()
        case 14:
            viewController = TableViewCellEventViewController()
        case 15:
            viewController = BubbleMessageViewController()
        case 16:
            viewController = ScrollViewController()
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
