//
//  CFSetup+Loyalty.swift
//
//
//  Created by khushbu on 16/11/23.
//

import CausalFoundrySDKCore
import Foundation

public extension CFSetup {
    func updateLoyaltyCatalogItem(subject: CatalogSubject, catalogObject: Data?) {
        if(catalogObject == nil){
            return
        }
        catalogAPIHandler.updateLoyaltyCatalogItem(subject: subject, catalogObject: catalogObject!)
    }
}
