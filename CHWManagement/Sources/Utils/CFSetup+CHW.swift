//
//  CFSetup+CHW.swift
//
//
//  Created by khushbu on 16/11/23.
//

#if canImport(CasualFoundryCore)
import CasualFoundryCore
#endif
import Foundation

public extension CFSetup {
    func updateCHWMamnagementCatalogItem(subject: CatalogSubject, catalogObject: Data) {
        catalogAPIHandler.updateCHWCatalogItem(subject: subject, catalogObject: catalogObject)
    }
}
