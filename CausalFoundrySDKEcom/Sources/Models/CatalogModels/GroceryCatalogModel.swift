//
//  GroceryCatalogModel.swift
//
//
//  Created by moizhassankh on 07/12/23.
//

import Foundation

public struct GroceryCatalogModel: Codable {
    var groceryId: String
    var name: String
    var category: String?
    var marketId: String?
    var description: String?
    var supplierId: String?
    var supplierName: String?
    var producer: String?
    var packaging: String?
    var packagingSize: Float?
    var packagingUnits: String?
    var activeIngredients: [String]?

    enum CodingKeys: String, CodingKey {
        case groceryId = "id"
        case name
        case category
        case marketId = "market_id"
        case description
        case supplierId = "supplier_id"
        case supplierName = "supplier_name"
        case producer
        case packaging
        case packagingSize = "packaging_size"
        case packagingUnits = "packaging_units"
        case activeIngredients = "active_ingredients"
    }

    public init(groceryId: String, name: String, category: String? = "", marketId: String? = "", description: String? = "", supplierId: String? = "", supplierName: String? = "", producer: String? = "", packaging: String? = "", packagingSize: Float? = 0, packagingUnits: String? = "", activeIngredients: [String]? = []) {
        self.groceryId = groceryId
        self.name = name
        self.category = category
        self.marketId = marketId
        self.description = description
        self.supplierId = supplierId
        self.supplierName = supplierName
        self.producer = producer
        self.packaging = packaging
        self.packagingSize = packagingSize
        self.packagingUnits = packagingUnits
        self.activeIngredients = activeIngredients
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        groceryId = try container.decode(String.self, forKey: .groceryId)
        name = try container.decode(String.self, forKey: .name)
        category = try container.decodeIfPresent(String.self, forKey: .category)
        marketId = try container.decodeIfPresent(String.self, forKey: .marketId)
        description = try container.decodeIfPresent(String.self, forKey: .description)
        supplierId = try container.decodeIfPresent(String.self, forKey: .supplierId)
        supplierName = try container.decodeIfPresent(String.self, forKey: .supplierName)
        producer = try container.decodeIfPresent(String.self, forKey: .producer)
        packaging = try container.decodeIfPresent(String.self, forKey: .packaging)
        packagingSize = try container.decodeIfPresent(Float.self, forKey: .packagingSize)
        packagingUnits = try container.decodeIfPresent(String.self, forKey: .packagingUnits)
        activeIngredients = try container.decodeIfPresent([String].self, forKey: .activeIngredients)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(groceryId, forKey: .groceryId)
        try container.encode(name, forKey: .name)
        try container.encodeIfPresent(category, forKey: .category)
        try container.encodeIfPresent(marketId, forKey: .marketId)
        try container.encodeIfPresent(description, forKey: .description)
        try container.encodeIfPresent(supplierId, forKey: .supplierId)
        try container.encodeIfPresent(supplierName, forKey: .supplierName)
        try container.encodeIfPresent(producer, forKey: .producer)
        try container.encodeIfPresent(packaging, forKey: .packaging)
        try container.encodeIfPresent(packagingSize, forKey: .packagingSize)
        try container.encodeIfPresent(packagingUnits, forKey: .packagingUnits)
        try container.encodeIfPresent(activeIngredients, forKey: .activeIngredients)
    }
}

