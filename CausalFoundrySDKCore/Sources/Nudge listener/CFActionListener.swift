//
//  CFActionListener.swift
//
//
//  Created by Causal Foundry on 29.11.23.
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
    private func fetchPushNotificationActions() async throws -> [BackendActionMainObject] {
        var userId = CoreConstants.shared.userId
        
        if(userId == nil || userId?.isEmpty == true){
            userId = MMKVHelper.shared.fetchUserBackupID()
        }
        
        if(userId ==  nil || userId?.isEmpty == true){
            userId = CoreConstants.shared.internalInfoObject?.device_id
        }
        guard let userID = userId, !userID.isEmpty else {
            return [] }
        return try await withCheckedThrowingContinuation { continuation in
            let url = URL(string: "\(APIConstants.fetchAction)\(userID)?render_method=push_notification")!
            BackgroundRequestController.shared.request(url: url, httpMethod: .get, params: nil) { result in
                switch result {
                case .success(let data):
                    do {
                        let decoder = JSONDecoder.new
                        let objects = try decoder.decode([BackendActionMainObject].self, from: data ?? Data())
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
    
    @available(iOS 13.0, *)
    private func fetchInAppMessagesActions(actionScreenType : ActionScreenType) async throws -> [BackendActionMainObject] {
        var userId = CoreConstants.shared.userId
        
        if(userId == nil || userId?.isEmpty == true){
            userId = MMKVHelper.shared.fetchUserBackupID()
        }
        
        if(userId ==  nil || userId?.isEmpty == true){
            userId = CoreConstants.shared.internalInfoObject?.device_id
        }
        guard let userID = userId, !userID.isEmpty else {
            return [] }
        return try await withCheckedThrowingContinuation { continuation in
            let url = URL(string: "\(APIConstants.fetchAction)\(userID)?render_method=in_app_message&render_page=\(actionScreenType.rawValue)")!
            BackgroundRequestController.shared.request(url: url, httpMethod: .get, params: nil) { result in
                switch result {
                case .success(let data):
                    do {
                        let decoder = JSONDecoder.new
                        let objects = try decoder.decode([BackendActionMainObject].self, from: data ?? Data())
                        continuation.resume(with: .success(objects))
                    } catch {
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
//        let pushNotificationActionsObjects = try! BackendActionsMainObject.debugObjects()
        let pushNotificationActionObjects = try await fetchPushNotificationActions()
        
        // Filter the objects to get only the ones that are not expired
        let nonExpiredActions = pushNotificationActionObjects.filter { !$0.internalObj.isExpired }
       
        // Find the expired objects by subtracting non-expired ones from all fetched objects
        let expiredObjects = Set(pushNotificationActionObjects).subtracting(nonExpiredActions)

        // Call a function for each expired object
        expiredObjects.forEach { expiredAction in
            CFNotificationController.shared.track(response: ActionRepsonse.Expired, expiredAt: expiredAction.internalObj.expiredAt, refTime: expiredAction.internalObj.refTime, modelId: expiredAction.internalObj.modelId, invId: expiredAction.internalObj.invId, actionId: expiredAction.internalObj.actionId, details: "")
        }
        
        for object in nonExpiredActions {
            CFNotificationController.shared.triggerActionNotification(object: object)
        }
    }
    
    
    @available(iOS 13.0, *)
    func fetchAndDisplayInAppMessagesAction(actionScreenType: ActionScreenType) async throws {
        let inAppMessageActionObjects = try await fetchInAppMessagesActions(actionScreenType: actionScreenType)
        
        // Filter the objects to get only the ones that are not expired
        let nonExpiredAction = inAppMessageActionObjects.filter { !$0.internalObj.isExpired }
        
        // Find the expired objects by subtracting non-expired ones from all fetched objects
        let expiredObjects = Set(inAppMessageActionObjects).subtracting(nonExpiredAction)

        // Call a function for each expired object
        expiredObjects.forEach { expiredAction in
            CFNotificationController.shared.track(response: ActionRepsonse.Expired, expiredAt: expiredAction.internalObj.expiredAt, refTime: expiredAction.internalObj.refTime, modelId: expiredAction.internalObj.modelId, invId: expiredAction.internalObj.invId, actionId: expiredAction.internalObj.actionId, details: "")
        }
        if(!nonExpiredAction.isEmpty){
            if (CoreConstants.shared.isAppOpen) {
                    DispatchQueue.main.async {
                        guard let window = UIApplication.shared.windows.first,
                              let rootViewController = window.rootViewController else {
                            nonExpiredAction.forEach { action in
                                    CFNotificationController.shared.track(response: ActionRepsonse.Expired, expiredAt: action.internalObj.expiredAt, refTime: action.internalObj.refTime, modelId: action.internalObj.modelId, invId: action.internalObj.invId, actionId: action.internalObj.actionId, details: "unable to show actions, UI controller not found")
                                }
                                return // or perform some other action
                            }
                            CFActionPresenter.presentWithData(in: rootViewController, objects: nonExpiredAction)
                    }
            }else{
                var storedActions = MMKVHelper.shared.readActions()
                if(!storedActions.isEmpty){
                    storedActions.append(contentsOf: nonExpiredAction)
                    MMKVHelper.shared.writeActions(objects: storedActions)
                    return
                }
                MMKVHelper.shared.writeActions(objects: nonExpiredAction)
            }
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
extension BackendActionMainObject {
    
    static func debugObjects() throws -> [BackendActionMainObject] {
        let json = """
        [
          {
            "ref": "adp_0",
            "time": "2023-08-30T11:53:00+02:00",
            "expire_at": "2024-08-30T11:53:00+02:00",
            "nd": {
              "type": "message",
              "message": {
                "title": "Test Traits and Item Pair with Values",
                "tmpl_cfg": {
                  "tmpl_type": "item_pair, traits",
                  "item_pair_cfg": {
                    "item_type": "drug",
                    "pair_rank_type": ""
                  },
                  "traits": [
                    "data.ct_user.country"
                  ]
                },
                "body": "Hello from Country: <b style='color:red;'>BOLD</b> and buy <i>Italic</i>",
                "tags": [
                  "incentive"
                ]
              },
              "render_method": "in_app_message",
              "cta": "redirect"
            },
            "extra": {
              "traits": {
                "data.ct_user.country": "Spain"
              },
              "item_pair": {
                "ids": [
                  "12",
                  "13"
                ],
                "names": [
                  "Panadol",
                  "Bruffin"
                ]
              }
            }
          },
          {
            "ref": "adp_0",
            "time": "2023-08-31T11:53:00+02:00",
            "nd": {
              "type": "message",
              "message": {
                "title": "Test Traits with Values",
                "tmpl_cfg": {
                  "tmpl_type": "traits",
                  "item_pair_cfg": {
                    "item_type": "drug",
                    "pair_rank_type": ""
                  },
                  "traits": [
                  "data.dt_day_user_chw_activity.review_change_sign_seven",
                  "data.dt_day_user_chw_activity.review_change_seven",
                  "data.dt_day_user_chw_activity.review_recommendation_seven"
               ]
                },
                "body": "The number of medical reviews you've submitted {{ data.dt_day_user_chw_activity.review_change_sign_seven }} by {{ data.dt_day_user_chw_activity.review_change_seven }} in the last seven days. {{ data.dt_day_user_chw_activity.review_recommendation_seven }}",
                "tags": [
                  "incentive"
                ]
              },
              "render_method": "in_app_message",
              "cta": "redirect"
            },
            "extra": {
              "traits": {
                    "data.dt_day_user_chw_activity.review_change_seven":0,
                    "data.dt_day_user_chw_activity.review_change_sign_seven":"increased",
                    "data.dt_day_user_chw_activity.review_recommendation_seven":"👍"
                 }
            }
          }
        ]
        """
        let data = json.data(using: .utf8)!
        let decoder = JSONDecoder.new
        let objects = try decoder.decode([BackendActionMainObject].self, from: data)
        return objects
    }
}
#endif
