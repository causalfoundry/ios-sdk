//
//  CfEComCatalog.swift
//
//
//  Created by khushbu on 30/10/23.
//

import CasualFoundryCore
import Foundation

public class CfEComCatalog {
    public static func callCatalogAPI(itemId: String, itemType: String, catalogModel: Any) {
        let catalogName = "item catalog"

        switch itemType {
        case ItemType.drug.rawValue:
            if let drugCatalogModel = catalogModel as? DrugCatalogModel {
                CfEComCatalog.updateDrugCatalog(drugId: itemId, drugCatalogModel: drugCatalogModel)
            }
        case ItemType.blood.rawValue:
            if let bloodCatalogModel = catalogModel as? BloodCatalogModel {
                CfEComCatalog.updateBloodCatalog(itemId: itemId, bloodCatalogModel: bloodCatalogModel)
            }
        case ItemType.oxygen.rawValue:
            if let oxygenCatalogModel = catalogModel as? OxygenCatalogModel {
                CfEComCatalog.updateOxygenCatalog(itemId: itemId, oxygenCatalogModel: oxygenCatalogModel)
            }
        case ItemType.medicalEquipment.rawValue:
            if let medicalEquipmentCatalogModel = catalogModel as? MedicalEquipmentCatalogModel {
                CfEComCatalog.updateMedicalEquipmentCatalog(itemId: itemId, medicalEquipmentCatalogModel: medicalEquipmentCatalogModel)
            }
        case ItemType.grocery.rawValue:
            if let groceryCatalogModel = catalogModel as? GroceryCatalogModel {
                CfEComCatalog.updateGroceryCatalog(itemId: itemId, groceryCatalogModel: groceryCatalogModel)
            }
        case ItemType.facility.rawValue:
            if let facilityCatalogModel = catalogModel as? FacilityCatalogModel {
                CfEComCatalog.updateFacilityCatalog(facilityId: itemId, facilityCatalogModel: facilityCatalogModel)
            }
        default:
            ExceptionManager.throwIllegalStateException(eventType: catalogName, message: "Please use correct catalog properties with provided item type", className: String(describing: CfEComCatalog.self))
        }
    }

    // Drug Catalog
    public static func updateDrugCatalog(drugId: String, drugCatalogModel: String) {
        if let drugCatalogModel = try? JSONDecoder.new.decode(DrugCatalogModel.self, from: Data(drugCatalogModel.utf8)) {
            updateDrugCatalog(drugId: drugId, drugCatalogModel: drugCatalogModel)
        }
    }

    public static func updateDrugCatalog(drugId: String, drugCatalogModel: DrugCatalogModel) {
        let drugInternalCatalog = ECommerceConstants.verifyCatalogForDrug(drugId: drugId, drugCatalogModel: drugCatalogModel)
        CFSetup().updateEcommerceCatalogItem(subject: .drug, catalogObject: [drugInternalCatalog].toData()!)
    }

    // Grocery Catalog
    public static func updateGroceryCatalog(itemId: String, groceryCatalogModel: String) {
        if let groceryCatalogModel = try? JSONDecoder.new.decode(GroceryCatalogModel.self, from: Data(groceryCatalogModel.utf8)) {
            updateGroceryCatalog(itemId: itemId, groceryCatalogModel: groceryCatalogModel)
        }
    }

    public static func updateGroceryCatalog(itemId: String, groceryCatalogModel: GroceryCatalogModel) {
        let groceryInternalCatalog = ECommerceConstants.verifyCatalogForGrocery(itemId: itemId, groceryCatalogModel: groceryCatalogModel)
        CFSetup().updateEcommerceCatalogItem(subject: .grocery, catalogObject: [groceryInternalCatalog].toData()!)
    }

    // Blood Catalog
    public static func updateBloodCatalog(itemId: String, bloodCatalogModel: String) {
        if let bloodCatalogModel = try? JSONDecoder.new.decode(BloodCatalogModel.self, from: Data(bloodCatalogModel.utf8)) {
            updateBloodCatalog(itemId: itemId, bloodCatalogModel: bloodCatalogModel)
        }
    }

    public static func updateBloodCatalog(itemId: String, bloodCatalogModel: BloodCatalogModel) {
        let bloodInternalCatalog = ECommerceConstants.verifyCatalogForBlood(itemId: itemId, bloodCatalogModel: bloodCatalogModel)
        CFSetup().updateEcommerceCatalogItem(subject: .blood, catalogObject: [bloodInternalCatalog].toData()!)
    }

    // Oxygen Catalog
    public static func updateOxygenCatalog(itemId: String, oxygenCatalogModel: String) {
        if let oxygenCatalogModel = try? JSONDecoder.new.decode(OxygenCatalogModel.self, from: Data(oxygenCatalogModel.utf8)) {
            updateOxygenCatalog(itemId: itemId, oxygenCatalogModel: oxygenCatalogModel)
        }
    }

    public static func updateOxygenCatalog(itemId: String, oxygenCatalogModel: OxygenCatalogModel) {
        let oxygenInternalCatalog = ECommerceConstants.verifyCatalogForOxygen(itemId: itemId, oxygenCatalogModel: oxygenCatalogModel)
        CFSetup().updateEcommerceCatalogItem(subject: .oxygen, catalogObject: [oxygenInternalCatalog].toData()!)
    }

    // Medical Equipment Catalog
    public static func updateMedicalEquipmentCatalog(itemId: String, medicalEquipmentCatalogModel: String) {
        if let medicalEquipmentCatalogModel = try? JSONDecoder.new.decode(MedicalEquipmentCatalogModel.self, from: Data(medicalEquipmentCatalogModel.utf8)) {
            updateMedicalEquipmentCatalog(itemId: itemId, medicalEquipmentCatalogModel: medicalEquipmentCatalogModel)
        }
    }

    public static func updateMedicalEquipmentCatalog(itemId: String, medicalEquipmentCatalogModel: MedicalEquipmentCatalogModel) {
        let medicalInternalCatalog = ECommerceConstants.verifyCatalogForMedicalEquipment(itemId: itemId, medicalEquipmentCatalogModel: medicalEquipmentCatalogModel)
        CFSetup().updateEcommerceCatalogItem(subject: .medical_equipment, catalogObject: [medicalInternalCatalog].toData()!)
    }

    // Facility Catalogd
    public static func updateFacilityCatalog(facilityId: String, facilityCatalogModel: String) {
        if let facilityCatalogModel = try? JSONDecoder.new.decode(FacilityCatalogModel.self, from: Data(facilityCatalogModel.utf8)) {
            updateFacilityCatalog(facilityId: facilityId, facilityCatalogModel: facilityCatalogModel)
        }
    }

    public static func updateFacilityCatalog(facilityId: String, facilityCatalogModel: FacilityCatalogModel) {
        let facilityInternalCatalog = ECommerceConstants.verifyCatalogForFacility(facilityId: facilityId, facilityCatalogModel: facilityCatalogModel)
        CFSetup().updateEcommerceCatalogItem(subject: .facility, catalogObject: [facilityInternalCatalog].toData()!)
    }
}
