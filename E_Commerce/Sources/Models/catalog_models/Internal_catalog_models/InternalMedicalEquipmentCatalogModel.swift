//
//  InternalMedicalEquipmentCatalogModel.swift
//
//
//  Created by khushbu on 30/10/23.
//
import Foundation

struct InternalMedicalEquipmentCatalogModel: Codable {
    var id: String?
    var name: String?
    var description: String?
    var market_id: String?
    var supplier_id: String?
    var supplier_name: String?
    var producer: String?
    var packaging: String?
    var packaging_size: Float?
    var packaging_units: String?
    var category: String?

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case description
        case market_id
        case supplier_id
        case supplier_name
        case producer
        case packaging
        case packaging_size
        case packaging_units
        case category
    }

    init(id: String? = nil, name: String? = nil, description: String? = nil, market_id: String? = nil, supplier_id: String? = nil, supplier_name: String? = nil, producer: String? = nil, packaging: String? = nil, packaging_size: Float? = nil, packaging_units: String? = nil, category: String? = nil) {
        self.id = id
        self.name = name
        self.description = description
        self.market_id = market_id
        self.supplier_id = supplier_id
        self.supplier_name = supplier_name
        self.producer = producer
        self.packaging = packaging
        self.packaging_size = packaging_size
        self.packaging_units = packaging_units
        self.category = category
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decodeIfPresent(String.self, forKey: .id)
        name = try container.decodeIfPresent(String.self, forKey: .name)
        description = try container.decodeIfPresent(String.self, forKey: .description)
        market_id = try container.decodeIfPresent(String.self, forKey: .market_id)
        supplier_id = try container.decodeIfPresent(String.self, forKey: .supplier_id)
        supplier_name = try container.decodeIfPresent(String.self, forKey: .supplier_name)
        producer = try container.decodeIfPresent(String.self, forKey: .producer)
        packaging = try container.decodeIfPresent(String.self, forKey: .packaging)
        packaging_size = try container.decodeIfPresent(Float.self, forKey: .packaging_size)
        packaging_units = try container.decodeIfPresent(String.self, forKey: .packaging_units)
        category = try container.decodeIfPresent(String.self, forKey: .category)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(description, forKey: .description)
        try container.encode(market_id, forKey: .market_id)
        try container.encode(supplier_id, forKey: .supplier_id)
        try container.encode(supplier_name, forKey: .supplier_name)
        try container.encode(producer, forKey: .producer)
        try container.encode(packaging, forKey: .packaging)
        try container.encode(packaging_size, forKey: .packaging_size)
        try container.encode(packaging_units, forKey: .packaging_units)
        try container.encode(category, forKey: .category)
    }
}

