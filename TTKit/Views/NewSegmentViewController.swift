//
//  NewSegmentViewController.swift
//  TTKit
//
//  Created by Tian Tong on 7/29/21.
//  Copyright © 2021 TTDP. All rights reserved.
//

import UIKit

class NewSegmentViewController: BaseViewController {
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .red
    }
    
    // MARK: - View
    
    lazy var naviView: BaseView = {
        let view = BaseView()
        view.alpha = 0
        return view
    }()
    
    lazy var tableView: NewSegmentTableView = {
        let tableView = NewSegmentTableView(frame: .zero, style: .grouped)
        tableView.controller = self
        return tableView
    }()
    
    override func setupViews() {
        view.addSubview(tableView)
        view.addConstraints(format: "H:|[v0]|", views: tableView)
        view.addConstraints(format: "V:|[v0]|", views: tableView)
        
        view.addSubview(naviView)
        view.addConstraints(format: "H:|[v0]|", views: naviView)
        view.addConstraints(format: "V:|[v0(84)]", views: naviView)
    }
}

class NewSegmentTableView: BaseTableView, UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate {
    
    var controller: NewSegmentViewController!
    
    var initialOffsetY: CGFloat = 0
    var isInitialScroll = true
    
    // MARK: - View
    
    lazy var profileView: BaseView = {
        let view = BaseView()
        view.backgroundColor = .lightGray
        return view
    }()
    
    override func setupViews() {
        dataSource = self
        delegate = self
        registerCell(UITableViewCell.self)
    }
    
    // MARK: - Delegate & DateSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 30
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(forIndexPath: indexPath) as UITableViewCell
        cell.textLabel?.text = "\(indexPath)"
        cell.backgroundColor = .blue
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return profileView
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
    
    // MARK: - Scroll View Delegate
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y

        if isInitialScroll {
            initialOffsetY = offsetY
            isInitialScroll = false
        }

        if offsetY > initialOffsetY + 100 {
            UIView.animate(withDuration: 0.3) {
                self.controller.naviView.alpha = 1
            }
        } else {
            UIView.animate(withDuration: 0.3) {
                self.controller.naviView.alpha = 0
            }
        }
    }
    
}
