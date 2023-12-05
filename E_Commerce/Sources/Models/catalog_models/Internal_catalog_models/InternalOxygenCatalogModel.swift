//
//  InternalOxygenCatalogModel.swift
//
//
//  Created by khushbu on 30/10/23.
//

import Foundation

struct InternalOxygenCatalogModel: Codable {
    var id: String?
    var market_id: String?
    var packaging: String?
    var packaging_size: Float?
    var packaging_units: String?
    var supplier_id: String?
    var supplier_name: String?

    enum CodingKeys: String, CodingKey {
        case id
        case market_id
        case packaging
        case packaging_size
        case packaging_units
        case supplier_id
        case supplier_name
    }

    init(id: String? = nil, market_id: String? = nil, packaging: String? = nil, packaging_size: Float? = nil, packaging_units: String? = nil, supplier_id: String? = nil, supplier_name: String? = nil) {
        self.id = id
        self.market_id = market_id
        self.packaging = packaging
        self.packaging_size = packaging_size
        self.packaging_units = packaging_units
        self.supplier_id = supplier_id
        self.supplier_name = supplier_name
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decodeIfPresent(String.self, forKey: .id)
        market_id = try container.decodeIfPresent(String.self, forKey: .market_id)
        packaging = try container.decodeIfPresent(String.self, forKey: .packaging)
        packaging_size = try container.decodeIfPresent(Float.self, forKey: .packaging_size)
        packaging_units = try container.decodeIfPresent(String.self, forKey: .packaging_units)
        supplier_id = try container.decodeIfPresent(String.self, forKey: .supplier_id)
        supplier_name = try container.decodeIfPresent(String.self, forKey: .supplier_name)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(market_id, forKey: .market_id)
        try container.encode(packaging, forKey: .packaging)
        try container.encode(packaging_size, forKey: .packaging_size)
        try container.encode(packaging_units, forKey: .packaging_units)
        try container.encode(supplier_id, forKey: .supplier_id)
        try container.encode(supplier_name, forKey: .supplier_name)
    }
}
