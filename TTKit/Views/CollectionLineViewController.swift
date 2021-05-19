//
//  CollectionLineViewController.swift
//  TTKit
//
//  Created by Tian Tong on 2021/5/14.
//  Copyright © 2021 TTDP. All rights reserved.
//

import UIKit

class CollectionLineViewController: BaseViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.showsHorizontalScrollIndicator = false
        collection.backgroundColor = .clear
        collection.dataSource = self
        collection.delegate = self
        collection.register(TagCollectionCell.self, forCellWithReuseIdentifier: "Cell")
        return collection
    }()
    
    override func setupViews() {
        let line = UIView()
        line.backgroundColor = .cyan
        view.addSubview(line)
        view.addConstraints(format: "H:|[v0]|", views: line)
        view.addConstraints(format: "V:|-179-[v0(1)]", views: line)
        
        view.addSubview(collectionView)
        view.addConstraints(format: "H:|-15-[v0]-15-|", views: collectionView)
        view.addConstraints(format: "V:|-120-[v0(60)]", views: collectionView)
    }
    
    // MARK: - DataSource & Delegate
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 60, height: 60)
    }
    
}

class TagCollectionCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUpViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpViews() {
        backgroundColor = .red
    }
    
}
