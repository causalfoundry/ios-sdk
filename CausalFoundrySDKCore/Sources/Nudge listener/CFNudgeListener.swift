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
        guard let userID = CoreConstants.shared.userId, !userID.isEmpty else { return }
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
    private func fetchNudges() async throws -> [BackendNudgeMainObject] {
        guard let userID = CoreConstants.shared.userId, !userID.isEmpty else { return [] }
        return try await withCheckedThrowingContinuation { continuation in
            let url = URL(string: "\(APIConstants.fetchNudge)\(userID)")!
            BackgroundRequestController.shared.request(url: url, httpMethod: .get, params: nil) { result in
                switch result {
                case .success(let data):
                    do {
                        /*
                         #if DEBUG
                         let debugObjects = try BackendNudgeMainObject.debugObjects()
                         continuation.resume(with: .success(debugObjects))
                         return
                         #endif
                         */
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
    func fetchAndDisplayNudges() async throws {
        
        let allNudgeObjects = try await fetchNudges().filter { !$0.isExpired }
//        let allNudgeObjects = try BackendNudgeMainObject.debugObjects()
        
        // Filter the objects to get only the ones that are not expired
        var objects = allNudgeObjects.filter { !$0.isExpired }
        let storedNudges = MMKVHelper.shared.readNudges().filter { !$0.isExpired }
        if(!storedNudges.isEmpty){
            objects.append(contentsOf: storedNudges)
            let set = Set(objects)
            objects = Array(set)
        }
        MMKVHelper.shared.writeNudges(objects: [])
        
        // Find the expired objects by subtracting non-expired ones from all fetched objects
        let expiredObjects = Set(objects).subtracting(Set(objects))

        // Call a function for each expired object
        expiredObjects.forEach { expiredNudge in
            CFNotificationController.shared.track(nudgeRef: expiredNudge.ref, response: .error, errorDetails: "nudge expired")
        }
        
        let pushNotificationNudges = objects.filter { $0.nd.renderMethod == .pushNotification }
        let InAppMessagesNudges = objects.filter { $0.nd.renderMethod == .inAppMessage }
        
        for object in pushNotificationNudges {
            CFNotificationController.shared.triggerNudgeNotification(object: object)
        }
        
        if(!InAppMessagesNudges.isEmpty){
            if (CoreConstants.shared.autoShowInAppNudge && CoreConstants.shared.isAppOpen) {
                    DispatchQueue.main.async {
                        guard let window = UIApplication.shared.windows.first,
                              let rootViewController = window.rootViewController else {
                                MMKVHelper.shared.writeNudges(objects: InAppMessagesNudges)
                                return // or perform some other action
                            }
                            CFNudgePresenter.presentWithData(in: rootViewController, objects: InAppMessagesNudges)
                    }
            }else{
                MMKVHelper.shared.writeNudges(objects: InAppMessagesNudges)
            }
        }
    }
    
    private func fetchAndDisplayNudgesTask() {
        if #available(iOS 13.0, *) {
            Task {
                try await fetchAndDisplayNudges()
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
                "body": "Hello from Country: {{ data.ct_user.country }} and buy {{primary}} AND {{secondary}}",
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
