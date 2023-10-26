//
//  ChwConstants.swift
//
//
//  Created by khushbu on 25/10/23.
//

import Foundation
import CasualFoundryCore


enum ChwConstants {
    static var contentBlockName: String = ContentBlock.chw_mgmt.rawValue

    static func verifyChwCatalog(_ chwId: String, _ chwCatalogModel: ChwCatalogModel) throws -> InternalChwModel {
        let catalogName = CatalogSubject.chw.rawValue + " catalog"

        guard !chwId.isEmpty else {
            ExceptionManager.throwIsRequiredException(eventType: catalogName, elementName: "Chw Id")
        }

        for item in chwCatalogModel.rolePermissions {
            guard !item.isEmpty else {
                ExceptionManager.throwRuntimeException(eventType: catalogName, message: "Invalid role_permissions provided")
            }
        }

        for item in chwCatalogModel.siteIdsList {
            guard !item.isEmpty else {
                 ExceptionManager.throwRuntimeException(eventType: catalogName, message: "Invalid site_id_list provided")
            }
        }

        for item in chwCatalogModel.servicesList {
            guard !item.isEmpty else {
                 ExceptionManager.throwRuntimeException(eventType: catalogName, message: "Invalid services provided")
            }
        }

        return InternalChwModel(
            id: chwId,
            name: chwCatalogModel.name,
            isVolunteer: false,
            role: chwCatalogModel.role,
            rolePermissions: chwCatalogModel.rolePermissions,
            siteIdsList: chwCatalogModel.siteIdsList,
            servicesList:chwCatalogModel.servicesList
        )
    }

    static func verifySiteCatalog(_ siteId: String, _ chwSiteCatalogModel: ChwSiteCatalogModel) throws -> InternalSiteModel {
        let catalogName = CatalogSubject.chwsite.rawValue + " catalog"
        
        guard !siteId.isEmpty else {
            ExceptionManager.throwIsRequiredException(eventType: catalogName, elementName: "Site Id")
        }
        
        if !chwSiteCatalogModel.country.isEmpty {
            guard let countryCode = CountryCode(rawValue: chwSiteCatalogModel.country) else {
                ExceptionManager.throwEnumException(eventType: catalogName, className: "CountryCode")
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
            addresstype: chwSiteCatalogModel.addressType,
            latitude: chwSiteCatalogModel.latitude,
            longitude: chwSiteCatalogModel.longitude,
            culture: chwSiteCatalogModel.culture
        )
        
    }

    static func verifyPatientCatalog(_ patientId: String, _ patientCatalogModel: PatientCatalogModel) throws -> InternalPatientModel {
        let catalogName = CatalogSubject.patient.rawValue + " catalog"

        guard !patientId.isEmpty else {
             ExceptionManager.throwIsRequiredException(eventType:catalogName , elementName: "Patient Id")
        }

        if !patientCatalogModel.country.isEmpty {
            guard let countryCode = CountryCode(rawValue: patientCatalogModel.country) else {
                 ExceptionManager.throwEnumException(eventType:catalogName , className:"CountryCode")
            }
        }

        if !patientCatalogModel.educationLevel.isEmpty {
            guard let educationalLevel = EducationalLevel(rawValue: patientCatalogModel.educationLevel) else {
                 ExceptionManager.throwEnumException(eventType:catalogName , className: "EducationalLevel")
            }
        }

        for item in patientCatalogModel.siteIdsList {
            guard !item.isEmpty else {
                 ExceptionManager.throwRuntimeException(eventType: catalogName, message: "Invalid site_ids_list provided")
            }
        }

        return InternalPatientModel(
            id: patientId,
            country: patientCatalogModel.country,
            region_state: patientCatalogModel.regionState,
            city: patientCatalogModel.city,
            profession: patientCatalogModel.profession,
            education_level: patientCatalogModel.educationLevel,
            site_ids_list: patientCatalogModel.siteIdsList,
            national_id: patientCatalogModel.nationalId,
            insurance_id: patientCatalogModel.insuranceId,
            insurance_type: patientCatalogModel.insuranceType,
            insurance_status: patientCatalogModel.insuranceStatus,
            landmark: patientCatalogModel.landmark,
            phone_number_category: patientCatalogModel.phoneNumberCategory,
            program_id: patientCatalogModel.programId
        )
    }
}
