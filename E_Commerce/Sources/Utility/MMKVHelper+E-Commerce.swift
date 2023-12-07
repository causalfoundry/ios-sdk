//
//  MMKVHelper+E-Commerce.swift
//
//
//  Created by khushbu on 29/10/23.
//

#if canImport(CasualFoundryCore)
import CasualFoundryCore
#endif
import Foundation

public extension MMKVHelper {
    func getEcommerceCatalogTypeData(newData: Data, oldData: Data, subject: CatalogSubject) -> Data? {
        var newUpdatedData: Data?
        do {
            let decoder = JSONDecoder.new
            if subject == .drug {
                var catalogTableData = try decoder.decode([InternalDrugModel].self, from: oldData)
                var catalogNewData = try decoder.decode([InternalDrugModel].self, from: newData)
                catalogTableData.removeAll(where: { $0.id == catalogNewData.first?.id })
                catalogTableData.append(catalogNewData.first!)
                newUpdatedData = catalogTableData.toData()
            } else if subject == .grocery {
                var catalogTableData = try decoder.decode([InternalGroceryCatalogModel].self, from: oldData)
                var catalogNewData = try decoder.decode([InternalGroceryCatalogModel].self, from: newData)
                catalogTableData.removeAll(where: { $0.id == catalogNewData.first?.id })
                catalogTableData.append(catalogNewData.first!)
                newUpdatedData = catalogTableData.toData()
            } else if subject == .blood {
                var catalogTableData = try decoder.decode([InternalBloodCatalogModel].self, from: oldData)
                var catalogNewData = try decoder.decode([InternalBloodCatalogModel].self, from: newData)
                catalogTableData.removeAll(where: { $0.id == catalogNewData.first?.id })
                catalogTableData.append(catalogNewData.first!)
                newUpdatedData = catalogTableData.toData()
            } else if subject == .oxygen {
                var catalogTableData = try decoder.decode([InternalOxygenCatalogModel].self, from: oldData)
                var catalogNewData = try decoder.decode([InternalOxygenCatalogModel].self, from: newData)
                catalogTableData.removeAll(where: { $0.id == catalogNewData.first?.id })
                catalogTableData.append(catalogNewData.first!)
                newUpdatedData = catalogTableData.toData()
            } else if subject == .medical_equipment {
                var catalogTableData = try decoder.decode([InternalMedicalEquipmentCatalogModel].self, from: oldData)
                var catalogNewData = try decoder.decode([InternalMedicalEquipmentCatalogModel].self, from: newData)
                catalogTableData.removeAll(where: { $0.id == catalogNewData.first?.id })
                catalogTableData.append(catalogNewData.first!)
                newUpdatedData = catalogTableData.toData()
            } else if subject == .facility {
                var catalogTableData = try decoder.decode([InternalFacilityCatalogModel].self, from: oldData)
                var catalogNewData = try decoder.decode([InternalFacilityCatalogModel].self, from: newData)
                catalogTableData.removeAll(where: { $0.id == catalogNewData.first?.id })
                catalogTableData.append(catalogNewData.first!)
                newUpdatedData = catalogTableData.toData()
            }
        } catch {
            print("Error decoding data into Person: \(error)")
        }
        return newUpdatedData
    }

    func writeEcommerceCatalogData(subject: CatalogSubject, data: Data) {
        let oldData = readCatalogData(subject: subject) ?? Data()
        let newData = getEcommerceCatalogTypeData(newData: data, oldData: oldData, subject: subject)
        writeCatalogData(subject: subject, data: newData ?? data)
    }
}
