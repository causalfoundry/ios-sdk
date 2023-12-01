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
}
