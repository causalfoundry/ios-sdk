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

    static func verifyHcwCatalog(hcwId: String, hcwCatalogModel: HcwCatalogModel) -> InternalHcwModel? {
        let catalogName = "HCW catalog"

        guard !hcwId.isEmpty else {
            ExceptionManager.throwIsRequiredException(eventType: catalogName, elementName: "Hcw Id")
            return nil
        }

        for item in hcwCatalogModel.rolePermissions {
            guard !item.isEmpty else {
                ExceptionManager.throwRuntimeException(eventType: catalogName, message: "Invalid role_permissions provided")
                return nil
            }
        }

        for item in hcwCatalogModel.siteIdsList {
            guard !item.isEmpty else {
                ExceptionManager.throwRuntimeException(eventType: catalogName, message: "Invalid site_id_list provided")
                return nil
            }
        }

        for item in hcwCatalogModel.servicesList {
            guard !item.isEmpty else {
                ExceptionManager.throwRuntimeException(eventType: catalogName, message: "Invalid services provided")
                return nil
            }
        }

        return InternalHcwModel(
            id: hcwId,
            name: hcwCatalogModel.name,
            isVolunteer: hcwCatalogModel.isVolunteer,
            role: hcwCatalogModel.role,
            rolePermissions: hcwCatalogModel.rolePermissions,
            siteIdsList: hcwCatalogModel.siteIdsList,
            servicesList: hcwCatalogModel.servicesList
        )
    }

    static func verifySiteCatalog(siteId: String, hcwSiteCatalogModel: HcwSiteCatalogModel) -> InternalHcwSiteCatalogModel? {
        let catalogName = CatalogSubject.chwsite.rawValue + " catalog"

        guard !siteId.isEmpty else {
            ExceptionManager.throwIsRequiredException(eventType: catalogName, elementName: "Site Id")
            return nil
        }

        if !hcwSiteCatalogModel.country.isEmpty {
            guard CountryCode(rawValue: hcwSiteCatalogModel.country) != nil else {
                ExceptionManager.throwEnumException(eventType: catalogName, className: "CountryCode")
                return nil
            }
        }

        return InternalHcwSiteCatalogModel(
            id: siteId,
            name: hcwSiteCatalogModel.name,
            country: hcwSiteCatalogModel.country,
            regionState: hcwSiteCatalogModel.regionState,
            city: hcwSiteCatalogModel.city,
            zipcode: hcwSiteCatalogModel.zipcode,
            level: hcwSiteCatalogModel.level,
            category: hcwSiteCatalogModel.category,
            isActive: hcwSiteCatalogModel.isActive,
            address: hcwSiteCatalogModel.address,
            addressType: hcwSiteCatalogModel.addressType,
            latitude: hcwSiteCatalogModel.latitude,
            longitude: hcwSiteCatalogModel.longitude,
            culture: hcwSiteCatalogModel.culture
        )
    }

    static func verifyPatientCatalog(patientId: String, patientCatalogModel: PatientCatalogModel) -> InternalPatientModel? {
        let catalogName = CatalogSubject.patient.rawValue + " catalog"

        guard !patientId.isEmpty else {
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

        for item in patientCatalogModel.siteIdsList {
            guard !item.isEmpty else {
                ExceptionManager.throwRuntimeException(eventType: catalogName, message: "Invalid site_ids_list provided")
                return nil
            }
        }

        return InternalPatientModel(
            id: patientId,
            country: patientCatalogModel.country,
            regionState: patientCatalogModel.regionState,
            city: patientCatalogModel.city,
            profession: patientCatalogModel.profession,
            educationLevel: patientCatalogModel.educationLevel,
            siteIdsList: patientCatalogModel.siteIdsList,
            nationalId: patientCatalogModel.nationalId,
            insuranceId: patientCatalogModel.insuranceId,
            insuranceType: patientCatalogModel.insuranceType,
            insuranceStatus: patientCatalogModel.insuranceStatus,
            landmark: patientCatalogModel.landmark,
            phoneNumberCategory: patientCatalogModel.phoneNumberCategory,
            programId: patientCatalogModel.programId
        )
    }
    
    
    
    
}
