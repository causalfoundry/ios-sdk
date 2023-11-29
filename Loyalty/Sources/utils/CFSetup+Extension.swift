//
//  File.swift
//  
//
//  Created by khushbu on 16/11/23.
//

import Foundation
import CasualFoundryCore


extension CFSetup {
    
    public func updateLoyaltyCatalogItem(subject: CatalogSubject, catalogObject: Data) {
        catalogAPIHandler.updateLoyaltyCatalogItem(subject: subject, catalogObject: catalogObject)
    }
    
    
}
