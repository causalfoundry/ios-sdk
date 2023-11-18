//
//  CausualFoundry.swift
//
//
//  Created by khushbu on 28/09/23.
//

import Foundation
import UIKit
import BackgroundTasks



public class CausualFoundry {
    var backgroundTask: UIBackgroundTaskIdentifier = UIBackgroundTaskIdentifier.invalid

    
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
        // Register Background Task
        let isBackgroundFetchEnabled = self.application!.backgroundRefreshStatus == .available
//        if !isBackgroundFetchEnabled {
//            showBAckgroudTaskEnableNotification()
//        }else {
//            WorkerCaller().scheduleBackgroundTask()
//        }
      
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
            CFLogAppEventBuilder().setAppEvent(appAction:.resume)
                .setStartTime(start_time:0)
                .build()
        }
        CoreConstants.shared.isAppPaused = true
    }
    
 
    
    @objc func appDidEnterBackground() {
        let currentTimeMillis = Date().timeIntervalSince1970 * 1000
        CoreConstants.shared.sessionEndTime = Int64(currentTimeMillis)
        
        CFLogAppEventBuilder().setAppEvent(appAction: .background)
            .setStartTime(start_time:0)
            .build()
        
        backgroundTask = self.application!.beginBackgroundTask { [weak self] in
            guard let self =  self else {return }
            self.application!.endBackgroundTask(self.backgroundTask )
            self.backgroundTask = UIBackgroundTaskIdentifier.invalid
        }

            WorkerCaller.performAPICalls()

            // Ensure to end the background task when your work is done
            self.application!.endBackgroundTask(backgroundTask)
            backgroundTask = UIBackgroundTaskIdentifier.invalid
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



extension CausualFoundry {
    func showBAckgroudTaskEnableNotification() {
        let alert = UIAlertController(title: "Enable Background App Refresh", message: "To take full advantage of our app's features, please enable Background App Refresh in your device settings.", preferredStyle: .alert)
    
               let settingsAction = UIAlertAction(title: "Open Settings", style: .default) { (_) in
                   if let settingsURL = URL(string: UIApplication.openSettingsURLString) {
                       UIApplication.shared.open(settingsURL)
                   }
               }

               let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)

               alert.addAction(settingsAction)
               alert.addAction(cancelAction)

               if let topViewController = UIApplication.shared.keyWindow?.rootViewController {
                   topViewController.present(alert, animated: true, completion: nil)
               }
    }
}
