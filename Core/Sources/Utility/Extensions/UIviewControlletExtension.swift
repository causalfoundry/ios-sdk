//
//  File.swift
//
//
//  Created by khushbu on 06/10/23.
//

import Foundation
import UIKit


extension UIViewController {
    
    var className: String {
            NSStringFromClass(self.classForCoder).components(separatedBy: ".").last!
        
    }
    var path:String {
        return "\(Bundle.main.bundleIdentifier ?? "")\(self.className)"
    }
    
    
    @objc func viewDidLoadSwizzlingMethod() {
        self.viewDidLoadSwizzlingMethod()
        CfLogPageBuilder().setContentBlock(content_block:.core)
                          .setTitle(title:self.className)
                          .setPath(path:self.path)
                          .setDuration(duration: 0)
                          .build()
                             
        
    }
    
    @objc func viewDidDisappearSwizzlingMethod() {
        self.viewDidLoadSwizzlingMethod()
        CfLogPageBuilder().setContentBlock(content_block:.core)
                          .setTitle(title:self.className)
                          .setPath(path:self.path)
                          .setDuration(duration: 300)
                          .build()
                             
        
    }
    
    static func startSwizzlingViewDidLoad() {
        let defaultSelector = #selector(self.viewDidLoad)
        let newSelector = #selector(viewDidLoadSwizzlingMethod)
        
        // 2
        let defaultInstace = class_getInstanceMethod(UIViewController.self, defaultSelector)
        let newInstance = class_getInstanceMethod(UIViewController.self, newSelector)
        
        // 3
        if let instance1 = defaultInstace, let instance2 = newInstance {
            debugPrint("Swizzlle for all view controller success")
            method_exchangeImplementations(instance1, instance2)
        }
    }
    
    static func startSwizzlingDidDisapper() {
        let defaultSelector = #selector(self.viewDidDisappear)
        let newSelector = #selector(viewDidDisappearSwizzlingMethod)
        
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
