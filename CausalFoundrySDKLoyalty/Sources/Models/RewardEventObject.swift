//
//  RewardEventObject.swift
//
//
//  Created by khushbu on 08/11/23.
//

import CausalFoundrySDKCore
import Foundation

public struct RewardEventObject: Codable {
    var rewardId: String
    var rewardAction: String
    var accPoints: Float?
    var totalPoints: Float?
    let redeemType: String?
    let redeemPointsWithdrawn: Float?
    let redeemConvertedValue: Float?
    var redeemCurrency: String?
    let redeemIsSuccessful: Bool?
    var meta: Encodable?

    private enum CodingKeys: String, CodingKey {
        case rewardId = "id"
        case rewardAction = "action"
        case accPoints = "acc_points"
        case totalPoints = "total_points"
        case redeemType = "redeem_type"
        case redeemPointsWithdrawn = "redeem_points_withdrawn"
        case redeemConvertedValue = "redeem_converted_value"
        case redeemCurrency = "redeem_currency"
        case redeemIsSuccessful = "redeem_is_successful"
        case meta
    }

    public init(rewardId: String, rewardAction: RewardAction, accPoints: Float? = 0.0, totalPoints: Float = 0.0, redeemType: RedeemType?, redeemPointsWithdrawn: Float?, redeemConvertedValue: Float?, redeemIsSuccessful: Bool?, redeemCurrency: CurrencyCode? = nil, meta: Encodable? = nil) {
        
        self.rewardId = rewardId
        self.rewardAction = rewardAction.rawValue
        self.accPoints = accPoints
        self.totalPoints = totalPoints
        self.redeemType = redeemType?.rawValue
        self.redeemPointsWithdrawn = redeemPointsWithdrawn
        self.redeemConvertedValue = redeemConvertedValue
        self.redeemCurrency = redeemCurrency?.rawValue ?? ""
        self.redeemIsSuccessful = redeemIsSuccessful
        self.meta = meta
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        rewardId = try container.decode(String.self, forKey: .rewardId)
        rewardAction = try container.decode(String.self, forKey: .rewardAction)
        accPoints = try container.decodeIfPresent(Float.self, forKey: .accPoints)
        totalPoints = try container.decode(Float.self, forKey: .totalPoints)
        redeemType = try container.decodeIfPresent(String.self, forKey: .redeemType)
        redeemPointsWithdrawn = try container.decodeIfPresent(Float.self, forKey: .redeemPointsWithdrawn)
        redeemConvertedValue = try container.decodeIfPresent(Float.self, forKey: .redeemConvertedValue)
        redeemIsSuccessful = try container.decodeIfPresent(Bool.self, forKey: .redeemIsSuccessful)
        redeemCurrency = try container.decodeIfPresent(String.self, forKey: .redeemCurrency)
        if let metaData = try container.decodeIfPresent(Data.self, forKey: .meta) {
            meta = try? (JSONSerialization.jsonObject(with: metaData, options: .allowFragments) as! any Encodable)
        } else {
            meta = nil
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(rewardId, forKey: .rewardId)
        try container.encode(rewardAction, forKey: .rewardAction)
        try container.encodeIfPresent(accPoints, forKey: .accPoints)
        try container.encode(totalPoints, forKey: .totalPoints)
        try container.encodeIfPresent(redeemType, forKey: .redeemType)
        try container.encodeIfPresent(redeemPointsWithdrawn, forKey: .redeemPointsWithdrawn)
        try container.encodeIfPresent(redeemConvertedValue, forKey: .redeemConvertedValue)
        try container.encodeIfPresent(redeemIsSuccessful, forKey: .redeemIsSuccessful)
        try container.encodeIfPresent(redeemCurrency, forKey: .redeemCurrency)
        if let metaData = meta {
            try container.encode(metaData, forKey: .meta)
        }
    }
}
