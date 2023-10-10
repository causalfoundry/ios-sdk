//
//  File.swift
//  
//
//  Created by khushbu on 06/10/23.
//

import Foundation


struct PageObject:Codable {
    var path:String?
    var title:String?
    var duration:Float?
    var render_time:Int?
    var meta:Any?
    
    init(path: String? = nil, title: String? = nil, duration: Float? = nil, render_time: Int? = nil, meta: Any? = nil) {
        self.path = path
        self.title = title
        self.duration = duration
        self.render_time = render_time
        self.meta = meta
    }
    
    enum CodingKeys: String, CodingKey {
        case path = "path"
        case title = "title"
        case duration = "duration"
        case render_time = "render_time"
        case meta = "meta"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        path = try values.decodeIfPresent(String.self, forKey: .path)
        title = try values.decodeIfPresent(String.self, forKey: .title)
        duration = try values.decodeIfPresent(Float.self, forKey: .duration)
        render_time = try values.decodeIfPresent(Int.self, forKey: .render_time)
        
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
        try baseContainer.encode(self.path, forKey: .path)
        
        try baseContainer.encode(self.title, forKey: .title)
        try baseContainer.encode(self.duration, forKey: .duration)
        try baseContainer.encode(self.render_time, forKey: .render_time)
        
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
