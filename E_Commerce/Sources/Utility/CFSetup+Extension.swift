//
//  File.swift
//  
//
//  Created by khushbu on 29/10/23.
//

import Foundation
import CasualFoundryCore


extension CFSetup {
    
    public func updateEcommerceCatalogItem(subject: CatalogSubject, catalogObject: Data) {
        catalogAPIHandler.updateEcommerceCatalogItem(subject: subject, catalogObject: catalogObject)
    }
    
    
}
