//
//  CatalogAPIHandler+Extension.swift
//
//
//  Created by khushbu on 16/11/23.
//

import CasualFoundryCore
import Foundation

public extension CatalogAPIHandler {
    func updateEcommerceCatalogItem(subject: CatalogSubject, catalogObject: Data) {
        CoreDataHelper.shared.writeEcommerceCatalogData(subject: subject, data: catalogObject)
    }
}
