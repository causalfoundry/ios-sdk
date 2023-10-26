//
//  File.swift
//
//
//  Created by khushbu on 28/09/23.
//

import Foundation
import UIKit



public class CausualFoundry {
    
    var startTime:Int64?
    var previousStartTime:Int64?
    var pageCreateTime:Int64? = 0
    var pageRenderTime:Int64? = 0
    var oldPageRenderTime:Int64 = 0
    
    
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
    
    public func configure(application:UIApplication) {
        self.application = application
    }
    
    deinit {
        // Unregister for notifications when the instance is deallocated
        NotificationCenter.default.removeObserver(self)
    }
    
    
    
    @objc func appDidFinishLaunching() {
        let currentTimeMillis = Date().timeIntervalSince1970 * 1000
        CoreConstants.shared.sessionStartTime = Int64(currentTimeMillis)
        
        CFLogAppEventBuilder().setAppEvent(appAction:.open)
            .setStartTime(start_time: Int(CoreConstants.shared.sessionStartTime))
            .build()
    }
    
    @objc func appWillEnterForeground() {
        CoreConstants.shared.isAppOpen = true
        
        if CoreConstants.shared.isAppPaused {
            let currentTimeMillis = Date().timeIntervalSince1970 * 1000
            CoreConstants.shared.sessionStartTime = Int64(currentTimeMillis)
        }
        CoreConstants.shared.isAppPaused = true
        
        CFLogAppEventBuilder().setAppEvent(appAction:.resume)
            . setStartTime(start_time:0)
            .build()
    }
    
    @objc func appDidEnterBackground() {
        let currentTimeMillis = Date().timeIntervalSince1970 * 1000
        CoreConstants.shared.sessionEndTime = Int64(currentTimeMillis)
        
        CFLogAppEventBuilder().setAppEvent(appAction: .background)
            .setStartTime(start_time:0)
            .build()
    }
    
    
    @objc func appDidBecomeActive() {
        
    }
    
    @objc func appWillResignActive() {
        
        
    }
    
    
    
    @objc func appWillTerminate() {
        let currentTimeMillis = Date().timeIntervalSince1970 * 1000
        CoreConstants.shared.sessionEndTime = Int64(currentTimeMillis)
        
        CFLogAppEventBuilder().setAppEvent(appAction: .close)
            .setStartTime(start_time:0)
            .build()
    }
}

