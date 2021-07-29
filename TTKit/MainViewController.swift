//
//  MainViewController.swift
//  TTKit
//
//  Created by Tian Tong on 2019/9/4.
//  Copyright © 2019 TTDP. All rights reserved.
//

import UIKit

class MainViewController: BaseViewController {
    
    let demos = ["HTTP SSL View",
                 "Pop Up Input Alert",
                 "Pop Up Label View",
                 "Nil ViewModel Controller",
                 "Multi Label View",
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
                 "UIView Animation",
                 "Scroll view including View & TableView",
                 "Scroll view including Header & TableView"]
    
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
            viewController = HTTPSSLViewController()
        case 1:
            viewController = PopUpInputViewController()
        case 2:
            viewController = LabelViewController()
        case 3:
            viewController = NilViewModelViewController()
        case 4:
            viewController = MultiLabelViewController()
        case 5:
            viewController = LeftAlignedActionSheetViewController()
        case 6:
            viewController = ImageGalleryViewController()
        case 7:
            viewController = ImageZoomViewController()
        case 8:
            viewController = DynamicTableHeaderViewController()
        case 9:
            viewController = ToggleTableSectionViewController()
        case 10:
            viewController = RefresherViewController()
        case 11:
            viewController = CommentReplyViewController()
        case 12:
            viewController = FloatingActionViewController()
        case 13:
            viewController = LikeAnimationViewController()
        case 14:
            viewController = LifeCircleViewController()
        case 15:
            viewController = CollectionLineViewController()
        case 16:
            viewController = TableViewCellEventViewController()
        case 17:
            viewController = BubbleMessageViewController()
        case 18:
            viewController = UIViewAnimationViewController()
        case 19:
            viewController = ScrollViewController()
        case 20:
            viewController = ScrollHeaderViewController()
            
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
