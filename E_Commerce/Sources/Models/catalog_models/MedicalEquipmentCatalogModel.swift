//
//  MedicalEquipmentCatalogModel.swift
//
//
//  Created by khushbu on 27/10/23.
//

import Foundation

struct MedicalEquipmentCatalogModel: Codable {
    var name: String?
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
    
    // Encoding method
    func encode() throws -> Data {
        let encoder = JSONEncoder()
        encoder.keyEncodingStrategy = .convertToSnakeCase
        return try encoder.encode(self)
    }
    
    // Decoding method
    static func decode(from data: Data) throws -> MedicalEquipmentCatalogModel {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return try decoder.decode(MedicalEquipmentCatalogModel.self, from: data)
    }
}
