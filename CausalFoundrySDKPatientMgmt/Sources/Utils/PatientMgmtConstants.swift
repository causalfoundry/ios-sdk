//
//  PatientMgmtConstants.swift
//
//
//  Created by MOIZ HASSAN KHAN on 01/05/24.
//

import CausalFoundrySDKCore
import Foundation

enum PatientMgmtConstants {
    static var contentBlockName: String = "patient_mgmt"

    static func verifyHcwCatalog(hcwCatalogModel: HcwCatalogModel) -> HcwCatalogModel? {
        let catalogName = "HCW catalog"

        guard !hcwCatalogModel.hcwId.isEmpty else {
            ExceptionManager.throwIsRequiredException(eventType: catalogName, elementName: "Hcw Id")
            return nil
        }

        for item in hcwCatalogModel.siteIdList {
            guard !item.isEmpty else {
                ExceptionManager.throwRuntimeException(eventType: catalogName, message: "Invalid site_id_list provided")
                return nil
            }
        }

        for item in hcwCatalogModel.supervisorIdList {
            guard !item.isEmpty else {
                ExceptionManager.throwRuntimeException(eventType: catalogName, message: "Invalid supervisor_id_list provided")
                return nil
            }
        }

        return hcwCatalogModel
    }

    static func verifySiteCatalog(hcwSiteCatalogModel: HcwSiteCatalogModel) -> HcwSiteCatalogModel? {
        let catalogName = CatalogSubject.chwsite.rawValue + " catalog"

        print("--------")
        print(hcwSiteCatalogModel)
        guard !hcwSiteCatalogModel.siteId.isEmpty else {
            ExceptionManager.throwIsRequiredException(eventType: catalogName, elementName: "Site val Id")
            return nil
        }
        
        guard !hcwSiteCatalogModel.name.isEmpty else {
            ExceptionManager.throwIsRequiredException(eventType: catalogName, elementName: "Site name")
            return nil
        }

        if !hcwSiteCatalogModel.country.isEmpty {
            guard CountryCode(rawValue: hcwSiteCatalogModel.country) != nil else {
                ExceptionManager.throwEnumException(eventType: catalogName, className: "CountryCode")
                return nil
            }
        }

        return hcwSiteCatalogModel
    }

    static func verifyPatientCatalog(patientCatalogModel: PatientCatalogModel) -> PatientCatalogModel? {
        let catalogName = CatalogSubject.patient.rawValue + " catalog"

        guard !patientCatalogModel.patientId.isEmpty else {
            ExceptionManager.throwIsRequiredException(eventType: catalogName, elementName: "Patient Id")
            return nil
        }

        if !patientCatalogModel.country.isEmpty {
            guard CountryCode(rawValue: patientCatalogModel.country) != nil else {
                ExceptionManager.throwEnumException(eventType: catalogName, className: "CountryCode")
                return nil
            }
        }

        if (!patientCatalogModel.educationLevel.isEmpty && !CoreConstants.shared.enumContains(EducationalLevel.self, name: patientCatalogModel.educationLevel)) {
            ExceptionManager.throwEnumException(eventType: catalogName, className: "EducationalLevel")
            return nil
        }

        for item in patientCatalogModel.siteIdList {
            guard !item.isEmpty else {
                ExceptionManager.throwRuntimeException(eventType: catalogName, message: "Invalid site_id_list provided")
                return nil
            }
        }

        return patientCatalogModel
    }
    
    
    
    
}
