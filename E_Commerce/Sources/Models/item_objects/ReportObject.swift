//
//  ReportObject.swift
//
//
//  Created by khushbu on 01/11/23.
//

import Foundation

public struct ReportObject {
    var id: String
    var short_desc: String
    var remarks: String
    
    
    
    public init(id: String, short_desc: String, remarks: String) {
        self.id = id
        self.short_desc = short_desc
        self.remarks = remarks
    }
}

extension ReportObject: Encodable {
    public  func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(short_desc, forKey: .short_desc)
        try container.encode(remarks, forKey: .remarks)
    }

    private enum CodingKeys: String, CodingKey {
        case id
        case short_desc
        case remarks
    }
}

extension ReportObject: Decodable {
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(String.self, forKey: .id)
        short_desc = try container.decode(String.self, forKey: .short_desc)
        remarks = try container.decode(String.self, forKey: .remarks)
    }
}
