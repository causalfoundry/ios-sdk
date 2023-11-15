//
//  InternalMediaModel.swift
//
//
//  Created by khushbu on 09/10/23.
//

import Foundation

struct InternalMediaModel: Codable {
    var media_id: String?
    var media_name: String?
    var media_description: String?
    var type: String?
    var length: String?
    var resolution: String?
    var language: String?
    
    // Custom CodingKeys enum
    private enum CodingKeys: String, CodingKey {
        case media_id
        case media_name
        case media_description
        case type
        case length
        case resolution
        case language
    }
    
    // Custom initializer
    init(
        media_id: String? = nil,
        media_name: String? = nil,
        media_description: String? = nil,
        type: String? = nil,
        length: String? = nil,
        resolution: String? = nil,
        language: String? = nil
    ) {
        self.media_id = media_id
        self.media_name = media_name
        self.media_description = media_description
        self.type = type
        self.length = length
        self.resolution = resolution
        self.language = language
    }
    
    
    public func encode() throws -> Data {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        return try encoder.encode(self)
    }

    // Decoding method
    public func decode(from data: Data) throws -> InternalMediaModel {
        let decoder = JSONDecoder()
        return try decoder.decode(InternalMediaModel.self, from: data)
    }
}

    

