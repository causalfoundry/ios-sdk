//
//  ItemImpressionModel.swift
//
//
//  Created by khushbu on 02/11/23.
//

import Foundation
import CausalFoundrySDKCore

public struct ItemImpressionModel: Codable {
    var itemProperties: ItemModel
    var catalogProperties: Any? = nil

    enum CodingKeys: String, CodingKey {
        case itemProperties = "item_properties"
        case catalogProperties = "catalog_properties"
    }

    public init(itemProperties: ItemModel, catalogProperties: Any? = nil) {
        self.itemProperties = itemProperties
        self.catalogProperties = catalogProperties
    }

    // Implement the custom initializer for decoding if needed
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        itemProperties = try container.decode(ItemModel.self, forKey: .itemProperties)
        var propertiesDecoded = false
        switch itemProperties.type {
        case ItemType.Drug.rawValue:
            if let catalog_properties = try? container.decodeIfPresent(DrugCatalogModel.self, forKey: .catalogProperties) {
                self.catalogProperties = catalog_properties
                propertiesDecoded = true
            }
        case ItemType.Blood.rawValue:
            if let catalog_properties = try? container.decodeIfPresent(BloodCatalogModel.self, forKey: .catalogProperties) {
                self.catalogProperties = catalog_properties
                propertiesDecoded = true
            }
        case ItemType.Oxygen.rawValue:
            if let catalog_properties = try? container.decodeIfPresent(OxygenCatalogModel.self, forKey: .catalogProperties) {
                self.catalogProperties = catalog_properties
                propertiesDecoded = true
            }
        case ItemType.MedicalEquipment.rawValue:
            if let catalog_properties = try? container.decodeIfPresent(MedicalEquipmentCatalogModel.self, forKey: .catalogProperties) {
                self.catalogProperties = catalog_properties
                propertiesDecoded = true
            }
        case ItemType.Grocery.rawValue:
            if let catalog_properties = try? container.decodeIfPresent(GroceryCatalogModel.self, forKey: .catalogProperties) {
               self.catalogProperties = catalog_properties
                propertiesDecoded = true
           }
        case ItemType.Facility.rawValue:
            if let catalog_properties = try? container.decodeIfPresent(FacilityCatalogModel.self, forKey: .catalogProperties) {
               self.catalogProperties = catalog_properties
                propertiesDecoded = true
           }
        default:
            break
        }
        if !propertiesDecoded {
            ExceptionManager.throwIllegalStateException(eventType: "item catalog", message: "Please use correct catalog properties with provided item type", className: "ItemImpressionListener")
        }
    }

    // Implement the encoding method if needed
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(itemProperties, forKey: .itemProperties)

        switch itemProperties.type {
        case ItemType.Drug.rawValue:
            try container.encodeIfPresent(catalogProperties as? DrugCatalogModel, forKey: .catalogProperties)
        case ItemType.Blood.rawValue:
            try container.encodeIfPresent(catalogProperties as? BloodCatalogModel, forKey: .catalogProperties)
        case ItemType.Oxygen.rawValue:
            try container.encodeIfPresent(catalogProperties as? OxygenCatalogModel, forKey: .catalogProperties)
        case ItemType.MedicalEquipment.rawValue:
            try container.encodeIfPresent(catalogProperties as? MedicalEquipmentCatalogModel, forKey: .catalogProperties)
        case ItemType.Grocery.rawValue:
            try container.encodeIfPresent(catalogProperties as? GroceryCatalogModel, forKey: .catalogProperties)
        case ItemType.Facility.rawValue:
            try container.encodeIfPresent(catalogProperties as? FacilityCatalogModel, forKey: .catalogProperties)
        default:
            ExceptionManager.throwIllegalStateException(eventType: "item catalog", message: "Please use correct catalog properties with provided item type", className: "ItemImpressionListener")
        }
    }
}
