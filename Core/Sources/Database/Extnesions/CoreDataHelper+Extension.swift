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
    
    func userEventsEntity() -> NSEntityDescription {
        
        let exceptionDataEntity = NSEntityDescription()
        exceptionDataEntity.name = TableName.userEvents.rawValue // Set the entity name
        
        return exceptionDataEntity
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
    
    func userEventsEntity() {
        
        // Create a userEntity Table
        let userCatalogEntity = NSEntityDescription()
        userCatalogEntity.name = TableName.userEvents.rawValue
        
        
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
        attributedeventType.name = "eventType"
        attributedeventType.attributeType = .stringAttributeType
        
        let attributedEventProperties = NSAttributeDescription()
        attributedEventProperties.name = "eventPropeties"
        attributedEventProperties.attributeType = .stringAttributeType
    }
    
    
}
