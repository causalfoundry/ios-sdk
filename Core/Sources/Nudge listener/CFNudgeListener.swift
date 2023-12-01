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
    private var userID: String?
    
    let timeInterval: TimeInterval = 20 * 3600

    func endListening() {
        userID = nil
        endTimer()
        NotificationCenter.default.removeObserver(self)
    }
    
    func beginListening(userID: String) {
        endListening()
        guard !userID.isEmpty else { return }
        self.userID = userID
        startTimer()
        fetchAndDisplayNudges()
        NotificationCenter.default.addObserver(forName: UIApplication.didEnterBackgroundNotification, object: nil, queue: .main) { [weak self] _ in
            self?.endTimer()
        }
        NotificationCenter.default.addObserver(forName: UIApplication.didBecomeActiveNotification, object: nil, queue: .main) { [weak self] _ in
            self?.startTimer()
            self?.fetchAndDisplayNudges()
        }
    }
    
    func fetchNudges() async throws -> [BackendNudgeMainObject] {
        guard let userID = userID, !userID.isEmpty else { return [] }
        return try await withCheckedThrowingContinuation { continuation in
            let url = URL(string: "\(CoreConstants.shared.devUrl)nudge/sdk/\(userID)")!
            BackgroundRequestController.shared.request(url: url, httpMethod: "GET", params: nil) { error, response, data in
                if let error = error {
                    continuation.resume(with: .failure(error))
                } else {
                    do {
                        let decoder = JSONDecoder()
                        let objects = try decoder.decode([BackendNudgeMainObject].self, from: data ?? Data())
                        continuation.resume(with: .success(objects))
                    } catch {
                        continuation.resume(with: .failure(error))
                    }
                }
            }
        }
    }
    
    private func startTimer() {
        nudgeTimer?.invalidate()
        nudgeTimer = Timer.scheduledTimer(withTimeInterval: timeInterval, repeats: true) { [weak self] timer in
            self?.fetchAndDisplayNudges()
        }
    }
    
    private func endTimer() {
        nudgeTimer?.invalidate()
        nudgeTimer = nil
    }
    
    private func fetchAndDisplayNudges() {
        Task {
            /*
            #if DEBUG
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
            let decoder = JSONDecoder()
            let objects = try decoder.decode([BackendNudgeMainObject].self, from: data)
            #endif
            */
            let objects = try await fetchNudges()
            for object in objects {
                CFNotificationController.shared.triggerNudgeNotification(object: object)
            }
        }
    }
}
