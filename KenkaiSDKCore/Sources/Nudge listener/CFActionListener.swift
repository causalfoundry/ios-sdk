//
//  CFActionListener.swift
//
//
//  Created by kenkai on 29.11.23.
//

import UIKit

class CFActionListener {
    static let shared = CFActionListener()

    private var actionTimer: Timer?
    private var actionTask: URLSessionDataTask?

    let timeInterval: TimeInterval = 20 * 3600

    func endListening() {
        endTimer()
        NotificationCenter.default.removeObserver(self)
    }

    func beginListening() {
        endListening()
        startTimer()
        fetchAndDisplayActionTask()
        NotificationCenter.default.addObserver(forName: UIApplication.willResignActiveNotification, object: nil, queue: .main) { [weak self] _ in
            self?.endTimer()
        }
        NotificationCenter.default.addObserver(forName: UIApplication.willEnterForegroundNotification, object: nil, queue: .main) { [weak self] _ in
            self?.startTimer()
            self?.fetchAndDisplayActionTask()
        }
    }
    
    @available(iOS 13.0, *)
    private func fetchActionsfromBackend(actionType: InvActionType, renderMethod: ActionRenderMethodType, actionScreenType: String = "") async throws -> ActionAPIResponse {
      var userId = CoreConstants.shared.userId
      
      if(userId == nil || userId?.isEmpty == true){
        userId = MMKVHelper.shared.fetchUserBackupID()
      }
      
      if(userId ==  nil || userId?.isEmpty == true){
          userId = CoreConstants.shared.internalInfoObject?.device_id
      }
      guard let userID = userId, !userID.isEmpty else {
        return ActionAPIResponse(data: [])
      }
        let attr: [String: String]? = !actionScreenType.isEmpty ? ["render_page": actionScreenType] : nil
        let nudgeRequestData = ActionRequestObject(userId: userID, actionType: actionType.rawValue, renderMethod: renderMethod.rawValue, attr: attr)
      
      let dictionary = nudgeRequestData.dictionary ?? [:]
    
      return try await withCheckedThrowingContinuation { continuation in
        
        let url = URL(string: APIConstants.fetchAction)!
        BackgroundRequestController.shared.request(url: url, httpMethod: .post, params: dictionary) { result in
          switch result {
          case .success(let data):
            do {
              let decoder = JSONDecoder.new
              let objects = try decoder.decode(ActionAPIResponse.self, from: data ?? Data())
              continuation.resume(with: .success(objects))
            } catch {
              print("error: \(error)")
              continuation.resume(with: .failure(error))
            }
          case .failure(let error):
            continuation.resume(with: .failure(error))
          }
        }
      }
    }

    private func startTimer() {
        actionTimer?.invalidate()
        actionTimer = Timer.scheduledTimer(withTimeInterval: timeInterval, repeats: true) { [weak self] _ in
            self?.fetchAndDisplayActionTask()
        }
    }

    private func endTimer() {
        actionTimer?.invalidate()
        actionTimer = nil
    }

