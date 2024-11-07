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

        
        if let siteIdList = hcwCatalogModel.siteIdList, !siteIdList.isEmpty {
            for item in siteIdList {
                guard !item.isEmpty else {
                    ExceptionManager.throwRuntimeException(eventType: catalogName, message: "Invalid site_id_list provided")
                    return nil
                }
            }
        }
        
        
        if let supervisorIdList = hcwCatalogModel.supervisorIdList, !supervisorIdList.isEmpty {
            for item in supervisorIdList {
                guard !item.isEmpty else {
                    ExceptionManager.throwRuntimeException(eventType: catalogName, message: "Invalid supervisor_id_list provided")
                    return nil
                }
            }
        }
        

        return hcwCatalogModel
    }

    static func verifyPatientCatalog(patientCatalogModel: PatientCatalogModel) -> PatientCatalogModel? {
        let catalogName = CatalogSubject.patient.rawValue + " catalog"

        guard !patientCatalogModel.patientId.isEmpty else {
            ExceptionManager.throwIsRequiredException(eventType: catalogName, elementName: "Patient Id")
            return nil
        }

        if let country = patientCatalogModel.country, !country.isEmpty {
            guard CountryCode(rawValue: country) != nil else {
                ExceptionManager.throwEnumException(eventType: catalogName, className: "CountryCode")
                return nil
            }
        }

        if let educationLevel = patientCatalogModel.educationLevel,
           !educationLevel.isEmpty,
           !CoreConstants.shared.enumContains(EducationalLevel.self, name: educationLevel) {
               
            ExceptionManager.throwEnumException(eventType: catalogName, className: "EducationalLevel")
            return nil
        }

        if let siteIdList = patientCatalogModel.siteIdList, !siteIdList.isEmpty {
            for item in siteIdList {
                guard !item.isEmpty else {
                    ExceptionManager.throwRuntimeException(eventType: catalogName, message: "Invalid site_id_list provided")
                    return nil
                }
            }
        }

        return patientCatalogModel
    }
    
    
    
    
}

