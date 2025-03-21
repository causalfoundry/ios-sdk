//
//  MMKVHelper+Loyalty.swift
//
//
//  Created by khushbu on 16/11/23.
//

import CausalFoundrySDKCore
import Foundation

public extension MMKVHelper {
    func getLoyaltyCatalogTypeData(newData: Data, oldData: Data, subject: CatalogSubject) -> Data? {
        var newUpdatedData: Data?
        do {
            let decoder = JSONDecoder.new
            if subject == .survey {
                var catalogTableData = try decoder.decode([SurveyCatalogModel].self, from: oldData)
                let catalogNewData = try decoder.decode([SurveyCatalogModel].self, from: newData)
                catalogTableData.removeAll(where: { $0.id == catalogNewData.first?.id })
                catalogTableData.append(catalogNewData.first!)
                newUpdatedData = catalogTableData.toData()
            } else if subject == .reward {
                var catalogTableData = try decoder.decode([RewardCatalogModel].self, from: oldData)
                let catalogNewData = try decoder.decode([RewardCatalogModel].self, from: newData)
                catalogTableData.removeAll(where: { $0.id == catalogNewData.first?.id })
                catalogTableData.append(catalogNewData.first!)
                newUpdatedData = catalogTableData.toData()
            }
        } catch {
            print("Error decoding data into Loyalty: \(error)")
        }
        return newUpdatedData
    }

    func writeLoyaltyCatalogData(subject: CatalogSubject, data: Data) {
        let oldData = readCatalogData(subject: subject) ?? Data()
        let newData = getLoyaltyCatalogTypeData(newData: data, oldData: oldData, subject: subject)
        writeCatalogData(subject: subject, data: newData ?? data)
    }
}
