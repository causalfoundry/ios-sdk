//
//  CfChwCatalog.swift
//
//
//  Created by khushbu on 16/11/23.
//

import CausalFoundrySDKCore
import Foundation

public enum CfChwCatalog {
    // MARK: - CHW Catalog

    public static func updateChwCatalog(chwId: String, chwCatalogModel: String) {
        CfChwCatalog.updateChwCatalog(chwId: chwId, chwCatalogModel: try! JSONDecoder.new.decode(ChwCatalogModel.self, from: chwCatalogModel.data(using: .utf8)!))
    }

    public static func updateChwCatalog(chwId: String, chwCatalogModel: ChwCatalogModel) {
        let internalCatalog = ChwConstants.verifyChwCatalog(chwId, chwCatalogModel)
        CFSetup().updateCHWMamnagementCatalogItem(subject: .chw, catalogObject: [internalCatalog].toData()!)
    }

    // MARK: - CHW Site Catalog

    public static func updateChwSiteCatalog(siteId: String, chwSiteCatalogModel: String) {
        CfChwCatalog.updateChwSiteCatalog(siteId: siteId, chwSiteCatalogModel: try! JSONDecoder.new.decode(ChwSiteCatalogModel.self, from: chwSiteCatalogModel.data(using: .utf8)!))
    }

    public static func updateChwSiteCatalog(siteId: String, chwSiteCatalogModel: ChwSiteCatalogModel) {
        let internalCatalog = ChwConstants.verifySiteCatalog(siteId, chwSiteCatalogModel)
        CFSetup().updateCHWMamnagementCatalogItem(subject: .chwsite, catalogObject: [internalCatalog].toData()!)
    }

    // MARK: - Patient Catalog

    public static func updatePatientCatalog(patientId: String, patientCatalogModel: String) {
        CfChwCatalog.updatePatientCatalog(patientId: patientId, patientCatalogModel: try! JSONDecoder.new.decode(PatientCatalogModel.self, from: patientCatalogModel.data(using: .utf8)!))
    }

    public static func updatePatientCatalog(patientId: String, patientCatalogModel: PatientCatalogModel) {
        let internalCatalog = ChwConstants.verifyPatientCatalog(patientId, patientCatalogModel)
        CFSetup().updateCHWMamnagementCatalogItem(subject: .patient, catalogObject: [internalCatalog].toData()!)
    }
}
