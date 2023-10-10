//
//  File.swift
//  
//
//  Created by khushbu on 09/10/23.
//

import Foundation


struct MediaObject:Codable {
    var id:String?
    var type:String?
    var action:String?
    var time:String?
    var meta:Any?
    
    init(id: String, type: String? = nil, action: String? = nil, time: String? = nil, meta: Any? = nil) {
        self.id = id
        self.type = type
        self.action = action
        self.time = time
        self.meta = meta
    }
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case type = "type"
        case action = "action"
        case time = "time"
        case meta = "meta"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        type = try values.decodeIfPresent(String.self, forKey: .type)
        action = try values.decodeIfPresent(String.self, forKey: .action)
        time = try values.decodeIfPresent(String.self, forKey: .time)
        
        if let decodeMetaInt =  try values.decodeIfPresent(Int.self, forKey: .meta) {
            meta = decodeMetaInt
        }else if let decodeMetaString = try values.decodeIfPresent(String.self, forKey: .meta) {
            meta = decodeMetaString
        }else {
            meta = nil
        }
       
        
        
    }
    
    // MARK: Encodable
    func encode(to encoder: Encoder) throws {
        var baseContainer = encoder.container(keyedBy: CodingKeys.self)
        try baseContainer.encode(self.id, forKey: .id)
        
        try baseContainer.encode(self.type, forKey: .type)
        try baseContainer.encode(self.action, forKey: .action)
        try baseContainer.encode(self.time, forKey: .time)
        
        let dataEncoder = baseContainer.superEncoder(forKey: .meta)
        
        // Use the Encoder directly:
        if let metaAsInt = self.meta as? Int {
            try (metaAsInt).encode(to: dataEncoder)
        }else if let metaAsString = self.meta as? String {
            try (metaAsString).encode(to: dataEncoder)
        }else if let metaAsDouble = self.meta as? Double {
            try (metaAsDouble).encode(to: dataEncoder)
        }
        
    }
}
