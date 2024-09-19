//
//  CfCoreCatalog.swift
//
//
//  Created by khushbu on 25/10/23.
//

import Foundation

public class CfCoreCatalog {
    //////////////////////////////////////////////////////
    // User Catalog
    //////////////////////////////////////////////////////

    public static func updateUserCatalog(userCatalogModelString: String) {
        if let data = userCatalogModelString.data(using: .utf8),
           let catalogItem = try? JSONDecoder.new.decode(UserCatalogModel.self, from: data)
        {
            CfCoreCatalog.updateUserCatalogData(userCatalogModel: catalogItem)
        }
        return
    }

    public static func updateUserCatalogData(userCatalogModel: UserCatalogModel) {
        let catalogName = "\(CatalogSubject.user.rawValue) catalog"

        if userCatalogModel.userId.isEmpty == true {
            ExceptionManager.throwIsRequiredException(eventType: catalogName, elementName: "User Id")
        } else if userCatalogModel.country?.isEmpty == false, !CoreConstants.shared.enumContains(CountryCode.self, name: userCatalogModel.country) {
            ExceptionManager.throwEnumException(eventType: catalogName, className: String(describing: CountryCode.self))
        } else if userCatalogModel.language?.isEmpty == false, !CoreConstants.shared.enumContains(LanguageCode.self, name: userCatalogModel.language) {
            ExceptionManager.throwEnumException(eventType: catalogName, className: String(describing: LanguageCode.self))
        } else if userCatalogModel.educationLevel?.isEmpty == false, !CoreConstants.shared.enumContains(EducationalLevel.self, name: userCatalogModel.educationLevel) {
            ExceptionManager.throwEnumException(eventType: catalogName, className: String(describing: EducationalLevel.self))
        } else if ((userCatalogModel.birthYear != nil) && (userCatalogModel.birthYear != 0) && (userCatalogModel.birthYear! < 1900 || userCatalogModel.birthYear! > Calendar.current.component(.year, from: Date()))){
            ExceptionManager.throwInvalidException(eventType: catalogName, paramName: "birthYear", className: String(describing: CfCoreCatalog.self))
        } else if userCatalogModel.gender?.isEmpty == false, !CoreConstants.shared.enumContains(UserGender.self, name: userCatalogModel.gender) {
            ExceptionManager.throwEnumException(eventType: catalogName, className: String(describing: UserGender.self))
        } else if userCatalogModel.maritalStatus?.isEmpty == false, !CoreConstants.shared.enumContains(MaritalStatus.self, name: userCatalogModel.maritalStatus) {
            ExceptionManager.throwEnumException(eventType: catalogName, className: String(describing: MaritalStatus.self))
        } else if userCatalogModel.familyMembers?.isEmpty == false, !CoreConstants.shared.enumContains(MembersCount.self, name: userCatalogModel.familyMembers) {
            ExceptionManager.throwEnumException(eventType: catalogName, className: String(describing: MembersCount.self))
        } else if userCatalogModel.childrenUnderFive?.isEmpty == false, !CoreConstants.shared.enumContains(MembersCount.self, name: userCatalogModel.childrenUnderFive) {
            ExceptionManager.throwEnumException(eventType: catalogName, className: String(describing: MembersCount.self))
        }

        CFSetup().updateCoreCatalogItem(subject: CatalogSubject.user, catalogObject: [userCatalogModel.toInternalUserCatalogModel()].toData()!)
    }
    
    
    
    
    public static func updateMediaCatalog(mediaCatalogModelString: String) {
        if let data = mediaCatalogModelString.data(using: .utf8),
           let catalogItem = try? JSONDecoder.new.decode(MediaCatalogModel.self, from: data)
        {
            CfCoreCatalog.updateMediaCatalogData(mediaCatalogModel: catalogItem)
        }
        return
    }

    public static func updateMediaCatalogData(mediaCatalogModel: MediaCatalogModel) {
        let catalogName = "\(CatalogSubject.media.rawValue) catalog"

        if mediaCatalogModel.mediaId?.isEmpty == true {
            ExceptionManager.throwIsRequiredException(eventType: catalogName, elementName: "Media Id")
        } else if mediaCatalogModel.length == nil || mediaCatalogModel.length! < 0 {
            ExceptionManager.throwIsRequiredException(eventType: catalogName, elementName: "media_total_duration")
        } else if mediaCatalogModel.language?.isEmpty == false, !CoreConstants.shared.enumContains(LanguageCode.self, name: mediaCatalogModel.language) {
            ExceptionManager.throwEnumException(eventType: catalogName, className: String(describing: LanguageCode.self))
        }
        
        CFSetup().updateCoreCatalogItem(subject: CatalogSubject.media, catalogObject: [mediaCatalogModel].toData()!)
    }
    
    
    
    
}
