//
//  ViewItemObject.swift
//
//
//  Created by khushbu on 30/10/23.
//

import Foundation
import CasualFoundryCore


class CfEComCatalog {
    static func callCatalogAPI(itemId: String, itemType: String, catalogModel: Any) {
        let catalogName = "item catalog"
        
        switch itemType {
        case ItemType.drug.rawValue:
            if let drugCatalogModel = catalogModel as? DrugCatalogModel {
                updateDrugCatalog(drugId: itemId, drugCatalogModel: drugCatalogModel)
            }
        case ItemType.blood.rawValue:
            if let bloodCatalogModel = catalogModel as? BloodCatalogModel {
                updateBloodCatalog(itemId: itemId, bloodCatalogModel: bloodCatalogModel)
            }
        case ItemType.oxygen.rawValue:
            if let oxygenCatalogModel = catalogModel as? OxygenCatalogModel {
                updateOxygenCatalog(itemId: itemId, oxygenCatalogModel: oxygenCatalogModel)
            }
        case ItemType.medicalEquipment.rawValue:
            if let medicalEquipmentCatalogModel = catalogModel as? MedicalEquipmentCatalogModel {
                updateMedicalEquipmentCatalog(itemId: itemId, medicalEquipmentCatalogModel: medicalEquipmentCatalogModel)
            }
        case ItemType.grocery.rawValue:
            if let groceryCatalogModel = catalogModel as? GroceryCatalogModel {
                updateGroceryCatalog(itemId: itemId, groceryCatalogModel: groceryCatalogModel)
            }
        case ItemType.facility.rawValue:
            if let facilityCatalogModel = catalogModel as? FacilityCatalogModel {
                updateFacilityCatalog(facilityId: itemId, facilityCatalogModel: facilityCatalogModel)
            }
        default:
            ExceptionManager.throwIllegalStateException(eventType:catalogName, message:"Please use correct catalog properties with provided item type", className:String(describing: CfEComCatalog.self))
        }
        
        // Drug Catalog
        func updateDrugCatalog(drugId: String, drugCatalogModel: String) {
            if let drugCatalogModel = try? JSONDecoder().decode(DrugCatalogModel.self, from: Data(drugCatalogModel.utf8)) {
                updateDrugCatalog(drugId: drugId, drugCatalogModel: drugCatalogModel)
            }
        }
        
        func updateDrugCatalog(drugId: String, drugCatalogModel: DrugCatalogModel) {
            let drugInternalCatalog = ECommerceConstants.verifyCatalogForDrug(drugId: drugId, drugCatalogModel: drugCatalogModel)
            CFSetup().updateCatalogItem(subject: .drug, catalogObject: drugInternalCatalog.toData()!)
        }
        
        // Grocery Catalog
        func updateGroceryCatalog(itemId: String, groceryCatalogModel: String) {
            if let groceryCatalogModel = try? JSONDecoder().decode(GroceryCatalogModel.self, from: Data(groceryCatalogModel.utf8)) {
                updateGroceryCatalog(itemId: itemId, groceryCatalogModel: groceryCatalogModel)
            }
        }
        
        func updateGroceryCatalog(itemId: String, groceryCatalogModel: GroceryCatalogModel) {
            let groceryInternalCatalog = ECommerceConstants.verifyCatalogForGrocery(itemId: itemId, groceryCatalogModel: groceryCatalogModel)
            CFSetup().updateCatalogItem(subject: .grocery, catalogObject: groceryInternalCatalog.toData()!)
        }
        
        // Blood Catalog
        func updateBloodCatalog(itemId: String, bloodCatalogModel: String) {
            if let bloodCatalogModel = try? JSONDecoder().decode(BloodCatalogModel.self, from: Data(bloodCatalogModel.utf8)) {
                updateBloodCatalog(itemId: itemId, bloodCatalogModel: bloodCatalogModel)
            }
        }
        
        func updateBloodCatalog(itemId: String, bloodCatalogModel: BloodCatalogModel) {
            let bloodInternalCatalog = ECommerceConstants.verifyCatalogForBlood(itemId: itemId, bloodCatalogModel: bloodCatalogModel)
            CFSetup().updateCatalogItem(subject: .blood, catalogObject: bloodInternalCatalog.toData()!)
        }
        
        // Oxygen Catalog
        func updateOxygenCatalog(itemId: String, oxygenCatalogModel: String) {
            if let oxygenCatalogModel = try? JSONDecoder().decode(OxygenCatalogModel.self, from: Data(oxygenCatalogModel.utf8)) {
                updateOxygenCatalog(itemId: itemId, oxygenCatalogModel: oxygenCatalogModel)
            }
        }
        
        func updateOxygenCatalog(itemId: String, oxygenCatalogModel: OxygenCatalogModel) {
            let oxygenInternalCatalog = ECommerceConstants.verifyCatalogForOxygen(itemId: itemId, oxygenCatalogModel: oxygenCatalogModel)
            CFSetup().updateCatalogItem(subject: .oxygen, catalogObject: oxygenInternalCatalog.toData()!)
        }
        
        // Medical Equipment Catalog
        func updateMedicalEquipmentCatalog(itemId: String, medicalEquipmentCatalogModel: String) {
            if let medicalEquipmentCatalogModel = try? JSONDecoder().decode(MedicalEquipmentCatalogModel.self, from: Data(medicalEquipmentCatalogModel.utf8)) {
                updateMedicalEquipmentCatalog(itemId: itemId, medicalEquipmentCatalogModel: medicalEquipmentCatalogModel)
            }
        }
        
        func updateMedicalEquipmentCatalog(itemId: String, medicalEquipmentCatalogModel: MedicalEquipmentCatalogModel) {
            let medicalInternalCatalog = ECommerceConstants.verifyCatalogForMedicalEquipment(itemId: itemId, medicalEquipmentCatalogModel: medicalEquipmentCatalogModel)
            CFSetup().updateCatalogItem(subject: .medical_equipment, catalogObject: medicalInternalCatalog.toData()!)
        }
        
        // Facility Catalogd
        func updateFacilityCatalog(facilityId: String, facilityCatalogModel: String) {
            if let facilityCatalogModel = try? JSONDecoder().decode(FacilityCatalogModel.self, from: Data(facilityCatalogModel.utf8)) {
                updateFacilityCatalog(facilityId: facilityId, facilityCatalogModel: facilityCatalogModel)
            }
        }
        
        func updateFacilityCatalog(facilityId: String, facilityCatalogModel: FacilityCatalogModel) {
            let facilityInternalCatalog = ECommerceConstants.verifyCatalogForFacility(facilityId: facilityId, facilityCatalogModel: facilityCatalogModel)
            CFSetup().updateCatalogItem(subject: .facility, catalogObject: facilityInternalCatalog.toData()!)
        }
        
        
        
    }
    
}
