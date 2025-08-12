//
//  CFNudgeListener.swift
//
//
//  Created by Causal Foundry on 29.11.23.
//

import UIKit

class CFNudgeListener {
    static let shared = CFNudgeListener()

    private var nudgeTimer: Timer?
    private var nudgeTask: URLSessionDataTask?

    let timeInterval: TimeInterval = 20 * 3600

    func endListening() {
        endTimer()
        NotificationCenter.default.removeObserver(self)
    }

    func beginListening() {
        endListening()
        startTimer()
        fetchAndDisplayNudgesTask()
        NotificationCenter.default.addObserver(forName: UIApplication.willResignActiveNotification, object: nil, queue: .main) { [weak self] _ in
            self?.endTimer()
        }
        NotificationCenter.default.addObserver(forName: UIApplication.willEnterForegroundNotification, object: nil, queue: .main) { [weak self] _ in
            self?.startTimer()
            self?.fetchAndDisplayNudgesTask()
        }
    }

    @available(iOS 13.0, *)
    private func fetchPushNotificationNudges() async throws -> [BackendNudgeMainObject] {
        var userId = CoreConstants.shared.userId
        
        if(userId == nil || userId?.isEmpty == true){
            userId = MMKVHelper.shared.fetchUserBackupID()
        }
        
        if(userId ==  nil || userId?.isEmpty == true){
            userId = CoreConstants.shared.deviceObject?.device_id
        }
        guard let userID = userId, !userID.isEmpty else {
            return [] }
        return try await withCheckedThrowingContinuation { continuation in
            let url = URL(string: "\(APIConstants.fetchNudge)\(userID)?render_method=push_notification")!
            BackgroundRequestController.shared.request(url: url, httpMethod: .get, params: nil) { result in
                switch result {
                case .success(let data):
                    do {
                        let decoder = JSONDecoder.new
                        let objects = try decoder.decode([BackendNudgeMainObject].self, from: data ?? Data())
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
    private func fetchInAppMessagesNudges(nudgeScreenType : NudgeScreenType) async throws -> [BackendNudgeMainObject] {
        var userId = CoreConstants.shared.userId
        
        if(userId == nil || userId?.isEmpty == true){
            userId = MMKVHelper.shared.fetchUserBackupID()
        }
        
        if(userId ==  nil || userId?.isEmpty == true){
            userId = CoreConstants.shared.deviceObject?.device_id
        }
        guard let userID = userId, !userID.isEmpty else {
            return [] }
        return try await withCheckedThrowingContinuation { continuation in
            let url = URL(string: "\(APIConstants.fetchNudge)\(userID)?render_method=in_app_message&render_page=\(nudgeScreenType.rawValue)")!
            BackgroundRequestController.shared.request(url: url, httpMethod: .get, params: nil) { result in
                switch result {
                case .success(let data):
                    do {
                        let decoder = JSONDecoder.new
                        let objects = try decoder.decode([BackendNudgeMainObject].self, from: data ?? Data())
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
        nudgeTimer?.invalidate()
        nudgeTimer = Timer.scheduledTimer(withTimeInterval: timeInterval, repeats: true) { [weak self] _ in
            self?.fetchAndDisplayNudgesTask()
        }
    }

    private func endTimer() {
        nudgeTimer?.invalidate()
        nudgeTimer = nil
    }

    @available(iOS 13.0, *)
    func fetchAndDisplayPushNotificationNudges() async throws {
//        let pushNotificationNudgeObjects = try! BackendNudgeMainObject.debugObjects()
        let pushNotificationNudgeObjects = try await fetchPushNotificationNudges()
        
        // Filter the objects to get only the ones that are not expired
        let nonExpiredNudges = pushNotificationNudgeObjects.filter { !$0.isExpired }
       
        // Find the expired objects by subtracting non-expired ones from all fetched objects
        let expiredObjects = Set(pushNotificationNudgeObjects).subtracting(nonExpiredNudges)

        // Call a function for each expired object
        expiredObjects.forEach { expiredNudge in
            CFNotificationController.shared.track(nudgeRef: expiredNudge.ref, response: .expired)
        }
        
        for object in nonExpiredNudges {
            CFNotificationController.shared.triggerNudgeNotification(object: object)
        }
    }
    
    
    @available(iOS 13.0, *)
    func fetchAndDisplayInAppMessagesNudges(nudgeScreenType: NudgeScreenType) async throws {
        let inAppMessageNudgeObjects = try await fetchInAppMessagesNudges(nudgeScreenType: nudgeScreenType)
        
        // Filter the objects to get only the ones that are not expired
        let nonExpiredNudges = inAppMessageNudgeObjects.filter { !$0.isExpired }
        
        // Find the expired objects by subtracting non-expired ones from all fetched objects
        let expiredObjects = Set(inAppMessageNudgeObjects).subtracting(nonExpiredNudges)

        // Call a function for each expired object
        expiredObjects.forEach { expiredNudge in
            CFNotificationController.shared.track(nudgeRef: expiredNudge.ref, response: .expired)
        }
        if(!nonExpiredNudges.isEmpty){
            if (CoreConstants.shared.isAppOpen) {
                    DispatchQueue.main.async {
                        guard let window = UIApplication.shared.windows.first,
                              let rootViewController = window.rootViewController else {
                                nonExpiredNudges.forEach { nudge in
                                    CFNotificationController.shared.track(nudgeRef: nudge.ref, response: .error, errorDetails: "unable to show nudge, UI controller not found")
                                }
                                return // or perform some other action
                            }
                            CFNudgePresenter.presentWithData(in: rootViewController, objects: nonExpiredNudges)
                    }
            }else{
                var storedNudges = MMKVHelper.shared.readNudges()
                if(!storedNudges.isEmpty){
                    storedNudges.append(contentsOf: nonExpiredNudges)
                    MMKVHelper.shared.writeNudges(objects: storedNudges)
                    return
                }
                MMKVHelper.shared.writeNudges(objects: nonExpiredNudges)
            }
        }
    }
    
    private func fetchAndDisplayNudgesTask() {
        if #available(iOS 13.0, *) {
            Task {
                try await fetchAndDisplayPushNotificationNudges()
                if(CoreConstants.shared.isAppOpen && CoreConstants.shared.autoShowInAppNudge){
                    try await fetchAndDisplayInAppMessagesNudges(nudgeScreenType: NudgeScreenType.None)
                }
            }
        }
    }
    
    
    public func showInAppMessages(nudgeScreenType: NudgeScreenType) {
        if #available(iOS 13.0, *) {
            Task {
                if(CoreConstants.shared.isAppOpen && !CoreConstants.shared.autoShowInAppNudge){
                    try await fetchAndDisplayInAppMessagesNudges(nudgeScreenType: nudgeScreenType)
                }
            }
        }
    }
}

#if DEBUG
extension BackendNudgeMainObject {
    
    static func debugObjects() throws -> [BackendNudgeMainObject] {
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
        let objects = try decoder.decode([BackendNudgeMainObject].self, from: data)
        return objects
    }
}
#endif
