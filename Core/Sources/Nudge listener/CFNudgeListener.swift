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
        NotificationCenter.default.addObserver(forName: UIApplication.didBecomeActiveNotification, object: nil, queue: .main) { [weak self] _ in
            self?.startTimer()
            self?.fetchAndDisplayNudgesTask()
        }
    }

    private func fetchNudges() async throws -> [BackendNudgeMainObject] {
        guard let userID = CoreConstants.shared.userId, !userID.isEmpty else { return [] }
        return try await withCheckedThrowingContinuation { continuation in
            let url = URL(string: "\(CoreConstants.shared.devUrl)nudge/sdk/\(userID)")!
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

    func fetchAndDisplayNudges() async throws {
        
        let objects = try await fetchNudges().filter { !$0.isExpired }
        
        let pushNotificationNudges = objects.filter { $0.nd.renderMethod == .pushNotification }
        let nonPushNotificationNudges = objects.filter { $0.nd.renderMethod != .pushNotification }
        
        if CoreConstants.shared.autoShowInAppNudge {
            for object in pushNotificationNudges {
                CFNotificationController.shared.triggerNudgeNotification(object: object)
            }
        }
        
        var savedObjects = MMKVHelper.shared.readNudges()
        savedObjects.append(contentsOf: nonPushNotificationNudges)
        
        MMKVHelper.shared.writeNudges(objects: savedObjects)
    }
    
    private func fetchAndDisplayNudgesTask() {
        Task {
            try await fetchAndDisplayNudges()
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
              "render_method": "push_notification",
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
            "ref": "adp_94",
            "time": "2023-08-30T11:53:00+02:00",
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
                    "data.ct_user.country"
                  ]
                },
                "body": "Hellooooo from Country: {{ data.ct_user.country }}",
                "tags": [
                  "incentive"
                ]
              },
              "render_method": "push_notification",
              "cta": "redirect"
            },
            "extra": {
              "traits": {
                "data.ct_user.country": "Spain"
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
