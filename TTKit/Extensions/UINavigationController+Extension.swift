//
//  UINavigationController+Extension.swift
//  TTKit
//
//  Created by Tian Tong on 2019/9/4.
//  Copyright © 2019 TTDP. All rights reserved.
//

import UIKit

extension UINavigationController {
    
    var shouldHideBottomBar: Bool {
        get {
            return viewControllers.first?.hidesBottomBarWhenPushed ?? false
        }
        set {
            if let viewController = viewControllers.first {
                viewController.hidesBottomBarWhenPushed = newValue
            }
        }
    }
    
}
