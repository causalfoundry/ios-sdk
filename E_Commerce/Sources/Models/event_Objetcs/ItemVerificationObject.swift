//
//  ItemVerificationObject.swift
//
//
//  Created by khushbu on 01/11/23.
//

import Foundation


public struct ItemVerificationObject: Codable {
    let scan_channel: String
    let scan_type: String
    let is_successful: Bool
    let item_info: ItemInfoObject?
    let meta: Encodable?
    
    enum CodingKeys: String, CodingKey {
        case scan_channel
        case scan_type
        case is_successful
        case item_info
        case meta
    }
    
    public init(scan_channel: String, scan_type: String, is_successful: Bool, item_info: ItemInfoObject? = nil, meta: Encodable? = nil) {
        self.scan_channel = scan_channel
        self.scan_type = scan_type
        self.is_successful = is_successful
        self.item_info = item_info
        self.meta = meta
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        scan_channel = try container.decode(String.self, forKey: .scan_channel)
        scan_type = try container.decode(String.self, forKey: .scan_type)
        is_successful = try container.decode(Bool.self, forKey: .is_successful)
        item_info = try container.decodeIfPresent(ItemInfoObject.self, forKey: .item_info)
        if let metaData = try container.decodeIfPresent(Data.self, forKey: .meta) {
            meta = try? (JSONSerialization.jsonObject(with: metaData, options: .allowFragments) as! any Encodable)
        } else {
            meta = nil
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(scan_channel, forKey: .scan_channel)
        try container.encode(scan_type, forKey: .scan_type)
        try container.encode(is_successful, forKey: .is_successful)
        try container.encode(item_info, forKey: .item_info)
        if let metaData = meta {
            try container.encode(metaData, forKey: .meta)
        }
        
    }
}
