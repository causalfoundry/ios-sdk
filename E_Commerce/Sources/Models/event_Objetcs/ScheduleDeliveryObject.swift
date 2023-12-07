//
//  ScheduleDeliveryObject.swift
//
//
//  Created by khushbu on 01/11/23.
//

import Foundation

public struct ScheduleDeliveryObject: Codable {
    let orderId: String
    let action: String
    let deliveryTimestamp: String
    let isUrgentDelivery: Bool
    let meta: Encodable?

    enum CodingKeys: String, CodingKey {
        case orderId = "order_id"
        case action
        case deliveryTimestamp = "delivery_ts"
        case isUrgentDelivery = "is_urgent"
        case meta
    }

    public init(orderId: String, action: String, deliveryTimestamp: String, isUrgentDelivery: Bool, meta: Encodable? = nil) {
        self.orderId = orderId
        self.action = action
        self.deliveryTimestamp = deliveryTimestamp
        self.isUrgentDelivery = isUrgentDelivery
        self.meta = meta
    }
    
    // Custom encoding method
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(orderId, forKey: .orderId)
        try container.encode(action, forKey: .action)
        try container.encode(deliveryTimestamp, forKey: .deliveryTimestamp)
        try container.encode(isUrgentDelivery, forKey: .isUrgentDelivery)
        if let metaData = meta {
            try container.encode(metaData, forKey: .meta)
        }
        
    }

    // Custom decoding method
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        orderId = try container.decode(String.self, forKey: .orderId)
        action = try container.decode(String.self, forKey: .action)
        deliveryTimestamp = try container.decode(String.self, forKey: .deliveryTimestamp)
        isUrgentDelivery = try container.decode(Bool.self, forKey: .isUrgentDelivery)
        if let metaData = try? container.decodeIfPresent(Data.self, forKey: .meta) {
            meta = try? (JSONSerialization.jsonObject(with: metaData, options: .allowFragments) as! any Encodable)
        } else {
            meta = nil
        }
        
    }
    
}
