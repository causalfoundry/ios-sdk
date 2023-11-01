//
//  DrugCatalogModel.swift
//
//
//  Created by khushbu on 27/10/23.
//

import Foundation

public struct DrugCatalogModel: Codable {
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
    
    
    
    public init(name: String? = nil, marketId: String? = nil, description: String? = nil, supplierId: String? = nil, supplierName: String? = nil, producer: String? = nil, packaging: String? = nil, activeIngredients: [String]? = nil, drugForm: String? = nil, drugStrength: String? = nil, atcAnatomicalGroup: String? = nil, otcOrEthical: String? = nil) {
        self.name = name
        self.marketId = marketId
        self.description = description
        self.supplierId = supplierId
        self.supplierName = supplierName
        self.producer = producer
        self.packaging = packaging
        self.activeIngredients = activeIngredients
        self.drugForm = drugForm
        self.drugStrength = drugStrength
        self.atcAnatomicalGroup = atcAnatomicalGroup
        self.otcOrEthical = otcOrEthical
    }

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
    public func encode() throws -> Data {
        let encoder = JSONEncoder()
        encoder.keyEncodingStrategy = .convertToSnakeCase
        return try encoder.encode(self)
    }
    
    // Decoding method
    public func decode(from data: Data) throws -> DrugCatalogModel {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return try decoder.decode(DrugCatalogModel.self, from: data)
    }
}
