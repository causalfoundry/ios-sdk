//
//  ItemImpressionModel.swift
//
//
//  Created by khushbu on 02/11/23.
//

import Foundation

struct ItemImpressionModel: Codable {
    var item_properties: ItemModel
    var catalog_properties: Any?

    enum CodingKeys: String, CodingKey {
        case item_properties
        case catalog_properties
    }

    init(item_properties: ItemModel, catalog_properties: Any?) {
        self.item_properties = item_properties
        self.catalog_properties = catalog_properties
    }

    // Implement the custom initializer for decoding if needed
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        item_properties = try container.decode(ItemModel.self, forKey: .item_properties)

        if let catalog_properties = try? container.decode(DrugCatalogModel.self, forKey: .catalog_properties) {
            self.catalog_properties = catalog_properties
        } else if let catalog_properties = try? container.decode(GroceryCatalogModel.self, forKey: .catalog_properties) {
            self.catalog_properties = catalog_properties
        } else if let catalog_properties = try? container.decode(FacilityCatalogModel.self, forKey: .catalog_properties) {
            self.catalog_properties = catalog_properties
        } else if let catalog_properties = try? container.decode(BloodCatalogModel.self, forKey: .catalog_properties) {
            self.catalog_properties = catalog_properties
        } else if let catalog_properties = try? container.decode(OxygenCatalogModel.self, forKey: .catalog_properties) {
            self.catalog_properties = catalog_properties
        } else if let catalog_properties = try? container.decode(MedicalEquipmentCatalogModel.self, forKey: .catalog_properties) {
            self.catalog_properties = catalog_properties
        }
        // Add more cases for other catalog models if needed
    }

    // Implement the encoding method if needed
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(item_properties, forKey: .item_properties)

        // Encode catalog_properties based on its actual type
        if let catalog_properties = catalog_properties as? DrugCatalogModel {
            try container.encode(catalog_properties, forKey: .catalog_properties)
        } else if let catalog_properties = catalog_properties as? GroceryCatalogModel {
            try container.encode(catalog_properties, forKey: .catalog_properties)
        } else if let catalog_properties = catalog_properties as? FacilityCatalogModel {
            try container.encode(catalog_properties, forKey: .catalog_properties)
        } else if let catalog_properties = catalog_properties as? BloodCatalogModel {
            try container.encode(catalog_properties, forKey: .catalog_properties)
        } else if let catalog_properties = catalog_properties as? OxygenCatalogModel {
            try container.encode(catalog_properties, forKey: .catalog_properties)
        } else if let catalog_properties = catalog_properties as? MedicalEquipmentCatalogModel {
            try container.encode(catalog_properties, forKey: .catalog_properties)
        }
    }
}
