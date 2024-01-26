//
//  CFSetup+Loyalty.swift
//
//
//  Created by khushbu on 16/11/23.
//

import CausalFoundrySDKCore
import Foundation

public extension CFSetup {
    func updateLoyaltyCatalogItem(subject: CatalogSubject, catalogObject: Data) {
        catalogAPIHandler.updateLoyaltyCatalogItem(subject: subject, catalogObject: catalogObject)
    }
}
