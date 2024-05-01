//
//  CatalogAPIHandler+CHW.swift
//
//
//  Created by khushbu on 16/11/23.
//

import CausalFoundrySDKCore
import Foundation

public extension CatalogAPIHandler {
    func updateCHWCatalogItem(subject: CatalogSubject, catalogObject: Data) {
        MMKVHelper.shared.writeCHWManagemntCatalogData(subject: subject, data: catalogObject)
    }
}
