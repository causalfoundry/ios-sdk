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
    
    /*
    public func handle(launchOptions: [UIApplication.LaunchOptionsKey: Any]?) {
        guard let notification = launchOptions?[UIApplication.LaunchOptionsKey.localNotification] as? UILocalNotification,
              let data = notification.userInfo?["object"] as? Data,
              let object = data.toObject() else { return }
        track(object: object, response: .shown)
    }
    */
    
    internal func triggerNudgeNotification(object: BackendNudgeMainObject) {
        Task {
            let settings = await center.notificationSettings()
            guard settings.authorizationStatus == .authorized else {
                track(object: object, response: .block)
                return
            }
            let identifier = UUID().uuidString
            let content = UNMutableNotificationContent()
            content.title = object.nd.message?.title ?? ""
            content.body = NudgeUtils.getBodyTextBasedOnTemplate(nudgeObject: object)
            content.categoryIdentifier = "BackendNudgeMainObject"
            if let data = object.toData() {
                content.userInfo = ["object": data]
            }
            content.sound = UNNotificationSound.default
            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)
            let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)
            try await center.add(request)
        }
    }
    
    private func track(object: BackendNudgeMainObject, response: NudgeRepsonseObject.NudgeRepsonse) {
        let nudgeResponse = NudgeRepsonseObject(object: object,
                                                response: response)
        CFSetup()
            .track(contentBlockName: CoreConstants.shared.contentBlockName,
                   eventType: CoreEventType.nudge_response.rawValue,
                   logObject: nudgeResponse,
                   updateImmediately: CoreConstants.shared.updateImmediately,
                   eventTime: 0)
    }
}

extension CFNotificationController: UNUserNotificationCenterDelegate {
    
    public func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        // notification is presented
        if let data = notification.request.content.userInfo["object"] as? Data, let object = data.toObject() {
            track(object: object, response: .shown)
        }
        completionHandler(options)
    }
    
    public func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        // user tapped on notification
        if let data = response.notification.request.content.userInfo["object"] as? Data, let object = data.toObject() {
            track(object: object, response: .open)
        }
        completionHandler()
    }
}

fileprivate extension Data {
    
    func toObject() -> BackendNudgeMainObject? {
        let decoder = JSONDecoder()
        return try? decoder.decode(BackendNudgeMainObject.self, from: self)
    }
}
