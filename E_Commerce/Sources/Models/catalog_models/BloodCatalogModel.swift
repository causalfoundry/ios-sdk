//
//  BloodCatalogModel.swift
//
//
//  Created by khushbu on 27/10/23.
//

import Foundation

public struct BloodCatalogModel: Codable {
    var marketId: String?
    var bloodComponent: String?
    var bloodGroup: String?
    var packaging: String?
    var packagingSize: Float?
    var packagingUnits: String?
    var supplierId: String?
    var supplierName: String?

    enum CodingKeys: String, CodingKey {
        case marketId = "market_id"
        case bloodComponent = "blood_component"
        case bloodGroup = "blood_group"
        case packaging
        case packagingSize = "packaging_size"
        case packagingUnits = "packaging_units"
        case supplierId = "supplier_id"
        case supplierName = "supplier_name"
    }

    public init(marketId: String?, bloodComponent: String?, bloodGroup: String?, packaging: String?, packagingSize: Float?, packagingUnits: String?, supplierId: String?, supplierName: String?) {
        self.marketId = marketId
        self.bloodComponent = bloodComponent
        self.bloodGroup = bloodGroup
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
        try container.encodeIfPresent(marketId, forKey: .marketId)
        try container.encodeIfPresent(bloodComponent, forKey: .bloodComponent)
        try container.encodeIfPresent(bloodGroup, forKey: .bloodGroup)
        try container.encodeIfPresent(packaging, forKey: .packaging)
        try container.encodeIfPresent(packagingSize, forKey: .packagingSize)
        try container.encodeIfPresent(packagingUnits, forKey: .packagingUnits)
        try container.encodeIfPresent(supplierId, forKey: .supplierId)
        try container.encodeIfPresent(supplierName, forKey: .supplierName)
    }

    // Custom decoding
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        marketId = try container.decodeIfPresent(String.self, forKey: .marketId)
        bloodComponent = try container.decodeIfPresent(String.self, forKey: .bloodComponent)
        bloodGroup = try container.decodeIfPresent(String.self, forKey: .bloodGroup)
        packaging = try container.decodeIfPresent(String.self, forKey: .packaging)
        packagingSize = try container.decodeIfPresent(Float.self, forKey: .packagingSize)
        packagingUnits = try container.decodeIfPresent(String.self, forKey: .packagingUnits)
        supplierId = try container.decodeIfPresent(String.self, forKey: .supplierId)
        supplierName = try container.decodeIfPresent(String.self, forKey: .supplierName)
    }
}
