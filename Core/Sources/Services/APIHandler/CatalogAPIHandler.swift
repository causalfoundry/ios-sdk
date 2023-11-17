//
//  CatalogAPIHandler.swift
//
//
//  Created by khushbu on 12/09/23.
//

import Foundation
import UIKit


public class CatalogAPIHandler {

   public  func updateCoreCatalogItem(subject: CatalogSubject, catalogObject: Data) {
       CoreDataHelper.shared.writeCoreCatalogData(subject: subject, data: catalogObject)
    }
    
    private func updateCatalogArray(subject: CatalogSubject, catalogArray: [Any]) {
        
    }

    public func callCatalogAPI(catalogMainObject: [Any], catalogSubject: String, sdkToken: String) {
        _ = try? JSONSerialization.data(withJSONObject: catalogMainObject)
        try APIManager.shared.postUpdateCatelogEvents(url:APIConstants.updateCatalog , params: catalogMainObject, "POST", headers:["subject":catalogSubject], completion:{ (result) in
            print(result as Any)
        })
    }


}
