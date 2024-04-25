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

    public static func updateUserCatalog(appUserId: String, userCatalogModelString: String) {
        if let data = userCatalogModelString.data(using: .utf8),
           let catalogItem = try? JSONDecoder.new.decode(UserCatalogModel.self, from: data)
        {
            CfCoreCatalog.updateUserCatalogData(appUserId: appUserId, userCatalogModel: catalogItem)
        }
        return
    }

    public static func updateUserCatalogData(appUserId: String, userCatalogModel: UserCatalogModel) {
        let catalogName = "\(CatalogSubject.user.rawValue) catalog"

        if appUserId.isEmpty {
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

        let userCatalogModelItem: UserCatalogModel? = MMKVHelper.shared.readUserCatalog()
        if userCatalogModel != userCatalogModelItem {
            let internalUserModel = InternalUserModel(
                id: appUserId,
                name: userCatalogModel.name,
                country: userCatalogModel.country,
                regionState: userCatalogModel.regionState,
                city: userCatalogModel.city,
                workplace: userCatalogModel.workplace,
                profession: userCatalogModel.profession,
                zipcode: userCatalogModel.zipcode,
                language: userCatalogModel.language,
                experience: userCatalogModel.experience,
                educationLevel: userCatalogModel.educationLevel,
                timezone: CoreConstants.shared.getUserTimeZone(),
                organizationId: userCatalogModel.organizationId,
                organizationName: userCatalogModel.organizationName,
                accountType: userCatalogModel.accountType,
                birthYear: userCatalogModel.birthYear,
                gender: userCatalogModel.gender,
                maritalStatus: userCatalogModel.maritalStatus,
                familyMembers: userCatalogModel.familyMembers,
                childrenUnderFive: userCatalogModel.childrenUnderFive
            )
            MMKVHelper.shared.writeUserCatalog(userCataLogData: userCatalogModel)
            CFSetup().updateCoreCatalogItem(subject: CatalogSubject.user, catalogObject: [internalUserModel].toData()!)
        } 
    }
    
    
    
    
}
