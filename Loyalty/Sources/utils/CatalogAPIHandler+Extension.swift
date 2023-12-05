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
//        guard let prevCatalog = CoreDataHelper.shared.readCataLogData(subject:subject.rawValue) else { return }
        CoreDataHelper.shared.writeLoyaltyCatalogData(subject: subject, data: catalogObject)
    }
}
