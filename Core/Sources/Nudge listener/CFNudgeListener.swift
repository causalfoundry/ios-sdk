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
    private var topViewController: UIViewController? {
        UIApplication.shared.windows.filter({ $0.isKeyWindow }).first?.rootViewController
    }

    func endListening() {
        nudgeTimer?.invalidate()
        nudgeTimer = nil
        NotificationCenter.default.removeObserver(self, name: UIApplication.didBecomeActiveNotification, object: nil)
    }
    
    func beginListening(userID: String) {
        endListening()
        guard !userID.isEmpty else { return }
        nudgeTimer = Timer.scheduledTimer(withTimeInterval: 20 * 3600, repeats: true) { [weak self] timer in
            self?.requestNudges(userID: userID)
        }
        NotificationCenter.default.addObserver(forName: UIApplication.didBecomeActiveNotification, object: nil, queue: .main) { [weak self] _ in
            self?.requestNudges(userID: userID)
        }
        requestNudges(userID: userID)
    }
    
    private func requestNudges(userID: String) {
        guard !userID.isEmpty else { return }
        let session = URLSession.shared
        var request = URLRequest(url: URL(string: "\(CoreConstants.shared.devUrl)nudge/sdk/\(userID)")!)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue(CoreConstants.shared.sdkKey, forHTTPHeaderField: "Authorization")
        let task = session.dataTask(with: request) { [weak self] data, response, error in
            DispatchQueue.main.async {
                if let error = error {
                    let alert = UIAlertController(title: error.localizedDescription, message: nil, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .cancel))
                    self?.topViewController?.present(alert, animated: true)
                } else if let data = data {
                    self?.displayNudges(data: data)
                } else {
                    let alert = UIAlertController(title: "No nudge data found", message: nil, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .cancel))
                    self?.topViewController?.present(alert, animated: true)
                }
            }
        }
        task.resume()
    }
    
    private func displayNudges(data: Data) {
        do {
            /*
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
               "ref":"adp_94",
               "time":"2023-08-30T11:53:00+02:00",
               "nd":{
                  "type":"message",
                  "message":{
                     "title":"Test Traits with Values",
                     "tmpl_cfg":{
                        "tmpl_type":"traits",
                        "item_pair_cfg":{
                           "item_type":"drug",
                           "pair_rank_type":""
                        },
                        "traits":[
                           "data.ct_user.country"
                        ]
                     },
                     "body":"Hellooooo from Country: {{ data.ct_user.country }}",
                     "tags":[
                        "incentive"
                     ]
                  },
                  "render_method":"push_notification",
                  "cta":"redirect"
               },
               "extra":{
                  "traits":{
                     "data.ct_user.country":"Spain"
                  }
               }
            }
            ]
            """
            let data = json.data(using: .utf8)!
            */
            let decoder = JSONDecoder()
            let objects = try decoder.decode([BackendNudgeMainObject].self, from: data)
            objects.forEach { object in
                CFNotificationController.shared.triggerNudgeNotification(object: object)
            }
        } catch {
            let alert = UIAlertController(title: error.localizedDescription, message: nil, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .cancel))
            topViewController?.present(alert, animated: true)
        }
    }
}
