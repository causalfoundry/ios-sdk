//
//  PromoObject.swift
//
//
//  Created by khushbu on 07/11/23.
//

import Foundation

public struct PromoObject: Codable {
    var promoId: String
    var promoAction: String
    var promoTitle: String
    var promoType: String
    var promoItemsList: [String]
    var meta: Encodable?

    private enum CodingKeys: String, CodingKey {
        case promoId = "id"
        case promoAction = "action"
        case promoTitle = "title"
        case promoType = "type"
        case promoItemsList = "items"
        case meta
    }

    public init(promoId: String, promoAction: PromoAction, promoTitle: String, promoType: PromoType, promoItemsList: [String], meta: Encodable? = nil) {
        self.promoId = promoId
        self.promoAction = promoAction.rawValue
        self.promoTitle = promoTitle
        self.promoType = promoType.rawValue
        self.promoItemsList = promoItemsList.filter { !$0.isEmpty }.removingDuplicates()
        self.meta = meta
    }

    // Encoding
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(promoId, forKey: .promoId)
        try container.encode(promoAction, forKey: .promoAction)
        try container.encode(promoTitle, forKey: .promoTitle)
        try container.encode(promoType, forKey: .promoType)
        try container.encode(promoItemsList, forKey: .promoItemsList)
        if let metaData = meta {
            try container.encode(metaData, forKey: .meta)
        }
    }

    // Decoding
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        promoId = try container.decode(String.self, forKey: .promoId)
        promoAction = try container.decode(String.self, forKey: .promoAction)
        promoTitle = try container.decode(String.self, forKey: .promoTitle)
        promoType = try container.decode(String.self, forKey: .promoType)
        promoItemsList = try container.decode([String].self, forKey: .promoItemsList)
        if let metaData = try? container.decodeIfPresent(Data.self, forKey: .meta) {
            meta = try? (JSONSerialization.jsonObject(with: metaData, options: .allowFragments) as! any Encodable)
        } else {
            meta = nil
        }
    }
}
