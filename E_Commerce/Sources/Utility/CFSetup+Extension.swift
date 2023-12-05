//
//  CFSetup+Extension.swift
//
//
//  Created by khushbu on 29/10/23.
//

import CasualFoundryCore
import Foundation

public extension CFSetup {
    func updateEcommerceCatalogItem(subject: CatalogSubject, catalogObject: Data) {
        catalogAPIHandler.updateEcommerceCatalogItem(subject: subject, catalogObject: catalogObject)
    }
}
