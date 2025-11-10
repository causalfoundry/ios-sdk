//
//  CFNotificationController.swift
//
//
//  Created by kenkai on 29.11.23.
//

import Foundation
import UIKit

public final class CFNotificationController: NSObject {
    public static let shared = CFNotificationController()

    private let center = UNUserNotificationCenter.current()

    private let userInfoKey = "object"
    private let options: UNNotificationPresentationOptions = [.alert, .badge, .sound]

    public func request(completionHandler: @escaping (Bool, Error?) -> Void) {
        center.requestAuthorization(options: [.alert, .badge, .sound], completionHandler: completionHandler)
        center.delegate = self
    }

    /*
     public func handle(launchOptions: [UIApplication.LaunchOptionsKey: Any]?) {
         guard let notification = launchOptions?[UIApplication.LaunchOptionsKey.localNotification] as? UILocalNotification,
               let data = notification.userInfo?["object"] as? Data,
               let object = data.toObject() else { return }
         track(object: object, response: .shown)
     }
     */

    func triggerActionNotification(object: Nudge) {
        if #available(iOS 13.0, *) {
            Task {
                let settings = await checkNotificationsEnabled()
                if !settings {
                    track(payload: object, response: ActionRepsonse.Block, details: "")
                    return
                }
                let identifier = UUID().uuidString
                let content = UNMutableNotificationContent()
                content.title = object.content?["title"] ?? ""
                content.body = (object.content?["body"] ?? "").htmlAttributedString().with(font:UIFont.preferredFont(forTextStyle: .body)).string
                content.categoryIdentifier = "Nudge"
                if let data = object.toData() {
                    content.userInfo = [userInfoKey: data]
                }
                content.sound = UNNotificationSound.default
                let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)
                let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)
                try await center.add(request)
                
            }
        }
    }
    
    func checkNotificationsEnabled() async -> Bool {
        let settings = await center.notificationSettings()
        return settings.authorizationStatus == .authorized
    }
    
    func track(payload: Nudge?, response: ActionRepsonse, details : String = "") {
        let actionResponseObj = ActionRepsonseObject(response: response.rawValue, details: details, internalObject: payload?.internalObject)
        CFCoreEvent.shared.logIngest(eventType: .ActionResponse, logObject: actionResponseObj, isUpdateImmediately: true)
    }
    
    func trackAndOpen(object: Nudge) {
        track(payload:object, response: ActionRepsonse.Open, details: "")
        ActionOnClickObject.actionOnClickInterface?(object.attr)
    }
}

extension CFNotificationController: UNUserNotificationCenterDelegate {
    public func userNotificationCenter(_: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        // notification is presented
        if let data = notification.request.content.userInfo[userInfoKey] as? Data, let object = data.toObject() {
            track(payload:object, response: ActionRepsonse.Shown, details: "")
        }
        completionHandler(options)
    }

    public func userNotificationCenter(_: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        // user tapped on notification
        if let data = response.notification.request.content.userInfo[userInfoKey] as? Data, let object = data.toObject() {
            trackAndOpen(object: object)
        }
        completionHandler()
    }
}

private extension Data {
    func toObject() -> Nudge? {
        let decoder = JSONDecoder.new
        return try? decoder.decode(Nudge.self, from: self)
    }
}
