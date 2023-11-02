//
//  RecyclerImpressionModel.swift
//
//
//  Created by khushbu on 02/11/23.
//

import Foundation


public struct RecyclerImpressionModel: Codable {
    var element_id: String
    var content_block: String
    var event_name: String
    var catalog_subject: String
    var item_properties: Encodable?
    var catalog_properties: Encodable?
    
    enum CodingKeys: String, CodingKey {
        case element_id
        case content_block
        case event_name
        case catalog_subject
        case item_properties
        case catalog_properties
    }
    
    
    public init(element_id: String, content_block: String, event_name: String, catalog_subject: String, item_properties: Encodable? = nil, catalog_properties: Encodable? = nil) {
        self.element_id = element_id
        self.content_block = content_block
        self.event_name = event_name
        self.catalog_subject = catalog_subject
        self.item_properties = item_properties
        self.catalog_properties = catalog_properties
    }
    
    //    // Implement the custom initializer for decoding if needed
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        element_id = try container.decode(String.self, forKey: .element_id)
        content_block = try container.decode(String.self, forKey: .content_block)
        event_name = try container.decode(String.self, forKey: .event_name)
        catalog_subject = try container.decode(String.self, forKey: .catalog_subject)
        
        if let itemPropertiesData = try container.decodeIfPresent(Data.self, forKey: .item_properties) {
            item_properties = try? (JSONSerialization.jsonObject(with: itemPropertiesData, options: .allowFragments) as! any Encodable)
        } else {
            item_properties = nil
        }
        if let catalogPropertiesData = try container.decodeIfPresent(Data.self, forKey: .catalog_properties) {
            catalog_properties = try? (JSONSerialization.jsonObject(with: catalogPropertiesData, options: .allowFragments) as! any Encodable)
        } else {
            catalog_properties = nil
        }
        
    }
    
    // Implement the encoding method if needed
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(element_id, forKey: .element_id)
        try container.encode(content_block, forKey: .content_block)
        try container.encode(event_name, forKey: .event_name)
        try container.encode(catalog_subject, forKey: .catalog_subject)
        
        if let itemproperties = item_properties {
            try container.encode(itemproperties, forKey: .item_properties)
        }
        
        if let catalogProperties = catalog_properties {
            try container.encode(catalogProperties, forKey: .item_properties)
        }
        
        
    }
}

