//
//  File.swift
//  
//
//  Created by khushbu on 28/09/23.
//

import Foundation
import UIKit


final class appLifecycleobserver:NSObject,UIApplicationDelegate {
    var application:UIApplication?
    
    init(application:UIApplication)
    {
        super.init()
        self.application = application
        self.application?.delegate = self
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        onStateChnaged(applicationState: .active)
    }
    
    
    func applicationWillResignActive(_ application: UIApplication) {
        onStateChnaged(applicationState: .background)
    }
    
    func onStateChnaged(applicationState: UIApplication.State) {
        print("application state is:\(applicationState)")
        
    }
    
}
