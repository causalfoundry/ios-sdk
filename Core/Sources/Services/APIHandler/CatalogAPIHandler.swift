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
        if let catalogObject = catalogObject {
//            var prevEvent[Any] = PaperObject.readCatalog(subject) ?? []
//            prevEvent.append(catalogObject)
//            PaperObject.writeCatalog(subject, prevEvent)
        }
    }

    private func updateCatalogArray(subject: CatalogSubject, catalogArray: [Any]) {
//        var prevEvent = PaperObject.readCatalog(subject) ?? []
//        prevEvent.append(contentsOf: catalogArray)
//        PaperObject.writeCatalog(subject, prevEvent)
    }

    func callCatalogAPI(catalogMainObject: [Any], catalogSubject: String, sdkToken: String) {
        let data = try? JSONSerialization.data(withJSONObject: catalogMainObject)
        try APIManager.shared.postUpdateCatelogEvents(url:APIConstants.updateCatalog , params: catalogMainObject, "POST", headers:["subject":catalogSubject], completion:{ (result) in
            print(result)
        })
    }

}

