//
//  PromoObject.swift
//
//
//  Created by khushbu on 07/11/23.
//

import Foundation

public struct PromoObject: Codable {
    var promo_id: String
    var promo_action: String
    var promo_title: String
    var promo_type: String
    var promo_items_list: [PromoItemObject]
    var meta: Encodable?
    
    enum CodingKeys: String, CodingKey {
        case promo_id = "id"
        case promo_action = "action"
        case promo_title = "title"
        case promo_type = "type"
        case promo_items_list = "items"
        case meta
    }

    public init(promo_id: String, promo_action: String, promo_title: String, promo_type: String, promo_items_list: [PromoItemObject], meta: Encodable?) {
        self.promo_id = promo_id
        self.promo_action = promo_action
        self.promo_title = promo_title
        self.promo_type = promo_type
        self.promo_items_list = promo_items_list
        self.meta = meta
    }

    // Encoding
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys)
        try container.encode(promo_id, forKey: .promo_id)
        try container.encode(promo_action, forKey: .promo_action)
        try container.encode(promo_title, forKey: .promo_title)
        try container.encode(promo_type, forKey: .promo_type)
        try container.encode(promo_items_list, forKey: .promo_items_list)
        try container.encodeIfPresent(meta, forKey: .meta)
    }

    // Decoding
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys)
        promo_id = try container.decode(String.self, forKey: .promo_id)
        promo_action = try container.decode(String.self, forKey: .promo_action)
        promo_title = try container.decode(String.self, forKey: .promo_title)
        promo_type = try container.decode(String.self, forKey: .promo_type)
        promo_items_list = try container.decode([PromoItemObject].self, forKey: .promo_items_list)
        meta = try container.decodeIfPresent(Any.self, forKey: .meta)
    }
}
