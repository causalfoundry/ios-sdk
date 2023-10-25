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
        
        CausualFoundry(appplication: application).configure()
        
        
        
        return true
    }
}

