//
//  PromoObject.swift
//
//
//  Created by khushbu on 07/11/23.
//

import Foundation

public struct PromoObject: Codable {
    var promoId: String
    var action: String
    var promoTitle: String
    var type: String
    var promoItemsList: [PromoItemObject]
    var meta: Encodable?

    private enum CodingKeys: String, CodingKey {
        case promoId = "id"
        case action = "action"
        case promoTitle = "title"
        case type = "type"
        case promoItemsList = "items"
        case meta
    }

    public init(promoId: String, action: PromoAction, promoTitle: String, type: PromoType, promoItemsList: [PromoItemObject], meta: Encodable? = nil) {
        self.promoId = promoId
        self.action = action.rawValue
        self.promoTitle = promoTitle
        self.type = type.rawValue
        self.promoItemsList = promoItemsList
        self.meta = meta
    }

    // Encoding
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(promoId, forKey: .promoId)
        try container.encode(action, forKey: .action)
        try container.encode(promoTitle, forKey: .promoTitle)
        try container.encode(type, forKey: .type)
        try container.encode(promoItemsList, forKey: .promoItemsList)
        if let metaData = meta {
            try container.encode(metaData, forKey: .meta)
        }
    }

    // Decoding
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        promoId = try container.decode(String.self, forKey: .promoId)
        action = try container.decode(String.self, forKey: .action)
        promoTitle = try container.decode(String.self, forKey: .promoTitle)
        type = try container.decode(String.self, forKey: .type)
        promoItemsList = try container.decode([PromoItemObject].self, forKey: .promoItemsList)
        if let metaData = try? container.decodeIfPresent(Data.self, forKey: .meta) {
            meta = try? (JSONSerialization.jsonObject(with: metaData, options: .allowFragments) as! any Encodable)
        } else {
            meta = nil
        }
    }
}
