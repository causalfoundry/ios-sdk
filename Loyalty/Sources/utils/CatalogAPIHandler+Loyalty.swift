//
//  CatalogAPIHandler+Loyalty.swift
//
//
//  Created by khushbu on 16/11/23.
//

#if canImport(CasualFoundryCore)
import CasualFoundryCore
#endif
import Foundation

public extension CatalogAPIHandler {
    func updateLoyaltyCatalogItem(subject: CatalogSubject, catalogObject: Data) {
//        guard let prevCatalog = MMKVHelper.shared.readCataLogData(subject:subject.rawValue) else { return }
        MMKVHelper.shared.writeLoyaltyCatalogData(subject: subject, data: catalogObject)
    }
}
