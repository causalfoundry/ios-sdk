//
//  CatalogAPIHandler.swift
//
//
//  Created by khushbu on 16/11/23.
//

import Foundation
import CasualFoundryCore

extension CatalogAPIHandler {
    public func updateEcommerceCatalogItem(subject: CatalogSubject, catalogObject: Data) {
        CoreDataHelper.shared.writeEcommerceCatalogData(subject: subject, data: catalogObject)
    }
}
