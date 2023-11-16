//
//  File.swift
//
//
//  Created by khushbu on 29/10/23.
//

import Foundation
import CasualFoundryCore
import CoreData

extension CoreDataHelper {
    public func getEcommerceCatalogTypeData(newData:Data,oldData:Data,subject:CatalogSubject)-> Data? {
        var newUpdatedData:Data?
        do {
            let decoder = JSONDecoder()
            if subject == .drug {
                var catalogTableData = try decoder.decode([InternalDrugModel].self, from:oldData)
                var catalogNewData = try decoder.decode([InternalDrugModel].self, from:newData)
                catalogTableData.removeAll(where: {$0.id == catalogNewData.first?.id})
                catalogTableData.append(catalogNewData.first!)
                newUpdatedData = catalogTableData.toData()
            }else if subject == .grocery {
                var catalogTableData = try decoder.decode([InternalGroceryCatalogModel].self, from:oldData)
                var catalogNewData = try decoder.decode([InternalGroceryCatalogModel].self, from:newData)
                catalogTableData.removeAll(where: {$0.id == catalogNewData.first?.id})
                catalogTableData.append(catalogNewData.first!)
                newUpdatedData = catalogTableData.toData()
            }else if subject == .blood {
                var catalogTableData = try decoder.decode([InternalBloodCatalogModel].self, from:oldData)
                var catalogNewData = try decoder.decode([InternalBloodCatalogModel].self, from:newData)
                catalogTableData.removeAll(where: {$0.id == catalogNewData.first?.id})
                catalogTableData.append(catalogNewData.first!)
                newUpdatedData = catalogTableData.toData()
            }else if subject == .oxygen {
                
                var catalogTableData = try decoder.decode([InternalOxygenCatalogModel].self, from:oldData)
                var catalogNewData = try decoder.decode([InternalOxygenCatalogModel].self, from:newData)
                catalogTableData.removeAll(where: {$0.id == catalogNewData.first?.id})
                catalogTableData.append(catalogNewData.first!)
                newUpdatedData = catalogTableData.toData()
            }else if subject == .medical_equipment {
                var catalogTableData = try decoder.decode([InternalMedicalEquipmentCatalogModel].self, from:oldData)
                var catalogNewData = try decoder.decode([InternalMedicalEquipmentCatalogModel].self, from:newData)
                catalogTableData.removeAll(where: {$0.name == catalogNewData.first?.name})
                catalogTableData.append(catalogNewData.first!)
                newUpdatedData = catalogTableData.toData()
            }else if subject == .facility {
                var catalogTableData = try decoder.decode([InternalFacilityCatalogModel].self, from:oldData)
                var catalogNewData = try decoder.decode([InternalFacilityCatalogModel].self, from:newData)
                catalogTableData.removeAll(where: {$0.name == catalogNewData.first?.name})
                catalogTableData.append(catalogNewData.first!)
                newUpdatedData = catalogTableData.toData()
            }
        } catch {
            print("Error decoding data into Person: \(error)")
        }
        return newUpdatedData
    }
    
    public func writeEcommerceCatalogData(subject:CatalogSubject,data:Data) {
        let managedContext = context
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName:TableName.catalogEvents.rawValue)
        let filterPredicate = NSPredicate(format: "subject == %@", subject.rawValue)
        fetchRequest.predicate = filterPredicate
        do {
            let fetchedObjects = try managedContext.fetch(fetchRequest)
            if fetchedObjects.count > 0 {
                var oldData = fetchedObjects.first?.value(forKey: "catalog")
                var newData = self.getEcommerceCatalogTypeData(newData:data, oldData: oldData as! Data, subject:subject)
                var managedObejct = fetchedObjects[0]
                managedObejct.setValue(subject.rawValue, forKey:"subject")
                managedObejct.setValue(newData, forKey:"catalog")
            }else {
                let entity = NSEntityDescription.entity(forEntityName: TableName.catalogEvents.rawValue, in: managedContext)!
                let managedObject = NSManagedObject(entity: entity, insertInto: managedContext)
                managedObject.setValue(subject.rawValue, forKey: "subject")
                managedObject.setValue(data, forKey:"catalog")
            }
            try managedContext.save()
            
            
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
            
        }
    }
}
