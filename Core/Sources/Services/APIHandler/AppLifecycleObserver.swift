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


public class AppLifecycleTracker {
    public static let shared = AppLifecycleTracker()
    
    public init() {
        // Register for application lifecycle notifications
        NotificationCenter.default.addObserver(self, selector: #selector(appWillEnterForeground), name: UIApplication.willEnterForegroundNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(appDidBecomeActive), name: UIApplication.didBecomeActiveNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(appWillResignActive), name: UIApplication.willResignActiveNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(appDidEnterBackground), name: UIApplication.didEnterBackgroundNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(appWillTerminate), name: UIApplication.willTerminateNotification, object: nil)
    }
    
    deinit {
        // Unregister for notifications when the instance is deallocated
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc func appWillEnterForeground() {
        // Handle app entering the foreground
        print("App entered the foreground")
    }
    
    @objc func appDidBecomeActive() {
        // Handle app becoming active
        print("App became active")
    }
    
    @objc func appWillResignActive() {
        // Handle app resigning active status
        print("App will resign active")
    }
    
    @objc func appDidEnterBackground() {
        // Handle app entering the background
        print("App entered the background")
    }
    
    @objc func appWillTerminate() {
        // Handle app termination
        print("App will terminate")
    }
}

// Usage:
// Create an instance to start tracking

// Don't forget to remove the observer when it's no longer needed to avoid leaks
// For example, in a UIViewController's deinit or when the observing object is deallocated:
// NotificationCenter.default.removeObserver(AppLifecycleTracker.shared)
