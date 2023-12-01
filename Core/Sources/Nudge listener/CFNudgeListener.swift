//
//  CFNudgeListener.swift
//  
//
//  Created by Causal Foundry on 29.11.23.
//

import UIKit

class CFNudgeListener {
    
    static let shared = CFNudgeListener()
    
    private var userID: String?

    func endListening() {
        userID = nil
    }
    
    func beginListening(userID: String) {
        self.userID = userID
    }
    
    func fetchNudges() async throws {
        guard let userID = userID, !userID.isEmpty else { return }
        try await withCheckedThrowingContinuation { (continuation: CheckedContinuation<Void, Error>) -> Void in
            let url = URL(string: "\(CoreConstants.shared.devUrl)nudge/sdk/\(userID)")!
            BackgroundRequestController.shared.request(url: url, httpMethod: "GET", params: nil) { [weak self] error, response, data in
                if let error = error {
                    continuation.resume(with: .failure(error))
                } else {
                    if let data = data {
                        self?.displayNudges(data: data)
                    }
                    continuation.resume(with: .success(()))
                }
            }
        }
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
            ExceptionManager.throwInvalidNudgeException(message: "Could not decode data", nudgeObject: "")
            print(error)
        }
    }
}
