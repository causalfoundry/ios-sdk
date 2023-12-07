//
//  DeliveryObject.swift
//
//
//  Created by moizhassankh on 06/12/23.
//

import Foundation

public struct DeliveryObject: Codable {
    var deliveryId: String
    var orderId: String
    var action: String
    var meta: Encodable?

    enum CodingKeys: String, CodingKey {
        case deliveryId = "id"
        case orderId = "order_id"
        case action
        case meta
    }

    public init(deliveryId: String, orderId: String, action: String, meta: Encodable? = nil) {
        self.deliveryId = deliveryId
        self.orderId = orderId
        self.action = action
        self.meta = meta
    }

    // MARK: - Codable

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(deliveryId, forKey: .deliveryId)
        try container.encode(orderId, forKey: .orderId)
        try container.encode(action, forKey: .action)
        if let metaData = meta {
            try container.encode(metaData, forKey: .meta)
        }
        
    }

    // Custom decoding method
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        deliveryId = try container.decode(String.self, forKey: .deliveryId)
        orderId = try container.decode(String.self, forKey: .orderId)
        action = try container.decode(String.self, forKey: .action)
        if let metaData = try? container.decodeIfPresent(Data.self, forKey: .meta) {
            meta = try? (JSONSerialization.jsonObject(with: metaData, options: .allowFragments) as! any Encodable)
        } else {
            meta = nil
        }
        
    }
}
