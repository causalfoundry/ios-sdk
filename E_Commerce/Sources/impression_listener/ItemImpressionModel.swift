//
//  ItemImpressionModel.swift
//
//
//  Created by khushbu on 02/11/23.
//

import Foundation
import CasualFoundryCore

struct ItemImpressionModel: Codable {
    var itemProperties: ItemModel
    var catalogProperties: Any?

    enum CodingKeys: String, CodingKey {
        case itemProperties = "item_properties"
        case catalogProperties = "catalog_properties"
    }

    init(itemProperties: ItemModel, catalogProperties: Any?) {
        self.itemProperties = itemProperties
        self.catalogProperties = catalogProperties
    }

    // Implement the custom initializer for decoding if needed
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        itemProperties = try container.decode(ItemModel.self, forKey: .itemProperties)
        switch itemProperties.type {
        case ItemType.drug.rawValue:
            if let catalog_properties = try? container.decode(DrugCatalogModel.self, forKey: .catalogProperties) {
                self.catalogProperties = catalog_properties
            }
        case ItemType.blood.rawValue:
            if let catalog_properties = try? container.decode(BloodCatalogModel.self, forKey: .catalogProperties) {
                self.catalogProperties = catalog_properties
            }
        case ItemType.oxygen.rawValue:
            if let catalog_properties = try? container.decode(OxygenCatalogModel.self, forKey: .catalogProperties) {
                self.catalogProperties = catalog_properties
            }
        case ItemType.medicalEquipment.rawValue:
            if let catalog_properties = try? container.decode(MedicalEquipmentCatalogModel.self, forKey: .catalogProperties) {
                self.catalogProperties = catalog_properties
            }
        case ItemType.grocery.rawValue:
            if let catalog_properties = try? container.decode(GroceryCatalogModel.self, forKey: .catalogProperties) {
               self.catalogProperties = catalog_properties
           }
        case ItemType.facility.rawValue:
            if let catalog_properties = try? container.decode(FacilityCatalogModel.self, forKey: .catalogProperties) {
               self.catalogProperties = catalog_properties
           }
        default:
            ExceptionManager.throwIllegalStateException(eventType: "item catalog", message: "Please use correct catalog properties with provided item type", className: "ItemImpressionListener")
        }
    }

    // Implement the encoding method if needed
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(itemProperties, forKey: .itemProperties)

        switch itemProperties.type {
        case ItemType.drug.rawValue:
            try container.encode(catalogProperties as? DrugCatalogModel, forKey: .catalogProperties)
        case ItemType.blood.rawValue:
            try container.encode(catalogProperties as? BloodCatalogModel, forKey: .catalogProperties)
        case ItemType.oxygen.rawValue:
            try container.encode(catalogProperties as? OxygenCatalogModel, forKey: .catalogProperties)
        case ItemType.medicalEquipment.rawValue:
            try container.encode(catalogProperties as? MedicalEquipmentCatalogModel, forKey: .catalogProperties)
        case ItemType.grocery.rawValue:
            try container.encode(catalogProperties as? GroceryCatalogModel, forKey: .catalogProperties)
        case ItemType.facility.rawValue:
            try container.encode(catalogProperties as? FacilityCatalogModel, forKey: .catalogProperties)
        default:
            ExceptionManager.throwIllegalStateException(eventType: "item catalog", message: "Please use correct catalog properties with provided item type", className: "ItemImpressionListener")
        }
    }
}
