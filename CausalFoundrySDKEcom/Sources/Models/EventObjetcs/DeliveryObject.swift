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
    var isUrgent: Bool
    var deliveryTs: String?
    var deliveryCoordinates: CoordinatesObject?
    var dispatchCoordinates: CoordinatesObject?
    var meta: Encodable?

    private enum CodingKeys: String, CodingKey {
        case deliveryId = "id"
        case orderId = "order_id"
        case action
        case isUrgent = "is_urgent"
        case deliveryTs = "est_delivery_ts"
        case deliveryCoordinates = "delivery_coordinates"
        case dispatchCoordinates = "dispatch_coordinates"
        case meta
    }

    public init(deliveryId: String, orderId: String, action: DeliveryAction, isUrgent: Bool = false, deliveryTs: Int64 = 0, deliveryCoordinates: CoordinatesObject? = nil, dispatchCoordinates: CoordinatesObject? = nil, meta: Encodable? = nil) {
        self.deliveryId = deliveryId
        self.orderId = orderId
        self.action = action.rawValue
        self.isUrgent = isUrgent
        self.deliveryTs = ECommerceConstants.getDateTime(milliSeconds: deliveryTs)
        self.deliveryCoordinates = deliveryCoordinates
        self.dispatchCoordinates = dispatchCoordinates
        self.meta = meta
    }

    // MARK: - Codable

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(deliveryId, forKey: .deliveryId)
        try container.encode(orderId, forKey: .orderId)
        try container.encode(action, forKey: .action)
        try container.encodeIfPresent(isUrgent, forKey: .isUrgent)
        try container.encodeIfPresent(deliveryTs, forKey: .deliveryTs)
        try container.encodeIfPresent(deliveryCoordinates, forKey: .deliveryCoordinates)
        try container.encodeIfPresent(dispatchCoordinates, forKey: .dispatchCoordinates)
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
        isUrgent = try container.decode(Bool.self, forKey: .isUrgent)
        deliveryTs = try container.decodeIfPresent(String.self, forKey: .deliveryTs)
        deliveryCoordinates = try container.decodeIfPresent(CoordinatesObject.self, forKey: .deliveryCoordinates)
        dispatchCoordinates = try container.decodeIfPresent(CoordinatesObject.self, forKey: .dispatchCoordinates)
        if let metaData = try? container.decodeIfPresent(Data.self, forKey: .meta) {
            meta = try? (JSONSerialization.jsonObject(with: metaData, options: .allowFragments) as! any Encodable)
        } else {
            meta = nil
        }
        
    }
}
