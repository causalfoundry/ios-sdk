//
//  DrugCatalogModel.swift
//
//
//  Created by khushbu on 27/10/23.
//

import Foundation

struct DrugCatalogModel: Codable {
    var name: String?
    var marketId: String?
    var description: String?
    var supplierId: String?
    var supplierName: String?
    var producer: String?
    var packaging: String?
    var activeIngredients: [String]?
    var drugForm: String?
    var drugStrength: String?
    var atcAnatomicalGroup: String?
    var otcOrEthical: String?

    enum CodingKeys: String, CodingKey {
        case name
        case marketId = "market_id"
        case description
        case supplierId = "supplier_id"
        case supplierName = "supplier_name"
        case producer
        case packaging
        case activeIngredients = "active_ingredients"
        case drugForm = "drug_form"
        case drugStrength = "drug_strength"
        case atcAnatomicalGroup = "ATC_anatomical_group"
        case otcOrEthical = "OTC_or_ethical"
    }
    
    // Encoding method
    func encode() throws -> Data {
        let encoder = JSONEncoder()
        encoder.keyEncodingStrategy = .convertToSnakeCase
        return try encoder.encode(self)
    }
    
    // Decoding method
    static func decode(from data: Data) throws -> DrugCatalogModel {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return try decoder.decode(DrugCatalogModel.self, from: data)
    }
}
