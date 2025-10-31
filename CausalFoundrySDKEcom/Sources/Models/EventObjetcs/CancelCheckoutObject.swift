//
//  CancelCheckoutObject.swift
//
//
//  Created by khushbu on 01/11/23.
//

import Foundation

public struct CancelCheckoutObject: Codable {
    var checkoutId: String
    var type: String
    var itemList: [String] = []
    var reason: String = ""
    var meta: Encodable? = nil

    public init(checkoutId: String, type: CancelType, itemList: [String], reason: String = "", meta: Encodable? = nil) {
        self.checkoutId = checkoutId
        self.type = type.rawValue
        self.itemList = itemList
        self.reason = reason
        self.meta = meta
    }

    // CodingKeys to map the keys if they differ from the property names
    private enum CodingKeys: String, CodingKey {
        case checkoutId = "id"
        case type
        case itemList = "items_list"
        case reason
        case meta
    }

    // Custom encoding method
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(checkoutId, forKey: .checkoutId)
        try container.encode(type, forKey: .type)
        try container.encode(reason, forKey: .reason)
        try container.encode(itemList, forKey: .itemList)
        if let metaData = meta {
            try container.encode(metaData, forKey: .meta)
        }
        
    }

    // Custom decoding method
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        checkoutId = try container.decode(String.self, forKey: .checkoutId)
        type = try container.decode(String.self, forKey: .type)
        reason = try container.decode(String.self, forKey: .reason)
        itemList = try container.decode([String].self, forKey: .itemList)
        if let metaData = try? container.decodeIfPresent(Data.self, forKey: .meta) {
            meta = try? (JSONSerialization.jsonObject(with: metaData, options: .allowFragments) as! any Encodable)
        } else {
            meta = nil
        }
    }
    
}
