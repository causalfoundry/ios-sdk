//
//  CFNotificationController.swift
//
//
//  Created by Causal Foundry on 29.11.23.
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

    func triggerActionNotification(object: BackendActionMainObject) {
        if #available(iOS 13.0, *) {
            Task {
                let settings = await center.notificationSettings()
                guard settings.authorizationStatus == .authorized else {
                    track(response: ActionRepsonse.Block, expiredAt: object.internalObj.expiredAt, refTime: object.internalObj.refTime, modelId: object.internalObj.modelId, invId: object.internalObj.invId, actionId: object.internalObj.actionId, details: "")
                    return
                }
                let identifier = UUID().uuidString
                let content = UNMutableNotificationContent()
                content.title = object.content["title"] ?? ""
                content.body = (object.content["body"] ?? "").htmlAttributedString().with(font:UIFont.preferredFont(forTextStyle: .body)).string
                content.categoryIdentifier = "BackendActionMainObject"
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
    
    func track(response: ActionRepsonse, expiredAt : String, refTime : String, modelId : String, invId : String, actionId : String, details : String = "") {
        let actionResponseObj = ActionRepsonseObject(response: response, expiredAt: expiredAt, refTime: refTime, modelId: modelId, invId: invId, actionId: actionId, details: details)
        CFCoreEvent.shared.logIngest(eventType: .ActionResponse, logObject: actionResponseObj)
    }
    
    func trackAndOpen(object: BackendActionMainObject) {
        track(response: ActionRepsonse.Open, expiredAt: object.internalObj.expiredAt, refTime: object.internalObj.refTime, modelId: object.internalObj.modelId, invId: object.internalObj.invId, actionId: object.internalObj.actionId, details: "")
        if let cta = object.attr["cta_type"], cta == "redirect" || cta == "add_to_cart",
           let itemID = object.attr["cta_id"]
        {
            if let closure = ActionOnClickObject.actionOnClickInterface {
                closure(cta, itemID)
            }
        }
    }
}

extension CFNotificationController: UNUserNotificationCenterDelegate {
    public func userNotificationCenter(_: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        // notification is presented
        if let data = notification.request.content.userInfo[userInfoKey] as? Data, let object = data.toObject() {
            track(response: ActionRepsonse.Shown, expiredAt: object.internalObj.expiredAt, refTime: object.internalObj.refTime, modelId: object.internalObj.modelId, invId: object.internalObj.invId, actionId: object.internalObj.actionId, details: "")
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
    func toObject() -> BackendActionMainObject? {
        let decoder = JSONDecoder.new
        return try? decoder.decode(BackendActionMainObject.self, from: self)
    }
}
