//
//  CatalogAPIHandler+E-Commerce.swift
//
//
//  Created by khushbu on 16/11/23.
//

#if canImport(CasualFoundryCore)
import CasualFoundryCore
#endif
import Foundation

public extension CatalogAPIHandler {
    func updateEcommerceCatalogItem(subject: CatalogSubject, catalogObject: Data) {
        MMKVHelper.shared.writeEcommerceCatalogData(subject: subject, data: catalogObject)
    }
}
