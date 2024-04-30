//
//  ChwConstants.swift
//
//
//  Created by khushbu on 25/10/23.
//

import CausalFoundrySDKCore
import Foundation

enum ChwConstants {
    static var contentBlockName: String = ContentBlock.PatientMgmt.rawValue

    static func verifyChwCatalog(chwId: String, chwCatalogModel: ChwCatalogModel) -> InternalChwModel? {
        let catalogName = CatalogSubject.chw.rawValue + " catalog"

        guard !chwId.isEmpty else {
            ExceptionManager.throwIsRequiredException(eventType: catalogName, elementName: "Chw Id")
            return nil
        }

        for item in chwCatalogModel.rolePermissions {
            guard !item.isEmpty else {
                ExceptionManager.throwRuntimeException(eventType: catalogName, message: "Invalid role_permissions provided")
                return nil
            }
        }

        for item in chwCatalogModel.siteIdsList {
            guard !item.isEmpty else {
                ExceptionManager.throwRuntimeException(eventType: catalogName, message: "Invalid site_id_list provided")
                return nil
            }
        }

        for item in chwCatalogModel.servicesList {
            guard !item.isEmpty else {
                ExceptionManager.throwRuntimeException(eventType: catalogName, message: "Invalid services provided")
                return nil
            }
        }

        return InternalChwModel(
            id: chwId,
            name: chwCatalogModel.name,
            isVolunteer: false,
            role: chwCatalogModel.role,
            rolePermissions: chwCatalogModel.rolePermissions,
            siteIdsList: chwCatalogModel.siteIdsList,
            servicesList: chwCatalogModel.servicesList
        )
    }

    static func verifySiteCatalog(siteId: String, chwSiteCatalogModel: ChwSiteCatalogModel) -> InternalSiteModel? {
        let catalogName = CatalogSubject.chwsite.rawValue + " catalog"

        guard !siteId.isEmpty else {
            ExceptionManager.throwIsRequiredException(eventType: catalogName, elementName: "Site Id")
            return nil
        }

        if !chwSiteCatalogModel.country.isEmpty {
            guard CountryCode(rawValue: chwSiteCatalogModel.country) != nil else {
                ExceptionManager.throwEnumException(eventType: catalogName, className: "CountryCode")
                return nil
            }
        }

        return InternalSiteModel(
            id: siteId,
            name: chwSiteCatalogModel.name,
            country: chwSiteCatalogModel.country,
            regionState: chwSiteCatalogModel.regionState,
            city: chwSiteCatalogModel.city,
            zipcode: chwSiteCatalogModel.zipcode,
            level: chwSiteCatalogModel.level,
            category: chwSiteCatalogModel.category,
            isActive: chwSiteCatalogModel.isActive,
            address: chwSiteCatalogModel.address,
            addressType: chwSiteCatalogModel.addressType,
            latitude: chwSiteCatalogModel.latitude,
            longitude: chwSiteCatalogModel.longitude,
            culture: chwSiteCatalogModel.culture
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

        if !patientCatalogModel.educationLevel.isEmpty {
            guard EducationalLevel(rawValue: patientCatalogModel.educationLevel) != nil else {
                ExceptionManager.throwEnumException(eventType: catalogName, className: "EducationalLevel")
                return nil
            }
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
