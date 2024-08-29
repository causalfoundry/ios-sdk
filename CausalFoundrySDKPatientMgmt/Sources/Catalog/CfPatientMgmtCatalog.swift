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

    public static func updateHcwCatalogString(hcwCatalogString: String) {
        updateHcwCatalog(hcwCatalogModel: try! JSONDecoder.new.decode(HcwCatalogModel.self, from: hcwCatalogString.data(using: .utf8)!))
    }

    public static func updateHcwCatalog(hcwCatalogModel: HcwCatalogModel) {
        let internalCatalog = PatientMgmtConstants.verifyHcwCatalog(hcwCatalogModel: hcwCatalogModel)
        CFSetup().updateCHWMamnagementCatalogItem(subject: .user_chw, catalogObject: [internalCatalog].toData()!)
    }

    // MARK: - CHW Site Catalog

    public static func updateHcwSiteCatalogString(hcwSiteCatalogString: String) {
        updateHcwSiteCatalog(hcwSiteCatalogModel: try! JSONDecoder.new.decode(HcwSiteCatalogModel.self, from: hcwSiteCatalogString.data(using: .utf8)!))
    }

    public static func updateHcwSiteCatalog(hcwSiteCatalogModel: HcwSiteCatalogModel) {
        let internalCatalog = PatientMgmtConstants.verifySiteCatalog(hcwSiteCatalogModel: hcwSiteCatalogModel)
        CFSetup().updateCHWMamnagementCatalogItem(subject: .chwsite, catalogObject: [internalCatalog].toData()!)
    }

    // MARK: - Patient Catalog

    public static func updatePatientCatalogString(patientCatalogString: String) {
        updatePatientCatalog(patientCatalogModel: try! JSONDecoder.new.decode(PatientCatalogModel.self, from: patientCatalogString.data(using: .utf8)!))
    }

    public static func updatePatientCatalog(patientCatalogModel: PatientCatalogModel) {
        let internalCatalog = PatientMgmtConstants.verifyPatientCatalog(patientCatalogModel: patientCatalogModel)
        CFSetup().updateCHWMamnagementCatalogItem(subject: .patient, catalogObject: [internalCatalog].toData()!)
    }
}
