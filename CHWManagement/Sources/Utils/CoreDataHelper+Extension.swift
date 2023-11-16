//
//  File.swift
//  
//
//  Created by khushbu on 16/11/23.
//

import Foundation
import CasualFoundryCore
import CoreData

extension CoreDataHelper {
    public func getCHWManagementcatalogTypeData(newData:Data,oldData:Data,subject:CatalogSubject)-> Data? {
         var newUpdatedData:Data?
         do {
             let decoder = JSONDecoder()
            if subject  == .chw {
                 var catalogTableData = try decoder.decode([InternalChwModel].self, from:oldData)
                 var catalogNewData = try decoder.decode([InternalChwModel].self, from:newData)
                 catalogTableData.removeAll(where: {$0.id == catalogNewData.first?.id})
                 catalogTableData.append(catalogNewData.first!)
                 newUpdatedData = catalogTableData.toData()
             }else if subject  == .chwsite {
                 var catalogTableData = try decoder.decode([InternalSiteModel].self, from:oldData)
                 var catalogNewData = try decoder.decode([InternalSiteModel].self, from:newData)
                 catalogTableData.removeAll(where: {$0.id == catalogNewData.first?.id})
                 catalogTableData.append(catalogNewData.first!)
                 newUpdatedData = catalogTableData.toData()
             }else if subject == .patient {
                 var catalogTableData = try decoder.decode([InternalPatientModel].self, from:oldData)
                 var catalogNewData = try decoder.decode([InternalPatientModel].self, from:newData)
                 catalogTableData.removeAll(where: {$0.id == catalogNewData.first?.id})
                 catalogTableData.append(catalogNewData.first!)
                 newUpdatedData = catalogTableData.toData()
             }
         } catch {
             print("Error decoding data into Person: \(error)")
         }
         return newUpdatedData
     }
    
    public func writeCHWManagemntCatalogData(subject:CatalogSubject,data:Data) {
        let managedContext = context
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName:TableName.catalogEvents.rawValue)
        let filterPredicate = NSPredicate(format: "subject == %@", subject.rawValue)
        fetchRequest.predicate = filterPredicate
        do {
            let fetchedObjects = try managedContext.fetch(fetchRequest)
            if fetchedObjects.count > 0 {
                var oldData = fetchedObjects.first?.value(forKey: "catalog")
                var newData = self.getCHWManagementcatalogTypeData(newData:data, oldData: oldData as! Data, subject:subject)
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

