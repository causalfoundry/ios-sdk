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
    
@discardableResult
    public func configure() -> CausualFoundry {
        // Register for application lifecycle notifications
        NotificationCenter.default.addObserver(self, selector: #selector(appDidFinishLaunching), name: UIApplication.didFinishLaunchingNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(appWillEnterForeground), name: UIApplication.willEnterForegroundNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(appDidEnterBackground), name: UIApplication.didEnterBackgroundNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(appWillTerminate), name: UIApplication.willTerminateNotification, object: nil)
        return self
    }
    
    deinit {
        // Unregister for notifications when the instance is deallocated
        NotificationCenter.default.removeObserver(self)
    }
    
    
    
    @objc func appDidFinishLaunching() {
        CFLogBuilder(application: self.appplication!)
            .setAppLevelContentBlock(contentBlock:.core)
            .setSdkKey(sdkKey:"")
            .disableAutoPageTrack()
            .setAppLevelContentBlock(contentBlock: ContentBlock.core)
            .build()
    }

    @objc func appDidEnterBackground() {
        CFLogBuilder(application: self.appplication!)
            .setAppLevelContentBlock(contentBlock:.core)
            .setLifecycleEvent(event:.background)
            .build()
    }
    
    @objc func appWillEnterForeground() {
        CFLogBuilder(application: self.appplication!)
            .setAppLevelContentBlock(contentBlock:.core)
            .setLifecycleEvent(event:.active)
            .build()
    }
    
    @objc func appWillTerminate() {
        CFLogBuilder(application: self.appplication!)
            .setAppLevelContentBlock(contentBlock:.core)
            .setLifecycleEvent(event:.inactive)
            .build()
    }
}

// Usage:
// Create an instance to start tracking

// Don't forget to remove the observer when it's no longer needed to avoid leaks
// For example, in a UIViewController's deinit or when the observing object is deallocated:
// NotificationCenter.default.removeObserver(AppLifecycleTracker.shared)
