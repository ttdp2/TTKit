//
//  ToggleTableSectionViewController.swift
//  TTKit
//
//  Created by Tian Tong on 4/16/20.
//  Copyright © 2020 TTDP. All rights reserved.
//

import UIKit

class ToggleTableSectionViewController: BaseViewController {
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.registerCell(ToggleTableCell.self)
        return tableView
    }()
    
    override func setupViews() {
        view.addSubview(tableView)
        view.addConstraints(format: "H:|[v0]|", views: tableView)
        view.addConstraints(format: "V:|[v0]|", views: tableView)
    }
    
}

class ToggleTableCell: BaseTableCell {
    
    override func setupViews() {
        backgroundColor = .magenta
    }
    
}

extension ToggleTableSectionViewController: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(forIndexPath: indexPath) as ToggleTableCell
        return cell
    }
    
}

extension ToggleTableSectionViewController: UITableViewDelegate {
    
    var headers: [String] {
        return ["Q: Hello world, this is a swift programme -ing blog.",
        "Q: I am here, go with me, for seriously. I am here, go with me, for seriously. I am here, go with me, for seriously. I am here, go with me, for seriously."]
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        let height = heightForView(text: headers[section], font: UIFont.systemFont(ofSize: 18), width: tableView.frame.width - 30)
        print("\(section): \(height)")
        return height + 50
    }
    
    func heightForView(text:String, font:UIFont, width:CGFloat) -> CGFloat{
        let label:UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: width, height:CGFloat.greatestFiniteMagnitude))
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.font = font
        label.text = text

        label.sizeToFit()
        return label.frame.height
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        let questionlabel = UILabel()
        questionlabel.font = UIFont.systemFont(ofSize: 18)
        questionlabel.text = headers[section]
        questionlabel.numberOfLines = 0
        view.addSubview(questionlabel)
        view.addConstraints(format: "H:|-15-[v0]-15-|", views: questionlabel)
        view.addConstraints(format: "V:|-10-[v0]", views: questionlabel)
        
        let answerLabel = UILabel()
        answerLabel.font = UIFont.systemFont(ofSize: 16)
        answerLabel.text = "Show 3 answers"
        answerLabel.textColor = .darkGray
        answerLabel.textAlignment = .right
        view.addSubview(answerLabel)
        view.addConstraints(format: "H:[v0]-15-|", views: answerLabel)
        view.addConstraints(format: "V:[v0]-10-|", views: answerLabel)
        return view
    }
    
}
