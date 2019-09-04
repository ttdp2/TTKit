//
//  UIViewController+Extension.swift
//  TTKit
//
//  Created by Tian Tong on 2019/9/4.
//  Copyright © 2019 TTDP. All rights reserved.
//

import UIKit

extension UIViewController {
    
    var naviGap: CGFloat {
        return ScreenUtility.hasTopNotch ? 88.0 : 64.0
    }
    
    var bottomGap: CGFloat {
        return ScreenUtility.hasTopNotch ? 34.0 : 0.0
    }
    
    // MARK: - Custom Back Item
    
    func setBackItem(image: UIImage?, title: String = "", color: UIColor? = nil) {
        navigationController?.navigationBar.backIndicatorImage = image
        navigationController?.navigationBar.backIndicatorTransitionMaskImage = image
        navigationItem.backBarButtonItem = UIBarButtonItem(title: title, style: .plain, target: nil, action: nil)
        navigationController?.navigationBar.tintColor = color
    }
    
    // MARK: - Add Sub Controller
    
    func add(_ child: UIViewController) {
        addChild(child)
        view.addSubview(child.view)
        child.didMove(toParent: self)
    }
    
    func remove() {
        guard parent != nil else {
            return
        }
        
        willMove(toParent: nil)
        view.removeFromSuperview()
        removeFromParent()
    }
    
    // MARK: - Keyboard
    
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
}


