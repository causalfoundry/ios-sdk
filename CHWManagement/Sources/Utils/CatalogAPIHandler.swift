//
//  File.swift
//  
//
//  Created by khushbu on 16/11/23.
//

import Foundation
import CasualFoundryCore


extension CatalogAPIHandler {
    public func updateCHWCatalogItem(subject: CatalogSubject, catalogObject: Data) {
        CoreDataHelper.shared.writeCHWManagemntCatalogData(subject: subject, data: catalogObject)
    }
}




