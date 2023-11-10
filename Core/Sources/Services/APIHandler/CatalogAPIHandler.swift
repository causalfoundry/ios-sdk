//
//  CatalogAPIHandler.swift
//
//
//  Created by khushbu on 12/09/23.
//

import Foundation
import UIKit


public class CatalogAPIHandler {

    func updateCatalogItem(subject: CatalogSubject, catalogObject: Any?) {
        guard let prevCatalog = CoreDataHelper.shared.readCataLogData(subject:subject.rawValue) else { return }
        CoreDataHelper.shared.writeCatalogData(subject: subject.rawValue, data: catalogObject as Any)
    }
        
    

    private func updateCatalogArray(subject: CatalogSubject, catalogArray: [Any]) {
        
    }

    func callCatalogAPI(catalogMainObject: [Any], catalogSubject: String, sdkToken: String) {
        _ = try? JSONSerialization.data(withJSONObject: catalogMainObject)
        try APIManager.shared.postUpdateCatelogEvents(url:APIConstants.updateCatalog , params: catalogMainObject, "POST", headers:["subject":catalogSubject], completion:{ (result) in
            print(result as Any)
        })
    }


}
