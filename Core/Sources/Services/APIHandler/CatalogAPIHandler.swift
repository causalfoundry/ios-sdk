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
       CoreDataHelper.shared.writeCatalogData(subject: subject, data: catalogObject)
    }
    
   
    public func callCatalogAPI(catalogMainObject: [Any], catalogSubject: String, completion: @escaping (_ success: Bool) -> Void) {
        APIManager.shared.postUpdateCatelogEvents(url:"\(CoreConstants.shared.devUrl)ingest/catalog/\(catalogSubject)" , params: catalogMainObject, "POST", headers:["subject":catalogSubject], completion:{ (result) in
            completion(result)
        })
    }


}
