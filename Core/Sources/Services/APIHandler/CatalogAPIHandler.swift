//
//  CatalogAPIHandler.swift
//
//
//  Created by khushbu on 12/09/23.
//

import Foundation
import UIKit

public class CatalogAPIHandler {
    public func updateCoreCatalogItem(subject: CatalogSubject, catalogObject: Data) {
        MMKVHelper.shared.writeCatalogData(subject: subject, data: catalogObject)
    }

    public func callCatalogAPI(catalogMainObject: [Any], catalogSubject: String, completion: @escaping (_ success: Bool) -> Void) {
        let url = URL(string: "\(CoreConstants.shared.devUrl)ingest/catalog/\(catalogSubject)")!
        BackgroundRequestController.shared.request(url: url, httpMethod: .post, params: catalogMainObject) { result in
            switch result {
            case .success:
                completion(true)
            case .failure:
                completion(false)
            }
        }
    }
}
