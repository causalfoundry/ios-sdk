//
//  File.swift
//
//
//  Created by khushbu on 30/10/23.
//

import Foundation

public struct ViewItemObject: Codable {
    var action: String?
    var item: ItemModel
    var search_id: String?
    var usd_rate: Float?
    var meta: Encodable?
    
    private enum CodingKeys: String, CodingKey {
        case action
        case item
        case search_id = "search_id"
        case usd_rate = "usd_rate"
        case meta
    }
    
    
    init(action: String, item: ItemModel, search_id: String? = nil, usd_rate: Float? = nil, meta: Encodable? = nil) {
        self.action = action
        self.item = item
        self.search_id = search_id
        self.usd_rate = usd_rate
        self.meta = meta
    }
    
   public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        action = try container.decode(String.self, forKey: .action)
        item = try container.decode(ItemModel.self, forKey: .item)
        search_id = try container.decodeIfPresent(String.self, forKey: .search_id)
        usd_rate = try container.decodeIfPresent(Float.self, forKey: .usd_rate)
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
        try container.encode(search_id, forKey: .search_id)
        try container.encode(usd_rate, forKey: .usd_rate)
        if let metaData = meta {
            try container.encode(metaData, forKey: .meta)
        }
    }
    
}

