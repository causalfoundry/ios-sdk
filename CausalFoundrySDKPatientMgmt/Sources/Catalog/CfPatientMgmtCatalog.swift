//
//  CfPatientMgmtCatalog.swift
//
//
//  Created by MOIZ HASSAN KHAN on 01/05/24.
//

import CausalFoundrySDKCore
import Foundation

public enum CfPatientMgmtCatalog {
    // MARK: - CHW Catalog

    public static func updateHcwCatalog(hcwId: String, hcwCatalogModel: String) {
        updateHcwCatalog(hcwId: hcwId, hcwCatalogModel: try! JSONDecoder.new.decode(HcwCatalogModel.self, from: hcwCatalogModel.data(using: .utf8)!))
    }

    public static func updateHcwCatalog(hcwId: String, hcwCatalogModel: HcwCatalogModel) {
        let internalCatalog = PatientMgmtConstants.verifyHcwCatalog(hcwId: hcwId, hcwCatalogModel: hcwCatalogModel)
        CFSetup().updateCHWMamnagementCatalogItem(subject: .user_chw, catalogObject: [internalCatalog].toData()!)
    }

    // MARK: - CHW Site Catalog

    public static func updateHcwSiteCatalog(siteId: String, hcwSiteCatalogModel: String) {
        updateHcwSiteCatalog(siteId: siteId, hcwSiteCatalogModel: try! JSONDecoder.new.decode(HcwSiteCatalogModel.self, from: hcwSiteCatalogModel.data(using: .utf8)!))
    }

    public static func updateHcwSiteCatalog(siteId: String, hcwSiteCatalogModel: HcwSiteCatalogModel) {
        let internalCatalog = PatientMgmtConstants.verifySiteCatalog(siteId: siteId, hcwSiteCatalogModel: hcwSiteCatalogModel)
        CFSetup().updateCHWMamnagementCatalogItem(subject: .chwsite, catalogObject: [internalCatalog].toData()!)
    }

    // MARK: - Patient Catalog

    public static func updatePatientCatalog(patientId: String, patientCatalogModel: String) {
        updatePatientCatalog(patientId: patientId, patientCatalogModel: try! JSONDecoder.new.decode(PatientCatalogModel.self, from: patientCatalogModel.data(using: .utf8)!))
    }

    public static func updatePatientCatalog(patientId: String, patientCatalogModel: PatientCatalogModel) {
        let internalCatalog = PatientMgmtConstants.verifyPatientCatalog(patientId: patientId, patientCatalogModel: patientCatalogModel)
        CFSetup().updateCHWMamnagementCatalogItem(subject: .patient, catalogObject: [internalCatalog].toData()!)
    }
}
