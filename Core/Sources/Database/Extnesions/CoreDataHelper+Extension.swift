//
//  CoreDataHelper+Extension.swift
//
//
//  Created by khushbu on 08/11/23.
//

import Foundation

extension CoreDataHelper {
    
    public func getCorecatalogTypeData(newData:Data,oldData:Data,subject:CatalogSubject)-> Data? {
        var newUpdatedData:Data?
        do {
            let decoder = JSONDecoder.new
            if subject == .user {
                var catalogTableData = try decoder.decode([InternalUserModel].self, from:oldData)
                let catalogNewData = try decoder.decode([InternalUserModel].self, from:newData)
                catalogTableData.removeAll(where: {$0.id == catalogNewData.first?.id})
                catalogTableData.append(catalogNewData.first!)
                newUpdatedData = catalogTableData.toData()
            }else if subject == .media {
                var catalogTableData = try decoder.decode([InternalMediaModel].self, from:oldData)
                let catalogNewData = try decoder.decode([InternalMediaModel].self, from:newData)
                catalogTableData.removeAll(where: {$0.media_id == catalogNewData.first?.media_id})
                catalogTableData.append(catalogNewData.first!)
                newUpdatedData = catalogTableData.toData()
            }
        } catch {
            print("Error decoding data into Person: \(error)")
        }
        return newUpdatedData
    }
}
