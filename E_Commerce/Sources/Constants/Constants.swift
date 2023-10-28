//
//  ECommerceConstants.swift
//
//
//  Created by khushbu on 27/10/23.
//

import Foundation

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
        
        if itemValue.id.isEmpty {
            ExceptionManager.throwIsRequiredException(eventType:eventName, elementName: "item_id")
        } else if itemValue.quantity < 0 {
            ExceptionManager.throwItemQuantityException(eventType: eventName)
        } else if itemValue.price == nil {
            ExceptionManager.throwIsRequiredException(eventType: eventName, elementName: "item_price")
        } else if itemValue.price == -1.0 {
            ExceptionManager.throwIsRequiredException(eventType:eventName, elementName: "item_price")
        } else if itemValue.currency.isEmpty {
            ExceptionManager.throwIsRequiredException(eventType:eventName , elementName: "item_currency")
        } else if !CoreConstants.enumContains(InternalCurrencyCode.self, itemValue.currency) {
            ExceptionManager.throwEnumException(eventType: eventName, className:"CurrencyCode")
        } else if itemValue.type.isEmpty {
            ExceptionManager.throwIsRequiredException(eventType: eventName, elementName: ="item_type")
        } else if !CoreConstants.enumContains(ItemType.self, itemValue.type) {
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
        } else if !CoreConstants.enumContains(ItemType.self, itemValue.item_type) {
            ExceptionManager.throwEnumException(eventType:eventName , className: "ItemType")
        }
    }
    
    static func verifyCatalogForDrug(drugId: String, drugCatalogModel: DrugCatalogModel) -> InternalDrugModel {
        let catalogName = CatalogSubject.drug.rawValue + " catalog"
        
        guard !drugId.isEmpty else {
            ExceptionManager.throwIsRequiredException(eventType: catalogName, elementName: "drug Id")
        }
        
        guard let name = drugCatalogModel.name, !name.isEmpty else {
            ExceptionManager.throwIsRequiredException(eventType: catalogName, elementName: "name")
        }
        
        return InternalDrugModel(
            id: drugId,
            name: CoreConstants.shared.checkIfNull(drugCatalogModel.name),
            market_id: CoreConstants.shared.checkIfNull(drugCatalogModel.market_id),
            description: CoreConstants.shared.checkIfNull(drugCatalogModel.description),
            supplier_id: CoreConstants.shared.checkIfNull(drugCatalogModel.supplier_id),
            supplier_name: CoreConstants.shared.checkIfNull(drugCatalogModel.supplier_name),
            producer: CoreConstants.shared.checkIfNull(drugCatalogModel.producer),
            packaging: CoreConstants.shared.checkIfNull(drugCatalogModel.packaging),
            active_ingredients: drugCatalogModel.active_ingredients ?? [],
            drug_form: CoreConstants.shared.checkIfNull(drugCatalogModel.drug_form),
            drug_strength: CoreConstants.shared.checkIfNull(drugCatalogModel.drug_strength),
            atc_anatomical_group: CoreConstants.shared.checkIfNull(drugCatalogModel.ATC_anatomical_group),
            otc_or_ethical: CoreConstants.shared.checkIfNull(drugCatalogModel.OTC_or_ethical)
        )
    }
    
    static func verifyCatalogForGrocery(itemId: String, groceryCatalogModel: GroceryCatalogModel) -> InternalGroceryCatalogModel {
        let catalogName = CatalogSubject.grocery.rawValue + " catalog"
        
        guard !itemId.isEmpty else {
            ExceptionManager.throwIsRequiredException(catalogName, "grocery item Id")
        }
        
        guard let name = groceryCatalogModel.name, !name.isEmpty else {
            ExceptionManager.throwIsRequiredException(catalogName, "name")
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
    
    static func verifyCatalogForBlood(itemId: String, bloodCatalogModel: BloodCatalogModel) -> InternalBloodCatalogModel {
        let catalogName = CatalogSubject.blood.rawValue + " catalog"
        
        guard !itemId.isEmpty else {
            ExceptionManager.throwIsRequiredException(catalogName, "blood item Id")
        }
        
        guard let bloodGroup = bloodCatalogModel.blood_group, !bloodGroup.isEmpty else {
            ExceptionManager.throwIsRequiredException(catalogName, "blood_group")
        }
        
        return InternalBloodCatalogModel(
            id: itemId,
            market_id: CoreConstants.shared.checkIfNull(bloodCatalogModel.market_id),
            blood_component: CoreConstants.shared.checkIfNull(bloodCatalogModel.blood_component),
            blood_group: CoreConstants.shared.checkIfNull(bloodCatalogModel.blood_group),
            packaging: CoreConstants.shared.checkIfNull(bloodCatalogModel.packaging),
            packaging_size: bloodCatalogModel.packaging_size ?? 0.0,
            packaging_units: CoreConstants.shared.checkIfNull(bloodCatalogModel.packaging_units),
            supplier_id: CoreConstants.shared.checkIfNull(bloodCatalogModel.supplier_id),
            supplier_name: CoreConstants.shared.checkIfNull(bloodCatalogModel.supplier_name)
        )
    }
    
    static func verifyCatalogForOxygen
