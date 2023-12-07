//
//  ReportObject.swift
//
//
//  Created by khushbu on 01/11/23.
//

import Foundation

public struct ReportObject : Codable {
    var id: String
    var shortDesc: String
    var remarks: String? = ""

    enum CodingKeys: String, CodingKey {
        case id
        case shortDesc = "short_desc"
        case remarks
    }
    
    public init(id: String, shortDesc: String, remarks: String? = "") {
        self.id = id
        self.shortDesc = shortDesc
        self.remarks = remarks
    }
    
    // Custom encoding method
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(shortDesc, forKey: .shortDesc)
        try container.encode(remarks, forKey: .remarks)
    }

    // Custom decoding method
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(String.self, forKey: .id)
        shortDesc = try container.decode(String.self, forKey: .shortDesc)
        remarks = try container.decode(String.self, forKey: .remarks)
    }
    
}
