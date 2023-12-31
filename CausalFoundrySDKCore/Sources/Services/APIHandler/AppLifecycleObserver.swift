//
//  AppLifecycleObserver.swift
//
//
//  Created by khushbu on 28/09/23.
//

import BackgroundTasks
import Foundation
import UIKit

public class CausualFoundry {
    var startTime: Int64?
    var previousStartTime: Int64?
    var pageCreateTime: Int64? = 0
    var pageRenderTime: Int64? = 0
    var oldPageRenderTime: Int64 = 0
    var appStartTime: Int64 = 0

    public static let shared = CausualFoundry()

    public init() {
        appStartTime = Int64(Date().timeIntervalSince1970 * 1000)
    }

    public func configure() {
        setupNotifications()
    }

    deinit {
        // Unregister for notifications when the instance is deallocated
        removeNotifiations()
    }

    @objc func appDidFinishLaunching() {
        // Register Background Task
        let isBackgroundFetchEnabled = UIApplication.shared.backgroundRefreshStatus == .available
        if !isBackgroundFetchEnabled {
            showBAckgroudTaskEnableNotification()
        } else {
            if #available(iOS 13.0, *) {
                WorkerCaller.registerBackgroundTask()
            }
        }
        
        
        var startTime: Int64 = 0
        if(appStartTime != 0){
            let currentTimeMillis = Date().timeIntervalSince1970 * 1000
            startTime = Int64(currentTimeMillis) - appStartTime
        }
        CFLogAppEventBuilder().setAppEvent(appAction: .open)
            .setStartTime(start_time: Int(startTime))
            .build()
    }

    @objc func appWillEnterForeground() {
        CoreConstants.shared.isAppOpen = true

        if CoreConstants.shared.isAppPaused {
            let currentTimeMillis = Date().timeIntervalSince1970 * 1000
            CoreConstants.shared.sessionStartTime = Int64(currentTimeMillis)
            CFLogAppEventBuilder().setAppEvent(appAction: .resume)
                .setStartTime(start_time: 0)
                .build()
        }
        CoreConstants.shared.isAppPaused = false
    }

    @objc func appDidBecomeActive() {
        CoreConstants.shared.isAppOpen = true
    }

    @objc func appWillResignActive() {
        CoreConstants.shared.isAppOpen = false
        CoreConstants.shared.isAppPaused = true
    }
    
    @objc func appDidEnterBackground() {
        let currentTimeMillis = Date().timeIntervalSince1970 * 1000
        CoreConstants.shared.sessionEndTime = Int64(currentTimeMillis)
        CoreConstants.shared.isAppOpen = false
        CFLogAppEventBuilder().setAppEvent(appAction: .background)
            .setStartTime(start_time: 0)
            .build()

        if #available(iOS 13.0, *) {
            WorkerCaller.scheduleBackgroundTasks()
        }
    }

    @objc func appWillTerminate() {
        let currentTimeMillis = Date().timeIntervalSince1970 * 1000
        CoreConstants.shared.sessionEndTime = Int64(currentTimeMillis)

        CFLogAppEventBuilder().setAppEvent(appAction: .close)
            .setStartTime(start_time: 0)
            .build()
    }

    private func setupNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(appDidFinishLaunching), name: UIApplication.didFinishLaunchingNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(appWillEnterForeground), name: UIApplication.willEnterForegroundNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(appDidBecomeActive), name: UIApplication.didBecomeActiveNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(appWillResignActive), name: UIApplication.willResignActiveNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(appDidEnterBackground), name: UIApplication.didEnterBackgroundNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(appWillTerminate), name: UIApplication.willTerminateNotification, object: nil)
        // NotificationCenter.default.addObserver(self, selector: #selector(appWillTerminate), name: UIViewController.showDetailTargetDidChangeNotification, object: nil)
    }

    private func removeNotifiations() {
        NotificationCenter.default.removeObserver(self)
    }
}

extension CausualFoundry {
    func showBAckgroudTaskEnableNotification() {
        if #available(iOS 13.0, *) {
            guard let window = UIApplication.shared.windows.first,
                  let rootViewController = window.rootViewController else {
                    return
                }
            
            let alert = UIAlertController(title: "Enable Background App Refresh", message: "To take full advantage of our app's features, please enable Background App Refresh in your device settings.", preferredStyle: .alert)
            let settingsAction = UIAlertAction(title: "Open Settings", style: .default) { _ in
                if let settingsURL = URL(string: UIApplication.openSettingsURLString) {
                    UIApplication.shared.open(settingsURL)
                }
            }
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            alert.addAction(settingsAction)
            alert.addAction(cancelAction)
            rootViewController.present(alert, animated: true, completion: nil)
        }
    }
}

// Call this in your AppDelegate or somewhere early in your app lifecycle
