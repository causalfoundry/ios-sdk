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
        if #available(iOS 13.0, *) {
            guard !CoreConstants.shared.pauseSDK else { return }
            MMKVHelper.shared.writeCatalogData(subject: subject, data: catalogObject)
        }
    }

    public func callCatalogAPI(catalogMainObject: [Any], catalogSubject: String, completion: @escaping (_ success: Bool) -> Void) {
        if #available(iOS 13.0, *) {
            let url = URL(string: "\(APIConstants.updateCatalog)\(catalogSubject)")!
            let arrayWithoutDuplicates = Array(NSOrderedSet(array: catalogMainObject)) as! [Any]
            
            print("USER Catalog \(arrayWithoutDuplicates)")
            
            BackgroundRequestController.shared.request(url: url, httpMethod: .post, params: arrayWithoutDuplicates) { result in
                switch result {
                case .success:
                    completion(true)
                case .failure:
                    completion(false)
                }
            }
        }
    }
}
