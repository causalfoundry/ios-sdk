//
//  MMKVHelper+CHW.swift
//
//
//  Created by khushbu on 16/11/23.
//

import CausalFoundrySDKCore
import Foundation

public extension MMKVHelper {
    func getCHWManagementcatalogTypeData(newData: Data, oldData: Data, subject: CatalogSubject) -> Data? {
        var newUpdatedData: Data?
        do {
            let decoder = JSONDecoder.new
            if subject == .user_chw {
                var catalogTableData = try decoder.decode([InternalHcwModel].self, from: oldData)
                let catalogNewData = try decoder.decode([InternalHcwModel].self, from: newData)
                catalogTableData.removeAll(where: { $0.id == catalogNewData.first?.id })
                catalogTableData.append(catalogNewData.first!)
                newUpdatedData = catalogTableData.toData()
            } else if subject == .chwsite {
                var catalogTableData = try decoder.decode([InternalHcwSiteCatalogModel].self, from: oldData)
                let catalogNewData = try decoder.decode([InternalHcwSiteCatalogModel].self, from: newData)
                catalogTableData.removeAll(where: { $0.id == catalogNewData.first?.id })
                catalogTableData.append(catalogNewData.first!)
                newUpdatedData = catalogTableData.toData()
            } else if subject == .patient {
                var catalogTableData = try decoder.decode([InternalPatientModel].self, from: oldData)
                let catalogNewData = try decoder.decode([InternalPatientModel].self, from: newData)
                catalogTableData.removeAll(where: { $0.id == catalogNewData.first?.id })
                catalogTableData.append(catalogNewData.first!)
                newUpdatedData = catalogTableData.toData()
            }
        } catch {
            print("Error decoding data into CHW: \(error)")
        }
        return newUpdatedData
    }

    func writeCHWManagemntCatalogData(subject: CatalogSubject, data: Data) {
        let oldData = readCatalogData(subject: subject) ?? Data()
        let newData = getCHWManagementcatalogTypeData(newData: data, oldData: oldData, subject: subject)
        writeCatalogData(subject: subject, data: newData ?? data)
    }
}
