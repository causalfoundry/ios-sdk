//
//  SurveyObject.swift
//
//
//  Created by khushbu on 08/11/23.
//

import Foundation

public struct SurveyObject: Codable {
    var id: String
    var isCompleted: Bool = false
    var rewardId: String?
    var type: String

    private enum CodingKeys: String, CodingKey {
        case id
        case isCompleted = "is_completed"
        case rewardId = "reward_id"
        case type
    }

    public init(id: String, isCompleted: Bool = false, rewardId: String, type: SurveyType) {
        self.id = id
        self.isCompleted = isCompleted
        self.rewardId = rewardId
        self.type = type.rawValue
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(String.self, forKey: .id)
        isCompleted = try container.decode(Bool.self, forKey: .isCompleted)
        rewardId = try container.decodeIfPresent(String.self, forKey: .rewardId)
        type = try container.decode(String.self, forKey: .type)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encodeIfPresent(isCompleted, forKey: .isCompleted)
        try container.encode(rewardId, forKey: .rewardId)
        try container.encode(type, forKey: .type)
    }
}
