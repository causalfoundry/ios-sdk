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
        let swizzledSelector = #selector(lifecycleObserver().didBecomeActive(_application:))
        swizzling(UIApplication.self, originalSelector, swizzledSelector)
        
    }
}

 extension UIApplicationDelegate {
     
    public func applicationDidBecomeActive(_ application: UIApplication) {
        lifecycleObserver().didBecomeActive(_application: application)
     }
     
    public func applicationDidEnterBackground(_ application: UIApplication) {
         lifecycleObserver().didBecomeActive(_application: application)
     }
}

public class lifecycleObserver: NSObject,UIApplicationDelegate {
    public var application:UIApplication?
    
    
    public init(application: UIApplication? = nil) {
        self.application = application
    }
    
    public func configure () {
        self.application?.configure()
    }
    
    @objc public func didBecomeActive(_application:UIApplication) {
        print("Become active")
    }
    
    public func applicationDidEnterBackground(_ application: UIApplication) {
        print("Enter in Background")
    }
    
}
