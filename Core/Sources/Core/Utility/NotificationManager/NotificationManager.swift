//
//  File.swift
//  
//
//  Created by khushbu on 25/09/23.
//

import Foundation
import UIKit
import UserNotifications



final class NotificationManager {
    
    static let shared = NotificationManager()
    let center:UNUserNotificationCenter?
    
    init() {
        center =  UNUserNotificationCenter.current()
        self.checkPremissionAllowance()
    }
    
    // Check Notification Permission Allowed or not
    private func checkPremissionAllowance() {
        center!.requestAuthorization(options: [.alert, .badge, .sound]) { (granted, error) in
            if granted {
                
            } else {
                print("D'oh")
            }
        }
    }
}
