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
            switch subject {
            case .blood:
                break
            case .user:
                var prevUserCatalog = CoreDataHelper.shared.readUserCatalog()
                if let item = catalogObject as? UserCatalogModel {
                    prevUserCatalog.append(item)
                    CoreDataHelper.shared.writeUserCatalog(catalogArray:prevUserCatalog )
                }
            case .media:
                break
            case .chw:
                break
            case .chwsite:
                break
            case .patient:
                break
            case .drug:
                break
            case .grocery:
                break
            case .oxygen:
                break
            case .medical_equipment:
                break
            case .facility:
                break
            case .survey:
                break
            case .reward:
                break
            }
        }
    }

    private func updateCatalogArray(subject: CatalogSubject, catalogArray: [Any]) {
      switch subject {
            case .blood:
                break
            case .user:
                var prevUserCatalog = CoreDataHelper.shared.readUserCatalog()
                if let items = catalogArray as? [UserCatalogModel] {
                    for item in items {
                        prevUserCatalog.append(item)
                    }
                    CoreDataHelper.shared.writeUserCatalog(catalogArray:prevUserCatalog )
                }
            case .media:
                break
            case .chw:
                break
            case .chwsite:
                break
            case .patient:
                break
            case .drug:
                break
            case .grocery:
                break
            case .oxygen:
                break
            case .medical_equipment:
                break
            case .facility:
                break
            case .survey:
                break
            case .reward:
                break
            }
    }

    func callCatalogAPI(catalogMainObject: [Any], catalogSubject: String, sdkToken: String) {
        let data = try? JSONSerialization.data(withJSONObject: catalogMainObject)
        try APIManager.shared.postUpdateCatelogEvents(url:APIConstants.updateCatalog , params: catalogMainObject, "POST", headers:["subject":catalogSubject], completion:{ (result) in
            print(result)
        })
    }

}

