//
//  File.swift
//
//
//  Created by khushbu on 28/09/23.
//

import Foundation
import UIKit


private let swizzling: (AnyClass, Selector, Selector) -> () = { forClass, originalSelector, swizzledSelector in
    guard
        let originalMethod = class_getInstanceMethod(forClass, originalSelector),
        let swizzledMethod = class_getInstanceMethod(forClass, swizzledSelector)
    else { return }
    method_exchangeImplementations(originalMethod, swizzledMethod)
}

@objc extension UIApplication {
//    func configure() {
//        let originalSelector = #selector(self.delegate?.applicationDidBecomeActive(_:))
//        let swizzledSelector = #selector(lifecycleObserver().didBecomeActive(_application:))
//        swizzling(UIApplication.self, originalSelector, swizzledSelector)
//        
//    }
}


public class CausulFoundry:NSObject {
    
    
    public override init() {
        
    }
    
    
    public func configure(){
        UIViewController.startSwizzlingViewDidLoad()
                
    }
}
