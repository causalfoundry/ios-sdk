//
//  OxygenMetaModel.swift
//
//
//  Created by khushbu on 30/10/23.
//

import Foundation

struct OxygenMetaModel: Codable {
    var orderType: String
    var reason: String

    enum CodingKeys: String, CodingKey {
        case orderType = "order_type"
        case reason
    }

    init(orderType: String = "", reason: String = "") {
        self.orderType = orderType
        self.reason = reason
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        orderType = try container.decode(String.self, forKey: .orderType)
        reason = try container.decode(String.self, forKey: .reason)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(orderType, forKey: .orderType)
        try container.encode(reason, forKey: .reason)
    }
}
