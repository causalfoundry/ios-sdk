//
//  ChwConstants.swift
//
//
//  Created by khushbu on 25/10/23.
//

import Foundation


enum ChwConstants {
    static var contentBlockName: String = ContentBlock.chw_mgmt.name

    static func verifyChwCatalog(_ chwId: String, _ chwCatalogModel: ChwCatalogModel) throws -> InternalChwModel {
        let catalogName = CatalogSubject.chw.name + " catalog"

        guard !chwId.isEmpty else {
            throw ExceptionManager.RequiredException(catalogName, "Chw Id")
        }

        for item in chwCatalogModel.role_permissions {
            guard !item.isEmpty else {
                throw ExceptionManager.RuntimeException(catalogName, "Invalid role_permissions provided")
            }
        }

        for item in chwCatalogModel.site_id_list {
            guard !item.isEmpty else {
                throw ExceptionManager.RuntimeException(catalogName, "Invalid site_id_list provided")
            }
        }

        for item in chwCatalogModel.services {
            guard !item.isEmpty else {
                throw ExceptionManager.RuntimeException(catalogName, "Invalid services provided")
            }
        }

        return InternalChwModel(
            id: chwId,
            name: chwCatalogModel.name,
            role: chwCatalogModel.role,
            role_permissions: chwCatalogModel.role_permissions,
            site_id_list: chwCatalogModel.site_id_list,
            services: chwCatalogModel.services
        )
    }

    static func verifySiteCatalog(_ siteId: String, _ chwSiteCatalogModel: ChwSiteCatalogModel) throws -> InternalSiteModel {
        let catalogName = CatalogSubject.chwsite.name + " catalog"

        guard !siteId.isEmpty else {
            throw ExceptionManager.RequiredException(catalogName, "Site Id")
        }

        if !chwSiteCatalogModel.country.isEmpty {
            guard let countryCode = CountryCode(rawValue: chwSiteCatalogModel.country) else {
                throw ExceptionManager.EnumException(catalogName, CountryCode.self.simpleName)
            }
        }

        return InternalSiteModel(
            id: siteId,
            name: chwSiteCatalogModel.name,
            country: chwSiteCatalogModel.country,
            region_state: chwSiteCatalogModel.region_state,
            city: chwSiteCatalogModel.city,
            zipcode: chwSiteCatalogModel.zipcode,
            level: chwSiteCatalogModel.level,
            category: chwSiteCatalogModel.category,
            is_active: chwSiteCatalogModel.is_active,
            address: chwSiteCatalogModel.address,
            address_type: chwSiteCatalogModel.address_type,
            latitude: chwSiteCatalogModel.latitude,
            longitude: chwSiteCatalogModel.longitude,
            culture: chwSiteCatalogModel.culture
        )
    }

    static func verifyPatientCatalog(_ patientId: String, _ patientCatalogModel: PatientCatalogModel) throws -> InternalPatientModel {
        let catalogName = CatalogSubject.patient.name + " catalog"

        guard !patientId.isEmpty else {
            throw ExceptionManager.RequiredException(catalogName, "Patient Id")
        }

        if !patientCatalogModel.country.isEmpty {
            guard let countryCode = CountryCode(rawValue: patientCatalogModel.country) else {
                throw ExceptionManager.EnumException(catalogName, CountryCode.self.simpleName)
            }
        }

        if !patientCatalogModel.education_level.isEmpty {
            guard let educationalLevel = EducationalLevel(rawValue: patientCatalogModel.education_level) else {
                throw ExceptionManager.EnumException(catalogName, EducationalLevel.self.simpleName)
            }
        }

        for item in patientCatalogModel.site_ids_list {
            guard !item.isEmpty else {
                throw ExceptionManager.RuntimeException(catalogName, "Invalid site_ids_list provided")
            }
        }

        return InternalPatientModel(
            id: patientId,
            country: patientCatalogModel.country,
            region_state: patientCatalogModel.region_state,
            city: patientCatalogModel.city,
            profession: patientCatalogModel.profession,
            education_level: patientCatalogModel.education_level,
            site_ids_list: patientCatalogModel.site_ids_list,
            national_id: patientCatalogModel.national_id,
            insurance_id: patientCatalogModel.insurance_id,
            insurance_type: patientCatalogModel.insurance_type,
            insurance_status: patientCatalogModel.insurance_status,
            landmark: patientCatalogModel.landmark,
            phone_number_category: patientCatalogModel.phone_number_category,
            program_id: patientCatalogModel.program_id
        )
    }
}
