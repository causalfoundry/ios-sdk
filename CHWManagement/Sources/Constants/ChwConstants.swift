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

        if chwId.isEmpty {
            ExceptionManager.throwIsRequiredException(eventType: catalogName, elementName: "Chw Id")
        }else if let permissions = chwCatalogModel.rolePermissions {
            for item in permissions{
                guard !item.isEmpty else {
                    ExceptionManager.throwRuntimeException(eventType: catalogName, message: "Invalid role_permissions provided")
                    
                }
            }

        }else if let idLists = chwCatalogModel.siteIdsList {
            for item in  idLists {
                guard !item.isEmpty else {
                     ExceptionManager.throwRuntimeException(eventType: catalogName, message: "Invalid site_id_list provided")
                    return
                }
            }
        }else if let serviceList = chwCatalogModel.servicesList {
            for item in serviceList {
                guard !item.isEmpty else {
                     ExceptionManager.throwRuntimeException(eventType: catalogName, message: "Invalid services provided")
                    return
                }
            }
        }else {
            
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
    }

    static func verifySiteCatalog(_ siteId: String, _ chwSiteCatalogModel: ChwSiteCatalogModel) throws -> InternalSiteModel {
        let catalogName = CatalogSubject.chwsite.rawValue + " catalog"
        
        guard !siteId.isEmpty else {
            ExceptionManager.throwIsRequiredException(eventType: catalogName, elementName: "Site Id")
            return
        }
        
        if !chwSiteCatalogModel.country.isEmpty {
            guard let countryCode = CountryCode(rawValue: chwSiteCatalogModel.country) else {
                ExceptionManager.throwEnumException(eventType: catalogName, className: "CountryCode")
                return
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

    static func verifyPatientCatalog(_ patientId: String, _ patientCatalogModel: PatientCatalogModel) throws -> InternalPatientModel {
        let catalogName = CatalogSubject.patient.rawValue + " catalog"

        guard !patientId.isEmpty else {
             ExceptionManager.throwIsRequiredException(eventType:catalogName , elementName: "Patient Id")
            return
        }

        if !patientCatalogModel.country.isEmpty {
            guard let countryCode = CountryCode(rawValue: patientCatalogModel.country) else {
                 ExceptionManager.throwEnumException(eventType:catalogName , className:"CountryCode")
                return
            }
        }

        if !patientCatalogModel.educationLevel.isEmpty {
            guard let educationalLevel = EducationalLevel(rawValue: patientCatalogModel.educationLevel) else {
                 ExceptionManager.throwEnumException(eventType:catalogName , className: "EducationalLevel")
                return
            }
        }

        for item in patientCatalogModel.siteIdsList {
            guard !item.isEmpty else {
                 ExceptionManager.throwRuntimeException(eventType: catalogName, message: "Invalid site_ids_list provided")
                return
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
