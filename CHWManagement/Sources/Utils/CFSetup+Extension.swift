//
//  CFSetup+Extension.swift
//
//
//  Created by khushbu on 16/11/23.
//

import CasualFoundryCore
import Foundation

public extension CFSetup {
    func updateCHWMamnagementCatalogItem(subject: CatalogSubject, catalogObject: Data) {
        catalogAPIHandler.updateCHWCatalogItem(subject: subject, catalogObject: catalogObject)
    }
}
