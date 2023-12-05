//
//  ScheduleDeliveryObject.swift
//
//
//  Created by khushbu on 01/11/23.
//

import Foundation

public struct ScheduleDeliveryObject: Codable {
    let orderId: String
    let isUrgent: Bool
    let action: String
    let deliveryTimestamp: String
    let meta: Encodable?

    enum CodingKeys: String, CodingKey {
        case orderId = "order_id"
        case isUrgent = "is_urgent"
        case action
        case deliveryTimestamp = "delivery_ts"
        case meta
    }

    public init(orderId: String, isUrgent: Bool, action: String, deliveryTimestamp: String, meta: Encodable? = nil) {
        self.orderId = orderId
        self.isUrgent = isUrgent
        self.action = action
        self.deliveryTimestamp = deliveryTimestamp
        self.meta = meta
    }

    // Encoding method to encode all keys
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(orderId, forKey: .orderId)
        try container.encode(isUrgent, forKey: .isUrgent)
        try container.encode(action, forKey: .action)
        try container.encode(deliveryTimestamp, forKey: .deliveryTimestamp)
        if let metaData = meta {
            try container.encode(metaData, forKey: .meta)
        }
    }

    // Decoding method to decode all keys
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        orderId = try container.decode(String.self, forKey: .orderId)
        isUrgent = try container.decode(Bool.self, forKey: .isUrgent)
        action = try container.decode(String.self, forKey: .action)
        deliveryTimestamp = try container.decode(String.self, forKey: .deliveryTimestamp)
        if let metaData = try container.decodeIfPresent(Data.self, forKey: .meta) {
            meta = try? (JSONSerialization.jsonObject(with: metaData, options: .allowFragments) as! any Encodable)
        } else {
            meta = nil
        }
    }
}
