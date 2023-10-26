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
        _ = CausualFoundry.shared.configure()
        CFLogBuilder().setAppLevelContentBlock(contentBlock:.core)
            .updateImmediately(updateImmediately:true)
            .setLifecycleEvent(event: .active)
            .setSdkKey(sdkKey:"cfkey4dxUm8RIJmWmxgY4uakWFXqd1KmNk4Y14uHb0ogvqPpkJiGwEaKge4iGXAg")
            .disableAutoPageTrack()
        
            .build()
        
        
        return true
    }
}

