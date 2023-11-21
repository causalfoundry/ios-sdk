//
//  File.swift
//  
//
//  Created by khushbu on 21/11/23.
//

import Foundation
import UIKit


extension UIViewController {
    static func swizzleViewDidAppear() {
        let originalSelector = #selector(UIViewController.viewDidAppear(_:))
        let swizzledSelector = #selector(UIViewController.swizzledViewDidAppear(_:))

        guard let originalMethod = class_getInstanceMethod(UIViewController.self, originalSelector),
              let swizzledMethod = class_getInstanceMethod(UIViewController.self, swizzledSelector) else {
            return
        }

        let didAddMethod = class_addMethod(UIViewController.self, originalSelector,
                                           method_getImplementation(swizzledMethod),
                                           method_getTypeEncoding(swizzledMethod))

        if didAddMethod {
            class_replaceMethod(UIViewController.self, swizzledSelector,
                                method_getImplementation(originalMethod),
                                method_getTypeEncoding(originalMethod))
        } else {
            method_exchangeImplementations(originalMethod, swizzledMethod)
        }
    }

    @objc func swizzledViewDidAppear(_ animated: Bool) {
        // Your custom implementation or tracking code goes here

        // Call the original method implementation
        self.swizzledViewDidAppear(animated)
    }
}
