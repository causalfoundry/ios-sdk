//
//  InternalDrugModel.swift
//
//
//  Created by khushbu on 27/10/23.
//
import Foundation

struct InternalDrugModel: Codable {
    var id: String?
    var name: String?
    var market_id: String?
    var description: String?
    var supplier_id: String?
    var supplier_name: String?
    var producer: String?
    var packaging: String?
    var active_ingredients: [String]?
    var drug_form: String?
    var drug_strength: String?
    var atc_anatomical_group: String?
    var otc_or_ethical: String?
    
    // Define CodingKeys to specify custom key mappings
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case market_id
        case description
        case supplier_id
        case supplier_name
        case producer
        case packaging
        case active_ingredients
        case drug_form
        case drug_strength
        case atc_anatomical_group
        case otc_or_ethical
    }
    
    init(id: String? = nil, name: String? = nil, market_id: String? = nil, description: String? = nil, supplier_id: String? = nil, supplier_name: String? = nil, producer: String? = nil, packaging: String? = nil, active_ingredients: [String]? = nil, drug_form: String? = nil, drug_strength: String? = nil, atc_anatomical_group: String? = nil, otc_or_ethical: String? = nil) {
        self.id = id
        self.name = name
        self.market_id = market_id
        self.description = description
        self.supplier_id = supplier_id
        self.supplier_name = supplier_name
        self.producer = producer
        self.packaging = packaging
        self.active_ingredients = active_ingredients
        self.drug_form = drug_form
        self.drug_strength = drug_strength
        self.atc_anatomical_group = atc_anatomical_group
        self.otc_or_ethical = otc_or_ethical
    }
    
    
    // Encoding method to customize the encoding process
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(id, forKey: .id)
        try container.encodeIfPresent(name, forKey: .name)
        try container.encodeIfPresent(market_id, forKey: .market_id)
        try container.encodeIfPresent(description, forKey: .description)
        try container.encodeIfPresent(supplier_id, forKey: .supplier_id)
        try container.encodeIfPresent(supplier_name, forKey: .supplier_name)
        try container.encodeIfPresent(producer, forKey: .producer)
        try container.encodeIfPresent(packaging, forKey: .packaging)
        try container.encodeIfPresent(active_ingredients, forKey: .active_ingredients)
        try container.encodeIfPresent(drug_form, forKey: .drug_form)
        try container.encodeIfPresent(drug_strength, forKey: .drug_strength)
        try container.encodeIfPresent(atc_anatomical_group, forKey: .atc_anatomical_group)
        try container.encodeIfPresent(otc_or_ethical, forKey: .otc_or_ethical)
    }
    
    // Decoding method to customize the decoding process
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decodeIfPresent(String.self, forKey: .id)
        name = try container.decodeIfPresent(String.self, forKey: .name)
        market_id = try container.decodeIfPresent(String.self, forKey: .market_id)
        description = try container.decodeIfPresent(String.self, forKey: .description)
        supplier_id = try container.decodeIfPresent(String.self, forKey: .supplier_id)
        supplier_name = try container.decodeIfPresent(String.self, forKey: .supplier_name)
        producer = try container.decodeIfPresent(String.self, forKey: .producer)
        packaging = try container.decodeIfPresent(String.self, forKey: .packaging)
        active_ingredients = try container.decodeIfPresent([String].self, forKey: .active_ingredients)
        drug_form = try container.decodeIfPresent(String.self, forKey: .drug_form)
        drug_strength = try container.decodeIfPresent(String.self, forKey: .drug_strength)
        atc_anatomical_group = try container.decodeIfPresent(String.self, forKey: .atc_anatomical_group)
        otc_or_ethical = try container.decodeIfPresent(String.self, forKey: .otc_or_ethical)
    }
}
