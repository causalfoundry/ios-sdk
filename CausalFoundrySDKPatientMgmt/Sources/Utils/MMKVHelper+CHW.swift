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
                var catalogTableData = try decoder.decode([HcwCatalogModel].self, from: oldData)
                let catalogNewData = try decoder.decode([HcwCatalogModel].self, from: newData)
                catalogTableData.removeAll(where: { $0.hcwId == catalogNewData.first?.hcwId })
                catalogTableData.append(catalogNewData.first!)
                newUpdatedData = catalogTableData.toData()
            } else if subject == .chwsite {
                var catalogTableData = try decoder.decode([HcwSiteCatalogModel].self, from: oldData)
                let catalogNewData = try decoder.decode([HcwSiteCatalogModel].self, from: newData)
                catalogTableData.removeAll(where: { $0.siteId == catalogNewData.first?.siteId })
                catalogTableData.append(catalogNewData.first!)
                newUpdatedData = catalogTableData.toData()
            } else if subject == .patient {
                var catalogTableData = try decoder.decode([PatientCatalogModel].self, from: oldData)
                let catalogNewData = try decoder.decode([PatientCatalogModel].self, from: newData)
                catalogTableData.removeAll(where: { $0.patientId == catalogNewData.first?.patientId })
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
