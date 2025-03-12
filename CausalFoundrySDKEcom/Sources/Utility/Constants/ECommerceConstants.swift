//
//  Constants.swift
//
//
//  Created by moizhassankh on 07/12/23.
//

import CausalFoundrySDKCore
import Foundation

public enum ECommerceConstants {
    // SDK API endpoints
    static let contentBlockName = "e-commerce"

    static func getDateTime(milliSeconds: Int64) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ"
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        let date = Date(timeIntervalSince1970: TimeInterval(milliSeconds) / 1000)
        return dateFormatter.string(from: date)
    }

    static func isItemValueObjectValid(itemValue: ItemModel, eventType: EComEventType) -> Bool {
        let eventName = eventType.rawValue
        if itemValue.id.isEmpty {
            ExceptionManager.throwIsRequiredException(eventType:eventName, elementName: "item_id")
            return false
        }
        if itemValue.quantity < 0 {
            ExceptionManager.throwItemQuantityException(eventType: eventName)
            return false
        }
        if itemValue.price < 0 {
            ExceptionManager.throwIsRequiredException(eventType: eventName, elementName: "item_price")
            return false
        }
        if !CoreConstants.shared.enumContains(CurrencyCode.self, name:itemValue.currency) {
            ExceptionManager.throwEnumException(eventType: eventName, className:"CurrencyCode")
            return false
        }
        if !CoreConstants.shared.enumContains(ItemType.self, name:itemValue.type) {
            ExceptionManager.throwEnumException(eventType: eventName, className: "ItemType")
            return false
        }
//        if eventType == .checkout, itemValue.type == ItemType.blood.rawValue {
//            if itemValue.meta == nil {
//                ExceptionManager.throwIsRequiredException(eventType: eventName, elementName: "Blood Meta Properties")
//                return false
//            } else if !(itemValue.meta is BloodMetaModel) {
//                ExceptionManager.throwEnumException(eventType: eventName, className: "Blood Meta Properties")
//                return false
//            }
//        } 
//        if eventType == .checkout, itemValue.type == ItemType.oxygen.rawValue {
//            if itemValue.meta == nil {
//                ExceptionManager.throwIsRequiredException(eventType: eventName, elementName: "Oxygen Meta Properties")
//                return false
//            } else if !(itemValue.meta is OxygenMetaModel) {
//                ExceptionManager.throwEnumException(eventType: eventName, className: "Oxygen Meta Properties")
//                return false
//            }
//        }
        return true
    }

    static func isItemTypeObjectValid(itemValue: ItemTypeModel, eventType: EComEventType) -> Bool {
        let eventName = eventType.rawValue
        if itemValue.itemId.isEmpty {
            ExceptionManager.throwIsRequiredException(eventType: eventName, elementName: "item_id")
            return false
        } else if !CoreConstants.shared.enumContains(ItemType.self, name: itemValue.type) {
            ExceptionManager.throwEnumException(eventType: eventName, className: "ItemType")
            return false
        }
        return true
    }

    
    // MARK: VERIFY CATALOGS
    
    static func verifyCatalogForDrug(drugCatalogModel: DrugCatalogModel) -> DrugCatalogModel? {
        let catalogName = CatalogSubject.drug.rawValue + " catalog"

        if(drugCatalogModel.drugId.isEmpty){
            ExceptionManager.throwIsRequiredException(eventType: catalogName, elementName: "drug Id")
            return nil
        } else if(drugCatalogModel.name.isEmpty){
            ExceptionManager.throwIsRequiredException(eventType: catalogName, elementName: "drug name")
            return nil
        }

        return drugCatalogModel
    }

    static func verifyCatalogForGrocery(groceryCatalogModel: GroceryCatalogModel) -> GroceryCatalogModel? {
        let catalogName = CatalogSubject.grocery.rawValue + " catalog"

        if(groceryCatalogModel.groceryId.isEmpty){
            ExceptionManager.throwIsRequiredException(eventType: catalogName, elementName: "grocery item Id")
            return nil
        } else if(groceryCatalogModel.name.isEmpty){
            ExceptionManager.throwIsRequiredException(eventType: catalogName, elementName: "grocery name")
            return nil
        }

        return groceryCatalogModel
    }

    static func verifyCatalogForBlood(bloodCatalogModel: BloodCatalogModel) -> BloodCatalogModel? {
        let catalogName = CatalogSubject.blood.rawValue + " catalog"

        if(bloodCatalogModel.itemId.isEmpty){
            ExceptionManager.throwIsRequiredException(eventType: catalogName, elementName: "blood item Id")
            return nil
        } else if(bloodCatalogModel.bloodGroup.isEmpty){
            ExceptionManager.throwIsRequiredException(eventType: catalogName, elementName: "blood_group")
            return nil
        }

        return bloodCatalogModel
    }

    static func verifyCatalogForOxygen(oxygenCatalogModel: OxygenCatalogModel) -> OxygenCatalogModel? {
        let catalogName = CatalogSubject.oxygen.rawValue + " catalog"

        if(oxygenCatalogModel.itemId.isEmpty){
            ExceptionManager.throwIsRequiredException(eventType: catalogName, elementName: "oxygen item Id")
            return nil
        }
        return oxygenCatalogModel
    }

    static func verifyCatalogForMedicalEquipment(medicalEquipmentCatalogModel: MedicalEquipmentCatalogModel) -> MedicalEquipmentCatalogModel? {
        let catalogName = CatalogSubject.medical_equipment.rawValue + " catalog"

        if(medicalEquipmentCatalogModel.itemId.isEmpty){
            ExceptionManager.throwIsRequiredException(eventType: catalogName, elementName: "medical equipment item Id")
            return nil
        }else if(medicalEquipmentCatalogModel.name.isEmpty){
            ExceptionManager.throwIsRequiredException(eventType: catalogName, elementName: "medical equipment name")
            return nil
        }

        return medicalEquipmentCatalogModel
    }

    static func verifyCatalogForFacility(facilityCatalogModel: FacilityCatalogModel) -> FacilityCatalogModel? {
        let catalogName = CatalogSubject.facility.rawValue + " catalog"

        if(facilityCatalogModel.facilityId.isEmpty){
            ExceptionManager.throwIsRequiredException(eventType: catalogName, elementName: "facility Id")
            return nil
        }else if(facilityCatalogModel.name.isEmpty){
            ExceptionManager.throwIsRequiredException(eventType: catalogName, elementName: "facility name")
            return nil
        }

        return facilityCatalogModel
    }
}
