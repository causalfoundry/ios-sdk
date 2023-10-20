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


public protocol AppLifecycleObserver {
    func appDidFinishLaunching()
    func appDidEnterBackground()
    func appDidBecomeActive()
    func appWillResignActive()
    func appWillTerminate()
    func appWillEnterForeground()
}





public class CausulFoundry:NSObject {
    
   public var lifecycleObservers: [AppLifecycleObserver] = []
    
    public override init() {
        
    }
    public func configure(){
//        UIViewController.startSwizzlingViewDidLoad()
//        UIViewController.startSwizzlingDidDisapper()
                
    }
    
    // lifecycle observers Event
    func appDidFinishLaunching() {
        for observer in lifecycleObservers {
            observer.appDidFinishLaunching()
        }
    }

    func appDidEnterBackground() {
        for observer in lifecycleObservers {
            observer.appDidEnterBackground()
        }
    }
    
    func appDidBecomeActive() {
        for observer in lifecycleObservers {
            observer.appDidBecomeActive()
        }
    }
    
    func appWillResignActive() {
        for observer in lifecycleObservers {
            observer.appWillResignActive()
        }
     }
    
    func appWillTerminate() {
        for observer in lifecycleObservers {
            observer.appWillTerminate()
        }
    }
    
    func appWillEnterForeground() {
        for observer in lifecycleObservers {
            observer.appWillEnterForeground()
        }
    }
}






