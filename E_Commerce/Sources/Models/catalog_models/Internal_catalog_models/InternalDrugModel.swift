//
//  InternalDrugModel.swift
//
//
//  Created by moizhassankh on 07/12/23.
//
import Foundation

struct InternalDrugModel: Codable {
    var id: String
    var name: String
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
        case id
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
    
    public init(id: String, name: String, marketId: String? = "", description: String? = "", supplierId: String? = "", supplierName: String? = "", producer: String? = "", packaging: String? = "", activeIngredients: [String]? = [], drugForm: String? = "", drugStrength: String? = "", atcAnatomicalGroup: String? = "", otcOrEthical: String? = "") {
        self.id = id
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

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encodeIfPresent(marketId, forKey: .marketId)
        try container.encodeIfPresent(description, forKey: .description)
        try container.encodeIfPresent(supplierId, forKey: .supplierId)
        try container.encodeIfPresent(supplierName, forKey: .supplierName)
        try container.encodeIfPresent(producer, forKey: .producer)
        try container.encodeIfPresent(packaging, forKey: .packaging)
        try container.encodeIfPresent(activeIngredients, forKey: .activeIngredients)
        try container.encodeIfPresent(drugForm, forKey: .drugForm)
        try container.encodeIfPresent(drugStrength, forKey: .drugStrength)
        try container.encodeIfPresent(atcAnatomicalGroup, forKey: .atcAnatomicalGroup)
        try container.encodeIfPresent(otcOrEthical, forKey: .otcOrEthical)
    }

    // Custom decoding
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(String.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        marketId = try container.decodeIfPresent(String.self, forKey: .marketId)
        description = try container.decodeIfPresent(String.self, forKey: .description)
        supplierId = try container.decodeIfPresent(String.self, forKey: .supplierId)
        supplierName = try container.decodeIfPresent(String.self, forKey: .supplierName)
        producer = try container.decodeIfPresent(String.self, forKey: .producer)
        packaging = try container.decodeIfPresent(String.self, forKey: .packaging)
        activeIngredients = try container.decodeIfPresent([String].self, forKey: .activeIngredients)
        drugForm = try container.decodeIfPresent(String.self, forKey: .drugForm)
        drugStrength = try container.decodeIfPresent(String.self, forKey: .drugStrength)
        atcAnatomicalGroup = try container.decodeIfPresent(String.self, forKey: .atcAnatomicalGroup)
        otcOrEthical = try container.decodeIfPresent(String.self, forKey: .otcOrEthical)
    }
}
