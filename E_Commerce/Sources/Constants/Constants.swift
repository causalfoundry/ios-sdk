//
//  ECommerceConstants.swift
//
//
//  Created by khushbu on 27/10/23.
//

import Foundation
import CasualFoundryCore

public class ECommerceConstants {
    // SDK API endpoints
    static let contentBlockName = "e-commerce"
    
    static func getDateTime(milliSeconds: Int64) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ"
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        let date = Date(timeIntervalSince1970: TimeInterval(milliSeconds) / 1000)
        return dateFormatter.string(from: date)
    }
    
    static func isItemValueObjectValid(itemValue: ItemModel, eventType: EComEventType) {
        let eventName = eventType.rawValue
        
        if itemValue.id == "" {
            ExceptionManager.throwIsRequiredException(eventType:eventName, elementName: "item_id")
        } else if itemValue.quantity! < 0 {
            ExceptionManager.throwItemQuantityException(eventType: eventName)
        } else if itemValue.price == nil {
            ExceptionManager.throwIsRequiredException(eventType: eventName, elementName: "item_price")
        } else if itemValue.price == -1.0 {
            ExceptionManager.throwIsRequiredException(eventType:eventName, elementName: "item_price")
        } else if itemValue.currency == "" {
            ExceptionManager.throwIsRequiredException(eventType:eventName , elementName: "item_currency")
        } else if !CoreConstants.shared.enumContains(InternalCurrencyCode.self, name:itemValue.currency!) {
            ExceptionManager.throwEnumException(eventType: eventName, className:"CurrencyCode")
        } else if itemValue.type == "" {
            ExceptionManager.throwIsRequiredException(eventType: eventName, elementName:"item_type")
        } else if !CoreConstants.shared.enumContains(ItemType.self, name:itemValue.type!) {
            ExceptionManager.throwEnumException(eventType: eventName, className: "ItemType")
        } else if eventType == .checkout && itemValue.type == ItemType.blood.rawValue {
            if itemValue.meta == nil {
                ExceptionManager.throwIsRequiredException(eventType:eventName, elementName: "Blood Meta Properties")
            } else if !(itemValue.meta is BloodMetaModel) {
                ExceptionManager.throwEnumException(eventType:eventName , className:"Blood Meta Properties")
            }
        } else if eventType == .checkout && itemValue.type == ItemType.oxygen.rawValue {
            if itemValue.meta == nil {
                ExceptionManager.throwIsRequiredException(eventType:eventName, elementName: "Oxygen Meta Properties")
            } else if !(itemValue.meta is OxygenMetaModel) {
                ExceptionManager.throwEnumException(eventType: eventName, className:"Oxygen Meta Properties")
            }
        }
    }
    
    static func isItemTypeObjectValid(itemValue: ItemTypeModel, eventType: EComEventType) {
        let eventName = eventType.rawValue
        if itemValue.item_id.isEmpty {
            ExceptionManager.throwIsRequiredException(eventType:eventName , elementName: "item_id")
        } else if itemValue.item_type.isEmpty {
            ExceptionManager.throwIsRequiredException(eventType: eventName, elementName: "item_type")
        } else if !CoreConstants.shared.enumContains(ItemType.self, name: itemValue.item_type) {
            ExceptionManager.throwEnumException(eventType: eventName, className: "ItemType")
        }
    }
    
    static func verifyCatalogForDrug(drugId: String, drugCatalogModel: DrugCatalogModel) -> InternalDrugModel? {
        let catalogName = CatalogSubject.drug.rawValue + " catalog"
        
        guard !drugId.isEmpty else {
            ExceptionManager.throwIsRequiredException(eventType: catalogName, elementName: "drug Id")
            return nil
        }
        
        guard let name = drugCatalogModel.name, !name.isEmpty else {
            ExceptionManager.throwIsRequiredException(eventType: catalogName, elementName: "name")
            return nil
        }
        return InternalDrugModel(
            id: drugId,
            name: CoreConstants.shared.checkIfNull(drugCatalogModel.name),
            market_id: CoreConstants.shared.checkIfNull(drugCatalogModel.marketId),
            description: CoreConstants.shared.checkIfNull(drugCatalogModel.description),
            supplier_id: CoreConstants.shared.checkIfNull(drugCatalogModel.supplierId),
            supplier_name: CoreConstants.shared.checkIfNull(drugCatalogModel.supplierName),
            producer: CoreConstants.shared.checkIfNull(drugCatalogModel.producer),
            packaging: CoreConstants.shared.checkIfNull(drugCatalogModel.packaging),
            active_ingredients: drugCatalogModel.activeIngredients ?? [],
            drug_form: CoreConstants.shared.checkIfNull(drugCatalogModel.drugForm),
            drug_strength: CoreConstants.shared.checkIfNull(drugCatalogModel.drugStrength),
            atc_anatomical_group: CoreConstants.shared.checkIfNull(drugCatalogModel.atcAnatomicalGroup),
            otc_or_ethical: CoreConstants.shared.checkIfNull(drugCatalogModel.otcOrEthical)
        )
    }
    
    static func verifyCatalogForGrocery(itemId: String, groceryCatalogModel: GroceryCatalogModel) -> InternalGroceryCatalogModel? {
        let catalogName = CatalogSubject.grocery.rawValue + " catalog"
        
        guard !itemId.isEmpty else {
            ExceptionManager.throwIsRequiredException(eventType: catalogName, elementName: "grocery item Id")
            return nil
        }
        
        guard let name = groceryCatalogModel.name, !name.isEmpty else {
            ExceptionManager.throwIsRequiredException(eventType: catalogName, elementName: "name")
            return nil
        }
        
        return InternalGroceryCatalogModel(
            id: itemId,
            name: CoreConstants.shared.checkIfNull(groceryCatalogModel.name),
            category: CoreConstants.shared.checkIfNull(groceryCatalogModel.category),
            market_id: CoreConstants.shared.checkIfNull(groceryCatalogModel.market_id),
            description: CoreConstants.shared.checkIfNull(groceryCatalogModel.description),
            supplier_id: CoreConstants.shared.checkIfNull(groceryCatalogModel.supplier_id),
            supplier_name: CoreConstants.shared.checkIfNull(groceryCatalogModel.supplier_name),
            producer: CoreConstants.shared.checkIfNull(groceryCatalogModel.producer),
            packaging: CoreConstants.shared.checkIfNull(groceryCatalogModel.packaging),
            packaging_size: groceryCatalogModel.packaging_size ?? 0.0,
            packaging_units: CoreConstants.shared.checkIfNull(groceryCatalogModel.packaging_units),
            active_ingredients: groceryCatalogModel.active_ingredients ?? []
        )
    }
    
    static func verifyCatalogForBlood(itemId: String, bloodCatalogModel: BloodCatalogModel) -> InternalBloodCatalogModel? {
        let catalogName = CatalogSubject.blood.rawValue + " catalog"
        
        guard !itemId.isEmpty else {
            ExceptionManager.throwIsRequiredException(eventType: catalogName, elementName: "blood item Id")
            return nil
        }
        
        guard let bloodGroup = bloodCatalogModel.bloodGroup, !bloodGroup.isEmpty else {
            ExceptionManager.throwIsRequiredException(eventType: catalogName, elementName: "blood_group")
            return nil
        }
        
        return InternalBloodCatalogModel(
            id: itemId,
            market_id: CoreConstants.shared.checkIfNull(bloodCatalogModel.marketId),
            blood_component: CoreConstants.shared.checkIfNull(bloodCatalogModel.bloodComponent),
            blood_group: CoreConstants.shared.checkIfNull(bloodCatalogModel.bloodGroup),
            packaging: CoreConstants.shared.checkIfNull(bloodCatalogModel.packaging),
            packaging_size: bloodCatalogModel.packagingSize ?? 0.0,
            packaging_units: CoreConstants.shared.checkIfNull(bloodCatalogModel.packagingUnits),
            supplier_id: CoreConstants.shared.checkIfNull(bloodCatalogModel.supplierId),
            supplier_name: CoreConstants.shared.checkIfNull(bloodCatalogModel.supplierName)
        )
    }
    
    static func verifyCatalogForOxygen(itemId: String, oxygenCatalogModel: OxygenCatalogModel) -> InternalOxygenCatalogModel {
        let catalogName = CatalogSubject.oxygen.rawValue + " catalog"
        
        guard !itemId.isEmpty else {
            // Replace with appropriate error handling for required item Id
            fatalError("Required item Id is empty")
        }
        
        return InternalOxygenCatalogModel(
            id: itemId,
            market_id: CoreConstants.shared.checkIfNull(oxygenCatalogModel.marketId),
            packaging: CoreConstants.shared.checkIfNull(oxygenCatalogModel.packaging),
            packaging_size: oxygenCatalogModel.packagingSize ?? 0.0,
            packaging_units: CoreConstants.shared.checkIfNull(oxygenCatalogModel.packagingUnits),
            supplier_id: CoreConstants.shared.checkIfNull(oxygenCatalogModel.supplierId),
            supplier_name: CoreConstants.shared.checkIfNull(oxygenCatalogModel.supplierName)
        )
    }

    static func verifyCatalogForMedicalEquipment(itemId: String, medicalEquipmentCatalogModel: MedicalEquipmentCatalogModel) -> InternalMedicalEquipmentCatalogModel {
        let catalogName = CatalogSubject.medical_equipment.rawValue + " catalog"
        
        guard !itemId.isEmpty else {
            // Replace with appropriate error handling for required item Id
            fatalError("Required item Id is empty")
        }
        guard let name = medicalEquipmentCatalogModel.name, !name.isEmpty else {
            // Replace with appropriate error handling for required name
            fatalError("Required name is empty")
        }
        
        return InternalMedicalEquipmentCatalogModel(
            id: itemId,
            name: CoreConstants.shared.checkIfNull(medicalEquipmentCatalogModel.name),
            description: CoreConstants.shared.checkIfNull(medicalEquipmentCatalogModel.description),
            market_id: CoreConstants.shared.checkIfNull(medicalEquipmentCatalogModel.marketId),
            supplier_id: CoreConstants.shared.checkIfNull(medicalEquipmentCatalogModel.supplierId),
            supplier_name: CoreConstants.shared.checkIfNull(medicalEquipmentCatalogModel.supplierName),
            producer: CoreConstants.shared.checkIfNull(medicalEquipmentCatalogModel.producer),
            packaging: CoreConstants.shared.checkIfNull(medicalEquipmentCatalogModel.packaging),
            packaging_size: medicalEquipmentCatalogModel.packagingSize ?? 0.0,
            packaging_units: CoreConstants.shared.checkIfNull(medicalEquipmentCatalogModel.packagingUnits),
            category: CoreConstants.shared.checkIfNull(medicalEquipmentCatalogModel.category)
        )
    }

   static func verifyCatalogForFacility(facilityId: String, facilityCatalogModel: FacilityCatalogModel) -> InternalFacilityCatalogModel {
        let catalogName = CatalogSubject.facility.rawValue + " catalog"
        
        guard !facilityId.isEmpty else {
            // Replace with appropriate error handling for required facility Id
            fatalError("Required facility Id is empty")
        }
        guard let name = facilityCatalogModel.name, !name.isEmpty else {
            // Replace with appropriate error handling for required name
            fatalError("Required name is empty")
        }
        guard let type = facilityCatalogModel.type, !type.isEmpty else {
            // Replace with appropriate error handling for required type
            fatalError("Required type is empty")
        }
        
        return InternalFacilityCatalogModel(
            id: facilityId,
            name: CoreConstants.shared.checkIfNull(facilityCatalogModel.name),
            type: CoreConstants.shared.checkIfNull(facilityCatalogModel.type),
            country: CoreConstants.shared.checkIfNull(facilityCatalogModel.country),
            region_state: CoreConstants.shared.checkIfNull(facilityCatalogModel.region_state),
            city: CoreConstants.shared.checkIfNull(facilityCatalogModel.city),
            is_active: facilityCatalogModel.is_active ?? false,
            has_delivery: facilityCatalogModel.has_delivery ?? false,
            is_sponsored: facilityCatalogModel.is_sponsored ?? false
        )
    }
}
