//
//  CFSetup+Extension.swift
//
//
//  Created by khushbu on 16/11/23.
//

import Foundation
import CasualFoundryCore

extension CFSetup {
    
    public func updateCHWMamnagementCatalogItem(subject: CatalogSubject, catalogObject: Data) {
        catalogAPIHandler.updateCHWCatalogItem(subject: subject, catalogObject: catalogObject)
    }
    
}
