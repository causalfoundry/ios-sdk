//
//  RewardEventObject.swift
//
//
//  Created by khushbu on 08/11/23.
//

import Foundation

public struct RewardEventObject: Codable {
    var rewardId: String
    var action: String
    var accPoints: Float?
    var totalPoints: Float
    var redeem: RedeemObject?
    var meta: Encodable?

    private enum CodingKeys: String, CodingKey {
        case rewardId = "id"
        case action
        case accPoints = "acc_points"
        case totalPoints = "total_points"
        case redeem
        case meta
    }

    public init(rewardId: String, action: RewardAction, accPoints: Float? = 0.0, totalPoints: Float = 0.0, redeem: RedeemObject? = nil, meta: Encodable? = nil) {
        self.rewardId = rewardId
        self.action = action.rawValue
        self.accPoints = accPoints
        self.totalPoints = totalPoints
        self.redeem = redeem
        self.meta = meta
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        rewardId = try container.decode(String.self, forKey: .rewardId)
        action = try container.decode(String.self, forKey: .action)
        accPoints = try container.decodeIfPresent(Float.self, forKey: .accPoints)
        totalPoints = try container.decode(Float.self, forKey: .totalPoints)
        redeem = try container.decodeIfPresent(RedeemObject.self, forKey: .redeem)
        if let metaData = try container.decodeIfPresent(Data.self, forKey: .meta) {
            meta = try? (JSONSerialization.jsonObject(with: metaData, options: .allowFragments) as! any Encodable)
        } else {
            meta = nil
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(rewardId, forKey: .rewardId)
        try container.encode(action, forKey: .action)
        try container.encodeIfPresent(accPoints, forKey: .accPoints)
        try container.encode(totalPoints, forKey: .totalPoints)
        try container.encodeIfPresent(redeem, forKey: .redeem)
        if let metaData = meta {
            try container.encode(metaData, forKey: .meta)
        }
    }
}
