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
    func configure() {
        let originalSelector = #selector(self.delegate?.applicationDidBecomeActive(_:))
        let swizzledSelector = #selector(self.applicationDidBecomeActiveNew(_:))
        swizzling(UIApplicationDelegate.self, originalSelector, swizzledSelector)
        
    }
    @objc func applicationDidBecomeActiveNew(_ application: UIApplication) {
        applicationDidBecomeActiveNew(application)
        print("swizzled_layoutSubviews")
    }
    
}



public class lifecycleObserver {
    public var application:UIApplication?
    
    
    public init(application: UIApplication? = nil) {
        self.application = application
    }
    
   public func configure () {
        self.application?.configure()
    }
    
}