    @available(iOS 13.0, *)
    func fetchAndDisplayPushNotificationActions() async throws {
//        let pushNotificationActionObjects = try! ActionAPIResponse.debugObjects().data
        let pushNotificationActionObjects = try await fetchActionsfromBackend(actionType: .Message, renderMethod: .PushNotification).data
        
        
        // Filter out expired or errored nudges
        let validNonExpiredNudges = pushNotificationActionObjects?.filter { nudge in
          !(nudge.payload?.isExpired ?? false) && (nudge.error?.isEmpty ?? true)
        } ?? []

        // Filter out nudges with errors
        let erroredNudges = pushNotificationActionObjects?.filter { nudge in
            !(nudge.error?.isEmpty ?? true)
        } ?? []
        
        // Find the expired objects by subtracting non-expired ones from all fetched objects
        let expiredObjects = pushNotificationActionObjects?.filter { nudge in
          !(validNonExpiredNudges.contains(where: { $0.payload == nudge.payload })) &&
            !(erroredNudges.contains(where: { $0.payload == nudge.payload }))
        } ?? []
        
        // Call a function for each expired object
        expiredObjects.forEach { expiredNudge in
            CFNotificationController.shared.track(payload: expiredNudge.payload, response: ActionRepsonse.Expired)
        }
        
        for object in validNonExpiredNudges {
          if(object.payload != nil) {
            CFNotificationController.shared.triggerActionNotification(object: object.payload!)
          }
        }
    }
    
    
    @available(iOS 13.0, *)
    func fetchAndDisplayInAppMessagesAction(actionScreenType: ActionScreenType) async throws {
//        let inAppMessageActionObjects = try! ActionAPIResponse.debugObjects().data
        let inAppMessageActionObjects = try await fetchActionsfromBackend(actionType: .Message, renderMethod: .InAppMessage, actionScreenType: actionScreenType.rawValue).data
        
        
        // Filter out expired or errored nudges
        let validNonExpiredNudges = inAppMessageActionObjects?.filter { nudge in
          !(nudge.payload?.isExpired ?? false) && (nudge.error?.isEmpty ?? true)
        } ?? []

        // Filter out nudges with errors
        let erroredNudges = inAppMessageActionObjects?.filter { nudge in
            !(nudge.error?.isEmpty ?? true)
        } ?? []
        
        // Find the expired objects by subtracting non-expired ones from all fetched objects
        let expiredObjects = inAppMessageActionObjects?.filter { nudge in
          !(validNonExpiredNudges.contains(where: { $0.payload == nudge.payload })) &&
            !(erroredNudges.contains(where: { $0.payload == nudge.payload }))
        } ?? []
        
        // Call a function for each expired object
        expiredObjects.forEach { expiredNudge in
            CFNotificationController.shared.track(payload: expiredNudge.payload, response: ActionRepsonse.Expired)
        }
        
        if (CoreConstants.shared.isAppOpen) {
                DispatchQueue.main.async {
                    guard let window = UIApplication.shared.windows.first,
                          let rootViewController = window.rootViewController else {
                        validNonExpiredNudges.forEach { action in
                            CFNotificationController.shared.track(payload: action.payload, response: ActionRepsonse.Expired, details: "unable to show actions, UI controller not found")
                            }
                            return // or perform some other action
                        }
                        CFActionPresenter.presentWithData(in: rootViewController, objects: validNonExpiredNudges)
                }
        }else{
            var storedActions = MMKVHelper.shared.readActions()
            if(!storedActions.isEmpty){
                storedActions.append(contentsOf: validNonExpiredNudges)
                MMKVHelper.shared.writeActions(objects: storedActions)
                return
            }
            MMKVHelper.shared.writeActions(objects: validNonExpiredNudges)
        }
    }
    
    private func fetchAndDisplayActionTask() {
        if #available(iOS 13.0, *) {
            Task {
                try await fetchAndDisplayPushNotificationActions()
                if(CoreConstants.shared.isAppOpen && CoreConstants.shared.autoShowInAppMessage){
                    try await fetchAndDisplayInAppMessagesAction(actionScreenType: ActionScreenType.None)
                }
            }
        }
    }
    
    
    public func showInAppMessages(actionScreenType: ActionScreenType) {
        if #available(iOS 13.0, *) {
            Task {
                if(CoreConstants.shared.isAppOpen && !CoreConstants.shared.autoShowInAppMessage){
                    try await fetchAndDisplayInAppMessagesAction(actionScreenType: actionScreenType)
                }
            }
        }
    }
}

#if DEBUG
extension ActionAPIResponse {
    
    static func debugObjects() throws -> ActionAPIResponse {
        let json = """
        {"data":[{"user_id":"sdkTestUserId","payload":{"type":"message","render_method":"push_notification","delivery_mode":"one-off","content":{"body":"Some text here for the body","title":"Hello World"},"attr":{"cta_type":"redirect", "cta_id":"123"},"tags":null,"internal":{"inv_id":62,"action_id":33,"ref_time":"2025-10-23T14:27:00Z","expired_at":"2025-11-25T14:27:00Z","followup_of_ref":"0001-01-01T00:00:00Z","template_vals":{}}},"error":null,"queued_at":"2025-10-23T14:27:29.277756Z"}]}
        """
        let data = json.data(using: .utf8)!
        let decoder = JSONDecoder.new
        let objects = try decoder.decode(ActionAPIResponse.self, from: data)
        return objects
    }
}
#endif
