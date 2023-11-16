//
//  CoreDataHelper+Extension.swift
//
//
//  Created by khushbu on 08/11/23.
//

import Foundation
import CoreData



extension CoreDataHelper {
    
    func userEntity() -> NSEntityDescription {
        let userDataEntity = NSEntityDescription()
        userDataEntity.name = TableName.user.rawValue
        
        // Create attributes
        let attributeUser = NSAttributeDescription()
        attributeUser.name = "userID"
        attributeUser.attributeType = .stringAttributeType
        
        
        let attributeDeviceID = NSAttributeDescription()
        attributeDeviceID.name = "deviceID"
        attributeDeviceID.attributeType = .stringAttributeType
        
        // Add the attribute to the entity
        userDataEntity.properties = [attributeUser, attributeDeviceID]
        return userDataEntity
    }
    
    
    
    func exceptionEntity() -> NSEntityDescription {
        
        let exceptionDataEntity = NSEntityDescription()
        exceptionDataEntity.name = TableName.exceptionData.rawValue // Set the entity name
        
        
        // Create attributes
        
        let attributEventTitle = NSAttributeDescription()
        attributEventTitle.name = "title"
        attributEventTitle.attributeType = .stringAttributeType
        
        let attributEventType = NSAttributeDescription()
        attributEventType.name = "eventType"
        attributEventType.attributeType = .stringAttributeType
        
        
        let attributeExceptionType = NSAttributeDescription()
        attributeExceptionType.name = "exceptionType"
        attributeExceptionType.attributeType = .stringAttributeType
        
        let attributeExceptionSource = NSAttributeDescription()
        attributeExceptionSource.name = "exceptionSource"
        attributeExceptionSource.attributeType = .stringAttributeType
        
        let attributeDeviceTs = NSAttributeDescription()
        attributeDeviceTs.name = "ts"
        attributeDeviceTs.attributeType = .stringAttributeType
        
        let attributeStackTrace = NSAttributeDescription()
        attributeStackTrace.name = "stackTrace"
        attributeStackTrace.attributeType = .stringAttributeType
        
        // Add the attribute to the entity
        exceptionDataEntity.properties = [attributEventTitle, attributEventType,attributeExceptionType, attributeExceptionSource,attributeDeviceTs, attributeStackTrace]
        return exceptionDataEntity
        
    }
    
    
    func currencyEntity() -> NSEntityDescription {
        let currencyDataEntity = NSEntityDescription()
        currencyDataEntity.name = TableName.currency.rawValue
        
        
        // Create attributes
        let attributefromCurrency = NSAttributeDescription()
        attributefromCurrency.name = "fromCurrency"
        attributefromCurrency.attributeType = .stringAttributeType
        
        
        let attributeConversionDate = NSAttributeDescription()
        attributeConversionDate.name = "conversionDate"
        attributeConversionDate.attributeType = .stringAttributeType
        
        let attributeToCurrency = NSAttributeDescription()
        attributeToCurrency.name = "toCurrency"
        attributeToCurrency.attributeType = .stringAttributeType
        
        // Add the attribute to the entity
        currencyDataEntity.properties = [attributefromCurrency, attributeConversionDate, attributeToCurrency]
        return currencyDataEntity
        
    }
    
    func userEventsEntity() -> NSEntityDescription {
        
        // Create a userEntity Table
        let userEventsEntity = NSEntityDescription()
        userEventsEntity.name = TableName.userEvents.rawValue
        
        
        let attributedContentBlockName = NSAttributeDescription()
        attributedContentBlockName.name = "content_block"
        attributedContentBlockName.attributeType = .stringAttributeType
        
        let attributedisOnline = NSAttributeDescription()
        attributedisOnline.name = "online"
        attributedisOnline.attributeType = .booleanAttributeType
        
        let attributedTsName = NSAttributeDescription()
        attributedTsName.name = "ts"
        attributedTsName.attributeType = .stringAttributeType
        
        let attributedeventType = NSAttributeDescription()
        attributedeventType.name = "event_type"
        attributedeventType.attributeType = .stringAttributeType
        
        let attributedEventProperties = NSAttributeDescription()
        attributedEventProperties.name = "event_properties"
        attributedEventProperties.attributeType = .binaryDataAttributeType
        
        
        userEventsEntity.properties = [attributedContentBlockName,attributedisOnline,attributedTsName,attributedeventType,attributedEventProperties]
        return userEventsEntity
    }
    
    
    func catalogEntity() -> NSEntityDescription {
        let catalogEntity = NSEntityDescription()
        catalogEntity.name = TableName.catalogEvents.rawValue
        
        let attributedSubject = NSAttributeDescription()
        attributedSubject.name = "subject"
        attributedSubject.attributeType = .stringAttributeType
        
        let attributedCatalog = NSAttributeDescription()
        attributedCatalog.name = "catalog"
        attributedCatalog.attributeType = .binaryDataAttributeType
        
        catalogEntity.properties = [attributedSubject,attributedCatalog ]
        return catalogEntity
    }
    
   public func getCorecatalogTypeData(newData:Data,oldData:Data,subject:CatalogSubject)-> Data? {
        var newUpdatedData:Data?
        do {
            let decoder = JSONDecoder()
            if subject == .user {
                
            }else if subject == .media {
                var catalogTableData = try decoder.decode([MediaCatalogModel].self, from:oldData)
                let catalogNewData = try decoder.decode([MediaCatalogModel].self, from:newData)
                catalogTableData.removeAll(where: {$0.name == catalogNewData.first?.name})
                catalogTableData.append(catalogNewData.first!)
                newUpdatedData = catalogTableData.toData()
            }
        } catch {
            print("Error decoding data into Person: \(error)")
        }
        return newUpdatedData
    }
}
