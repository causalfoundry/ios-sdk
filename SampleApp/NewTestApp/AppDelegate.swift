//
//  AppDelegate.swift
//  NewTestApp
//
//  Created by khushbu on 29/09/23.
//

import UIKit
import CasualFoundryCore

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        let vc = lifecycleObserver(application: application)
        vc.configure()
        
    
     
//        CFLogBuilder(application: application)
//                    .setSdkKey(sdkKey:"cfkey4dxUm8RIJmWmxgY4uakWFXqd1KmNk4Y14uHb0ogvqPpkJiGwEaKge4iGXAg")
//                    .setAppLevelContentBlock(contentBlock: .core)
//                    .disableAutoPageTrack()
//                    .setLifecycleEvent(event: .active)
//                    .setAutoShowInAppNudge(showInAppNudge: true)
//                    .allowAnonymousUsers()
//                    .build()
//        CFLogAppEventBuilder().setAppEvent(appAction: .open)
//                              .build()
            return true
    }
    
    
    
    
    func applicationDidBecomeActive(_ application: UIApplication) {
       
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
//        CFLogAppEventBuilder().setAppEvent(appAction: .background)
//        CFLogAppEventBuilder().build()

    }

    // MARK: UISceneSession Lifecycle

//    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
//        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
//    }
//
//    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
//        // Called when the user discards a scene session.
//        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
//        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
//    }
    
    



}

