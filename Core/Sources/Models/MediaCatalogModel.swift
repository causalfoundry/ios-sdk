//
//  File.swift
//
//
//  Created by khushbu on 09/10/23.
//

import Foundation


public struct MediaCatalogModel:Codable,Equatable {
    
    let name:String?
    let description:String?
    let length:String?
    let resolution:String?
    var language:String?
    
    
    enum CodingKeys: String, CodingKey {
        case name = "media_name"
        case description = "media_description"
        case length
        case resolution
        case language
    }
    
    
    public init(name: String? = nil, description: String? = nil, length: String? = nil, resolution: String? = nil, language: String? = nil) {
        self.name = name
        self.description = description
        self.length = length
        self.resolution = resolution
        self.language = language
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decodeIfPresent(String.self, forKey: .name)
        description = try container.decodeIfPresent(String.self, forKey: .description)
        length = try container.decodeIfPresent(String.self, forKey: .length)
        resolution = try container.decodeIfPresent(String.self, forKey: .resolution)
        language = try container.decodeIfPresent(String.self, forKey: .language)
    }
    
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(name, forKey: .name)
        try container.encodeIfPresent(description, forKey: .description)
        try container.encodeIfPresent(length, forKey: .length)
        try container.encodeIfPresent(resolution, forKey: .resolution)
        try container.encodeIfPresent(language, forKey: .language)
    }
}
