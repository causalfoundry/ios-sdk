//
//  MedicalEquipmentCatalogModel.swift
//
//
//  Created by moizhassankh on 07/12/23.
//

import Foundation

public struct MedicalEquipmentCatalogModel: Codable {
    var itemId: String
    var name: String
    var description: String?
    var marketId: String?
    var supplierId: String?
    var supplierName: String?
    var producer: String?
    var packaging: String?
    var packagingSize: Float?
    var packagingUnits: String?
    var category: String?

    enum CodingKeys: String, CodingKey {
        case itemId = "id"
        case name
        case description
        case marketId = "market_id"
        case supplierId = "supplier_id"
        case supplierName = "supplier_name"
        case producer
        case packaging
        case packagingSize = "packaging_size"
        case packagingUnits = "packaging_units"
        case category
    }

    public init(itemId: String, name: String, description: String? = "", marketId: String? = "", supplierId: String? = "", supplierName: String? = "", producer: String? = "", packaging: String? = "", packagingSize: Float? = 0, packagingUnits: String? = "", category: String? = "") {
        self.itemId = itemId
        self.name = name
        self.description = description
        self.marketId = marketId
        self.supplierId = supplierId
        self.supplierName = supplierName
        self.producer = producer
        self.packaging = packaging
        self.packagingSize = packagingSize
        self.packagingUnits = packagingUnits
        self.category = category
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(itemId, forKey: .itemId)
        try container.encode(name, forKey: .name)
        try container.encodeIfPresent(description, forKey: .description)
        try container.encodeIfPresent(marketId, forKey: .marketId)
        try container.encodeIfPresent(supplierId, forKey: .supplierId)
        try container.encodeIfPresent(supplierName, forKey: .supplierName)
        try container.encodeIfPresent(producer, forKey: .producer)
        try container.encodeIfPresent(packaging, forKey: .packaging)
        try container.encodeIfPresent(packagingSize, forKey: .packagingSize)
        try container.encodeIfPresent(packagingUnits, forKey: .packagingUnits)
        try container.encodeIfPresent(category, forKey: .category)
    }

    // Custom decoding
   public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
       itemId = try container.decode(String.self, forKey: .itemId)
        name = try container.decode(String.self, forKey: .name)
        description = try container.decodeIfPresent(String.self, forKey: .description)
        marketId = try container.decodeIfPresent(String.self, forKey: .marketId)
        supplierId = try container.decodeIfPresent(String.self, forKey: .supplierId)
        supplierName = try container.decodeIfPresent(String.self, forKey: .supplierName)
        producer = try container.decodeIfPresent(String.self, forKey: .producer)
        packaging = try container.decodeIfPresent(String.self, forKey: .packaging)
        packagingSize = try container.decodeIfPresent(Float.self, forKey: .packagingSize)
        packagingUnits = try container.decodeIfPresent(String.self, forKey: .packagingUnits)
        category = try container.decodeIfPresent(String.self, forKey: .category)
    }
}

