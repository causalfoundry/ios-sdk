//
//  OxygenCatalogModel.swift
//
//
//  Created by moizhassankh on 07/12/23.
//

import Foundation

public struct OxygenCatalogModel: Codable {
    var itemId: String
    var marketId: String?
    var packaging: String?
    var packagingSize: Float?
    var packagingUnits: String?
    var supplierId: String?
    var supplierName: String?

    enum CodingKeys: String, CodingKey {
        case itemId = "id"
        case marketId = "market_id"
        case packaging
        case packagingSize = "packaging_size"
        case packagingUnits = "packaging_units"
        case supplierId = "supplier_id"
        case supplierName = "supplier_name"
    }

    public init(itemId: String, marketId: String? = "", packaging: String? = "", packagingSize: Float? = 0, packagingUnits: String? = "", supplierId: String? = "", supplierName: String? = "") {
        self.itemId = itemId
        self.packaging = packaging
        self.packagingSize = packagingSize
        self.packagingUnits = packagingUnits
        self.supplierId = supplierId
        self.supplierName = supplierName
    }

    // MARK: - Codable methods

    // Custom encoding
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(itemId, forKey: .itemId)
        try container.encodeIfPresent(marketId, forKey: .marketId)
        try container.encodeIfPresent(packaging, forKey: .packaging)
        try container.encodeIfPresent(packagingSize, forKey: .packagingSize)
        try container.encodeIfPresent(packagingUnits, forKey: .packagingUnits)
        try container.encodeIfPresent(supplierId, forKey: .supplierId)
        try container.encodeIfPresent(supplierName, forKey: .supplierName)
    }

    // Custom decoding
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        itemId = try container.decode(String.self, forKey: .itemId)
        marketId = try container.decodeIfPresent(String.self, forKey: .marketId)
        packaging = try container.decodeIfPresent(String.self, forKey: .packaging)
        packagingSize = try container.decodeIfPresent(Float.self, forKey: .packagingSize)
        packagingUnits = try container.decodeIfPresent(String.self, forKey: .packagingUnits)
        supplierId = try container.decodeIfPresent(String.self, forKey: .supplierId)
        supplierName = try container.decodeIfPresent(String.self, forKey: .supplierName)
    }
}
