//
//  File.swift
//  
//
//  Created by Causal Foundry on 29.11.23.
//

import UIKit

public final class CFNotificationController: NSObject {
    
    public static let shared = CFNotificationController()
    
    private let center = UNUserNotificationCenter.current()
    
    private let options: UNNotificationPresentationOptions = [.alert, .badge, .sound]
    
    public func request(completionHandler: @escaping (Bool, Error?) -> Void) {
        center.requestAuthorization(options: [.alert, .badge, .sound], completionHandler: completionHandler)
        center.delegate = self
    }
    
    internal func triggerNudgeNotification(object: BackendNudgeMainObject) {
        let identifier = UUID().uuidString
        let content = UNMutableNotificationContent()
        content.title = object.nd.message?.title ?? ""
        content.body = NudgeUtils.getBodyTextBasedOnTemplate(nudgeObject: object)
        content.categoryIdentifier = "BackendNudgeMainObject"
        //content.userInfo = ["customData": "fizzbuzz"]
        content.sound = UNNotificationSound.default
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)
        let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)
        center.add(request)
    }
}

extension CFNotificationController: UNUserNotificationCenterDelegate {
    
    public func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler(options)
    }
    
    public func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        completionHandler()
    }
}
