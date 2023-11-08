//
//  File.swift
//  
//
//  Created by khushbu on 08/11/23.
//

import Foundation

public struct SurveyObject: Codable {
    var id: String
    var isCompleted: Bool?
    var rewardId: String?
    var type: String

    enum CodingKeys: String, CodingKey {
        case id
        case isCompleted = "is_completed"
        case rewardId = "reward_id"
        case type
    }

    public init(id: String, isCompleted: Bool? = nil, rewardId: String? = nil, type: String) {
        self.id = id
        self.isCompleted = isCompleted
        self.rewardId = rewardId
        self.type = type
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys)
        id = try container.decode(String.self, forKey: .id)
        isCompleted = try container.decodeIfPresent(Bool.self, forKey: .isCompleted)
        rewardId = try container.decodeIfPresent(String.self, forKey: .rewardId)
        type = try container.decode(String.self, forKey: .type)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys)
        try container.encode(id, forKey: .id)
        try container.encodeIfPresent(isCompleted, forKey: .isCompleted)
        try container.encodeIfPresent(rewardId, forKey: .rewardId)
        try container.encode(type, forKey: .type)
    }
}
