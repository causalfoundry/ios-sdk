//
//  AppDelegate.swift
//  NewTestApp
//
//  Created by khushbu on 29/09/23.
//

import UIKit
import CasualFoundryCore

@main
class AppDelegate: UIResponder, UIApplicationDelegate,AppLifecycleObserver {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
     
        let CausulFoundryObject = CausulFoundry()
        CausulFoundryObject.lifecycleObservers.append(self)
        return true
    }


    
    func appDidFinishLaunching() {
        
    }
    
    func appDidEnterBackground() {
        
    }
    
    func appDidBecomeActive() {
        
    }
    
    func appWillResignActive() {
        
    }
    
    func appWillTerminate() {
        
    }
    
    func appWillEnterForeground() {
        
    }
    
    
    



}

