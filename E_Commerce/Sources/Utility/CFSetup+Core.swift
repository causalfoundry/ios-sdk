//
//  CFSetup+Core.swift
//
//
//  Created by khushbu on 29/10/23.
//

import CausalFoundrySDKCore
import Foundation

public extension CFSetup {
    func updateEcommerceCatalogItem(subject: CatalogSubject, catalogObject: Data) {
        catalogAPIHandler.updateEcommerceCatalogItem(subject: subject, catalogObject: catalogObject)
    }
}
