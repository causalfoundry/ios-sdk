//
//  File.swift
//
//
//  Created by khushbu on 28/09/23.
//

import Foundation
import UIKit



public class CausualFoundry {
    
    public static let shared = CausualFoundry()
    var application:UIApplication?
    public init() {
       NotificationCenter.default.addObserver(self, selector: #selector(appDidFinishLaunching), name: UIApplication.didFinishLaunchingNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(appWillEnterForeground), name: UIApplication.willEnterForegroundNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(appDidBecomeActive), name: UIApplication.didBecomeActiveNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(appWillResignActive), name: UIApplication.willResignActiveNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(appDidEnterBackground), name: UIApplication.didEnterBackgroundNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(appWillTerminate), name: UIApplication.willTerminateNotification, object: nil)
    }
    
    func configure(application:UIApplication) {
        self.application = application
    }
    
    deinit {
        // Unregister for notifications when the instance is deallocated
       NotificationCenter.default.removeObserver(self)
    }
    
    @objc func appWillEnterForeground() {
        CFLogBuilder(application:application!).setAutoShowInAppNudge(showInAppNudge: false)
            .setLifecycleEvent(event: .active)
    }
    
    @objc func appDidFinishLaunching() {
        CFLogAppEventBuilder().setAppEvent(appAction:.open)
    }
    
    @objc func appDidBecomeActive() {
        
    }
    
    @objc func appWillResignActive() {
        
        
    }
    
    @objc func appDidEnterBackground() {
        CFLogBuilder(application:application!).setAutoShowInAppNudge(showInAppNudge: false)
            .setLifecycleEvent(event: .background)
    }
    
    
    @objc func appWillTerminate() {
        CFLogAppEventBuilder().setAppEvent(appAction: .close)
    }
}
    
