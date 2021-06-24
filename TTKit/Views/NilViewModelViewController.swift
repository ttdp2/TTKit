//
//  NilViewModelViewController.swift
//  TTKit
//
//  Created by Tian Tong on 2021/6/24.
//  Copyright © 2021 TTDP. All rights reserved.
//

import UIKit

class NilViewModelViewController: BaseViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nextButton = UIBarButtonItem(title: "Next", style: .plain, target: self, action: #selector(handleNext))
        navigationItem.rightBarButtonItem = nextButton
    }
    
    // MARK: - Action
    
    @objc func handleNext() {
        NilNextCoordinator().start()
    }
    
}

class NilNextCoordinator: NilNextViewModelCoordiantor {
    
    deinit {
        print("Deinit nil Next Coordinator")
    }
    
    func start() {
        let rootVC = UIApplication.shared.keyWindow?.rootViewController
        
        if let rootNav = rootVC as? UINavigationController {
            let topVC = rootNav.visibleViewController
            
            let nilNextVM = NilNextViewModel()
            nilNextVM.coordinator = self
            
            let nilNextVC = NilNextViewController(viewModel: nilNextVM)
            topVC?.navigationController?.pushViewController(nilNextVC, animated: true)
        }
    }
    
    func haha() {
        
    }
    
}

protocol NilNextViewModelCoordiantor {
    func haha()
}

class NilNextViewModel {
    
    var coordinator: NilNextViewModelCoordiantor?
    
    deinit {
        print("Deinit nil Next ViewModel")
    }
    
    let bio = "I am nil"
}

class NilNextViewController: BaseViewController {
    
    deinit {
        print("Deinit nil Next ViewController")
    }
    
    let viewModel: NilNextViewModel
    
    init(viewModel: NilNextViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var tableView: NilNextTableView = {
        let tableView = NilNextTableView(viewModel: viewModel)
        tableView.controller = self
        return tableView
    }()
    
    override func setupViews() {
        view.addSubview(tableView)
        view.addConstraints(format: "H:|[v0]|", views: tableView)
        view.addConstraints(format: "V:|[v0]|", views: tableView)
    }
    
}

class NilNextTableView: BaseTableView, UITableViewDataSource, UITableViewDelegate {
    
    deinit {
        print("Deinit nil Next TableView")
    }
    
    let viewModel: NilNextViewModel
    weak var controller: NilNextViewController?
    
    init(viewModel: NilNextViewModel) {
        self.viewModel = viewModel
        super.init(frame: .zero, style: .plain)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setupViews() {
        dataSource = self
        delegate = self
        
        registerCell(BaseTableCell.self)
    }
    
    // MARK: - DateSource & Delegate
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(forIndexPath: indexPath) as BaseTableCell
        cell.textLabel?.text = "\(indexPath)"
        return cell
    }
    
}
