//
//  RewardEventObject.swift
//
//
//  Created by khushbu on 08/11/23.
//

import Foundation

public struct RewardEventObject: Codable {
    let id: String
    let action: String
    let acc_points: Float?
    let total_points: Float?
    let redeem: RedeemObject?
    let usd_rate: Float?
    let meta: Encodable?

    // Custom init method
    init(id: Int, action: Int, acc_points: String?,total_points:Float,redeem: RedeemObject?,usd_rate:Float?, meta: Encodable?) {
        self.id = id
        self.action = action
        self.acc_points = acc_points
        self.total_points = total_points
        self.redeem = redeem
        self.usd_rate = usd_rate
        self.meta = meta
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case action
        case acc_points
        case total_points
        case redeem
        case usd_rate
        case meta
        
    }
    
    // Encoding method
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(action, forKey: .action)
        try container.encode(acc_points, forKey: .acc_points)
        try container.encode(total_points, forKey: .total_points)
        try container.encode(redeem, forKey: .redeem)
        try container.encode(usd_rate, forKey: .usd_rate)
        if let metaData = meta {
            try container.encode(metaData, forKey: .meta)
        }
        
    }
    
    // Decoding method
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decodeIfPresent(String.self, forKey: .id)
        action = try container.decodeIfPresent(String.self, forKey: .action)
        acc_points = try container.decodeIfPresent(Float.self, forKey: .acc_points)
        total_points = try container.decodeIfPresent(Float.self, forKey: .total_points)
        redeem = try container.decodeIfPresent(RedeemObject.self, forKey: .redeem)
        usd_rate = try container.decodeIfPresent(Float.self, forKey: .usd_rate)
        if let metaData = try container.decodeIfPresent(Data.self, forKey: .meta) {
            meta = try? (JSONSerialization.jsonObject(with: metaData, options: .allowFragments) as! any Encodable)
        } else {
            meta = nil
        }
    }
}

