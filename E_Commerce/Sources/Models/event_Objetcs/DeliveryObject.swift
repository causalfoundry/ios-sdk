//
//  DeliveryObject.swift
//
//
//  Created by khushbu on 29/10/23.
//

import Foundation


import Foundation

internal struct DeliveryObject: Codable {
    var id: String
    var order_id: String
    var action: String
    var meta: Encodable?
    
    enum CodingKeys: String, CodingKey {
        case id
        case order_id
        case action
        case meta
    }
    
    init(id: String, order_id: String, action: String, meta: Encodable? = nil) {
        self.id = id
        self.order_id = order_id
        self.action = action
        self.meta = meta
    }
    
    // MARK: - Codable
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(String.self, forKey: .id)
        order_id = try container.decode(String.self, forKey: .order_id)
        action = try container.decode(String.self, forKey: .action)
        if let metaData = try container.decodeIfPresent(Data.self, forKey: .meta) {
            meta = try? (JSONSerialization.jsonObject(with: metaData, options: .allowFragments) as! any Encodable)
        } else {
            meta = nil
        }
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(order_id, forKey: .order_id)
        try container.encode(action, forKey: .action)
        if let metaData = meta {
            try container.encode(metaData, forKey: .meta)
        }
    }
}

