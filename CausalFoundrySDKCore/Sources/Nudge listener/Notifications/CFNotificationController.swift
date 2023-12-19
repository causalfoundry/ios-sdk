//
//  CFNotificationController.swift
//
//
//  Created by Causal Foundry on 29.11.23.
//

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

    func triggerNudgeNotification(object: BackendNudgeMainObject) {
        if #available(iOS 13.0, *) {
            Task {
                let settings = await center.notificationSettings()
                guard settings.authorizationStatus == .authorized else {
                    track(nudgeRef: object.ref, response: .block)
                    return
                }
                let identifier = UUID().uuidString
                let content = UNMutableNotificationContent()
                content.title = object.nd.message?.title ?? ""
                content.body = NudgeUtils.getBodyTextBasedOnTemplate(nudgeObject: object)
                content.categoryIdentifier = "BackendNudgeMainObject"
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
    
    func track(nudgeRef: String, response: NudgeRepsonseObject.NudgeRepsonse, errorDetails: String = "") {
        let nudgeResponse = NudgeRepsonseObject(nudgeRef: nudgeRef,
                                                response: response, details: errorDetails)
        CFSetup()
            .track(contentBlockName: CoreConstants.shared.contentBlockName,
                   eventType: CoreEventType.nudge_response.rawValue,
                   logObject: nudgeResponse,
                   updateImmediately: true,
                   eventTime: 0)
    }
    
    func trackAndOpen(object: BackendNudgeMainObject) {
       track(nudgeRef: object.ref, response: .open)
        if let cta = object.nd.cta, cta == "redirect" || cta == "add_to_cart",
           let itemType = object.nd.message?.tmplCFG?.itemPairCFG?.itemType, !itemType.isEmpty,
           let itemID = object.extra?.itemPair?.ids?.first
        {
            if let closure = NudgeOnClickObject.nudgeOnClickInterface {
                closure(cta, itemType, itemID)
            }
        }
    }
}

extension CFNotificationController: UNUserNotificationCenterDelegate {
    public func userNotificationCenter(_: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        // notification is presented
        if let data = notification.request.content.userInfo[userInfoKey] as? Data, let object = data.toObject() {
            track(nudgeRef: object.ref, response: .shown)
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
    func toObject() -> BackendNudgeMainObject? {
        let decoder = JSONDecoder.new
        return try? decoder.decode(BackendNudgeMainObject.self, from: self)
    }
}
