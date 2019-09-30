//
//  ImageGalleryViewController.swift
//  TTKit
//
//  Created by Tian Tong on 2019/9/30.
//  Copyright © 2019 TTDP. All rights reserved.
//

import UIKit
import Gallery

class ImageGalleryViewController: BaseViewController {

    var photos: [UIImage] = [Images.WWDC!]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(handleAdd))
        navigationItem.rightBarButtonItem = addButton
    
        view.backgroundColor = Colors.BC
    }
    
    lazy var galleryTable: GalleryTableView = {
        let tableView = GalleryTableView()
        tableView.controller = self
        tableView.dataSource = self
        tableView.delegate = self
        tableView.registerCell(GalleryTableCell.self)
        tableView.registerCell(GalleryTableAddCell.self)
        tableView.contentInset = UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
        return tableView
    }()
    
    override func setupViews() {
        view.addSubview(galleryTable)
        view.addConstraints(format: "H:|[v0]|", views: galleryTable)
        view.addConstraints(format: "V:|[v0]|", views: galleryTable)
    }
    
    // MARK: - Method
    
    func gallery(didSelect images: [UIImage]) {
        let count = photos.count
        var indexPaths: [IndexPath] = []
        
        for (index, image) in images.enumerated() {
            photos.append(image)
            indexPaths.append(IndexPath(row: count + index, section: 0))
        }
        
        galleryTable.insertRows(at: indexPaths, with: .fade)
    }
    
    // MARK: - Action
    
    @objc func handleAdd() {
        Config.initialTab = .imageTab
        Config.tabsToShow = [.imageTab, .videoTab]
        
        let gallery = GalleryController()
        gallery.delegate = self
        
        present(gallery, animated: true)
    }
    
    @objc func handleDelete(_ button: UIButton) {
        let index = button.tag
        
        // If delete too quickly, the cells may not finished reloading,
        // the index maybe out of bounds.
        guard index < photos.count else {
            return
        }
        
        photos.remove(at: index)
        
        galleryTable.deleteRows(at: [IndexPath(row: index, section: 0)], with: .fade)
        
        // Need reload all cells to update the delete button tag value.
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.galleryTable.reloadData()
        }
    }
}

class GalleryTableView: BaseTableView {
    
    weak var controller: ImageGalleryViewController!
    
}

class GalleryTableCell: BaseTableCell {
    
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
    }
    
}

class GalleryTableAddCell: BaseTableCell {
    
    let addView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 10
        view.layer.borderWidth = 2
        view.layer.borderColor = Colors.border.cgColor
        return view
    }()
    
    let addButton = UIButton(type: .contactAdd)
    
    override func setupViews() {
        addSubview(addView)
        addConstraints(format: "H:|-20-[v0]-20-|", views: addView)
        addConstraints(format: "V:|-10-[v0]-10-|", views: addView)
        
        addSubview(addButton)
        addConstraints(format: "H:[v0(100)]", views: addButton)
        addConstraints(format: "V:[v0(100)]", views: addButton)
        addButton.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        addButton.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        addButton.isEnabled = false
    }
    
}

extension ImageGalleryViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return photos.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let index = indexPath.row
        if index == photos.count {
            let cell = tableView.dequeueReusableCell(forIndexPath: indexPath) as GalleryTableAddCell
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(forIndexPath: indexPath) as GalleryTableCell
            cell.photoView.image = photos[index]
            cell.deleteButton.tag = index
            cell.deleteButton.addTarget(self, action: #selector(handleDelete), for: .touchUpInside)
            return cell
        }
    }
    
}

extension ImageGalleryViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == photos.count {
            handleAdd()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 220
    }
    
}

extension ImageGalleryViewController: GalleryControllerDelegate {
    
    func galleryController(_ controller: GalleryController, didSelectImages images: [Image]) {
        Image.resolve(images: images) { resolvedImages in
            self.gallery(didSelect: resolvedImages.compactMap { $0 })
        }
        controller.dismiss(animated: true)
    }
    
    func galleryController(_ controller: GalleryController, didSelectVideo video: Video) {
        
    }
    
    func galleryController(_ controller: GalleryController, requestLightbox images: [Image]) {
        
    }
    
    func galleryControllerDidCancel(_ controller: GalleryController) {
        controller.dismiss(animated: true)
    }
    
}
