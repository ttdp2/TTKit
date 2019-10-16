//
//  DynamicTableHeaderViewController.swift
//  TTKit
//
//  Created by Tian Tong on 2019/10/1.
//  Copyright © 2019 TTDP. All rights reserved.
//

import UIKit

class DynamicTableHeaderViewController: BaseViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        hideKeyboardWhenTappedAround()
    }
    
    lazy var dynamicTable: DynamicTableView = {
        let tableView = DynamicTableView(frame: .zero, style: .grouped)
        tableView.controller = self
        tableView.dataSource = self
        tableView.delegate = self
        tableView.registerCell(DynamicTableCell.self)
        tableView.contentInset = UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
        return tableView
    }()
    
    override func setupViews() {
        view.addSubview(dynamicTable)
        view.addConstraints(format: "H:|[v0]|", views: dynamicTable)
        view.addConstraints(format: "V:|[v0]|", views: dynamicTable)
    }
    
}

extension DynamicTableHeaderViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(forIndexPath: indexPath) as DynamicTableCell
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if let height = dynamicTable.headerViewHeightConstraint?.constant {
            return height + 20
        }
        return 60 + 20
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return dynamicTable.headerView
    }
    
}

class DynamicTableView: BaseTableView, UITextViewDelegate {
    
    weak var controller: DynamicTableHeaderViewController!
    
    let placeholder = "Dynamic text view"
    lazy var textView: UITextView = {
        let view = UITextView()
        view.textColor = .lightGray
        view.text = placeholder
        view.font = UIFont.systemFont(ofSize: 16)
        view.layer.cornerRadius = 5
        view.layer.borderColor = UIColor.lightGray.cgColor
        view.layer.borderWidth = 0.5
        view.isScrollEnabled = false
        view.delegate = self
        return view
    }()
    
    var headerViewHeightConstraint: NSLayoutConstraint?
    lazy var headerView: UIView = {
        let view = UIView()
        view.backgroundColor = Colors.DE
        view.addSubview(textView)
        view.addConstraints(format: "H:|-20-[v0]-20-|", views: textView)
        view.addConstraints(format: "V:|-10-[v0]", views: textView)
        headerViewHeightConstraint = textView.heightAnchor.constraint(equalToConstant: 60)
        headerViewHeightConstraint?.isActive = true
        return view
    }()
    
    // MARK: - TextView Delegate
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == "Dynamic text view" {
            textView.text = ""
        }
        textView.textColor = .black
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text == "" {
            textView.text = "Dynamic text view"
            textView.textColor = .lightGray
        }
    }
    
    func textViewDidChange(_ textView: UITextView) {
        let width = textView.frame.width
        let height = textView.sizeThatFits(CGSize(width: width, height: .infinity)).height
        
        if height > textView.frame.height {
            if height > 60 && height < 120 {
                headerViewHeightConstraint?.constant = height
                
                UIView.animate(withDuration: 0.2) {
                    self.layoutIfNeeded()
                    self.reloadData()
                }
            } else {
                textView.isScrollEnabled = true
            }
        } else {
            headerViewHeightConstraint?.constant = height > 60 ? height : 60
            
            UIView.animate(withDuration: 0.2) {
                self.layoutIfNeeded()
                self.reloadData()
            }
            textView.isScrollEnabled = false
        }
    }
    
}

class DynamicTableCell: BaseTableCell {
    
    lazy var photoView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.image = Images.WWDC
        return imageView
    }()
    
    lazy var deleteButton: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(), for: .normal)
        button.setImage(Images.Delete, for: .normal)
        return button
    }()
    
    override func setupViews() {
        addSubview(photoView)
        addConstraints(format: "H:|-20-[v0]-20-|", views: photoView)
        addConstraints(format: "V:|-10-[v0(200)]-10-|", views: photoView)
        
        addSubview(deleteButton)
        addConstraints(format: "H:[v0(44)]-20-|", views: deleteButton)
        addConstraints(format: "V:|-10-[v0(44)]", views: deleteButton)
        deleteButton.alpha = 0
    }
    
}
