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
    func userCatalogEntity() -> NSEntityDescription{
        // Create a UserCatalog Table
        let userCatalogEntity = NSEntityDescription()
        userCatalogEntity.name = TableName.userCatalog.rawValue
        
        // Create attributes
        let attributedUserName = NSAttributeDescription()
        attributedUserName.name = "name"
        attributedUserName.attributeType = .stringAttributeType
        
        let attributedCountry = NSAttributeDescription()
        attributedCountry.name = "country"
        attributedCountry.attributeType = .stringAttributeType
        
        let attributedRegion = NSAttributeDescription()
        attributedRegion.name = "region_state"
        attributedRegion.attributeType = .stringAttributeType
        
        let attributedCity = NSAttributeDescription()
        attributedCity.name = "city"
        attributedCity.attributeType = .stringAttributeType
        
        let attributedWorkPlace = NSAttributeDescription()
        attributedWorkPlace.name = "workplace"
        attributedWorkPlace.attributeType = .stringAttributeType
        
        let attributedProfession = NSAttributeDescription()
        attributedProfession.name = "profession"
        attributedProfession.attributeType = .stringAttributeType
        
        let attributedZipCode = NSAttributeDescription()
        attributedZipCode.name = "zipcode"
        attributedZipCode.attributeType = .stringAttributeType
        
        let attributedLanguage = NSAttributeDescription()
        attributedLanguage.name = "language"
        attributedLanguage.attributeType = .stringAttributeType
        
        let attributedexperience = NSAttributeDescription()
        attributedexperience.name = "experience"
        attributedexperience.attributeType = .stringAttributeType
        
        let attributeEducation = NSAttributeDescription()
        attributeEducation.name = "education_level"
        attributeEducation.attributeType = .stringAttributeType
        
        let attributeOrganizationID = NSAttributeDescription()
        attributeOrganizationID.name = "organization_id"
        attributeOrganizationID.attributeType = .stringAttributeType
        
        let attributeOrganizationName = NSAttributeDescription()
        attributeOrganizationName.name = "organization_name"
        attributeOrganizationName.attributeType = .stringAttributeType
        
        userCatalogEntity.properties = [attributedUserName,attributedCountry,attributedRegion, attributedCity, attributedWorkPlace, attributedProfession, attributedZipCode, attributedLanguage,attributedexperience,attributeEducation, attributeOrganizationID, attributeOrganizationName ]
        return userCatalogEntity
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
    
   public func getcatalogTypeData(newData:Data,oldData:Data,subject:CatalogSubject)-> Data? {
        var newUpdatedData:Data?
        do {
            let decoder = JSONDecoder()
            switch subject {
              
            case .user:
                break
            case .media:
                var catalogTableData = try decoder.decode([MediaCatalogModel].self, from:oldData)
                var catalogNewData = try decoder.decode([MediaCatalogModel].self, from:newData)
                catalogTableData.removeAll(where: {$0.name == catalogNewData.first?.name})
                catalogTableData.append(catalogNewData.first!)
                newUpdatedData = catalogTableData.toData()
            case .chw:
                break
            case .chwsite:
                break
            case .patient:
                break
            case .drug:
                break
            case .grocery:
                break
            case .blood:
                break
            case .oxygen:
                break
            case .medical_equipment:
                break
            case .facility:
                break
            case .survey:
                break
            case .reward:
                break
            }
        
        } catch {
            print("Error decoding data into Person: \(error)")
        }
        return newUpdatedData
    }
    
}
