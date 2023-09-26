//
//  AppDelegate.swift
//  Test_CHW_App
//
//  Created by khushbu on 10/09/23.
//

import UIKit
import CHW_SDK

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        let application = UIApplication.value(forKeyPath: #keyPath(UIApplication.shared)) as! UIApplication
        
        let objCHW = CHW_SDK.CFLog.Builder(application:application)
        //objCHW.setSdkKey(sdkKey: "ai.causalfoundry.android.sdk.APPLICATION_KEY")
        objCHW.disableAutoPageTrack()
        objCHW.setAppLevelContentBlock(contentBlock: ContentBlock.core)
        objCHW.setApplicationCurrentState(currentState: application.applicationState)
        objCHW.build()
        return true
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
       let cFLogAppObj =  CFLogAppEvent.Builder()
        cFLogAppObj.setAppEvent(appAction: .open)
        cFLogAppObj.setEventTime(event_time:Int64(Date().timeIntervalSince1970))
        cFLogAppObj.updateImmediately(update_immediately: true)
        cFLogAppObj.build()
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        let cFLogAppObj =  CFLogAppEvent.Builder()
        cFLogAppObj.setAppEvent(appAction: .background)
        cFLogAppObj.setEventTime(event_time:Int64(Date().timeIntervalSince1970))
        cFLogAppObj.updateImmediately(update_immediately: true)
        cFLogAppObj.build()
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        let cFLogAppObj =  CFLogAppEvent.Builder()
        cFLogAppObj.setAppEvent(appAction: .close)
        cFLogAppObj.setEventTime(event_time:Int64(Date().timeIntervalSince1970))
        cFLogAppObj.updateImmediately(update_immediately: true)
        cFLogAppObj.build()
            
    }
    
   
    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

