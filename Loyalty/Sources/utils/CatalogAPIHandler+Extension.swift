//
//  CatalogAPIHandler+Extension.swift
//
//
//  Created by khushbu on 16/11/23.
//

import CasualFoundryCore
import Foundation

public extension CatalogAPIHandler {
    func updateLoyaltyCatalogItem(subject: CatalogSubject, catalogObject: Data) {
//        guard let prevCatalog = MMKVHelper.shared.readCataLogData(subject:subject.rawValue) else { return }
        MMKVHelper.shared.writeLoyaltyCatalogData(subject: subject, data: catalogObject)
    }
}
