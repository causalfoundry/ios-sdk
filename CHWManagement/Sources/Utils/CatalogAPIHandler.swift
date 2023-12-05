//
//  CatalogAPIHandler.swift
//
//
//  Created by khushbu on 16/11/23.
//

import CasualFoundryCore
import Foundation

public extension CatalogAPIHandler {
    func updateCHWCatalogItem(subject: CatalogSubject, catalogObject: Data) {
        CoreDataHelper.shared.writeCHWManagemntCatalogData(subject: subject, data: catalogObject)
    }
}
