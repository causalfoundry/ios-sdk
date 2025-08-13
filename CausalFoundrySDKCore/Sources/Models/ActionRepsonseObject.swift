//
//  ActionRepsonseObject.swift
//
//
//  Created by Causal Foundry on 01.12.23.
//

import Foundation

struct ActionRepsonseObject: Codable {
    
    let response: String // open, shown, error, block
    let details: String // reason for error
    let expired_at: String
    let ref_time: String
    let model_id: String
    let inv_id: String
    let action_id: String

    init(response: ActionRepsonse, expiredAt : String, refTime : String, modelId : String, invId : String, actionId : String, details : String = "") {
        self.response = response.rawValue
        self.details = details
        self.expired_at = expiredAt
        self.ref_time = refTime
        self.model_id = modelId
        self.inv_id = invId
        self.action_id = actionId
    }
}
