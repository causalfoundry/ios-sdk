//
//  ViewItemObject.swift
//
//
//  Created by khushbu on 30/10/23.
//

import Foundation

public struct ViewItemObject: Codable {
    var action: String
    var item: ItemModel
    var searchId: String
    var meta: Encodable?

    private enum CodingKeys: String, CodingKey {
        case action
        case item
        case searchId = "search_id"
        case meta
    }
    
    
    public init(action: EComItemAction, item: ItemModel, searchId: String = "", meta: Encodable? = nil) {
        self.action = action.rawValue
        self.item = item
        self.searchId = searchId
        self.meta = meta
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        action = try container.decode(String.self, forKey: .action)
        item = try container.decode(ItemModel.self, forKey: .item)
        searchId = try container.decode(String.self, forKey: .searchId)
        if let metaData = try container.decodeIfPresent(Data.self, forKey: .meta) {
            meta = try? (JSONSerialization.jsonObject(with: metaData, options: .allowFragments) as! any Encodable)
        } else {
            meta = nil
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(action, forKey: .action)
        try container.encode(item, forKey: .item)
        try container.encode(searchId, forKey: .searchId)
        if let metaData = meta {
            try container.encodeIfPresent(metaData, forKey: .meta)
        }
    }
}
