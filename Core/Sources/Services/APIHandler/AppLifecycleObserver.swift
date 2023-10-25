//
//  File.swift
//
//
//  Created by khushbu on 28/09/23.
//

import Foundation
import UIKit



public class CausualFoundry {
    
    private var appplication:UIApplication?
    
    public init(appplication: UIApplication? = nil) {
        self.appplication = appplication
    }
    
    
    
    
    public func configure() -> CausualFoundry {
        // Register for application lifecycle notifications
        NotificationCenter.default.addObserver(self, selector: #selector(appDidFinishLaunching), name: UIApplication.didFinishLaunchingNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(appWillEnterForeground), name: UIApplication.willEnterForegroundNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(appDidBecomeActive), name: UIApplication.didBecomeActiveNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(appWillResignActive), name: UIApplication.willResignActiveNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(appDidEnterBackground), name: UIApplication.didEnterBackgroundNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(appWillTerminate), name: UIApplication.willTerminateNotification, object: nil)
        return self
    }
    
    deinit {
        // Unregister for notifications when the instance is deallocated
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc func appWillEnterForeground() {
        CFLogAppEventBuilder().setAppEvent(appAction:.resume)
            .setStartTime(start_time: 1000)
                                .build()
    }
    
    @objc func appDidFinishLaunching() {
        CFLogAppEventBuilder().setAppEvent(appAction:.open)
    }
    
    @objc func appDidBecomeActive() {
        
    }
    
    @objc func appWillResignActive() {
        
        
    }
    
    @objc func appDidEnterBackground() {
        CFLogAppEventBuilder().setAppEvent(appAction:.background)
    }
    
    @objc func appWillTerminate() {
        CFLogAppEventBuilder().setAppEvent(appAction:.close)
    }
}

// Usage:
// Create an instance to start tracking

// Don't forget to remove the observer when it's no longer needed to avoid leaks
// For example, in a UIViewController's deinit or when the observing object is deallocated:
// NotificationCenter.default.removeObserver(AppLifecycleTracker.shared)
