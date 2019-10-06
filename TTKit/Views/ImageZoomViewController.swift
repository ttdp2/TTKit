//
//  ImageZoomViewController.swift
//  TTKit
//
//  Created by Tian Tong on 2019/10/7.
//  Copyright © 2019 TTDP. All rights reserved.
//

import UIKit

class ImageZoomViewController: BaseViewController {

    override func setupViews() {
        let imageView = ZoomImageView()
        imageView.image = Images.LA16
        view.addSubview(imageView)
        view.addConstraints(format: "H:|[v0]|", views: imageView)
        view.addConstraints(format: "V:|[v0]|", views: imageView)
    }
    
}

open class ZoomImageView : UIScrollView, UIScrollViewDelegate {
    
    public enum ZoomMode {
        case fit
        case fill
    }
    
    // MARK: - Properties
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.allowsEdgeAntialiasing = true
        return imageView
    }()
    
    public var zoomMode: ZoomMode = .fit {
        didSet {
            updateImageView()
            scrollToCenter()
        }
    }
    
    open var image: UIImage? {
        get {
            return imageView.image
        }
        set {
            let oldImage = imageView.image
            imageView.image = newValue
            
            if oldImage?.size != newValue?.size {
                oldSize = nil
                updateImageView()
            }
            scrollToCenter()
        }
    }
    
    open override var intrinsicContentSize: CGSize {
        return imageView.intrinsicContentSize
    }
    
    private var oldSize: CGSize?
    
    // MARK: - Initializers
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    public init(image: UIImage) {
        super.init(frame: CGRect.zero)
        self.image = image
        setup()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    // MARK: - Functions
    open func scrollToCenter() {
        let centerOffset = CGPoint(
            x: contentSize.width > bounds.width ? (contentSize.width / 2) - (bounds.width / 2) : 0,
            y: contentSize.height > bounds.height ? (contentSize.height / 2) - (bounds.height / 2) : 0
        )
        
        contentOffset = centerOffset
    }
    
    open func setup() {
        if #available(iOS 11, *) {
            contentInsetAdjustmentBehavior = .never
        }
        
        backgroundColor = UIColor.clear
        delegate = self
        imageView.contentMode = .scaleAspectFill
        showsVerticalScrollIndicator = false
        showsHorizontalScrollIndicator = false
        addSubview(imageView)
    }
    
    open override func didMoveToSuperview() {
        super.didMoveToSuperview()
    }
    
    open override func layoutSubviews() {
        super.layoutSubviews()
        
        if imageView.image != nil && oldSize != bounds.size {
            
            updateImageView()
            oldSize = bounds.size
        }
        
        if imageView.frame.width <= bounds.width {
            imageView.center.x = bounds.width * 0.5
        }
        
        if imageView.frame.height <= bounds.height {
            imageView.center.y = bounds.height * 0.5
        }
    }
    
    open override func updateConstraints() {
        super.updateConstraints()
        updateImageView()
    }
    
    private func updateImageView() {
        
        func fitSize(aspectRatio: CGSize, boundingSize: CGSize) -> CGSize {
            let widthRatio = (boundingSize.width / aspectRatio.width)
            let heightRatio = (boundingSize.height / aspectRatio.height)
            
            var boundingSize = boundingSize
            
            if widthRatio < heightRatio {
                boundingSize.height = boundingSize.width / aspectRatio.width * aspectRatio.height
            }
            else if (heightRatio < widthRatio) {
                boundingSize.width = boundingSize.height / aspectRatio.height * aspectRatio.width
            }
            
            return CGSize(width: ceil(boundingSize.width), height: ceil(boundingSize.height))
        }
        
        func fillSize(aspectRatio: CGSize, minimumSize: CGSize) -> CGSize {
            let widthRatio = (minimumSize.width / aspectRatio.width)
            let heightRatio = (minimumSize.height / aspectRatio.height)
            
            var minimumSize = minimumSize
            
            if widthRatio > heightRatio {
                minimumSize.height = minimumSize.width / aspectRatio.width * aspectRatio.height
            }
            else if (heightRatio > widthRatio) {
                minimumSize.width = minimumSize.height / aspectRatio.height * aspectRatio.width
            }
            
            return CGSize(width: ceil(minimumSize.width), height: ceil(minimumSize.height))
        }
        
        guard let image = imageView.image else { return }
        
        var size: CGSize
        
        switch zoomMode {
        case .fit:
            size = fitSize(aspectRatio: image.size, boundingSize: bounds.size)
        case .fill:
            size = fillSize(aspectRatio: image.size, minimumSize: bounds.size)
        }
        
        size.height = round(size.height)
        size.width = round(size.width)
        
        zoomScale = 1
        maximumZoomScale = image.size.width / size.width
        imageView.bounds.size = size
        contentSize = size
        imageView.center = ZoomImageView.contentCenter(forBoundingSize: bounds.size, contentSize: contentSize)
    }
    
    // MARK: - UIScrollViewDelegate
    public func scrollViewDidZoom(_ scrollView: UIScrollView) {
        imageView.center = ZoomImageView.contentCenter(forBoundingSize: bounds.size, contentSize: contentSize)
    }
    
    public func scrollViewWillBeginZooming(_ scrollView: UIScrollView, with view: UIView?) {
        
    }
    
    public func scrollViewDidEndZooming(_ scrollView: UIScrollView, with view: UIView?, atScale scale: CGFloat) {
        
    }
    
    public func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
    
    private static func contentCenter(forBoundingSize boundingSize: CGSize, contentSize: CGSize) -> CGPoint {
        /// When the zoom scale changes i.e. the image is zoomed in or out, the hypothetical center
        /// of content view changes too. But the default Apple implementation is keeping the last center
        /// value which doesn't make much sense. If the image ratio is not matching the screen
        /// ratio, there will be some empty space horizontaly or verticaly. This needs to be calculated
        /// so that we can get the correct new center value. When these are added, edges of contentView
        /// are aligned in realtime and always aligned with corners of scrollview.
        let horizontalOffest = (boundingSize.width > contentSize.width) ? ((boundingSize.width - contentSize.width) * 0.5): 0.0
        let verticalOffset = (boundingSize.height > contentSize.height) ? ((boundingSize.height - contentSize.height) * 0.5): 0.0
        
        return CGPoint(x: contentSize.width * 0.5 + horizontalOffest,  y: contentSize.height * 0.5 + verticalOffset)
    }
    
}
