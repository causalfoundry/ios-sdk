//
//  EventDataObject.swift
//  
//
//  Created by khushbu on 21/09/23.
//

import Foundation


struct EventDataObject: Codable {
    var content_block: String
    var online: Bool
    var ts: Date
    var event_type: String
    var event_properties: Encodable?
    
    enum CodingKeys: String, CodingKey {
        case content_block = "block"
        case online = "ol"
        case ts
        case event_type = "type"
        case event_properties = "props"
    }
    
    init(content_block: String, online: Bool, ts: Date, event_type: String, event_properties: Encodable? = nil) {
        self.content_block = content_block
        self.online = online
        self.ts = ts
        self.event_type = event_type
        self.event_properties = event_properties
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(content_block, forKey: .content_block)
        try container.encode(online, forKey: .online)
        try container.encode(ISO8601DateFormatter().string(from: ts), forKey: .ts)
        try container.encode(event_type, forKey: .event_type)
        
        if let properties = event_properties {
            try container.encode(properties, forKey: .event_properties)
          
        }
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        content_block = try container.decode(String.self, forKey: .content_block)
        online = try container.decode(Bool.self, forKey: .online)
        let dateString = try container.decode(String.self, forKey: .ts)
        guard let date = ISO8601DateFormatter().date(from: dateString) else {
            throw DecodingError.dataCorruptedError(forKey: .ts, in: container, debugDescription: "date string not in ISO8601 format")
        }
        ts = date
        event_type = try container.decode(String.self, forKey: .event_type)
        
        if let propertiesData = try container.decodeIfPresent(Data.self, forKey: .event_properties) {
            event_properties = try? (JSONSerialization.jsonObject(with: propertiesData, options: .allowFragments) as! any Encodable)
        } else {
            event_properties = nil
        }
    }
}






// Define a protocol that requires conformance to Codable
protocol ModelData: Codable {}

// Create a struct that can hold any model data
struct AnyModelData<T: ModelData>: Codable {
    var model: T
}





