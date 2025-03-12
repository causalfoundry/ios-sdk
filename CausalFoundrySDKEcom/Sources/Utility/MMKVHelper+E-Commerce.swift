//
//  MMKVHelper+E-Commerce.swift
//
//
//  Created by khushbu on 29/10/23.
//

import CausalFoundrySDKCore
import Foundation

public extension MMKVHelper {
    func getEcommerceCatalogTypeData(newData: Data, oldData: Data, subject: CatalogSubject) -> Data? {
        var newUpdatedData: Data?
        do {
            let decoder = JSONDecoder.new
            if subject == .drug {
                var catalogTableData = try decoder.decode([DrugCatalogModel].self, from: oldData)
                let catalogNewData = try decoder.decode([DrugCatalogModel].self, from: newData)
                catalogTableData.removeAll(where: { $0.drugId == catalogNewData.first?.drugId })
                catalogTableData.append(catalogNewData.first!)
                newUpdatedData = catalogTableData.toData()
            } else if subject == .grocery {
                var catalogTableData = try decoder.decode([GroceryCatalogModel].self, from: oldData)
                let catalogNewData = try decoder.decode([GroceryCatalogModel].self, from: newData)
                catalogTableData.removeAll(where: { $0.groceryId == catalogNewData.first?.groceryId })
                catalogTableData.append(catalogNewData.first!)
                newUpdatedData = catalogTableData.toData()
            } else if subject == .blood {
                var catalogTableData = try decoder.decode([BloodCatalogModel].self, from: oldData)
                let catalogNewData = try decoder.decode([BloodCatalogModel].self, from: newData)
                catalogTableData.removeAll(where: { $0.itemId == catalogNewData.first?.itemId })
                catalogTableData.append(catalogNewData.first!)
                newUpdatedData = catalogTableData.toData()
            } else if subject == .oxygen {
                var catalogTableData = try decoder.decode([OxygenCatalogModel].self, from: oldData)
                let catalogNewData = try decoder.decode([OxygenCatalogModel].self, from: newData)
                catalogTableData.removeAll(where: { $0.itemId == catalogNewData.first?.itemId })
                catalogTableData.append(catalogNewData.first!)
                newUpdatedData = catalogTableData.toData()
            } else if subject == .medical_equipment {
                var catalogTableData = try decoder.decode([MedicalEquipmentCatalogModel].self, from: oldData)
                let catalogNewData = try decoder.decode([MedicalEquipmentCatalogModel].self, from: newData)
                catalogTableData.removeAll(where: { $0.itemId == catalogNewData.first?.itemId })
                catalogTableData.append(catalogNewData.first!)
                newUpdatedData = catalogTableData.toData()
            } else if subject == .facility {
                var catalogTableData = try decoder.decode([FacilityCatalogModel].self, from: oldData)
                let catalogNewData = try decoder.decode([FacilityCatalogModel].self, from: newData)
                catalogTableData.removeAll(where: { $0.facilityId == catalogNewData.first?.facilityId })
                catalogTableData.append(catalogNewData.first!)
                newUpdatedData = catalogTableData.toData()
            }
        } catch {
            print("Error decoding data into Ecom: \(error)")
        }
        return newUpdatedData
    }

    func writeEcommerceCatalogData(subject: CatalogSubject, data: Data) {
        let oldData = readCatalogData(subject: subject) ?? Data()
        let newData = getEcommerceCatalogTypeData(newData: data, oldData: oldData, subject: subject)
        writeCatalogData(subject: subject, data: newData ?? data)
    }
}
