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
        return Bundle.main.path(forResource: self.className, ofType: "swift")!
    }
    
    
    @objc func viewDidLoadSwizzlingMethod() {
        self.viewDidLoadSwizzlingMethod()
        CfLogPageBuilder().setContentBlock(content_block:.core)
                          .setTitle(title:self.className)
                          .setPath(path:self.path)
                          .setDuration(duration: 300)
                          .build()
                             
        
    }
    
    static func startSwizzlingDidappear() {
        let defaultSelector = #selector(self.viewDidAppear(_:))
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
}
