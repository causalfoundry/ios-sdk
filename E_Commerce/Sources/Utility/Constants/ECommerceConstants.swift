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
        if itemValue.id == "" {
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
        if itemValue.currency == "" {
            ExceptionManager.throwIsRequiredException(eventType:eventName , elementName: "item_currency")
            return false
        }
        if !CoreConstants.shared.enumContains(InternalCurrencyCode.self, name:itemValue.currency) {
            ExceptionManager.throwEnumException(eventType: eventName, className:"CurrencyCode")
            return false
        }
        if itemValue.type == "" {
            ExceptionManager.throwIsRequiredException(eventType: eventName, elementName:"item_type")
            return false
        }
        if !CoreConstants.shared.enumContains(ItemType.self, name:itemValue.type) {
            ExceptionManager.throwEnumException(eventType: eventName, className: "ItemType")
            return false
        }
        if eventType == .checkout, itemValue.type == ItemType.blood.rawValue {
            if itemValue.meta == nil {
                ExceptionManager.throwIsRequiredException(eventType: eventName, elementName: "Blood Meta Properties")
                return false
            } else if !(itemValue.meta is BloodMetaModel) {
                ExceptionManager.throwEnumException(eventType: eventName, className: "Blood Meta Properties")
                return false
            }
        } 
        if eventType == .checkout, itemValue.type == ItemType.oxygen.rawValue {
            if itemValue.meta == nil {
                ExceptionManager.throwIsRequiredException(eventType: eventName, elementName: "Oxygen Meta Properties")
                return false
            } else if !(itemValue.meta is OxygenMetaModel) {
                ExceptionManager.throwEnumException(eventType: eventName, className: "Oxygen Meta Properties")
                return false
            }
        }
        return true
    }

    static func isItemTypeObjectValid(itemValue: ItemTypeModel, eventType: EComEventType) -> Bool {
        let eventName = eventType.rawValue
        if itemValue.item_id.isEmpty {
            ExceptionManager.throwIsRequiredException(eventType: eventName, elementName: "item_id")
            return false
        } else if itemValue.item_type.isEmpty {
            ExceptionManager.throwIsRequiredException(eventType: eventName, elementName: "item_type")
            return false
        } else if !CoreConstants.shared.enumContains(ItemType.self, name: itemValue.item_type) {
            ExceptionManager.throwEnumException(eventType: eventName, className: "ItemType")
            return false
        }
        return true
    }

    
    // MARK: VERIFY CATALOGS
    
    static func verifyCatalogForDrug(drugId: String, drugCatalogModel: DrugCatalogModel) -> InternalDrugModel? {
        let catalogName = CatalogSubject.drug.rawValue + " catalog"

        if(drugId.isEmpty){
            ExceptionManager.throwIsRequiredException(eventType: catalogName, elementName: "drug Id")
            return nil
        } else if(drugCatalogModel.name.isEmpty){
            ExceptionManager.throwIsRequiredException(eventType: catalogName, elementName: "drug name")
            return nil
        }
        
        return InternalDrugModel(
            id: drugId,
            name: CoreConstants.shared.checkIfNull(drugCatalogModel.name),
            marketId: CoreConstants.shared.checkIfNull(drugCatalogModel.marketId),
            description: CoreConstants.shared.checkIfNull(drugCatalogModel.description),
            supplierId: CoreConstants.shared.checkIfNull(drugCatalogModel.supplierId),
            supplierName: CoreConstants.shared.checkIfNull(drugCatalogModel.supplierName),
            producer: CoreConstants.shared.checkIfNull(drugCatalogModel.producer),
            packaging: CoreConstants.shared.checkIfNull(drugCatalogModel.packaging),
            activeIngredients: drugCatalogModel.activeIngredients ?? [],
            drugForm: CoreConstants.shared.checkIfNull(drugCatalogModel.drugForm),
            drugStrength: CoreConstants.shared.checkIfNull(drugCatalogModel.drugStrength),
            atcAnatomicalGroup: CoreConstants.shared.checkIfNull(drugCatalogModel.atcAnatomicalGroup),
            otcOrEthical: CoreConstants.shared.checkIfNull(drugCatalogModel.otcOrEthical)
        )
    }

    static func verifyCatalogForGrocery(itemId: String, groceryCatalogModel: GroceryCatalogModel) -> InternalGroceryCatalogModel? {
        let catalogName = CatalogSubject.grocery.rawValue + " catalog"

        if(itemId.isEmpty){
            ExceptionManager.throwIsRequiredException(eventType: catalogName, elementName: "grocery item Id")
            return nil
        } else if(groceryCatalogModel.name.isEmpty){
            ExceptionManager.throwIsRequiredException(eventType: catalogName, elementName: "grocery name")
            return nil
        }

        return InternalGroceryCatalogModel(
            id: itemId,
            name: CoreConstants.shared.checkIfNull(groceryCatalogModel.name),
            category: CoreConstants.shared.checkIfNull(groceryCatalogModel.category),
            marketId: CoreConstants.shared.checkIfNull(groceryCatalogModel.marketId),
            description: CoreConstants.shared.checkIfNull(groceryCatalogModel.description),
            supplierId: CoreConstants.shared.checkIfNull(groceryCatalogModel.supplierId),
            supplierName: CoreConstants.shared.checkIfNull(groceryCatalogModel.supplierName),
            producer: CoreConstants.shared.checkIfNull(groceryCatalogModel.producer),
            packaging: CoreConstants.shared.checkIfNull(groceryCatalogModel.packaging),
            packagingSize: groceryCatalogModel.packagingSize ?? 0,
            packagingUnits: CoreConstants.shared.checkIfNull(groceryCatalogModel.packagingUnits),
            activeIngredients: groceryCatalogModel.activeIngredients ?? []
        )
    }

    static func verifyCatalogForBlood(itemId: String, bloodCatalogModel: BloodCatalogModel) -> InternalBloodCatalogModel? {
        let catalogName = CatalogSubject.blood.rawValue + " catalog"

        if(itemId.isEmpty){
            ExceptionManager.throwIsRequiredException(eventType: catalogName, elementName: "blood item Id")
            return nil
        } else if(bloodCatalogModel.bloodGroup.isEmpty){
            ExceptionManager.throwIsRequiredException(eventType: catalogName, elementName: "blood_group")
            return nil
        }

        return InternalBloodCatalogModel(
            id: itemId,
            bloodGroup: bloodCatalogModel.bloodGroup,
            marketId: CoreConstants.shared.checkIfNull(bloodCatalogModel.marketId),
            bloodComponent: CoreConstants.shared.checkIfNull(bloodCatalogModel.bloodComponent),
            packaging: CoreConstants.shared.checkIfNull(bloodCatalogModel.packaging),
            packagingSize: bloodCatalogModel.packagingSize ?? 0,
            packagingUnits: CoreConstants.shared.checkIfNull(bloodCatalogModel.packagingUnits),
            supplierId: CoreConstants.shared.checkIfNull(bloodCatalogModel.supplierId),
            supplierName: CoreConstants.shared.checkIfNull(bloodCatalogModel.supplierName)
        )
    }

    static func verifyCatalogForOxygen(itemId: String, oxygenCatalogModel: OxygenCatalogModel) -> InternalOxygenCatalogModel? {
        let catalogName = CatalogSubject.oxygen.rawValue + " catalog"

        if(itemId.isEmpty){
            ExceptionManager.throwIsRequiredException(eventType: catalogName, elementName: "oxygen item Id")
            return nil
        }
        return InternalOxygenCatalogModel(
            id: itemId,
            marketId: CoreConstants.shared.checkIfNull(oxygenCatalogModel.marketId),
            packaging: CoreConstants.shared.checkIfNull(oxygenCatalogModel.packaging),
            packagingSize: oxygenCatalogModel.packagingSize ?? 0,
            packagingUnits: CoreConstants.shared.checkIfNull(oxygenCatalogModel.packagingUnits),
            supplierId: CoreConstants.shared.checkIfNull(oxygenCatalogModel.supplierId),
            supplierName: CoreConstants.shared.checkIfNull(oxygenCatalogModel.supplierName)
        )
    }

    static func verifyCatalogForMedicalEquipment(itemId: String, medicalEquipmentCatalogModel: MedicalEquipmentCatalogModel) -> InternalMedicalEquipmentCatalogModel? {
        let catalogName = CatalogSubject.medical_equipment.rawValue + " catalog"

        if(itemId.isEmpty){
            ExceptionManager.throwIsRequiredException(eventType: catalogName, elementName: "medical equipment item Id")
            return nil
        }else if(medicalEquipmentCatalogModel.name.isEmpty){
            ExceptionManager.throwIsRequiredException(eventType: catalogName, elementName: "medical equipment name")
            return nil
        }

        return InternalMedicalEquipmentCatalogModel(
            id: itemId,
            name: CoreConstants.shared.checkIfNull(medicalEquipmentCatalogModel.name),
            description: CoreConstants.shared.checkIfNull(medicalEquipmentCatalogModel.description),
            marketId: CoreConstants.shared.checkIfNull(medicalEquipmentCatalogModel.marketId),
            supplierId: CoreConstants.shared.checkIfNull(medicalEquipmentCatalogModel.supplierId),
            supplierName: CoreConstants.shared.checkIfNull(medicalEquipmentCatalogModel.supplierName),
            producer: CoreConstants.shared.checkIfNull(medicalEquipmentCatalogModel.producer),
            packaging: CoreConstants.shared.checkIfNull(medicalEquipmentCatalogModel.packaging),
            packagingSize: medicalEquipmentCatalogModel.packagingSize ?? 0,
            packagingUnits: CoreConstants.shared.checkIfNull(medicalEquipmentCatalogModel.packagingUnits),
            category: CoreConstants.shared.checkIfNull(medicalEquipmentCatalogModel.category)
        )
    }

    static func verifyCatalogForFacility(facilityId: String, facilityCatalogModel: FacilityCatalogModel) -> InternalFacilityCatalogModel? {
        let catalogName = CatalogSubject.facility.rawValue + " catalog"

        if(facilityId.isEmpty){
            ExceptionManager.throwIsRequiredException(eventType: catalogName, elementName: "facility Id")
            return nil
        }else if(facilityCatalogModel.name.isEmpty){
            ExceptionManager.throwIsRequiredException(eventType: catalogName, elementName: "facility name")
            return nil
        }

        return InternalFacilityCatalogModel(
            id: facilityId,
            name: CoreConstants.shared.checkIfNull(facilityCatalogModel.name),
            type: CoreConstants.shared.checkIfNull(facilityCatalogModel.type),
            country: CoreConstants.shared.checkIfNull(facilityCatalogModel.country),
            regionState: CoreConstants.shared.checkIfNull(facilityCatalogModel.regionState),
            city: CoreConstants.shared.checkIfNull(facilityCatalogModel.city),
            isActive: facilityCatalogModel.isActive ?? false,
            hasDelivery: facilityCatalogModel.hasDelivery ?? false,
            isSponsored: facilityCatalogModel.isSponsored ?? false
        )
    }
}
