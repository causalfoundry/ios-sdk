//
//  File.swift
//  
//
//  Created by khushbu on 16/11/23.
//

import Foundation
import CasualFoundryCore


extension CatalogAPIHandler {
    public func updateCHWCatalogItem(subject: CatalogSubject, catalogObject: Data) {
        guard let prevCatalog = CoreDataHelper.shared.readCataLogData(subject:subject.rawValue) else { return }
        CoreDataHelper.shared.writeCHWManagemntCatalogData(subject: subject, data: catalogObject)
    }
}




