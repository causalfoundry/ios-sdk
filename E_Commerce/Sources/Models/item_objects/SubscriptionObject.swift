//
//  SubscriptionObject.swift
//
//
//  Created by moizhassankh on 4/12/23.
//

import Foundation

public struct SubscriptionObject: Codable {
    var status: String
    var type: String
    var subscriptionItems: [ItemTypeModel]?

    // Custom coding keys enum
    enum CodingKeys: String, CodingKey {
        case status
        case type
        case subscriptionItems = "subscription_items"
    }

    
    public init(status: String, type: String, subscriptionItems: [ItemTypeModel]? = []) {
        self.status = status
        self.type = type
        self.subscriptionItems = subscriptionItems
    }
    
    // Encoding method
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(status, forKey: .status)
        try container.encode(type, forKey: .type)
        try container.encode(subscriptionItems, forKey: .subscriptionItems)
    }

//    // Decoding method
    public  init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        status = try container.decode(String.self, forKey: .status)
        type = try container.decode(String.self, forKey: .type)
        subscriptionItems = try container.decode([ItemTypeModel].self, forKey: .subscriptionItems)
    }
}
