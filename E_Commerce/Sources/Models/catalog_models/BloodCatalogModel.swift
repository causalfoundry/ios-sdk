//
//  File.swift
//  
//
//  Created by khushbu on 27/10/23.
//

import Foundation

struct BloodCatalogModel: Codable {
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
    
    // Encoding method
    func encode() throws -> Data {
        let encoder = JSONEncoder()
        encoder.keyEncodingStrategy = .convertToSnakeCase
        return try encoder.encode(self)
    }
    
    // Decoding method
    static func decode(from data: Data) throws -> BloodCatalogModel {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return try decoder.decode(BloodCatalogModel.self, from: data)
    }
}

