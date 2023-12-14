//
//  CFSetup+CHW.swift
//
//
//  Created by khushbu on 16/11/23.
//

import CausalFoundrySDKCore
import Foundation

public extension CFSetup {
    func updateCHWMamnagementCatalogItem(subject: CatalogSubject, catalogObject: Data) {
        catalogAPIHandler.updateCHWCatalogItem(subject: subject, catalogObject: catalogObject)
    }
}
