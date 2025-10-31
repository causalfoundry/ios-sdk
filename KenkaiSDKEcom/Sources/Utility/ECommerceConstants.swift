//
//  Constants.swift
//
//
//  Created by moizhassankh on 07/12/23.
//

import KenkaiSDKCore
import Foundation

enum ECommerceConstants {

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
        if itemValue.unitPrice < 0 {
            ExceptionManager.throwIsRequiredException(eventType: eventName, elementName: "item_unit_price")
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
        return true
    }

    
    // MARK: VERIFY CATALOGS
    
    static func verifyCatalogForDrug(subjectId: String, drugCatalogModel: DrugCatalogModel) -> DrugCatalogModel? {
        let catalogName = CatalogSubject.drug.rawValue + " catalog"

        if(subjectId.isEmpty){
            ExceptionManager.throwIsRequiredException(eventType: catalogName, elementName: "drug Id")
            return nil
        } else if(drugCatalogModel.name.isEmpty){
            ExceptionManager.throwIsRequiredException(eventType: catalogName, elementName: "drug name")
            return nil
        }

        return drugCatalogModel
    }

    static func verifyCatalogForGrocery(subjectId: String, groceryCatalogModel: GroceryCatalogModel) -> GroceryCatalogModel? {
        let catalogName = CatalogSubject.grocery.rawValue + " catalog"

        if(subjectId.isEmpty){
            ExceptionManager.throwIsRequiredException(eventType: catalogName, elementName: "grocery item Id")
            return nil
        } else if(groceryCatalogModel.name.isEmpty){
            ExceptionManager.throwIsRequiredException(eventType: catalogName, elementName: "grocery name")
            return nil
        }

        return groceryCatalogModel
    }

    static func verifyCatalogForBlood(subjectId: String, bloodCatalogModel: BloodCatalogModel) -> BloodCatalogModel? {
        let catalogName = CatalogSubject.blood.rawValue + " catalog"

        if(subjectId.isEmpty){
            ExceptionManager.throwIsRequiredException(eventType: catalogName, elementName: "blood item Id")
            return nil
        } else if(bloodCatalogModel.bloodGroup.isEmpty){
            ExceptionManager.throwIsRequiredException(eventType: catalogName, elementName: "blood_group")
            return nil
        }

        return bloodCatalogModel
    }

    static func verifyCatalogForOxygen(subjectId: String, oxygenCatalogModel: OxygenCatalogModel) -> OxygenCatalogModel? {
        let catalogName = CatalogSubject.oxygen.rawValue + " catalog"

        if(subjectId.isEmpty){
            ExceptionManager.throwIsRequiredException(eventType: catalogName, elementName: "oxygen item Id")
            return nil
        }
        return oxygenCatalogModel
    }

    static func verifyCatalogForMedicalEquipment(subjectId: String, medicalEquipmentCatalogModel: MedicalEquipmentCatalogModel) -> MedicalEquipmentCatalogModel? {
        let catalogName = CatalogSubject.medical_equipment.rawValue + " catalog"

        if(subjectId.isEmpty){
            ExceptionManager.throwIsRequiredException(eventType: catalogName, elementName: "medical equipment item Id")
            return nil
        }else if(medicalEquipmentCatalogModel.name.isEmpty){
            ExceptionManager.throwIsRequiredException(eventType: catalogName, elementName: "medical equipment name")
            return nil
        }

        return medicalEquipmentCatalogModel
    }

    static func verifyCatalogForFacility(subjectId: String, facilityCatalogModel: FacilityCatalogModel) -> FacilityCatalogModel? {
        let catalogName = CatalogSubject.facility.rawValue + " catalog"

        if(subjectId.isEmpty){
            ExceptionManager.throwIsRequiredException(eventType: catalogName, elementName: "facility Id")
            return nil
        }else if(facilityCatalogModel.name.isEmpty){
            ExceptionManager.throwIsRequiredException(eventType: catalogName, elementName: "facility name")
            return nil
        }

        return facilityCatalogModel
    }
}
