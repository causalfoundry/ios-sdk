//
//  CfEComCatalog.swift
//
//
//  Created by moizhassankh on 07/12/23.
//

import CausalFoundrySDKCore
import Foundation

class CfEComCatalog {
    static func callCatalogAPI(catalogType: EComCatalogType, catalogModel: Any) {
        var propertiesDecoded = false
        switch catalogType {
        case EComCatalogType.Drug:
            if let drugCatalogModel = catalogModel as? DrugCatalogModel {
                let drugInternalCatalog = ECommerceConstants.verifyCatalogForDrug(drugCatalogModel: drugCatalogModel)
                CFSetup().updateEcommerceCatalogItem(subject: .drug, catalogObject: [drugInternalCatalog].toData())
                propertiesDecoded = true
            }
        case EComCatalogType.Grocery:
            if let groceryCatalogModel = catalogModel as? GroceryCatalogModel {
                let groceryInternalCatalog = ECommerceConstants.verifyCatalogForGrocery(groceryCatalogModel: groceryCatalogModel)
                CFSetup().updateEcommerceCatalogItem(subject: .grocery, catalogObject: [groceryInternalCatalog].toData())
                propertiesDecoded = true
            }
        case EComCatalogType.Blood:
            if let bloodCatalogModel = catalogModel as? BloodCatalogModel {
                let bloodInternalCatalog = ECommerceConstants.verifyCatalogForBlood(bloodCatalogModel: bloodCatalogModel)
                CFSetup().updateEcommerceCatalogItem(subject: .blood, catalogObject: [bloodInternalCatalog].toData())
                propertiesDecoded = true
            }
        case EComCatalogType.Oxygen:
            if let oxygenCatalogModel = catalogModel as? OxygenCatalogModel {
                let oxygenInternalCatalog = ECommerceConstants.verifyCatalogForOxygen(oxygenCatalogModel: oxygenCatalogModel)
                CFSetup().updateEcommerceCatalogItem(subject: .oxygen, catalogObject: [oxygenInternalCatalog].toData())
                propertiesDecoded = true
            }
        case EComCatalogType.MedicalEquipment:
            if let medicalEquipmentCatalogModel = catalogModel as? MedicalEquipmentCatalogModel {
                let medicalInternalCatalog = ECommerceConstants.verifyCatalogForMedicalEquipment(medicalEquipmentCatalogModel: medicalEquipmentCatalogModel)
                CFSetup().updateEcommerceCatalogItem(subject: .medical_equipment, catalogObject: [medicalInternalCatalog].toData())
                propertiesDecoded = true
            }
        case EComCatalogType.Facility:
            if let facilityCatalogModel = catalogModel as? FacilityCatalogModel {
                let facilityInternalCatalog = ECommerceConstants.verifyCatalogForFacility(facilityCatalogModel: facilityCatalogModel)
                CFSetup().updateEcommerceCatalogItem(subject: .facility, catalogObject: [facilityInternalCatalog].toData())
                propertiesDecoded = true
            }
        }
        if !propertiesDecoded {
            ExceptionManager.throwIllegalStateException(eventType: "item catalog", message: "Please use correct catalog properties with provided item type", className: "CfEComCatalog")
        }
    }
}
