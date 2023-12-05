//
//  File.swift
//  
//
//  Created by khushbu on 30/10/23.
//

import Foundation

struct OxygenMetaModel: Codable {
    var order_type: String
    var reason: String

    enum CodingKeys: String, CodingKey {
        case order_type
        case reason
    }

    init(order_type: String = "", reason: String = "") {
        self.order_type = order_type
        self.reason = reason
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        order_type = try container.decode(String.self, forKey: .order_type)
        reason = try container.decode(String.self, forKey: .reason)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(order_type, forKey: .order_type)
        try container.encode(reason, forKey: .reason)
    }
}
