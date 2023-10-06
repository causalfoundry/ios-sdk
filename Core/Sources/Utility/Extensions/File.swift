//
//  File.swift
//
//
//  Created by khushbu on 06/10/23.
//

import Foundation
import UIKit


extension UIViewController {
    @objc func didappearSwizzlingMethod() {
        self.didappearSwizzlingMethod()
        debugPrint("Swizzling Didappear method called")
    }
    
    static func startSwizzlingDidappear() {
        let defaultSelector = #selector(self.viewDidAppear(_:))
        let newSelector = #selector(didappearSwizzlingMethod)
        
        // 2
        let defaultInstace = class_getInstanceMethod(UIViewController.self, defaultSelector)
        let newInstance = class_getInstanceMethod(UIViewController.self, newSelector)
        
        // 3
        if let instance1 = defaultInstace, let instance2 = newInstance {
            debugPrint("Swizzlle for all view controller success")
            method_exchangeImplementations(instance1, instance2)
        }
    }
}
