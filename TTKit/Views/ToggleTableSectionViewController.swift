//
//  ToggleTableSectionViewController.swift
//  TTKit
//
//  Created by Tian Tong on 4/16/20.
//  Copyright © 2020 TTDP. All rights reserved.
//

import UIKit

class ToggleTableSectionViewController: BaseViewController {
    
    // MARK: - Property
    
    var headers: [String] {
        return ["Q: Hello world, this is a swift programming blog.",
                "你好，欢迎来到中国旅游，我们的国家是一个文明古国，有着5000年的历史。",
                "Q: I am here, go with me, for seriously. I am here, go with me, for seriously. I am here, go with me, for seriously. I am here, go with me, for seriously."]
    }
    
    var question: [String: Bool] = ["Q0": false, "Q1": false, "Q2": false]
    
    // MARK: - View
    
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
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let key = "Q\(section)"
        let isShow = question[key] ?? false
        print(isShow)
        return isShow ? 2 : 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(forIndexPath: indexPath) as ToggleTableCell
        return cell
    }
    
}

extension ToggleTableSectionViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        let height = heightForView(text: headers[section], font: UIFont.systemFont(ofSize: 18), width: tableView.frame.width - 15 - 10)
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
        view.tag = section
        
        let questionlabel = UILabel()
        questionlabel.font = UIFont.systemFont(ofSize: 18)
        questionlabel.text = headers[section]
        questionlabel.numberOfLines = 0
        view.addSubview(questionlabel)
        view.addConstraints(format: "H:|-15-[v0]-10-|", views: questionlabel)
        view.addConstraints(format: "V:|-10-[v0]", views: questionlabel)
        
        let answerLabel = UILabel()
        answerLabel.font = UIFont.systemFont(ofSize: 16)
        answerLabel.text = "Show 3 answers"
        answerLabel.textColor = .darkGray
        answerLabel.textAlignment = .right
        view.addSubview(answerLabel)
        view.addConstraints(format: "H:[v0]-15-|", views: answerLabel)
        view.addConstraints(format: "V:[v0]-10-|", views: answerLabel)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleToggle))
        view.addGestureRecognizer(tapGesture)
        return view
    }
    
    @objc func handleToggle(_ sender: UITapGestureRecognizer) {
        guard let tag = sender.view?.tag else { return }
        
        let key = "Q\(tag)"
        question[key]?.toggle()
        
        tableView.reloadSections([tag], with: .fade)
    }
    
}
